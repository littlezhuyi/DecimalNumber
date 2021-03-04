//
//  NSDecimalNumber+YQQAdd.m
//  YQQKit
//
//  Created by 朱逸 on 2021/3/3.
//

#import "NSDecimalNumber+YQQAdd.h"

@implementation NSDecimalNumber (YQQAdd)

+ (NSDecimalNumber *)caculateWithPassive:(id)passive active:(id)active type:(CalculationType)type decimalNumberHandler:(NSDecimalNumberHandler *)decimalNumberHandler {
    NSDecimalNumber *passiveDecimalNumber;
    if (!passive) {
        NSLog(@"passive can't nil");
        return nil;
    }
    if ([passive isKindOfClass:[NSString class]]) {
        passiveDecimalNumber = [NSDecimalNumber decimalNumberWithString:passive];
    } else if ([passive isKindOfClass:[NSDecimalNumber class]]) {
        passiveDecimalNumber = passive;
    } else if ([passive isKindOfClass:[NSNumber class]]) {
        passiveDecimalNumber = [NSDecimalNumber decimalNumberWithDecimal:[passive decimalValue]];
    } else {
        NSLog(@"passive should be NSDecimalNumber or NSString or NSNumber");
        return nil;
    }
    
    NSDecimalNumber *activeDecimalNumber;
    if (!active) {
        NSLog(@"active can't nil");
        return nil;
    }
    if ([active isKindOfClass:[NSString class]]) {
        activeDecimalNumber = [NSDecimalNumber decimalNumberWithString:active];
    } else if ([active isKindOfClass:[NSDecimalNumber class]]) {
        activeDecimalNumber = active;
    } else if ([active isKindOfClass:[NSNumber class]]) {
        activeDecimalNumber = [NSDecimalNumber decimalNumberWithDecimal:[active decimalValue]];
    } else {
        NSLog(@"active should be NSDecimalNumber or NSString or NSNumber");
        return nil;
    }
    
    if (passiveDecimalNumber.decimalValue._isNegative || activeDecimalNumber.decimalValue._isNegative) {
        NSLog(@"passive or active should not be NaN");
        return nil;
    }
        
    NSDecimalNumber *resultDecimalNumber;
    if (type == Add) {
        resultDecimalNumber = [passiveDecimalNumber decimalNumberByAdding:activeDecimalNumber];
    } else if (type == Subtract) {
        resultDecimalNumber = [passiveDecimalNumber decimalNumberBySubtracting:activeDecimalNumber];
    } else if (type == Multiply) {
        resultDecimalNumber = [passiveDecimalNumber decimalNumberByMultiplyingBy:activeDecimalNumber];
    } else {
        if (YQQ_Compare(activeDecimalNumber, @(0)) == 0) {
            NSLog(@"active can't be 0");
            return nil;
        } else {
            resultDecimalNumber = [passiveDecimalNumber decimalNumberByDividingBy:activeDecimalNumber];
        }
    }
    
    if (decimalNumberHandler) {
        resultDecimalNumber = [resultDecimalNumber decimalNumberByRoundingAccordingToBehavior:decimalNumberHandler];
    }
    
    return resultDecimalNumber;
}

NSComparisonResult YQQ_Compare(id passive, id active) {
    if (!passive || !active) {
        NSLog(@"passive or active can't be nil");
        return -404;
    }
    
    NSDecimalNumber *passiveDecimalNumber;
    if ([passive isKindOfClass:[NSString class]]) {
        passiveDecimalNumber = [NSDecimalNumber decimalNumberWithString:passive];
    } else if ([passive isKindOfClass:[NSDecimalNumber class]]) {
        passiveDecimalNumber = passive;
    } else if ([passive isKindOfClass:[NSNumber class]]) {
        passiveDecimalNumber = [NSDecimalNumber decimalNumberWithDecimal:[passive decimalValue]];
    } else {
        NSLog(@"passive should be NSDecimalNumber or NSString or NSNumber");
        return -404;
    }
    
    NSDecimalNumber *activeDecimalNumber;
    if ([active isKindOfClass:[NSString class]]) {
        activeDecimalNumber = [NSDecimalNumber decimalNumberWithString:active];
    } else if ([active isKindOfClass:[NSDecimalNumber class]]){
        activeDecimalNumber = active;
    } else if ([active isKindOfClass:[NSNumber class]]){
        activeDecimalNumber = [NSDecimalNumber decimalNumberWithDecimal:[active decimalValue]];
    } else {
        NSLog(@"active should be NSDecimalNumber or NSString or NSNumber");
        return -404;
    }
    return [passiveDecimalNumber compare:activeDecimalNumber];
}

NSDecimalNumber * YQQ_ConvertIdToDecimalNumber(id value) {
    NSDecimalNumber *decimalNumber;
    if ([value isKindOfClass:[NSString class]]) {
        decimalNumber = [NSDecimalNumber decimalNumberWithString:value];
    } else if ([value isKindOfClass:[NSDecimalNumber class]]) {
        decimalNumber = value;
    } else if ([value isKindOfClass:[NSNumber class]]) {
        decimalNumber = [NSDecimalNumber decimalNumberWithDecimal:[value decimalValue]];
    } else {
        NSLog(@"value should be NSDecimalNumber or NSString or NSNumber");
        return nil;
    }
    return decimalNumber;
}

extern NSDecimalNumber * YQQ_ConvertIdToDecimalNumberByHandler(id value, NSRoundingMode mode, NSInteger scale) {
    NSDecimalNumber *decimalNumber;
    if (!value) {
        NSLog(@"value can't nil");
        return nil;
    }
    if ([value isKindOfClass:[NSString class]]) {
        decimalNumber = [NSDecimalNumber decimalNumberWithString:value];
    } else if ([value isKindOfClass:[NSDecimalNumber class]]) {
        decimalNumber = value;
    } else if ([value isKindOfClass:[NSNumber class]]) {
        decimalNumber = [NSDecimalNumber decimalNumberWithDecimal:[value decimalValue]];
    } else {
        NSLog(@"value should be NSDecimalNumber or NSString or NSNumber");
        return nil;
    }
    NSDecimalNumberHandler *handler = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:mode scale:scale raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    return [decimalNumber decimalNumberByRoundingAccordingToBehavior:handler];
}

NSDecimalNumber * YQQ_Add(id passive, id active) {
    return [NSDecimalNumber caculateWithPassive:passive active:active type:Add decimalNumberHandler:nil];
}

NSDecimalNumber * YQQ_Subtract(id passive, id active) {
    return [NSDecimalNumber caculateWithPassive:passive active:active type:Subtract decimalNumberHandler:nil];
}

NSDecimalNumber * YQQ_Multiply(id passive, id active) {
    return [NSDecimalNumber caculateWithPassive:passive active:active type:Multiply decimalNumberHandler:nil];
}

NSDecimalNumber * YQQ_Divide(id passive, id active) {
    return [NSDecimalNumber caculateWithPassive:passive active:active type:Divide decimalNumberHandler:nil];
}

id YQQ_Min(id passive, id active) {
    return YQQ_Compare(passive, active) > 0 ? active : passive;
}

id YQQ_Max(id passive, id active) {
    return YQQ_Compare(passive, active) > 0 ? passive : active;
}

NSDecimalNumber * YQQ_Add_Handler(id passive, id active, NSRoundingMode mode, NSInteger scale) {
    return YQQ_ConvertIdToDecimalNumberByHandler(YQQ_Add(passive, active), mode, scale);
}

NSDecimalNumber * YQQ_Subtract_Handler(id passive, id active, NSRoundingMode mode, NSInteger scale) {
    return YQQ_ConvertIdToDecimalNumberByHandler(YQQ_Subtract(passive, active), mode, scale);
}

NSDecimalNumber * YQQ_Multiply_Handler(id passive, id active, NSRoundingMode mode, NSInteger scale) {
    return YQQ_ConvertIdToDecimalNumberByHandler(YQQ_Multiply(passive, active), mode, scale);
}

NSDecimalNumber * YQQ_Divide_Handler(id passive, id active, NSRoundingMode mode, NSInteger scale) {
    return YQQ_ConvertIdToDecimalNumberByHandler(YQQ_Divide(passive, active), mode, scale);
}

NSDecimalNumber * YQQ_Min_Handler(id passive, id active, NSRoundingMode mode, NSInteger scale) {
    return YQQ_ConvertIdToDecimalNumberByHandler(YQQ_Min(passive, active), mode, scale);
}

NSDecimalNumber * YQQ_Max_Handler(id passive, id active, NSRoundingMode mode, NSInteger scale) {
    return YQQ_ConvertIdToDecimalNumberByHandler(YQQ_Max(passive, active), mode, scale);
}

@end
