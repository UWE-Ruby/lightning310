@app = angular.module('lightning310', ["ngRoute", "ngResource"])

@app.config [
  "$httpProvider"
  (provider) ->
    return provider.defaults.headers.common["X-CSRF-Token"] = $("meta[name=csrf-token]").attr("content")
]