//
//  HttpSafariContentController.h
//  HttpSafari
//
//  Created by fernyb on 6/29/10.
//  Copyright 2010 Fernando Barajas. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface HttpSafariContentController : NSObject {
  IBOutlet NSView * contentview;
  IBOutlet NSTextView * textview;
}
@property(readonly, getter=view) NSView  * contentview;

- (void)showRequestData:(NSNotification *)aNotification;

@end
