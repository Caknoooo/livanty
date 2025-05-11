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
        case "Kuliah":
            return "Setiap pagi aku bangun jam 7, menyiapkan diri dengan semangat untuk kuliah di Universitas Ciputra. Kampusku memiliki lingkungan yang inspiratif dan dosen-dosen yang supportif. Aku mengambil jurusan yang aku minati dan selalu berusaha aktif di kelas, berdiskusi dengan teman-teman, dan mengerjakan tugas dengan penuh dedikasi. Jadwal kuliah yang padat membuatku belajar mengelola waktu dengan baik."
        case "Apple Academy":
            return "Siang hari adalah waktu berharga di Apple Academy. Ini adalah kesempatan emas untuk belajar pengembangan aplikasi dari para ahli industri. Di sini, aku berkolaborasi dengan teman-teman berbakat dalam project inovatif, dari ide hingga implementasi. Setiap sesi di Academy memperluas pengetahuanku tentang teknologi Apple dan mengajarkanku cara berpikir 'think different' ala Apple. Pengalaman ini sangat berharga untuk karirku ke depan."
        case "Olahraga":
            return "Sore hari adalah waktu untuk bergerak! Aku sangat menikmati bermain badminton dan basket dengan teman-teman. Terkadang aku juga berlari di sekitar kampus atau taman kota untuk menjaga kebugaran. Olahraga bukan hanya tentang kesehatan fisik bagiku, tapi juga cara untuk refreshing pikiran setelah seharian belajar. Momen-momen ini juga memperkuat persahabatan dengan teman-teman sepermainan."
        case "Freelance & Organisasi":
            return "Malam hari adalah waktuku untuk mengembangkan skill profesional dan sosial. Sebagai freelancer, aku mengerjakan berbagai proyek desain dan pengembangan aplikasi yang menantang. Selain itu, keterlibatanku dalam organisasi kampus mengajarkan leadership dan teamwork. Meski jadwalku padat, aku selalu menikmati setiap tanggung jawab karena passion yang kumiliki. Ini semua membentuk jati diriku yang multitalenta."
        default:
            return ""
        }
    }
    
    var storyBackgroundName: String {
        switch title {
        case "Kuliah": return "campus_background"
        case "Apple Academy": return "apple_academy_background"
        case "Olahraga": return "sports_background"
        case "Freelance & Organisasi": return "work_background"
        default: return ""
        }
    }
}
