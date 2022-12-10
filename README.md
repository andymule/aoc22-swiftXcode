# aoc22-swiftXcode
aoc22-swiftXcode

I tried to make a fast-as-possible setup for swift. I do everything in SwiftUI preview canvas. It recompiles in realtime (< 500ms) without saving or doing anything manually. Overall, very cool. It also comes with some baggage. The worst two things: you can't highlight/copy OUT of the preview pane. Also, if you null deref something, you get a useless crash popup that doesn't actually stop anything from working except you, the human. Here are my workarounds:

I use a custom command `pr()` to print to my preview pane/terminal instead of `print()`, which isn't executed in preview. 

I find where my swiftUI canvas preview is sandboxing my app, in my case it is here:
~/Library/Developer/Xcode/UserData/Previews/Simulator\ Devices/53F099E6-21B0-4FE4-94CF-7BA756439400/data/Containers/Data/Application

brew install watch

Then I run these two commands:

`watch -n 0.1 find . -name "AOC.txt" -exec cat {} +`
This print whatever goes to swiftUI to terminal

`watch -n 0.1 pkill "Problem Reporter"`
This automagically obliterates the crash popups

Note:
command+option+P reloads preview if stopped
