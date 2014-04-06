'use strict'

angular.module('interviewappApp')
.controller 'SearchCtrl',['$scope', 'Questions', ($scope, Questions) ->
    if Questions.questionsobject is undefined
      Questions.getquestions()
    $scope.questions = Questions.questionsobject
    $scope.filterlimit = 50
]