//
//  CookieViewController.m
//  HttpSafari
//
//  Created by fernyb on 6/26/10.
//  Copyright 2010 Fernando Barajas. All rights reserved.
//

#import "CookieViewController.h"


@implementation CookieViewController
@synthesize cookieview;

- (id) init
{
  self = [super init];
  if (self != nil) {
    [NSBundle loadNibNamed:@"CookieView" owner:self];
    cookiesReceived = [[NSMutableArray alloc] init];
    cookiesSent = [[NSMutableArray alloc] init];
  }
  return self;
}

- (void)awakeFromNib
{
  NSLog(@"Cookie View Ready!");
}

- (void)dealloc
{
  [cookiesReceived release];
  [cookiesSent release];
  [cookieview release];
  [receivedCookiesTable release];
  [sentCookiesTable release];
  [cookiesSentArrayController release];
  [super dealloc];
}


@end
