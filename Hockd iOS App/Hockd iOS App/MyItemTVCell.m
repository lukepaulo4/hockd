//
//  MyItemTableViewCell.m
//  Hockd iOS App
//
//  Created by Luke Paulo on 9/14/16.
//  Copyright © 2016 HOCKD. All rights reserved.
//

#import "MyItemTVCell.h"
#import "MyItem.h"
#import "User.h"

@interface MyItemTVCell ()

@property (nonatomic, strong) UIImageView *itemOneImageView;
@property (nonatomic, strong) UILabel *itemDescriptionLabel;
@property (nonatomic, strong) UILabel *loanDesiredLabel;

@end


// Added these when did the cell programmatically...
static UIFont *lightFont;
static UIFont *boldFont;
static UIColor *itemDescriptionLabelGray;
static UIColor *loanDesiredLabelGray;
static UIColor *linkColor;
static NSParagraphStyle *paragraphStyle;
 

@implementation MyItemTVCell

//Use this if build from storyboard. 
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


//called once and only once per class. It's a class method and not a instance method, hence the + rather than the -
+ (void)load {
    lightFont = [UIFont fontWithName:@"HelveticaNeue-Thin" size:11];
    boldFont = [UIFont fontWithName:@"HelveticaNeue-Bold" size:11];
    itemDescriptionLabelGray = [UIColor colorWithRed:0.933 green:0.933 blue:0.933 alpha:1]; //#eeeeee
    loanDesiredLabelGray = [UIColor colorWithRed:0.898 green:0.898 blue:0.898 alpha:1]; //#e5e5e5
    linkColor = [UIColor colorWithRed:0.345 green:0.314 blue:0.427 alpha:1]; //#58506d
    
    NSMutableParagraphStyle *mutableParagraphStyle = [[NSMutableParagraphStyle alloc] init];
    mutableParagraphStyle.headIndent = 20.0;
    mutableParagraphStyle.firstLineHeadIndent = 20.0;
    mutableParagraphStyle.tailIndent = -20.0;
    mutableParagraphStyle.paragraphSpacingBefore = 5;
    
    paragraphStyle = mutableParagraphStyle;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.itemOneImageView = [[UIImageView alloc] init];
        self.itemDescriptionLabel = [[UILabel alloc] init];
        self.itemDescriptionLabel.numberOfLines = 0;
        self.itemDescriptionLabel.backgroundColor = itemDescriptionLabelGray;
        
        self.loanDesiredLabel = [[UILabel alloc] init];
        self.loanDesiredLabel.numberOfLines = 0;
        self.loanDesiredLabel.backgroundColor = loanDesiredLabelGray;
        
        for (UIView *view in @[self.itemOneImageView, self.itemDescriptionLabel, self.loanDesiredLabel]) {
            [self.contentView addSubview:view];
        }
    }
    return self;
}


//create the attributed strings
- (NSAttributedString *) itemDescriptionString {
    
    // #1 - font size
    CGFloat itemDescriptionFontSize = 15;
    
    // #2 - Make a string that says "item description"
    NSString *baseString = [NSString stringWithFormat:@"%@", self.item.itemDescription];
    
    // #3 - Make an attributed string, this sets it up with a bold string..
    NSMutableAttributedString *mutableItemDescriptionString = [[NSMutableAttributedString alloc] initWithString:baseString attributes:@{NSFontAttributeName : [boldFont fontWithSize:itemDescriptionFontSize], NSParagraphStyleAttributeName : paragraphStyle}];
    
    return mutableItemDescriptionString;
    
}



//Life to the Posted Loan Value string...
- (NSAttributedString *) loanAmountString {
    
    // #1 - font size equal to itemDescription font size
    CGFloat loanAmountFontSize = 15;
    
    
    // #2 - Make a string that says "loan amount"
    NSString *baseString = [NSString stringWithFormat:@"%@", self.item.loanDesired];
    
    // #3 - Make an attributed string, this sets it up with a bold string..
    NSMutableAttributedString *mutableLoanAmountString = [[NSMutableAttributedString alloc] initWithString:baseString attributes:@{NSFontAttributeName : [boldFont fontWithSize:loanAmountFontSize], NSParagraphStyleAttributeName : paragraphStyle}];

    return mutableLoanAmountString;
}


//Calculates how tall the labels need to be.
- (CGSize) sizeOfString:(NSAttributedString *)string {
    CGSize maxSize = CGSizeMake(CGRectGetWidth(self.contentView.bounds) - 40, 0.0);
    CGRect sizeRect = [string boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    sizeRect.size.height += 20;
    sizeRect = CGRectIntegral(sizeRect);
    return sizeRect.size;
}


- (void) layoutSubviews {
    [super layoutSubviews];
    
    if (!self.item) {
        return;
    }
    
    CGFloat imageOneHeight = self.item.imageOne.size.height / self.item.imageOne.size.width * CGRectGetWidth(self.contentView.bounds);
    self.itemOneImageView.frame = CGRectMake(0, 0, CGRectGetWidth(self.contentView.bounds), imageOneHeight);
    
    CGSize sizeOfItemDescriptionLabel = [self sizeOfString:self.itemDescriptionLabel.attributedText];
    self.itemDescriptionLabel.frame = CGRectMake(0, CGRectGetMaxY(self.itemOneImageView.frame), CGRectGetWidth(self.contentView.bounds), sizeOfItemDescriptionLabel.height);
    
    CGSize sizeOfLoanAmountLabel = [self sizeOfString:self.loanDesiredLabel.attributedText];
    self.loanDesiredLabel.frame = CGRectMake(0, CGRectGetMaxY(self.itemDescriptionLabel.frame), CGRectGetWidth(self.bounds), sizeOfLoanAmountLabel.height);
    
    // Hide the line between cells.. If we want this line later we can remove this code snippet. However, the picture should be a clear indicator that the new cell starts
    self.separatorInset = UIEdgeInsetsMake(0, CGRectGetWidth(self.bounds)/2.0, 0, CGRectGetWidth(self.bounds)/2.0);
}


//override auto-generated methods. We want to update the image and text labels whenever a new item is set
- (void) setItem:(MyItem *)item {
    _item = item;
    self.itemOneImageView.image = _item.imageOne;
    self.itemDescriptionLabel.attributedText = [self itemDescriptionString];
    self.loanDesiredLabel.attributedText = [self loanAmountString];
}


//This method will fake a layout event to return the full height of a completed cell as if it were actually being placed in the table
+ (CGFloat) heightForItem:(MyItem *)item width:(CGFloat)width {
    
    //make a cell
    MyItemTVCell *layoutCell = [[MyItemTVCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"layoutCell"];
    
    //Set it to the fiven width, and the maximum possible height
    layoutCell.frame = CGRectMake(0, 0, width, CGFLOAT_MAX);
    
    //Give it the item
    layoutCell.item = item;
    
    //make it adjust the image view and labels
    [layoutCell layoutSubviews];
    
    //the height will be wherever the bottom of the loan desired label is
    return CGRectGetMaxY(layoutCell.loanDesiredLabel.frame);
}







/*
- (NSString *) itemDescriptionString {
    NSString *baseString = [NSString stringWithFormat:@"%@", self.item.itemDescription];
    
    return baseString;
}

- (NSString *) loanDesiredString {
    NSString *baseString = [NSString stringWithFormat:@"%@", self.item.loanDesired];
    
    return baseString;
}


*/



//Use this if build from storyboard. Keep for now in case implement storyboard
//- (void)awakeFromNib {
//    [super awakeFromNib];
//    // Initialization code
//}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    [super setHighlighted:NO animated:animated];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:NO animated:animated];
}
 

@end
