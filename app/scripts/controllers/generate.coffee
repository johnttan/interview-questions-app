angular.module('interviewappApp')
.controller 'GenerateCtrl', ['$scope', 'Questions', 'QuestionsKeys', ($scope, Questions, QuestionsKeys) ->
    if Questions.questionsobject is undefined
      Questions.getquestions()

    $scope.generate = {role: null}
    $scope.generated = {role: 'Role'}

    $scope.filterquestion = (questions, filterby, value, random, limit)->
      filtered = questions.filter(
        (q)->
          return q[filterby] is value
      )
      if random
        pickeduid = []
        picked = []
        z = 0
        while z < limit
          i = filtered[Math.floor(Math.random() * filtered.length)]
          if i.uid not in pickeduid
            pickeduid.push(i.uid)
            picked.push(i)
            z++
      return picked
    $scope.generatebutton = ->
      $scope.limitcopy = angular.copy($scope.limit)
      if $scope.generate.role isnt null
         $scope.generated = angular.copy($scope.generate)
         $scope.generatedqs['Role'] = $scope.filterquestion($scope.questions, 'role', $scope.generated.role, true, $scope.limitcopy)
      for category in $scope.questionskeys['category']
        $scope.generatedqs[category] = $scope.filterquestion($scope.questions, 'category', category, true, $scope.limitcopy)
    ]