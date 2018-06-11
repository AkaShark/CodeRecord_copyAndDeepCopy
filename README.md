---
title: 关于iOS的深浅拷贝
date: 2018-06-10 10:25:53
tags: iOS学习 面试学习
---

最近在准备面试~打算暑假的时候去面试去，去看一看公司的氛围，毕竟总是埋头苦学也不知道自己的水平咋样。去尝试下看看自己的分量。（还有上次说好了要更新上一篇提到的知识点的。。。）
<!--more-->
这两天看了一个ios的知识点关于深浅拷贝的问题，首先推荐几篇不错的[我觉得讲的超级好](https://www.zybuluo.com/MicroCai/note/50592)在这里也谢谢大佬们无私的分享，对应我这个的小白真的有很大的帮助~
好了接下来就来讲讲我的学习理解好实验吧~

# 写在前面
还有一篇大佬写的blog也是超级棒，[blog](http://www.fanliugen.com/?p=278)其实主要内容都是差不多。  然后废话说完了 开始我的记录。

# 首先
先说下什么叫做深复制和浅复制吧，深复制就像他的名字一样是一个深度的复制，意识就是说是将这个对象进行的复制，在内存空间中再开辟一不部分专门来放置这个复制的对象，而复制就是将指向这个对象的指针进行复制，复制一个新的指针指向原来的那一份内存空间，内存空间不再分配内存。
盗图大法~
![](https://ws1.sinaimg.cn/large/a4a9debbly1fs61mk33mdj20w20hoadl.jpg)
对于iOS系统提供的分为两种，一种是集合类（容器类）对象，另一种是非集合类（非容器类）现在分别来说下。

## 集合类的浅拷贝
我这里就用了blog里面的例子了，例子我也是一个一个尝试了没问题的。

```
NSArray *someArray = @[@"a",@"b",@"c"];
NSArray *shallowCopyArray = [someArray copyWithZone:nil];
NSSet *shallowCopySet = [NSSet mutableCopyWithZone:nil];
NSDictionary *shallowCopyDict = [[NSDictionary alloc] initWithDictionary:someDictionary copyItems:NO];
```
可以复制运行下，看看shallowArray和someArray的内存地址。（可以使用NSLog（@“%p”,someArray）;或者采用lldb的p来打印地址）
经过打印我们发现这个内存地址是不变的。很明显他们指向的内存地址是相同的这个就是一个浅拷贝，只是简单将指针进行了拷贝。

## 集合的深拷贝
```
NSDictionary *someDictionary = @{@"0":@"a",@"1":@"b"};
NSDictionary *shallowCopyDict = [[NSDictionary alloc] initWithDictionary:someDictionary copyItems:YES];
```
采用这种initWithArray：cpyItem设置YES是深拷贝这个someDicTionary这个对象，在内存开辟内存放着拷贝的someDicTionary对象（说下我自己的理解不知道对不对，我觉得这个字典是一个结构体，在结构体里面的键值对也是一个一个指针，指向键值对存放到内存空间，这个方法拷贝的只是这个结构体这个对象但是对于他厘米的指针采用的浅拷贝拷贝指针）这个在一篇大佬的blog写的叫做一层内存拷贝，说白了就是只是拷贝了这个对象但是对象内部的都采用的浅拷贝。

采用归档的方法创建的是真正意义上的深拷贝
```
NSArray *oldArray = @[@"a",@"b",@"c"];
NSArray *trueDeepCopyArray = [NSKeyedUnarchiver unarchiveObjectWithData:[NSKeyedArchiver archivedDataWithRootObject:oldArray]];
```
然后就是一些比较简单的东西记录下 直接引用大佬写的啦。

```
NSMutableString *string = [NSMutableString stringWithString: @"origin"];
//copy
NSString *stringCopy = [string copy];
NSMutableString *mStringCopy = [string copy];
NSMutableString *stringMCopy = [string mutableCopy];
//change value
[mStringCopy appendString:@"mm"]; //crash
[string appendString:@" origion!"];
[stringMCopy appendString:@"!!"];
```
这个运行会出现错误，但是为啥呢。~ 在`[mStringCopy appendString:@"mm"]; `在这句gg 因为mStringCopy是对一个NSMutableString进行了copy操作的，一个MU对象进行了copy有变成了一个不可变的对象，这个可以看下XCode上面的这个对象的isa指针指向的是NSString 然后对一个不可变对象你调用这个方法 那不就G了么。

```
在非集合类对象中：对immutable对象进行copy操作，是指针复制，mutableCopy操作时内容复制；对mutable对象进行copy和mutableCopy都是内容复制。用代码简单表示如下：

[immutableObject copy] // 浅复制
[immutableObject mutableCopy] //深复制
[mutableObject copy] //深复制
[mutableObject mutableCopy] //深复制
```


```
集合类对象是指NSArray、NSDictionary、NSSet ... 之类的对象。下面先看集合类immutable对象使用copy和mutableCopy的一个例子：

NSArray *array = @[@[@"a", @"b"], @[@"c", @"d"]],[NSMutableArray arrayWithObject:@"1",@"2"]];
NSArray *copyArray = [array copy];
NSMutableArray *mCopyArray = [array mutableCopy];
```
这个不可变的集合类和非集合类类似，但是这里有一点要说下，比如说我现在要去改变这个数组的最后一个元素。你该怎么办呢~因为采用copy是浅拷贝所以这个copyArray这个指针和原来的array指向的是一块内存空间。然而mCopyArray虽然是mutableCopy是一个深拷贝但是他拷贝的就是array这个对象，但是对其中的元素还是指针拷贝，所以这几个数组内元素对应的内存空间都是一样的，所以我们只要取出其中的一个然后修改就好了这个些数组都会改变的。
```
 NSMutableArray *muArray = [array  objectAtIndex:1];
 [muArray addObject:@[@"耶耶耶"]];
```
然后打印看看你的那些数组元素吧。这里还要说一下就是关于取出这个指针的时候不可以直接
```
[array lastObject] = @[@"ooo"];
```
这样的话是将@[@"ooo"]这个临时变量的付给了array lastObject这个改变了array lastObject这个指针，这样只会修改对应的哪一个数组的元素，但不会对应每个数组都生效的。
继续继续

```
NSMutableArray *array = [NSMutableArray arrayWithObjects:[NSMutableString stringWithString:@"a"],@"b",@"c",nil];
NSArray *copyArray = [array copy];
NSMutableArray *mCopyArray = [array mutableCopy];
```

```
在集合类对象中，对immutable对象进行copy，是指针复制，mutableCopy是内容复制；对mutable对象进行copy和mutableCopy都是内容复制。但是：集合对象的内容复制仅限于对象本身，对象元素仍然是指针复制。用代码简单表示如下：

[immutableObject copy] // 浅复制
[immutableObject mutableCopy] //单层深复制
[mutableObject copy] //单层深复制
[mutableObject mutableCopy] //单层深复制
```
总结下~：
```
1、对不可变的对象进行mutableCopy操作,是进行了一次深拷贝，返回的对象是可变的对象。

2、对不可变的对象进行copy操作，进行了一次浅拷贝，返回一个不可变的对象。

3、对可变得对象进行copy，进行了深拷贝，产生了不可变的对象副本。

4、 对可变的对象进行了一次mutableCopy，是进行了一次深拷贝， 返回的对象是一个可变的对象。

5、想要让自定义的对象支持copy和mutableCopy那么就要对应实现NSCopying协议，和NSMutableCopying协议。

retain和copy的区别：
 1、retain是对当前对象增加了一个指针指向，使对象的引用计数器加1， 是进行了一次安全的浅拷贝操作。
 2、copy是对当前对象进行了一次拷贝，重新拷贝了当前对象，当使用的时候减少了对当前对象的依赖。
```

好了就是这样了 这就我对应深浅拷贝的简单理解。 谢谢大佬们的帮助~
做下简单的记录 方便自己以后的学习。







