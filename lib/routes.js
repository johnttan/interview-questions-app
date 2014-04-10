'use strict';

var api = require('./controllers/api'),
    index = require('./controllers');

/**
 * Application routes
 */
module.exports = function(app) {

  // Server API Routes
  app.get('/getquestions', api.getquestions);
  app.get('/getkeys', api.getkeys);


  // All other routes to use Angular routing in app/scripts/app.js
//  app.get('/partials/*', index.partials);
  app.get('/*', index.index);
};