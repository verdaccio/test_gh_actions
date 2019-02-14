workflow "New workflow" {
  resolves = ["GitHub Action for npm"]
  on = "push"
}

action "GitHub Action for npm" {
  uses = "actions/npm@4633da3702a5366129dca9d8cc3191476fc3433c"
  args = "ci"
}
