
//	Copyright 2005-2017 Michel Fortin
//
//	Licensed under the Apache License, Version 2.0 (the "License");
//	you may not use this file except in compliance with the License.
//	You may obtain a copy of the License at
//
//	http://www.apache.org/licenses/LICENSE-2.0
//
//	Unless required by applicable law or agreed to in writing, software
//	distributed under the License is distributed on an "AS IS" BASIS,
//	WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//	See the License for the specific language governing permissions and
//	limitations under the License.

#import "SettingsViewController.h"
#import "SimDaltonismFilter.h"

@implementation SettingsViewController

- (void)	dealloc {
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (BOOL)automaticallyAdjustsScrollViewInsets {
	return NO;
}

- (void)viewDidLoad {
	[super viewDidLoad];

	self.paletteScrollView.subviews.firstObject.transform = CGAffineTransformMakeScale(-1, 1);
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[self readDefaults];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(readDefaults) name:NSUserDefaultsDidChangeNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	[super viewWillDisappear:animated];
}

- (void)readDefaults {
	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];

	[self.paletteScrollView performSelector:@selector(updateDisplay) withObject:nil afterDelay:0.0];

	// Sim Daltonism
	NSInteger visionType = [userDefaults integerForKey:SimVisionTypeKey];
	self.visionTypeName.text = SimVisionTypeName(visionType);
	self.visionTypeDescription.text = SimVisionTypeDesc(visionType);
}

- (IBAction)closeSettings:(id)sender {
	[self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

@end

