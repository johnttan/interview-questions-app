/**
 * Created by Ostonzi on 4/9/14.
 */
'use strict';

var mongoose = require('mongoose'),
    Schema = mongoose.Schema;

/**
 * Thing Schema
 */
var KeysSchema = new Schema({});

/**
 * Validations
 */
//ThingSchema.path('awesomeness').validate(function (num) {
//  return num >= 1 && num <= 10;
//}, 'Awesomeness must be between 1 and 10');

mongoose.model('Keys', KeysSchema, 'Keys');
