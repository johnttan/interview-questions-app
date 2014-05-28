angular.module("interviewappApp")
.service "QuestionsKeys", ['$resource',
    class QuestionsKeysResource
      constructor: (@$resource)->
      resourceservice: ->
        @$resource "/getkeys",
          get:
            method: "GET"
            isArray: false
      getquestionskeys: ->
        @questionskeysobject = @resourceservice().get()

  ]