//
//  AnalyzeWindowController.m
//  HttpSafari
//
//  Created by fernyb on 6/21/10.
//  Copyright 2010 Fernando Barajas. All rights reserved.
//

#import "AnalyzeWindowController.h"
#import "HeaderViewController.h"
#import "CookieViewController.h"
#import "QueryViewController.h"
#import "HttpSafariPostDataController.h"


@implementation AnalyzeWindowController

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
  [tabview setDelegate:self];
  
  list = [[NSMutableArray alloc] init];
  
  [table setDataSource:self];
  [table setDelegate:self];
  [table setTarget:self];
  [table setAction:@selector(rowClicked:)];
  [table reloadData];
}

- (void)showWindow:(id)sender
{
  [[self window] makeKeyAndOrderFront:sender];
  
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
    }
    [tabViewItem setView:[headerviewController view]];
  }
  
  if([[tabViewItem identifier] isEqualToString:@"cookies"]) {
    if(!cookiesController) {
      cookiesController = [[CookieViewController alloc] init];
    }
    [tabViewItem setView:[cookiesController view]];
    if(currentItem) {
      [[NSNotificationCenter defaultCenter] postNotificationName:@"kHttpSafariRequestwCookies" object:[currentItem objectAtIndex:0]];
      [[NSNotificationCenter defaultCenter] postNotificationName:@"kHttpSafariResponseCookies" object:currentItem];
    }
  } // end cookies tab
  
  if([[tabViewItem identifier] isEqualToString:@"query"]) {
    if(!queryController) {
      queryController = [[QueryViewController alloc] init];
    }
    [tabViewItem setView:[queryController view]];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"kHttpSafariViewQuery" object:currentItem];
  }
  
  if([[tabViewItem identifier] isEqualToString:@"postdata"]) {
    if(!postdataController) {
      postdataController = [[HttpSafariPostDataController alloc] init];
    }
    [tabViewItem setView:[postdataController view]];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"kHttpSafariPostData" object:currentPostData];
  }
}


- (void)setRequestHeaders:(NSDictionary *)headers
{
 if(currentRequestHeaders) {
   [currentRequestHeaders release], currentRequestHeaders = nil;
 }
  currentRequestHeaders = [headers copy];
}

- (void)setPostData:(NSString *)data
{
  if(postdata) {
    [postdata release], postdata = nil;
  }
  if(!postDataList) {
    postDataList = [[NSMutableArray alloc] init];
  }
  postdata = [data copy];
  [postDataList addObject:postdata];
}

- (void)logRequest:(NSMutableArray *)request
{
  [request addObject:currentRequestHeaders];
  [request addObject:postdata];
  
  [list addObject:request];
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
  NSDictionary * item = [[list objectAtIndex:rowIndex] objectAtIndex:0];
  return [item objectForKey:[aTableColumn identifier]]; 
}

- (void)rowClicked:(NSTableView *)aTable
{
  if(currentItem) {
    [currentItem release], currentItem = nil;
  }
  if(currentPostData) {
    [currentPostData release], currentPostData = nil;
  }
  currentItem = [[list objectAtIndex:[aTable selectedRow]] retain];
  currentPostData = [[postDataList objectAtIndex:([aTable selectedRow] + 1)] retain];
  
  NSDictionary * response = [currentItem objectAtIndex:1];
  NSDictionary * request  = [currentItem objectAtIndex:2];
  
  [[NSNotificationCenter defaultCenter] postNotificationName:@"kHttpSafariShowRequestHeaders" object:request];
  [[NSNotificationCenter defaultCenter] postNotificationName:@"kHttpSafariShowResponseHeaders" object:response];
  [[NSNotificationCenter defaultCenter] postNotificationName:@"kHttpSafariRequestwCookies" object:[currentItem objectAtIndex:0]];
  [[NSNotificationCenter defaultCenter] postNotificationName:@"kHttpSafariResponseCookies" object:currentItem];
  [[NSNotificationCenter defaultCenter] postNotificationName:@"kHttpSafariViewQuery" object:currentItem];
  [[NSNotificationCenter defaultCenter] postNotificationName:@"kHttpSafariPostData" object:currentPostData];
}


- (void)dealloc
{
  [currentRequestHeaders release], currentRequestHeaders = nil;
  [cookiesController release];
  [headerviewController release];
  [queryController release];
  [currentItem release];
  [list release];
  [postDataList release];
  [super dealloc];
}


@end
