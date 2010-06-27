//
//  QueryViewController.h
//  HttpSafari
//
//  Created by fernyb on 6/27/10.
//  Copyright 2010 Fernando Barajas. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface QueryViewController : NSObject {
  IBOutlet NSView * queryview;
}
@property(readonly, getter=view) NSView * queryview;



@end
