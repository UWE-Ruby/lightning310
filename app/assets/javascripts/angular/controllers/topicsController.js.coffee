@app.controller "TopicsController", ["$scope", "$resource", "Topic", ($scope, $resource, Topic) ->

  init = ->
    $scope.topics = Topic.index()
    alert "hi"

  $scope.topics = []
  init()
]