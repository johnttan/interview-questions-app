angular.module('interviewappApp')
.controller 'RecentQuestionsCtrl', ['$scope', 'RecentQuestions', 'Portfolio', ($scope, RecentQuestions, Portfolio) ->
#      $scope.$watch('recentquestions', ->
#        $scope.recentquestionskeys = Object.keys($scope.recentquestions).sort().reverse()
#      )
    $scope.recentquestionskeys = Object.keys(RecentQuestions.recentquestions).sort().reverse()
    console.log($scope.recentquestionskeys)
    $scope.recentquestions = RecentQuestions
    $scope.switchcandidate = (candidate)->
      Portfolio.injectcandidate(candidate)
    RecentQuestions.getrecent()
    RecentQuestions.recentquestions.$promise.then((result)->
      $scope.recentquestionsarray = (result[x] for x in Object.keys(result) when x not in ['$resolved', '$promise'])
      console.log(RecentQuestions.recentquestions)
    )
    $scope.deletecandidate = (candidate)->
      RecentQuestions.clearrecentq(candidate)
      $scope.recentquestionsarray = (RecentQuestions.recentquestions[x] for x in Object.keys(RecentQuestions.recentquestions) when x not in ['$resolved', '$promise'])
    ]