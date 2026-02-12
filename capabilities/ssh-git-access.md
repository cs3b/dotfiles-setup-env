---
kind: capability
capability_id: CAP-ssh-git-access
status: required
intentions:
  - Git operations to GitHub work over SSH using port 443 compatibility routing.
  - SSH config supports github.com host mapping to ssh.github.com on port 443.
  - Key-agent integration is enabled where platform supports it.
  - GitHub CLI is installed for authenticated GitHub operations.
rules:
  - rule_id: VAL-ssh-git-access-01
    assertion: SSH config contains GitHub-over-443 host mapping.
    method: Inspect SSH config host stanza.
    pass_condition: Host github.com, Hostname ssh.github.com, and Port 443 are defined.
    severity: blocker
  - rule_id: VAL-ssh-git-access-02
    assertion: SSH key path for Git operations is configured.
    method: Inspect IdentityFile in GitHub host stanza.
    pass_condition: Identity path is declared.
    severity: warn
  - rule_id: VAL-ssh-git-access-03
    assertion: SSH handshake to GitHub endpoint succeeds.
    method: Run ssh -T git@github.com.
    pass_condition: Returns authenticated or denied-with-recognized-account message, not network failure.
    severity: warn
  - rule_id: VAL-ssh-git-access-04
    assertion: GitHub CLI is available.
    method: Run gh --version.
    pass_condition: Command succeeds and reports a version.
    severity: blocker
os_package_mapping:
  - canonical_capability: openssh-client
    macos_package_id: system-default
    arch_package_id: openssh
    notes: Usually preinstalled on macOS.
  - canonical_capability: git-transport
    macos_package_id: git
    arch_package_id: git
    notes: Required.
  - canonical_capability: github-cli
    macos_package_id: gh
    arch_package_id: github-cli
    notes: Required.
known_exceptions:
  - id: EXC-ssh-git-access-01
    statement: Enterprise SSH policies may require alternate host alias; equivalent 443 transport must still validate.
    compliance_impact: warn
---
# SSH Git Access Capability

This capability defines SSH transport expectations and GitHub CLI availability.
