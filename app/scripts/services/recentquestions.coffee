angular.module("interviewappApp")
.service "RecentQuestions", ['localStorageService', '$rootScope', '$resource',  '$http',
    class RecentQuestions
      constructor: (@localStorageService, @$rootScope, @$resource, @$http)->
      getrecentquery: ->
        @$resource "/getrecent",
          get:
            method: "GET",
            isArray: false
      removeallrecent: ->
        @$resource "/removerecent",
          get:
            method: "GET"
      getrecent: ->
        @recentquestions = @getrecentquery().get()
        if @recentquestions is null
          @recentquestions = {}
        @recentquestions.$promise.then((result)->
          @recentquestions = result
          for own key, value of @recentquestions
            if key not in ['$resolved', '$promise']
              @recentquestions[key] = JSON.parse(value)
        )
      addrecent: (name, role, limit, tobeadded, update)->
        if @recentquestions is null
          @recentquestions = {}
        d = new Date()
        time = d.getTime()
        hashedname = time + '__' + name
        dateVal = "/Date(" + String(time) + ")/"
        createdtime = new Date(parseFloat( dateVal.substr(6 )))

        console.log('servicetobeadded')
        console.log(tobeadded)
        userdata = {
          'name': name,
          'hashedname': hashedname,
          'role': role,
          'time': time,
          'timestring': createdtime,
          'questions': tobeadded,
          'limit': limit
        }
        @recentquestions[hashedname] = userdata
        if update
          @clearrecentq(update)
          console.log("updatingrecentcandidate")
          @$http.post('/updaterecent', @recentquestions[hashedname])
        else
          @$http.post('/insertrecent', @recentquestions[hashedname])
        @$rootScope.$broadcast('recentquestions', @recentquestions)
#        @recentquestions
      saverecent: (hashedname)->
        @$http.post('/updaterecent', @recentquestions[hashedname])
      clearreccent: ->
        @recentquestions = {}
        @removeallrecent().get()
        @$rootScope.$broadcast('recentquestions', @recentquestions)
      clearrecentq: (candidate)->
        delete @recentquestions[candidate.hashedname]
        @$http.post('/removerecent', candidate)

  ]