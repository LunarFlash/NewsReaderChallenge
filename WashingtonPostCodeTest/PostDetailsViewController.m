//
//  PostDetailsViewController.m
//  WashingtonPostCodeTest
//
//  Created by Terry Wang on 9/29/14.
//  Copyright (c) 2014 YI. All rights reserved.
//

#import "PostDetailsViewController.h"

@interface PostDetailsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIWebView *contentWebView;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;


// NSDateFormatter is pretty expensive to create, so we create 1 instance and reuse it for each cell
@property (nonatomic, strong) NSDateFormatter *dateFormatter;

@end

@implementation PostDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dateFormatter = [[NSDateFormatter alloc] init];
    [self.dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    
    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[self.post.title dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    //self.titleLabel.attributedText = attrStr;
    
    
     // To Do remove &' from string
    NSString *titleString = [self.title stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
   
    
    
    self.titleLabel.text = self.post.title;
    [self.contentWebView loadHTMLString:self.post.content baseURL:nil];
    self.dateLabel.text = [self.dateFormatter stringFromDate:self.post.date];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
