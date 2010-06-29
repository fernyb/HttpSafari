//
//  HttpSafariContentController.m
//  HttpSafari
//
//  Created by fernyb on 6/29/10.
//  Copyright 2010 Fernando Barajas. All rights reserved.
//

#import "HttpSafariContentController.h"


@implementation HttpSafariContentController
@synthesize contentview;

- (id)init
{
  self = [super init];
  if (self != nil) {
    [NSBundle loadNibNamed:@"ContentView" owner:self];
  }
  return self;
}

- (void)awakeFromNib
{
  
}

- (void)dealloc
{
  [textview release];
  [contentview release];
  [super dealloc];
}

@end
