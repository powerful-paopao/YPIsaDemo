#import "YPObjectStructure.h"
#import <malloc/malloc.h>
#import <objc/runtime.h>
#import "yp-printf.h"

@implementation YPObjectStructure

+ (uintptr_t)printObjectISA:(id)obj {
    uintptr_t isa = *(uintptr_t *)(__bridge void *)obj;
    return isa;
}

+ (isa_t *)printObjectISA_T:(id)obj {
    isa_t * t = (isa_t *)(__bridge void *)obj;
    return t;
}

// 打印对象的基本结构
+ (void)printObjectStructure:(id)obj {
    printf("------------------对象的基本结构--------------\n");
    printf("对象地址: %p\n", obj);
    printf("对象大小: %zu bytes\n", malloc_size((__bridge const void *)obj));
    // isa的地址实际上是实例对象的地址
    printf("isa 地址: %p\n", (__bridge void *)obj);
    printf("isa 值: 0x016%lx\n", [self printObjectISA:obj]);
    
    uintptr_t isa = [self printObjectISA:obj];
    Class cls1 = (Class)(isa & ISA_MASK);
    Class cls2 = object_getClass(obj);
    printf("类对象地址: 0x016%lx, 实例对象isa指向的地址为：0x016%lx\n", (uintptr_t)cls1, (uintptr_t)cls2);
    
    uintptr_t cls_isa = *(uintptr_t *)(__bridge void *)cls1;
    Class metaCls1 = (Class)(cls_isa & ISA_MASK);
    Class metaCls2 = object_getClass(cls2);
    printf("元类对象地址: 0x016%lx，类对象isa指向的地址为：0x016%lx\n", (uintptr_t)metaCls1, (uintptr_t)metaCls2);
    
    uintptr_t meta_isa = *(uintptr_t *)(__bridge void *)metaCls1;
    Class rootCls1 = (Class)(meta_isa & ISA_MASK);
    Class rootCls2 = object_getClass(metaCls2);
    printf("根元类对象地址: 0x016%lx，元类对象isa指向的地址为：0x016%lx\n", (uintptr_t)rootCls1, (uintptr_t)rootCls2);
    
    Class rootCls_self = object_getClass(rootCls1);
    printf("根元类对象isa指向的地址为: 0x016%lx\n", (uintptr_t)rootCls_self);
    
//    const char * clsChar = [NSStringFromClass(cls) UTF8String];
//
//    Class metaCls1 =  objc_getMetaClass(clsChar);
//    printf("元类对象地址1: 016%p\n", metaCls1);

}

/// 打印 ISA 的详细结构
/// @param obj 实例对象
+ (void)printISAStructure:(id)obj {
    
    printf("------------------isa基本结构--------------\n");
    uintptr_t isa = [self printObjectISA:obj];
    printf("isa的内存结构为: %s\n", decimalToBinary(isa));
    printf("nonpointer: %d\n", (int)(isa & ISA_NONPOINTER_MASK));
    printf("has_assoc: %d\n", (int)((isa >> 1) & ISA_ASSOC_MASK));
    printf("has_cxx_dtor: %d\n", (int)((isa >> 2) & ISA_HAS_CXX_DTOR));
    printf("shiftcls: 0x%llx\n", (isa & ISA_MASK));
    printf("magic: 0x%llx\n", (isa & ISA_MAGIC_BITS_MASK) >> 36);
    printf("weakly_referenced: %d\n", (int)((isa & ISA_WEAKLY_MASK) >> 42));
    printf("deallocating: %d\n", (int)((isa & ISA_DEALLOC_MASK) >> 43));
    printf("has_sidetable_rc: %d\n", (int)((isa & ISA_SIDETABLE_MASK) >> 44));
    printf("extra_rc: %ld\n", (isa >> 56));
}

// 打印对象的内部信息
+ (void)printObjectInternals:(id)obj {
    NSLog(@"\n======= Object Internals =======");
    
    // 获取类名
    NSLog(@"类名: %@", NSStringFromClass([obj class]));
    
    // 获取成员变量信息
    unsigned int count;
    Ivar *ivars = class_copyIvarList([obj class], &count);
    NSLog(@"\n实例变量列表:");
    for (unsigned int i = 0; i < count; i++) {
        Ivar ivar = ivars[i];
        NSLog(@"名称: %s, 类型: %s", ivar_getName(ivar), ivar_getTypeEncoding(ivar));
    }
    free(ivars);
    
    // 获取属性信息
    objc_property_t *properties = class_copyPropertyList([obj class], &count);
    NSLog(@"\n属性列表:");
    for (unsigned int i = 0; i < count; i++) {
        objc_property_t property = properties[i];
        NSLog(@"名称: %s, 特性: %s", property_getName(property), property_getAttributes(property));
    }
    free(properties);
}

@end 
