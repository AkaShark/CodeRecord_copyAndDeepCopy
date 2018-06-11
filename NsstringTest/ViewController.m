//
//  ViewController.m
//  NsstringTest
//
//  Created by kys-20 on 2018/5/28.
//  Copyright © 2018年 kys-20. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    NSMutableString *string = [NSMutableString stringWithFormat:@"haha"]; // copy
//    NSString *stringCopy = [string copy];
//    string = [NSMutableString stringWithFormat:@"%@",@"lala"];
////    [string appendString:@"可变的"];
//
//    NSLog(@"%@",stringCopy);
//
//    NSLog(@"%p",string);
//
//    NSLog(@"%p",stringCopy);
//
//
//    char a[20] = "sadasdasd";
//
//    NSString *str1 = [NSString stringWithUTF8String:a];
//    NSLog(@"str-->%@",str1);
//    [self setShallowCopy];
    [self deepCopy];
//    [self copyAndMutableCopy];
//    [self setObjCopy];
//    [self setMObjCopy];
//    [self StringTest];
}
- (void)StringTest
{
    NSString *str = @"string";
    str = @"newString";
    
}
- (void)setMObjCopy
{
    NSMutableArray *array = [NSMutableArray arrayWithObjects:@[@"a"],@"b",@"c",@"d", nil];
    NSArray *copyArray = [array copy];
//    array[1] = @"cc"; //这样修改的话是相当于将@“cc”这个临时变量赋值给array[1]这个指针，相当与是改变了指针的内容 指向数组的第2个元素的指针发生了变化
    
    NSString *str = [array objectAtIndex:1];
    [str stringByAppendingString:@"!!!"];
    
    
    NSMutableArray *mCopyArray = [array mutableCopy];
    
    
    NSLog(@"");
}

- (void)setObjCopy
{
    NSArray *arry = @[@[@"a",@"b"],@[@"c",@"d"]];
    NSArray *copyArray = [arry copy];
    NSMutableArray *mCopyArray = [arry mutableCopy];
    
}

- (void)mutableObjCopy
{
    NSMutableString *string = [NSMutableString stringWithString:@"origin"];
    NSString *stringCopy = [string copy];
    NSMutableString *mStringCopy = [string copy];
//    可变copy=不可变 stringCopy mStringCopy 是同一个东西 内存地址相同
    NSMutableString *stringMCopy = [string mutableCopy];
//    [mStringCopy appendString:@"mm"];
    
    [string appendString:@"origion!"];
    [stringMCopy appendString:@"!!"];
    
}

- (void)copyAndMutableCopy
{
    NSString *string = @"origin";
//    浅拷贝
    NSString *stringCopy = [string copy];
    NSMutableString *stringMCopy = [string mutableCopy]; //深拷贝
    NSLog(@"");
    
}


- (void)setShallowCopy
{
    NSArray *array = @[@"a",@"b",@"c",@"d"];
    NSDictionary *dic = @{@"0":@"a",@"1":@"b",@"2":@"c"};
    NSArray *shallowCopyArray = [array copyWithZone:nil];
    NSDictionary *shallowCopyDic = [[NSDictionary alloc] initWithDictionary:dic copyItems:NO];
    NSLog(@"");
   
}

- (void)deepCopy
{
    NSDictionary *dic = @{@"0":@"a"};
    NSDictionary *shallowCopyDic = [[NSDictionary alloc] initWithDictionary:dic copyItems:YES];
    NSLog(@"");
   
//    NSArray *array = @[@"0",@"1"];
//    NSArray *tureDeepCopyArray = [NSKeyedUnarchiver unarchiveObjectWithData:[NSKeyedArchiver archivedDataWithRootObject:array]];

}

- (void)test
{
 
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
