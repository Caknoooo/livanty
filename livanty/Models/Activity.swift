//
//  Activity.swift
//  livanty
//
//  Created by M Naufal Badruttamam on 11/05/25.
//

import Foundation
import SwiftUI

struct Activity: Identifiable {
    let id = UUID()
    let name: String
    let title: String
    let description: String
    let icon: String
    
    var storyContent: String {
        switch title {
        case "College":
            return "Every morning I wake up at 7, preparing myself enthusiastically for classes at Ciputra University. My campus has an inspiring environment and supportive professors. I'm studying a major that I'm passionate about and always try to be active in class, discussing with friends, and completing assignments with dedication. The packed class schedule has taught me to manage my time well."
        case "Apple Academy":
            return "Afternoon is valuable time at Apple Academy. This is a golden opportunity to learn app development from industry experts. Here, I collaborate with talented friends on innovative projects, from idea to implementation. Every session at the Academy expands my knowledge about Apple technology and teaches me how to 'think different' the Apple way. This experience is invaluable for my future career."
        case "Exercise":
            return "Evening is time to move! I really enjoy playing badminton and basketball with friends. Sometimes I also run around campus or city parks to stay fit. Sports isn't just about physical health for me, but also a way to refresh my mind after a day of studying. These moments also strengthen friendships with my fellow players."
        case "Freelance & Organization":
            return "Night is my time to develop professional and social skills. As a freelancer, I work on various challenging design and app development projects. Additionally, my involvement in campus organizations teaches me leadership and teamwork. Although my schedule is packed, I always enjoy every responsibility because of my passion. All of this shapes my multitalented identity."
        default:
            return ""
        }
    }

    var storyBackgroundName: String {
        switch title {
        case "College": return "campus_background"
        case "Apple Academy": return "apple_academy_background"
        case "Exercise": return "sports_background"
        case "Freelance & Organization": return "work_background"
        default: return ""
        }
    }
}
