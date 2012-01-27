//
//  RSSChannel.h
//  Nerdfeed
//
//  Created by James Haley II on 2/24/11.
//  Copyright 2011 J 2 Consulting, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface RSSChannel : NSObject <NSXMLParserDelegate> {
    NSMutableString *currentString;
    NSString *title;
    NSString *shortDescription;
    NSMutableArray *items;
    
    id parentParserDelegate;
    
}

@property (nonatomic, assign) id parentParserDelegate;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *shortDescription;
@property (nonatomic, readonly) NSMutableArray *items;

@end
