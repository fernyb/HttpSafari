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
@synthesize requestHeadersList;
@synthesize responseHeadersList;
@synthesize resourceDataList;
@synthesize responseCookieList;
@synthesize requestCookieList;
@synthesize requestParamsList;
@synthesize requestPostDataList;


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

- (void)addRequestHeaders:(NSDictionary *)request
{
  if(!requestHeadersList) {
    requestHeadersList = [[NSMutableArray alloc] init];
  }
  if(request) {
    //NSDictionary * req = [request copy];
    [requestHeadersList addObject:request];
    //[req release];
  } else {
    [requestHeadersList addObject:[NSDictionary dictionary]];
  }
}

- (void)addResponseHeaders:(NSDictionary *)response
{
  if(!responseHeadersList) {
    responseHeadersList = [[NSMutableArray alloc] init];
  }
  if(response) {
    //SDictionary * res = [response copy];
    [responseHeadersList addObject:response];
    //[res release];
  } else {
    [responseHeadersList addObject:[NSDictionary dictionary]];
  }
}

- (void)addResourceData:(NSData *)data
{
  if(!resourceDataList) {
    resourceDataList = [[NSMutableArray alloc] init];
  }
  if(data) {
    [resourceDataList addObject:data];
  } else {
    [resourceDataList addObject:[NSData data]];
  }
}

- (void)addResponseCookies:(NSArray *)kookies
{
  if(!responseCookieList) {
    responseCookieList = [[NSMutableArray alloc] init];
  }
  if(kookies) {
    [responseCookieList addObject:kookies];
  } else {
    [responseCookieList addObject:[NSArray array]];
  }
}

- (void)addRequestCookies:(NSArray *)kookies
{
  if(!requestCookieList) {
    requestCookieList = [[NSMutableArray alloc] init];
  }
  if(kookies) {
    [requestCookieList addObject:kookies];
  } else {
    [requestCookieList addObject:[NSArray array]];
  }
}

- (void)addParams:(NSDictionary *)params
{
  if(!requestParamsList) {
    requestParamsList = [[NSMutableArray alloc] init];
  }
  if(params) {
    [requestParamsList addObject:params];
  } else {
    [requestParamsList addObject:[NSDictionary dictionary]];
  }
}

- (void)addPostData:(NSData *)data
{
  if(!requestPostDataList) {
    requestPostDataList = [[NSMutableArray alloc] init];
  }
  if(data) {
    [requestPostDataList addObject:data];
  } else {
    [requestPostDataList addObject:[NSData data]];
  }
}

@end
