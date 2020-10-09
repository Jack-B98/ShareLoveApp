//
//  AppDelegate.swift
//  ShareLoveApp
//
//

import UIKit
import Firebase
import GoogleSignIn
import FBSDKCoreKit
import FBSDKLoginKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {

    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {

        if let error = error {
            print(error.localizedDescription)
            return
        }
        
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                        accessToken: authentication.accessToken)
        
        //Authenticate with the token
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if let error = error {
                //Was not successful
                print ("Error occured :")
                print(error.localizedDescription)
                return
            }
            //Otherwise, we've succeeded
            print("User has logged in through Google.")
            let userId = user.userID                  // For client-side use only!
            let idToken = user.authentication.idToken // Safe to send to the server
            let fullName = user.profile.name
            let givenName = user.profile.givenName
            let familyName = user.profile.familyName
            let email = user.profile.email
            var urlString: String = "No photo url"
            if user.profile.hasImage
            {
                let userDP = user.profile.imageURL(withDimension: 100)
                urlString = userDP!.absoluteString
            } else {}
            let destinationReference = Database.database().reference().child("UserList").child((Auth.auth().currentUser?.uid)!)
            destinationReference.observeSingleEvent(of: .value) { (snapshot) in
                if snapshot.exists(){
                    print("User's Google profile exists\n")
                }else{
                    let userProfile = User(email_address: email!, name: fullName!, photo: urlString, money_recieved: 0.00, money_sent: 0.00)
                    
                    destinationReference.setValue(userProfile.toDictionary())
                }
            }
        }
    }

    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        print("User has signed out.\n")
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {

        ApplicationDelegate.shared.application(
            app,
            open: url,
            sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
            annotation: options[UIApplication.OpenURLOptionsKey.annotation]
        )
         return GIDSignIn.sharedInstance().handle(url)
    }
    
    var window: UIWindow?
    
    internal func application(_ application: UIApplication,
      didFinishLaunchingWithOptions launchOptions:
        [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        ApplicationDelegate.shared.application(
            application,
            didFinishLaunchingWithOptions: launchOptions
        )
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

