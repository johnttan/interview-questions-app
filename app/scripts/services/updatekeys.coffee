angular.module("interviewappApp")
.service "UpdateKeys", ['$http'
    class UpdateKeys
      constructor: (@$http)->
      editquestion: (keys)->
        @$http.post('/editquestion', keys)
  ]