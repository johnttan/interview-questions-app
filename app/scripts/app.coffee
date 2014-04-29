'use strict'

angular.module('interviewappApp', [
  'ngCookies',
  'ngResource',
  'ngSanitize',
  'ngRoute',
  'QuickList',
  'LocalStorageModule'
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
      .when '/recent/:recentname/:time',
        controller: 'RecentViewCtrl'
        templateUrl: 'recentview'
      .otherwise
        redirectTo: '/'

    $locationProvider.html5Mode true