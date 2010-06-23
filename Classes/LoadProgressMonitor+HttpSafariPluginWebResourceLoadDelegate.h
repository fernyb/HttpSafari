//
//  LoadProgressMonitor+HttpSafariPluginWebResourceLoadDelegate.h
//  HttpSafari
//
//  Created by fernyb on 6/20/10.
//  Copyright 2010 Fernando Barajas. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Safari.h"


@interface NSObject (HttpSafariPluginWebResourceLoadDelegate)

- (NSURLRequest *)httpSafari_webView:(WebView *)sender resource:(id)identifier willSendRequest:(NSURLRequest *)request redirectResponse:(NSURLResponse *)redirectResponse fromDataSource:(WebDataSource *)dataSource;
- (void)httpSafari_webView:(WebView *)sender resource:(id)identifier didFinishLoadingFromDataSource:(WebDataSource *)dataSource;

@end
