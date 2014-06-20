'use strict'

angular.module('interviewappApp')
.controller 'SideCtrl', ['$scope', '$location', 'Portfolio', ($scope, $location, Portfolio) ->
    $scope.isActive = (route) ->
      console.log $location.path()
      route is $location.path()
    $scope.Portfolio = Portfolio
    ]