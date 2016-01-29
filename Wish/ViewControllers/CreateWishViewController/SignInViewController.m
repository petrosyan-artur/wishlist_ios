//
//  SignInViewController.m
//  Wish
//
//  Created by Annie Klekchyan on 1/29/16.
//  Copyright © 2016 TLab. All rights reserved.
//

#import "SignInViewController.h"
#import "Definitions.h"
#import "PublicService.h"
#import "WishUtils.h"

@interface SignInViewController ()
@property (strong, nonatomic) IBOutlet UITextField *usernameTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
- (IBAction)signInButtonAction:(UIButton *)sender;

@end

@implementation SignInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"SIGN IN";
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)signInButtonAction:(UIButton *)sender {
    
    [[PublicService sharedInstance] authenticateWithUsername:self.usernameTextField.text AndPassword:self.passwordTextField.text OnCompletion:^(NSDictionary *result, BOOL isSucess) {
        
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
}

@end
