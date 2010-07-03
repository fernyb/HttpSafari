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
#import "NSString+URIQuery.h"
#import "AnalyzeWindowController.h"
#import "HttpSafariManager.h"
#import "HttpSafariRequestItem.h"


@implementation NSObject (HttpSafariPluginWebResourceLoadDelegate)


- (NSURLRequest *)httpSafari_webView:(WebView *)sender resource:(id)identifier willSendRequest:(NSURLRequest *)request redirectResponse:(NSURLResponse *)redirectResponse fromDataSource:(WebDataSource *)dataSource
{
  NSURLRequest * req = [self httpSafari_webView:sender resource:identifier willSendRequest:request redirectResponse:redirectResponse fromDataSource:dataSource];
  if(req && [[HttpSafariManager sharedInstance] isWindowOpen]) {
    if([[[identifier URL] absoluteString] isEqualToString:@"about:blank"] == NO) {
    //
    // TODO: Display the POST Requests
    //
      
    NSData * postdata = [req HTTPBody];
    NSString * postd = [[NSString alloc] initWithData:postdata encoding:NSUTF8StringEncoding];
    NSLog(@"%@", [identifier URL]);
    [postd release];
    
    [[HttpSafariManager sharedInstance] addPostData:postdata];
    }
  }
  
  return req;
}


- (void)httpSafari_webView:(WebView *)sender resource:(id)identifier didFinishLoadingFromDataSource:(WebDataSource *)dataSource
{    
  [self httpSafari_webView:sender resource:identifier didFinishLoadingFromDataSource:dataSource];

  if( [[HttpSafariManager sharedInstance] isWindowOpen] ) {      
    NSHTTPURLResponse * res = (NSHTTPURLResponse *)[dataSource response];
    
    if([res respondsToSelector:@selector(allHeaderFields)]) {
      NSMutableURLRequest * req = [dataSource request];
      
      WebResource * source = [dataSource subresourceForURL:[identifier URL]];   
      NSString * dateString = [NSString date];
      NSString * url = [[identifier URL] absoluteString];
      
      NSString * mimetype;
      NSData * resourceData;
      if(source) {
        resourceData = [source data];
        mimetype = [source MIMEType];
      } else {
        resourceData = [dataSource data];
        mimetype = [[dataSource response] MIMEType];
      }
      
      HttpSafariRequestItem * item = [[HttpSafariRequestItem alloc] init];
      [item setRequestTime:dateString];
      [item setMethod:[[dataSource request] HTTPMethod]];
      [item setUrl:url];
      [item setContentType:mimetype];
     
      [[HttpSafariManager sharedInstance] addRequest:item];
      [[HttpSafariManager sharedInstance] addResource:source];
      [[HttpSafariManager sharedInstance] addRequestHeaders:[req allHTTPHeaderFields]];
      [[HttpSafariManager sharedInstance] addResponseHeaders:[res allHeaderFields]];
      [[HttpSafariManager sharedInstance] addResourceData:resourceData];
     
      NSArray * resCookies = [NSHTTPCookie cookiesWithResponseHeaderFields:[res allHeaderFields] forURL:[identifier URL]];
      [[HttpSafariManager sharedInstance] addResponseCookies:resCookies];
      
      NSArray * reqCookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL:[identifier URL]];
      [[HttpSafariManager sharedInstance] addRequestCookies:reqCookies];
      
      NSDictionary * params = [[[identifier URL] absoluteString] toParams];
      [[HttpSafariManager sharedInstance] addParams:params];
      
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
