//
//  LoadProgressMonitor+HttpSafariPluginWebResourceLoadDelegate.m
//  HttpSafari
//
//  Created by fernyb on 6/20/10.
//  Copyright 2010 Fernando Barajas. All rights reserved.
//

#import <WebKit/WebKit.h>
#import "LoadProgressMonitor+HttpSafariPluginWebResourceLoadDelegate.h"


@implementation NSObject (HttpSafariPluginWebResourceLoadDelegate)

- (NSURLRequest *)httpSafari_webView:(WebView *)sender resource:(id)identifier willSendRequest:(NSURLRequest *)request redirectResponse:(NSURLResponse *)redirectResponse fromDataSource:(WebDataSource *)dataSource
{
  [[NSNotificationCenter defaultCenter] postNotificationName:@"kHttpSafariWillSendRequest" object:request];
 return [self httpSafari_webView:sender resource:identifier willSendRequest:request redirectResponse:redirectResponse fromDataSource:dataSource];
}


- (void)httpSafari_webView:(WebView *)sender resource:(id)identifier didFinishLoadingFromDataSource:(WebDataSource *)dataSource
{
  if([[identifier className] isEqualToString:@"ResourceProgressEntry"]) {
    NSURL * url = [identifier URL];
    NSLog(@"URL: %@", [url absoluteString]);
    NSLog(@"Status Code: %lu", [identifier statusCode]);
    
    NSMutableURLRequest * request = [dataSource request];
    NSLog(@"HTTP Method: %@", [request HTTPMethod]);
    NSLog(@"Request Headers: %@", [request allHTTPHeaderFields]);
    
    NSURLResponse * response = [dataSource response];
    NSLog(@"Response Mime Type: %@", [response MIMEType]);
    
    NSLog(@"------------------");
  }
  
  return [self httpSafari_webView:sender resource:identifier didFinishLoadingFromDataSource:dataSource];
}

@end
