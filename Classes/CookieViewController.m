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
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showCookies:) name:@"kHttpSafariRequestwCookies" object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showResponseCookies:) name:@"kHttpSafariResponseCookies" object:nil];
}

- (void)showCookies:(NSNotification *)aNotification
{
  [[cookiesSentArrayController content] removeAllObjects];
  [cookiesSent removeAllObjects];
   
  NSDictionary * request = [aNotification object];
  NSArray * availableCookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL:[NSURL URLWithString:[request objectForKey:@"url"]]];
  
  for(NSHTTPCookie * cookie in availableCookies) {
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
  
  NSString * url = [[[aNotification object] objectAtIndex:0] objectForKey:@"url"];
  NSDictionary * responseHeaders = [[aNotification object] objectAtIndex:1];

  NSArray * cookies = [NSHTTPCookie cookiesWithResponseHeaderFields:responseHeaders forURL:[NSURL URLWithString:url]];
  for(NSHTTPCookie * cookie in cookies) {
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
