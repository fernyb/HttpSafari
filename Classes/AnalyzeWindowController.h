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
@class HttpSafariRequestItem;
@class WebDataSource;


@interface AnalyzeWindowController : NSWindowController <NSWindowDelegate, NSTableViewDataSource, NSTableViewDelegate, NSTabViewDelegate> 
{
  IBOutlet NSTableView * table;
  IBOutlet NSTabView * tabview;
  
  NSMutableArray * list;
  NSInteger selectedIndex;
  HttpSafariRequestItem * currentItem;
  
  NSData * currentPostData;
  NSString * currentContent;
  NSDictionary * currentRequestHeaders;
  NSDictionary * currentResponseHeaders;
  NSArray * currentResponseCookies;
  NSArray * currentRequestCookies;
  NSDictionary * currentRequestParams;
  NSData * currentRequestData;
  
  id dataResource;
  
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
@property(retain) id dataResource;


- (void)webViewDidLoad:(NSNotification *)aNotification;
- (void)showWindow:(id)sender;
- (void)setTabViewIfNeeded:(NSTabViewItem *)tabViewItem;
+ (NSArray *)tableColumnKeys;
- (void)setRequestHeaders:(NSDictionary *)headers;
- (void)setResponseHeaders:(NSDictionary *)headers;
- (void)setPostData:(NSString *)data;
- (void)setContent:(NSString *)content;
- (void)httpSafariShowRequest:(NSNotification *)aNotification;
- (void)clearCurrentItemsIfNeeded;
- (void)rowClicked:(NSTableView *)aTable;


@end
