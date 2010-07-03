//
//  CookieViewController.m
//  HttpSafari
//
//  Created by fernyb on 6/26/10.
//  Copyright 2010 Fernando Barajas. All rights reserved.
//

#import "CookieViewController.h"
#import "HttpSafariCookie.h"

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
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showRequestCookies:) name:@"kHttpSafariRequestCookies" object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showResponseCookies:) name:@"kHttpSafariResponseCookies" object:nil];
}

- (void)showRequestCookies:(NSNotification *)aNotification
{
  [[cookiesSentArrayController content] removeAllObjects];
  [cookiesSent removeAllObjects];
 
  for(NSHTTPCookie * cookie in [aNotification object]) {
    HttpSafariCookie * kookie = [[HttpSafariCookie alloc] init];
    [kookie setName:[cookie name]];
    [kookie setValue:[cookie value]];
    [kookie setPath:[cookie path]];
    [kookie setDomain:[cookie domain]];
   
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"EEEE MMMM d HH:MM:SS yyyy"];
   
    [kookie setExpires:[formatter stringFromDate:[cookie expiresDate]]];
    [formatter release];
    
    [cookiesSent addObject:kookie];
    [kookie release];
  }
  
  [cookiesSentArrayController setContent:cookiesSent];
}


- (void)showResponseCookies:(NSNotification *)aNotification
{
  [[cookiesReceivedArrayController content] removeAllObjects];
  [cookiesReceived removeAllObjects];
 
  for(NSHTTPCookie * cookie in [aNotification object]) {
    HttpSafariCookie * kookie = [[HttpSafariCookie alloc] init];
    [kookie setName:[cookie name]];
    [kookie setValue:[cookie value]];
    [kookie setPath:[cookie path]];
    [kookie setDomain:[cookie domain]];
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"EEEE MMMM d HH:MM:SS yyyy"];
    
    [kookie setExpires:[formatter stringFromDate:[cookie expiresDate]]];
    [formatter release];
    
    [cookiesReceived addObject:kookie];
    [kookie release];
  }
  
  [cookiesReceivedArrayController setContent:cookiesReceived];
}


- (void)dealloc
{
  [cookiesReceived release];
  [cookiesSent release];
  [cookieview release];
  [receivedCookiesTable release];
  [sentCookiesTable release];
  [cookiesSentArrayController release];
  [cookiesReceivedArrayController release];
  [super dealloc];
}


@end
