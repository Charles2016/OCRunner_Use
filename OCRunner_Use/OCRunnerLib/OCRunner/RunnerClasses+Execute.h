//
//  ORunner+Execute.h
//  MangoFix
//
//  Created by Jiang on 2020/5/8.
//  Copyright © 2020 yongpengliang. All rights reserved.
//

// Cocoapods
#import "ORPatchFile.h"
// While need compile static framework
//#import "ORPatchFile.h"
#import <objc/runtime.h>


@class MFValue;
NS_ASSUME_NONNULL_BEGIN
@class MFScopeChain;
@protocol OCExecute <NSObject>
- (nullable MFValue *)execute:(MFScopeChain *)scope;
@end
@interface ORNode (Execute) <OCExecute>
- (nullable MFValue *)execute:(MFScopeChain *)scope;
@end
@interface ORTypeSpecial (Execute) <OCExecute>
- (nullable MFValue *)execute:(MFScopeChain *)scope;
@end
@interface ORVariable  (Execute) <OCExecute>
- (nullable MFValue *)execute:(MFScopeChain *)scope;
@end
@interface ORTypeVarPair (Execute) <OCExecute>
- (nullable MFValue *)execute:(MFScopeChain *)scope;
@end
@interface ORFuncVariable (Execute) <OCExecute>
- (nullable MFValue *)execute:(MFScopeChain *)scope;
@end
@interface ORFuncDeclare (Execute) <OCExecute>
- (nullable MFValue *)execute:(MFScopeChain *)scope;
@end
@interface ORValueExpression  (Execute) <OCExecute>
- (nullable MFValue *)execute:(MFScopeChain *)scope;
@end
@interface ORMethodCall (Execute) <OCExecute>
- (nullable MFValue *)execute:(MFScopeChain *)scope;
@end
@interface ORCFuncCall (Execute) <OCExecute>
- (nullable MFValue *)execute:(MFScopeChain *)scope;
@end
@interface ORScopeImp (Execute) <OCExecute>
- (nullable MFValue *)execute:(MFScopeChain *)scope;
@end
@interface ORFunctionImp (Execute) <OCExecute>
- (nullable MFValue *)execute:(MFScopeChain *)scope;
@end
@interface ORSubscriptExpression (Execute) <OCExecute>
- (nullable MFValue *)execute:(MFScopeChain *)scope;
@end
@interface ORAssignExpression  (Execute) <OCExecute>
- (nullable MFValue *)execute:(MFScopeChain *)scope;
@end
@interface ORDeclareExpression  (Execute) <OCExecute>
- (nullable MFValue *)execute:(MFScopeChain *)scope;
@end
@interface ORUnaryExpression  (Execute) <OCExecute>
- (nullable MFValue *)execute:(MFScopeChain *)scope;
@end
@interface ORBinaryExpression (Execute) <OCExecute>
- (nullable MFValue *)execute:(MFScopeChain *)scope;
@end
@interface ORTernaryExpression (Execute) <OCExecute>
- (nullable MFValue *)execute:(MFScopeChain *)scope;
@end

@interface ORIfStatement  (Execute) <OCExecute>
- (nullable MFValue *)execute:(MFScopeChain *)scope;
@end
@interface ORWhileStatement  (Execute) <OCExecute>
- (nullable MFValue *)execute:(MFScopeChain *)scope;
@end
@interface ORDoWhileStatement  (Execute) <OCExecute>
- (nullable MFValue *)execute:(MFScopeChain *)scope;
@end
@interface ORCaseStatement  (Execute) <OCExecute>
- (nullable MFValue *)execute:(MFScopeChain *)scope;
@end
@interface ORSwitchStatement  (Execute) <OCExecute>
- (nullable MFValue *)execute:(MFScopeChain *)scope;
@end
@interface ORForStatement  (Execute) <OCExecute>
- (nullable MFValue *)execute:(MFScopeChain *)scope;
@end
@interface ORForInStatement  (Execute) <OCExecute>
- (nullable MFValue *)execute:(MFScopeChain *)scope;
@end
@interface ORReturnStatement  (Execute) <OCExecute>
- (nullable MFValue *)execute:(MFScopeChain *)scope;
@end
@interface ORBreakStatement  (Execute) <OCExecute>
- (nullable MFValue *)execute:(MFScopeChain *)scope;
@end
@interface ORContinueStatement  (Execute) <OCExecute>
- (nullable MFValue *)execute:(MFScopeChain *)scope;
@end
@interface ORPropertyDeclare (Execute) <OCExecute>
- (nullable MFValue *)execute:(MFScopeChain *)scope;
@property (nonatomic, assign, readonly)  const objc_property_attribute_t * propertyAttributes;
@end
@interface ORMethodDeclare (Execute) <OCExecute>
- (nullable MFValue *)execute:(MFScopeChain *)scope;
@end
@interface ORMethodImplementation (Execute) <OCExecute>
- (nullable MFValue *)execute:(MFScopeChain *)scope;
@end
@interface ORClass (Execute) <OCExecute>
- (nullable MFValue *)execute:(MFScopeChain *)scope;
@end

@interface ORStructExpressoin (Execute) <OCExecute>
- (nullable MFValue *)execute:(MFScopeChain *)scope;
@end

@interface OREnumExpressoin (Execute) <OCExecute>
- (nullable MFValue *)execute:(MFScopeChain *)scope;
@end

@interface ORTypedefExpressoin (Execute) <OCExecute>
- (nullable MFValue *)execute:(MFScopeChain *)scope;
@end

@interface ORProtocol (Execute) <OCExecute>
- (nullable MFValue *)execute:(MFScopeChain *)scope;
@end

@interface ORCArrayVariable (Execute) <OCExecute>
- (nullable MFValue *)execute:(MFScopeChain *)scope;
@end

@interface ORUnionExpressoin (Execute) <OCExecute>
- (nullable MFValue *)execute:(MFScopeChain *)scope;
@end

NS_ASSUME_NONNULL_END
