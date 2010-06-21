//
//  HttpSafariPlugin.h
//  HttpSafari
//
//  Created by fernyb on 6/19/10.
//  Copyright 2010 Fernando Barajas. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class WebView;
@class WebDataSource;

@interface HttpSafariPlugin : NSObject {

}

+ (HttpSafariPlugin *)sharedInstance;
- (void)swizzle;

@end
