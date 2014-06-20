'use strict'

angular.module('interviewappApp')
.controller 'CurrentCandidateCtrl',['$scope', 'Questions', 'QuestionsKeys', 'Portfolio', ($scope, Questions, QuestionsKeys, Portfolio) ->
    if Questions.questionsobject is undefined
      Questions.getquestions()
    if QuestionsKeys.questionskeysobject is undefined
      QuestionsKeys.getquestionskeys()

    $scope.search = {}
    $scope.questions = Questions
    $scope.filterlimit = 50
    $scope.questionskeys = QuestionsKeys
    $scope.Portfolio = Portfolio
    $scope.deletequestion = (qid, category)->
      $scope.Portfolio.deletequestion(qid, category)
    $scope.savecandidate = ->
      $scope.Portfolio.savecandidate()
  ]