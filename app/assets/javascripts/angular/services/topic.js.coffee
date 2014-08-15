@app.factory "Topic", ["$resource", ($resource) ->
    $resource( "/topics/:id.json",
      {id: @id}
      {
       index: { method: 'get', isArray: true }
      }
    )
]