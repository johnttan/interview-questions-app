'use strict'

angular.module('interviewappApp')
.controller 'GlobalCtrl', ['$scope', 'RecentQuestions', 'Questions', 'QuestionsKeys', ($scope,  RecentQuestions, Questions, QuestionsKeys) ->
    $scope.printview = false
    $scope.showallanswers = false
    $scope.toggleprintview = ->
      $scope.printview = !$scope.printview
      $scope.showallanswers = !$scope.showallanswers
    RecentQuestions.getrecent()
    $scope.recentquestions = RecentQuestions.recentquestions
    $scope.$on('recentquestions', ->
      $scope.recentquestions = RecentQuestions.recentquestions
    )
    $scope.addrecentquestions = (name, tobeadded)->
      questionids = {}
      for own key, value of tobeadded
        questionids[key] = (question['_id'] for question in tobeadded[key])
      RecentQuestions.addrecent(name, questionids)
    $scope.clearrecent = ->
      RecentQuestions.clearreccent()

    if Questions.questionsobject is undefined
      Questions.getquestions()
      QuestionsKeys.getquestionskeys()
    $scope.questions = Questions.questionsobject
    $scope.questionskeys = QuestionsKeys.questionskeysobject
    $scope.generatedqs = {}
    $scope.transformedjson = {}
    Questions.transformedqs.then(
      (value)->
        $scope.transformedjson = value
    )
    console.log($scope.transformedjson)
  ]