//
//  NSString+DateFormat.m
//  HttpSafari
//
//  Created by fernyb on 7/2/10.
//  Copyright 2010 Fernando Barajas. All rights reserved.
//

#import "NSString+DateFormat.h"


@implementation NSString (DateFormat)

+ (NSString *)date
{
  NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
  [formatter setDateFormat:@"HH:MM:SS"];
  
  NSString * dateString = [formatter stringFromDate:[NSDate date]];
  [formatter release];
  
  return dateString;
}

@end
