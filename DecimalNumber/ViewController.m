//
//  ViewController.m
//  DecimalNumber
//
//  Created by 朱逸 on 2021/3/3.
//

#import "ViewController.h"
#import "NSDecimalNumber+YQQAdd.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *passiveTextFieldTop;

@property (weak, nonatomic) IBOutlet UITextField *passiveTextField;
@property (weak, nonatomic) IBOutlet UITextField *activeTextField;
@property (weak, nonatomic) IBOutlet UITextField *resultTextField;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *calculateButtonArray;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *modeButtonArray;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *scaleButtonArray;

@property (nonatomic, assign) CalculationType calculationType;
@property (nonatomic, assign) NSRoundingMode roundingMode;
@property (nonatomic, assign) NSUInteger scale;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)relation:(UIButton *)sender {
    for (UIButton *button in self.calculateButtonArray) {
        if (button == sender) {
            button.selected = YES;
            _calculationType = button.tag;
        } else {
            button.selected = NO;
        }
    }
}

- (IBAction)calculate:(UIButton *)sender {
    if (_calculationType == Add) {
        _resultTextField.text = YQQ_Add(_passiveTextField.text, _activeTextField.text).stringValue;
    } else if (_calculationType == Subtract) {
        _resultTextField.text = YQQ_Subtract(_passiveTextField.text, _activeTextField.text).stringValue;
    }  else if (_calculationType == Multiply) {
        _resultTextField.text = YQQ_Multiply(_passiveTextField.text, _activeTextField.text).stringValue;
    } else {
        _resultTextField.text = YQQ_Divide(_passiveTextField.text, _activeTextField.text).stringValue;
    }
}

- (IBAction)modeAction:(UIButton *)sender {
    for (UIButton *button in self.modeButtonArray) {
        if (button == sender) {
            button.selected = YES;
            _roundingMode = button.tag;
        } else {
            button.selected = NO;
        }
    }
    if (_calculationType == Add) {
        _resultTextField.text = YQQ_Add_Handler(_passiveTextField.text, _activeTextField.text, _roundingMode, _scale).stringValue;
    } else if (_calculationType == Subtract) {
        _resultTextField.text = YQQ_Subtract_Handler(_passiveTextField.text, _activeTextField.text, _roundingMode, _scale).stringValue;
    }  else if (_calculationType == Multiply) {
        _resultTextField.text = YQQ_Multiply_Handler(_passiveTextField.text, _activeTextField.text, _roundingMode, _scale).stringValue;
    } else {
        _resultTextField.text = YQQ_Divide_Handler(_passiveTextField.text, _activeTextField.text, _roundingMode, _scale).stringValue;
    }
}

- (IBAction)scaleAction:(UIButton *)sender {
    for (UIButton *button in self.scaleButtonArray) {
        if (button == sender) {
            button.selected = YES;
            _scale = button.tag;
        } else {
            button.selected = NO;
        }
    }
    if (_calculationType == Add) {
        _resultTextField.text = YQQ_Add_Handler(_passiveTextField.text, _activeTextField.text, _roundingMode, _scale).stringValue;
    } else if (_calculationType == Subtract) {
        _resultTextField.text = YQQ_Subtract_Handler(_passiveTextField.text, _activeTextField.text, _roundingMode, _scale).stringValue;
    }  else if (_calculationType == Multiply) {
        _resultTextField.text = YQQ_Multiply_Handler(_passiveTextField.text, _activeTextField.text, _roundingMode, _scale).stringValue;
    } else {
        _resultTextField.text = YQQ_Divide_Handler(_passiveTextField.text, _activeTextField.text, _roundingMode, _scale).stringValue;
    }
}

@end
