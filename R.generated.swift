//
// This is a generated file, do not edit!
// Generated by R.swift, see https://github.com/mac-cain13/R.swift
//

import Foundation
import Rswift
import UIKit

/// This `R` struct is generated and contains references to static resources.
struct R: Rswift.Validatable {
  fileprivate static let applicationLocale = hostingBundle.preferredLocalizations.first.flatMap(Locale.init) ?? Locale.current
  fileprivate static let hostingBundle = Bundle(for: R.Class.self)

  /// Find first language and bundle for which the table exists
  fileprivate static func localeBundle(tableName: String, preferredLanguages: [String]) -> (Foundation.Locale, Foundation.Bundle)? {
    // Filter preferredLanguages to localizations, use first locale
    var languages = preferredLanguages
      .map(Locale.init)
      .prefix(1)
      .flatMap { locale -> [String] in
        if hostingBundle.localizations.contains(locale.identifier) {
          if let language = locale.languageCode, hostingBundle.localizations.contains(language) {
            return [locale.identifier, language]
          } else {
            return [locale.identifier]
          }
        } else if let language = locale.languageCode, hostingBundle.localizations.contains(language) {
          return [language]
        } else {
          return []
        }
      }

    // If there's no languages, use development language as backstop
    if languages.isEmpty {
      if let developmentLocalization = hostingBundle.developmentLocalization {
        languages = [developmentLocalization]
      }
    } else {
      // Insert Base as second item (between locale identifier and languageCode)
      languages.insert("Base", at: 1)

      // Add development language as backstop
      if let developmentLocalization = hostingBundle.developmentLocalization {
        languages.append(developmentLocalization)
      }
    }

    // Find first language for which table exists
    // Note: key might not exist in chosen language (in that case, key will be shown)
    for language in languages {
      if let lproj = hostingBundle.url(forResource: language, withExtension: "lproj"),
         let lbundle = Bundle(url: lproj)
      {
        let strings = lbundle.url(forResource: tableName, withExtension: "strings")
        let stringsdict = lbundle.url(forResource: tableName, withExtension: "stringsdict")

        if strings != nil || stringsdict != nil {
          return (Locale(identifier: language), lbundle)
        }
      }
    }

    // If table is available in main bundle, don't look for localized resources
    let strings = hostingBundle.url(forResource: tableName, withExtension: "strings", subdirectory: nil, localization: nil)
    let stringsdict = hostingBundle.url(forResource: tableName, withExtension: "stringsdict", subdirectory: nil, localization: nil)

    if strings != nil || stringsdict != nil {
      return (applicationLocale, hostingBundle)
    }

    // If table is not found for requested languages, key will be shown
    return nil
  }

  /// Load string from Info.plist file
  fileprivate static func infoPlistString(path: [String], key: String) -> String? {
    var dict = hostingBundle.infoDictionary
    for step in path {
      guard let obj = dict?[step] as? [String: Any] else { return nil }
      dict = obj
    }
    return dict?[key] as? String
  }

  static func validate() throws {
    try font.validate()
    try intern.validate()
  }

  #if os(iOS) || os(tvOS)
  /// This `R.segue` struct is generated, and contains static references to 2 view controllers.
  struct segue {
    /// This struct is generated for `FoldersVC`, and contains static references to 1 segues.
    struct foldersVC {
      /// Segue identifier `goToFolder`.
      static let goToFolder: Rswift.StoryboardSegueIdentifier<UIKit.UIStoryboardSegue, FoldersVC, FolderVC> = Rswift.StoryboardSegueIdentifier(identifier: "goToFolder")

      #if os(iOS) || os(tvOS)
      /// Optionally returns a typed version of segue `goToFolder`.
      /// Returns nil if either the segue identifier, the source, destination, or segue types don't match.
      /// For use inside `prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)`.
      static func goToFolder(segue: UIKit.UIStoryboardSegue) -> Rswift.TypedStoryboardSegueInfo<UIKit.UIStoryboardSegue, FoldersVC, FolderVC>? {
        return Rswift.TypedStoryboardSegueInfo(segueIdentifier: R.segue.foldersVC.goToFolder, segue: segue)
      }
      #endif

      fileprivate init() {}
    }

    /// This struct is generated for `NoteVC`, and contains static references to 2 segues.
    struct noteVC {
      /// Segue identifier `goToMap`.
      static let goToMap: Rswift.StoryboardSegueIdentifier<UIKit.UIStoryboardSegue, NoteVC, NoteMapVC> = Rswift.StoryboardSegueIdentifier(identifier: "goToMap")
      /// Segue identifier `goToSelectFolder`.
      static let goToSelectFolder: Rswift.StoryboardSegueIdentifier<UIKit.UIStoryboardSegue, NoteVC, SelectFolderVC> = Rswift.StoryboardSegueIdentifier(identifier: "goToSelectFolder")

      #if os(iOS) || os(tvOS)
      /// Optionally returns a typed version of segue `goToMap`.
      /// Returns nil if either the segue identifier, the source, destination, or segue types don't match.
      /// For use inside `prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)`.
      static func goToMap(segue: UIKit.UIStoryboardSegue) -> Rswift.TypedStoryboardSegueInfo<UIKit.UIStoryboardSegue, NoteVC, NoteMapVC>? {
        return Rswift.TypedStoryboardSegueInfo(segueIdentifier: R.segue.noteVC.goToMap, segue: segue)
      }
      #endif

      #if os(iOS) || os(tvOS)
      /// Optionally returns a typed version of segue `goToSelectFolder`.
      /// Returns nil if either the segue identifier, the source, destination, or segue types don't match.
      /// For use inside `prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)`.
      static func goToSelectFolder(segue: UIKit.UIStoryboardSegue) -> Rswift.TypedStoryboardSegueInfo<UIKit.UIStoryboardSegue, NoteVC, SelectFolderVC>? {
        return Rswift.TypedStoryboardSegueInfo(segueIdentifier: R.segue.noteVC.goToSelectFolder, segue: segue)
      }
      #endif

      fileprivate init() {}
    }

    fileprivate init() {}
  }
  #endif

  #if os(iOS) || os(tvOS)
  /// This `R.storyboard` struct is generated, and contains static references to 5 storyboards.
  struct storyboard {
    /// Storyboard `Banner`.
    static let banner = _R.storyboard.banner()
    /// Storyboard `LaunchScreen`.
    static let launchScreen = _R.storyboard.launchScreen()
    /// Storyboard `Main`.
    static let main = _R.storyboard.main()
    /// Storyboard `Menu`.
    static let menu = _R.storyboard.menu()
    /// Storyboard `Note`.
    static let note = _R.storyboard.note()

    #if os(iOS) || os(tvOS)
    /// `UIStoryboard(name: "Banner", bundle: ...)`
    static func banner(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.banner)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIStoryboard(name: "LaunchScreen", bundle: ...)`
    static func launchScreen(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.launchScreen)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIStoryboard(name: "Main", bundle: ...)`
    static func main(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.main)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIStoryboard(name: "Menu", bundle: ...)`
    static func menu(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.menu)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIStoryboard(name: "Note", bundle: ...)`
    static func note(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.note)
    }
    #endif

    fileprivate init() {}
  }
  #endif

  /// This `R.color` struct is generated, and contains static references to 2 colors.
  struct color {
    /// Color `appBlue`.
    static let appBlue = Rswift.ColorResource(bundle: R.hostingBundle, name: "appBlue")
    /// Color `appOrange`.
    static let appOrange = Rswift.ColorResource(bundle: R.hostingBundle, name: "appOrange")

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "appBlue", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func appBlue(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.appBlue, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "appOrange", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func appOrange(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.appOrange, compatibleWith: traitCollection)
    }
    #endif

    fileprivate init() {}
  }

  /// This `R.file` struct is generated, and contains static references to 4 files.
  struct file {
    /// Resource file `GrinchedRegular.otf`.
    static let grinchedRegularOtf = Rswift.FileResource(bundle: R.hostingBundle, name: "GrinchedRegular", pathExtension: "otf")
    /// Resource file `Super Webcomic Bros. Bold Italic.ttf`.
    static let superWebcomicBrosBoldItalicTtf = Rswift.FileResource(bundle: R.hostingBundle, name: "Super Webcomic Bros. Bold Italic", pathExtension: "ttf")
    /// Resource file `Super Webcomic Bros. Bold.ttf`.
    static let superWebcomicBrosBoldTtf = Rswift.FileResource(bundle: R.hostingBundle, name: "Super Webcomic Bros. Bold", pathExtension: "ttf")
    /// Resource file `Super Webcomic Bros..ttf`.
    static let superWebcomicBrosTtf = Rswift.FileResource(bundle: R.hostingBundle, name: "Super Webcomic Bros.", pathExtension: "ttf")

    /// `bundle.url(forResource: "GrinchedRegular", withExtension: "otf")`
    static func grinchedRegularOtf(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.grinchedRegularOtf
      return fileResource.bundle.url(forResource: fileResource)
    }

    /// `bundle.url(forResource: "Super Webcomic Bros. Bold Italic", withExtension: "ttf")`
    static func superWebcomicBrosBoldItalicTtf(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.superWebcomicBrosBoldItalicTtf
      return fileResource.bundle.url(forResource: fileResource)
    }

    /// `bundle.url(forResource: "Super Webcomic Bros. Bold", withExtension: "ttf")`
    static func superWebcomicBrosBoldTtf(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.superWebcomicBrosBoldTtf
      return fileResource.bundle.url(forResource: fileResource)
    }

    /// `bundle.url(forResource: "Super Webcomic Bros.", withExtension: "ttf")`
    static func superWebcomicBrosTtf(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.superWebcomicBrosTtf
      return fileResource.bundle.url(forResource: fileResource)
    }

    fileprivate init() {}
  }

  /// This `R.font` struct is generated, and contains static references to 4 fonts.
  struct font: Rswift.Validatable {
    /// Font `Grinched`.
    static let grinched = Rswift.FontResource(fontName: "Grinched")
    /// Font `SuperWebcomicBros.-BoldItalic`.
    static let superWebcomicBrosBoldItalic = Rswift.FontResource(fontName: "SuperWebcomicBros.-BoldItalic")
    /// Font `SuperWebcomicBros.-Bold`.
    static let superWebcomicBrosBold = Rswift.FontResource(fontName: "SuperWebcomicBros.-Bold")
    /// Font `SuperWebcomicBros.`.
    static let superWebcomicBros = Rswift.FontResource(fontName: "SuperWebcomicBros.")

    /// `UIFont(name: "Grinched", size: ...)`
    static func grinched(size: CGFloat) -> UIKit.UIFont? {
      return UIKit.UIFont(resource: grinched, size: size)
    }

    /// `UIFont(name: "SuperWebcomicBros.", size: ...)`
    static func superWebcomicBros(size: CGFloat) -> UIKit.UIFont? {
      return UIKit.UIFont(resource: superWebcomicBros, size: size)
    }

    /// `UIFont(name: "SuperWebcomicBros.-Bold", size: ...)`
    static func superWebcomicBrosBold(size: CGFloat) -> UIKit.UIFont? {
      return UIKit.UIFont(resource: superWebcomicBrosBold, size: size)
    }

    /// `UIFont(name: "SuperWebcomicBros.-BoldItalic", size: ...)`
    static func superWebcomicBrosBoldItalic(size: CGFloat) -> UIKit.UIFont? {
      return UIKit.UIFont(resource: superWebcomicBrosBoldItalic, size: size)
    }

    static func validate() throws {
      if R.font.grinched(size: 42) == nil { throw Rswift.ValidationError(description:"[R.swift] Font 'Grinched' could not be loaded, is 'GrinchedRegular.otf' added to the UIAppFonts array in this targets Info.plist?") }
      if R.font.superWebcomicBros(size: 42) == nil { throw Rswift.ValidationError(description:"[R.swift] Font 'SuperWebcomicBros.' could not be loaded, is 'Super Webcomic Bros..ttf' added to the UIAppFonts array in this targets Info.plist?") }
      if R.font.superWebcomicBrosBold(size: 42) == nil { throw Rswift.ValidationError(description:"[R.swift] Font 'SuperWebcomicBros.-Bold' could not be loaded, is 'Super Webcomic Bros. Bold.ttf' added to the UIAppFonts array in this targets Info.plist?") }
      if R.font.superWebcomicBrosBoldItalic(size: 42) == nil { throw Rswift.ValidationError(description:"[R.swift] Font 'SuperWebcomicBros.-BoldItalic' could not be loaded, is 'Super Webcomic Bros. Bold Italic.ttf' added to the UIAppFonts array in this targets Info.plist?") }
    }

    fileprivate init() {}
  }

  /// This `R.image` struct is generated, and contains static references to 4 images.
  struct image {
    /// Image `BackgroundMenu`.
    static let backgroundMenu = Rswift.ImageResource(bundle: R.hostingBundle, name: "BackgroundMenu")
    /// Image `Background`.
    static let background = Rswift.ImageResource(bundle: R.hostingBundle, name: "Background")
    /// Image `noteImage`.
    static let noteImage = Rswift.ImageResource(bundle: R.hostingBundle, name: "noteImage")
    /// Image `paper`.
    static let paper = Rswift.ImageResource(bundle: R.hostingBundle, name: "paper")

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "Background", bundle: ..., traitCollection: ...)`
    static func background(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.background, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "BackgroundMenu", bundle: ..., traitCollection: ...)`
    static func backgroundMenu(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.backgroundMenu, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "noteImage", bundle: ..., traitCollection: ...)`
    static func noteImage(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.noteImage, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "paper", bundle: ..., traitCollection: ...)`
    static func paper(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.paper, compatibleWith: traitCollection)
    }
    #endif

    fileprivate init() {}
  }

  /// This `R.nib` struct is generated, and contains static references to 2 nibs.
  struct nib {
    /// Nib `MenuCell`.
    static let menuCell = _R.nib._MenuCell()
    /// Nib `Slide`.
    static let slide = _R.nib._Slide()

    #if os(iOS) || os(tvOS)
    /// `UINib(name: "MenuCell", in: bundle)`
    @available(*, deprecated, message: "Use UINib(resource: R.nib.menuCell) instead")
    static func menuCell(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.menuCell)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UINib(name: "Slide", in: bundle)`
    @available(*, deprecated, message: "Use UINib(resource: R.nib.slide) instead")
    static func slide(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.slide)
    }
    #endif

    static func menuCell(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> MenuCell? {
      return R.nib.menuCell.instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? MenuCell
    }

    static func slide(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> Slide? {
      return R.nib.slide.instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? Slide
    }

    fileprivate init() {}
  }

  /// This `R.reuseIdentifier` struct is generated, and contains static references to 4 reuse identifiers.
  struct reuseIdentifier {
    /// Reuse identifier `CellFolder`.
    static let cellFolder: Rswift.ReuseIdentifier<UIKit.UITableViewCell> = Rswift.ReuseIdentifier(identifier: "CellFolder")
    /// Reuse identifier `CellNote`.
    static let cellNote: Rswift.ReuseIdentifier<UIKit.UITableViewCell> = Rswift.ReuseIdentifier(identifier: "CellNote")
    /// Reuse identifier `Cell`.
    static let cell: Rswift.ReuseIdentifier<UIKit.UITableViewCell> = Rswift.ReuseIdentifier(identifier: "Cell")
    /// Reuse identifier `MenuCell`.
    static let menuCell: Rswift.ReuseIdentifier<MenuCell> = Rswift.ReuseIdentifier(identifier: "MenuCell")

    fileprivate init() {}
  }

  /// This `R.string` struct is generated, and contains static references to 1 localization tables.
  struct string {
    /// This `R.string.localizable` struct is generated, and contains static references to 6 localization keys.
    struct localizable {
      /// en translation: A menu item is under construction
      ///
      /// Locales: en, ru
      static let menuAlertTitle = Rswift.StringResource(key: "menu.alert.title", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "ru"], comment: nil)
      /// en translation: Currency converter
      ///
      /// Locales: en, ru
      static let menuCurrencyConverter = Rswift.StringResource(key: "menu.CurrencyConverter", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "ru"], comment: nil)
      /// en translation: In developing
      ///
      /// Locales: en, ru
      static let menuInDeveloping = Rswift.StringResource(key: "menu.InDeveloping", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "ru"], comment: nil)
      /// en translation: Location notes
      ///
      /// Locales: en, ru
      static let menuLocationNotes = Rswift.StringResource(key: "menu.LocationNotes", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "ru"], comment: nil)
      /// en translation: Select another item
      ///
      /// Locales: en, ru
      static let menuAlertDescription = Rswift.StringResource(key: "menu.alert.description", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "ru"], comment: nil)
      /// en translation: Select menu item
      ///
      /// Locales: en, ru
      static let menuSelectMenuItem = Rswift.StringResource(key: "menu.SelectMenuItem", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "ru"], comment: nil)

      /// en translation: A menu item is under construction
      ///
      /// Locales: en, ru
      static func menuAlertTitle(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("menu.alert.title", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "menu.alert.title"
        }

        return NSLocalizedString("menu.alert.title", bundle: bundle, comment: "")
      }

      /// en translation: Currency converter
      ///
      /// Locales: en, ru
      static func menuCurrencyConverter(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("menu.CurrencyConverter", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "menu.CurrencyConverter"
        }

        return NSLocalizedString("menu.CurrencyConverter", bundle: bundle, comment: "")
      }

      /// en translation: In developing
      ///
      /// Locales: en, ru
      static func menuInDeveloping(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("menu.InDeveloping", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "menu.InDeveloping"
        }

        return NSLocalizedString("menu.InDeveloping", bundle: bundle, comment: "")
      }

      /// en translation: Location notes
      ///
      /// Locales: en, ru
      static func menuLocationNotes(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("menu.LocationNotes", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "menu.LocationNotes"
        }

        return NSLocalizedString("menu.LocationNotes", bundle: bundle, comment: "")
      }

      /// en translation: Select another item
      ///
      /// Locales: en, ru
      static func menuAlertDescription(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("menu.alert.description", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "menu.alert.description"
        }

        return NSLocalizedString("menu.alert.description", bundle: bundle, comment: "")
      }

      /// en translation: Select menu item
      ///
      /// Locales: en, ru
      static func menuSelectMenuItem(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("menu.SelectMenuItem", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "menu.SelectMenuItem"
        }

        return NSLocalizedString("menu.SelectMenuItem", bundle: bundle, comment: "")
      }

      fileprivate init() {}
    }

    fileprivate init() {}
  }

  fileprivate struct intern: Rswift.Validatable {
    fileprivate static func validate() throws {
      try _R.validate()
    }

    fileprivate init() {}
  }

  fileprivate class Class {}

  fileprivate init() {}
}

struct _R: Rswift.Validatable {
  static func validate() throws {
    #if os(iOS) || os(tvOS)
    try storyboard.validate()
    #endif
  }

  #if os(iOS) || os(tvOS)
  struct nib {
    struct _MenuCell: Rswift.NibResourceType, Rswift.ReuseIdentifierType {
      typealias ReusableType = MenuCell

      let bundle = R.hostingBundle
      let identifier = "MenuCell"
      let name = "MenuCell"

      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> MenuCell? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? MenuCell
      }

      fileprivate init() {}
    }

    struct _Slide: Rswift.NibResourceType {
      let bundle = R.hostingBundle
      let name = "Slide"

      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> Slide? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? Slide
      }

      fileprivate init() {}
    }

    fileprivate init() {}
  }
  #endif

  #if os(iOS) || os(tvOS)
  struct storyboard: Rswift.Validatable {
    static func validate() throws {
      #if os(iOS) || os(tvOS)
      try banner.validate()
      #endif
      #if os(iOS) || os(tvOS)
      try launchScreen.validate()
      #endif
      #if os(iOS) || os(tvOS)
      try main.validate()
      #endif
      #if os(iOS) || os(tvOS)
      try menu.validate()
      #endif
      #if os(iOS) || os(tvOS)
      try note.validate()
      #endif
    }

    #if os(iOS) || os(tvOS)
    struct banner: Rswift.StoryboardResourceType, Rswift.Validatable {
      let bannerVC = StoryboardViewControllerResource<BannerVC>(identifier: "BannerVC")
      let bundle = R.hostingBundle
      let name = "Banner"

      func bannerVC(_: Void = ()) -> BannerVC? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: bannerVC)
      }

      static func validate() throws {
        if UIKit.UIImage(named: "BackgroundMenu", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'BackgroundMenu' is used in storyboard 'Banner', but couldn't be loaded.") }
        if #available(iOS 11.0, tvOS 11.0, *) {
          if UIKit.UIColor(named: "appBlue", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Color named 'appBlue' is used in storyboard 'Banner', but couldn't be loaded.") }
          if UIKit.UIColor(named: "appOrange", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Color named 'appOrange' is used in storyboard 'Banner', but couldn't be loaded.") }
        }
        if _R.storyboard.banner().bannerVC() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'bannerVC' could not be loaded from storyboard 'Banner' as 'BannerVC'.") }
      }

      fileprivate init() {}
    }
    #endif

    #if os(iOS) || os(tvOS)
    struct launchScreen: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = UIKit.UIViewController

      let bundle = R.hostingBundle
      let name = "LaunchScreen"

      static func validate() throws {
        if UIKit.UIImage(named: "BackgroundMenu", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'BackgroundMenu' is used in storyboard 'LaunchScreen', but couldn't be loaded.") }
        if UIKit.UIImage(named: "noteImage", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'noteImage' is used in storyboard 'LaunchScreen', but couldn't be loaded.") }
        if #available(iOS 11.0, tvOS 11.0, *) {
          if UIKit.UIColor(named: "appBlue", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Color named 'appBlue' is used in storyboard 'LaunchScreen', but couldn't be loaded.") }
        }
      }

      fileprivate init() {}
    }
    #endif

    #if os(iOS) || os(tvOS)
    struct main: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = UIKit.UITabBarController

      let bundle = R.hostingBundle
      let name = "Main"
      let tabNavBar = StoryboardViewControllerResource<UIKit.UITabBarController>(identifier: "TabNavBar")

      func tabNavBar(_: Void = ()) -> UIKit.UITabBarController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: tabNavBar)
      }

      static func validate() throws {
        if UIKit.UIImage(named: "folder", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'folder' is used in storyboard 'Main', but couldn't be loaded.") }
        if UIKit.UIImage(named: "pencil", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'pencil' is used in storyboard 'Main', but couldn't be loaded.") }
        if #available(iOS 11.0, tvOS 11.0, *) {
        }
        if _R.storyboard.main().tabNavBar() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'tabNavBar' could not be loaded from storyboard 'Main' as 'UIKit.UITabBarController'.") }
      }

      fileprivate init() {}
    }
    #endif

    #if os(iOS) || os(tvOS)
    struct menu: Rswift.StoryboardResourceType, Rswift.Validatable {
      let bundle = R.hostingBundle
      let menuNavVC = StoryboardViewControllerResource<UIKit.UINavigationController>(identifier: "MenuNavVC")
      let menuVC = StoryboardViewControllerResource<MenuVC>(identifier: "MenuVC")
      let name = "Menu"

      func menuNavVC(_: Void = ()) -> UIKit.UINavigationController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: menuNavVC)
      }

      func menuVC(_: Void = ()) -> MenuVC? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: menuVC)
      }

      static func validate() throws {
        if UIKit.UIImage(named: "BackgroundMenu", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'BackgroundMenu' is used in storyboard 'Menu', but couldn't be loaded.") }
        if #available(iOS 11.0, tvOS 11.0, *) {
          if UIKit.UIColor(named: "appOrange", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Color named 'appOrange' is used in storyboard 'Menu', but couldn't be loaded.") }
        }
        if _R.storyboard.menu().menuNavVC() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'menuNavVC' could not be loaded from storyboard 'Menu' as 'UIKit.UINavigationController'.") }
        if _R.storyboard.menu().menuVC() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'menuVC' could not be loaded from storyboard 'Menu' as 'MenuVC'.") }
      }

      fileprivate init() {}
    }
    #endif

    #if os(iOS) || os(tvOS)
    struct note: Rswift.StoryboardResourceType, Rswift.Validatable {
      let bundle = R.hostingBundle
      let name = "Note"
      let noteVC = StoryboardViewControllerResource<NoteVC>(identifier: "NoteVC")

      func noteVC(_: Void = ()) -> NoteVC? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: noteVC)
      }

      static func validate() throws {
        if UIKit.UIImage(named: "folder", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'folder' is used in storyboard 'Note', but couldn't be loaded.") }
        if #available(iOS 11.0, tvOS 11.0, *) {
        }
        if _R.storyboard.note().noteVC() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'noteVC' could not be loaded from storyboard 'Note' as 'NoteVC'.") }
      }

      fileprivate init() {}
    }
    #endif

    fileprivate init() {}
  }
  #endif

  fileprivate init() {}
}
