workflow "New workflow" {
  resolves = [
    "GitHub Action for npm",
    "GitHub Action for npm-1",
  ]
  on = "push"
}

action "GitHub Action for npm" {
  uses = "actions/npm@4633da3702a5366129dca9d8cc3191476fc3433c"
  args = "ci"
}

action "GitHub Action for npm-1" {
  uses = "actions/npm@4633da3702a5366129dca9d8cc3191476fc3433c"
  args = "test"
}
