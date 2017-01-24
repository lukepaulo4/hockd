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

@interface MyItemTVCell () <UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIImageView *itemOneImageView;
@property (nonatomic, strong) UILabel *itemDescriptionLabel;
@property (nonatomic, strong) UILabel *loanDesiredLabel;

@property (nonatomic, strong) NSLayoutConstraint *imageHeightConstraint;
@property (nonatomic, strong) NSLayoutConstraint *itemDescriptionLabelHeightConstraint;
@property (nonatomic, strong) NSLayoutConstraint *loanDesiredLabelHeightConstraint;

@property (nonatomic, strong) UITapGestureRecognizer *tapGestureRecognizer;

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
        self.itemOneImageView.userInteractionEnabled = YES;
        
        self.tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapFired:)];
        self.tapGestureRecognizer.delegate = self;
        [self.itemOneImageView addGestureRecognizer:self.tapGestureRecognizer];
        
        self.itemDescriptionLabel = [[UILabel alloc] init];
        self.itemDescriptionLabel.numberOfLines = 0;
        self.itemDescriptionLabel.backgroundColor = itemDescriptionLabelGray;
        
        self.loanDesiredLabel = [[UILabel alloc] init];
        self.loanDesiredLabel.numberOfLines = 0;
        self.loanDesiredLabel.backgroundColor = loanDesiredLabelGray;
        
        for (UIView *view in @[self.itemOneImageView, self.itemDescriptionLabel, self.loanDesiredLabel]) {
            [self.contentView addSubview:view];
            
            view.translatesAutoresizingMaskIntoConstraints = NO;
        }
        
        NSDictionary *viewDictionary = NSDictionaryOfVariableBindings(_itemOneImageView, _itemDescriptionLabel, _loanDesiredLabel);
        
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_itemOneImageView]|" options:kNilOptions metrics:nil views:viewDictionary]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_itemDescriptionLabel]|" options:kNilOptions metrics:nil views:viewDictionary]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_loanDesiredLabel]|" options:kNilOptions metrics:nil views:viewDictionary]];
        
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_itemOneImageView][_itemDescriptionLabel][_loanDesiredLabel]"
                                                                                 options:kNilOptions
                                                                                 metrics:nil
                                                                                   views:viewDictionary]];
        
        self.imageHeightConstraint = [NSLayoutConstraint constraintWithItem:_itemOneImageView
                                                                  attribute:NSLayoutAttributeHeight
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:nil
                                                                  attribute:NSLayoutAttributeNotAnAttribute
                                                                 multiplier:1
                                                                   constant:100];
        self.imageHeightConstraint.identifier = @"Image height constraint";
        
        self.itemDescriptionLabelHeightConstraint = [NSLayoutConstraint constraintWithItem:_itemDescriptionLabel
                                                                                    attribute:NSLayoutAttributeHeight
                                                                                    relatedBy:NSLayoutRelationEqual
                                                                                       toItem:nil
                                                                                    attribute:NSLayoutAttributeNotAnAttribute
                                                                                   multiplier:1
                                                                                     constant:100];
        self.itemDescriptionLabelHeightConstraint.identifier = @"Item description label height constraint";
        
        self.loanDesiredLabelHeightConstraint = [NSLayoutConstraint constraintWithItem:_loanDesiredLabel
                                                                         attribute:NSLayoutAttributeHeight
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:nil
                                                                         attribute:NSLayoutAttributeNotAnAttribute
                                                                        multiplier:1
                                                                          constant:100];
        self.loanDesiredLabelHeightConstraint.identifier = @"Loan desired label height constraint";
        
        [self.contentView addConstraints:@[self.imageHeightConstraint, self.itemDescriptionLabelHeightConstraint, self.loanDesiredLabelHeightConstraint]];
        
        
    }
    return self;
}



#pragma mark - Image View
//add the target method for the tapFired call
- (void) tapFired:(UITapGestureRecognizer *)sender {
    [self.delegate cell:self didTapImageView:self.itemOneImageView];
}

#pragma mark - UIGestureRecognizerDelegate

//not that there are any other active editors currently operating on the image view, but in case they are implemented later... we want to make sure the gesture recognizer only fires while the cell isn't in editing mode
- (BOOL) gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    return self.isEditing == NO;
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




- (void) layoutSubviews {
    [super layoutSubviews];
    
    if (!self.item) {
        return;
    }
    
    // Before layout, calculate the intrinsic size of the labels (the size they "want" to be), and add 20 to the height for some vertical padding.
    CGSize maxSize = CGSizeMake(CGRectGetWidth(self.bounds), CGFLOAT_MAX);
    CGSize itemDescriptionLabelSize = [self.itemDescriptionLabel sizeThatFits:maxSize];
    CGSize loanDesiredLabelSize = [self.loanDesiredLabel sizeThatFits:maxSize];
    
    self.itemDescriptionLabelHeightConstraint.constant = itemDescriptionLabelSize.height + 20;
    self.loanDesiredLabelHeightConstraint.constant = loanDesiredLabelSize.height + 20;
    self.imageHeightConstraint.constant = self.item.imageOne.size.height / self.item.imageOne.size.width * CGRectGetWidth(self.contentView.bounds);
    
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
    
    
    layoutCell.item = item;
    
    layoutCell.frame = CGRectMake(0, 0, width, CGRectGetHeight(layoutCell.frame));
    
    [layoutCell setNeedsLayout];
    [layoutCell layoutIfNeeded];
    
    // Get the actual height required for the cell
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
