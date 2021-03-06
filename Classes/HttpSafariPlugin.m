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
#import "AnalyzeWindowController.h"


@implementation HttpSafariPlugin
/**
 * A special method called by SIMBL once the application has
 * started and all classes are initialized
 */
+ (void)load
{
  HttpSafariPlugin * thePlugin = [[self class] sharedInstance];
  [thePlugin swizzle];
  [thePlugin installMenu];
}


+ (HttpSafariPlugin *)sharedInstance
{
  static HttpSafariPlugin * plugin = nil;
  if(plugin == nil) {
    plugin = [[HttpSafariPlugin alloc] init];
  }
  return plugin;
}

- (id)init
{
  self = [super init];
  if (self != nil) {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(httpSafariWillSendRequest:) name:@"kHttpSafariWillSendRequest" object:nil];
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(httpSafariResources:) name:@"httpSafariDidFinishLoadingFromDataSource" object:nil];
  }
  return self;
}


- (void)swizzle
{   
  BOOL methodAdded = [self swizzleClass:NSClassFromString(@"LoadProgressMonitor") 
 targetSelector:@selector(webView:resource:willSendRequest:redirectResponse:fromDataSource:) 
   withSelector:@selector(httpSafari_webView:resource:willSendRequest:redirectResponse:fromDataSource:)];
  
  if (methodAdded) {
    NSLog(@"LoadProgressMonitor now has new method");
  }
  
  methodAdded = [self swizzleClass:NSClassFromString(@"LoadProgressMonitor") 
      targetSelector:@selector(webView:resource:didFinishLoadingFromDataSource:) 
        withSelector:@selector(httpSafari_webView:resource:didFinishLoadingFromDataSource:)];
  
  if(methodAdded) {
    NSLog(@"Method Added to LoadProgressMonitor");
  }
  
  // ---
  methodAdded = [self swizzleClass:NSClassFromString(@"LoadProgressMonitor") 
                    targetSelector:@selector(webView:resource:didReceiveResponse:fromDataSource:) 
                      withSelector:@selector(httpSafari_webView:resource:didReceiveResponse:fromDataSource:)];
  
  if(methodAdded) {
    NSLog(@"Method Added to LoadProgressMonitor");
  }
}


- (void)installMenu
{
  NSMenuItem * newItem;
  NSMenu * newMenu;
  
  newItem = [[NSMenuItem allocWithZone:[NSMenu menuZone]] initWithTitle:@"HttpSafari" action:NULL keyEquivalent:@""];
  newMenu = [[NSMenu allocWithZone:[NSMenu menuZone]] initWithTitle:@"HttpSafari"];
  [newItem setSubmenu:newMenu];
  [newMenu release];
  
  NSInteger menuItemCount = [[[NSApp mainMenu] itemArray] count] - 1;
  [[NSApp mainMenu] insertItem:newItem atIndex:menuItemCount];
  [newItem release];
  
  // Add Items to the menu
  newItem = [[NSMenuItem allocWithZone:[NSMenu menuZone]] initWithTitle:@"Open Window" action:NULL keyEquivalent:@""];
  [newItem setTarget:self];
  [newItem setAction:@selector(_openWindow:)];
  
  // Add MenuItem to the Menu
  [newMenu addItem:newItem];
  [newItem release];
}

- (void)_openWindow:(id)sender
{
  if(!analyzeWindow) {
    analyzeWindow = [[AnalyzeWindowController alloc] init];
  }
  
  if([[analyzeWindow window] isVisible] == NO) {
    [analyzeWindow showWindow:self];
  }
}


- (void)httpSafariWillSendRequest:(NSNotification *)aNotification
{
  if(analyzeWindow && [[analyzeWindow window] isVisible] == YES) {
    [analyzeWindow setRequestHeaders:[[aNotification object] objectAtIndex:0]];
   
    [analyzeWindow setPostData:[[aNotification object] objectAtIndex:1]];
  }
}

- (void)httpSafariDidFinishLoadingResource:(NSNotification *)aNotification
{
  if(analyzeWindow && [[analyzeWindow window] isVisible] == YES) {
//    NSMutableArray * items = [aNotification object];
//    NSString * content = [[items lastObject] retain];
//    [items removeLastObject];
//    
//    [analyzeWindow setResponseHeaders:[items objectAtIndex:1]];
//    [analyzeWindow logRequest:items];
//    
//    [analyzeWindow setContent:content];
//    [content release];
  }
}

- (void)httpSafariResources:(NSNotification *)aNotification
{
  if(analyzeWindow && [[analyzeWindow window] isVisible] == YES) {
    //NSMutableArray * items = [aNotification object];
    //NSDictionary * responseHeaders = [items objectAtIndex:1];
    //[analyzeWindow setDataResource:[aNotification object]];
  }
}

- (void)dealloc
{
  [analyzeWindow release];
  [super dealloc];
}


@end
