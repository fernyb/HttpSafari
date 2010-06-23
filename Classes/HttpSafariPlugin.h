//
//  HttpSafariPlugin.h
//  HttpSafari
//
//  Created by fernyb on 6/19/10.
//  Copyright 2010 Fernando Barajas. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class AnalyzeWindowController;


@interface HttpSafariPlugin : NSObject {
  AnalyzeWindowController * analyzeWindow;
}

+ (HttpSafariPlugin *)sharedInstance;
- (void)swizzle;
- (void)installMenu;
- (void)_openWindow:(id)sender;
- (void)httpSafariWillSendRequest:(NSNotification *)aNotification;
- (void)httpSafariDidFinishLoadingResource:(NSNotification *)aNotification;

@end
