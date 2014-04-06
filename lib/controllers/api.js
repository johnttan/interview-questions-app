'use strict';

var mongoose = require('mongoose'),
    Questions = mongoose.model('Questions');

/**
 * Get awesome things
 */
exports.getquestions = function(req, res) {
    Questions.find({}, function(err, questions){
        res.send(questions);
    })
};