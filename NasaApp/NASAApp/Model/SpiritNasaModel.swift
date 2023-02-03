//
//  SpiritNasaModel.swift
//  NASAApp
//
//  Created by Şehriban Yıldırım on 31.01.2023.
//

import Foundation
// MARK: - Welcome
struct SpiritNasa: Codable {
    let photos: [SpiritPhoto]
}

// MARK: - Photo
struct SpiritPhoto: Codable {
    let id, sol: Int
    let camera: SpiritCamera
    let imgSrc: String
    let earthDate: String
    let rover: SpiritRover

    enum CodingKeys: String, CodingKey {
        case id, sol, camera
        case imgSrc = "img_src"
        case earthDate = "earth_date"
        case rover
    }
}

// MARK: - Camera
struct SpiritCamera: Codable {
    let id: Int
    let name: CameraName
    let roverID: Int
    let fullName: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case roverID = "rover_id"
        case fullName = "full_name"
    }
    
    enum CameraName: String, Codable {
        case chemcam = "CHEMCAM"
        case fhaz = "FHAZ"
        case mast = "MAST"
        case navcam = "NAVCAM"
        case rhaz = "RHAZ"
        case mahli = "MAHLI"
        case mardi = "MARDI"
        case pancam = "PANCAM"
        case minites = "MINITES"
    }
}

// MARK: - Rover
struct SpiritRover: Codable {
    let id: Int
    let name, landingDate, launchDate, status: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case landingDate = "landing_date"
        case launchDate = "launch_date"
        case status
    }
}
