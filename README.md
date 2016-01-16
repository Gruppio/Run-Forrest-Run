![alt Echolor](https://raw.github.com/Gruppio/Run-Forrest-Run/assets/RunForrestRun_(Stupid).png "Forrest Gump Running")

[![Analytics](https://ga-beacon.appspot.com/UA-39980089-6/Gruppio/Run-Forrest-Run)](https://github.com/igrigorik/ga-beacon)

# Run Forrest Run
#### Run Shell Commands in Swift

**Forrest Features:** 
- Execute any Shell Command in your Swift Scripts
- Super Easy to use
- Pipe commands easly
- < 1000 lines of code

## Example:
```Swift
import Forrest

let forrest = Forrest()

// Get Current Directory
let pwd = forrest.run("pwd").stdout

// Piped Commands
let swiftFiles = forrest.run("ls -la | grep swift").stdout
```

## Included Examples:
The First example is a program that it will list the Swift files in your launch directory.
For run this program:
```Shell
git clone https://github.com/Gruppio/Run-Forrest-Run.git
cd Run-Forrest-Run/Examples/ListSwiftFiles
swift build
.build/debug/ListSwiftFiles
```

## How to Install:
You can install Commander with SPM (Swift Package Manager)


## Info:
- Inspired by Swiftline
- Developed by Michele Gruppioni
