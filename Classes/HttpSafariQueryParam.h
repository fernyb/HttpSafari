//
//  HttpSafariQueryParam.h
//  HttpSafari
//
//  Created by fernyb on 6/27/10.
//  Copyright 2010 Fernando Barajas. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface HttpSafariQueryParam : NSObject {
  NSString * name;
  NSString * value;
}
@property(copy) NSString * name;
@property(copy) NSString * value;

@end
