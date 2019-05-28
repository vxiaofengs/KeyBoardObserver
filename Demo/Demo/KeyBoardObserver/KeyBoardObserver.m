
//
//  KeyBoardObserver.m
//  Wanduoduo2
//
//  Created by vxiaofengs on 16/8/15.
//  Copyright © 2016年 vxiaofengs. All rights reserved.
//

#import "KeyBoardObserver.h"
#import <objc/runtime.h>

#define associatedKey @"KeyBoardObserver"

CGFloat _tableViewOriYOffset = 0;
UIScrollView *_responseScrollView = nil;

@interface KeyBoardObserver ()

@property (nonatomic, weak) UIScrollView *sv;
@property (nonatomic, weak) UIView *targetView;
@property (nonatomic, assign) BOOL isCurrentKeyboardTarget;

@end

@implementation KeyBoardObserver

+ (void)autoScrollWithTargetView:(UIView *)targetView {
    [self autoScrollWithTargetView:targetView scrollView:nil];
}

+ (void)autoScrollWithTargetView:(UIView*)targetView scrollView:(UIScrollView*)scrollView {
    KeyBoardObserver *sinton = [KeyBoardObserver new];
    sinton.targetView = targetView;
    sinton.sv = scrollView;
    objc_setAssociatedObject(targetView, associatedKey, sinton, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [[NSNotificationCenter defaultCenter] addObserver:sinton selector:@selector(keyBordDidShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:sinton selector:@selector(keyBordDidHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyBordDidHide:(NSNotification*)noti {
    _responseScrollView = nil;
    if (self.sv && _targetView && self.isCurrentKeyboardTarget) {
        [UIView animateWithDuration:0.3 animations:^{
            self.sv.contentOffset = CGPointMake(0, _tableViewOriYOffset);
        } completion:^(BOOL finished) {
            self.isCurrentKeyboardTarget = NO;
        }];
    }
}

- (void)keyBordDidShow:(NSNotification*)noti {
    
    if (_responseScrollView != self.sv) {
        _tableViewOriYOffset = self.sv.contentOffset.y;
        _responseScrollView = self.sv;
    }
    
    if (self.sv && _targetView && [_targetView isFirstResponder]) {
        self.isCurrentKeyboardTarget = YES;
        CGRect keyBoardBounds = [[[noti userInfo]objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
        
        UIWindow* window = [UIApplication sharedApplication].keyWindow;
        CGRect windowFrame = [_targetView.superview convertRect:_targetView.frame toView:window];
        
        if (keyBoardBounds.origin.y <= (windowFrame.origin.y+windowFrame.size.height)) {
            CGFloat offsetY = windowFrame.origin.y + windowFrame.size.height - keyBoardBounds.origin.y;
            [self.sv setContentOffset:CGPointMake(0, _sv.contentOffset.y + offsetY) animated:YES];
        }
    }
}

- (UIScrollView *)sv {
    if (_sv) {
        return _sv;
    } else {
        return [self getFirstScrollView:self.targetView];
    }
}

- (UIScrollView *)getFirstScrollView:(UIView *)view {
    if ([view.superview isKindOfClass:[UIScrollView class]]) {
        _sv = (UIScrollView *)view.superview;
        return _sv;
    } else {
        return [self getFirstScrollView:view.superview];
    }
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
