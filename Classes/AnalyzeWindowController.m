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
  }
}


- (void)setRequestHeaders:(NSDictionary *)headers
{
 if(currentRequestHeaders) {
   [currentRequestHeaders release], currentRequestHeaders = nil;
 }
  currentRequestHeaders = [headers copy];
}

- (void)logRequest:(NSMutableArray *)request
{
  [request addObject:currentRequestHeaders];
  
  [list addObject:request];
  [table reloadData];
 
  //  NSLog(@"Header Fields: %@", [request allHTTPHeaderFields]);
  //  NSLog(@"Handle Cookies? %@", [request HTTPShouldHandleCookies] ? @"YES" : @"NO");
  //  NSLog(@"Http Method: %@", [request HTTPMethod]);
  //  for(NSHTTPCookie * cookie in [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]) 
  //	{
  //		NSLog(@"%@", [cookie domain]);
  //	}
  //  NSLog(@"------------");
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
  NSDictionary * response = [[list objectAtIndex:[aTable selectedRow]] objectAtIndex:1];
  NSDictionary * request = [[list objectAtIndex:[aTable selectedRow]] objectAtIndex:2];
  
  [[NSNotificationCenter defaultCenter] postNotificationName:@"kHttpSafariShowRequestHeaders" object:request];
  [[NSNotificationCenter defaultCenter] postNotificationName:@"kHttpSafariShowResponseHeaders" object:response];
}


- (void)dealloc
{
  [currentRequestHeaders release], currentRequestHeaders = nil;
  [cookiesController release];
  [headerviewController release];
  [list release];
  [super dealloc];
}


@end
