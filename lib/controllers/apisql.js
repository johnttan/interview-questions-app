var sql = require('mssql');
var config = require('./sqlconfig');
var uuid = require('node-uuid');

var createtablesquery = 'CREATE TABLE Questions ( question text, answers text, role text, subcategory text, category text, uid uniqueidentifier);';
var defaultkeys = JSON.stringify({
    'category': ['General', 'Behavior', 'Situational', 'Opening', 'Closing'],
    'role': ['Executive', 'RN/Nurse', 'CMA', 'CNA', 'Maintenance', 'Dietary'],
    'subcategory': ['Multiple Choice', 'Short Answer', 'Open-Ended', 'Case Study', 'Technical'],
    'uid': null,
    'answers': null,
    'comments': null
});
var createkeysquery = "CREATE TABLE Keys (json nvarchar(max));";
var retrievequestionsquery = 'select * from Questions';
var retrievekeysquery = 'select * from Keys';
var insertkeysgen = function(keys){
    return "insert into Keys values(" + "'" +  keys + "'" + ");";
};
var insertquestiongen = function(values){
    console.log(values);
//    var request = 'insert into Questions values (' + values.question +', '+ values.answers +', '+ values.role +', '+ values.subcategory +', '+ values.category +', '+ uuid.v4() + ');';
    var request = 'insert into Questions values ('+"'"+values.question+"'"+','+"'"+values.answers+"'"+','+"'"+values.role+"'"+','+"'"+values.subcategory+"'"+','+"'"+values.category+"'"+','+'NewID()'+');';
    return request;
};
var removequestiongen = function(data){
    console.log(data);
    var uid = data.uid;
    return 'delete from Questions where uid = ' + "'" + uid + "';";
};
function transactions(req, res, querystring, nextquery){
    sql.connect(config.config, function(err){
        if(err){
            console.log('sql connection failed');
            console.log(err);
            res.send(err);
        }
        var transaction = new sql.Transaction(/* [connection] */);
        transaction.begin(function(err){
            if(err){
                console.log('transaction err');
                console.log(err);
                res.send(err);
            }
            var request = new sql.Request(transaction);
            request.query(querystring, function(err, recordset){
                if(err){
                    console.log(err);
                    res.send(err);
                }else{
                    transaction.commit(function(err, recordset){
                        if(err){
                            console.log(err);
                            res.send(err);
                        }else{
                            console.log('transaction commited.');
                            if(nextquery){
                                transactions(req, res, nextquery);
                            }else{
                                res.send(recordset);
                            }

                        }
                    });

                }

            });
        });
    });
}

exports.setupsql = function(req, res){
    transactions(req, res, createtablesquery, false);
};

exports.setupkeys = function(req, res){
    transactions(req, res, createkeysquery, false);
};

exports.insertkeys = function(req, res){
    var keys = JSON.stringify(req.body);
    console.log(keys);
    var generated = insertkeysgen(keys);
//    var generated = insertkeysgen(defaultkeys);
    console.log(generated);
    var deletekeys = "delete from Keys;";
    transactions(req, res, deletekeys, generated);
};

exports.addquestion = function(req, res){
    console.log(req.body);
    var insertquestionsquery = insertquestiongen(req.body);
    console.log(insertquestionsquery);
    transactions(req, res, insertquestionsquery, false);
};

exports.removequestion = function(req, res){
    console.log(req.body);
    var removequestionquery = removequestiongen(req.body);
    console.log(removequestionquery);
    transactions(req, res, removequestionquery, false);
};

exports.getquestions = function(req, res){
    sql.connect(config.config, function(err){
        if(err){
            console.log(err);
            res.send(err);
        }
        var request = new sql.Request();
        request.query(retrievequestionsquery, function(err, recordset){
            if(err){
                console.log(err);
                res.send(err);
            }else{
//                console.log(recordset);
                res.send(recordset);
            }

        });
    });
};
exports.getkeys = function(req, res){
    sql.connect(config.config, function(err){
        if(err){
            console.log(err);
            res.send(err);
        }
        var request = new sql.Request();
        request.query(retrievekeysquery, function(err, recordset){
            if(err){
                console.log(err);
                res.send(err);
            }else{
                if(recordset[0] === undefined){
                    res.send(404);
                }else{
                    console.log(recordset[0].json);
                    res.send(recordset[0].json);

                }
            }

        });
    });
};
