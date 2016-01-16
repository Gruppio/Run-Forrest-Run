![alt Echolor](https://raw.github.com/Gruppio/Run-Forrest-Run/assets/RunForrestRun_(Stupid).png "Forrest Gump Running")

# Run Forrest Run
#### Run Shell Commands in Swift

**Forrest Features:** 
- Execute any Shell Command in your Swift Scripts
- Easy to use
- Pipe commands easly
- < 1000 lines of code

## Example:
```Swift
import Run-Forrest-Run

let forrest = Forrest()

// Get Current Directory
let pwd = forrest.run("pwd").stdout

// Piped Commands
let swiftFiles = forrest.run("ls -la | grep swift").stdout
```

## How to Install:
You can install Commander in many ways, with SPM (Swift Package Manager)


## Info:
Inspired by Swiftline
Developed by Michele Gruppioni
