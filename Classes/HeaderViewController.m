//
//  HeaderViewController.m
//  HttpSafari
//
//  Created by fernyb on 6/24/10.
//  Copyright 2010 Fernando Barajas. All rights reserved.
//

#import "HeaderViewController.h"


@implementation HeaderViewController
@synthesize headerview;

- (id) init
{
  self = [super init];
  if (self != nil) {
    [NSBundle loadNibNamed:@"HeaderView" owner:self];
  }
  return self;
}


- (void)awakeFromNib
{
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectedHeaders:) name:@"kHttpSafariShowRequestHeaders" object:nil];
  
  // ----
}

- (void)selectedHeaders:(NSNotification *)aNotification
{
  NSDictionary * headers = [aNotification object];
  for(NSString * aKey in [headers allKeys]) {
    NSLog(@"%@ => %@", aKey, [headers objectForKey:aKey]);
  }
}


@end
