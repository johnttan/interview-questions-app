'use strict'

angular.module('interviewappApp')
  .controller 'NavbarCtrl', ['$scope', '$location', ($scope, $location) ->
    $scope.menu = [
      title: 'Home'
      link: '/'
    ]
    
    $scope.isActive = (route) ->
      route is $location.path()
    ]