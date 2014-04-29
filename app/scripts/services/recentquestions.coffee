angular.module("interviewappApp")
.service "RecentQuestions", ['localStorageService', '$rootScope',
    class RecentQuestions
      constructor: (@localStorageService, @$rootScope)->
      getrecent: ->
        @recentquestions = @localStorageService.get('recentquestions')
        if @recentquestions is null
          @recentquestions = {}
        @$rootScope.$broadcast('recentquestions', @recentquestions)
      addrecent: (name, tobeadded)->
        if @recentquestions is null
          @recentquestions = {}
        d = new Date()
        time = d.getTime()
        hashedname = time + '__' + name
        console.log('servicetobeadded')
        console.log(tobeadded)
        userdata = {
          'name': name
          'time': time,
          'questions': tobeadded
        }
        @recentquestions[hashedname] = userdata
        @localStorageService.add('recentquestions', @recentquestions)
        @$rootScope.$broadcast('recentquestions', @recentquestions)
#        @recentquestions
      clearreccent: ->
        @localStorageService.clearAll()
        @recentquestions = {}
        @$rootScope.$broadcast('recentquestions', @recentquestions)
#        @recentquestions
  ]