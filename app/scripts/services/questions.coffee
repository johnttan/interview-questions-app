angular.module("interviewappApp")
.service "Questions", ['$resource', '$q'
    class QuestionsResource
      constructor: (@$resource, @$q)->
      resourceservice: ->
        @$resource "/getquestions",
          query:
            method: "GET"
      getquestions: ->
        @questionsobject = @resourceservice().query()
        @deferred =  @$q.defer()
        @transformedqs = @deferred.promise
        @questionsobject.$promise.then(
            do(deferred = @deferred)->
              (value)->
                transformedjson = {}
                for question in value
                  transformedjson[question['uid']] = question
                deferred.resolve(transformedjson)
        )
    ]