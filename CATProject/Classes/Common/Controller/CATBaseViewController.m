//
//  CATBaseViewController.m
//  CATProject
//
//  Created by Shihuaixing on 2020/9/1.
//  Copyright © 2020 Shihuaixing. All rights reserved.
//

#import "CATBaseViewController.h"
#import "CATNavigationController.h"
#import "CATNavigationBar.h"
#import <CATCommonKit/CATCommonKit.h>

@interface CATBaseViewController ()

@end

@implementation CATBaseViewController

#pragma mark - Life
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
//        self.leftNaviButtonItem = [[CATNaviButtonItem alloc] initWithImageName:@"cat_navigation_bar_black_back_icon" title:nil];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _navigationBar = [[CATNavigationBar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), self.navigationController.navigationBar.height + CGRectGetHeight([UIApplication sharedApplication].statusBarFrame))];
    _navigationBar.bottom = self.navigationController.navigationBar.height;
    [self.navigationController.navigationBar addSubview:_navigationBar];
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"0xF5F5F5"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 设置导航栏内容
    [self setupNavigationBarContent];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)dealloc {
    if (_navigationBar) {
        [_navigationBar removeFromSuperview];
        _navigationBar = nil;
    }
    NSLog(@"%@ ----- dealloc", NSStringFromClass([self class]));
}

#pragma mark - Private

/// 设置导航栏内容
- (void)setupNavigationBarContent {
    // 设置title
    [self setupNavigationBarTitle];
    // 设置左右按钮
    [self setupNavigationBarButton];
}

/// 设置title
- (void)setupNavigationBarTitle {
    self.navigationBar.title = self.titleString;
}

/// 设置导航栏左右按钮
- (void)setupNavigationBarButton {
    
    if (_leftNaviButtonItem) {
        self.navigationBar.leftButtonItem = _leftNaviButtonItem;
    }
    if (_rightNaviButtonItem) {
        self.navigationBar.rightButtonItem = _rightNaviButtonItem;
    }
    
}

#pragma mark - Public

- (void)setTitleString:(NSString *)titleString {
    if ([_titleString isEqualToString:titleString]) {
        return;
    }
    _titleString = [titleString copy];
    self.navigationBar.title = self.titleString;
}

- (void)setLeftNaviButtonItem:(CATNaviButtonItem *)leftNaviButtonItem {
    if (_leftNaviButtonItem == leftNaviButtonItem) {
        return;
    }
    _leftNaviButtonItem = leftNaviButtonItem;
    [_leftNaviButtonItem addTarget:self action:@selector(leftNaviButtonItemDidClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self setupNavigationBarContent];
}

- (void)cat_pushVieController:(UIViewController *)controller animated:(BOOL)animated {
    [self.navigationController pushViewController:controller animated:animated];
}

- (void)cat_presentVieController:(UIViewController *)controller animated:(BOOL)animated completion:(void (^)(void))completion {
    
    if (![controller isKindOfClass:[UINavigationController class]]) {
        CATNavigationController *navi = [[CATNavigationController alloc] initWithRootViewController:controller];
        navi.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentViewController:navi animated:animated completion:completion];
    } else {
        controller.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentViewController:controller animated:animated completion:completion];
    }
}

#pragma mark - Action
- (void)leftNaviButtonItemDidClick:(CATNaviButtonItem *)sender {
    
}

- (void)rightNaviButtonItemDidClick:(CATNaviButtonItem *)sender {
    
}
@end
