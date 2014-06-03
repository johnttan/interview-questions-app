angular.module('interviewappApp')
.controller 'UpdateKeysCtrl', ['$scope', 'EditQuestions', 'QuestionsKeys', ($scope, QuestionsKeys) ->
    $scope.questionskeys = QuestionsKeys


]