'use strict';

var mongoose = require('mongoose'),
    Questions = mongoose.model('Questions'),
    Keys = mongoose.model('Keys');

/**
 * Get awesome things
 */
exports.getquestions = function(req, res) {
    Questions.find({}, function(err, questions){
        res.send(questions);
    })
};

exports.getkeys = function(req, res) {
    Keys.find({}, function(err, questions){
        res.send(questions);
    })
};