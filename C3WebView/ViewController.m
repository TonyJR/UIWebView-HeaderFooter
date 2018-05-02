//
//  ViewController.m
//  C3WebView
//
//  Created by Tony on 16/4/11.
//  Copyright © 2016年 Tony. All rights reserved.
//

#import "ViewController.h"
#import "UIWebView+HeaderFooter.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UIWebView * web;
    BOOL didResized;
    UITableView *tableView;
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
    [self addHeader:nil];
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
//    UIButton * bottomView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
//    [bottomView setTitle:@"This is a BottomView" forState:UIControlStateNormal];
//    web.footerView = bottomView;
    
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    tableView.delegate = self;
    tableView.dataSource = self;
    web.footerView = tableView;
    
    [tableView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
}

-(IBAction)reload:(id)sender{
    [web reload];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - KVO
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{

    NSValue *newValue = change[@"new"];
    CGSize size;
    [newValue getValue:&size];
    size.height += 5;
    if (!CGSizeEqualToSize(size, tableView.frame.size)) {
        tableView.frame = (CGRect){0,0,size};
        web.footerView = tableView;
    }
}


#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    return cell;
}

#pragma mark - UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

@end
