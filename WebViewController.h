//
//  WebViewController.h
//  Nerdfeed
//
//  Created by James Haley II on 2/24/11.
//  Copyright 2011 J 2 Consulting, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ListViewController.h"


@interface WebViewController : UIViewController<ListViewControllerDelegate> {
    
}
@property (nonatomic,readonly) UIWebView *webView;
@end
