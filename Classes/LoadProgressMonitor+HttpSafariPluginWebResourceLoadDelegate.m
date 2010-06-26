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
  //[[NSNotificationCenter defaultCenter] postNotificationName:@"kHttpSafariWillSendRequest" object:request];
 return [self httpSafari_webView:sender resource:identifier willSendRequest:request redirectResponse:redirectResponse fromDataSource:dataSource];
}


- (void)httpSafari_webView:(WebView *)sender resource:(id)identifier didFinishLoadingFromDataSource:(WebDataSource *)dataSource
{
  if([[identifier className] isEqualToString:@"ResourceProgressEntry"]) {
//    NSLog(@"Status Code: %lu", [identifier statusCode]);
    
    NSMutableURLRequest * request = [dataSource request];
    NSURLResponse * response = [dataSource response];
       
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:MM:SS"];
    
    NSString * dateString = [formatter stringFromDate:[NSDate date]];
    [formatter release];
   
    NSMutableDictionary * requestHeaders = [[NSMutableDictionary dictionaryWithDictionary:[request allHTTPHeaderFields]] retain];
    [requestHeaders setValue:[[request URL] host] forKey:@"Host"];
    [requestHeaders setValue:[request HTTPMethod] forKey:@"Method"];
    
    
    NSString * method      = [request HTTPMethod];
    NSString * url         = [[identifier URL] absoluteString];
    NSString * type        = [response MIMEType];
   
    NSDictionary * item = [[NSDictionary alloc] initWithObjects:[NSArray arrayWithObjects:dateString, method, url, type, nil] 
                                                        forKeys:[AnalyzeWindowController tableColumnKeys]];
    
    NSArray * items = [[NSArray alloc] initWithObjects:item, requestHeaders, nil];
   
    [[NSNotificationCenter defaultCenter] postNotificationName:@"kHttpSafariDidFinishLoadingResource" object:items];
    
    //[items release];
    //[item release];
    //[requestHeaders release];
  }
  
  return [self httpSafari_webView:sender resource:identifier didFinishLoadingFromDataSource:dataSource];
}

@end
