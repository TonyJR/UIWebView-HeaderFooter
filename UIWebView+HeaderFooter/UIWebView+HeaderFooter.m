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

@property (nonatomic,readonly) UIView *webBrowser;
@property (nonatomic,assign) BOOL needsUpdateBrowser;


@end

@implementation UIWebView (HeaderFooter)


#define kHeaderViewTag 2200
#define kFooterViewTag 2201

- (void)setNeedsUpdateBrowser:(BOOL)needsUpdateBrowser{
    objc_setAssociatedObject(self, "needsUpdateBrowser", @(needsUpdateBrowser), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)needsUpdateBrowser{
    return objc_getAssociatedObject(self, "needsUpdateBrowser");
}

- (void)layoutSubviews{
    if (self.needsUpdateBrowser) {
        self.needsUpdateBrowser = NO;
        [self updateWebBrowser];
    }
}

- (void)updateWebBrowser{
    CGRect frame = self.webBrowser.frame;
    UIView *headerView = [self headerView];
    CGRect headerFrame = headerView.frame;
    
    frame = ({
        CGRect rect = frame;
        rect.origin.y = headerFrame.origin.y + headerFrame.size.height;
        rect;
    });
    if (!CGRectEqualToRect(frame, self.webBrowser.frame)) {
        self.webBrowser.frame = frame;
    }
    
    UIView *footerView = [self footerView];
    if (footerView) {
        CGRect footerFrame = (CGRect){0, frame.origin.y + frame.size.height, footerView.frame.size};
        if (!CGRectEqualToRect(footerView.frame, footerFrame)) {
            [footerView setFrame:footerFrame];
        }
        
        CGSize contentSize = self.scrollView.contentSize;
        contentSize.height = frame.origin.y + frame.size.height + footerView.frame.size.height;
        self.scrollView.contentSize = contentSize;
    }else{
        CGSize contentSize = self.scrollView.contentSize;
        contentSize.height = frame.origin.y + frame.size.height;
        self.scrollView.contentSize = contentSize;
    }
}

- (void)setHeaderView:(UIView *)headerView{
    UIView *_headerView = [self headerView];
    if (_headerView) {
        [_headerView removeFromSuperview];
    }
    
    
    headerView.tag = kHeaderViewTag;
    [headerView setFrame:CGRectMake(0, 0, self.frame.size.width, headerView.frame.size.height)];
    headerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
    [self.scrollView insertSubview:headerView atIndex:0];
    
    self.needsUpdateBrowser = YES;
    [self setNeedsLayout];
}

- (UIView *)headerView{
    return [self.scrollView viewWithTag:kHeaderViewTag];
}

- (void)setFooterView:(UIView *)footerView{
    UIView *webBrowser = self.webBrowser;
    
    UIView *_footerView = [self footerView];
    if (_footerView) {
        [_footerView removeFromSuperview];
    }else {
        [webBrowser addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
    }

    if (footerView) {
        footerView.tag = kFooterViewTag;
        
        [footerView setFrame:CGRectMake(0, self.scrollView.contentSize.height, self.frame.size.width, footerView.frame.size.height)];
        footerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
        [self.scrollView insertSubview:footerView atIndex:0];
        
    }else{
        [webBrowser removeObserver:self forKeyPath:@"frame"];
    }
    self.needsUpdateBrowser = YES;
    [self setNeedsLayout];
}

- (UIView *)footerView{
    return [self.scrollView viewWithTag:kFooterViewTag];
}



- (UIView *)webBrowser{
    UIScrollView *scroller = self.scrollView;
    UIView *result;
    for (UIView *view in scroller.subviews) {
        if ([[NSString stringWithUTF8String:object_getClassName(view)] containsString:@"UIWebBrowserView"]) {
            result = view;
            break;
        }
    }
    
    return result;
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    
    NSValue *newValue = change[@"new"];
    CGRect newFrame;
    [newValue getValue:&newFrame];
    self.needsUpdateBrowser = YES;
    [self setNeedsLayout];
}




- (void)dealloc{
    [self.webBrowser removeObserver:self forKeyPath:@"frame"];
}


@end
