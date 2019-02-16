workflow "TestActions" {
  resolves = [
    "Docker Lint",
    "Publish",
  ]
  on = "push"
}

action "Docker Lint" {
  uses = "docker://replicated/dockerfilelint"
  args = ["Dockerfile"]
}

action "CI" {
  uses = "actions/npm@4633da3702a5366129dca9d8cc3191476fc3433c"
  args = "ci"
  needs = ["Test"]
}

action "Test" {
  uses = "actions/npm@4633da3702a5366129dca9d8cc3191476fc3433c"
  args = "test"
  needs = ["Docker Lint"]
}

action "Tag" {
  uses = "actions/bin/filter@46ffca7632504e61db2d4cb16be1e80f333cb859"
  needs = [
    "CI",
    "Test",
  ]
  args = "branch master"
}

action "Publish Verdaccio" {
  uses = "verdaccio/github-actions/publish@master"
  needs = ["Tag"]
  args = "publish"
}

action "Publish" {
  uses = "actions/npm@59b64a598378f31e49cb76f27d6f3312b582f680"
  needs = ["Publish Verdaccio"]
  env = {
    NPM_REGISTRY_URL = "registry.verdaccio.org"
    NPM_STRICT_SSL = "true"
  }
}
