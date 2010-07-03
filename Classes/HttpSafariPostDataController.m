//
//  HttpSafariPostDataController.m
//  HttpSafari
//
//  Created by fernyb on 6/28/10.
//  Copyright 2010 Fernando Barajas. All rights reserved.
//

#import "HttpSafariPostDataController.h"
#import "HttpSafariQueryParam.h"
#import "NSString+URIQuery.h"


@implementation HttpSafariPostDataController
@synthesize dataview;

- (id)init
{
  self = [super init];
  if (self != nil) {
    [NSBundle loadNibNamed:@"PostDataView" owner:self];
    formdata = [[NSMutableArray alloc] init];
  }
  return self;
}

- (void)awakeFromNib
{
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showPostData:) name:@"kHttpSafariPostData" object:nil];
}

- (void)showPostData:(NSNotification *)aNotfication
{
  [[formdataArrayController content] removeAllObjects];
  [formdata removeAllObjects];
  
  if([[aNotfication object] bytes] <= 0) {
    return;
  }
  
  NSString * qstring = [NSString stringWithFormat:@"?%@", [NSString stringWithCString:[[aNotfication object] bytes] encoding:NSASCIIStringEncoding]];

  NSDictionary * params = [qstring toParams];
  
  for(NSString * k in [params allKeys]) {
    HttpSafariQueryParam * param = [[HttpSafariQueryParam alloc] init];
    [param setName:k];
    [param setValue:[params objectForKey:k]];
    [formdata addObject:param];
    [param release];
  }
  
  [formdataArrayController setContent:formdata];
}

- (void) dealloc
{
  [formdata release];
  [formdataArrayController release];
  [dataview release];
  [super dealloc];
}


@end
