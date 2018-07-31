fixMethod("ViewController", "test:test1:", 1, function(instance, invocation, arg) {
          if (arg[0] == null) {
          runErrorBranch("ViewController", "test");
          } else {
          var arr1 = new Array();
          arr1[0] = '1';
          arr1[1] = '2';
          setInvocationArgumentAtIndex(invocation, 1234, 1);
          runInvocation(invocation);
         
          var arr = new Array();
          arr[0] = '0';
          setInvocationReturnValue(invocation, arr);
          }
          });
