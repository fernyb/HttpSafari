//
//  QueryViewController.m
//  HttpSafari
//
//  Created by fernyb on 6/27/10.
//  Copyright 2010 Fernando Barajas. All rights reserved.
//

#import "QueryViewController.h"


@implementation QueryViewController
@synthesize queryview;

- (id) init
{
  self = [super init];
  if (self != nil) {
    [NSBundle loadNibNamed:@"QueryView" owner:self];
  }
  return self;
}

- (void)awakeFromNib
{
  NSLog(@"Query View Awake!");
}

@end
