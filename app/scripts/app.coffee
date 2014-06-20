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
        templateUrl: 'update'
      .when '/updatekeys',
        controller: 'UpdateKeysCtrl'
        templateUrl: 'updatekeys'
      .when '/recent',
        controller: 'RecentQuestionsCtrl'
        templateUrl: 'recentquestions'
      .when '/current',
        controller: 'CurrentCandidateCtrl'
        templateUrl: 'current'
      .otherwise
        redirectTo: '/'

    $locationProvider.html5Mode true