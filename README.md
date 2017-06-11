# VIPERTools for Swift 4

All you need to start using VIPER in your iOS project. 
This Clean Architecture divides an app’s logical structure into distinct layers of responsibility, makes it easier to isolate dependencies, maintain and test your iOS project of any size!

## Integration


## Install xCode File Templates

### Using xCode
Open demo project, choose `CodeTemplates` target and run. 
If there is a `sudo` problem appears, make sure you have `Debug process as` `root` set up under the `Edit Scheme/Run`

### Using terminal
Open terminal and then run ```sudo swift VIPERToolsDemo/CodeTemplates/main.swift```

### Manually
Copy folder `/CodeTemplates/VIPER` from the project's root to `/Applications/Xcode.app/Contents/Developer/Library/Xcode/Templates/File\ Templates/`

Ok. Now you should be able to find new templates in `New File` menu under the section named VIPER (probably, the last one).
It's 2 templates for `UIView` and `UIViewController`-based VIPER modules

## Add ViperModule.swift
Copy file named `ViperModule.swift` from project's root to your project
