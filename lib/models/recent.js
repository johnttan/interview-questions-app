
'use strict';

var mongoose = require('mongoose'),
    Schema = mongoose.Schema;

var RecentSchema = new Schema({});

/**
 * Validations
 */


mongoose.model('Recent', RecentSchema);
