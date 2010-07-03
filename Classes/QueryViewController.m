//
//  QueryViewController.m
//  HttpSafari
//
//  Created by fernyb on 6/27/10.
//  Copyright 2010 Fernando Barajas. All rights reserved.
//

#import "QueryViewController.h"
#import "NSString+URIQuery.h"
#import "HttpSafariQueryParam.h"


@implementation QueryViewController
@synthesize queryview;

- (id) init
{
  self = [super init];
  if (self != nil) {
    [NSBundle loadNibNamed:@"QueryView" owner:self];
    queryParams = [[NSMutableArray alloc] init];
  }
  return self;
}

- (void)awakeFromNib
{
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showQueryParams:) name:@"kHttpSafariViewQuery" object:nil];
}

- (void)showQueryParams:(NSNotification *)aNotification
{
  [[queryParamsArrayController content] removeAllObjects];
  [queryParams removeAllObjects];
 
  NSDictionary * params = [aNotification object];
  for(NSString * k in params) {
    HttpSafariQueryParam * param = [[HttpSafariQueryParam alloc] init];
    [param setName:k];
    [param setValue:[params objectForKey:k]];
    
    [queryParams addObject:param];
    [param release];
  }
  
  [queryParamsArrayController setContent:queryParams];
}

- (void) dealloc
{
  [queryParams release];
  [queryParamsArrayController release];
  [queryview release];
  [super dealloc];
}


@end
