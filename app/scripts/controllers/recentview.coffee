angular.module('interviewappApp')
.controller 'RecentViewCtrl', ['$scope', '$routeParams', ($scope, $routeParams) ->

      $scope.candidatename = $routeParams.recentname
      $scope.apptime = $routeParams.time
      $scope.appquestions = $scope.recentquestions[$scope.apptime + '__' + $scope.candidatename]
      $scope.tempqs = {}
      $scope.$watch('transformedjson', ()->
        for own key, value of $scope.appquestions.questions
          $scope.tempqs[key] = ($scope.transformedjson[uid] for uid in value)

      )
    ]