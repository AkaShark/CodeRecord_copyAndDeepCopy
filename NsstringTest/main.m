//
//  main.m
//  NsstringTest
//
//  Created by kys-20 on 2018/5/28.
//  Copyright © 2018年 kys-20. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        /*
         argc、argv：直接传递给UIApplicationMain进行相关处理即可
         
         * principalClassName：指定应用程序类名（app的象征），该类必须是UIApplication(或子类)。如果为nil,则用UIApplication类作为默认值
         
         * delegateClassName：指定应用程序的代理类，该类必须遵守UIApplicationDelegate协议
         
         •  UIApplicationMain函数会根据principalClassName创建UIApplication对象，根据delegateClassName创建一个delegate对象，并将该delegate对象赋值给UIApplication对象中的delegate属性
         
         •  接着会建立应用程序的Main Runloop（事件循环），进行事件的处理(首先会在程序加载完毕后调用delegate对象的application:didFinishLaunchingWithOptions:方法)
         
         *  程序正常退出时UIApplicationMain函数才返回
         */
        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
