//
//  ViewController.m
//  Demo
//
//  Created by 黄枵锋 on 2018/9/7.
//  Copyright © 2018年 vxiaofengs. All rights reserved.
//

#import "ViewController.h"

#import "KeyBoardObserver.h"

@interface ViewController ()<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *tf1;
@property (weak, nonatomic) IBOutlet UITextField *tf2;
@property (weak, nonatomic) IBOutlet UITextField *tf3;
@property (weak, nonatomic) IBOutlet UITextField *tf4;
@property (weak, nonatomic) IBOutlet UITextView *tv1;
@property (weak, nonatomic) IBOutlet UIScrollView *scrolllview;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    [KeyBoardObserver autoScrollWithTargetView:_tf1 scrollView:_scrolllview];
    
    [KeyBoardObserver autoScrollWithTargetView:_tf2 scrollView:_scrolllview];
    
    [KeyBoardObserver autoScrollWithTargetView:_tf3 scrollView:_scrolllview];
    
    [KeyBoardObserver autoScrollWithTargetView:_tf4 scrollView:_scrolllview];
    
    [KeyBoardObserver autoScrollWithTargetView:_tv1 scrollView:_scrolllview];
    
}


- (IBAction)tap:(UITapGestureRecognizer *)sender {
    [self.view endEditing:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
