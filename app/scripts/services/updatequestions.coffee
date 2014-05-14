angular.module("interviewappApp")
.service "EditQuestions", ['$http'
    class EditQuestions
      constructor: (@$http)->
      editquestion: (edit, question)->
        if edit == 'edit'
          data = {
            editType: edit
            question: question
          }
        else
          data = {
            editType: edit
            uid: question.uid
          }
          console.log('remove: ' + data);
        @$http.post('/editquestion', data)
      addquestion: (question)->
        @$http.post('/addquestion', question)
  ]