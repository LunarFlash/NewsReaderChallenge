//
//  Utility.h
//  WashingtonPostCodeTest
//
//  Created by Yi Wang on 10/1/14.
//  Copyright (c) 2014 YI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utility : NSObject

+ (void)downloadFeedInBackgroundWithURL:(NSURL *)url completionBlock:(void (^)(BOOL succeeded, NSError *error, NSDictionary *data))completionBlock;

@end
