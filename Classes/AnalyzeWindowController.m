//
//  AnalyzeWindowController.m
//  HttpSafari
//
//  Created by fernyb on 6/21/10.
//  Copyright 2010 Fernando Barajas. All rights reserved.
//

#import <WebKit/WebKit.h>
#import "AnalyzeWindowController.h"
#import "HttpSafariManager.h"
#import "HeaderViewController.h"
#import "CookieViewController.h"
#import "QueryViewController.h"
#import "HttpSafariPostDataController.h"
#import "HttpSafariContentController.h"


@implementation AnalyzeWindowController
@synthesize dataResource;

- (id) init
{
  self = [super initWithWindowNibName:@"Analyze" owner:self];
  if (self != nil) {
    [self showWindow:self];
  }
  return self;
}

- (void)awakeFromNib
{
  [[self window] setDelegate:self];
  
  [tabview setDelegate:self];
  
  list = [[NSMutableArray alloc] init];
  
  [table setDataSource:self];
  [table setDelegate:self];
  [table setTarget:self];
  [table setAction:@selector(rowClicked:)];
  [table reloadData];
  
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(webViewDidLoad:) name:WebViewProgressFinishedNotification object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(httpSafariShowRequest:) name:@"httpSafariShowRequest" object:nil];
}

- (void)webViewDidLoad:(NSNotification *)aNotification
{
  NSLog(@"Web View Did Load");
}


- (void)showWindow:(id)sender
{
  [[self window] makeKeyAndOrderFront:sender];
  [[HttpSafariManager sharedInstance] setIsWindowOpen:YES];
  
  NSTabViewItem * tab = [tabview selectedTabViewItem];
  [self setTabViewIfNeeded:tab];
}


- (void)tabView:(NSTabView *)tabView willSelectTabViewItem:(NSTabViewItem *)tabViewItem
{
  [self setTabViewIfNeeded:tabViewItem];
}


- (void)setTabViewIfNeeded:(NSTabViewItem *)tabViewItem
{
  if([[tabViewItem identifier] isEqualToString:@"headers"]) {
    if(!headerviewController) {
      headerviewController = [[HeaderViewController alloc] init];
      [tabViewItem setView:[headerviewController view]];
    }
    if(currentRequestHeaders) {
      [[NSNotificationCenter defaultCenter] postNotificationName:@"kHttpSafariShowRequestHeaders" object:currentRequestHeaders];
    }
    if(currentResponseHeaders) {
      [[NSNotificationCenter defaultCenter] postNotificationName:@"kHttpSafariShowResponseHeaders" object:currentResponseHeaders];
    }
  }
  
  if([[tabViewItem identifier] isEqualToString:@"cookies"]) {
    if(!cookiesController) {
      cookiesController = [[CookieViewController alloc] init];
      [tabViewItem setView:[cookiesController view]];
    }
    if(currentItem) {
      [[NSNotificationCenter defaultCenter] postNotificationName:@"kHttpSafariRequestCookies" object:currentRequestCookies];
      [[NSNotificationCenter defaultCenter] postNotificationName:@"kHttpSafariResponseCookies" object:currentResponseCookies];
    }
  } // end cookies tab
  
  if([[tabViewItem identifier] isEqualToString:@"query"]) {
    if(!queryController) {
      queryController = [[QueryViewController alloc] init];
      [tabViewItem setView:[queryController view]];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"kHttpSafariViewQuery" object:currentRequestParams];
  }
  
  if([[tabViewItem identifier] isEqualToString:@"postdata"]) {
    if(!postdataController) {
      postdataController = [[HttpSafariPostDataController alloc] init];
      [tabViewItem setView:[postdataController view]];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"kHttpSafariPostData" object:currentPostData];
  }
  
  if([[tabViewItem identifier] isEqualToString:@"content"]) {
    if(!contentviewController) {
      contentviewController = [[HttpSafariContentController alloc] init];
      [tabViewItem setView:[contentviewController view]];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"kHttpSafariShowRequestData" object:currentRequestData];
  }
}


- (void)setRequestHeaders:(NSDictionary *)headers
{
  if(!requestHeadersList) {
    requestHeadersList = [[NSMutableArray alloc] init];
  }
  [requestHeadersList addObject:headers];
}

- (void)setResponseHeaders:(NSDictionary *)headers
{
  if(!responseHeadersList) {
    responseHeadersList = [[NSMutableArray alloc] init];
  }
  [responseHeadersList addObject:headers];
}

- (void)setPostData:(NSString *)data
{
  if(!postDataList) {
    postDataList = [[NSMutableArray alloc] init];
  }
  [postDataList addObject:data];
}

- (void)setContent:(NSString *)content
{
 if(!contentList) {
   contentList = [[NSMutableArray alloc] init];
 }
  [contentList addObject:content];
}


- (void)httpSafariShowRequest:(NSNotification *)aNotification
{
 list = [[HttpSafariManager sharedInstance] requests];
 [table reloadData];
}


# pragma mark NSTableView Methods

+ (NSArray *)tableColumnKeys
{
  return [NSArray arrayWithObjects:@"time", @"method", @"url", @"type", nil];
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
  return [list count];
}

- (id)tableView:(NSTableView *)aTableView objectValueForTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex
{
  HttpSafariRequestItem * item = [list objectAtIndex:rowIndex];
  NSString * identifier = [aTableColumn identifier];
  
  if([identifier isEqualToString:@"time"]) {
    return [item performSelector:@selector(requestTime)];
  }
  if([identifier isEqualToString:@"method"]) {
    return [item performSelector:@selector(method)];
  }
  if([identifier isEqualToString:@"url"]) {
    return [item performSelector:@selector(url)];
  }
  if([identifier isEqualToString:@"type"]) {
    return [item performSelector:@selector(contentType)];
  }
  return @"";
}

- (void)clearCurrentItemsIfNeeded
{
  if(currentItem) [currentItem release], currentItem = nil;
  if(currentPostData) [currentPostData release], currentPostData = nil;
  if(currentContent) [currentContent release], currentContent = nil;
  if(currentRequestHeaders) [currentRequestHeaders release], currentRequestHeaders = nil;
  if(currentResponseHeaders) [currentResponseHeaders release], currentResponseHeaders = nil;
  if(currentResponseCookies) [currentResponseCookies release], currentResponseCookies = nil;
  if(currentRequestParams) [currentRequestParams release], currentRequestParams = nil;
  if(currentRequestData) [currentRequestData release], currentRequestData = nil;
}

- (void)rowClicked:(NSTableView *)aTable
{
  [self clearCurrentItemsIfNeeded];
  selectedIndex = [aTable selectedRow];
  currentItem = [[list objectAtIndex:selectedIndex] retain];
  
  currentRequestHeaders  = [[[HttpSafariManager sharedInstance] requestHeadersList] objectAtIndex:selectedIndex];
  [currentRequestHeaders retain];
  
  currentResponseHeaders = [[[HttpSafariManager sharedInstance] responseHeadersList] objectAtIndex:selectedIndex];
  [currentResponseHeaders retain];

  currentRequestData = [[[HttpSafariManager sharedInstance] resourceDataList] objectAtIndex:selectedIndex];
  [currentRequestData retain];
  
  currentResponseCookies = [[[HttpSafariManager sharedInstance] responseCookieList] objectAtIndex:selectedIndex];
  [currentResponseCookies retain];
  
  currentRequestCookies = [[[HttpSafariManager sharedInstance] requestCookieList] objectAtIndex:selectedIndex];
  [currentRequestCookies retain];
  
  currentRequestParams = [[[HttpSafariManager sharedInstance] requestParamsList] objectAtIndex:selectedIndex];
  [currentRequestParams retain];
 
  currentPostData = [[[HttpSafariManager sharedInstance] requestPostDataList] objectAtIndex:selectedIndex];
  [currentPostData retain];
  
  [[NSNotificationCenter defaultCenter] postNotificationName:@"kHttpSafariShowRequestHeaders" object:currentRequestHeaders];
  [[NSNotificationCenter defaultCenter] postNotificationName:@"kHttpSafariShowResponseHeaders" object:currentResponseHeaders];
  [[NSNotificationCenter defaultCenter] postNotificationName:@"kHttpSafariShowRequestData" object:currentRequestData];
  [[NSNotificationCenter defaultCenter] postNotificationName:@"kHttpSafariPostData" object:currentPostData];
  [[NSNotificationCenter defaultCenter] postNotificationName:@"kHttpSafariResponseCookies" object:currentResponseCookies];
  [[NSNotificationCenter defaultCenter] postNotificationName:@"kHttpSafariRequestCookies" object:currentRequestCookies];
  [[NSNotificationCenter defaultCenter] postNotificationName:@"kHttpSafariViewQuery" object:currentRequestParams];
  
}


- (void)windowWillClose:(NSNotification *)notification
{
  [[HttpSafariManager sharedInstance] setIsWindowOpen:NO];
}

- (void)dealloc
{
  [currentRequestData release];
  [currentRequestCookies release];
  [currentRequestParams release];
  [currentPostData release];
  [currentResponseCookies release];
  [currentResponseHeaders release];
  [currentRequestHeaders release];
  [cookiesController release];
  [headerviewController release];
  [queryController release];
  [postdataController release];
  [contentviewController release];
  [currentItem release];
  [list release];
  [postDataList release];
  [responseHeadersList release];
  [requestHeadersList release];
  
  [super dealloc];
}


@end
