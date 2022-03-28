import UIKit

struct Post {
    var title: String
    var author: String
    var description: String
    var image: String
    var likes: Int
    var views: Int
}

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

//var isLogined: Bool = false


struct Constants {
    struct ProfileView {
        struct AvatarImage {
            static let topMargin: CGFloat = 16
            static let leftMargin: CGFloat = 16
            static let size: CGFloat = 130.0
        }
        struct StatusButton {
            static let topMargin: CGFloat = 16
            static let leftMargin: CGFloat = 16
            static let rightMargin: CGFloat = 16
            static let buttomMargin: CGFloat = 16
            static let height: CGFloat = 50
        }
        struct FullName {
            static let topMargin: CGFloat = 27
            static let leftMargin: CGFloat = 16
            static let rightMargin: CGFloat = 16
            static let buttomMargin: CGFloat = 16
            static let height: CGFloat = 25
        }
        struct StatusLabel {
            static let leftMargin: CGFloat = 16
            static let rightMargin: CGFloat = 16
            static let buttomMargin: CGFloat = 50
            static let height: CGFloat = 25
        }
        struct StatusField {
            static let topMargin: CGFloat = 3
            static let leftMargin: CGFloat = 16
            static let rightMargin: CGFloat = 16
            static let height: CGFloat = 40
        }

    }
    struct PostViewCell {
        static let fortSizeHeader: CGFloat = 20
        static let fortSizeBody: CGFloat = 14
        static let fortSizeFoter: CGFloat = 16
        static let allMargin: CGFloat = 16.0
    }
    struct LoginView {
        struct StackView {
            static let height: CGFloat = 510
        }
        struct Logo {
            static let imageName: String = "Logo"
            static let topMargin: CGFloat = 120.0
            static let width: CGFloat = 100
            static let height: CGFloat = 100
        }
        struct StackField {
            static let topMargin: CGFloat = 120.0
            static let leftMargin: CGFloat = 16.0
            static let rigthMargin: CGFloat = 16.0
            static let height: CGFloat = 100
            static let cornerRadius: CGFloat = 10
            static let borderWidth: CGFloat = 0.5
        }
        struct TextField {
            static let borderWidth: CGFloat = 0.5
            static let loginPlaceholderText: String = "Email or phone"
            static let pwdPlaceholderText: String = "Password"
            static let fontSize: CGFloat = 16
            static let height: CGFloat = 50
            static let nameTintColor: String = "accentColor"
        }
        struct LoginButton {
            static let cornerRadius: CGFloat = 10
            static let backgraundImageName: String = "blue_pixel"
            static let titleText: String = "Login"
            static let fontSize: CGFloat = 16
            static let height: CGFloat = 50
            static let topMargin: CGFloat = 16.0
            static let leftMargin: CGFloat = 16.0
            static let rigthMargin: CGFloat = 16.0
        }
    }
    struct BlankView {
        static let width: CGFloat = 10
        static let height: CGFloat = 10
    }
    
}


 
