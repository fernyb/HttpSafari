//
//  HttpSafariHeader.m
//  HttpSafari
//
//  Created by fernyb on 6/26/10.
//  Copyright 2010 Fernando Barajas. All rights reserved.
//

#import "HttpSafariHeader.h"


@implementation HttpSafariHeader
@synthesize name, value;

- (id) init
{
  self = [super init];
  if (self != nil) {
    name = @"Header Name";
    value = @"Header Value";
  }
  return self;
}


@end
