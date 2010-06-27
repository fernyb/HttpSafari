//
//  CookieViewController.h
//  HttpSafari
//
//  Created by fernyb on 6/26/10.
//  Copyright 2010 Fernando Barajas. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface CookieViewController : NSObject {
  IBOutlet NSView * cookieview;
  IBOutlet NSTableView * receivedCookiesTable;
  IBOutlet NSTableView * sentCookiesTable;
  IBOutlet NSArrayController * cookiesSentArrayController;
  
  NSMutableArray * cookiesReceived;
  NSMutableArray * cookiesSent;
}
@property(readonly, getter=view) NSView * cookieview;

- (void)showCookies:(NSNotification *)aNotification;

@end
