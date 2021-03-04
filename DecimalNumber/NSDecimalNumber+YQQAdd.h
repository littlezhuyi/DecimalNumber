//
//  NSDecimalNumber+YQQAdd.h
//  YQQKit
//
//  Created by 朱逸 on 2021/3/3.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, CalculationType) {
    Add,
    Subtract,
    Multiply,
    Divide
};

NS_ASSUME_NONNULL_BEGIN

@interface NSDecimalNumber (YQQAdd)

+ (NSDecimalNumber *)caculateWithPassive:(id)passive active:(id)active type:(CalculationType)type decimalNumberHandler:(NSDecimalNumberHandler *_Nullable)decimalNumberHandler;

FOUNDATION_EXPORT NSComparisonResult YQQ_Compare(id passive, id active);

FOUNDATION_EXPORT NSDecimalNumber * YQQ_ConvertIdToDecimalNumber(id value);
FOUNDATION_EXPORT NSDecimalNumber * YQQ_ConvertIdToDecimalNumberByHandler(id value, NSRoundingMode mode, NSInteger scale);

FOUNDATION_EXPORT NSDecimalNumber * YQQ_Add(id passive, id active);
FOUNDATION_EXPORT NSDecimalNumber * YQQ_Subtract(id passive, id active);
FOUNDATION_EXPORT NSDecimalNumber * YQQ_Multiply(id passive, id active);
FOUNDATION_EXPORT NSDecimalNumber * YQQ_Divide(id passive, id active);
FOUNDATION_EXPORT id YQQ_Min(id passive, id active);
FOUNDATION_EXPORT id YQQ_Max(id passive, id active);

FOUNDATION_EXPORT NSDecimalNumber * YQQ_Add_Handler(id passive, id active, NSRoundingMode mode, NSInteger scale);
FOUNDATION_EXPORT NSDecimalNumber * YQQ_Subtract_Handler(id passive, id active, NSRoundingMode mode, NSInteger scale);
FOUNDATION_EXPORT NSDecimalNumber * YQQ_Multiply_Handler(id passive, id active, NSRoundingMode mode, NSInteger scale);
FOUNDATION_EXPORT NSDecimalNumber * YQQ_Divide_Handler(id passive, id active, NSRoundingMode mode, NSInteger scale);
FOUNDATION_EXPORT NSDecimalNumber * YQQ_Min_Handler(id passive, id active, NSRoundingMode mode, NSInteger scale);
FOUNDATION_EXPORT NSDecimalNumber * YQQ_Max_Handler(id passive, id active, NSRoundingMode mode, NSInteger scale);

@end

NS_ASSUME_NONNULL_END
