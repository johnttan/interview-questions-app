angular.module('interviewappApp')
.controller 'GenerateCtrl', ['$scope', 'Questions', ($scope, Questions) ->
    if Questions.questionsobject is undefined
      Questions.getquestions()
    $scope.limit = {}
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
        value = 'role' if filterby == 'role'
        while z < limit[value]
          i = filtered[Math.floor(Math.random() * filtered.length)]
          if i.uid not in pickeduid
            pickeduid.push(i.uuid)
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
    $scope.savegenerated = ->
        if $scope.candidatename isnt undefined
          tobeadded = {}
          for own category, questionarray of $scope.generatedqs
            tobeadded[category] = questionarray
          console.log(tobeadded)
          $scope.addrecentquestions($scope.candidatename, tobeadded)
          console.log('savegenerated')
          console.log($scope.recentquestions)
    ]
