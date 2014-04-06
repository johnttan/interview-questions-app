'use strict'

angular.module('interviewappApp', [
  'ngCookies',
  'ngResource',
  'ngSanitize',
  'ngRoute',
  'QuickList'
])
  .config ($routeProvider, $locationProvider) ->
    $routeProvider
      .when '/',
        controller: 'MainCtrl'
        templateUrl: 'home'
      .when '/search',
        controller: 'SearchCtrl'
        templateUrl: 'search'
      .when '/browse',
        controller: 'BrowseCtrl'
      .when '/update',
        controller: 'UpdateCtrl'
      .otherwise
        redirectTo: '/'

    $locationProvider.html5Mode true