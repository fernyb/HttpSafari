//
//  NSObject+HttpSafariPluginSwizzle.h
//  HttpSafari
//
//  Created by fernyb on 6/20/10.
//  Copyright 2010 Fernando Barajas. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface NSObject (HttpSafariPluginSwizzle)

- (BOOL)swizzleClass:(Class)targetClass targetSelector:(SEL)targetSelector withSelector:(SEL)newSelector;

@end
