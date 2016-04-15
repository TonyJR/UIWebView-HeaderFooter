//
//  ViewController.m
//  C3WebView
//
//  Created by Tony on 16/4/11.
//  Copyright © 2016年 Tony. All rights reserved.
//

#import "ViewController.h"
#import "UIWebView+HeaderFooter.h"

@interface ViewController (){
    UIWebView * web;
    BOOL didResized;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    web =[[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 50)];
    web.backgroundColor = [UIColor lightGrayColor];
    [web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://github.com/TonyJR/UIWebView-HeaderFooter"]]];
    [self.view addSubview:web];
    
    
    
    
    
    
}

-(IBAction)changeSize:(id)sender{
    
    [UIView beginAnimations:@"resizing" context:nil];
    [UIView setAnimationDuration:0.3];
    if (didResized) {
        [web setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 50)];
    }else{
        [web setFrame:CGRectMake(100, 100, 250, 350)];

    }
    [UIView commitAnimations];
    
    didResized = !didResized;
}


-(IBAction)addHeader:(id)sender{
    UIButton * headerView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
    [headerView setTitle:@"This is a HeaderView" forState:UIControlStateNormal];

    web.headerView = headerView;
}


-(IBAction)addBottom:(id)sender{
    UIButton * bottomView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
    [bottomView setTitle:@"This is a BottomView" forState:UIControlStateNormal];
    web.footerView = bottomView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
