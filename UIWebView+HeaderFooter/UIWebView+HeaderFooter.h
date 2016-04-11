//
//  UIWebView+HeaderFooter.h
//  C3WebView
//
//  Created by Tony on 16/4/11.
//  Copyright © 2016年 Tony. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWebView (HeaderFooter)

/**
 *  The width of headerView/footer may be changed in order to adapt different equipment.
 *  But height will not.
 */
@property (nonatomic,strong) UIView * headerView;
@property (nonatomic,strong) UIView * footerView;



@end
