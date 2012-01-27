//
//  ChannelViewController.h
//  Nerdfeed
//
//  Created by James Haley II on 2/25/11.
//  Copyright 2011 J 2 Consulting, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ListViewController.h"

@class RSSChannel;


@interface ChannelViewController : UITableViewController <ListViewControllerDelegate> {
    RSSChannel *channel;
    
}

@end
