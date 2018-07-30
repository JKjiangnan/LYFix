fixMethod('LBYFixDemo', 'instanceMightCrash:', 1, 
          function(instance, originInvocation, originArguments) {
          if (originArguments[0] == null) {
          runErrorBranch('LBYFixDemo', 'instanceMightCrash');
          } else {
          runInvocation(originInvocation);
          }
          });
