//
//  ViewController.m
//  RuntimeAPI
//
//  Created by linghang on 16/11/22.
//  Copyright © 2016年 wangjian. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
#import "CustomClass.h"
#import "PropertiesViewController.h"

@protocol TempProcotol <NSObject>

@required
- (void)tempPro;

@end

@interface ViewController ()
{
    NSString *varTest1;
    NSArray *varTest2;
    NSMutableArray *varTest3;
}

@property(nonatomic,copy)NSString *nameStr;
@property(nonatomic,strong)Protocol *tempPro;
@end
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //static NSString *classStr;

    char *c  = "ddd";

    //得到类的名称
    NSLog(@"classname:%s",class_getName([self class]));
    //得到supper类的名称
    NSLog(@"superclassname:%@",class_getSuperclass([self class]));
//判断类是不是基类
    NSLog(@"isMetaClass%d",class_isMetaClass([self class]));
    //类的大小
    NSLog(@"class_getInstanceSize:%zu",class_getInstanceSize([self class]));
    //获取类的属性类型
    Ivar ivar =     class_getInstanceVariable([self class], "varTest3");
    const char* typeEncoding =ivar_getTypeEncoding(ivar);
    NSString *stringType =  [NSString stringWithCString:typeEncoding encoding:NSUTF8StringEncoding];
    NSLog(@"stringType:%@",stringType);
    //返回一个指定的Ivar给定类的类变量，不知道为什么返回为空,这个方法不能用，没有成员变量
//    Ivar classIvar = class_getClassVariable([self class], "classStr");
//    const char* classTypeEncoding =ivar_getTypeEncoding(classIvar);
//
//    NSString *classType =  [NSString stringWithCString:classTypeEncoding encoding:NSUTF8StringEncoding];
//    NSLog(@"clasType:%@",classType);
//创建类添加属性和方法
    Class MyClass = [self createClass];
    
    //获取类的变量名称，包括属性名称
    unsigned int copyIvarCount = 0;
    Ivar *copyVars = class_copyIvarList([CustomClass class], &copyIvarCount);
    for (int i = 0; i < copyIvarCount; i++) {
        NSString *memberName = [NSString stringWithUTF8String:ivar_getName(copyVars[i])];
        NSLog(@"======ivarName:%@",memberName);
    }
    //获取类的属性，不包括变量名称，比较class_copyIvarList和class_copyPropertyList
    unsigned int propertiesCount = 0;
    //获取属性列表
    objc_property_t *properties = class_copyPropertyList([CustomClass class], &propertiesCount);
    
    for (int i = 0; i < propertiesCount; i++) {
        objc_property_t property = properties[i];
        //获取属性名称
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        NSLog(@"propertyName:%@",propertyName);
    }
    NSLog(@"ivarLayout:%s",class_getIvarLayout(MyClass));
    NSLog(@"weakIvarLayout:%s",class_getWeakIvarLayout(MyClass));
    
    
    //获取制定属性，不是变量，变量和属性不一样，不能获取属性，用途是判断有没有这个属性，propertyNmae这个为空，下边那个就崩溃，这个方法不怎么用
//    objc_property_t propertyNmae = class_getProperty([CustomClass class], "ivarStr");
//    //objc_property_t clas
//   NSString *propertyName3 = [[NSString alloc] initWithCString:property_getName(propertyNmae) encoding:NSUTF8StringEncoding];
//    NSLog(@"propertyName:%@",propertyName3);
    //获取类的方法,不能获取静态方法
    unsigned int methodCount = 0;
    //id objectClass = [CustomClass new];
    //objc_getClass([CustomClass class]);
    //;
    Method *method = class_copyMethodList([CustomClass class], &methodCount);
    
    
    for(int i = 0; i < methodCount; i++) {
        Method thisIvar = method[i];
        
        SEL sel = method_getName(thisIvar);
        const char *name = sel_getName(sel);
        
        
        
        NSLog(@"zp method :%s", name);
        
        
        
    }
    
    //获取指定的类方法
    Method getClassMethod = class_getClassMethod(objc_getClass("CustomClass"), @selector(test3));
    SEL sel = method_getName(getClassMethod);
    const char *name = sel_getName(sel);
    //free(getClassMethod);这个不能清空，清空会崩溃
    //获取指定的方法
    Method instanceMethod = class_getInstanceMethod(objc_getClass("CustomClass"), @selector(test1));
    SEL instanceMethodSel = method_getName(instanceMethod);
    const char *instanceName = sel_getName(instanceMethodSel);
   // free(instanceMethod);这个不能清空，清空会崩溃
    free(method);//一定要释放
//函数替换方法,替换的方法必须按照参数来写
   // BOOL class_addMethod(Class cls, SEL name, IMP imp,
            //             const char *types)
    //(MyClass, @selector(replaceClasstest:), 10)
    
    class_replaceMethod(MyClass, @selector(myclasstest:), (IMP)replaceClasstest, "@");
    id custom = [[MyClass alloc] init];
    [custom replaceClasstest:10];
    
    
    
    CustomClass *customClass = [[CustomClass alloc] init];
    [customClass test1];
    //获取函数的方法
    IMP methodIMP = class_getMethodImplementation([CustomClass class], @selector(test1));
    //现在这个方法不可用
   // IMP strectIMP = class_getMethodImplementation_stret([CustomClass class],@selector(test1));
    //判断类里边有没有这个函数
    BOOL respondsBool = class_respondsToSelector([CustomClass class], @selector(test6));
    BOOL classBool = [CustomClass instanceMethodForSelector:@selector(test1)];
    //向类里边添加协议
    BOOL protocolBool =  class_addProtocol([CustomClass class],@protocol(TempProcotol));
    //判断是否有这个协议
    BOOL jugeConforms =  class_conformsToProtocol([CustomClass class], @protocol(TempProcotol));
//查看有多少协议
   // unsigned int protocoCount = 0;
    
    // Copy Protocol List
    unsigned int numProtocols = 9999999;
  __unsafe_unretained Protocol **protocolList = class_copyProtocolList([CustomClass class], &numProtocols);
    printf("\nNum Protocols: %d\n", numProtocols);
    for (int i=0; i<numProtocols; i++) {
        Protocol *p = protocolList[i];
        printf("  %s\n", protocol_getName(p));
    }  
    free(protocolList);
   // 添加属性
    objc_property_attribute_t type = { "T", "@\"NSString\"" };
    objc_property_attribute_t ownership = { "C", "" }; // C = copy
    objc_property_attribute_t backingivar  = { "V", "_privateName" };
    objc_property_attribute_t attrs[] = { type, ownership, backingivar };
    
   // class_addProperty([CustomClass class], "name", attrs, 3);
    if (class_addProperty([CustomClass class], "nameStr", attrs, 3)) {
        NSLog(@"%sadd Property success",__func__);
    }else{
        NSLog(@"%sadd Property fail",__func__);
    }
    [self gainProperties:[CustomClass class]];
    [self gainAllVar:[CustomClass class]];
    
    //替换属性类型，没有的话，会创建
    objc_property_attribute_t attr0_ = { "T", "@\"NSArray\"" };
    objc_property_attribute_t attr1_ = { "&", "" };
    objc_property_attribute_t attr2_ = { "N", "" };
    objc_property_attribute_t attr3_  = { "V", "author" };
    objc_property_attribute_t attrs_[] = { attr0_, attr1_, attr2_,attr3_ };
    class_replaceProperty ( [CustomClass class], "nameStrStr", attrs_, 4 );
    //class_replaceProperty([CustomClass class], "nameStrStr", attrs, 3);
    NSLog(@"replace");
    [self gainProperties:[CustomClass class]];
    [self gainAllVar:[CustomClass class]];
    
    
    
    //获取类的版本
    class_setVersion([CustomClass class], 10);
    NSInteger versionInt = class_getVersion([CustomClass class]);
   //这两个函数不使用
    //objc_setFutureClass(),objc_getFutureClass，
    //  Used by Foundation's Key-Value Observing，不明白什么意思
    NSLog(@"dupicateClass:%@",objc_duplicateClass([CustomClass class], "timer", 0));
    
    
    // 创建类实例
    id class_createInstance ( Class cls, size_t extraBytes ); //会在heap里给类分配内存。这个方法和+alloc方法类似。
    
    // 在指定位置创建类实例,arc不能使用
    id objc_constructInstance ( Class cls, void *bytes );
    

    
    // 销毁类实例，arc不能使用
    void * objc_destructInstance ( id obj ); //不会释放移除任何相关引用
    //可以看出class_createInstance和alloc的不同
    //id theObject = class_createInstance(NSString.class, sizeof(unsigned));
//    id str1 = [theObject init];
//    NSLog(@"%@", [str1 class]);
//    id str2 = [[NSString alloc] initWithString:@"test"];
//    NSLog(@"%@", [str2 class]);
    //objc_set
//    [self objc_]
//    [My]
//    [[CustomClass class] objc_getFutureClass("CustomClass")];
//    objc_getFutureClass("CustomClass");
//    class_addProperty([CustomClass class], "customProperties", <#const objc_property_attribute_t *attributes#>, <#unsigned int attributeCount#>)
    //method_getName(<#Method m#>)
    
    /***************************************************************************/
    //对象使用
    CustomClass *customInstacneClass = [[CustomClass alloc] init];
   [self classInstance:customInstacneClass];
    //获取类定义
    [self obtainingClassDefinitions:[CustomClass class]];
    //变量的一些操作
    [self instanceVariablies];
   // class_replaceMethod(MyClass, @selector(myclasstest:), replaceClasstest(MyClass), @selector(replaceClasstest:), <#int a#>, <#const char *types#>)
    // prints
   // Ivar *layoutIvar = class_getIvarLayout([CustomClass class]);
    // Do any additional setup after loading the view, typically from a nib.
}
- (Class )createClass{
    //销毁类
    //objc_disposeClassPair([CustomClass class]);
    //创建类
    Class MyClass = objc_allocateClassPair([NSObject class], "myClass", 0);
    //添加一个NSString的变量，第四个参数是对其方式，第五个参数是参数类型,添加变量不是属性
    if (class_addIvar(MyClass, "itest", sizeof(NSString*), 0, "@")) {
        NSLog(@"add ivar success");
    }
    //myclasstest是已经实现的函数，"v@:"这种写法见参数类型连接
    class_addMethod(MyClass, @selector(myclasstest:), (IMP)myclasstest, "v@:");
    class_addMethod(MyClass, @selector(replaceClasstest:), (IMP)replaceClasstest, "v@:");

    //查看修饰符
    /*
    class_addIvar(MyClass, "_gayFriend", sizeof(id), log2(sizeof(id)), @encode(id));
    class_addIvar(MyClass, "_girlFriend", sizeof(id), log2(sizeof(id)), @encode(id));
    class_addIvar(MyClass, "_company", sizeof(id), log2(sizeof(id)), @encode(id));
    class_setIvarLayout(MyClass, (const uint8_t *)"\x01\x12"); // <--- new
    class_setWeakIvarLayout(MyClass, (const uint8_t *)"\x11\x10"); // <--- new
    Ivar weakIvar = class_getInstanceVariable(MyClass, "_girlFriend");
    Ivar strongIvar = class_getInstanceVariable(MyClass, "_gayFriend");
    id girl = [NSObject new];
    id boy = [NSObject new];
    object_setIvar(MyClass, weakIvar, girl);
    object_setIvar(MyClass, strongIvar, boy);
    
    NSLog(@"%@, %@", object_getIvar(MyClass, weakIvar), object_getIvar(MyClass, strongIvar));
     */
    
    
    //注册这个类到runtime系统中就可以使用他了
    objc_registerClassPair(MyClass);
    //生成了一个实例化对象
    id myobj = [[MyClass alloc] init];
    NSString *str = @"asdb";
    //给刚刚添加的变量赋值
    //	object_setInstanceVariable(myobj, "itest", (void *)&str);在ARC下不允许使用
    [myobj setValue:str forKey:@"itest"];
    //调用myclasstest方法，也就是给myobj这个接受者发送myclasstest这个消息
    [myobj myclasstest:10];

   
    return MyClass;
    
}
//这个方法实际上没有被调用,但是必须实现否则不会调用下面的方法
- (void)myclasstest:(int)a
{
    
}
//调用的是这个方法
static void myclasstest(id self, SEL _cmd, int a) //self和_cmd是必须的，在之后可以随意添加其他参数
{
    
    Ivar v = class_getInstanceVariable([self class], "itest");
    //返回名为itest的ivar的变量的值
    id o = object_getIvar(self, v);
    //成功打印出结果
    NSLog(@"%@", o);
    NSLog(@"int a is %d", a);
}
//被替换的方法
- (void)replaceClasstest:(int)a
{
    
}
//调用的是这个方法
static void replaceClasstest(id self, SEL _cmd, int a) //self和_cmd是必须的，在之后可以随意添加其他参数
{
    
//    Ivar v = class_getInstanceVariable([self class], "itest");
//    //返回名为itest的ivar的变量的值
//    id o = object_getIvar(self, v);
//    //成功打印出结果
//    NSLog(@"%@", o);
    NSLog(@"replace");
}
//获取属性列表
- (void)gainProperties:(Class)class{
    //获取类的属性，不包括变量名称，比较class_copyIvarList和class_copyPropertyList
    unsigned int propertiesCount = 0;
    //获取属性列表
    objc_property_t *properties = class_copyPropertyList(class, &propertiesCount);
    
    for (int i = 0; i < propertiesCount; i++) {
        objc_property_t property = properties[i];
        //获取属性名称
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        NSLog(@"propertyName:%@",propertyName);
        //获取属性类型
        NSString *attributesName = [[NSString alloc] initWithCString:property_getAttributes(property) encoding:NSUTF8StringEncoding];
        
        NSLog(@"attributesName:%@",attributesName);

    }
    free(properties);
}
//获取变量
- (void)gainAllVar:(Class)class{
    //获取类的变量名称，包括属性名称
    unsigned int copyIvarCount = 0;
    Ivar *copyVars = class_copyIvarList(class, &copyIvarCount);
    for (int i = 0; i < copyIvarCount; i++) {
        NSString *memberName = [NSString stringWithUTF8String:ivar_getName(copyVars[i])];
        NSLog(@"======ivarName:%@",memberName);
    }

}
#pragma mark - Class 创建
- (void)class_createInstance:(Class)class extraBytes:(size_t)extraBytes {
    //已经取消在10.0,创建类用另一个
//    CustomClass *tempPerson = class_createInstance(class, extraBytes);
//    tempPerson.str = @"instance creat Success";
//    NSLog(@"%s%@",__func__,tempPerson.str);
}
//实例对象使用
- (void)classInstance:(id )instanceObject{
    //复制对象，ARC不能使用
    //id object_copy(id obj, size_t size);
    //销毁对象，ARC不能使用
   // id object_dispose(id obj);
    //给变量赋值，ARC不能使用
    //Ivar object_setInstanceVariable(id obj, const char *name, void *value);
    //获取变量的值，ARC不能使用
    //Ivar object_getInstanceVariable(id obj, const char *name, void **outValue);
    //获取这块空间起始指针,10.0不能使用
    //void * object_getIndexedIvars(id obj);
    //得到变量的值
    Ivar ivar =     class_getInstanceVariable([CustomClass class], "strNum");

     id ivarObject = object_getIvar(instanceObject,ivar);
//给变量赋值
      object_setIvar(instanceObject, ivar, @"hello");
    id newIvarObject = object_getIvar(instanceObject,ivar);
//根据对象得到类的名称,
   //char *className = object_getClassName(instanceObject);
    NSLog(@"ClassName:%s",object_getClassName(instanceObject));
    //根据对象得到类
    Class tempClass = object_getClass(instanceObject);
    //object_setClass将一个对象设置为别的类类型，返回原来的Class
    Class setClass =  object_setClass(instanceObject, [UIViewController class]);
    //展示更换类型之后的class
    Class newTempClass = object_getClass(instanceObject);

    //NSLog(@"%@",object_getIndexedIvars(instanceObject));

    //objc_copy(
}
//Obtaining Class Definitions，获取类定义
- (void)obtainingClassDefinitions:(Class )definitionClass{
    //输出项目所有类
    int numClasses;
    Class *classes = NULL;
    
    classes = NULL;
    numClasses = objc_getClassList(NULL, 0);
    NSLog(@"Number of classes: %d", numClasses);
    
    if (numClasses > 0 )
    {
        classes = (__unsafe_unretained Class *)malloc(sizeof(Class) * numClasses);
        numClasses = objc_getClassList(classes, numClasses);
        for (int i = 0; i < numClasses; i++) {
            NSLog(@"Class name: %s", class_getName(classes[i]));
        }
        free(classes);
    }
    
    //创建并返回一个指向所有已注册类的指针列表

    unsigned int outCountClasses = 0;
    Class *copyClasses = NULL;
    copyClasses = objc_copyClassList(&outCountClasses);
    NSLog(@"copy of classes: %d", outCountClasses);
    if (outCountClasses > 0) {
        //根据返回指针，分配空间，
        copyClasses = (__unsafe_unretained Class*)malloc(sizeof(Class) * outCountClasses);
        outCountClasses = objc_getClassList(copyClasses, outCountClasses);
        for (int i = 0; i < outCountClasses; i++) {
            NSLog(@"copyClass name:%s",class_getName(copyClasses[i]));
        }
        free(copyClasses);
    }
    //根据名字返回类名，没有返回nil
    Class lookUpClass = objc_lookUpClass("CustomClasses");
    //返回类的类型
    id getClass = object_getClass(@"CustomClasses");
    //查看有没有这个对象，有的返回类型
     objc_getRequiredClass("CustomClass");
    //objc_getMetaClass,返回元类，三者区别
    NSLog(@"%@",objc_getMetaClass("CustomClass"));
    objc_getMetaClass("CustomClass");
}

//变量的一些操作
- (void)instanceVariablies{
    //获取类的变量名称，包括属性名称
    unsigned int copyIvarCount = 0;
    Ivar *copyVars = class_copyIvarList([CustomClass class], &copyIvarCount);
    for (int i = 0; i < copyIvarCount; i++) {
        NSString *memberName = [NSString stringWithUTF8String:ivar_getName(copyVars[i])];
        NSLog(@"======ivarName:%@",memberName);
    }
    free(copyVars);
    //获取类的属性类型
    Ivar ivar =     class_getInstanceVariable([self class], "varTest3");
    const char* typeEncoding =ivar_getTypeEncoding(ivar);
    NSString *stringType =  [NSString stringWithCString:typeEncoding encoding:NSUTF8StringEncoding];
    NSLog(@"stringType:%@",stringType);

    //实例变量偏移量
    ivar_getOffset(ivar);
    NSLog(@"offet:%td",ivar_getOffset(ivar));
   // free(ivar);
}
//关联的引用
- (void)associativeReferences{
    CustomClass *custom = [[CustomClass alloc] init];
    objc_setAssociatedObject(custom, "str", "strstr", <#objc_AssociationPolicy policy#>)
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end