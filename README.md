# Celestial

Frontend Flutter completo e offline, baseado nas 12 telas exportadas do Google
Stitch em `design/`, com os fluxos de apoio da lista-mestra do AGENTS.md.

**[Relatório de implementação, cobertura e limitações](docs/stitch-implementation.md)**
· **[Galeria renderizada em Flutter](docs/previews/README.md)**
· **[Inventário das exportações](docs/design-inventory.json)**

## Executar

```sh
flutter pub get
flutter run -d chrome --web-port 5181 --no-web-resources-cdn
```

O aplicativo começa em Splash → Welcome → Intro → autenticação demo/visitante →
Birth Details → Interests → Home. Use dados de exemplo. A autenticação não envia
nem armazena credenciais. Para Android/iOS com dispositivo disponível:

```sh
flutter run
```

Compilar iOS exige macOS/Xcode. Este projeto foi verificado no Windows com
Flutter 3.38.5 / Dart 3.10.4, Android SDK e Chrome.

## Estrutura

```text
lib/
  app/          # GoRouter, temas, idioma/aparência persistidos
  core/         # modelos imutáveis, estado Riverpod, contratos mock, widgets
  features/
    onboarding/ auth/ home/ astrology/ numerology/ love/
    wellness/ journal/ community/ engagement/ premium/ profile/
  l10n/         # ARBs en/es + variantes US e localização oficial gerada
assets/
  fonts/        # Playfair Display, Plus Jakarta Sans, Noto Symbols + licenças OFL
  stitch/       # nove imagens locais referenciadas nos HTMLs + proveniência
design/         # exportações originais preservadas como referência
test/           # integração de widgets, estado, localização, cobertura e auditoria
tool/           # importação de assets, geração de ícones e renderização
docs/           # inventário, relatório e previews reais do Flutter
```

Há cinco abas persistentes: Home, Astrology, Love, Wellness e Profile.
As telas exportadas têm widgets reais, e seus destinos secundários estão
implementados. O relatório lista as 44 telas da lista-mestra e as rotas extras.

## Dados e persistência

Riverpod injeta CatalogRepository, InterpretationRepository, PremiumRepository
e NotificationRepository, com implementações mock substituíveis. Leituras,
cartas, números, eventos e escores são ilustrativos e assim identificados.
Nenhum cálculo astrológico/numerológico complexo é alegado.

Idioma e aparência persistem em SharedPreferences. Dados pessoais da demo,
parceiro, interesses, diário, posts/comentários, favoritos e progresso ficam
em memória durante a sessão e reiniciam quando o processo fecha.
A lista de idiomas do dispositivo é resolvida em ordem (en-* / es-*), com
fallback en_US e prioridade da escolha manual.

Nenhum backend, banco de dados, SDK de IA, compra, integração de calendário ou
autenticação real foi implementado. Sem áudio licenciado exportado, o player
informa indisponibilidade e permanece desabilitado. A respiração é animada
e funcional. Planos mostram preços ilustrativos USD e checkout desabilitado.

## Verificar

```sh
dart format .
flutter analyze
flutter test
flutter build apk --debug
```

Regenerar as renderizações de revisão e ícones próprios (ferramentas opcionais):

```sh
flutter test tool/render_previews_test.dart --update-goldens
flutter test tool/generate_icons_test.dart
```

As fontes e imagens estão incluídas localmente; não é preciso executar o
importador de assets para usar o projeto. As licenças das fontes e as origens
dos arquivos estão preservadas em `assets/`.
