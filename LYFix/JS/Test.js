fixMethod("ViewController", "test:test1:", 1, function(instance, invocation, arg) {
          if (arg[0] == null) {
          runErrorBranch("ViewController", "test");
          } else {
          setInvocationArgumentAtIndex(invocation, "haha", 1);
          runInvocation(invocation);
         
          var arr = new Array();
          arr[0] = '0';
          setInvocationReturnValue(invocation, arr);
          }
          });
