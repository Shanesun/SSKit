//
//  SSKit.m
//  SSKit
//
//  Created by Shane on 15/12/9.
//  Copyright © 2015年 Shane. All rights reserved.
//

#import "SSKit.h"


@implementation SSKit
- (void)textFieldDidChange:(UITextField *)textField
{

}

- (void)limitInputStringWithTextField:(UITextField *)textField limitLength:(int)maxInputLength{
    NSString *lan =[[UITextInputMode currentInputMode]primaryLanguage];
    if ([lan isEqualToString:@"zh-Hans"]) {
        UITextRange *selectRang = [textField markedTextRange];
        UITextPosition * posi = [textField positionFromPosition:selectRang.start offset:0];
        if (!posi) {
            if(textField.text.length > maxInputLength){
                textField.text = [textField.text substringToIndex:maxInputLength];
            }
        }
    }else{
        if(textField.text.length > maxInputLength){
            textField.text = [textField.text substringToIndex:maxInputLength];
        }
    }
}
@end
