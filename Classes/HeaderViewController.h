//
//  HeaderViewController.h
//  HttpSafari
//
//  Created by fernyb on 6/24/10.
//  Copyright 2010 Fernando Barajas. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface HeaderViewController : NSObject {
  IBOutlet NSView * headerview;
  IBOutlet NSTableView * responseHeadersTable;
  IBOutlet NSArrayController * responseArrayController;
  IBOutlet NSArrayController * requestArrayController;
  
  NSMutableArray * requestHeaders;
  NSMutableArray * responseHeaders;
}
@property(readonly, getter=view) NSView * headerview;

- (void)showRequestHeaders:(NSNotification *)aNotification;
- (void)showResponseHeaders:(NSNotification *)aNotification;

@end
