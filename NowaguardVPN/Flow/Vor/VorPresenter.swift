import Foundation
import FirebaseRemoteConfigInternal

protocol VorDelegate: AnyObject {
    func didFinish()
}

final class VorPresenter {
    var delegate: VorDelegate
    
    init(delegate: VorDelegate) {
        self.delegate = delegate
    }
    
    var textTitleV1_2: String!
    var subtitleV1_2: String!
    var buttonTGitleV1_2: String!
    var textTitleV1_3: String!
    var textTitle2V1_3: String!
    var textTitle3V1_3: String!
    var subtitleV1_3: String!
    var subtitle1V1_3: String!
    var contentTitleV1_3: String!
    var subtitlesV1_3: [String]!
    var subtitles1V1_3: [String]!
    var buttonTGitleV1_3: String!
    var buttonTGitle1V1_3: String!
    var alertTitleV1_3: String!
    var alertContentV1_3: String!
    var alertButtonV1_3: String!
    var textTitleV1_last: String!
    var subtitleV1_last: String!
    var buttonTGitleV1_last: String!
    
    var textTitleV2_2: String!
    var subtitleV2_2: String!
    var buttonTGitleV2_2: String!
    var textTitleV2_3: String!
    var subtitleV2_3: String!
    var buttonTGitleV2_3: String!
    var textTitleV2_4: String!
    var subtitleV2_4: String!
    var subtitle1: String!
    var subtitle2: String!
    var buttonTGitle: String!
    var subtitles: [String]!
    var textTitleV2_Fail: String!
    var subtitleV2_Fail: String!
    var buttonTGitleV2_Fail: String!
    var textTitleV2_Last: String!
    var subtitleV2_Last: String!
    var buttonTGitleV2_Last: String!
    
    
    private let remoteConfig = RemoteConfig.remoteConfig()
    private let languageCode = Locale.preferredLanguages[0]
    
    @MainActor
    func load1() async {
        do {
            let status = try await remoteConfig.fetch(withExpirationDuration: 0)
            
            if status == .success {
                try await remoteConfig.activate()
                
                textTitleV1_2 = getString(forKey: "textTitleV1_2")
                subtitleV1_2 = getString(forKey: "subtitleV1_2")
                buttonTGitleV1_2 = getString(forKey: "buttonTGitleV1_2")
                textTitleV1_3 = getString(forKey: "textTitleV1_3")
                textTitle2V1_3 = getString(forKey: "textTitle2V1_3")
                textTitle3V1_3 = getString(forKey: "textTitle3V1_3")
                subtitleV1_3 = getString(forKey: "subtitleV1_3")
                subtitle1V1_3 = getString(forKey: "subtitle1V1_3")
                contentTitleV1_3 = getString(forKey: "contentTitleV1_3")
                subtitlesV1_3 = getStrings(forKey: "subtitlesV1_3")
                subtitles1V1_3 = getStrings(forKey: "subtitles1V1_3")
                buttonTGitleV1_3 = getString(forKey: "buttonTGitleV1_3")
                buttonTGitle1V1_3 = getString(forKey: "buttonTGitle1V1_3")
                alertTitleV1_3 = getString(forKey: "alertTitleV1_3")
                alertContentV1_3 = getString(forKey: "alertContentV1_3")
                alertButtonV1_3 = getString(forKey: "alertButtonV1_3")
                textTitleV1_last = getString(forKey: "textTitleV1_last")
                subtitleV1_last = getString(forKey: "subtitleV1_last")
                buttonTGitleV1_last = getString(forKey: "buttonTGitleV1_last")
            } else {
                print("status != success")
            }
            
        } catch {
            print("Config not fetched")
            print("Error: \(error.localizedDescription )")
        }
    }
    @MainActor
    func load2() async {
        do {
            let status = try await remoteConfig.fetch(withExpirationDuration: 0)
            
            if status == .success {
                try await remoteConfig.activate()
                
                textTitleV2_2 = getString(forKey: "textTitleV2_2")
                subtitleV2_2 = getString(forKey: "subtitleV2_2")
                buttonTGitleV2_2 = getString(forKey: "buttonTGitleV2_2")
                textTitleV2_3 = getString(forKey: "textTitleV2_3")
                subtitleV2_3 = getString(forKey: "subtitleV2_3")
                buttonTGitleV2_3 = getString(forKey: "buttonTGitleV2_3")
                textTitleV2_4 = getString(forKey: "textTitleV2_4")
                subtitleV2_4 = getString(forKey: "subtitleV2_4")
                subtitle1 = getString(forKey: "subtitle1")
                subtitle2 = getString(forKey: "subtitle2")
                buttonTGitle = getString(forKey: "buttonTGitle")
                subtitles = getStrings(forKey: "subtitles")
                textTitleV2_Fail = getString(forKey: "textTitleV2_Fail")
                subtitleV2_Fail = getString(forKey: "subtitleV2_Fail")
                buttonTGitleV2_Fail = getString(forKey: "buttonTGitleV2_Fail")
                textTitleV2_Last = getString(forKey: "textTitleV2_Last")
                subtitleV2_Last = getString(forKey: "subtitleV2_Last")
                buttonTGitleV2_Last = getString(forKey: "buttonTGitleV2_Last")
                
            } else {
                print("status != success")
            }
            
        } catch {
            print("Config not fetched")
            print("Error: \(error.localizedDescription )")
        }
    }
    
    
    private func getString(forKey: String) -> String {
        let a: [String: Any] = (remoteConfig.configValue(forKey: forKey).jsonValue as? [String : Any?] ?? [languageCode: forKey]) as [String : Any]
        return (a[languageCode] as? String) ?? forKey
    }
    private func getStrings(forKey: String) -> [String] {
        let a: [String: Any] = remoteConfig.configValue(forKey: forKey).jsonValue as? [String : Any] ?? ["en": [forKey]]
        return a["en"] as? [String] ?? [forKey]
    }

    
    
}
