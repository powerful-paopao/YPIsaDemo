#import <Foundation/Foundation.h>
#import <objc/runtime.h>


#define ISA_MASK            0x0000000ffffffff8ULL // isa掩码
#define ISA_MAGIC_MASK      0x000003f000000001ULL //
#define ISA_MAGIC_VALUE     0x000001a000000001ULL
#define ISA_NONPOINTER_MASK 0x0000000000000001ULL
#define ISA_ASSOC_MASK      0x0000000000000002ULL
#define ISA_HAS_CXX_DTOR    0x0000000000000004ULL
#define ISA_WEAKLY_MASK     0x0000040000000000ULL
#define ISA_DEALLOC_MASK    0x0000080000000000ULL
#define ISA_SIDETABLE_MASK  0x0000100000000000ULL
#define ISA_MAGIC_BITS_MASK 0x000003f000000000ULL

//// objc_object 结构体的简化版本
//struct objc_object {
//    // isa 指针，指向类对象
//    Class isa;  // 实际上是 isa_t 类型
//};

// isa_t 的结构 (ARM64)
union isa_t {
    isa_t() { }
    isa_t(uintptr_t value) : bits(value) { }
    
    Class cls;
    uintptr_t bits;
    
    // 位域结构
    struct {
        // 0. nonpointer
        uintptr_t nonpointer        : 1;  // 是否开启 isa 优化（指针优化）
        
        // 1. has_assoc
        uintptr_t has_assoc         : 1;  // 对象是否有关联对象
        
        // 2. has_cxx_dtor
        uintptr_t has_cxx_dtor      : 1;  // 是否有 C++ 析构函数
        
        // 3-35. shiftcls
        uintptr_t shiftcls          : 33; // 类指针
        
        // 36-41. magic
        uintptr_t magic             : 6;  // 用于调试器判断是否是 isa 指针
        
        // 42. weakly_referenced
        uintptr_t weakly_referenced : 1;  // 是否有弱引用指向
        
        // 43. deallocating
        uintptr_t deallocating      : 1;  // 是否正在释放
        
        // 44. has_sidetable_rc
        uintptr_t has_sidetable_rc  : 1;  // 引用计数是否过大
        
        uintptr_t pad               : 11; // 填充位
        
        // 45-63. extra_rc
        uintptr_t extra_rc          : 8; // 引用计数值
    };
};

@interface YPObjectStructure : NSObject

/// 获取对象的ISA
/// @param obj 实例对象
+ (uintptr_t)printObjectISA:(id)obj;

/// 获取对象的ISA结构
/// @param obj 实例对象
+ (isa_t *)printObjectISA_T:(id)obj;

+ (void)printObjectStructure:(id)obj;

/// 打印isa中各个位信息
/// @param obj 实例对象
+ (void)printISAStructure:(id)obj;
+ (void)printObjectInternals:(id)obj;

@end 
