//
//  HttpSafariManager.h
//  HttpSafari
//
//  Created by fernyb on 6/29/10.
//  Copyright 2010 Fernando Barajas. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class HttpSafariRequestItem;
@class WebDataSource;
@class WebResource;


@interface HttpSafariManager : NSObject {
  BOOL isWindowOpen;
  
  WebDataSource * aDataSource;
  NSMutableArray * dataSourceList;
  NSMutableArray * requestList;
  NSMutableArray * resourceList;
  
  NSMutableArray * requestHeadersList;
  NSMutableArray * responseHeadersList;
  NSMutableArray * resourceDataList;
  NSMutableArray * responseCookieList;
  NSMutableArray * requestCookieList;
  NSMutableArray * requestParamsList;
  NSMutableArray * requestPostDataList;
}

@property(assign) BOOL isWindowOpen;
@property(readonly) NSMutableArray * requestHeadersList;
@property(readonly) NSMutableArray * responseHeadersList;
@property(readonly) NSMutableArray * resourceDataList;
@property(readonly) NSMutableArray * responseCookieList;
@property(readonly) NSMutableArray * requestCookieList;
@property(readonly) NSMutableArray * requestParamsList;
@property(readonly) NSMutableArray * requestPostDataList;


+ (HttpSafariManager *)sharedInstance;

- (void)addRequest:(HttpSafariRequestItem *)item;
- (NSMutableArray *)requests;

- (void)addDataSource:(WebDataSource *)dataSource;
- (WebDataSource *)dataSource;

- (void)addResource:(WebResource *)resource;
- (NSMutableArray *)resources;

- (void)addRequestHeaders:(NSDictionary *)request;
- (void)addResponseHeaders:(NSDictionary *)response;
- (void)addResourceData:(NSData *)data;
- (void)addResponseCookies:(NSArray *)kookies;
- (void)addRequestCookies:(NSArray *)kookies;
- (void)addParams:(NSDictionary *)params;
- (void)addPostData:(NSData *)data;

@end
