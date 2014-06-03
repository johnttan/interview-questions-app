angular.module('interviewappApp')
.controller 'UpdateKeysCtrl', ['$scope', 'QuestionsKeys', ($scope, QuestionsKeys) ->
    $scope.questionskeys = QuestionsKeys
    QuestionsKeys.getquestionskeys()
    $scope.questionskeysformatted = ->
      formatted = {}
      formatted.category = $scope.questionskeys.questionskeysobject.category
      formatted.subcategory = $scope.questionskeys.questionskeysobject.subcategory
      formatted.role = $scope.questionskeys.questionskeysobject.role
      console.log(formatted, 'formatted')
      return formatted
    $scope.newkeys = {}
    $scope.changechecked = (key, option, picked)->
      if key not of $scope.newkeys
        $scope.newkeys[key] = {}
        $scope.newkeys[key][option] = picked
      else
          $scope.newkeys[key][option] = picked
      console.log($scope.newkeys)

    $scope.updatedatabase = ->
      newkeys = {}
      for own key of $scope.newkeys
        newkeys[key] = []
      console.log($scope.newkeys, "newkeys scope")
      for own key of $scope.newkeys
        for own option, value of $scope.newkeys[key]
          console.log(key, option, value)
          if value
              newkeys[key].push(option)
      console.log(newkeys, 'newkeys database')
      QuestionsKeys.updatekeys(newkeys)

    $scope.refresh = ->
      QuestionsKeys.getquestionskeys()
]