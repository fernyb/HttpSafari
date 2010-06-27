//
//  HttpSafariHeader.h
//  HttpSafari
//
//  Created by fernyb on 6/26/10.
//  Copyright 2010 Fernando Barajas. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface HttpSafariHeader : NSObject {
  NSString * name;
  NSString * value;
}
@property(copy) NSString * name;
@property(copy) NSString * value;

@end
