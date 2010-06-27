//
//  HeaderViewController.m
//  HttpSafari
//
//  Created by fernyb on 6/24/10.
//  Copyright 2010 Fernando Barajas. All rights reserved.
//

#import "HeaderViewController.h"
#import "HttpSafariHeader.h"

@implementation HeaderViewController
@synthesize headerview;

- (id) init
{
  self = [super init];
  if (self != nil) {
    [NSBundle loadNibNamed:@"HeaderView" owner:self];
    responseHeaders = [[NSMutableArray alloc] init];
    requestHeaders = [[NSMutableArray alloc] init];
  }
  return self;
}


- (void)awakeFromNib
{
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showResponseHeaders:) name:@"kHttpSafariShowResponseHeaders" object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showRequestHeaders:) name:@"kHttpSafariShowRequestHeaders" object:nil];
}


- (void)showRequestHeaders:(NSNotification *)aNotification
{
  [[requestArrayController content] removeAllObjects];
  [requestHeaders removeAllObjects];
  
  NSDictionary * headers = [NSDictionary dictionaryWithDictionary:[aNotification object]];
  
  for(NSString * aKey in [headers allKeys]) {
    HttpSafariHeader * header = [[HttpSafariHeader alloc] init];
    [header setName:aKey];
    [header setValue:[headers objectForKey:aKey]];
    
    [requestHeaders addObject:header];
    [header release], header = nil;
  }
  
  [requestArrayController setContent:requestHeaders];
}


- (void)showResponseHeaders:(NSNotification *)aNotification
{
  [[responseArrayController content] removeAllObjects];
  [responseHeaders removeAllObjects];
  
  NSDictionary * headers = [NSDictionary dictionaryWithDictionary:[aNotification object]];
  
  for(NSString * aKey in [headers allKeys]) {
    HttpSafariHeader * header = [[HttpSafariHeader alloc] init];
    [header setName:aKey];
    [header setValue:[headers objectForKey:aKey]];
    
    [responseHeaders addObject:header];
    [header release], header = nil;
  }
  
  [responseArrayController setContent:responseHeaders];
}

- (void)dealloc
{
  [requestHeaders release], requestHeaders = nil;
  [responseHeaders release], responseHeaders = nil;
  [headerview release];
  [responseHeadersTable release];
  [responseArrayController release];
  [requestArrayController release];
  [super dealloc];
}


@end
