angular.module('interviewappApp')
.controller 'RecentQuestionsCtrl', ['$scope', 'RecentQuestions', ($scope, RecentQuestions) ->
#      $scope.$watch('recentquestions', ->
#        $scope.recentquestionskeys = Object.keys($scope.recentquestions).sort().reverse()
#      )
    $scope.recentquestionskeys = Object.keys(RecentQuestions.recentquestions).sort().reverse()
    $scope.$on("recentquestions", ->
      $scope.recentquestionskeys = Object.keys(RecentQuestions.recentquestions).sort().reverse()
    )

    ]