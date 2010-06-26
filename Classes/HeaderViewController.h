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
}
@property(readonly) NSView * headerview;

- (void)selectedHeaders:(NSNotification *)aNotification;

@end
