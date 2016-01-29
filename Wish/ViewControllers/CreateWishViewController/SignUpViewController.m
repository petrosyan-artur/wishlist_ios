//
//  SignUpViewController.m
//  Wish
//
//  Created by Annie Klekchyan on 1/26/16.
//  Copyright © 2016 TLab. All rights reserved.
//

#import "SignUpViewController.h"
#import "Definitions.h"
#import "PublicService.h"
#import "WishUtils.h"
#import "TPKeyboardAvoidingScrollView.h"

@interface SignUpViewController ()

@property (strong, nonatomic) IBOutlet UILabel *userNameLabel;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UITextField *repeatPasswordTextField;
@property (strong, nonatomic) IBOutlet UILabel *warningLabel;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *scrollViewButtomConstarint;
@property (strong, nonatomic) IBOutlet UIScrollView *signUpScrollView;

@end

@implementation SignUpViewController{
    
    NSInteger keyboardHeight;
    NSInteger keyboardWidth;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    [[PublicService sharedInstance] getUserNameOnCompletion:^(NSDictionary *result, BOOL isSucess) {
        
        if(isSucess){
            
            self.userNameLabel.text = [result objectForKey:@"username"];
            self.warningLabel.text = [result objectForKey:@"hint"];
        }else{
            
            [WishUtils showErrorAlertWithTitle:@"" AndText:[result objectForKey:@"message"]];
        }
    }];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) textFieldDidBeginEditing:(UITextField *)sender{
    
//    if ([sender isEqual:mailTf])
//    {
//        //move the main view, so that the keyboard does not hide it.
//        if  (self.view.frame.origin.y >= 0)
//        {
//            [self setViewMovedUp:YES];
//        }
//    }
}

- (IBAction)closeButtonAction:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)signUpButton:(UIButton *)sender {
    
    if([self.passwordTextField.text isEqualToString:self.repeatPasswordTextField.text]){
        

        [[PublicService sharedInstance] registerUserWithUserName:self.userNameLabel.text Password:self.passwordTextField.text Password2:self.repeatPasswordTextField.text OnCompletion:^(NSDictionary *result, BOOL isSucess) {
           
            if(isSucess){
                
                NSString *token = [result objectForKey:@"token"];
                AppDelegate* appDelgate = (AppDelegate*)[UIApplication sharedApplication].delegate;
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                [defaults setValue:token forKey:ktoken];
                [defaults synchronize];
                appDelgate.configuration.token = [defaults objectForKey:ktoken];
                [self dismissViewControllerAnimated:YES completion:nil];
            }else{
                
                [WishUtils showErrorAlertWithTitle:@"" AndText:[result objectForKey:@"message"]];
            }
        }];
    }else{
        
        [WishUtils shakeAnimationWithViewComtroller:self];
    }
}

@end
