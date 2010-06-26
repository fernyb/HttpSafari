//
//  AnalyzeWindowController.m
//  HttpSafari
//
//  Created by fernyb on 6/21/10.
//  Copyright 2010 Fernando Barajas. All rights reserved.
//

#import "AnalyzeWindowController.h"
#import "HeaderViewController.h"


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
  if([[tab identifier] isEqualToString:@"headers"]) {
    
    if(!headerviewController) {
      headerviewController = [[HeaderViewController alloc] init];
    }
    
    [tab setView:[headerviewController headerview]];
  }
}


- (void)logRequest:(NSArray *)request
{
 // NSDictionary * req = [request objectAtIndex:0];
//  NSDictionary * other = [request objectAtIndex:1];
  
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
  NSDictionary * reqeust = [[list objectAtIndex:[aTable selectedRow]] objectAtIndex:1];
 
  [[NSNotificationCenter defaultCenter] postNotificationName:@"kHttpSafariShowRequestHeaders" object:reqeust];
}


- (void)dealloc
{
  [headerviewController release];
  [list release];
  [super dealloc];
}


@end
