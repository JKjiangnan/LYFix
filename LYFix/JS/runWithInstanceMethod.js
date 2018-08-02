var self;
fixMethod('ViewController','viewDidLoad',0,function(instance,invocation,arg){
          var co = new Array(Math.random(),Math.random(),Math.random(),Math.random());
          var color = runMethod('UIColor','colorWithRed:green:blue:alpha:',co);
          var view = runInstanceMethod(instance,'view');
          self = instance;
          runInstanceMethod(view,'setBackgroundColor:',new Array(color));
          });


fixMethod('ViewController','tableView:didSelectRowAtIndexPath:',0,function(instance,invocation,arg){

          var co = new Array(Math.random(),Math.random(),Math.random(),Math.random());
          var color = runMethod('UIColor','colorWithRed:green:blue:alpha:',co);
          var view = runInstanceMethod(self,'view');

          runInstanceMethod(view,'setBackgroundColor:',new Array(color));
          });

