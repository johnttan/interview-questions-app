'use strict'

angular.module('interviewappApp')
.controller 'SearchCtrl',['$scope', 'Questions', 'QuestionsKeys', ($scope, Questions, QuestionsKeys) ->
    if Questions.questionsobject is undefined
      Questions.getquestions()
      QuestionsKeys.getquestionskeys()

    $scope.questions = Questions.questionsobject
    $scope.filterlimit = 50
    $scope.questionskeys = QuestionsKeys.questionskeysobject
  ]