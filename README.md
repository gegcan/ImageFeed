## ImageFeed (iOS)


ImageFeed - многостраничное приложение предназначено для просмотра изображений через API Unsplash

### Основные функции

- [x] В приложении обязательна авторизация через OAuth Unsplash, поддерживается работа нескольких пользователей
- [x] Главный экран состоит из ленты с изображениями
- [x] Пользователь может просматривать ленту, добавлять и удалять изображения из избранного
- [x] Пользователь может просматривать каждое изображение отдельно и делиться ссылкой на них, сохранять в телефон
- [x] У пользователя есть профиль с краткой информацией о пользователе
- [x] У приложения есть возможность лайкать фотографии при просмотре изображения на весь экран



### Требования заказчика
[Дизайн приложения (Figma)](https://www.figma.com/file/Y8jmksdf2qxOUmLEt1Afth/Image-Feed?type=design&node-id=0-1&mode=design&t=MwVNdcCuW1WCSX7e-0
)
[Техническое задание](https://github.com/Yandex-Practicum/iOS-ImageFeed-Public)
[Unsplash API](https://unsplash.com/documentation)


### Технические требования
Архитектура - `MVC`, рефакторинг на `MVP`

Верстка - `storyboard`, рефакторинг профиля и `верстка кодом`


| Системные требования                                 | Значение                     |
| ---------------------------------------------------- | ---------------------------- |
| Версия iOS                                           | Minimum 13.0                 |
| Платформа                                            | iPhone                       |
| Ориентация устройства                                | Портрет (только)             |
| Шрифт                                                | Системный                    |


### Зависимости
`Kingfisher (SPM)`, `KeychainWrapper (SPM)`, `SwiftLint`

### Стек технологий 
`TabBarController`, `NavigationController`, `NavigationBar`, `UITableView`, `UITableViewCell`, `UserDefaults`, `Keychain`, `JSON API`, `OAuth 2.0`

### Тесты
`Unit-tests`, `UI-tests`

### Инструменты
`Xcode`, `Figma`, `Charles`
 
### План по доработке
- [ ] Реализовать ленту избранного


### Список создателей
[Александр Гегешидзе](https://github.com/gegcan)
