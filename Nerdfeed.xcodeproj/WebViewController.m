//
//  WebViewController.m
//  Nerdfeed
//
//  Created by James Haley II on 2/24/11.
//  Copyright 2011 J 2 Consulting, LLC. All rights reserved.
//

#import "WebViewController.h"
#import "RSSItem.h"


@implementation WebViewController

- (void)listViewController:(ListViewController *)lvc handleObject:(id)object
{
    RSSItem *entry = object;
    
    if(![entry isKindOfClass:[RSSItem class]])
        return;
    NSURL *url = [NSURL URLWithString:[entry link]];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    [[self webView] loadRequest:req];
    
    [[self navigationItem] setTitle:[entry title]];
}

-(void)loadView
{
    UIWebView *wv = [[UIWebView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    [wv setScalesPageToFit:YES];
    
    [self setView:wv];
    [wv release];
}

-(UIWebView *)webView
{
    return (UIWebView *)[self view];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
        return YES;
    return toInterfaceOrientation == UIInterfaceOrientationPortrait;
}


@end
