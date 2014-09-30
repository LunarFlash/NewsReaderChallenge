//
//  Post.m
//  WashingtonPostCodeTest
//
//  Created by Terry Wang on 9/29/14.
//  Copyright (c) 2014 YI. All rights reserved.
//

#import "Post.h"

@implementation Post



-(id)initWithId:(NSString *)postId title:(NSString*)title content:(NSString *)content excerpt:(NSString *)excerpt date:(NSDate*)date {
    
    
    self = [super init];
    if (self) {
        _postId = postId;
        _title = title;
        _content = content;
        _excerpt = excerpt;
        _date = date;
    }
    
    return self;
}


@end
