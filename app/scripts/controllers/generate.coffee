angular.module('interviewappApp')
.controller 'GenerateCtrl', ['$scope', 'Questions', 'Portfolio', ($scope, Questions, Portfolio) ->
    if Questions.questionsobject is undefined
      Questions.getquestions()
    $scope.limit = Portfolio.limit
    $scope.limitcopy = $scope.limit
    $scope.generate = {role: null}
    $scope.generated = {role: 'Role'}
    $scope.generatedqs = Portfolio.generatedqs
    $scope.Portfolio = Portfolio
    $scope.filterquestion = (questions, filterby, value, random, limit)->
      filtered = questions.filter(
        (q)->
          return q[filterby] is value
      )
      if random
        pickeduid = []
        picked = []
        z = 0
        value = 'role' if filterby == 'role'
        if filtered is []
          return []
        while z < limit[value]
          randomindex = Math.floor(Math.random() * filtered.length)
          i = filtered[randomindex]
          if i isnt undefined
            if i.uid not in pickeduid
                pickeduid.push(i.uid)
                picked.push(i)
          z++
      console.log(picked)
      return picked
    $scope.generatebutton = ->
      $scope.limitcopy = angular.copy($scope.limit)
      if $scope.generate.role isnt null
         $scope.generated = angular.copy($scope.generate)
         $scope.generatedqs['Role'] = $scope.filterquestion(Questions.questionsobject, 'role', $scope.generated.role, true, $scope.limitcopy)
      for category in $scope.questionskeys.questionskeysobject.category
        console.log(category)
        $scope.generatedqs[category] = $scope.filterquestion(Questions.questionsobject, 'category', category, true, $scope.limitcopy)
      Portfolio.generatedqs = $scope.generatedqs
      Portfolio.limit = $scope.limitcopy
      Portfolio.role = $scope.generated.role
    $scope.savegenerated = ->
      Portfolio.savecandidate()
    $scope.newcandidate = ->
      Portfolio.newcandidate()
      $scope.limit = Portfolio.limit
      $scope.limitcopy = $scope.limit
      $scope.generate = {role: null}
      $scope.generated = {role: 'Role'}
      $scope.generatedqs = Portfolio.generatedqs
    ]
