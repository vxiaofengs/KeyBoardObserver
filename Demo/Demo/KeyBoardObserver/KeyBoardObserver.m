
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

static CGFloat _tableViewOriYOffset = 0;
static UIScrollView *_responseScrollView = nil;

@interface KeyBoardObserver ()

@property (nonatomic, assign) UIScrollView* sv;
@property (nonatomic, assign) UIView* targetView;
@property (nonatomic, assign) BOOL isCurrentKeyboardTarget;

@end

@implementation KeyBoardObserver

+ (void)autoScrollWithTargetView:(UIView*)targetView scrollView:(UIScrollView*)scrollView{
    KeyBoardObserver *sinton = [KeyBoardObserver new];
    sinton.targetView = targetView;
    sinton.sv = scrollView;
    objc_setAssociatedObject(targetView, associatedKey, sinton, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [[NSNotificationCenter defaultCenter] addObserver:sinton selector:@selector(keyBordDidShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:sinton selector:@selector(keyBordDidHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyBordDidHide:(NSNotification*)noti{
    _responseScrollView = nil;
    if (_sv && _targetView && self.isCurrentKeyboardTarget) {
        [UIView animateWithDuration:0.3 animations:^{
            self->_sv.contentOffset = CGPointMake(0, _tableViewOriYOffset);
        }completion:^(BOOL finished) {
            self.isCurrentKeyboardTarget = NO;
        }];
    }
}

- (void)keyBordDidShow:(NSNotification*)noti{
    
    if (_responseScrollView != self.sv) {
        _tableViewOriYOffset = _sv.contentOffset.y;
        _responseScrollView = self.sv;
    }
    
    if (_sv && _targetView && [_targetView isFirstResponder]) {
        self.isCurrentKeyboardTarget = YES;
        CGRect keyBoardBounds = [[[noti userInfo]objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
        
        UIWindow* window = [UIApplication sharedApplication].keyWindow;
        CGRect windowFrame = [_targetView.superview convertRect:_targetView.frame toView:window];
        
        if (keyBoardBounds.origin.y <= (windowFrame.origin.y+windowFrame.size.height)) {
            CGFloat offsetY = windowFrame.origin.y + windowFrame.size.height - keyBoardBounds.origin.y;
            [_sv setContentOffset:CGPointMake(0, _sv.contentOffset.y + offsetY) animated:YES];
        }
    }
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
