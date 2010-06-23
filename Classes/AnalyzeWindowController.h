//
//  AnalyzeWindowController.h
//  HttpSafari
//
//  Created by fernyb on 6/21/10.
//  Copyright 2010 Fernando Barajas. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface AnalyzeWindowController : NSWindowController <NSTableViewDataSource, NSTableViewDelegate> 
{
  IBOutlet NSTableView * table;
  NSMutableArray * list;
}

- (void)showWindow:(id)sender;
+ (NSArray *)tableColumnKeys;
- (void)logRequest:(NSDictionary *)request;

@end
