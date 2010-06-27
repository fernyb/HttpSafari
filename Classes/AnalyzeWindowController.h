//
//  AnalyzeWindowController.h
//  HttpSafari
//
//  Created by fernyb on 6/21/10.
//  Copyright 2010 Fernando Barajas. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class HeaderViewController;


@interface AnalyzeWindowController : NSWindowController <NSTableViewDataSource, NSTableViewDelegate> 
{
  IBOutlet NSTableView * table;
  IBOutlet NSTabView * tabview;
  NSMutableArray * list;
  
  HeaderViewController * headerviewController;
  NSDictionary * currentRequestHeaders;
}

- (void)showWindow:(id)sender;
+ (NSArray *)tableColumnKeys;
- (void)setRequestHeaders:(NSDictionary *)headers;
- (void)logRequest:(NSMutableArray *)request;
- (void)rowClicked:(NSTableView *)aTable;

@end
