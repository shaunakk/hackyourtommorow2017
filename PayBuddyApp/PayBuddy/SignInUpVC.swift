/*
 1. install fbsdk with cocoapods.
 2. Register app
 3. Integration
 -----------------------------------
 1. https://developers.facebook.com/docs/ios/getting-started, "getting started" (left panel), scroll down, open facebook app dashboard, +Add new app (top right), fill in captcha, name it similar to your app's name, category doesn't really matter, "create app id"
 2. CLick the left tab, settings, scroll down to a wide button: add a platform, ios,  turn single sign on "on"
 3. go to xcode, get the bundle id copy it,
 4. paste in the bundle id into the tab
 5. back to facebook for developers website, "advanced topics" under getting started.  Scroll down to CocoaPods copy the 3 lines of pods. open terminal.
 go to your project, (easy way: drag your blue icon project from file navigator into your terminal, delete up to your project) do pod init (if you have already installed cocoapods). open podfile and paste the pod strings you copied right below the "# Pods for <YourProjectName>" line. save it. go back to terminal, "pod install"
  6. close the project, open the workspace.
 (https://www.youtube.com/watch?v=iSszeW1aH6I&list=PL0dzCUj1L5JGwSBwZIDlalK1bJph6xNi9, 8:08m)
 7. open facebook website, scroll to step 4, copy the plist code from the top down stopping just before <key>NSPhotoLibraryUsageDescription</key> though it might not be bad to use....xcode -> right click on plist -> open as -> source code. paste between <dict> and <key>CFBundle...
 8. Copy the AppID from the dashboard and paste it in the 2 plist placeholders.
 9. Put in the app name. Doesn't need to match anything, just shows up {your-app-name}
 10.  run app. eliminate the garbage output. Edit scheme -> run -> under Environment Variables.  Put in OS_ACTIVITY_MODE, value: "disable" then close.
 11.  run app. go to step number 5. If you didn't copy the AppDelegate, go to AppDelegate: import FBSDKCoreKit
 11:39
 12. either copy this app's appdelegate or copy the FBSDK conventioned code, and open url function definition.
 
 //Put the following in did finish launching with options.
   FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
 
 //Put this at the appdelegate's methods scope.
 func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
 let handled = FBSDKApplicationDelegate.sharedInstance().application(app, open: url, sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String!, annotation: options[UIApplicationOpenURLOptionsKey.annotation])
 return handled
 }
 
 13. open xcode, select your project, capabilities, find keychain sharing, turn it on.
 14. open fbook dashboard -> app review (left panel) -> make firebaseSocialLogin public set to "YES"
 ----------------------------------------------------------------------------------------
 ***Setup Firebase***
 
 *Overview
 
 1. Create Application
 2. Install SDK
 3. Sign in Facebook user
 
 -------------------------
 1. Go to Firebase console.  Create a new project.
 2. click add firebase to your ios app
 3. Put in bundle id, don't need to fill the other fields, register.
 4. Get the plist and drag it under your plist, make sure it is named GoogleService-Info, click the GoogleService-Info.plist file, open attributes inspector first tab, make sure the project is checked in the targets.
 5. Set up the auth package by opening terminal, go to the project directory to your project. open Podfile,
 6. put pod 'Firebase/Auth' in your pod list.
 7. pod install
 8. import Firebase
 9. go back to the Firebase website. click continue.
 10 click finish if you copied the app delegate, otherwise put that line of code in your appdelegate and import firebase there. then finish.
 11. Go to Firebase console -> Authentication -> Sign-in method -> choose facebook, select on
 12. go to your facebook dashboard for your app, copy the app id, then get the app secret. put them in the form and click save. run try logging in, shouldn't show an error.
 -------------------------
 ***Google Sign in***
 
 *Overview
1. install googlesignin pod.
------
 1. go to https://firebase.google.com/docs/auth/ios/google-signin
 2. open terminal, add pod 'GoogleSignIn' to the podfile, then save, then pod install
 3. import GoogleSignIn, run.
 4. Add custom URL schemes to your Xcode project:
 Open your project configuration: double-click the project name in the left tree view. Select your app from the TARGETS section, then select the Info tab, and expand the URL Types section.
 Click the + button, and add a URL scheme for your reversed client ID. To find this value, open the GoogleService-Info.plist configuration file, and look for the REVERSED_CLIENT_ID key. Copy the value of that key, and paste it into the URL Schemes box on the configuration page. Leave the other fields blank.
 When completed, your config should look something similar to the following (but with your application-specific values)
 5. edit scheme run, arguments passed on launch, add -FIRAnalyticsDebugEnabled
 6.  go into firebase, enable google authenticator, authentication -> google -> enable save.

 */

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit
import Firebase
import GoogleSignIn
//paybuddy-d3df8 id on firebase


class SignInUpVC: UIViewController, FBSDKLoginButtonDelegate, GIDSignInUIDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        //view.backgroundColor = .white
        let backgroundImage = UIImageView(frame: view.frame)
        backgroundImage.image = #imageLiteral(resourceName: "Log in")
        backgroundImage.contentMode = .scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        setupFacebookButtons()
        setupGoogleButtons()
        
    }

    
    fileprivate func setupGoogleButtons() {

        
//        let customBtn = UIButton(type: .system)
//        customBtn.frame = CGRect(x: 16, y: view.frame.height - (116 + 66 + 66), width: view.frame.width - 32, height: 50)
//        customBtn.setImage(#imageLiteral(resourceName: "googleBtnImg"), for: .normal)
//        customBtn.addTarget(self, action: #selector(handleCustomGoogleSign), for: .touchUpInside)
//        view.addSubview(customBtn)
        
        GIDSignIn.sharedInstance().uiDelegate = self
    }
    
    @objc func handleCustomGoogleSign() {
        GIDSignIn.sharedInstance().signIn()
    }
    
    fileprivate func setupFacebookButtons() {
        let customFBButton = UIButton()
        customFBButton.setImage(#imageLiteral(resourceName: "facebookBtnImg"), for: .normal)
        customFBButton.frame = CGRect(x: 16, y: view.frame.height - 116 - 66, width: view.frame.width - 32, height: 50)
        view.addSubview(customFBButton)
        
        customFBButton.addTarget(self, action: #selector(handleCustomFBLogin), for: .touchUpInside)
    }
    
    @objc func handleCustomFBLogin() {
        self.present(CustomTabBarController(), animated: true, completion: nil)
//        print(#function, #line)
//        FBSDKLoginManager().logIn(withReadPermissions: ["email", "public_profile"], from: self) {
//            (result, err) in
//            if err != nil {
//                print("Custom FB Login failed: ", err!)
//                return
//            }
//            //tokens are a convenient way for facebook to make sure you are the correct user.
//            print(result?.token.tokenString ?? "we didn't get a token string")
//            self.showEmailAddress()
////HERE
//            let customTabBarController = CustomTabBarController()
//            self.present(customTabBarController, animated: true, completion: nil)
//        }
    }
    
    //called when the application hands us back the user from authentication.
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("Did log out of Facebook")
    }
    
    //called when the application hands us back the user from authentication.
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil {
            print(error, " -SL")
            return
        }
        print("Successfully logged in with facebook...")
//HERE
        let customTabBarController = CustomTabBarController()
        self.present(customTabBarController, animated: true)
        showEmailAddress()
    }
    
    func showEmailAddress() {
        let accessToken = FBSDKAccessToken.current()
        guard let accessTokenString = accessToken?.tokenString else {return}
        let credentials = FacebookAuthProvider.credential(withAccessToken: accessTokenString)
        Auth.auth().signIn(with: credentials) {
            (user, err) in
            if err != nil {
                print("Something went wrong with our FB user: ", err!)
                return
            }
            print("Successfully logged in with our user: ", user ?? "We have an empty user")
//HERE
            let customTabBarController = CustomTabBarController()
            self.present(customTabBarController, animated: true, completion: nil)
        }
        
        FBSDKGraphRequest(graphPath: "/me", parameters: ["fields":"id, name, email"]).start {
            (connection, result, err) in
            if err != nil {
                print("Failed to start graph request:", err!)
                return
            }
            print(result ?? "result was nil -SL")
            
        }
    }
    
    
    
}
