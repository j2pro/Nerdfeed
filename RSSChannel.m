//
//  RSSChannel.m
//  Nerdfeed
//
//  Created by James Haley II on 2/24/11.
//  Copyright 2011 J 2 Consulting, LLC. All rights reserved.
//

#import "RSSChannel.h"
#import "RSSItem.h"


@implementation RSSChannel
@synthesize title, shortDescription, items, parentParserDelegate;

- (id)init
{
    self = [super init];
    
    items = [[NSMutableArray alloc] init];
    
    return self;
}

-(void) dealloc
{
    [items release];
    [title release];
    [shortDescription release];
    [super dealloc];
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)str {
    [currentString appendString:str];
}

-(void) parser:(NSXMLParser *)parser 
 didEndElement:(NSString *)elementName 
  namespaceURI:(NSString *)namespaceURI 
 qualifiedName:(NSString *)qName
{
    [currentString release];
    currentString = nil;
    
    if([elementName isEqual:@"channel"])
        [parser setDelegate:parentParserDelegate];
}

-(void)parser:(NSXMLParser *)parser 
didStartElement:(NSString *)elementName 
 namespaceURI:(NSString *)namespaceURI 
qualifiedName:(NSString *)qName 
   attributes:(NSDictionary *)attributeDict
{
    NSLog(@"\t%@ found a %@ element", self, elementName);
    
    if([elementName isEqual:@"title"]) {
        currentString = [[NSMutableString alloc] init];
        [self setTitle:currentString];
    }
    
    else if([elementName isEqual:@"description"]){
        currentString = [[NSMutableString alloc] init];
        [self setShortDescription:currentString];
    }
    else if([elementName isEqual:@"item"]) {
        RSSItem *entry = [[RSSItem alloc] init];
        
        [entry setParentParserDelegate:self];
        
        [parser setDelegate:entry];
        [items addObject:entry];
        [entry release];
    }
}

@end
