//
//  ChannelViewController.m
//  Nerdfeed
//
//  Created by James Haley II on 2/25/11.
//  Copyright 2011 J 2 Consulting, LLC. All rights reserved.
//

#import "ChannelViewController.h"

#import "RSSChannel.h"

@implementation ChannelViewController

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if(!cell)
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:@"UITableViewCell"] autorelease];
    
    if([indexPath row] == 0) {
        [[cell textLabel] setText:@"Title"];
        [[cell detailTextLabel] setText:[channel title]];
    } else {
        [[cell textLabel] setText:@"Info"];
        [[cell detailTextLabel] setText:[channel shortDescription]];
    }
    return  cell;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
        return YES;
    return toInterfaceOrientation == UIInterfaceOrientationPortrait;
}

-(void)dealloc
{
    [channel release];
    [super dealloc];
}

- (void)listViewController:(ListViewController *)lvc handleObject:(id)object
{
    if(![object isKindOfClass:[RSSChannel class]])
        return;
    
    [object retain];
    [channel release];
    channel = object;
    
    [[self tableView] reloadData];
}

@end
