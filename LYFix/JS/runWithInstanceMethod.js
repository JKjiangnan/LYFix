var vc = runMethod('ViewController','currentViewController');
var tableView = runInstanceMethod(vc,'view');
var co = new Array(Math.random(),Math.random(),Math.random(),Math.random());
var color = runMethod('UIColor','colorWithRed:green:blue:alpha:',co);
//runInstanceMethod(tableView,'setBackgroundColor:',new Array(color));

var label = runMethod('UILabel','new');
//var frame = {{20,20},{50,50}};
runInstanceMethod(label,'setFrame:',new Array('{{100, 101}, {102, 103}}'));
runInstanceMethod(label,'setText:',new Array('Test'));
runInstanceMethod(label,'setBackgroundColor:',new Array(color));
runInstanceMethod(tableView,'addSubview:',new Array(label));
//runInstanceMethod(label,'sizeToFit');

