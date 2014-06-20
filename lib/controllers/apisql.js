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
var createrecentquery = "CREATE TABLE Recent (hashedname nvarchar(max), json nvarchar(max));";
var retrievequestionsquery = 'select * from Questions';
var retrievekeysquery = 'select * from Keys';
var retrieverecentquery = 'select * from Recent';
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
var removerecentgen = function(hashedname){
    return 'delete from Recent where hashedname = ' + "'" + hashedname + "';";
};
var insertrecentgen = function(data){
    console.log(data);
    var hashedname = data.hashedname;
    return 'insert into Recent values (' + "'" + hashedname + "'" + "," + "'" + JSON.stringify(data) + "');";
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

exports.setuprecent = function(req, res){
    transactions(req, res, createrecentquery, false);
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
exports.insertrecent = function(req, res){
    console.log(req.body);
    var insertrecentquery = insertrecentgen(req.body);
    console.log(insertrecentquery);
    transactions(req, res, insertrecentquery, false);
};
exports.updaterecent = function(req, res){
    console.log(req.body);
    var insertrecentquery = insertrecentgen(req.body);
    console.log(insertrecentquery);
    console.log(req.body.hashedname, 'hashedname');
    var removerecentquery = removerecentgen(req.body.hashedname);
    transactions(req, res, removerecentquery, insertrecentquery);
};

exports.removequestion = function(req, res){
    console.log(req.body);
    var removequestionquery = removequestiongen(req.body);
    console.log(removequestionquery);
    transactions(req, res, removequestionquery, false);
};

exports.removerecent = function(req, res){
    console.log(req.body);
    var removerecentquery = removerecentgen(req.body.hashedname);
    console.log(removerecentquery);
    transactions(req, res, removerecentquery, false);
};
exports.removeallrecent = function(req, res){
    console.log(req.body);
    var removerecentquery = "delete from Recent;";
    transactions(req, res, removerecentquery, false);
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
exports.getrecent = function(req, res){
    sql.connect(config.config, function(err){
        if(err){
            console.log(err);
            res.send(err);
        }
        var request = new sql.Request();
        request.query(retrieverecentquery, function(err, recordset){
            if(err){
                console.log(err);
                res.send(err);
            }else{
                if(recordset[0] === undefined){
                    res.send(404);
                }else{
                    console.log(recordset[0].json);
                    var processed = {};
                    if(recordset.length > 0){
                        for(var i=0;i<recordset.length;i++){
                            var cand = JSON.parse(recordset[i].json);
                            processed[cand.hashedname] = recordset[i].json;
                        }
                        res.send(processed);

                    }else{
                        res.send(null);
                    }

                }
            }

        });
    });
};
