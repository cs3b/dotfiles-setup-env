#!/usr/bin/env bash
set -euo pipefail

out_path="${1:-contracts/index.yaml}"

ruby - "$out_path" <<'RUBY'
require "yaml"

out_path = ARGV.fetch(0)
root = Dir.pwd

FRONTMATTER_RE = /\A---\s*\n(.*?)\n---\s*\n/m

def load_frontmatter(path)
  text = File.read(path)
  match = FRONTMATTER_RE.match(text)
  raise "missing frontmatter: #{path}" unless match
  data = YAML.safe_load(match[1], permitted_classes: [], aliases: false)
  data.is_a?(Hash) ? data : {}
end

caps = Dir.glob("capabilities/*.md").sort.map do |path|
  data = load_frontmatter(path)
  {
    "id" => data["capability_id"],
    "path" => path,
    "status" => data["status"],
    "rule_ids" => Array(data["rules"]).map { |r| r["rule_id"] }.compact.sort,
  }
end

profiles = Dir.glob("profiles/*.md").sort.map do |path|
  data = load_frontmatter(path)
  {
    "id" => data["profile_id"],
    "path" => path,
    "included_capabilities" => Array(data["included_capabilities"]).sort,
  }
end

oses = Dir.glob("os/*.md").sort.map do |path|
  data = load_frontmatter(path)
  {
    "id" => data["os_id"],
    "path" => path,
    "rule_ids" => Array(data["rules"]).map { |r| r["rule_id"] }.compact.sort,
  }
end

rule_entries = []
(caps + oses).each do |entry|
  owner_id = entry["id"]
  owner_type = entry.key?("status") ? "capability" : "os"
  entry["rule_ids"].each do |rule_id|
    rule_entries << {
      "id" => rule_id,
      "source_type" => owner_type,
      "source_id" => owner_id,
    }
  end
end
rule_entries.sort_by! { |r| r["id"] }

scenarios_data = load_frontmatter("validation/scenarios.md")
checklist_data = load_frontmatter("validation/checklist.md")
waivers_data = YAML.safe_load(File.read("validation/waivers.yaml"), permitted_classes: [], aliases: false) || {}

index = {
  "snapshot" => "v0",
  "capabilities" => caps.sort_by { |c| c["id"].to_s },
  "profiles" => profiles.sort_by { |p| p["id"].to_s },
  "os" => oses.sort_by { |o| o["id"].to_s },
  "validation" => {
    "scenarios" => {
      "path" => "validation/scenarios.md",
      "scenario_ids" => Array(scenarios_data["scenarios"]).map { |s| s["scenario_id"] }.compact.sort,
    },
    "checklist" => {
      "path" => "validation/checklist.md",
      "core_blockers" => Array(checklist_data["core_blockers"]).sort,
      "core_warns" => Array(checklist_data["core_warns"]).sort,
      "optional_profiles" => checklist_data.fetch("optional_by_profile", {}).keys.sort,
    },
    "waivers" => {
      "path" => "validation/waivers.yaml",
      "waiver_ids" => Array(waivers_data["waivers"]).map { |w| w["waiver_id"] }.compact.sort,
    },
  },
  "rules" => rule_entries,
}

payload = YAML.dump(index)
if out_path == "-"
  print payload
else
  File.write(out_path, payload)
end
RUBY
