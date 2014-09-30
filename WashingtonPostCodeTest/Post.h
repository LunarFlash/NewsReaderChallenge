//
//  Post.h
//  WashingtonPostCodeTest
//
//  Created by Terry Wang on 9/29/14.
//  Copyright (c) 2014 YI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Post : NSObject

@property (strong, nonatomic) NSString *postId;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *content;
@property (strong, nonatomic) NSString *excerpt;
@property (strong, nonatomic) NSDate  *date;


-(id)initWithId:(NSString *)postId title:(NSString*)title content:(NSString *)content excerpt:(NSString *)excerpt date:(NSDate*)date;

@end
