#!/usr/bin/env bash
set -euo pipefail

ruby <<'RUBY'
require "yaml"
require "date"
require "set"

FRONTMATTER_RE = /\A---\s*\n(.*?)\n---\s*\n/m

SCHEMA_FILES = {
  "capability" => "schemas/capability.schema.yaml",
  "profile" => "schemas/profile.schema.yaml",
  "os" => "schemas/os.schema.yaml",
  "scenarios" => "schemas/scenario.schema.yaml",
  "checklist" => "schemas/checklist.schema.yaml",
  "waivers" => "schemas/waiver.schema.yaml",
  "runner-output" => "schemas/runner-output.schema.yaml",
}.freeze

errors = []

def read_yaml(path)
  YAML.safe_load(File.read(path), permitted_classes: [], aliases: false)
end

def read_frontmatter(path)
  text = File.read(path)
  match = FRONTMATTER_RE.match(text)
  raise "missing frontmatter" unless match
  data = YAML.safe_load(match[1], permitted_classes: [], aliases: false)
  data.is_a?(Hash) ? data : {}
end

def validate_top_level(path, data, schema, errors)
  required = Array(schema["required"])
  allowed = Array(schema["allowed"])

  required.each do |key|
    errors << "#{path}: missing required key '#{key}'" unless data.key?(key)
  end

  unknown = data.keys - allowed
  unknown.each do |key|
    errors << "#{path}: unknown key '#{key}'"
  end

  kind_values = schema.dig("enums", "kind")
  if kind_values && data["kind"] && !kind_values.include?(data["kind"])
    errors << "#{path}: invalid kind '#{data["kind"]}'"
  end
end

def ensure_array(path, value, field, errors)
  errors << "#{path}: #{field} must be an array" unless value.is_a?(Array)
end

def ensure_hash(path, value, field, errors)
  errors << "#{path}: #{field} must be a map" unless value.is_a?(Hash)
end

schemas = {}
SCHEMA_FILES.each do |name, path|
  unless File.exist?(path)
    errors << "missing schema file: #{path}"
    next
  end
  schemas[name] = read_yaml(path)
end

capability_docs = Dir.glob("capabilities/*.md").sort
profile_docs = Dir.glob("profiles/*.md").sort
os_docs = Dir.glob("os/*.md").sort

if capability_docs.empty?
  errors << "capabilities/: no capability contracts found"
end
if profile_docs.empty?
  errors << "profiles/: no profile contracts found"
end
if os_docs.empty?
  errors << "os/: no os contracts found"
end

capabilities = {}
profiles = {}
oses = {}
rules = {}
status_optional_profiles = []

capability_docs.each do |path|
  begin
    data = read_frontmatter(path)
  rescue => e
    errors << "#{path}: #{e.message}"
    next
  end

  validate_top_level(path, data, schemas.fetch("capability"), errors)

  cap_id = data["capability_id"]
  unless cap_id.is_a?(String) && cap_id.match?(/^CAP-[a-z0-9-]+$/)
    errors << "#{path}: invalid capability_id '#{cap_id}'"
  end

  if cap_id && capabilities.key?(cap_id)
    errors << "duplicate capability_id '#{cap_id}' in #{path} and #{capabilities[cap_id]}"
  else
    capabilities[cap_id] = path if cap_id
  end

  status = data["status"]
  unless status.is_a?(String) && (status == "required" || status.start_with?("optional:"))
    errors << "#{path}: invalid status '#{status}'"
  end
  if status&.start_with?("optional:")
    status_profile = status.split("optional:", 2).last
    status_optional_profiles << [path, status_profile]
  end

  ensure_array(path, data["intentions"], "intentions", errors)
  ensure_array(path, data["rules"], "rules", errors)
  ensure_array(path, data["os_package_mapping"], "os_package_mapping", errors)
  ensure_array(path, data["known_exceptions"], "known_exceptions", errors)

  Array(data["rules"]).each_with_index do |rule, idx|
    unless rule.is_a?(Hash)
      errors << "#{path}: rules[#{idx}] must be a map"
      next
    end

    %w[rule_id assertion method pass_condition severity].each do |k|
      errors << "#{path}: rules[#{idx}] missing '#{k}'" unless rule.key?(k)
    end

    rule_id = rule["rule_id"]
    unless rule_id.is_a?(String) && rule_id.match?(/^VAL-[a-z0-9-]+-\d{2}$/)
      errors << "#{path}: invalid rule_id '#{rule_id}'"
    end

    if rule_id && rules.key?(rule_id)
      errors << "duplicate rule_id '#{rule_id}' in #{path} and #{rules[rule_id]["path"]}"
    else
      rules[rule_id] = { "path" => path, "severity" => rule["severity"] } if rule_id
    end

    allowed_severity = schemas.dig("capability", "enums", "rule_severity") || []
    unless allowed_severity.include?(rule["severity"])
      errors << "#{path}: rule '#{rule_id}' has invalid severity '#{rule["severity"]}'"
    end
  end

  Array(data["os_package_mapping"]).each_with_index do |mapping, idx|
    unless mapping.is_a?(Hash)
      errors << "#{path}: os_package_mapping[#{idx}] must be a map"
      next
    end
    %w[canonical_capability macos_package_id arch_package_id notes].each do |k|
      errors << "#{path}: os_package_mapping[#{idx}] missing '#{k}'" unless mapping.key?(k)
    end
  end

  allowed_impacts = schemas.dig("capability", "enums", "exception_compliance_impact") || []
  Array(data["known_exceptions"]).each_with_index do |ex, idx|
    unless ex.is_a?(Hash)
      errors << "#{path}: known_exceptions[#{idx}] must be a map"
      next
    end
    %w[id statement compliance_impact].each do |k|
      errors << "#{path}: known_exceptions[#{idx}] missing '#{k}'" unless ex.key?(k)
    end
    if ex["compliance_impact"] && !allowed_impacts.include?(ex["compliance_impact"])
      errors << "#{path}: known_exceptions[#{idx}] invalid compliance_impact '#{ex["compliance_impact"]}'"
    end
  end
end

profile_docs.each do |path|
  begin
    data = read_frontmatter(path)
  rescue => e
    errors << "#{path}: #{e.message}"
    next
  end

  validate_top_level(path, data, schemas.fetch("profile"), errors)

  profile_id = data["profile_id"]
  unless profile_id.is_a?(String) && profile_id.match?(/^PROFILE-[a-z0-9-]+$/)
    errors << "#{path}: invalid profile_id '#{profile_id}'"
  end

  if profile_id && profiles.key?(profile_id)
    errors << "duplicate profile_id '#{profile_id}' in #{path} and #{profiles[profile_id]["path"]}"
  else
    profiles[profile_id] = { "path" => path, "included_capabilities" => data["included_capabilities"] }
  end

  ensure_array(path, data["included_capabilities"], "included_capabilities", errors)
  ensure_hash(path, data["validation_policy"], "validation_policy", errors)
end

os_docs.each do |path|
  begin
    data = read_frontmatter(path)
  rescue => e
    errors << "#{path}: #{e.message}"
    next
  end

  validate_top_level(path, data, schemas.fetch("os"), errors)

  os_id = data["os_id"]
  unless os_id.is_a?(String) && os_id.match?(/^OS-[a-z0-9-]+$/)
    errors << "#{path}: invalid os_id '#{os_id}'"
  end

  if os_id && oses.key?(os_id)
    errors << "duplicate os_id '#{os_id}' in #{path} and #{oses[os_id]["path"]}"
  else
    oses[os_id] = { "path" => path }
  end

  ensure_array(path, data["rules"], "rules", errors)
  ensure_array(path, data["known_exceptions"], "known_exceptions", errors)

  Array(data["rules"]).each_with_index do |rule, idx|
    unless rule.is_a?(Hash)
      errors << "#{path}: rules[#{idx}] must be a map"
      next
    end

    %w[rule_id assertion method pass_condition severity].each do |k|
      errors << "#{path}: rules[#{idx}] missing '#{k}'" unless rule.key?(k)
    end

    rule_id = rule["rule_id"]
    unless rule_id.is_a?(String) && rule_id.match?(/^VAL-[a-z0-9-]+-\d{2}$/)
      errors << "#{path}: invalid rule_id '#{rule_id}'"
    end

    if rule_id && rules.key?(rule_id)
      errors << "duplicate rule_id '#{rule_id}' in #{path} and #{rules[rule_id]["path"]}"
    else
      rules[rule_id] = { "path" => path, "severity" => rule["severity"] } if rule_id
    end

    allowed_severity = schemas.dig("os", "enums", "rule_severity") || []
    unless allowed_severity.include?(rule["severity"])
      errors << "#{path}: rule '#{rule_id}' has invalid severity '#{rule["severity"]}'"
    end
  end
end

scenarios_path = "validation/scenarios.md"
checklist_path = "validation/checklist.md"
waivers_path = "validation/waivers.yaml"
runner_contract_path = "contracts/runner-contract.yaml"
runner_output_schema_path = "schemas/runner-output.schema.yaml"

unless File.exist?(scenarios_path)
  errors << "missing required file: #{scenarios_path}"
end
unless File.exist?(checklist_path)
  errors << "missing required file: #{checklist_path}"
end
unless File.exist?(waivers_path)
  errors << "missing required file: #{waivers_path}"
end
unless File.exist?(runner_contract_path)
  errors << "missing required file: #{runner_contract_path}"
end
unless File.exist?(runner_output_schema_path)
  errors << "missing required file: #{runner_output_schema_path}"
end

scenario_data = {}
if File.exist?(scenarios_path)
  begin
    scenario_data = read_frontmatter(scenarios_path)
    validate_top_level(scenarios_path, scenario_data, schemas.fetch("scenarios"), errors)
    ensure_array(scenarios_path, scenario_data["scenarios"], "scenarios", errors)
  rescue => e
    errors << "#{scenarios_path}: #{e.message}"
  end
end

Array(scenario_data["scenarios"]).each_with_index do |scenario, idx|
  unless scenario.is_a?(Hash)
    errors << "#{scenarios_path}: scenarios[#{idx}] must be a map"
    next
  end
  %w[scenario_id profiles platform expected].each do |k|
    errors << "#{scenarios_path}: scenarios[#{idx}] missing '#{k}'" unless scenario.key?(k)
  end
  sid = scenario["scenario_id"]
  unless sid.is_a?(String) && sid.match?(/^SCN-[a-z0-9-]+$/)
    errors << "#{scenarios_path}: invalid scenario_id '#{sid}'"
  end
  unless scenario["profiles"].is_a?(Array) && !scenario["profiles"].empty?
    errors << "#{scenarios_path}: scenario '#{sid}' must have non-empty profiles"
  end
end

checklist_data = {}
if File.exist?(checklist_path)
  begin
    checklist_data = read_frontmatter(checklist_path)
    validate_top_level(checklist_path, checklist_data, schemas.fetch("checklist"), errors)
    ensure_array(checklist_path, checklist_data["core_blockers"], "core_blockers", errors)
    ensure_array(checklist_path, checklist_data["core_warns"], "core_warns", errors)
    ensure_hash(checklist_path, checklist_data["optional_by_profile"], "optional_by_profile", errors)
  rescue => e
    errors << "#{checklist_path}: #{e.message}"
  end
end

waiver_data = {}
if File.exist?(waivers_path)
  begin
    waiver_data = read_yaml(waivers_path) || {}
    validate_top_level(waivers_path, waiver_data, schemas.fetch("waivers"), errors)
    ensure_array(waivers_path, waiver_data["waivers"], "waivers", errors)
  rescue => e
    errors << "#{waivers_path}: #{e.message}"
  end
end

# Referential integrity checks
profiles.each do |profile_id, profile_data|
  Array(profile_data["included_capabilities"]).each do |cap_id|
    errors << "#{profile_data["path"]}: unknown capability '#{cap_id}'" unless capabilities.key?(cap_id)
  end
end

status_optional_profiles.each do |path, profile_id|
  errors << "#{path}: optional status references unknown profile '#{profile_id}'" unless profiles.key?(profile_id)
end

Array(scenario_data["scenarios"]).each do |scenario|
  next unless scenario.is_a?(Hash)
  sid = scenario["scenario_id"]

  Array(scenario["profiles"]).each do |profile_id|
    errors << "#{scenarios_path}: scenario '#{sid}' references unknown profile '#{profile_id}'" unless profiles.key?(profile_id)
  end

  platform = scenario["platform"]
  unless platform == "any" || oses.key?(platform)
    errors << "#{scenarios_path}: scenario '#{sid}' references unknown platform '#{platform}'"
  end
end

all_rule_ids = Set.new(rules.keys)
categorized_rule_ids = []

Array(checklist_data["core_blockers"]).each { |id| categorized_rule_ids << ["core_blockers", id] }
Array(checklist_data["core_warns"]).each { |id| categorized_rule_ids << ["core_warns", id] }

optional_profiles = checklist_data.fetch("optional_by_profile", {})
optional_profiles.each do |profile_id, groups|
  unless profiles.key?(profile_id)
    errors << "#{checklist_path}: optional_by_profile references unknown profile '#{profile_id}'"
  end
  unless groups.is_a?(Hash)
    errors << "#{checklist_path}: optional_by_profile '#{profile_id}' must be a map"
    next
  end
  ensure_array(checklist_path, groups["blockers"], "optional_by_profile.#{profile_id}.blockers", errors)
  ensure_array(checklist_path, groups["warns"], "optional_by_profile.#{profile_id}.warns", errors)

  Array(groups["blockers"]).each { |id| categorized_rule_ids << ["optional:#{profile_id}:blockers", id] }
  Array(groups["warns"]).each { |id| categorized_rule_ids << ["optional:#{profile_id}:warns", id] }
end

rule_occurrences = Hash.new { |h, k| h[k] = [] }
categorized_rule_ids.each do |source, rule_id|
  rule_occurrences[rule_id] << source
  errors << "#{checklist_path}: unknown rule '#{rule_id}' in #{source}" unless all_rule_ids.include?(rule_id)
end

all_rule_ids.each do |rule_id|
  unless rule_occurrences.key?(rule_id)
    errors << "#{checklist_path}: rule '#{rule_id}' is not categorized"
  end
end

rule_occurrences.each do |rule_id, sources|
  if sources.size > 1
    errors << "#{checklist_path}: rule '#{rule_id}' appears in multiple categories: #{sources.join(', ')}"
  end
end

waiver_ids = Set.new
allowed_waiver_status = schemas.dig("waivers", "enums", "status") || []
Array(waiver_data["waivers"]).each_with_index do |waiver, idx|
  unless waiver.is_a?(Hash)
    errors << "#{waivers_path}: waivers[#{idx}] must be a map"
    next
  end

  %w[waiver_id rule_id scope rationale owner expires_on status].each do |k|
    errors << "#{waivers_path}: waivers[#{idx}] missing '#{k}'" unless waiver.key?(k)
  end

  waiver_id = waiver["waiver_id"]
  if waiver_id && waiver_ids.include?(waiver_id)
    errors << "#{waivers_path}: duplicate waiver_id '#{waiver_id}'"
  else
    waiver_ids << waiver_id if waiver_id
  end

  rule_id = waiver["rule_id"]
  unless all_rule_ids.include?(rule_id)
    errors << "#{waivers_path}: waiver '#{waiver_id}' references unknown rule '#{rule_id}'"
  end

  scope = waiver["scope"].to_s
  if scope == "repo"
    # valid
  elsif scope.start_with?("profile:")
    pid = scope.split("profile:", 2).last
    errors << "#{waivers_path}: waiver '#{waiver_id}' references unknown profile scope '#{pid}'" unless profiles.key?(pid)
  elsif scope.start_with?("os:")
    oid = scope.split("os:", 2).last
    errors << "#{waivers_path}: waiver '#{waiver_id}' references unknown os scope '#{oid}'" unless oses.key?(oid)
  else
    errors << "#{waivers_path}: waiver '#{waiver_id}' has invalid scope '#{scope}'"
  end

  status = waiver["status"]
  unless allowed_waiver_status.include?(status)
    errors << "#{waivers_path}: waiver '#{waiver_id}' has invalid status '#{status}'"
  end

  begin
    expiry = Date.iso8601(waiver["expires_on"].to_s)
    if status == "active" && expiry < Date.today
      errors << "#{waivers_path}: waiver '#{waiver_id}' is active but expired on #{expiry}"
    end
  rescue ArgumentError
    errors << "#{waivers_path}: waiver '#{waiver_id}' has invalid expires_on '#{waiver["expires_on"]}'"
  end
end

if errors.any?
  warn "contract validation failed:" 
  errors.each { |e| warn "- #{e}" }
  exit 1
else
  puts "contract validation passed"
end
RUBY

# Generated index must match tracked index.
if [[ ! -f contracts/index.yaml ]]; then
  echo "contract validation failed: missing contracts/index.yaml"
  exit 1
fi

tmp_file="$(mktemp)"
trap 'rm -f "$tmp_file"' EXIT

tools/build-index.sh "$tmp_file"
if ! diff -u "$tmp_file" contracts/index.yaml; then
  echo "contract validation failed: contracts/index.yaml is out of date"
  exit 1
fi

echo "index validation passed"
