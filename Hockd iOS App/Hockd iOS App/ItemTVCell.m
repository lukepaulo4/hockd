//
//  ItemTableViewCell.m
//  Hockd iOS App
//
//  Created by Luke Paulo on 9/14/16.
//  Copyright © 2016 HOCKD. All rights reserved.
//

#import "ItemTVCell.h"
#import "Item.h"
#import "User.h"

@interface ItemTVCell ()

@property (nonatomic, strong) UIImageView *itemImageView;
@property (nonatomic, strong) UILabel *itemDescriptionLabel;
@property (nonatomic, strong) UILabel *postedLoanAmountLabel;

@end

static UIFont *lightFont;
static UIFont *boldFont;
static UIColor *itemDescriptionLabelGray;
static UIColor *postedLoanAmountLabelGray;
static UIColor *linkColor;
static NSParagraphStyle *paragraphStyle;

@implementation ItemTVCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.itemImageView = [[UIImageView alloc] init];
        self.itemDescriptionLabel = [[UILabel alloc] init];
        self.itemDescriptionLabel.numberOfLines = 0;
        self.itemDescriptionLabel.backgroundColor = itemDescriptionLabelGray;
        
        self.postedLoanAmountLabel = [[UILabel alloc] init];
        self.postedLoanAmountLabel.numberOfLines = 0;
        self.postedLoanAmountLabel.backgroundColor = postedLoanAmountLabelGray;
        
        for (UIView *view in @[self.itemImageView, self.itemDescriptionLabel, self.postedLoanAmountLabel]) {
            [self.contentView addSubview:view];
        }
    }
    return self;
}

+ (void)load {
    lightFont = [UIFont fontWithName:@"HelveticaNeue-Thin" size:11];
    boldFont = [UIFont fontWithName:@"HelveticaNeue-Bold" size:11];
    itemDescriptionLabelGray = [UIColor colorWithRed:0.933 green:0.933 blue:0.933 alpha:1]; /*#eeeeee*/
    postedLoanAmountLabelGray = [UIColor colorWithRed:0.898 green:0.898 blue:0.898 alpha:1]; /*#e5e5e5*/
    linkColor = [UIColor colorWithRed:0.345 green:0.314 blue:0.427 alpha:1]; /*#58506d*/
    
    NSMutableParagraphStyle *mutableParagraphStyle = [[NSMutableParagraphStyle alloc] init];
    mutableParagraphStyle.headIndent = 20.0;
    mutableParagraphStyle.firstLineHeadIndent = 20.0;
    mutableParagraphStyle.tailIndent = -20.0;
    mutableParagraphStyle.paragraphSpacingBefore = 5;
    
    paragraphStyle = mutableParagraphStyle;
}

//Add some life to the font (color, size, style...)
- (NSAttributedString *) itemDescriptionString {
    
    // #1 - font size
    CGFloat itemDescriptionFontSize = 15;
    
    // #2 - Make a string that says "item description"
    NSString *baseString = [NSString stringWithFormat:@"%@", self.item.itemDescription];
    
    // #3 - Make an attributed string, with the "username" bold
    NSMutableAttributedString *mutableItemDescriptionString = [[NSMutableAttributedString alloc] initWithString:baseString attributes:@{NSFontAttributeName : [lightFont fontWithSize:itemDescriptionFontSize], NSParagraphStyleAttributeName : paragraphStyle}];
    
    // #4
    NSRange itemDescriptionRange = [baseString rangeOfString:self.item.itemDescription];
    [mutableItemDescriptionString addAttribute:NSFontAttributeName value:[boldFont fontWithSize:itemDescriptionFontSize] range:itemDescriptionRange];
    [mutableItemDescriptionString addAttribute:NSForegroundColorAttributeName value:linkColor range:itemDescriptionRange];
    
    return mutableItemDescriptionString;
}

//Life to the Posted Loan Value string...
- (NSAttributedString *) postedLoanAmountString {
    
    CGFloat postedLoanAmountFontSize = 15;
    
    // #2 - Make a string that says "item description"
    NSString *baseString = [NSString stringWithFormat:@"%@", self.item.postedLoanAmount];
    
    // #3 - Make an attributed string, with the "username" bold
    NSMutableAttributedString *mutablePostedLoanAmountString = [[NSMutableAttributedString alloc] initWithString:baseString attributes:@{NSFontAttributeName : [lightFont fontWithSize:postedLoanAmountFontSize], NSParagraphStyleAttributeName : paragraphStyle}];
    
    // #4
    NSRange postedLoanAmountRange = [baseString rangeOfString:self.item.postedLoanAmount];
    [mutablePostedLoanAmountString addAttribute:NSFontAttributeName value:[boldFont fontWithSize:postedLoanAmountFontSize] range:postedLoanAmountRange];
    [mutablePostedLoanAmountString addAttribute:NSForegroundColorAttributeName value:linkColor range:postedLoanAmountRange];
    
    return mutablePostedLoanAmountString;
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
    self.itemImageView.frame = CGRectMake(0, 0, CGRectGetWidth(self.contentView.bounds), imageOneHeight);
    
    CGSize sizeOfItemDescriptionLabel = [self sizeOfString:self.itemDescriptionLabel.attributedText];
    self.itemDescriptionLabel.frame = CGRectMake(0, CGRectGetMaxY(self.itemImageView.frame), CGRectGetWidth(self.contentView.bounds), sizeOfItemDescriptionLabel.height);
    
    CGSize sizeOfPostedLoanAmountLabel = [self sizeOfString:self.postedLoanAmountLabel.attributedText];
    self.postedLoanAmountLabel.frame = CGRectMake(0, CGRectGetMaxY(self.itemDescriptionLabel.frame), CGRectGetWidth(self.bounds), sizeOfPostedLoanAmountLabel.height);
    
    // Hide the line between cells
    self.separatorInset = UIEdgeInsetsMake(0, CGRectGetWidth(self.bounds)/2.0, 0, CGRectGetWidth(self.bounds)/2.0);
}

//override auto-generated methods. We want to update the image and text labels whenever a new media item is set
- (void) setItem:(Item *)item {
    _item = item;
    self.itemImageView.image = _item.imageOne;
    self.itemDescriptionLabel.attributedText = [self itemDescriptionString];
    self.postedLoanAmountLabel.attributedText = [self postedLoanAmountString];
}




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
