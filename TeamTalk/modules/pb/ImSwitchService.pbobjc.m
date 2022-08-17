// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: IM.SwitchService.proto

// This CPP symbol can be defined to use imports that match up to the framework
// imports needed when using CocoaPods.
#if !defined(GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS)
 #define GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS 0
#endif

#if GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS
 #import <Protobuf/GPBProtocolBuffers_RuntimeSupport.h>
#else
 #import "GPBProtocolBuffers_RuntimeSupport.h"
#endif

#import "ImSwitchService.pbobjc.h"
// @@protoc_insertion_point(imports)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

#pragma mark - ImSwitchServiceRoot

@implementation ImSwitchServiceRoot

// No extensions in the file and no imports, so no need to generate
// +extensionRegistry.

@end

#pragma mark - ImSwitchServiceRoot_FileDescriptor

static GPBFileDescriptor *ImSwitchServiceRoot_FileDescriptor(void) {
  // This is called by +initialize so there is no need to worry
  // about thread safety of the singleton.
  static GPBFileDescriptor *descriptor = NULL;
  if (!descriptor) {
    GPB_DEBUG_CHECK_RUNTIME_VERSIONS();
    descriptor = [[GPBFileDescriptor alloc] initWithPackage:@"IM.SwitchService"
                                                     syntax:GPBFileSyntaxProto3];
  }
  return descriptor;
}

#pragma mark - IMP2PCmdMsg

@implementation IMP2PCmdMsg

@dynamic fromUserId;
@dynamic toUserId;
@dynamic cmdMsgData;

typedef struct IMP2PCmdMsg__storage_ {
  uint32_t _has_storage_[1];
  uint32_t fromUserId;
  uint32_t toUserId;
  NSString *cmdMsgData;
} IMP2PCmdMsg__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "fromUserId",
        .dataTypeSpecific.clazz = Nil,
        .number = IMP2PCmdMsg_FieldNumber_FromUserId,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(IMP2PCmdMsg__storage_, fromUserId),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeUInt32,
      },
      {
        .name = "toUserId",
        .dataTypeSpecific.clazz = Nil,
        .number = IMP2PCmdMsg_FieldNumber_ToUserId,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(IMP2PCmdMsg__storage_, toUserId),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeUInt32,
      },
      {
        .name = "cmdMsgData",
        .dataTypeSpecific.clazz = Nil,
        .number = IMP2PCmdMsg_FieldNumber_CmdMsgData,
        .hasIndex = 2,
        .offset = (uint32_t)offsetof(IMP2PCmdMsg__storage_, cmdMsgData),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeString,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[IMP2PCmdMsg class]
                                     rootClass:[ImSwitchServiceRoot class]
                                          file:ImSwitchServiceRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(IMP2PCmdMsg__storage_)
                                         flags:(GPBDescriptorInitializationFlags)(GPBDescriptorInitializationFlag_UsesClassRefs | GPBDescriptorInitializationFlag_Proto3OptionalKnown)];
    #if defined(DEBUG) && DEBUG
      NSAssert(descriptor == nil, @"Startup recursed!");
    #endif  // DEBUG
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end


#pragma clang diagnostic pop

// @@protoc_insertion_point(global_scope)