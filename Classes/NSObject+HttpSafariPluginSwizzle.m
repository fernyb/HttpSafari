//
//  NSObject+HttpSafariPluginSwizzle.m
//  HttpSafari
//
//  Created by fernyb on 6/20/10.
//  Copyright 2010 Fernando Barajas. All rights reserved.
//
#import <objc/objc-class.h>
#import "NSObject+HttpSafariPluginSwizzle.h"
#import "JRSwizzle.h"


@implementation NSObject (HttpSafariPluginSwizzle)

- (BOOL)swizzleClass:(Class)targetClass targetSelector:(SEL)targetSelector withSelector:(SEL)newSelector
{
  extern void _objc_flush_caches(Class);
  
  IMP newMethodIMP = class_getMethodImplementation([self class], newSelector); 
  Method newMethod = class_getInstanceMethod([self class], newSelector);
  
  if ( class_addMethod(targetClass, newSelector, newMethodIMP, method_getTypeEncoding(newMethod)) ) {
    
    NSError * error = nil;
    BOOL isSwizzled = [targetClass jr_swizzleMethod:targetSelector withMethod:newSelector error:&error];
    if(error != nil) {
      NSLog(@"Error Trying to swizzle");
      return NO;
    }
    
    if(isSwizzled) {
       _objc_flush_caches(targetClass);
      
      NSLog(@"Swizzle success!");
      return YES;
    } else {
      NSLog(@"Swizzle did not happen.");
      return NO;
    }
    
  } else {
    NSLog(@"Could Not Add Method to Class: %@ %@", NSStringFromClass(targetClass), NSStringFromSelector(newSelector));
    return NO;
  }
  
  return YES;
}

@end

