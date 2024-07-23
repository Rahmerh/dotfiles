```
                      :::!~!!!!!:.
                  .xUHWH!! !!?M88WHX:.
                .X*#M@$!!  !X!M$$$$$$WWx:.
               :!!!!!!?H! :!$!$$$$$$$$$$8X:
              !!~  ~:~!! :~!$!#$$$$$$$$$$8X:
             :!~::!H!<   ~.U$X!?R$$$$$$$$MM!
             ~!~!!!!~~ .:XW$$$U!!?$$$$$$RMM!
               !:~~~ .:!M"T#$$$$WX??#MRRMMM!
               ~?WuxiW*`   `"#$$$$8!!!!??!!!
             :X- M$$$$       `"T#$T~!8$WUXU~
            :%`  ~#$$$m:        ~!~ ?$$$$$$
          :!`.-   ~T$$$$8xx.  .xWW- ~""##*"
.....   -~~:<` !    ~?T#$$@@W@*?$$      /`
W$@@M!!! .!~~ !!     .:XUW$W!~ `"~:    :
#"~~`.:x%`!!  !H:   !WM$$$$Ti.: .!WUn+!`
:::~:!!`:X~ .: ?H.!u "$$$B$$$!W:U!T$$M~
.~~   :X@!.-~   ?@WTWo("*$$$W$TH$! `
Wi.~!X$?!-~    : ?$$$B$Wu("**$RM!
$R@i.~~ !     :   ~$$$$$B$$en:``
?MXT@Wx.~    :     ~"##*$$$$M~

```

# Rahmerh's dotfiles

## Installation

My dotfiles I want to have anywhere I want. I like arch so keep that in mind while using this repo.

Recently I moved back to windows for work and general compatibility for video games. I've lazily put my linux files in a linux folder and started a windows folder.

### Windows setup
WIP

### Linux setup

I've included an install script to easily get set up. If you want to live on the edge and directly install execute the following:

```shell
sh -c "$(curl -fsSL https://raw.githubusercontent.com/Rahmerh/dotfiles/main/linux/auto-setup.sh)"
```

Note that the auto setup only needs to be executed once, after setting up the fish shell you can use the `apply.fish` script to apply the dotfiles.

### Warning in advance

I am constantly pushing to this repository, so **no** guarantees any stability!

<sub>And yes, I did rewrite the repo to use fish script. I wanted to get more familiar with it</sub>

## How it works

Everything is fairly simple, the apply script basically executes each script in `install-scripts/` in alphabetical order.

If you want to know exactly what is happening just browse through that folder. I want to have an option to only execute 1 script, but I've not done that yet.

The home folder is the only one that isn't as straightforward as the rest. I wanted this to be username independent so everything located in `home/` will be copied to the current user's home directory.

## Screenshots

**Desktop**
![desktop](assets/desktop.png?raw=true)
<sub>Note that only focussed windows turn opaque</sub>

## Used applications

**For arch:**
- i3 (Window manager)
- polybar (Status bar)
- rofi (Application launcher)
- sddm (Display manager)
- kitty & fish (Terminal)
- qutebrowser (Browser)
- neovim (Text editor)

> These tools are configured with files from this repo.
