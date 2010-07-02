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
}

@property(assign) BOOL isWindowOpen;

+ (HttpSafariManager *)sharedInstance;

- (void)addRequest:(HttpSafariRequestItem *)item;
- (NSMutableArray *)requests;

- (void)addDataSource:(WebDataSource *)dataSource;
- (WebDataSource *)dataSource;

- (void)addResource:(WebResource *)resource;
- (NSMutableArray *)resources;

@end
