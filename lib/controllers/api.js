'use strict';

var mongoose = require('mongoose'),
    Questions = mongoose.model('Questions'),
    Keys = mongoose.model('Keys');
    Recent = mongoose.model('Recent');

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