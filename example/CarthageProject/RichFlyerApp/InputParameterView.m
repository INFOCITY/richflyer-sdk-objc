//
//  InputParameterView.m
//  RichFlyer
//
//  Copyright © 2019年 INFOCITY,Inc. All rights reserved.
//

#import "InputParameterView.h"

#define MARGIN 8

@interface InputParameterView() <UIPickerViewDelegate, UIPickerViewDataSource>
{
	Model* _model;
	SegmentParameter _type;
	
	UIView* _contentView;
	UILabel* _titleLabel;
	UITextField* _textField;
	UIPickerView* _pickerView;
	UIView* _underBar;
	
	NSArray* _list;
}
@end

@implementation InputParameterView

- (void)setModel:(Model*) model {
	_model = model;
}

- (void)setType:(SegmentParameter)type {
	_type = type;
}

- (void)loadView {
	
	self.backgroundColor = [UIColor colorWithRed:0.0 / 256.0 green:150.0 / 256.0 blue:136.0 / 256.0 alpha:1.0];
	self.layer.masksToBounds = YES;
	self.layer.cornerRadius = MARGIN;
	
	_list = [_model getSegmentParameterValue:_type];
	
	_contentView = [[UIView alloc] init];
	[self addSubview:_contentView];
	
	_titleLabel = [[UILabel alloc] init];
	_titleLabel.text = [_model getSegmentParameterName:_type];
	_titleLabel.textColor = [UIColor whiteColor];
	[_contentView addSubview:_titleLabel];
	
	_pickerView = [[UIPickerView alloc] init];
	_pickerView.delegate = self;
	_pickerView.dataSource = self;
	_pickerView.showsSelectionIndicator = YES;
	
	UIToolbar* toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 0, 35)];
	UIBarButtonItem* doneItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done)];
	[toolBar setItems:@[doneItem]];
	
	_textField = [[UITextField alloc] init];
	_textField.text = _list[0];
	_textField.textColor = [UIColor whiteColor];
	_textField.textAlignment = NSTextAlignmentCenter;
	_textField.inputView = _pickerView;
	_textField.inputAccessoryView = toolBar;
	[_contentView addSubview:_textField];
	
	_underBar = [[UIView alloc] init];
	_underBar.backgroundColor = [UIColor whiteColor];
	[_contentView addSubview:_underBar];
	
}

- (void)viewDidLayoutSubviews {
	
	_contentView.frame = CGRectMake(MARGIN, MARGIN, self.frame.size.width - MARGIN * 2, self.frame.size.height - MARGIN * 2);
	_titleLabel.frame = CGRectMake(0, 0, _contentView.frame.size.width, _contentView.frame.size.height / 2);
	_textField.frame = CGRectMake(0, _contentView.frame.size.height / 2, _contentView.frame.size.width, _contentView.frame.size.height / 2 - 1);
	_underBar.frame = CGRectMake(0, _contentView.frame.size.height - 1, _contentView.frame.size.width, 1);
	
}

- (void)done {
	[_textField endEditing:YES];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
	return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
	return _list.count;
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
	return _list[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
	_textField.text = _list[row];
	[_model setValue:_type value:_list[row]];
}

@end
