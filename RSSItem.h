//
//  RSSItem.h
//  Nerdfeed
//
//  Created by James Haley II on 2/24/11.
//  Copyright 2011 J 2 Consulting, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface RSSItem : NSObject<NSXMLParserDelegate> 
    {
        NSMutableString *currentString;
        NSString *title;
        NSString *link;
        
        
        id parentParserDelegate;
        
    }
    
    @property (nonatomic, assign) id parentParserDelegate;
    @property (nonatomic, retain) NSString *title;
    @property (nonatomic, retain) NSString *link;


@end
