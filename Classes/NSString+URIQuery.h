//
//  NSString+URIQuery.h
//  HttpSafari
//
//  Created by fernyb on 6/27/10.
//  Copyright 2010 Fernando Barajas. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSString (URIQuery)

- (NSDictionary *)toParams;

@end

