//
//  Utility.m
//  WashingtonPostCodeTest
//
//  Created by Yi Wang on 10/1/14.
//  Copyright (c) 2014 YI. All rights reserved.
//

#import "Utility.h"

@implementation Utility

+ (void)downloadFeedInBackgroundWithURL:(NSURL *)url completionBlock:(void (^)(BOOL succeeded, NSError *error, NSDictionary *data))completionBlock {
    
    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url
                                                         completionHandler:
                              ^(NSData *data, NSURLResponse *response, NSError *error) {
                                  if (data) {
                                      // Do stuff with the data
                                      
                                      NSDictionary *responseData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                                      // NSLog(@"reponseData:%@", responseData);
                                      
                                      if (completionBlock) {
                                          completionBlock(YES, error, responseData);
                                      }
                                      
                                      
                                  } else {
                                      NSLog(@"Failed to fetch %@: %@", url, error);
                                      
                                  }
                              }];
    [task resume];

    
}

@end
