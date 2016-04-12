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
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    web =[[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 100, 400)];
    web.backgroundColor = [UIColor blackColor];
    [web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://github.com/TonyJR/UIWebView-HeaderFooter"]]];
    [self.view addSubview:web];
    
    
    
    
    UIButton * button2 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    button2.backgroundColor = [UIColor grayColor];
    web.footerView = button2;
    
}

-(IBAction)changeSize:(id)sender{
    [web setFrame:CGRectMake(100, 100, 250, 350)];
}


-(IBAction)addHeader:(id)sender{
    UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    button.backgroundColor = [UIColor yellowColor];
    web.headerView = button;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
