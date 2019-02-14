workflow "New workflow" {
  resolves = [
    "GitHub Action for npm-1",
    "Publish",
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

action "Filters for GitHub Actions" {
  uses = "actions/bin/filter@46ffca7632504e61db2d4cb16be1e80f333cb859"
  needs = ["GitHub Action for npm", "GitHub Action for npm-1"]
  args = "tag"
}

action "Publish" {
  uses = "actions/npm@59b64a598378f31e49cb76f27d6f3312b582f680"
  needs = ["Filters for GitHub Actions"]
  args = "publish"
  secrets = ["NPM_AUTH_TOKEN"]
  env = {
    NPM_REGISTRY_URL = "https://registry.verdaccio.org"
  }
}
