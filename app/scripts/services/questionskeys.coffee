angular.module("interviewappApp")
.service "QuestionsKeys", ['$resource', '$http',
    class QuestionsKeysResource
      constructor: (@$resource, @$http)->
      resourceservice: ->
        @$resource "/getkeys",
          get:
            method: "GET"
            isArray: false
      getquestionskeys: ->
        @questionskeysobject = @resourceservice().get()
      updatekeys: (keys)->
        @$http.post('/insertkeys', keys)
        @questionskeysobject = @resourceservice().get()

  ]