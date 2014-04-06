angular.module("interviewappApp")
.service "Questions", ['$resource',
    class QuestionsResource
      constructor: (@$resource)->
      resourceservice: ->
        @$resource "/getquestions",
          query:
            method: "GET"
      getquestions: ->
        @questionsobject = @resourceservice().query()
    ]