//
//  ListViewController.m
//  Nerdfeed
//
//  Created by James Haley II on 2/24/11.
//  Copyright 2011 J 2 Consulting, LLC. All rights reserved.
//

#import "ListViewController.h"
#import "RSSChannel.h"
#import "RSSItem.h"
#import "WebViewController.h"
#import "ChannelViewController.h"


@implementation ListViewController

@synthesize webViewController;

-(void)showInfo:(id)sender
{
    ChannelViewController *channelViewController = [[[ChannelViewController alloc] initWithStyle:UITableViewStyleGrouped] autorelease];
    
    if([self splitViewController])
    {
        UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:channelViewController];
        
        NSArray *vcs = [NSArray arrayWithObjects:[self navigationController],
                        nvc,nil];
        [nvc release];
        
        [[self splitViewController] setViewControllers:vcs];
        
        [[self splitViewController] setDelegate:channelViewController];
        
        NSIndexPath *selectedRow = [[self tableView] indexPathForSelectedRow];
        if(selectedRow)
            [[self tableView] deselectRowAtIndexPath:selectedRow animated:YES];
    } else {
        [[self navigationController] pushViewController:channelViewController animated:YES];
    }
    [channelViewController listViewController:self handleObject:channel];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(![self splitViewController])
        [[self navigationController] pushViewController:webViewController animated:YES];
    
    RSSItem *entry = [[channel items] objectAtIndex:[indexPath row]];
    
    [webViewController listViewController:self handleObject:entry];
    
    //    NSURL *url = [NSURL URLWithString:[entry link]];
    //    
    //    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    //    
    //    [[webViewController webView] loadRequest:req];
    //    
    //    [[webViewController navigationItem] setTitle:[entry title]];
}

- (void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName 
  namespaceURI:(NSString *)namespaceURI 
 qualifiedName:(NSString *)qualifiedName
    attributes:(NSDictionary *)attributeDict
{
    NSLog(@"%@ found a %@ element", self, elementName);
    
    if([elementName isEqual:@"channel"]) {
        [channel release];
        channel = [[RSSChannel alloc]init];
        
        [channel setParentParserDelegate:self];
        
        [parser setDelegate:channel];
    }
}


- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [xmlData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSString *xmlCheck = [[[NSString alloc] initWithData:xmlData encoding:NSUTF8StringEncoding] autorelease];
    
    //NSLog(@"xmlCheck = %@", xmlCheck);
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:xmlData];
    [parser setDelegate:self];
    
    [parser parse];
    
    [parser release];
    
    [xmlData release];
    
    xmlData = nil;
    
    [connection release];
    connection = nil;
    
    [[self tableView] reloadData];
    
    NSLog(@"%@\n %@\n %@\n", channel, [channel title], [channel shortDescription]);
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [connection release];
    connection = nil;
    
    [xmlData release];
    xmlData = nil;
    
    NSString *errorString = [NSString stringWithFormat:@"Fetch failed: %@",
                             [error localizedDescription]];
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [av show];
    [av autorelease];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    
    UIBarButtonItem *bbi = [[UIBarButtonItem alloc] initWithTitle:@"Info" 
                                                            style:UIBarButtonItemStyleBordered 
                                                           target:self 
                                                           action:@selector(showInfo:)];
    [[self navigationItem] setRightBarButtonItem:bbi];
    [bbi release];
                            
    [self fetchEntries];
    return self;
}
                            
- (void)fetchEntries
    {
        [xmlData release];
        xmlData = [[NSMutableData alloc] init];
        
        NSURL *url = [NSURL URLWithString:@"http://www.centenarymemphis.com/about-centenary/news.feed?type\x3drss"];
        NSURLRequest *req = [NSURLRequest requestWithURL:url];
        
        connection = [[NSURLConnection alloc] initWithRequest:req delegate:self startImmediately:YES];
    }
                            
                            - (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
    {
        return [[channel items] count];
    }
                            
                            - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"] autorelease];
        }
        
        RSSItem *item = [[channel items] objectAtIndex:[indexPath row]];
        [[cell textLabel] setText:[item title]];
        
        return cell;
    }
                            
                            - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
    {
        if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
            return YES;
        return toInterfaceOrientation == UIInterfaceOrientationPortrait;
    }
                            
                            @end
