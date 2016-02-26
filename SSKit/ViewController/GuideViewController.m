//
//  GuideViewController.m
//  tttt
//
//  Created by Shane on 16/1/1.
//  Copyright © 2016年 Shane. All rights reserved.
//

#import "GuideViewController.h"

typedef enum : NSUInteger {
    GuidePageTypeSkip,
    GuidePageTypeStart,

} GuidePageType;

@interface GuidePageViewController : UIViewController

@property (assign, nonatomic) int type;
@property (assign, nonatomic) int index;

@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UIButton *skipButton;
@property (strong, nonatomic) UIButton *startLaunchButton;



@property (weak, nonatomic) id<GuideViewControllerDelegate> guideDelegate;

- (instancetype)initWithImageIndex:(int)index type:(int)type;

@end


@implementation GuidePageViewController

- (instancetype)initWithImageIndex:(int)index type:(int)type
{
    self = [super init];
    if (self) {
        _index = index;
        _type = type;
    }
    return self;
}

- (void)dealloc{
    NSLog(@"dealloc: %@",self);
}

-(BOOL)shouldAutorotate
{
    return YES;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.clipsToBounds = YES;
    self.imageView.image = [self imageWithType];
    [self.view addSubview:self.imageView];
    
    self.skipButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-60-20, 10, 60, 30)];
    self.skipButton.layer.cornerRadius = 4;
    self.skipButton.layer.borderColor = [UIColor colorWithHexString:@"ffffff"].CGColor;
    self.skipButton.layer.borderWidth = 1;
    self.skipButton.backgroundColor = [UIColor colorWithHexString:@"10ffffff"];
    self.skipButton.hidden = YES;
    self.skipButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.skipButton setTitle:@"跳过" forState:UIControlStateNormal];
    [self.skipButton addTarget:self action:@selector(skipGuideViewController) forControlEvents:UIControlEventTouchUpInside];
    [self.skipButton setTitleColor:[UIColor colorWithConfiger:@"T4"] forState:UIControlStateNormal];
    [self.view addSubview:self.skipButton];
    
    self.startLaunchButton = [[UIButton alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-35-74, 150, 35)];
    self.startLaunchButton.center = CGPointMake(self.view.center.x, self.startLaunchButton.center.y);
    self.startLaunchButton.layer.cornerRadius = 4;
    self.startLaunchButton.layer.borderWidth = 1;
    self.startLaunchButton.layer.borderColor = [UIColor colorWithHexString:@"ffffff"].CGColor;
    self.startLaunchButton.backgroundColor = [UIColor colorWithHexString:@"10ffffff"];
    self.startLaunchButton.hidden = YES;
    self.startLaunchButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.startLaunchButton addTarget:self action:@selector(skipGuideViewController) forControlEvents:UIControlEventTouchUpInside];
    [self.startLaunchButton setTitle:@"开启电竞掌游宝" forState:UIControlStateNormal];
    [self.startLaunchButton setTitleColor:[UIColor colorWithConfiger:@"T4"] forState:UIControlStateNormal];
    [self.view addSubview:self.startLaunchButton];
    
    if (_type == GuidePageTypeSkip) {
        self.skipButton.hidden = NO;
        self.startLaunchButton.hidden = YES;
    }
    else if(_type == GuidePageTypeStart){
        self.skipButton.hidden = YES;
        self.startLaunchButton.hidden = NO;
    }
}

- (UIImage *)imageWithType{
    NSString *imageName;
    float scale = [UIScreen mainScreen].scale;
    imageName = [[NSString alloc] initWithFormat:@"引导%d_%dx%d",_index,(int)(scale*SCREEN_WIDTH),(int)(scale*SCREEN_HEIGHT)];
    UIImage *image = [UIImage imageNamed:imageName];
    return image;
}

- (void)skipGuideViewController{
    if(self.guideDelegate && [self.guideDelegate respondsToSelector:@selector(didSelectSkipButton)]){
        [self.guideDelegate didSelectSkipButton];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (int)index{
    return _index;
}

@end

@interface GuideViewController()<UIPageViewControllerDelegate,UIPageViewControllerDataSource,UIScrollViewDelegate>{
    NSArray *_pages;
}

@property (nonatomic, strong) UIPageViewController *pageViewController;
@property (nonatomic, strong) UIPageControl *pageControl;

@end

@implementation GuideViewController
-(BOOL)shouldAutorotate
{
    return YES;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];

    if (!self.scrollView) {
        for (UIView *view in self.pageViewController.view.subviews) {
            if ([view isKindOfClass:[UIScrollView class]]) {
                self.scrollView = (UIScrollView *)view;
                self.scrollView.delegate = self;
            }
        }
    }
    
    self.pageViewController.view.backgroundColor = [UIColor blackColor];
    [self.pageViewController setDelegate:self];
    [self.pageViewController setDataSource:self];

    [[self.pageViewController view] setFrame:self.view.bounds];

    GuidePageViewController *pageVC1 = [[GuidePageViewController alloc] initWithImageIndex:1 type:GuidePageTypeSkip];
    pageVC1.guideDelegate = self.guideDelegate;
    GuidePageViewController *pageVC2 = [[GuidePageViewController alloc] initWithImageIndex:2 type:GuidePageTypeSkip];
    pageVC2.guideDelegate = self.guideDelegate;
    GuidePageViewController *pageVC3 = [[GuidePageViewController alloc] initWithImageIndex:3 type:GuidePageTypeSkip];
    pageVC3.guideDelegate = self.guideDelegate;
    GuidePageViewController *pageVC4 = [[GuidePageViewController alloc] initWithImageIndex:4 type:GuidePageTypeStart];
    pageVC4.guideDelegate = self.guideDelegate;
    
    _pages = @[pageVC1,pageVC2,pageVC3,pageVC4];
    
    [self.pageViewController setViewControllers:@[[_pages objectAtIndex:0]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    [self addChildViewController:self.pageViewController];
    
    [[self view] addSubview:[self.pageViewController view]];
    [self.pageViewController didMoveToParentViewController:self];
    
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 10, 100, 20)];
    self.pageControl.center = CGPointMake(self.view.center.x, self.pageControl.center.y);
    self.pageControl.numberOfPages = _pages.count;
    self.pageControl.currentPage = 0;
    [self.view addSubview:self.pageControl];
}

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    
    
    

    
    NSUInteger currentIndex = [_pages indexOfObject:viewController];
    if ( currentIndex > 0) {
        return [_pages objectAtIndex:currentIndex-1];
    } else {
        return nil;
    }
}

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    
    NSUInteger currentIndex = [_pages indexOfObject:viewController];
    if ( currentIndex < [_pages count]-1) {
        return [_pages objectAtIndex:currentIndex+1];
    } else {
        return nil;
    }
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed{
    if (completed) {
       GuidePageViewController *pageVC = (GuidePageViewController*)[pageViewController.viewControllers firstObject];
       [self.pageControl setCurrentPage:pageVC.index-1];
    }
}

// 禁掉 bounce 效果。
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (!NO) {
        if (0 == self.pageControl.currentPage && scrollView.contentOffset.x < scrollView.bounds.size.width) {
            scrollView.contentOffset = CGPointMake(scrollView.bounds.size.width, 0);
        }
        if (self.pageControl.currentPage == 3 && scrollView.contentOffset.x > scrollView.bounds.size.width) {
            scrollView.contentOffset = CGPointMake(scrollView.bounds.size.width, 0);
        }
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    if (!NO) {
        if (0 == self.pageControl.currentPage && scrollView.contentOffset.x <= scrollView.bounds.size.width) {
            *targetContentOffset = CGPointMake(scrollView.bounds.size.width, 0);
        }
        if (self.pageControl.currentPage == 3 && scrollView.contentOffset.x >= scrollView.bounds.size.width) {
            *targetContentOffset = CGPointMake(scrollView.bounds.size.width, 0);
        }
    }
}
@end
