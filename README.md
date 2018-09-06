# KeyBoardObserver


## 非常轻量级的键盘自适应组件，总代码行数70行，只针对需要开启的View开启,节省内存且自动释放

## 使用方法

在需要自适应键盘的地方

```
#import "KeyBoardObserver.h"


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //_textFiled : 需要键盘自适应的view
    //_scrollview : 滚动的父对象
    [KeyBoardObserver autoScrollWithTargetView:_textFiled scrollView:_scrollview];
}
```
