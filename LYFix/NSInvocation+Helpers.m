//
//  NSInvocation+Helpers.m
//
//
//  Created by Stéphane Copin on 1/7/15.
//  Copyright (c) 2015 Stéphane Copin.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall remain in place
// in this source code.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

#import "NSInvocation+Helpers.h"

@implementation NSInvocation (Helpers)

// Adapted from https://github.com/kstenerud/Objective-Gems
- (id)objectReturnValue {
  const char * returnType = self.methodSignature.methodReturnType;
#define GET_RETURN_VALUE_TYPE_NATIVE(type) \
  else if(strcmp(returnType, @encode(type)) == 0) \
  { \
    type result; \
    [self getReturnValue:&result]; \
    return @(result); \
  }
  
  if(strcmp(returnType, @encode(void)) == 0) {
    return nil;
  } else if(strcmp(returnType, @encode(id)) == 0) {
    id result;
    [self getReturnValue:&result];
    return result;
  } else if(strcmp(returnType, "?") == 0) {
    void * result;
    [self getReturnValue:&result];
    return [NSValue valueWithPointer:result];
  } else if(strcmp(returnType, "*") == 0) {
    char * result;
    [self getReturnValue:&result];
    return [NSValue valueWithPointer:strdup(result)];
  } else if(strcmp(returnType, ":") == 0) {
    SEL result;
    [self getReturnValue:&result];
    return [NSValue valueWithPointer:result];
  }
  GET_RETURN_VALUE_TYPE_NATIVE(BOOL)
  GET_RETURN_VALUE_TYPE_NATIVE(bool)
  GET_RETURN_VALUE_TYPE_NATIVE(char)
  GET_RETURN_VALUE_TYPE_NATIVE(short)
  GET_RETURN_VALUE_TYPE_NATIVE(int)
  GET_RETURN_VALUE_TYPE_NATIVE(long)
  GET_RETURN_VALUE_TYPE_NATIVE(long long)
  GET_RETURN_VALUE_TYPE_NATIVE(unsigned char)
  GET_RETURN_VALUE_TYPE_NATIVE(unsigned short)
  GET_RETURN_VALUE_TYPE_NATIVE(unsigned int)
  GET_RETURN_VALUE_TYPE_NATIVE(unsigned long)
  GET_RETURN_VALUE_TYPE_NATIVE(unsigned long long)
  GET_RETURN_VALUE_TYPE_NATIVE(float)
  GET_RETURN_VALUE_TYPE_NATIVE(double)
  return nil;
}

- (void)setObjectReturnValue:(id)returnValue {
  const char * returnType = self.methodSignature.methodReturnType;
  
#define SET_RETURN_VALUE_TYPE_NATIVE_METHOD(type, method) \
  else if(strcmp(returnType, @encode(type)) == 0) \
  { \
    type result = [returnValue method]; \
    [self setReturnValue:&result]; \
  }
  
#define SET_RETURN_VALUE_TYPE_NATIVE(type) SET_RETURN_VALUE_TYPE_NATIVE_METHOD(type, type ## Value)
  
  if(strcmp(returnType, @encode(id)) == 0) {
    [self setReturnValue:&returnValue];
  } else if(strcmp(returnType, "?") == 0) {
    void * returnValuePointer = [returnValue pointerValue];
    [self setReturnValue:&returnValuePointer];
  } else if(strcmp(returnType, "*") == 0) {
    void * returnValuePointer = [returnValue pointerValue];
    [self setReturnValue:&returnValuePointer];
    free([returnValue pointerValue]);
  } else if(strcmp(returnType, ":") == 0) {
    SEL returnValuePointer = [returnValue pointerValue];
    [self setReturnValue:&returnValuePointer];
  }
  SET_RETURN_VALUE_TYPE_NATIVE_METHOD(BOOL, boolValue)
  SET_RETURN_VALUE_TYPE_NATIVE(bool)
  SET_RETURN_VALUE_TYPE_NATIVE(char)
  SET_RETURN_VALUE_TYPE_NATIVE(short)
  SET_RETURN_VALUE_TYPE_NATIVE(int)
  SET_RETURN_VALUE_TYPE_NATIVE(long)
  SET_RETURN_VALUE_TYPE_NATIVE_METHOD(long long, longLongValue)
  SET_RETURN_VALUE_TYPE_NATIVE_METHOD(unsigned char, unsignedCharValue)
  SET_RETURN_VALUE_TYPE_NATIVE_METHOD(unsigned short, unsignedShortValue)
  SET_RETURN_VALUE_TYPE_NATIVE_METHOD(unsigned int, unsignedIntValue)
  SET_RETURN_VALUE_TYPE_NATIVE_METHOD(unsigned long, unsignedLongValue)
  SET_RETURN_VALUE_TYPE_NATIVE_METHOD(unsigned long long, unsignedLongLongValue)
  SET_RETURN_VALUE_TYPE_NATIVE(float)
  SET_RETURN_VALUE_TYPE_NATIVE(double)
}

// Adapted from https://github.com/stevedekorte/ActorKit
- (instancetype)stc_clone {
  NSInvocation * clone = [NSInvocation invocationWithMethodSignature:self.methodSignature];
  NSUInteger argCount = self.methodSignature.numberOfArguments;
  for (NSInteger i = 0; i < argCount; i++) {
    const char * argumentType = [self.methodSignature getArgumentTypeAtIndex:i];
    NSUInteger alignedArgumentSize = 0;
    NSGetSizeAndAlignment(argumentType, NULL, &alignedArgumentSize);
    char argument[alignedArgumentSize];
    [self getArgument:&argument atIndex:i];
    [clone setArgument:&argument atIndex:i];
  }
  return clone;
}

@end
