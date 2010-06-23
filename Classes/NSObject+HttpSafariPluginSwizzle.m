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
    NSError * error = nil;
    BOOL isSwizzled = [targetClass jr_swizzleMethod:targetSelector withMethod:newSelector error:&error];
    if(error != nil) {
      NSLog(@"Error Trying to swizzle");
      return NO;
    }
    
    if(isSwizzled) {
      NSLog(@"Swizzle success!");
      return YES;
    } else {
      NSLog(@"Swizzle did not happen.");
      return NO;
    }

  return YES;
}

@end

