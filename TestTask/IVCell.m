//
//  IVCell.m
//  TestTask
//
//  Created by Игорь Веденеев on 10.10.15.
//  Copyright © 2015 Игорь Веденеев. All rights reserved.
//

#import "IVCell.h"

@implementation IVCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (CGFloat) getHeightForRowForIndexPath: (UIImage*) img {
    //NSLog(@"%f", img.size.height);
    return img.size.height * 1.1f;
}

@end
