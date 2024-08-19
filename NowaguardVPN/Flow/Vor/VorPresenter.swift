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
                
                let dict: [String: Any] = remoteConfig.configValue(forKey: "fl1_" + languageCode.lowercased()).jsonValue as? [String: Any] ?? [:]
                
                textTitleV1_2 = dict["textTitleV1_2"] as? String
                subtitleV1_2 = dict["subtitleV1_2"] as? String
                buttonTGitleV1_2 = dict["buttonTGitleV1_2"] as? String
                textTitleV1_3 = dict["textTitleV1_3"] as? String
                textTitle2V1_3 = dict["textTitle2V1_3"] as? String
                textTitle3V1_3 = dict["textTitle3V1_3"] as? String
                subtitleV1_3 = dict["subtitleV1_3"] as? String
                subtitle1V1_3 = dict["subtitle1V1_3"] as? String
                contentTitleV1_3 = dict["contentTitleV1_3"] as? String
                subtitlesV1_3 = dict["subtitlesV1_3"] as? [String]
                subtitles1V1_3 = dict["subtitles1V1_3"] as? [String]
                buttonTGitleV1_3 = dict["buttonTGitleV1_3"] as? String
                buttonTGitle1V1_3 = dict["buttonTGitle1V1_3"] as? String
                alertTitleV1_3 = dict["alertTitleV1_3"] as? String
                alertContentV1_3 = dict["alertContentV1_3"] as? String
                alertButtonV1_3 = dict["alertButtonV1_3"] as? String
                textTitleV1_last = dict["textTitleV1_last"] as? String
                subtitleV1_last = dict["subtitleV1_last"] as? String
                buttonTGitleV1_last = dict["buttonTGitleV1_last"] as? String
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
                
                let dict: [String: Any] = remoteConfig.configValue(forKey: "fl2_" + languageCode.lowercased()).jsonValue as? [String: Any] ?? [:]
                
                textTitleV2_2 = dict["textTitleV2_2"] as? String
                subtitleV2_2 = dict["subtitleV2_2"] as? String
                buttonTGitleV2_2 = dict["buttonTGitleV2_3"] as? String
                textTitleV2_3 = dict["textTitleV2_3"] as? String
                subtitleV2_3 = dict["subtitleV2_3"] as? String
                buttonTGitleV2_3 = dict["buttonTGitleV2_3"] as? String
                textTitleV2_4 = dict["textTitleV2_4"] as? String
                subtitleV2_4 = dict["subtitleV2_4"] as? String
                subtitle1 = dict["subtitle1"] as? String
                subtitle2 = dict["subtitle2"] as? String
                buttonTGitle = dict["buttonTGitleV2_3"] as? String
                subtitles = dict["subtitles"] as? [String]
                textTitleV2_Fail = dict["textTitleV2_Fail"] as? String
                subtitleV2_Fail = dict["subtitleV2_Fail"] as? String
                buttonTGitleV2_Fail = dict["buttonTGitleV2_3"] as? String
                textTitleV2_Last = dict["textTitleV2_Last"] as? String
                subtitleV2_Last = dict["subtitleV2_Last"] as? String
                buttonTGitleV2_Last = dict["buttonTGitleV2_3"] as? String
                
            } else {
                print("status != success")
            }
            
        } catch {
            print("Config not fetched")
            print("Error: \(error.localizedDescription )")
        }
    }
}
