//
//  HttpSafariRequestItem.m
//  HttpSafari
//
//  Created by fernyb on 7/1/10.
//  Copyright 2010 Fernando Barajas. All rights reserved.
//

#import "HttpSafariRequestItem.h"


@implementation HttpSafariRequestItem
@synthesize requestTime;
@synthesize method;
@synthesize url;
@synthesize contentType;


- (void)dealloc
{
  [requestTime release];
  [method release];
  [url release];
  [contentType release];
  [super dealloc];
}


@end
