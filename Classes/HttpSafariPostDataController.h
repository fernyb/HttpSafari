//
//  HttpSafariPostDataController.h
//  HttpSafari
//
//  Created by fernyb on 6/28/10.
//  Copyright 2010 Fernando Barajas. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface HttpSafariPostDataController : NSObject {
  IBOutlet NSView * dataview;
  IBOutlet NSArrayController * formdataArrayController;
  NSMutableArray * formdata;
}
@property(assign,getter=view) NSView * dataview;

- (void)showPostData:(NSNotification *)aNotfication;

@end
