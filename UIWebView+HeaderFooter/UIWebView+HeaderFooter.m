//
//  UIWebView+HeaderFooter.m
//  C3WebView
//
//  Created by Tony on 16/4/11.
//  Copyright © 2016年 Tony. All rights reserved.
//

#import "UIWebView+HeaderFooter.h"
#import <objc/runtime.h>

@interface UIWebView ()

@property (nonatomic,readonly) UIView * webBrowser;

@end

@implementation UIWebView (HeaderFooter)


#define kHeaderViewTag 2200
#define kFooterViewTag 2201


-(void)setHeaderView:(UIView *)headerView{
    UIView * _headerView = [self headerView];
    if (_headerView) {
        [_headerView removeFromSuperview];
    }
    
    
    headerView.tag = kHeaderViewTag;
    [headerView setFrame:CGRectMake(0, 0, self.frame.size.width, headerView.frame.size.height)];
    headerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
    [self.scrollView addSubview:headerView];
}

-(UIView *)headerView{
    return [self.scrollView viewWithTag:kHeaderViewTag];
}

-(void)setFooterView:(UIView *)footerView{
    UIView * _footerView = [self footerView];
    if (_footerView) {
        [_footerView removeFromSuperview];
    }

    
    footerView.tag = kFooterViewTag;
    [footerView setFrame:CGRectMake(0, self.frame.size.height - footerView.frame.size.height, self.frame.size.width, footerView.frame.size.height)];
    footerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    [self.scrollView addSubview:footerView];
    
    
    UIEdgeInsets edgeInsets = self.scrollView.contentInset;
    edgeInsets.bottom = footerView.frame.size.height;
    self.scrollView.contentInset = edgeInsets;
    
    
    [self.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
}

-(UIView *)footerView{
    return [self.scrollView viewWithTag:kFooterViewTag];
}



-(UIView *)webBrowser{
    UIScrollView * scroller = self.scrollView;
    UIView * result;
    for (UIView * view in scroller.subviews) {
        if ([[NSString stringWithUTF8String:object_getClassName(view)] isEqualToString:@"UIWebBrowserView"]) {
            result = view;
            break;
        }
    }
    
    return result;
}


-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    NSValue * value = change[@"new"];
    CGSize size;
    [value getValue:&size];
    
    
    UIView * footerView = [self footerView];
    if (footerView) {
        [footerView setFrame:(CGRect){0, size.height, footerView.frame.size}];
    }
}

-(void)dealloc{
    [self.scrollView removeObserver:self forKeyPath:@"contentSize"];
}

@end