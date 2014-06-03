'use strict'

angular.module('interviewappApp')
.controller 'UpdateCtrl', ['$scope', 'EditQuestions', 'Questions', 'QuestionsKeys', ($scope, EditQuestions, Questions, QuestionsKeys) ->
    if Questions.questionsobject is undefined
       Questions.getquestions()
       QuestionsKeys.getquestionskeys()
#    By referencing the Questions object, $watch will recognize any changes to this objects properties
#    i.e. Questions.questionsobject which is an array that contains the questions objects
#    This allows us to update the view whenever a question is added, removed, or updated
    $scope.questions = Questions
    $scope.filterlimit = 50
    $scope.questionskeys = QuestionsKeys
    $scope.Qtobeupdated = {}
    $scope.search = {}
    $scope.updateQuestion = (type_of_edit)->
      UpdateQuestions.editquestions(type_of_edit, $scope.Qtobeupdate)
      Questions.getquestions()
    $scope.addChange = (question)->
      $scope.Qtobeupdated = question
      console.log($scope.Qtobeupdated)
    $scope.addquestionskeys = ->
      addquestionskeys = angular.copy($scope.questionskeys.questionskeysobject)
      delete addquestionskeys['_id']
      delete addquestionskeys['uid']
      addquestionskeys
    $scope.removeQuestion = (question)->
      EditQuestions.editquestion('remove', question)
      Questions.getquestions()

    $scope.qtobeadded = {}
    $scope.refresh = ->
      Questions.getquestions()
    $scope.addQuestion = ->
      console.log($scope.qtobeadded)
      EditQuestions.addquestion($scope.qtobeadded)
      $scope.showAdd = !$scope.showAdd
      $scope.qtobeadded = {}
      Questions.getquestions()
    $scope.placeholder = (key, value)->
      if key == 'role' or key == 'category' or key =='subcategory'
        return value
      else
        return key

    ]