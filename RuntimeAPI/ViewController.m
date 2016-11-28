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
#import <objc/message.h>
#import "HYBMethodLearn.h"
typedef struct objc_super *superClass;


@protocol TestProtocl <NSObject>

- (void)testProtocol2;

@end

@protocol TempProcotol <NSObject,TestProtocl>

@required
- (void)tempPro;
- (void)temp2Pro;
@property(nonatomic,strong)NSString *str1;
@property(nonatomic,strong)NSString *str2;
@end

//struct objc_super {
//   // id receiver;
//    //NSString *namel;
//    NSInteger intName;
//    Class tempClass;
//};

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

//    UILabel *nameLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, 300, 700)];
//    nameLab.text = @"各全国学会、协会、研究会：\n 为规范和加强中国科协“青年人才托举工程”项目的管理，现将《青年人才托举工程项目管理办法（试行）》印发你们，请遵照执行。\n \n \n \n 中国科协办公厅\n 2016年7月1日\n\r\n青年人才托举工程项目管理办法（试行）\\n第一章 总 则\\n第一条 为规范和加强中国科协青年人才托举工程项目（以下简称本项目）管理及实施，根据《中国科协项目管理办法（试行）》及相关法律法规，制定本管理办法。\\n第二条 本项目旨在引导中国科协所属全国学会（学会联合体）探索创新青年科技人才的选拔机制、培养模式和评价标准，鼓励32岁以下青年科技工作者开展原创性研究，支持他们在创造力黄金期脱颖而出。\\n第三条 中国科协对项目承担单位开展青年人才托举工作，按照3年一周期，给予定额补助，所需经费由中国科协向中央财政申请或向社会筹集。\\n第四条 本项目管理遵循以下原则：\\n（一）服务大局，明确目标。坚持把学会服务国家全面深化改革大局作为根本出发点和落脚点，推动学会持续改革创新，不断提升学会服务凝聚科技工作者的能力。\\n（二）创新模式,稳定支持。引导学会积极探索选拔、扶持和评价青年科技人才的有效路径和模式，为国家人才制度改革探索路径、积累经验、提供案例。\\n（三）加强监管,注重实效。在中央财政资金支持基础上,积极募集社会资金,对项目工作进行持续稳定支持。项目实行年度绩效检查，采取优胜劣汰滚动机制，对托举对象的学术行为轨迹进行跟踪记录，对项目绩效进行过程评估。\\n第五条 本项目由中国科协具体组织实施。\\n第二章 职责与分工\\n第六条 中国科协负责项目的组织策划、统筹协调、总体部署等工作，并委托中国科协直属单位或第三方机构承担项目的具体实施工作；中国科协所属全国学会（学会联合体）作为项目承担单位负责按照约定方案开展项目具体实施工作,并制定相关管理细则报送中国科协备案。\\n第七条 项目承担单位主要职责为：\\n（一）负责本单位项目申报、实施和总结工作；\\n（二）负责制定人才培养方案及评价机制、项目经费管理细则等，负责项目经费的执行工作；\\n（三）接受中国科协的监督，并按要求提供项目预算执行情况和有关财务资料。\\n（四）以学会联合作为项目承担单位的，由牵头学会负责项目的实施工作。\\n第八条 托举对象的主要职责为：\\n（一）在项目承担单位的组织下配合项目申报工作；\\n（二）积极落实培养实施计划；\\n（三）配合中国科协的各项监督工作并及时反馈有关意见。\\n第三章 申报与立项\\n第九条 中国科协所属全国学会（学会联合体）为本项目承担单位。采用项目承担单位集中申报制，不受理个人申报。\\n第十条 中国科协学会学术部负责制定项目评审办法，组织召开评审会议。评审会采用项目申报单位现场答辩，专家评审的方式进行。\\n第十一条 项目承担单位须每年度签署《中国科学技术协会项目任务书》（以下简称《项目任务书》）。《项目任务书》作为项目管理和项目总结验收的主要依据。\\n第十二条 《项目任务书》主要包括项目目标、工作任务、考核指标和费用预算等四部分内容。具体要求如下：\\n（一）项目目标：项目目标应界定清晰，必须有量化指标，对于定性指标也应采用分级分档等形式予以明确。\\n（二）工作任务：工作任务应按项目目标设定，做到每一项目标都有明确的任务，所有的工作任务汇总起来能达成全部项目目标。\\n（三）考核指标：包括质量指标、时间指标、财务指标等，考核指标应与项目目标和任务相对应。\\n（四）费用预算：项目承担单位要按照《中国科协项目管理办法（试行）》及相关法律法规编制预算。\\n第四章 管理与实施\\n第十三条 中国科协依据项目管理办法，对项目的实施过程和经费使用进行监督检查。\\n第十四条 项目经费主要用于项目承担单位扶持选定的青年人才的学术成长所发生的各项直接支出，不得用于项目承担单位的基本建设、对外投资、罚款、捐赠、工作人员工资及福利等。鼓励有条件的项目承担单位给予托举对象人力、物力以及配套资金支持。\\n第十五条 中国科协培训和人才服务中心负责对托举对象学术行为轨迹进行跟踪记录，建立基于大数据的项目绩效评估体系，定期编制项目进展分析报告。具体落实人才培养工作的绩效评价工作。\\n第十六条 项目承担单位要建立项目实施信息公开和社会监督机制，广泛接受社会各方面监督。\\n第十七条 项目承担单位应将项目实施工作纳入重要议事日程，完善工作机制，落实有关方面责任，并为项目完成提供必要的条件，确保项目的实施、完成，并按规定督促项目负责人做好项目的结题（验收）工作。\\n第十八条 项目获准立项后，周期为3年，项目承担单位应设立项目负责人，主要负责项目周期内的实施工作。项目执行过程中，原则上不得变更托举人选。若需更改实施计划、变更托举人选、提前结题或延长项目时间的，项目承担单位应提出书面报告，上报中国科协批准。若托举对象在培养周期内入选国家其他人才计划，个人可提出不再接受该项目资助，项目单位可以将未支出资金用于支持本单位后续入选的其他托举对象，书面报告中国科协批准。\\n第十九条 项目承担单位对项目计划执行不力或难以按原定计划完成的项目，可建议予以终止、撤销立项，项目承担单位应及时写出阶段工作总结，上报中国科协同意后办理有关手续。\\n第二十条 项目接收拨款单位与项目承担单位必须一致。项目承担单位须指定专门银行账户，按项目单独核算。项目承担单位的银行账户等信息发生变更,应及时函告中国科协。\\n第二十一条 项目经费分年度进行划拨，项目承担单位应按照《项目任务书》内约定的经费支出计划，在相应年度内完成经费支出。\\n第五章 总结与验收\\n第二十二条 项目结项时须提交年度绩效报告、项目承担单位对托举对象的绩效考核报告、项目自评报告、经费使用情况报告、三年总结报告等。\\n第二十三条 结项报告应以《项目任务书》的规定为依据，能够完成《项目任务书》确定的全部目标。\\n第二十四条 中国科协对于结项报告予以接受、验收、审计和评价。对结项报告的后续使用由中国科协负责，项目承担单位不得超出《项目任务书》约定的范围和方式使用结项报告。\\n第二十五条 中国科协将对弄虚作假、虚报业绩等违规行为，依照《中国科协项目管理办法（试行）》进行严肃查处，限期整改。对整改不力的项目承担单位进行通报批评，同时连续3年取消其申报资格。对涉嫌违法违纪的，提交国家司法机关追究当事人责任。\\n第六章 附 则\\n第二十六条 本办法由中国科协学会学术部负责解释和修订。\\n第二十七条 本办法自发布之日起施行。\r\n\r\n[table=98%]\r\n[tr][td=273]中国科协办公厅\\n[/td][td=316]2016年7月6日印发 \\n[/td][/tr]\r\n[/table]\r\n\r\n";
//    nameLab.numberOfLines = 0;
//    [self.view addSubview:nameLab];
//    nameLab.textColor = [UIColor redColor];
    
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
  // [self classInstance:customInstacneClass];
    //获取类定义
    [self obtainingClassDefinitions:[CustomClass class]];
    //变量的一些操作
    [self instanceVariablies];
    //发送消息，一定要导入头文件
    [self objc_msg];
    //方法调用
    [self methodInvoke];
    //关于库的一些方法
    [self workWithLibrariesMethods];
    //方法器的使用
    [self workWithSelector];
    //协议相关的方法
    [self protocoalMethod];
    //属性的方法
    [self methodRelatedProperties];
    
    //使用objective - c语言特性
    [self usingObjectCLanguageFeature];
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
    static char overviewKey;
    NSArray * array =[[NSArray alloc] initWithObjects:@"One", @"Two", @"Three", nil];
    //为了演示的目的，这里使用initWithFormat:来确保字符串可以被销毁
    NSString * overview = [[NSString alloc] initWithFormat:@"%@",@"First three numbers"];
    objc_setAssociatedObject(array, &overviewKey, overview, OBJC_ASSOCIATION_RETAIN);
    NSString * associatedObject = (NSString *)objc_getAssociatedObject(array, &overviewKey);
    //断开关联
    objc_setAssociatedObject(array, &overviewKey, nil, OBJC_ASSOCIATION_ASSIGN);
//移除关联
    objc_removeAssociatedObjects(array);

}
//发送消息
- (void)objc_msg{
//    SEL testFunc = NSSelectorFromString(@"sendMessage");
//    
//    objc_msgSend(self, testFunc, 10);
    //调用这个方法时候，在building里边搜索objc,把objc_msg call设置为NO
    id  returnValue = objc_msgSend(self,
                                  @selector(sendMessage:),
                                  10);
    
    //Arm64位不能使用,返回结构体
    //CGRect frame = objc_msgSend_stret(view, @selector(frame));

    //struct objc_super { id receiver; Class class; };
    //objc_msgSendSuper(super, @selector(sendMessage:),10);
    
    //输出，i386
   // objc_msgSend_fpret(self, @selector(sendMessage:),10);
    
    //objc_msgSend_stret(self, @selector(sendMessage:),10);
    //64位取消
    //void objc_msgSendSuper_stret(struct objc_super *super, SEL op, ...);

}
- (NSString *)sendMessage:(NSInteger)a{
    NSLog(@"aaaa%ld",a);
    return @"dd";
}
//方法调用
- (void)methodInvoke{
    //调用一个方法
    //Method *method = sel
    // 获取方法
    Method method = class_getInstanceMethod([self class], @selector(sendMessage:));
    //调用方法
    method_invoke(self, method,100);
    //不支持64位
    //method_invoke_stret(<#id receiver#>, <#Method m, ...#>)
    //得到方法名
    SEL selMethod = method_getName(method);
    const char *selName = sel_getName(method_getName(method));
    
    NSString *selnameStr = [[NSString alloc] initWithCString:selName encoding:NSUTF8StringEncoding];
    //获取方法对象
    IMP impMethod = method_getImplementation(method);
    //获取方法的类型
    const char *typeMethod = method_getTypeEncoding(method);
    NSString *typeMethodStr = [[NSString alloc] initWithCString:typeMethod encoding:NSUTF8StringEncoding];
    //复制返回值类型，一定要释放
    const char *copyTypeMethod = method_copyReturnType(method);
    NSString *copyTypeMethodStr = [[NSString alloc] initWithCString:copyTypeMethod encoding:NSUTF8StringEncoding];
    //free(&copyTypeMethod);//一定要释放
    //获取方法的指定位置参数的类型字符串
    Method argumentMethod = class_getInstanceMethod([self class], @selector(tempSendMessage:andString:));
    unsigned int methodInt = 0;
    const char *argureMent = method_copyArgumentType(argumentMethod, 2);
    //NSString *argumentStr = [[NSString alloc] initWithCString:argureMent encoding:NSUTF8StringEncoding];
    // 通过引用返回方法的返回值类型字符串
    //void method_getReturnType ( Method m, char *dst, size_t dst_len );
    //void method_getReturnType(Method m, char *dst, size_t dst_len);
//获取函数参数
    NSInteger methodArgumentInt = method_getNumberOfArguments(argumentMethod);
    
    //通过引用返回方法指定位置参数的类型字符串
    //method_getArgumentType(argumentMethod, 2, <#char *dst#>, <#size_t dst_len#>)
    
    //所有函数实现方法
    HYBMethodLearn *hybMethod = [[HYBMethodLearn alloc] init];
    [hybMethod getMethods];
    //函数描述
    typedef struct  objc_method_description *methodDescription;
    //methodDescription  =  method_getDescription(method);
    
    NSLog(@"description:%@",NSStringFromSelector(method_getDescription(method)->name));
    //返回前一个函数方法
    IMP methodIMP = class_getMethodImplementation([self class], @selector(sendMessage:));
    IMP newIMP = method_setImplementation(argumentMethod, methodIMP);
    //函数方法交换,后边跟前边交换
    method_exchangeImplementations(method, argumentMethod);
    [self tempSendMessage:@"a" andString:@"b"];
    //*methodDescription  =  method_getDescription(method);
}

- (void)tempSendMessage:(NSString *)a andString:(NSString *)b{
    NSLog(@"tempSendmesssage");
}

/*
 Type Encoding
 
 下面是官方给出的所有类型编码，数据类型的编码最终值会有可能是下面中的多个的组合：
 
 编码值	含意
 c	代表char类型
 i	代表int类型
 s	代表short类型
 l	代表long类型，在64位处理器上也是按照32位处理
 q	代表long long类型
 C	代表unsigned char类型
 I	代表unsigned int类型
 S	代表unsigned short类型
 L	代表unsigned long类型
 Q	代表unsigned long long类型
 f	代表float类型
 d	代表double类型
 B	代表C++中的bool或者C99中的_Bool
 v	代表void类型
 *	代表char *类型
 @	代表对象类型
 #	代表类对象 (Class)
 :	代表方法selector (SEL)
 [array type]	代表array
 {name=type…}	代表结构体
 (name=type…)	代表union
 bnum	A bit field of num bits
 ^type	A pointer to type
 ?	An unknown type (among other things, this code is used for function pointers)
 
 
 
 */
//库的工作
- (void)workWithLibrariesMethods{
    unsigned int outCount = 0;
    NSLog(@"获取指定类所在动态库");
    NSLog(@"UIView's Framework: %s",class_getImageName(NSClassFromString(@"UIView")));
    NSLog(@"获取指定库或框架中所有类的类名");
    // 获取所有加载的Objective-C框架和动态库的名称
    const char **copyOImageArr = objc_copyImageNames(&outCount);

    for (unsigned int j = 0; j < outCount; j++) {
        NSString *classStr = [[NSString alloc] initWithCString:copyOImageArr[j] encoding:NSUTF8StringEncoding];
        //获取动态库名称
        NSLog(@"className:%@",classStr);
        unsigned int tempOutCount = 0;
        //获取动态库的类名称
        const char **classes = objc_copyClassNamesForImage(copyOImageArr[j],&tempOutCount);
        for (int i = 0; i < tempOutCount; i++){
            NSLog(@"class name: %s", classes[i]);
        }

    }
    
    }
//方法器工作
- (void)workWithSelector{
    //获取方法名称
    const char *selGetName = sel_getName(@selector(sendMessage:));
    NSString *selGetNameStr = [[NSString alloc] initWithCString:selGetName encoding:NSUTF8StringEncoding];
    //注册方法
    SEL selName = sel_registerName("sel_register");
    //查看方法有没有
    const char *getNewName = sel_getName(@selector(sel_register));
    NSString *newGetNameStr = [[NSString alloc] initWithCString:getNewName encoding:NSUTF8StringEncoding];
    //先看这个方法有没有，没有的话就注册
    SEL getUidName = sel_getUid("sel_register2");
    const char *getUidNewName = sel_getName(@selector(sel_register2));
    NSString *newGetUidNameStr = [[NSString alloc] initWithCString:getUidNewName encoding:NSUTF8StringEncoding];
//判断两个方法相不相等
    BOOL rigisterBool = sel_isEqual(@selector(sel_register2), @selector(sel_register));
    
    
}
//跟协议相关的东西
- (void)protocoalMethod{
    //通过名称得到协议，协议不存在，则返回null
    Protocol *protocolName = objc_getProtocol("TempProcotol");
    //获取所有协议
    unsigned int protocolCount = 0;
   __unsafe_unretained Protocol **protocolPoint = objc_copyProtocolList(&protocolCount);
    for (NSInteger i = 0; i < protocolCount; i++) {
        const char *protocolName = protocol_getName(protocolPoint[i]);
        NSString *protocolStr = [[NSString alloc] initWithCString:protocolName encoding:NSUTF8StringEncoding];
        NSLog(@"protocolNamw%@",protocolStr);
    }
    free(protocolPoint);
    //创建协议，必须注册，这两个必须是成对出现
    Protocol *allocateProtocol = objc_allocateProtocol("NewProtocol");
    objc_registerProtocol(allocateProtocol);
    Protocol *protocolGetName = objc_getProtocol("NewProtocol");

    const char *protocolNamePro = protocol_getName(allocateProtocol);
    NSString *protocolStr = [[NSString alloc] initWithCString:protocolNamePro encoding:NSUTF8StringEncoding];
    NSLog(@"protocolNamw%@",protocolStr);

    //给协议添加方法，需要强调的是，协议一旦注册后就不可再修改，即无法再通过调用protocol_addMethodDescription、protocol_addProtocol和protocol_addProperty往协议中添加方法等。
    protocol_addMethodDescription(@protocol(TempProcotol), @selector(readMesaage), "@", YES, YES);
    // 添加属性
    objc_property_attribute_t type = { "T", "@\"NSString\"" };
    objc_property_attribute_t ownership = { "C", "" }; // C = copy
    objc_property_attribute_t backingivar  = { "V", "_privateName" };
    objc_property_attribute_t attrs[] = { type, ownership, backingivar };

    protocol_addProperty(@protocol(TempProcotol), "protocolName", attrs, 3, YES, YES);
    //获取协议所有方法
    unsigned int methodDescriptionCount = 0;
     struct objc_method_description *methodDescription =  protocol_copyMethodDescriptionList(@protocol(TempProcotol), YES, YES, &methodDescriptionCount);
    for (NSInteger i = 0; i < methodDescriptionCount; i++) {
        NSString *strGet = [[NSString alloc] initWithCString:sel_getName(&(methodDescription->name)[i]) encoding:NSUTF8StringEncoding];
        NSLog(@"protocolMethodName:%@",strGet);

    }
    free(methodDescription);
    //获取协议具体方法,名称
    struct objc_method_description methodGetDescription =protocol_getMethodDescription(@protocol(TempProcotol), @selector(tempPro), YES, YES);
    NSString *strGet2 = [[NSString alloc] initWithCString:sel_getName(methodGetDescription.name) encoding:NSUTF8StringEncoding];
    NSLog(@"protocolMethodName:%@",strGet2);
    //获取协议的所有属性
    unsigned int propertiesProtocolCount = 0;
    objc_property_t *protocolPertiesArr = protocol_copyPropertyList(@protocol(TempProcotol), &propertiesProtocolCount);
    for (NSInteger i = 0; i < propertiesProtocolCount; i++) {
        const char *protocolPropertiesName = property_getName(protocolPertiesArr[i]);
        NSString *protocolProprtiesNameStr = [[NSString alloc] initWithCString:protocolPropertiesName encoding:NSUTF8StringEncoding];
        NSLog(@"PropertiesProtocolName:%@",protocolProprtiesNameStr);
    }
    free(protocolPertiesArr);
    //获取协议某一个属性
    objc_property_t getOneProtocolProperty = protocol_getProperty(@protocol(TempProcotol), "str1", YES, YES);
    const char *protocolOnePropertyName = property_getName(getOneProtocolProperty);
    NSString *protocolOneProprtyNameStr = [[NSString alloc] initWithCString:protocolOnePropertyName encoding:NSUTF8StringEncoding];
    NSLog(@"PropertiesProtocolName:%@",protocolOneProprtyNameStr);
    //获取一个协议遵守的其他协议,就是<里边的协议方法>
    unsigned int copyProtocolCount = 0;
    __unsafe_unretained Protocol **protocolArr = protocol_copyProtocolList(@protocol(TempProcotol), &copyProtocolCount);
    for (NSInteger i = 0 ; i < copyProtocolCount; i++) {
        const char *protocolName = protocol_getName(protocolArr[i]);
        NSString *protocolNameStr = [[NSString alloc] initWithCString:protocolName encoding:NSUTF8StringEncoding];
        NSLog(@"protocolNameStr:%@",protocolNameStr);
    }
    free(protocolArr);
    //第一个协议遵守第二个协议
    BOOL conformBool = protocol_conformsToProtocol(@protocol(TempProcotol), @protocol(TestProtocl));
}
//属性的方法
- (void)methodRelatedProperties{
    //获取属性名称
    objc_property_t property = class_getProperty([self class], "nameStr");

    NSString *propertyNameStr = [[NSString alloc] initWithCString:     property_getName(property) encoding:NSUTF8StringEncoding];
    //获取属性特性描述字符串
    /**
     "T@\"NSString\",C,N,V_nameStr"

     属性类型  name值：T  value：变化
     编码类型  name值：C(copy) &(strong) W(weak) 空(assign) 等 value：无
     非/原子性 name值：空(atomic) N(Nonatomic)  value：无
     变量名称  name值：V  value：变化
     */
    
    //获取属性特性的value值
    const char *propertyAttributies = property_getAttributes(property);
    
    objc_property_attribute_t type = { "T", "@\"NSString\"" };

   char *attribute =  property_copyAttributeValue(property, "T");
    NSString *propertyAttributiesStr = [[NSString alloc] initWithCString:     attribute encoding:NSUTF8StringEncoding];
//获取一个属性的所有特性值
    unsigned int copyAttributeCount = 0;
    objc_property_attribute_t *attributeArr = property_copyAttributeList(property, &copyAttributeCount);
    for (NSInteger i = 0; i <  copyAttributeCount; i++) {
        objc_property_attribute_t propertyAttribute = attributeArr[i];
        NSLog(@"name:%s,value%s",propertyAttribute.name,propertyAttribute.value);
    }
    free(attributeArr);
}
//使用objective - c语言特性
- (void)usingObjectCLanguageFeature{
    // 通过在一个foreach循环中检测到突变的编译器插入。
    //void objc_enumerationMutation(id obj)
    // 设置突变处理
    //void objc_setEnumerationMutationHandler(void (*handler)(id))
    objc_setEnumerationMutationHandler([self mutArr:@"dd"]);
    NSMutableString *mutStr = [NSMutableString stringWithCapacity:0];
    [mutStr appendString:@"dd"];
    NSLog(@"enumeration:%@",[self mutArr:@"dd"]);
    objc_enumerationMutation(mutStr);
    //NSLog(@"%@",)
}
- (void*)mutArr:(id)object{
    NSMutableArray *tempArr = [NSMutableArray arrayWithCapacity:0];
    [tempArr addObject:@"0"];
    [tempArr addObject:@"1"];
    [tempArr addObject:object];
    return (__bridge void *)(tempArr);
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
