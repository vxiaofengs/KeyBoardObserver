//
//  KeyBoardObserver.h
//  Wanduoduo2
//
//  Created by vxiaofengs on 16/8/15.
//  Copyright © 2016年 vxiaofengs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KeyBoardObserver : NSObject

/**
 解决键盘遮盖输入框的问题

 @param targetView textField/textView..
 @param scrollView scrollView
 */
+ (void)autoScrollWithTargetView:(UIView*)targetView scrollView:(UIScrollView*)scrollView;

@end
