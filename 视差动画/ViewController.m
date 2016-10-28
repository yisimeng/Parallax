//
//  ViewController.m
//  视差动画
//
//  Created by 忆思梦 on 16/2/29.
//  Copyright © 2016年 忆思梦. All rights reserved.
//

#import "ViewController.h"
#import "ParallaxTableViewCell.h"
#import "SeparateImageView.h"
#import "AnimationTableViewCell.h"
#import "TextParallaxView.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView * tableView;
@end

int arraySum (NSMutableArray * array){
    int sum = 0;
    for (int i =0 ; i < [array count]; i++) {
        sum += [array[i] intValue];
    }
    return sum;
}

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
//    NSMutableArray * B = [NSMutableArray arrayWithArray: @[@1,@200,@300,@400,@5000,@6000,@70000,@80000,@90000]];
//    NSMutableArray * A = [NSMutableArray array];
//    [A addObject:[B lastObject]];
//    [B removeLastObject];
//    
//    while (arraySum(B) - arraySum(A) > [[B firstObject] intValue]) {
//        [A insertObject:[B firstObject] atIndex:(A.count-1)];
//        [B removeObjectAtIndex:0];
//    }
//    NSLog(@"%@",A);
//    NSLog(@"%@",B);
//    
//    
//    NSMutableArray * A1 = [NSMutableArray arrayWithArray:A];
//    NSMutableArray * B1 = [NSMutableArray arrayWithArray:B];
//    while (arraySum(A1) - arraySum(B1) > [[A1 firstObject] intValue]) {
//        [B1 addObject:[A1 firstObject]];
//        [A1 removeObjectAtIndex:0];
//    }
//    NSLog(@"a1:%d",arraySum(A1));
//    NSLog(@"b1:%d",arraySum(B1));
    
//    SeparateImageView * imageView = [[SeparateImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 250)];
//    imageView.BgImage = [UIImage imageNamed:@"1"];
//    [self.view addSubview:imageView];
    
/// 图片视差
//    _tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
//    _tableView.dataSource = self;
//    _tableView.delegate = self;
//    _tableView.rowHeight = 250;
//    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    [self.view addSubview:_tableView];

    //文字视差
    NSArray * titleArr = @[@"test1"];
    TextParallaxView * change = [[TextParallaxView alloc]initWithFrame:CGRectMake(100, 200, 200, 100) andTitleArr:titleArr];
    [self.view addSubview:change];
    
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"a" ofType:@"json"];
//    NSLog(@"%@,%d",path,[[NSFileManager defaultManager] fileExistsAtPath:path]);
//
//    NSString * str = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
//    NSLog(@"%@",str);
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSArray *visibleCells = [_tableView visibleCells];
    [visibleCells enumerateObjectsUsingBlock:^(ParallaxTableViewCell *  obj, NSUInteger idx, BOOL *  stop) {
        [obj cellOffset];
    }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSArray *visibleCells = [_tableView visibleCells];
    [visibleCells enumerateObjectsUsingBlock:^(ParallaxTableViewCell *  obj, NSUInteger idx, BOOL *  stop) {
        [obj cellOffset];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ParallaxTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"a"];
    if (cell == nil) {
        cell = [[ParallaxTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"a"];
    }

//    AnimationTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"b"];
//    if (cell == nil) {
//        cell = [[AnimationTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"b"];
//    }
//    [cell configWithDic:nil];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

@end
