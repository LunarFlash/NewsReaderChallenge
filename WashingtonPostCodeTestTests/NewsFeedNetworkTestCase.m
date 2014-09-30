//
//  NewsFeedNetworkTestCase.m
//  WashingtonPostCodeTest
//
//  Created by Terry Wang on 9/30/14.
//  Copyright (c) 2014 YI. All rights reserved.
//

#import "NewsFeedNetworkTestCase.h"
#import "NewsFeedTableViewController.h"
#import "Constants.h"

@interface NewsFeedNetworkTestCase ()
@property (nonatomic, strong) NSArray *posts;
@end


@implementation NewsFeedNetworkTestCase


- (void) testFetchPostsSuccessful {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];  // let user know we are using the network
    
    NSURL *url = [NSURL URLWithString:kFeedURL];
    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url
                                                         completionHandler:
                              ^(NSData *data, NSURLResponse *response, NSError *error) {
                                  if (data) {
                                      // Do stuff with the data
                                      
                                      NSDictionary *responseData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                                      // NSLog(@"reponseData:%@", responseData);
                                      
                                      self.posts = [responseData valueForKey:@"posts"];
                                      //NSLog(@"posts.count:%lu", self.posts.count);
                                      //[self.tableView reloadData];
                                      [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                                      
                                      
                                      XCTAssert(self.posts, @"Should not be nil");
                                      
                                      
                                  } else {
                                      NSLog(@"Failed to fetch %@: %@", url, error);
                                  }
                              }];
    [task resume];
}






- (void)setUp
{
    [super setUp];
    NSLog(@"%s", __PRETTY_FUNCTION__);
    [self testFetchPostsSuccessful];
}

- (void)tearDown
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    [super tearDown];
}




@end
