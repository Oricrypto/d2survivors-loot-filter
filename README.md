# Filtro de loot para D2 Survivors (D2 Survivors Loot Filter)

Um filtro de loot no estilo dos filtros de Path of Exile para o jogo **D2 Survivors** (versão para Windows). No menu do ESC aparece uma entrada **FILTER**: você marca builds de itens (53 prontas, para as 7 classes), cria as suas, escolhe uniques à mão, e o filtro decide, para cada item que você pega, se ele fica ou se é vendido.

*English: a loot filter for the Windows desktop version of the game D2 Survivors. Pick item builds (53 included, all 7 classes), make your own, hand-pick uniques; the filter keeps or sells each item you pick up. Starts in test mode (it only logs what it would do). Instructions below are in Portuguese; the installer and the in-game panel text are Portuguese and English respectively. Unofficial fan tool.*

> **Versão 1.22.0: pré-lançamento.** Foi testada numa pasta de jogo simulada e no jogo do autor, mas ainda **não** foi usada por outras pessoas num jogo de verdade. Use por sua conta e risco e leia "Segurança" abaixo.

## Baixar

Vá em **[Releases](../../releases)** e baixe o arquivo `Filtro-D2Survivors-v1.22.0.zip` (31.8 MB). Na página da Release há o **SHA-256** do arquivo para você conferir o download:

```
certutil -hashfile Filtro-D2Survivors-v1.22.0.zip SHA256
```

## Instalar

1. Instale o **jogo para Windows** (o filtro não funciona no jogo do navegador) e feche o jogo.
2. Descompacte o zip. Pode deixar a pasta **dentro da pasta do jogo** (onde está o `D2 Survivors.exe`) ou em qualquer lugar.
3. Dê dois cliques em **`INSTALAR.bat`**. Ele acha o jogo, guarda uma cópia do arquivo original, aplica o filtro e cria o atalho "D2 Survivors (filtro)". Ele também pergunta se você quer o **modo automático**, que reaplica o filtro sozinho depois das atualizações do jogo (assim você pode abrir o jogo pelo `.exe` normal).
4. No jogo: **ESC → FILTER**.

O `LEIA-ME.txt` dentro do zip explica tudo em detalhe (como usar o painel, como ligar a venda automática, o que fazer quando o jogo atualiza, como desinstalar).

## Como funciona (resumo)

O jogo não tem suporte a filtros. O filtro é aplicado **no código do jogo** (o arquivo `app.asar`), por isso uma atualização do jogo o apaga: o atalho ou o modo automático o reaplicam. O filtro começa em **modo de teste**: ele só anota o que faria em `%APPDATA%\D2 Survivors\filter-data\filter-decisions.jsonl`. A venda automática é uma chave no painel (dois cliques) e usa o mesmo caminho da venda manual do jogo. Nunca vende itens equipados, itens do baú, nada no acampamento, itens de missão, itens que o jogo não deixa vender nem itens que o filtro não consegue ler.

## Segurança

- **Isto modifica o programa do jogo** (só o `app.asar`, e só o necessário). O original é guardado em `%LOCALAPPDATA%\D2-Survivors-Filtro\backups` e o `desinstalar.bat` o devolve. Faça um backup do seu save (janela SAVES do jogo, código `D2S1:`) antes de ligar a venda automática.
- **Não mexe no seu save** e **não usa a internet**. Escreve apenas em `%LOCALAPPDATA%\D2-Survivors-Filtro` e em `%APPDATA%\D2 Survivors\filter-data`. O modo automático cria uma tarefa agendada do Windows (sem janela, só para o seu usuário, sem administrador) que o `desinstalar.bat` remove.
- **Transparência:** os arquivos `.bat`/`.vbs` do instalador estão legíveis na pasta [`fonte/`](fonte/); leia antes de rodar. Dentro do zip, o patcher (`apply-patches.mjs`) e os dois arquivos do filtro (`d2filter.js`, `d2filter-ui.js`) também são texto legível. O zip inclui um `node.exe` (Node.js v24, copiado do computador do autor); se preferir, troque-o por um `node.exe` baixado de https://nodejs.org antes de instalar.
- O Windows pode avisar sobre arquivos `.bat` baixados (SmartScreen) e antivírus podem reclamar de scripts que alteram outro programa. Os scripts não são assinados.
- Se o jogo atualizar de um jeito que o filtro não acompanha, o atalho avisa e **não** altera o jogo.

## Créditos e avisos

- Ferramenta **não oficial** de fã. Não é afiliada aos autores do D2 Survivors nem à Blizzard Entertainment. Sem garantia.
- As listas de itens das 53 builds foram lidas dos guias de **[Maxroll](https://maxroll.gg/d2)** (Diablo II: Resurrected); os valores mínimos usados para itens mágicos e raros são do autor e não foram testados em jogo longo. O jogo é uma versão alfa e muda várias vezes por dia: as builds podem ficar defasadas.
- Este pacote não contém arquivos nem imagens do jogo.

## Licença

Apache License 2.0, veja `LICENSE` e `NOTICE`. Copyright 2026 OrgunBr.
