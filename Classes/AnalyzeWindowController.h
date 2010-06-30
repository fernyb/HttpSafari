//
//  AnalyzeWindowController.h
//  HttpSafari
//
//  Created by fernyb on 6/21/10.
//  Copyright 2010 Fernando Barajas. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class HeaderViewController;
@class CookieViewController;
@class QueryViewController;
@class HttpSafariPostDataController;
@class HttpSafariContentController;


@interface AnalyzeWindowController : NSWindowController <NSWindowDelegate, NSTableViewDataSource, NSTableViewDelegate, NSTabViewDelegate> 
{
  IBOutlet NSTableView * table;
  IBOutlet NSTabView * tabview;
  NSMutableArray * list;
  NSArray * currentItem;
  NSString * currentPostData;
  NSString * currentContent;
  NSDictionary * currentRequestHeaders;
  
  HeaderViewController * headerviewController;
  CookieViewController * cookiesController;
  QueryViewController * queryController;
  HttpSafariPostDataController * postdataController;
  HttpSafariContentController * contentviewController;
  
  NSMutableArray * responseHeadersList;
  NSMutableArray * requestHeadersList;
  NSMutableArray * postDataList;
  NSMutableArray * contentList;
}

- (void)showWindow:(id)sender;
- (void)setTabViewIfNeeded:(NSTabViewItem *)tabViewItem;
+ (NSArray *)tableColumnKeys;
- (void)setRequestHeaders:(NSDictionary *)headers;
- (void)setResponseHeaders:(NSDictionary *)headers;
- (void)setPostData:(NSString *)data;
- (void)setContent:(NSString *)content;
- (void)logRequest:(NSMutableArray *)request;
- (void)rowClicked:(NSTableView *)aTable;


@end
