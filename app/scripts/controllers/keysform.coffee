angular.module('interviewappApp')
.controller 'KeysFormCtrl', ['$scope', ($scope) ->
  $scope.addkey = (option)->
    $scope.value.push(option)




]