var express = require('express');
var router = express.Router();

var Task = require('../models/Task');

router.get('/', function(req, res, next) {
  Task.find({}, function(err, tasks){
		if(err){
			return res.status(400).send("err in get /task");
		}else{
			console.log(tasks);
			return res.status(200).json(tasks);
		}
	})
});

router.post('/', function(req, res, next) {
  var task = req.body.task;
  console.log(task);
  //res.json({message: 'Task is ' + task});
  Task.create({task: task}, function(err, task){
		if (err) {
			return res.status(400).send("err in post /task");
		} else {
			return res.status(200).json(task);
		}
	});
});

module.exports = router;