//
//  RSSItem.m
//  Nerdfeed
//
//  Created by James Haley II on 2/24/11.
//  Copyright 2011 J 2 Consulting, LLC. All rights reserved.
//

#import "RSSItem.h"


@implementation RSSItem

@synthesize title,link,parentParserDelegate;

- (void)parser:(NSXMLParser *)parser 
didStartElement:(NSString *)elementName 
  namespaceURI:(NSString *)namespaceURI 
 qualifiedName:(NSString *)qualifiedName 
    attributes:(NSDictionary *)attributeDict
{
    NSLog(@"\t\t%@ found a %@ element", self, elementName);
    
    if([elementName isEqual:@"title"]) {
        currentString = [[NSMutableString alloc] init];
        [self setTitle:currentString];
    }
    else if([elementName isEqual:@"link"]) {
        currentString = [[NSMutableString alloc] init];
        [self setLink:currentString];
        
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)str 
{
    [currentString appendString:str];
}

- (void) parser:(NSXMLParser *)parser 
  didEndElement:(NSString *)elementName 
   namespaceURI:(NSString *)namespaceURI 
  qualifiedName:(NSString *)qName
{
    [currentString release];
    currentString = nil;
    
    if([elementName isEqual:@"item"])
        [parser setDelegate:parentParserDelegate];
}

- (void) dealloc
{
    [title release];
    [link release];
    [super dealloc];
}

@end
