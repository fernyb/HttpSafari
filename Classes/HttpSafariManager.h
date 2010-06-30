//
//  HttpSafariManager.h
//  HttpSafari
//
//  Created by fernyb on 6/29/10.
//  Copyright 2010 Fernando Barajas. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface HttpSafariManager : NSObject {
  BOOL isWindowOpen;
}
@property(assign) BOOL isWindowOpen;

+ (HttpSafariManager *)sharedInstance;

@end
