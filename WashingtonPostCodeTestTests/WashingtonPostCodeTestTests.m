//
//  WashingtonPostCodeTestTests.m
//  WashingtonPostCodeTestTests
//
//  Created by Terry Wang on 9/29/14.
//  Copyright (c) 2014 YI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "Constants.h"
#import "Post.h"

@interface WashingtonPostCodeTestTests : XCTestCase

@end

@implementation WashingtonPostCodeTestTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

- (void)testFetchPosts{
    // This will run the networking off of the main thread, and the callback will come from a system network queue. Generally this is what we want.
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];  // let user know we are using the network
    
    NSURL *url = [NSURL URLWithString:kFeedURL];
    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url
                                                         completionHandler:
                              ^(NSData *data, NSURLResponse *response, NSError *error) {
                                  if (data) {
                                      // Do stuff with the data
                                      
                                      NSDictionary *responseData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                                      // NSLog(@"reponseData:%@", responseData);
                                      
                                      NSArray *posts = [responseData valueForKey:@"posts"];
                                      //NSLog(@"posts.count:%lu", posts.count);
                                      //[self.tableView reloadData];
                                      XCTAssertNotNil(posts, @"Post should not be nil if fetch is successful");
                                      [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                                  } else {
                                      // NSLog(@"Failed to fetch %@: %@", url, error);
                                      XCTAssertFalse(false, @"Could not fatch response");
                                  }
                              }];
    [task resume];
    
}









@end
