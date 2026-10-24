# Filtro de loot para D2 Survivors / D2 Survivors Loot Filter

**[Português](#português) · [English](#english)**

---

## Português

Um filtro de loot no estilo dos filtros de Path of Exile para o jogo **D2 Survivors** (versão para Windows). No menu do ESC aparece uma entrada **FILTER**: você marca builds de itens (53 prontas, para as 7 classes), cria as suas, escolhe uniques à mão, e o filtro decide, para cada item que você pega, se ele fica ou se é vendido.

> **Versão 1.22.0: pré-lançamento.** O filtro em si já roda no jogo do autor, mas este instalador só foi testado numa pasta de jogo simulada: ainda **não** foi usado num jogo de verdade. Use por sua conta e risco e leia "Segurança" abaixo.

### Baixar

Vá em **[Releases](../../releases)** e baixe o arquivo `Filtro-D2Survivors-v1.22.0.zip` (31.8 MB). Na página da Release há o **SHA-256** do arquivo para você conferir o download:

```
certutil -hashfile Filtro-D2Survivors-v1.22.0.zip SHA256
```

### Instalar

1. Instale o **jogo para Windows** (o filtro não funciona no jogo do navegador) e feche o jogo.
2. Descompacte o zip. Pode deixar a pasta **dentro da pasta do jogo** (onde está o `D2 Survivors.exe`) ou em qualquer lugar.
3. Dê dois cliques em **`INSTALAR.bat`** (as mensagens saem em português e em inglês). Ele acha o jogo, guarda uma cópia do arquivo original, aplica o filtro e cria o atalho "D2 Survivors (filtro)". Ele também pergunta se você quer o **modo automático**, que reaplica o filtro sozinho depois das atualizações do jogo (assim você pode abrir o jogo pelo `.exe` normal).
4. No jogo: **ESC → FILTER**.

O `LEIA-ME.txt` (e o `README-EN.txt`, em inglês) dentro do zip explica tudo em detalhe: como usar o painel, como ligar a venda automática, o que fazer quando o jogo atualiza, como desinstalar.

### Como funciona (resumo)

O jogo não tem suporte a filtros. O filtro é aplicado **no código do jogo** (o arquivo `app.asar`), por isso uma atualização do jogo o apaga: o atalho ou o modo automático o reaplicam. O filtro começa em **modo de teste**: ele só anota o que faria em `%APPDATA%\D2 Survivors\filter-data\filter-decisions.jsonl`. A venda automática é uma chave no painel (dois cliques) e usa o mesmo caminho da venda manual do jogo. Nunca vende itens equipados, itens do baú, nada no acampamento, itens de missão, itens que o jogo não deixa vender nem itens que o filtro não consegue ler.

### Segurança

- **Isto modifica o programa do jogo** (só o `app.asar`, e só o necessário). O original é guardado em `%LOCALAPPDATA%\D2-Survivors-Filtro\backups` e o `desinstalar.bat` o devolve. Faça um backup do seu save (janela SAVES do jogo, código `D2S1:`) antes de ligar a venda automática.
- **Não mexe no seu save** e **não usa a internet**. Escreve apenas em `%LOCALAPPDATA%\D2-Survivors-Filtro` e em `%APPDATA%\D2 Survivors\filter-data`. O modo automático cria uma tarefa agendada do Windows (sem janela, só para o seu usuário, sem administrador) que o `desinstalar.bat` remove.
- **Transparência:** os arquivos `.bat`/`.vbs` do instalador estão legíveis na pasta [`fonte/`](fonte/); leia antes de rodar. Dentro do zip, o patcher (`apply-patches.mjs`) e os dois arquivos do filtro (`d2filter.js`, `d2filter-ui.js`) também são texto legível. O zip inclui um `node.exe` (Node.js v24, copiado do computador do autor); se preferir, troque-o por um `node.exe` baixado de https://nodejs.org antes de instalar.
- O Windows pode avisar sobre arquivos `.bat` baixados (SmartScreen) e antivírus podem reclamar de scripts que alteram outro programa. Os scripts não são assinados.
- Se o jogo atualizar de um jeito que o filtro não acompanha, o atalho avisa e **não** altera o jogo.

### Créditos e avisos

- Ferramenta **não oficial** de fã. Não é afiliada aos autores do D2 Survivors nem à Blizzard Entertainment. Sem garantia.
- As listas de itens das 53 builds foram lidas dos guias de **[Maxroll](https://maxroll.gg/d2)** (Diablo II: Resurrected); os valores mínimos usados para itens mágicos e raros são do autor e não foram testados em jogo longo. O jogo é uma versão alfa e muda várias vezes por dia: as builds podem ficar defasadas.
- Este pacote não contém arquivos nem imagens do jogo.

---

## English

A loot filter in the style of Path of Exile filters for the Windows desktop version of **D2 Survivors**. The ESC menu gets a **FILTER** entry: tick item builds (53 included, all 7 classes), make your own, hand-pick uniques, and for every item you pick up the filter decides whether to keep it or sell it.

> **Version 1.22.0: pre-release.** The filter itself runs on the author's game, but this installer has only been tested on a simulated game folder: it has **not** been used on a real game yet. Use at your own risk and read "Safety" below.

### Download

Go to **[Releases](../../releases)** and download `Filtro-D2Survivors-v1.22.0.zip` (31.8 MB). The Release page shows the file's **SHA-256** so you can check your download:

```
certutil -hashfile Filtro-D2Survivors-v1.22.0.zip SHA256
```

### Install

1. Install the **Windows desktop game** (the filter does not work with the browser version) and close it.
2. Unzip. You can leave the folder **inside the game's folder** (next to `D2 Survivors.exe`) or anywhere else.
3. Double-click **`INSTALAR.bat`** (its messages are printed in Portuguese and in English). It finds the game, keeps a copy of the original file, applies the filter and creates the shortcut "D2 Survivors (filtro)". It also asks whether you want the **automatic mode**, which re-applies the filter by itself after game updates (so you can open the game from its normal `.exe`).
4. In the game: **ESC → FILTER**.

`README-EN.txt` (and `LEIA-ME.txt`, in Portuguese) inside the zip explains everything: how to use the panel, how to turn auto-sell on, what to do when the game updates, how to uninstall. The panel inside the game is in English.

### How it works (short)

The game has no filter support. The filter is applied **to the game's code** (the `app.asar` file), so a game update removes it: the shortcut or the automatic mode re-applies it. The filter starts in **test mode**: it only logs what it would do, in `%APPDATA%\D2 Survivors\filter-data\filter-decisions.jsonl`. Auto-sell is a switch in the panel (two clicks) and uses the same path as the game's manual sale. It never sells equipped items, stash items, anything in the camp, quest items, items the game refuses to sell, or items it cannot read.

### Safety

- **This modifies the game's program** (only `app.asar`, and only what is needed). The original is kept in `%LOCALAPPDATA%\D2-Survivors-Filtro\backups` and `desinstalar.bat` (the uninstaller) gives it back. Back up your save (the game's SAVES window, `D2S1:` code) before turning auto-sell on.
- It **does not touch your save** and **does not use the internet**. It writes only to `%LOCALAPPDATA%\D2-Survivors-Filtro` and `%APPDATA%\D2 Survivors\filter-data`. The automatic mode creates a Windows scheduled task (no window, your user only, no administrator) that the uninstaller removes.
- **Transparency:** the installer's `.bat`/`.vbs` files are readable in the [`fonte/`](fonte/) folder (read them before running). Inside the zip, the patcher (`apply-patches.mjs`) and the two filter files (`d2filter.js`, `d2filter-ui.js`) are readable text too. The zip includes a `node.exe` (Node.js v24, copied from the author's computer); if you prefer, replace it with a `node.exe` downloaded from https://nodejs.org before installing.
- Windows may warn about downloaded `.bat` files (SmartScreen) and antivirus tools may complain about scripts that change another program. The scripts are not signed.
- If the game updates in a way the filter does not follow, the shortcut says so and does **not** change the game.

### Credits and notes

- **Unofficial** fan tool. Not affiliated with the authors of D2 Survivors or with Blizzard Entertainment. No warranty.
- The item lists of the 53 builds were read from **[Maxroll](https://maxroll.gg/d2)**'s Diablo II: Resurrected guides; the minimum values used for magic and rare items are the author's and have not been tested over long play. The game is an alpha and changes several times a day: the builds may become outdated.
- This package contains no files or pictures from the game.

---

## Licença / License

Apache License 2.0, veja / see `LICENSE` and `NOTICE`. Copyright 2026 OrgunBr.
