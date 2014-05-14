'use strict';

var mongoose = require('mongoose'),
    Questions = mongoose.model('Questions'),
    Keys = mongoose.model('Keys'),
    Recent = mongoose.model('Recent'),
    uuid = require('node-uuid');

/**
 * Get awesome things
 */
exports.getquestions = function(req, res) {
    Questions.find({}, function(err, questions){
        res.send(questions);
    });
};

exports.getkeys = function(req, res) {
    Keys.find({}, function(err, questionskeys){
        questionskeys = questionskeys[0];
        res.send(questionskeys);
    });
};
exports.getrecent = function(req, res) {
    Recent.find({}, function(err, recent){
        res.send(recent);
    });
};
exports.addrecent = function(req, res) {
    Recent.find({}, function(err, recent){
        res.send(recent);
    });
};

function removeQuestion(req, res){

    Questions.remove({'uid':req.body.uid}, function(err, question){
        if(err){
            console.log(err);
            res.send('error at remove question');
        }else{
            res.send('allgood');
        }
    });
}
function editQuestion(req, res){
    var uid = req.body.question.uid;
    var updatedquestion = req.body.question;
    Questions.where({'uid':uid}).update(updatedquestion, function(err, question){
        if(err){
            res.send('error at edit question');
        }else{
            res.send('allgood');
        }
    });
}
exports.editquestion = function(req, res) {
    console.log(req.body);
    if (req.body.editType === 'remove'){
        removeQuestion(req, res);
    }else if(req.body.editType === 'edit'){
        editQuestion(req, res);
    }
};
exports.addquestion = function(req, res) {
    var question = req.body;
    question.uid = uuid.v4();
    console.log(question);
    Questions.collection.insert(question, function(err, q){
        if(err){
            console.log(err);
            res.send('error');
        }else{
            res.send('allgood');
        }
    });

};