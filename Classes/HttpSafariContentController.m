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
  [textview setEditable:NO];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showRequestData:) name:@"kHttpSafariShowRequestData" object:nil]; 
}

- (void)showRequestData:(NSNotification *)aNotification
{
  if([aNotification object]) {
    // [aNotification object]
    [textview setString:@"Display DATA"];
  } else {
    [textview setString:@""];
  }
}

- (void)dealloc
{
  [textview release];
  [contentview release];
  [super dealloc];
}

@end
