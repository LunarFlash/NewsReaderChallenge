//
//  NewsFeedTableViewController.m
//  WashingtonPostCodeTest
//
//  Created by Terry Wang on 9/29/14.
//  Copyright (c) 2014 YI. All rights reserved.
//

#import "NewsFeedTableViewController.h"
#import "Constants.h"
#import "Post.h"
#import "PostDetailsViewController.h"

@interface NewsFeedTableViewController ()

@property (strong, nonatomic) NSString* feedURL;

@property (strong, nonatomic) NSArray *posts;

// NSDateFormatter is pretty expensive to create, so we create 1 instance and reuse it for each cell
@property (nonatomic, strong) NSDateFormatter *dateFormatter;

@end

@implementation NewsFeedTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Feed";
    self.dateFormatter = [[NSDateFormatter alloc] init];
    [self.dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];

    
    self.feedURL = kFeedURL; // set feed URL using global const design pattern
    
    [self fetchPosts];
    
    
    
}

- (void) fetchPosts {
    
    NSURL *url = [NSURL URLWithString:self.feedURL];
    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url
                                                         completionHandler:
                              ^(NSData *data, NSURLResponse *response, NSError *error) {
                                  if (data) {
                                      // Do stuff with the data
                                      
                                      NSDictionary *responseData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                                      // NSLog(@"reponseData:%@", responseData);
                                      
                                      self.posts = [responseData valueForKey:@"posts"];
                                      // NSLog(@"posts.count:%lu", self.posts.count);
                                      [self.tableView reloadData];
                                      
                                  } else {
                                      NSLog(@"Failed to fetch %@: %@", url, error);
                                  }
                              }];
    [task resume];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.posts count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    NSDictionary *postDict = self.posts[indexPath.row];
    NSDate *postDate = [self.dateFormatter dateFromString:postDict[@"date"]];
    
    Post *post = [[Post alloc] initWithId:postDict[@"id"] title:postDict[@"title"] content:postDict[@"content"] excerpt:postDict[@"excerpt"] date:postDate];
    
    
    UILabel *titleLabel = (UILabel*) [cell viewWithTag:100];
    titleLabel.text = postDict[@"title"];
    //titleLabel.text = post.title;
    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[post.title dataUsingEncoding:NSUnicodeStringEncoding] options:nil documentAttributes:nil error:nil];
    titleLabel.attributedText = attrStr;
    
    
    UILabel *dateLabel = (UILabel*) [cell viewWithTag:101];
    dateLabel.text = [self.dateFormatter stringFromDate:post.date];
    
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier] isEqualToString:@"ShowPostDetailsSegue"])
    {
        PostDetailsViewController *dvc = [segue destinationViewController];
        NSIndexPath *selectedIndexPath = [self.tableView indexPathForSelectedRow];
        
        NSDictionary *postDict = self.posts[selectedIndexPath.row];
        NSDate *postDate = [self.dateFormatter dateFromString:postDict[@"date"]];
        Post *post = [[Post alloc] initWithId:postDict[@"id"] title:postDict[@"title"] content:postDict[@"content"] excerpt:postDict[@"excerpt"] date:postDate];
        dvc.post = post;
        
    }
}


- (IBAction)sortByTitleButtonPressed:(id)sender {
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES];
    NSArray *sortedArray = [self.posts sortedArrayUsingDescriptors:@[sort]];
    self.posts = sortedArray;
    [self.tableView reloadData];

}



- (IBAction)sortByDateButtonPressed:(id)sender {
    
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"date" ascending:YES];
    NSArray *sortedArray = [self.posts sortedArrayUsingDescriptors:@[sort]];
    self.posts = sortedArray;
    [self.tableView reloadData];
    
}

#pragma mark - Helper Functions
- (void) parseFeed {
    
    
    
}


@end
