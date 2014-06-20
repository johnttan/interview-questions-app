'use strict';

var api = require('./controllers/api'),
    apisql = require('./controllers/apisql'),
    index = require('./controllers'),
    config = require('./config/config');
/**
 * Application routes
 */
if(config.database === 'mongo'){
    module.exports = function(app) {

        // Server API Routes (MongoDB)
    app.get('/getquestions', api.getquestions);
    app.get('/getkeys', api.getkeys);
    app.post('/editquestion', api.editquestion);
    app.post('/addquestion', api.addquestion);
    app.post('/updatekeys', api.updatekeys);

        // All other routes to use Angular routing in app/scripts/app.js
//  app.get('/partials/*', index.partials);
        app.get('/*', index.index);
    };
}else{
    module.exports = function(app) {
//  Server API Routes (SQL Server 2012)
        app.post('/addquestion', apisql.addquestion);
        app.post('/editquestion', apisql.removequestion);
        app.post('/insertkeys', apisql.insertkeys);
        app.post('/insertrecent', apisql.insertrecent);
        app.post('/removerecent', apisql.removerecent);
        app.post('/updaterecent', apisql.updaterecent);

        app.get('/setupsql', apisql.setupsql);
        app.get('/setupkeys', apisql.setupkeys);
        app.get('/setuprecent', apisql.setuprecent);

        app.get('/getquestions', apisql.getquestions);
        app.get('/getkeys', apisql.getkeys);
        app.get('/getrecent', apisql.getrecent);
        app.get('/removerecent', apisql.removeallrecent);

        // All other routes to use Angular routing in app/scripts/app.js
//  app.get('/partials/*', index.partials);
        app.get('/*', index.index);
    };
}
