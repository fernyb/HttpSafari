//
//  HttpSafariPlugin.m
//  HttpSafari
//
//  Created by fernyb on 6/19/10.
//  Copyright 2010 Fernando Barajas. All rights reserved.
//

#import <objc/objc-class.h>

#import "HttpSafariPlugin.h"
#import "LoadProgressMonitor+HttpSafariPluginWebResourceLoadDelegate.h"
#import "NSObject+HttpSafariPluginSwizzle.h"



@implementation HttpSafariPlugin
/**
 * A special method called by SIMBL once the application has
 * started and all classes are initialized
 */
+ (void)load
{
  HttpSafariPlugin * thePlugin = [[self class] sharedInstance];
  [thePlugin swizzle];
}


+ (HttpSafariPlugin *)sharedInstance
{
  static HttpSafariPlugin * plugin = nil;
  if(plugin == nil) {
    plugin = [[HttpSafariPlugin alloc] init];
  }
  return plugin;
}


- (void)swizzle
{   
  BOOL methodAdded = [self swizzleClass:NSClassFromString(@"LoadProgressMonitor") 
 targetSelector:@selector(webView:resource:willSendRequest:redirectResponse:fromDataSource:) 
   withSelector:@selector(httpSafari_webView:resource:willSendRequest:redirectResponse:fromDataSource:)];
  
  if (methodAdded) {
    NSLog(@"LoadProgressMonitor now has new method");
  }
  
  /*
  [self swizzleClass:NSClassFromString(@"LoadProgressMonitor") 
      targetSelector:@selector(webView:resource:didFinishLoadingFromDataSource:)
        withSelector:@selector(httpSafari_webView:resource:didFinishLoadingFromDataSource:)];
  */
//  [self swizzleClass:NSClassFromString(@"WebView") 
//      targetSelector:@selector(setResourceLoadDelegate:) 
//        withSelector:@selector(httpSafari_setResourceLoadDelegate:)];

}


@end
