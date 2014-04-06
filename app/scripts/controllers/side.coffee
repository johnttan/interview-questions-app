'use strict'

angular.module('interviewappApp')
.controller 'SideCtrl', ['$scope', '$location', ($scope, $location) ->
    $scope.isActive = (route) ->
      console.log $location.path()
      route is $location.path()
    ]