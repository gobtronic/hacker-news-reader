//
//  Comment.swift
//  hnreader
//
//  Created by gobtronic on 12/04/2023.
//

import Foundation

struct Comment: Codable, Identifiable {
    let id: Int
    let by: String
    let text: String
    let parent: Int
    let time: Double
    let kids: [Int]?
}

extension Comment {
    static func realMocked() -> Comment {
        return Comment(id: 9224,
                       by: "BrandonM",
                       text: "I have a few qualms with this app:<p>1. For a Linux user, you can already build such a system yourself quite trivially by getting an FTP account, mounting it locally with curlftpfs, and then using SVN or CVS on the mounted filesystem.  From Windows or Mac, this FTP account could be accessed through built-in software.<p>2. It doesn't actually replace a USB drive.  Most people I know e-mail files to themselves or host them somewhere online to be able to perform presentations, but they still carry a USB drive in case there are connectivity problems.  This does not solve the connectivity issue.<p>3. It does not seem very \"viral\" or income-generating.  I know this is premature at this point, but without charging users for the service, is it reasonable to expect to make money off of this?",
                       parent: 8863,
                       time: 1175786214,
                       kids: [
                           9272
                       ])
    }
}
