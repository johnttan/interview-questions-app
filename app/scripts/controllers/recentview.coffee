angular.module('interviewappApp')
.controller 'RecentViewCtrl', ['$scope', '$routeParams', 'RecentQuestions', 'Questions', ($scope, $routeParams, RecentQuestions, Questions) ->

      $scope.candidatename = $routeParams.recentname
      $scope.apptime = $routeParams.time
      $scope.appquestions = JSON.parse($scope.recentquestions)[$scope.apptime + '__' + $scope.candidatename]

      if $scope.appquestions isnt undefined
        if $scope.transformedqs isnt undefined
          for own key, value of $scope.appquestions.questions
            console.log(key, value)
            $scope.tempqs[key] = ($scope.transformedjson[uid] for uid in value)
          console.log($scope.tempqs, 'tempqs', transformedjson)
        else
          Questions.transformedqs.then((transformedjson)->
            for own key, value of $scope.appquestions.questions
              console.log(key, value)
              $scope.tempqs[key] = (transformedjson[uid] for uid in value)
            console.log($scope.tempqs, 'tempqs', transformedjson)

          )
      else
        RecentQuestions.recentquestions.$promise.then((result)->
          $scope.appquestions = JSON.parse(result[$scope.apptime + '__' + $scope.candidatename])
          console.log('recentview')
          console.log($scope.appquestions)
          $scope.tempqs = {}
          if $scope.transformedqs isnt undefined
            for own key, value of $scope.appquestions.questions
              console.log(key, value)
              $scope.tempqs[key] = ($scope.transformedjson[uid] for uid in value)
            console.log($scope.tempqs, 'tempqs', transformedjson)
          else
            Questions.transformedqs.then((transformedjson)->
              for own key, value of $scope.appquestions.questions
                console.log(key, value)
                $scope.tempqs[key] = (transformedjson[uid] for uid in value)
              console.log($scope.tempqs, 'tempqs', transformedjson)

            )
        )

    ]