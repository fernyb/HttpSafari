//
//  LoadProgressMonitor+HttpSafariPluginWebResourceLoadDelegate.m
//  HttpSafari
//
//  Created by fernyb on 6/20/10.
//  Copyright 2010 Fernando Barajas. All rights reserved.
//

#import <objc/objc-class.h>
#import <WebKit/WebKit.h>
#import "LoadProgressMonitor+HttpSafariPluginWebResourceLoadDelegate.h"
#import "NSString+DateFormat.h"
#import "AnalyzeWindowController.h"
#import "HttpSafariManager.h"
#import "HttpSafariRequestItem.h"


@implementation NSObject (HttpSafariPluginWebResourceLoadDelegate)


// - (void)webView:(WebView *)senderdidStartProvisionalLoadForFrame:(WebFrame *)frame

- (NSURLRequest *)httpSafari_webView:(WebView *)sender resource:(id)identifier willSendRequest:(NSURLRequest *)request redirectResponse:(NSURLResponse *)redirectResponse fromDataSource:(WebDataSource *)dataSource
{
  NSURLRequest * res = [self httpSafari_webView:sender resource:identifier willSendRequest:request redirectResponse:redirectResponse fromDataSource:dataSource];
  if(res && [[HttpSafariManager sharedInstance] isWindowOpen]) {
//    NSMutableArray * items = [[NSMutableArray alloc] init];
//    NSDictionary * headers = [[res allHTTPHeaderFields] copy];
//    [items addObject:headers];
//    
//    NSString * data = [[NSString alloc] initWithData:[request HTTPBody] encoding:NSUTF8StringEncoding];
//    [items addObject:data];
//    
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"kHttpSafariWillSendRequest" object:items];
//    [data autorelease]; 
//    [headers autorelease];
//    [items autorelease];
  }
  
  return res;
}


- (void)httpSafari_webView:(WebView *)sender resource:(id)identifier didFinishLoadingFromDataSource:(WebDataSource *)dataSource
{    
  [self httpSafari_webView:sender resource:identifier didFinishLoadingFromDataSource:dataSource];

  if( [[HttpSafariManager sharedInstance] isWindowOpen] ) {      
    NSHTTPURLResponse * res = (NSHTTPURLResponse *)[dataSource response];
    
    if([res respondsToSelector:@selector(allHeaderFields)]) {
      WebResource * source = [dataSource subresourceForURL:[identifier URL]];   
      
      NSString * mimetype;
      if(source) {
        mimetype = [source MIMEType];
      } else {
        mimetype = [[dataSource response] MIMEType];
      }
      
      NSString * dateString = [NSString date];
      NSString * url = [[identifier URL] absoluteString];
      
      HttpSafariRequestItem * item = [[HttpSafariRequestItem alloc] init];
      [item setRequestTime:dateString];
      [item setMethod:[[dataSource request] HTTPMethod]];
      [item setUrl:url];
      [item setContentType:mimetype];
      
      [[HttpSafariManager sharedInstance] addRequest:item];
      [[HttpSafariManager sharedInstance] addResource:source];
      
      [item release];
      [[NSNotificationCenter defaultCenter] postNotificationName:@"httpSafariShowRequest" object:nil];
    }
  }
}


- (void)httpSafari_webView:(WebView *)sender resource:(id)identifier didReceiveResponse:(NSURLResponse *)response fromDataSource:(WebDataSource *)dataSource
{
  [self httpSafari_webView:sender resource:identifier didReceiveResponse:response fromDataSource:dataSource];
}


@end
