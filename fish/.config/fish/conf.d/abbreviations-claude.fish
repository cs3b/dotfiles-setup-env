# Claude CLI abbreviations — core
abbr -a -- cc 'claude --dangerously-skip-permissions'
abbr -a -- ccp 'claude --dangerously-skip-permissions -p'
abbr -a -- ccc 'claude --dangerously-skip-permissions --continue'
abbr -a -- ccr 'claude --dangerously-skip-permissions --resume'
abbr -a -- cct 'claude --dangerously-skip-permissions setup-token'

# Claude CLI abbreviations — extended task shortcuts
abbr -a -- cc-on 'claude --dangerously-skip-permissions "/onboard"'
abbr -a -- cc-lcp 'claude --dangerously-skip-permissions "/onboard \n /ace:prompt"'
abbr -a -- cc-wt 'claude --dangerously-skip-permissions "/ace:work-on-task"'
abbr -a -- cc-rt 'claude --dangerously-skip-permissions "/ace:review-task"'
abbr -a -- cc-pt 'claude --dangerously-skip-permissions "/ace:plan-task"'
abbr -a -- cc-ft 'claude --dangerously-skip-permissions "/ace:fix-tests"'
