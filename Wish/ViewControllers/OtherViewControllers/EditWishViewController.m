//
//  EditWishViewController.m
//  Wish
//
//  Created by Annie Klekchyan on 2/16/16.
//  Copyright © 2016 TLab. All rights reserved.
//

#import "EditWishViewController.h"
#import "ColorDecorationCellObject.h"
#import "AppDelegate.h"
#import "ColorDecorationCollectionViewCell.h"
#import "Configuration.h"
#import "Definitions.h"
#import "WishUtils.h"
#import "UIView+Toast.h"
#import "PrivateService.h"

@interface EditWishViewController ()

@property (strong, nonatomic) IBOutlet UICollectionView *colorsCollectionView;
@property (strong, nonatomic) IBOutlet UIView *colorsView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *decorationViewButtomConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *colorsViewHeightConstraint;
@property (strong, nonatomic) IBOutlet UITextView *wishTextField;

@end

@implementation EditWishViewController{

    AppDelegate* appDelgate;
    NSMutableArray *colorsBGArray;
    UIColor *defaultColor;
    NSString *defaultColorString;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self navigationBarConfiguration];
    
    self.colorsViewHeightConstraint.constant = 55;
    appDelgate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)[self.colorsCollectionView collectionViewLayout];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    colorsBGArray = [[NSMutableArray alloc] init];
    int i = 0;
    for (UIColor *color in appDelgate.webConfiguration.colorsArray) {
        
        ColorDecorationCellObject *colorObj = [[ColorDecorationCellObject alloc] init];
        colorObj.bgColor = color;
        colorObj.bgColorString = [appDelgate.webConfiguration.colorsStringArray objectAtIndex:i++];
        [colorsBGArray addObject:colorObj];
    }
    
    UIColor *bgColor = [WishUtils getColorFromString:self.wish.decoration.colorString];
    defaultColor = bgColor;
    defaultColorString = self.wish.decoration.colorString;
    [self.wishTextField setBackgroundColor:defaultColor];
   
    [self.colorsCollectionView reloadData];
    self.wishTextField.text = self.wish.content;
}

- (void)viewWillAppear:(BOOL)animated {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) navigationBarConfiguration{
    
    self.navigationItem.title = @"EDIT WISH";
    [self.navigationController.navigationBar setTitleTextAttributes: @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    UIImage* closeImage = [UIImage imageNamed:@"toolbarCloseIcon"];
    CGRect frameimg = CGRectMake(0, 0, 30, 30);
    UIButton *closeButton = [[UIButton alloc] initWithFrame:frameimg];
    [closeButton setBackgroundImage:closeImage forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(closeButtonAction:)
          forControlEvents:UIControlEventTouchUpInside];
    [closeButton setShowsTouchWhenHighlighted:YES];
    
    UIBarButtonItem *navCloseButton =[[UIBarButtonItem alloc] initWithCustomView:closeButton];
    self.navigationItem.leftBarButtonItem = navCloseButton;
    
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 45, 40)];
    [rightButton setTitle:@"Edit" forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [rightButton addTarget:self action:@selector(editWish:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
}

- (IBAction)editWish:(UIButton *)sender{
    
    if(![self.wishTextField.text isEqualToString:@""]){
        
        self.wish.content = self.wishTextField.text;
        self.wish.decoration.colorString = defaultColorString;
        
        UIView *transparent = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, kmainScreenWidth, kmainScreenHeight)];
        transparent.backgroundColor = [UIColor blackColor];
        transparent.alpha = 0.8f;
        UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        indicator.center =CGPointMake(kmainScreenWidth/2, kmainScreenHeight/2);
        [transparent addSubview:indicator];
        [indicator startAnimating];
        [self.view addSubview:transparent];
        
        [[PrivateService sharedInstance] editWishWithWishObject:self.wish OnCompletion:^(NSDictionary *result, BOOL isSucess) {
            
            [transparent removeFromSuperview];
            if(isSucess){
                
                NSDictionary *userInfo = @{
                                           @"wishObject" : self.wish,
                                           };
                
                NSNotificationCenter* nc = [NSNotificationCenter defaultCenter];
                [nc postNotificationName:@"editWishNotification" object:self userInfo:userInfo];
                
                [self dismissViewControllerAnimated:YES completion:nil];
            }else{
                
                [WishUtils showErrorAlertWithTitle:@"" AndText:[result objectForKey:@"message"]];
            }
            
        }];
    }
}

- (IBAction)closeButtonAction:(UIButton *)sender{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)openDecorationButtonAction:(UIButton *)sender {
    
    self.colorsView.hidden = !self.colorsView.hidden;
    if(self.colorsView.hidden){
        
        [sender setImage:[UIImage imageNamed:@"colorsCloseIcon"] forState:UIControlStateNormal];
        self.colorsViewHeightConstraint.constant = 55;
    }else{
        
        [sender setImage:[UIImage imageNamed:@"colorsOpenedIcon"] forState:UIControlStateNormal];
        self.colorsViewHeightConstraint.constant = 160;
    }
}

#pragma mark - UICollectionView Datasource

- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    
    return colorsBGArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ColorDecorationCollectionViewCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"ColorDecorationCollectionViewCell" forIndexPath:indexPath];
    
    ColorDecorationCellObject *colorObj = [colorsBGArray objectAtIndex:indexPath.row];
    [cell.colorView setBackgroundColor:colorObj.bgColor];
    
    if([WishUtils isEqualFisrtColor:colorObj.bgColor AndSecondColor:defaultColor]){
        
        cell.colorView.layer.borderColor = [UIColor redColor].CGColor;
        cell.colorView.layer.borderWidth = 3.0f;
    }else{
        
        cell.colorView.layer.borderWidth = 0.0f;
    }
    
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    // TODO: Select Item
    ColorDecorationCellObject *colorObj = [colorsBGArray objectAtIndex:indexPath.row];
    [self.wishTextField setBackgroundColor:colorObj.bgColor];
    defaultColor = colorObj.bgColor;
    defaultColorString = colorObj.bgColorString;
    [self.colorsCollectionView reloadData];
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    // TODO: Deselect item
}

#pragma mark - keyboard movements
- (void)keyboardWillShow:(NSNotification *)notification{
    
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    self.decorationViewButtomConstraint.constant = keyboardSize.height;
}

- (void)keyboardWillHide:(NSNotification *)notification{
    
    self.decorationViewButtomConstraint.constant = 0;
}

- (void)textViewDidChange:(UITextView *)textView{
    
    UIWindow *window = [UIApplication sharedApplication].windows.lastObject;
    if(textView.text.length > appDelgate.webConfiguration.maxSymbolsCount){
        
        NSString *toastString = @"No more characters allowed!";
        [window makeToast:toastString duration:3.0 position:CSToastPositionBottom];
        NSString *subString = [textView.text substringToIndex:appDelgate.webConfiguration.maxSymbolsCount];
        textView.text = subString;
    }
}

@end
