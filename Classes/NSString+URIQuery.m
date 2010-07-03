//
//  NSString+URIQuery.m
//  HttpSafari
//
//  Created by fernyb on 6/27/10.
//  Copyright 2010 Fernando Barajas. All rights reserved.
//

#import "NSString+URIQuery.h"


@implementation NSString (URIQuery)

- (NSDictionary *)toParams
{
  NSArray * parts = [self componentsSeparatedByString:@"?"];
  if([parts count] != 2) {
    return [NSDictionary dictionary];
  }
  
  NSString * qstring = [parts objectAtIndex:1];
  
  NSCharacterSet * delimeters = [NSCharacterSet characterSetWithCharactersInString:@"&"];
  NSMutableDictionary * params = [NSMutableDictionary dictionary];
  NSScanner * scanner = [[NSScanner alloc] initWithString:qstring];
  
  while (![scanner isAtEnd]) {
    NSString * param;
    [scanner scanUpToCharactersFromSet:delimeters intoString:&param];
    [scanner scanCharactersFromSet:delimeters intoString:NULL];
    
    NSArray * pair = [param componentsSeparatedByString:@"="];
    if([pair count] == 2) {
      NSString * k = [[pair objectAtIndex:0] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
      NSString * v = [[pair objectAtIndex:1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
      [params setObject:v forKey:k];
    }
  }
  [scanner release];
  
  return params;
}


@end

