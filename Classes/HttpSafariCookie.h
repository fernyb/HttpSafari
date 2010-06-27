//
//  HttpSafariCookie.h
//  HttpSafari
//
//  Created by fernyb on 6/27/10.
//  Copyright 2010 Fernando Barajas. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface HttpSafariCookie : NSObject {
  NSString * name;
  NSString * value;
  NSString * path;
  NSString * domain;
  NSString * expires;
}

@property(copy) NSString * name;
@property(copy) NSString * value;
@property(copy) NSString * path;
@property(copy) NSString * domain;
@property(copy) NSString * expires;


@end
