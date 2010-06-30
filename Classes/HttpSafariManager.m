//
//  HttpSafariManager.m
//  HttpSafari
//
//  Created by fernyb on 6/29/10.
//  Copyright 2010 Fernando Barajas. All rights reserved.
//

#import "HttpSafariManager.h"

@implementation HttpSafariManager
@synthesize isWindowOpen;


+ (HttpSafariManager *)sharedInstance
{  
  static HttpSafariManager * httpSafariManager;
  if(httpSafariManager) {
    return httpSafariManager;
  }
  @synchronized(self) {
    httpSafariManager = [[HttpSafariManager alloc] init];
    [httpSafariManager setIsWindowOpen:NO];
  }
  return httpSafariManager;
}


@end
