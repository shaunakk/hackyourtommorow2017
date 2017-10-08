
import UIKit
import CoreData
import FBSDKCoreKit
import Firebase
import GoogleSignIn


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {
    
    var window: UIWindow?
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let err = error {
            print("failed to log in to Google -SL", err)
            return
        }
        print("Successfully logged in to Google -SL", user)
        guard let idToken = user.authentication?.idToken else { return }
        guard let accessToken = user.authentication?.accessToken else { return }
        let credentials = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
        Auth.auth().signIn(with: credentials) { (user, error) in
            if let err = error {
                print("failed to create a firebase user with Google Account: ", err)
                return
            }
            guard let uid = user?.uid else { return }
            print("Successfully logged into Firebase with Google: ", uid)
        }
    }
    


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        self.window?.rootViewController = CustomTabBarController()

        //Setting Tab bar values.
        UITabBar.appearance().isTranslucent = false
        UITabBar.appearance().barTintColor = .white
        UITabBar.appearance().unselectedItemTintColor = .clear
        UITabBar.appearance().tintColor = .clear
        UITabBar.appearance().selectionIndicatorImage = #imageLiteral(resourceName: "btn-green copy")
        UITabBar.appearance().backgroundColor = .white
        //Fabric.with([Twitter.self])
        FirebaseApp.configure()
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
//        if Auth.auth().currentUser?.uid != nil {
//            self.window?.rootViewController = CustomTabBarController()
//
//        } else {
//            self.window?.rootViewController = SignInUpVC()
//        }
        self.window?.rootViewController = SignInUpVC()
        return true
    }

    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        let sourceAppStr = options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String!
        let annotation = options[UIApplicationOpenURLOptionsKey.annotation]
        let handled = FBSDKApplicationDelegate.sharedInstance().application(app, open: url, sourceApplication: sourceAppStr, annotation:  annotation)
        GIDSignIn.sharedInstance().handle(url, sourceApplication: sourceAppStr, annotation: annotation)
        return handled
    }
    
    
    
    
    func applicationWillResignActive(_ application: UIApplication) {}
    func applicationDidEnterBackground(_ application: UIApplication) {}
    func applicationWillEnterForeground(_ application: UIApplication) {}
    func applicationDidBecomeActive(_ application: UIApplication) {}
    func applicationWillTerminate(_ application: UIApplication) {}

    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "PayBuddy")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()


    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

