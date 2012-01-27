//
//  ListViewController.h
//  Nerdfeed
//
//  Created by James Haley II on 2/24/11.
//  Copyright 2011 J 2 Consulting, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RSSChannel;
@class WebViewController;

@interface ListViewController : UITableViewController {
    NSURLConnection *connection;
    NSMutableData *xmlData;
    
    RSSChannel *channel;
    
    WebViewController *webViewController;
    
}

@property (nonatomic, retain) WebViewController *webViewController;


- (void)fetchEntries;

@end

@protocol ListViewControllerDelegate

- (void)listViewController:(ListViewController *)lvc handleObject:(id)object;

@end