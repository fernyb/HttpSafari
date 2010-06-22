//
//  AnalyzeWindowController.m
//  HttpSafari
//
//  Created by fernyb on 6/21/10.
//  Copyright 2010 Fernando Barajas. All rights reserved.
//

#import "AnalyzeWindowController.h"


@implementation AnalyzeWindowController

- (id) init
{
  self = [super initWithWindowNibName:@"Analyze" owner:self];
  if (self != nil) {
    [self showWindow:self];
    list = [[NSArray arrayWithObjects:@"One", nil] retain];
  }
  return self;
}


- (void)showWindow:(id)sender
{
  [[self window] makeKeyAndOrderFront:sender];
}


# pragma mark NSTableView Methods

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
  return [list count];
}

- (id)tableView:(NSTableView *)aTableView objectValueForTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex
{
  return [list objectAtIndex:0];
}


- (void)dealloc
{
  [list release];
  [super dealloc];
}


@end
