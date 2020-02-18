# xcode_build_scripts
Xcode custom scripts for Build Phases

## Automating Version and Build Numbers Using agvtool
https://developer.apple.com/library/archive/qa/qa1827/_index.html

### Updating the Version Number
```
$ xcrun agvtool new-marketing-version <your_specific_version>
```

### Updating the Build Number
```
$ xcrun agvtool next-version -all
$ xcrun agvtool new-version -all <your_specific_version>
```

### Viewing Version Numbers
```
$ xcrun agvtool what-marketing-version
$ xcrun agvtool what-version
```

### Commit in git
```
$ VERS=$(agvtool vers)
$ NUMBER=$(echo $VERS | tr -dc '0-9')
$ git commit -m "bump build no. $NUMBER"
```
