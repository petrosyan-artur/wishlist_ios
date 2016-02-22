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
    
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    [backButton setImage:[UIImage imageNamed:@"backButtonIcon"] forState:UIControlStateNormal];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    [backButton addTarget:self action:@selector(popBack) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) popBack {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)signInButtonAction:(UIButton *)sender {
    
    if(![self.usernameTextField.text isEqualToString:@""] && ![self.passwordTextField.text isEqualToString:@""]){
        
        UIView *transparent = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, kmainScreenWidth, kmainScreenHeight)];
        transparent.backgroundColor = [UIColor blackColor];
        transparent.alpha = 0.8f;
        UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        indicator.center =CGPointMake(160.0f, 200.0f);
        [transparent addSubview:indicator];
        [indicator startAnimating];
        [self.view addSubview:transparent];
        
        [[PublicService sharedInstance] authenticateWithUsername:self.usernameTextField.text AndPassword:self.passwordTextField.text OnCompletion:^(NSDictionary *result, BOOL isSucess) {
            
            [transparent removeFromSuperview];
            if(isSucess){
                
                NSString *token = [result objectForKey:@"token"];
                NSString *myUserID = [result objectForKey:@"userId"];
                AppDelegate* appDelgate = (AppDelegate*)[UIApplication sharedApplication].delegate;
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                [defaults setValue:token forKey:ktoken];
                [defaults setValue:myUserID forKey:kMyUserID];
                [defaults synchronize];
                appDelgate.configuration.token = [defaults objectForKey:ktoken];
                appDelgate.configuration.myUserID = [defaults objectForKey:kMyUserID];
                NSDictionary *userInfo = @{
                                           @"wishCreate" : @"0",
                                           };
                
                NSNotificationCenter* nc = [NSNotificationCenter defaultCenter];
                [nc postNotificationName:@"getRefreshNotification" object:self userInfo:userInfo];
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
