angular.module('interviewappApp')
.controller 'GenerateCtrl', ['$scope', 'Questions', ($scope, Questions) ->
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

      if $scope.generate.role isnt null
         $scope.generated = angular.copy($scope.generate)
         $scope.generatedqs['role'] = $scope.filterquestion($scope.questions, 'role', $scope.generated.role, true, $scope.limit)

      $scope.generatedqs['opening'] = $scope.filterquestion($scope.questions, 'category', 'Opening', true, $scope.limit)
      $scope.generatedqs['situational'] = $scope.filterquestion($scope.questions, 'category', 'Situational', true, $scope.limit)
      $scope.generatedqs['behavior'] = $scope.filterquestion($scope.questions, 'category', 'Behavior', true, $scope.limit)
      $scope.generatedqs['closing'] = $scope.filterquestion($scope.questions, 'category', 'Closing', true, $scope.limit)

    ]