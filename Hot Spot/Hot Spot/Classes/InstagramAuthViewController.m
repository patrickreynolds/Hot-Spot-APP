//
//  InstagramAuthViewController.m
//  Hot Spot
//
//  Created by Mathieu GHENNASSIA on 03/05/2014.
//  Copyright (c) 2014 Patrick Reynolds. All rights reserved.
//

#import "InstagramAuthViewController.h"

#import "InstagramPlatform.h"

@interface InstagramAuthViewController () <UIWebViewDelegate>

@property (nonatomic, weak) id<InstagramAuthViewControllerDelegate> delegate;

@property (nonatomic, strong) UIViewController *contentViewController;
@property (nonatomic, strong) UIViewController *rootViewController;
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) NSURL *authURL;

@property (nonatomic, strong) NSString *redirectURIScheme;

@property (nonatomic, assign) BOOL isHiding;

@end

@implementation InstagramAuthViewController

#pragma mark - Initialization

- (id)initWithURL:(NSURL *)url delegate:(id<InstagramAuthViewControllerDelegate>)delegate {
    self = [super init];
    if (self) {
        self.authURL = url;
        self.delegate = delegate;

        // Setup the auth view
        UIWindow *keyWindow = [UIApplication sharedApplication].delegate.window;
        if (!keyWindow) {
            keyWindow = [UIApplication sharedApplication].keyWindow;
        }
        self.rootViewController = keyWindow.rootViewController;

        NSAssert(self.rootViewController != nil, @"Application must have a root view controller.");
    }

    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationBar.tintColor = [UIColor darkGrayColor];
    self.navigationBar.translucent = NO;
    [self pushViewController:[[UIViewController alloc] init] animated:NO];

    self.topViewController.view.backgroundColor = [UIColor whiteColor];
    self.topViewController.view.frame = [UIScreen mainScreen].applicationFrame;

    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancel)];
    self.topViewController.navigationItem.leftBarButtonItem = cancelButton;

    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
    for (NSHTTPCookie *cookie in cookies) {
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
    }

    NSURL *url = [NSURL URLWithString:[InstagramPlatform sharedPlatform].redirectURI];
    self.redirectURIScheme = url.scheme;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.topViewController.view.bounds.size.width, self.topViewController.view.bounds.size.height)];
    self.webView.delegate = self;
    self.webView.backgroundColor = [UIColor whiteColor];
}

- (void)show {
    [self.rootViewController presentViewController:self animated:YES completion:^{
        [self.webView loadRequest:[NSURLRequest requestWithURL:self.authURL]];
    }];
}

- (void)hideWithCompletion:(void(^)())completion {
    if (self.isHiding) return;
    self.isHiding = YES;
    [self.rootViewController dismissViewControllerAnimated:YES completion:^{
        if (completion) completion();
    }];
}

- (void)cancel {
    [self hideWithCompletion:^{
        [self.delegate authViewControllerDidCancel:self];
    }];
}

#pragma mark - Web View Delegate

- (void)webViewDidStartLoad:(UIWebView *)webView {
    if (!self.webView.superview) {
        self.topViewController.navigationItem.title = @"Loading";
    }
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    // Add the web view once it loads
    if (!self.webView.superview) {
        self.topViewController.navigationItem.title = @"";
        [self.topViewController.view addSubview:self.webView];
    }
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    if ([request.URL.scheme isEqualToString:self.redirectURIScheme]) {
        NSString *query = request.URL.query;
        NSString *code = [query stringByReplacingOccurrencesOfString:@"code=" withString:@""];

        [self hideWithCompletion:nil];
        [self.delegate authViewController:self didCompleteWithAuthCode:code];

        return NO;
    }

    return YES;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [self hideWithCompletion:nil];
    [self.delegate authViewController:self didFailWithError:error];
}

@end