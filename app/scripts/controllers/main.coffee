'use strict'

angular.module('interviewappApp')
  .controller 'MainCtrl', ['$scope', 'Questions', 'QuestionsKeys', 'RecentQuestions', ($scope, Questions, QuestionsKeys, RecentQuestions) ->
#      if Questions.questionsobject is undefined
#        Questions.getquestions()
#        QuestionsKeys.getquestionskeys()
#      $scope.questions = Questions.questionsobject
#      $scope.questionskeys = QuestionsKeys.questionskeysobject
#      $scope.generatedqs = {}
#      $scope.transformedjson = {}
#      $scope.questions.$promise.then(
#        for question in $scope.questions
#          $scope.transformedjson[question._id] = question
#      )
  ]