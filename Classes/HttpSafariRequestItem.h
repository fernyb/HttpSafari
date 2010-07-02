//
//  HttpSafariRequestItem.h
//  HttpSafari
//
//  Created by fernyb on 7/1/10.
//  Copyright 2010 Fernando Barajas. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface HttpSafariRequestItem : NSObject {
  NSString * requestTime;
  NSString * method;
  NSString * url;
  NSString * contentType;
}
@property(copy) NSString * requestTime;
@property(copy) NSString * method;
@property(copy) NSString * url;
@property(copy) NSString * contentType;

@end
