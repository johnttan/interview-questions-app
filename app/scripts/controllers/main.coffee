'use strict'

angular.module('interviewappApp')
  .controller 'MainCtrl', ['$scope', 'Questions', 'QuestionsKeys', ($scope, Questions, QuestionsKeys) ->
      if Questions.questionsobject is undefined
        Questions.getquestions()
        QuestionsKeys.getquestionskeys()
      $scope.questions = Questions.questionsobject
      $scope.questionskeys = QuestionsKeys.questionskeysobject
      $scope.generatedqs = {}
  ]