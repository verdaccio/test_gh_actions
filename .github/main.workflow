workflow "New workflow" {
  resolves = [
    "Publish Verdaccio",
    "Test",
  ]
  on = "push"
}

action "CI" {
  uses = "actions/npm@4633da3702a5366129dca9d8cc3191476fc3433c"
  args = "ci"
}

action "Test" {
  uses = "actions/npm@4633da3702a5366129dca9d8cc3191476fc3433c"
  args = "test"
}

action "Tag" {
  uses = "actions/bin/filter@46ffca7632504e61db2d4cb16be1e80f333cb859"
  needs = [
    "CI",
    "Test",
  ]
  args = "branch master"
}

action "Publish" {
  uses = "actions/npm@59b64a598378f31e49cb76f27d6f3312b582f680"
  args = "publish --access public -ddd"
  secrets = ["NPM_AUTH_TOKEN"]
  env = {
    NPM_REGISTRY_URL = "registry.verdaccio.org"
  }
  needs = ["Tag"]
}

action "Publish Verdaccio" {
  uses = "verdaccio/github-actions/publish@master"
  needs = ["Tag"]
}
