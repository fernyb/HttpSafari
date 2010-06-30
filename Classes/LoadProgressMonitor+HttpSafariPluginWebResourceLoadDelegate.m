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
#import "HttpSafariManager.h"


@implementation NSObject (HttpSafariPluginWebResourceLoadDelegate)

- (NSURLRequest *)httpSafari_webView:(WebView *)sender resource:(id)identifier willSendRequest:(NSURLRequest *)request redirectResponse:(NSURLResponse *)redirectResponse fromDataSource:(WebDataSource *)dataSource
{
  NSURLRequest * res = [self httpSafari_webView:sender resource:identifier willSendRequest:request redirectResponse:redirectResponse fromDataSource:dataSource];
  if(res && [[HttpSafariManager sharedInstance] isWindowOpen]) {
    NSMutableArray * items = [[NSMutableArray alloc] init];
    NSDictionary * headers = [[res allHTTPHeaderFields] copy];
    [items addObject:headers];
    
    NSString * data = [[NSString alloc] initWithData:[request HTTPBody] encoding:NSUTF8StringEncoding];
    [items addObject:data];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"kHttpSafariWillSendRequest" object:items];
    [data autorelease]; 
    [headers autorelease];
    [items autorelease];
  }
  
  return res;
}


- (void)httpSafari_webView:(WebView *)sender resource:(id)identifier didFinishLoadingFromDataSource:(WebDataSource *)dataSource
{  
  return [self httpSafari_webView:sender resource:identifier didFinishLoadingFromDataSource:dataSource];
}


- (void)httpSafari_webView:(WebView *)sender resource:(id)identifier didReceiveResponse:(NSURLResponse *)response fromDataSource:(WebDataSource *)dataSource
{
  if( [[HttpSafariManager sharedInstance] isWindowOpen] ) {      
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
      
      NSString * content = [[NSString alloc] initWithData:[dataSource data] encoding:NSUTF8StringEncoding];
                          
      NSMutableArray * items = [[NSMutableArray alloc] init];
      [items addObject:tableItem];
      [items addObject:responseHeaders];
      [items addObject:content];
      
      [[NSNotificationCenter defaultCenter] postNotificationName:@"kHttpSafariDidFinishLoadingResource" object:items];
      
      [content release];
      [items autorelease];
      [tableItem autorelease];
    }
  }
  [self httpSafari_webView:sender resource:identifier didReceiveResponse:response fromDataSource:dataSource];
}


@end
