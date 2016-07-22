//
//  ViewController.m
//  Project
//
//  Created by yangqisuo on 16/6/27.
//  Copyright © 2016年 yangqisuo. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import "SecondViewController.h"
@interface ViewController ()

@end

@implementation ViewController

+ (instancetype)sharedInstance
{
    static ViewController* instance = nil;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [ViewController new];
    });

    return instance;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor redColor]];
      
    RACSignal* signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"1"];
        //[subscriber sendCompleted];
        return [
            RACDisposable disposableWithBlock:^{
                NSLog(@"信号被销毁");
            }
        ];
        
    }];
    
    [signal subscribeNext:^(id x) {
        NSLog(@"接收到数据:%@",x);
    }];
    
    
    RACSubject * subject = [RACSubject subject];
    [subject subscribeNext:^(id x) {
        NSLog(@"第一个订阅者:%@",x);
    }];
    [subject subscribeNext:^(id x) {
        NSLog(@"第二个订阅者:%@",x);
    }];
    
    
    [subject sendNext:@"1"];
    
    
    
    RACReplaySubject * replySubject = [RACReplaySubject subject];
    [replySubject sendNext:@"1"];
    [replySubject sendNext:@"2"];
    [replySubject subscribeNext:^(id x) {
        NSLog(@"第一个订阅者收到的数据%@",x);
    }];
    
    [replySubject subscribeNext:^(id x) {
        NSLog(@"第二个订阅者收到的数据%@",x);
    }];
    
    
    NSArray *numbers = @[@1,@2,@3,@4];
    
    // 这里其实是三步
    // 第一步: 把数组转换成集合RACSequence numbers.rac_sequence
    // 第二步: 把集合RACSequence转换RACSignal信号类,numbers.rac_sequence.signal
    // 第三步: 订阅信号，激活信号，会自动把集合中的所有值，遍历出来。
    [numbers.rac_sequence.signal subscribeNext:^(id x) {
        
        NSLog(@"%@",x);
    }];
    
    
    
    
    // 2.遍历字典,遍历出来的键值对会包装成RACTuple(元组对象)
    NSDictionary *dict = @{@"name":@"xmg",@"age":@18};
    [dict.rac_sequence.signal subscribeNext:^(RACTuple *x) {
        
        // 解包元组，会把元组的值，按顺序给参数里面的变量赋值
        RACTupleUnpack(NSString *key,NSString *value) = x;
        
        // 相当于以下写法
        //        NSString *key = x[0];
        //        NSString *value = x[1];
        
        NSLog(@"%@ %@",key,value);
        
    }];
    
    
    
    
    
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setFrame:CGRectMake(50, 100, 100, 50)];
    [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundColor:[UIColor purpleColor]];
    [button setTitle:@"click" forState:UIControlStateNormal];
    [self.view addSubview:button];
    
    
    [self initData];
}
- (void)initData{
    // 3.字典转模型
    // 3.1 OC写法
//    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"flags.plist" ofType:nil];
//    
//    NSArray *dictArr = [NSArray arrayWithContentsOfFile:filePath];
//    
//    NSMutableArray *items = [NSMutableArray array];
//    
//    for (NSDictionary *dict in dictArr) {
//        FlagItem *item = [FlagItem flagWithDict:dict];
//        [items addObject:item];
//    }
//    
//    // 3.2 RAC写法
//    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"flags.plist" ofType:nil];
//    
//    NSArray *dictArr = [NSArray arrayWithContentsOfFile:filePath];
//    
//    NSMutableArray *flags = [NSMutableArray array];
//    
//    _flags = flags;
//    
//    // rac_sequence注意点：调用subscribeNext，并不会马上执行nextBlock，而是会等一会。
//    [dictArr.rac_sequence.signal subscribeNext:^(id x) {
//        // 运用RAC遍历字典，x：字典
//        
//        FlagItem *item = [FlagItem flagWithDict:x];
//        
//        [flags addObject:item];
//        
//    }];
//    
//    NSLog(@"%@",  NSStringFromCGRect([UIScreen mainScreen].bounds));
//    
//    
//    // 3.3 RAC高级写法:
//    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"flags.plist" ofType:nil];
//    
//    NSArray *dictArr = [NSArray arrayWithContentsOfFile:filePath];
//    // map:映射的意思，目的：把原始值value映射成一个新值
//    // array: 把集合转换成数组
//    // 底层实现：当信号被订阅，会遍历集合中的原始值，映射成新值，并且保存到新的数组里。
//    NSArray *flags = [[dictArr.rac_sequence map:^id(id value) {
//        
//        return [FlagItem flagWithDict:value];
//        
//    }] array];
}
- (void)click:(id)sender{
    SecondViewController * second = [[SecondViewController alloc] init];
    second.subject =[RACSubject subject];
    [second.subject subscribeNext:^(id x) {
        NSLog(@"点击了通知按钮%@",x);
    }];
    
    [self presentViewController:second animated:YES completion:nil];
}


@end
