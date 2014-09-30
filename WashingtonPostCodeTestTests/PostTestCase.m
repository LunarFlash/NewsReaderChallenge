//
//  PostTestCase.m
//  WashingtonPostCodeTest
//
//  Created by Terry Wang on 9/30/14.
//  Copyright (c) 2014 YI. All rights reserved.
//

#import "PostTestCase.h"
#import "Post.h"

@implementation PostTestCase


- (void)testConstructorOverload {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    Post *post = [[Post alloc] initWithId:@"123" title:@"Test Title" content:@"All your bases are belong to us" excerpt:@"Life is like a box of chocolate" date:[NSDate date]];
    XCTAssert(post, @"Should be valid object");
}
- (void)setUp
{
    [super setUp];
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

- (void)tearDown
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    [super tearDown];
}

@end
