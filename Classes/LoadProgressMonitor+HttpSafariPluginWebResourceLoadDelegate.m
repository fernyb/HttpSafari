//
//  LoadProgressMonitor+HttpSafariPluginWebResourceLoadDelegate.m
//  HttpSafari
//
//  Created by fernyb on 6/20/10.
//  Copyright 2010 Fernando Barajas. All rights reserved.
//

#import <WebKit/WebKit.h>
#import "LoadProgressMonitor+HttpSafariPluginWebResourceLoadDelegate.h"
#import "AnalyzeWindowController.h"


@implementation NSObject (HttpSafariPluginWebResourceLoadDelegate)

- (NSURLRequest *)httpSafari_webView:(WebView *)sender resource:(id)identifier willSendRequest:(NSURLRequest *)request redirectResponse:(NSURLResponse *)redirectResponse fromDataSource:(WebDataSource *)dataSource
{
  NSURLRequest * res = [self httpSafari_webView:sender resource:identifier willSendRequest:request redirectResponse:redirectResponse fromDataSource:dataSource];
  if(res) {
    NSDictionary * headers = [[res allHTTPHeaderFields] copy];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"kHttpSafariWillSendRequest" object:headers];
    [headers autorelease];
  }
  
  return res;
}


- (void)httpSafari_webView:(WebView *)sender resource:(id)identifier didFinishLoadingFromDataSource:(WebDataSource *)dataSource
{  
  return [self httpSafari_webView:sender resource:identifier didFinishLoadingFromDataSource:dataSource];
}


- (void)httpSafari_webView:(WebView *)sender resource:(id)identifier didReceiveResponse:(NSURLResponse *)response fromDataSource:(WebDataSource *)dataSource
{
  NSHTTPURLResponse * res = (NSHTTPURLResponse *)response;
 
  if([res respondsToSelector:@selector(allHeaderFields)]) {
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:MM:SS"];
    
    NSString * dateString = [formatter stringFromDate:[NSDate date]];
    [formatter release];
    
    NSDictionary * responseHeaders = [res allHeaderFields];
    NSString * method = [[dataSource request] HTTPMethod];
    NSString * url    = [[identifier URL] absoluteString];
    NSString * type   = [response MIMEType];
    
    NSDictionary * tableItem = [[NSDictionary alloc] initWithObjects:[NSArray arrayWithObjects:dateString, method, url, type, nil] 
                                                        forKeys:[AnalyzeWindowController tableColumnKeys]];
    
    NSMutableArray * items = [[NSMutableArray alloc] init];
    [items addObject:tableItem];
    [items addObject:responseHeaders];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"kHttpSafariDidFinishLoadingResource" object:items];
    
    [items autorelease];
    [tableItem autorelease];
  }
 
  [self httpSafari_webView:sender resource:identifier didReceiveResponse:response fromDataSource:dataSource];
}


@end
