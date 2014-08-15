@app.controller "TopicsController", ["$scope", "$resource", "Topic", ($scope, $resource, Topic) ->

  init = ->
    $scope.topics = Topic.index()
    alert "hi"

  $scope.topics = []
  init()

  $scope.submitTopic = ->
    alert $scope.topic
    Topic.create(topic: $scope.topic)
]