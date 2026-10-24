LOOT FILTER FOR D2 SURVIVORS  (version 1.22.0)
Made by OrgunBr. Unofficial fan tool. No warranty: use at your own risk.
(A Portuguese version of this file is LEIA-ME.txt.)

WHAT IT IS
A loot filter in the style of Path of Exile filters. Inside the game, the ESC menu gets a FILTER entry.
There you tick item builds (53 included, for all classes), make your own, hand-pick uniques, and the filter
decides, for every item you pick up, whether it stays or is sold.
It does NOT change the game in any other way (no rerolls, magnet, stat points, etc.).

WHAT YOU NEED
- The game installed on the computer (the Windows version). It does NOT work with the browser version.
- Nothing else: the package brings everything. You do not need to install Node or have internet.

HOW TO INSTALL
1. Close the game completely.
2. Unzip this package. You can leave the folder inside the game's folder (where "D2 Survivors.exe" is) or anywhere else.
3. Double-click INSTALAR.bat. It finds the game by itself (if it cannot, it asks for the folder), keeps a copy of the game's
   original file, applies the filter and puts a shortcut "D2 Survivors (filtro)" on the desktop.
4. After installing you can delete the package folder. The filter lives in %LOCALAPPDATA%\D2-Survivors-Filtro
   (outside the game's folder, because a game update may delete the game's folder).

HOW TO PLAY
The filter lives INSIDE the game's file. So after the install the game opens with the filter whichever way you start it
(the normal .exe, the start menu, the "D2 Survivors (filtro)" shortcut). The problem is UPDATES: the game is an alpha and updates
itself several times a day, and each update replaces the game's file and removes the filter, without saying anything.
There are two ways to deal with that:

A) AUTOMATIC MODE (INSTALAR.bat asks: "Turn on automatic mode?"; answer S or Y for yes). It creates a hidden Windows scheduled task
   that every 2 minutes checks whether the game was updated and, if the game is CLOSED, re-applies the filter. With it you open the
   game as usual, from the normal .exe. After an update the filter comes back by itself as soon as the game is closed (up to 2 min).
   Limit: if the update happens while the game is open (the "Restart to update" button), that session runs without the filter;
   close the game, wait 2 minutes and open it again. What the watcher did is logged in %LOCALAPPDATA%\D2-Survivors-Filtro\vigia.log.
B) THE "D2 Survivors (filtro)" SHORTCUT (always created). Open the game from it. A black window stays open (minimized) while you
   play: it re-applies the filter when the game updates. When the game shows "Restart to update", press it and wait: the window
   opens the game again, with the filter.
You can use both together. With neither, the filter lasts only until the next game update (then just run INSTALAR.bat again).

HOW TO USE THE FILTER (the panel is in English)
In the game: ESC, then FILTER.
- Class tabs: tick the builds you want to farm. Ticking means KEEP. Items that no ticked build wants are treated as "to sell".
  The hero you play does not matter.
- Copy: makes an editable copy of a build in the My builds tab. My builds: make your own (ONE character's gear:
  1 helm, 1 body armour, 1 gloves, 1 belt, 1 boots, 2 amulets, 4 rings, 2 weapons and 2 shields; each slot only accepts its own kind of item).
- Uniques by hand: pick specific uniques by name (or by base: "shako" finds Harlequin Crest).
- GOLD FARM (sell all that drops): marks EVERYTHING to sell (equipped items, stash items and camp items are never sold).
  With nothing ticked, GOLD FARM turns on by itself.
- Clear filters: unticks everything (it never deletes your own builds).
- The badge at the top shows TEST (only logs, sells nothing) or LIVE (sells for real).

THE FILTER STARTS IN TEST MODE
In TEST mode it only writes what it would do, in %APPDATA%\D2 Survivors\filter-data\filter-decisions.jsonl (one item per line, with
the reason). Play a run like that, open that file with Notepad and check that the decisions make sense BEFORE turning selling on.

TO TURN AUTO-SELL ON
1. Back up your save: in the game's SAVES window, export the save code (D2S1:...) and keep it.
2. In the panel, tick "Auto-sell for real" and click again to confirm. The badge changes to LIVE.
3. Every item the filter judges "sell" is sold the moment you pick it up, through the same path as the game's manual sale
   (you get the gold and the item shows in Buy Back at the vendor, at 4x the price, until the hero's next run).
4. Never sold: equipped items, stash items, anything in the camp, quest items, items the game refuses to sell,
   items the filter cannot read.
To go back to testing, untick "Auto-sell for real".

IF THE GAME UPDATES AND THE FILTER STOPS
The game is an alpha and updates several times a day. If an update changes the game's code, the shortcut says it could not apply
the filter and does NOT open the game from it (the game is not changed). Open the game from its own shortcut and tell OrgunBr.

HOW TO UNINSTALL
Close the game and double-click desinstalar.bat (it is in %LOCALAPPDATA%\D2-Survivors-Filtro). It gives back the game's original file
and removes the shortcut and the automatic-mode task. Your selection and the decision log stay in %APPDATA%\D2 Survivors\filter-data (delete them if you want).

WHAT THE FILTER NEVER DOES
It does not touch your save. The filter does not send anything to the internet. It only reads and writes in the folders named above.
