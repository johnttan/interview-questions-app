'use strict';

var path = require('path');

var rootPath = path.normalize(__dirname + '/../../..');

module.exports = {
  database: 'sql', //sql or mongo
  root: rootPath,
  port: process.env.PORT || 8080,
  mongo: {
    options: {
      db: {
        safe: true
      }
    }
  }
};