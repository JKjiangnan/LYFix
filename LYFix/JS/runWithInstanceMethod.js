var vc = runMethod('ViewController','currentViewController');
var tableView = runInstanceMethod(vc,'tableView');
var co = new Array(Math.random(),Math.random(),Math.random(),Math.random());
var color = runMethod('UIColor','colorWithRed:green:blue:alpha:',co);
runInstanceMethod(tableView,'setBackgroundColor:',new Array(color));
