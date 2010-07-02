//
//  HttpSafariManager.m
//  HttpSafari
//
//  Created by fernyb on 6/29/10.
//  Copyright 2010 Fernando Barajas. All rights reserved.
//

#import <WebKit/WebKit.h>
#import "HttpSafariManager.h"
#import "HttpSafariRequestItem.h"


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

- (void)addRequest:(HttpSafariRequestItem *)item
{
  if(!requestList) {
    requestList = [[NSMutableArray alloc] init];
  }
  [requestList addObject:item];
}

- (NSMutableArray *)requests
{
  return requestList;
}

- (void)addDataSource:(WebDataSource *)dataSource
{
  if(aDataSource) {
    [aDataSource release], aDataSource = nil;
  }
  aDataSource = [dataSource retain];
}

- (WebDataSource *)dataSource
{
  return aDataSource;
}

- (void)addResource:(WebResource *)resource
{
  if(!resourceList) {
    resourceList = [[NSMutableArray alloc] init];
  }
  if(resource) {
    [resourceList addObject:resource];
  } else {
    [resourceList addObject:@""];
  }
}

- (NSMutableArray *)resources
{
  return resourceList;
}

@end
