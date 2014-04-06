'use strict'

angular.module('interviewappApp')
  .controller 'MainCtrl', ['$scope', 'Questions', ($scope, Questions) ->
      if Questions.questionsobject is undefined
        Questions.getquestions()
      $scope.questions = Questions.questionsobject
      $scope.generatedqs = {}
  ]