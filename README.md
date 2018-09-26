# KeyBoardObserver


## 非常轻量级的键盘自适应组件，使用只需一行代码。源代码行数70行，只针对需要开启的View调用，节省内存使用且支持自动释放。

## 效果展示
!()[https://github.com/vxiaofengs/KeyBoardObserver/blob/master/demo.gif]

## 使用方法

在需要自适应键盘的地方

```
#import "KeyBoardObserver.h"


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //_textFiled : 需要键盘自适应的view
    //_scrollview : 进行滚动调整的superview
    [KeyBoardObserver autoScrollWithTargetView:_textFiled scrollView:_scrollview];
    [KeyBoardObserver autoScrollWithTargetView:_textFiled2 scrollView:_scrollview];
    [KeyBoardObserver autoScrollWithTargetView:_textFiled3 scrollView:_scrollview];
}
```
