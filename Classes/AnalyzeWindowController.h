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


@interface AnalyzeWindowController : NSWindowController <NSTableViewDataSource, NSTableViewDelegate, NSTabViewDelegate> 
{
  IBOutlet NSTableView * table;
  IBOutlet NSTabView * tabview;
  NSMutableArray * list;
  NSArray * currentItem;
  
  HeaderViewController * headerviewController;
  CookieViewController * cookiesController;
  NSDictionary * currentRequestHeaders;
}

- (void)showWindow:(id)sender;
- (void)setTabViewIfNeeded:(NSTabViewItem *)tabViewItem;
+ (NSArray *)tableColumnKeys;
- (void)setRequestHeaders:(NSDictionary *)headers;
- (void)logRequest:(NSMutableArray *)request;
- (void)rowClicked:(NSTableView *)aTable;


@end
