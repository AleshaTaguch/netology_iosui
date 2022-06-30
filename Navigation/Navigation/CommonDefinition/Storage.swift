import Foundation
import StorageService
import UIKit

let sourcePostsArray: [Post] =
    [Post(title: "1. Композиция в фотографии - это построение и последовательность изобразительных",
          author: "Петя",
          description: "Композиция в фотографии — это построение и последовательность изобразительных приемов, реализующих художественную идею. Можно сказать, что композиция это соотношение и взаиморасположение частей.",
          image: "photo1",
          likes: 10,
          views: 100),
     Post(title: "2. Линейная перспектива",
          author: "Вася",
          description: "Линейная перспектива: параллельные линии стремятся сойтись в одной точке, предметы и объекты имеющие одинаковый размер, кажутся нам тем меньше чем дальше они от нас находятся.",
          image: "photo2",
          likes: 20,
          views: 200),
     Post(title: "3. Тональная перспектива",
          author: "Миша",
          description: "Первые определения тональной (многие говорят «воздушная») перспективы дал Леонардо да Винчи: «Вещи на расстоянии кажутся тебе двусмысленными и сомнительными; делай и ты их с такой же расплывчатостью, иначе они в твоей картине покажутся на одинаковом расстоянии…..",
          image: "photo3",
          likes: 30,
          views: 300),
     Post(title: "4. Ракурс съемки",
          author: "Коля",
          description: "Немаловажно для передачи пространства на фотографии является наличие разных планов объектов съемки. Большинство снимков можно разделить на три плана: передний, средний и задний.",
          image: "photo4",
          likes: 25,
          views: 250),
     Post(title: "5. Точка съемки",
          author: "Вика",
          description: "При съемке очень важен выбор точки съемки. Если предположить, что свет падает на предмет съемки, то при разных поворотах объект окажется или более узнаваемым, или будет выявлена его фактура. Фактически точка съемки определяет предмет и его свойства.",
          image: "photo5",
          likes: 15,
          views: 150)
    ]

let sourcePhotoNameArray: [String] = ["foto2-1","foto2-2","foto2-3","foto2-4","foto2-5"
                                 ,"foto2-6","foto2-7","foto2-8","foto2-9","foto2-10"
                                 ,"foto2-11","foto2-12","foto2-13","foto2-14","foto2-15"
                                 ,"foto2-16","foto2-17","foto2-18","foto2-19","foto2-20"]

let sourcePhotoImageArray: [UIImage] = {
    var imageArray: [UIImage] = []
    sourcePhotoNameArray.forEach{
        if let image = UIImage(named: $0) {
            imageArray.append(image)
        }
    }
    return imageArray
}()

struct MusicFileName {
    var name: String
    var ext: String
}

let musicFileNameArray: [MusicFileName] = [MusicFileName(name: "Linkin_Park_Faint", ext: "mp3"),
                                           MusicFileName(name: "Linkin_Park_In_the_End", ext: "mp3"),
                                           MusicFileName(name: "Linkin_Park_Numb", ext: "mp3"),
                                           MusicFileName(name: "Linkin_Park_Somewhere_I_Belong", ext: "mp3"),
                                           MusicFileName(name: "Linkin_Park_What_Ive_Done", ext: "mp3") ] 

struct VideoSource {
    var title: String
    var url: String
}

let videoSourceArray: [VideoSource] = [
    VideoSource(title: "Video 1 (for AVPlayer)",
                url: "https://media.istockphoto.com/videos/beautiful-woman-at-the-beach-waves-for-you-to-follow-video-id1191080573"),
    
    VideoSource(title: "Video 2 (for AVPlayer)",
                url: "https://cdn.videvo.net/videvo_files/video/premium/video0307/large_watermarked/601-2_601-7633_preview.mp4"),
    VideoSource(title: "Понятие ARC (Automatic Reference Counting) (Swift 5)",
                                                   url: "https://www.youtube.com/embed/0leVGyPplZw"),
                                       VideoSource(title: "ARC в замыканиях (Swift 5)",
                                                   url: "https://www.youtube.com/embed/9kk4ZWwN598"),
                                       VideoSource(title: "Create a Video Player",
                                                   url: "https://www.youtube.com/embed/O4am8mb1RTs"),
                                       VideoSource(title: "Создание ячейки с кнопкой «Like» в TableView (Swift 5)",
                                                   url: "https://www.youtube.com/embed/LzoFm9YaP8Y"),
                                       VideoSource(title: "Создание ScrollView программно (Swift 5)",
                                                   url: "https://www.youtube.com/embed/SfcycWTK-mA"),
                                       VideoSource(title: "Custom TabBar программно (Swift 5)",
                                                   url: "https://www.youtube.com/embed/n91fDwkrwds"),
                                       VideoSource(title: "Новая версия IDE от Apple - XCode 14",
                                                   url: "https://www.youtube.com/embed/VchpcmaetCE")]
