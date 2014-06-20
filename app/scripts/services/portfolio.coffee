angular.module("interviewappApp")
.service "Portfolio", ['RecentQuestions', 'Questions',
    class Portfolio
      constructor: (@RecentQuestions, @Questions, @generatedqs, @limit, @candidate, @role, @hashedname, @userdata)->
        @generatedqs = {}
        @limit = {}
      deletequestion: (qid, category)->
        console.log(qid, category)
        @generatedqs[category] = (x for x in @generatedqs[category] when x['_id'] != qid)
      addquestion: (question)->
        if question.category not of @generatedqs
          @generatedqs[question.category] = []
        console.log('adding to portfolio', question)
        console.log(@generatedqs)
        if question not in @generatedqs[question.category]
          @generatedqs[question.category].push(question)
      addrolequestion: (question)->
        if 'Role' not of @generatedqs
          @generatedqs[question.category] = []
        if question not in @generatedqs['Role']
          @generatedqs['Role'].push(question)

      savecandidate: ()->
        if @candidate isnt undefined
P          tobeadded = {}
          for own category, questionarray of @generatedqs
            tobeadded[category] = questionarray
          console.log(tobeadded)
          questionids = {}
          for own key, value of tobeadded
            questionids[key] = (question['uid'] for question in tobeadded[key])
          if @hashedname not in Object.keys(@RecentQuestions.recentquestions)
            update = false
            console.log('savegenerated')
          else
            update = @userdata
            console.log('savepreviouslygenerated')
          @RecentQuestions.addrecent(@candidate, @role, @limit, questionids, update)

      injectcandidate: (candidate)->
        @candidate = candidate.name
        @hashedname = candidate.hashedname
        tempqs = {}
        if @Questions.transformedjson isnt undefined
          for own key, value of candidate.questions
            console.log(key, value)
            tempqs[key] = (@Questions.transformedjson[uid] for uid in value)
          console.log(tempqs, 'tempqs', @Questions.transformedjson)
        else
          @Questions.transformedqs.then((transformedjson)->
            for own key, value of candidate.questions
              tempqs[key] = (transformedjson[uid] for uid in value)
            console.log(tempqs, 'tempqs', transformedjson)

          )
        @generatedqs = tempqs
        @limit = candidate.limit
        @role = candidate.role
        console.log(@generatedqs)
        @userdata = candidate
  ]