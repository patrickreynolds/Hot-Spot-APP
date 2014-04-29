//
//  HSOAuthSignupVC.m
//  Hot Spot
//
//  Created by Patrick Reynolds on 1/17/14.
//  Copyright (c) 2014 Patrick Reynolds. All rights reserved.
//

#import "HSOAuthSignupVC.h"
#import "HSPhotoFeedVC.h"

@interface HSOAuthSignupVC ()

@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong ,nonatomic) NSString *websiteURL;
@property (strong, nonatomic) NSString *websiteTitile;
@property (strong, readwrite) NSString *access_token;

@end

#define INSTAGRAM_CLIENT_ID @"801cf1d44fcd43f99cbb38781d7cb227"
#define INSTAGRAM_LOGIN_REQUEST @"http://api.instagram.com/oauth/authorize/?client_id=%@&redirect_uri=%@&response_type=token"
#define INSTAGRAM_REDIRECT_URI @"http://www.patrickreynolds.me/hotspot/index.html"

@implementation HSOAuthSignupVC
@synthesize access_token = _access_token;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Hot Spot";
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:INSTAGRAM_LOGIN_REQUEST,INSTAGRAM_CLIENT_ID, INSTAGRAM_REDIRECT_URI]]]];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    // Initializing currentURL with the last url that was loaded each time UIWebView is refreshed.
    NSURL *currentURL = [[webView request] URL];
        // NSLog(@"Current URL is %@", currentURL.absoluteString);
    
    // Determine if callback url was received by checking
    NSString *urlConfirmation = currentURL.absoluteString;
    NSString *urlConfirmationPrefix = [urlConfirmation substringWithRange:NSMakeRange(0, 48)];
    
    if ([urlConfirmationPrefix isEqualToString:INSTAGRAM_REDIRECT_URI]) {
        NSString *code = @"=";
        NSRange range = [urlConfirmation rangeOfString:code];
            //NSLog(@"range index: %lu", (unsigned long)range.location);
        self.access_token = [urlConfirmation substringFromIndex:range.location + 1];
            NSLog(@"Access token found in HSOAuthSignupVC: %@", self.access_token);

        [self performSegueWithIdentifier:@"Return Access Token" sender:self];
    }
}

#define UNWIND_SEGUE_IDENTIFIER @"Return Access Token"

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:UNWIND_SEGUE_IDENTIFIER]) {
        //HSPhotoFeedVC *vc = segue.destinationViewController;
        //vc.access_token = self.access_token;
        NSLog(@"Prepared for return from HSOAuthSignupVC to HSPhotoFeedVC");
    }
}

@end
