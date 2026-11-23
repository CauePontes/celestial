> Registro histórico do Dia 1. A versão completa atual está em [stitch-implementation.md](stitch-implementation.md).

# Dia 1 — Fundação e identidade visual

## Implementação

Projeto iniciado a partir de um diretório que continha apenas AGENTS.md.
Flutter 3.38.5 / Dart 3.10.4. Plataformas Android, iOS e web geradas pelo Flutter.

Home demonstrativa com saudação pela hora local, data localizada, hero orbital,
signo de exemplo identificado, insight ilustrativo, atalhos funcionais e aviso
de demonstração. Astrology, Love e Wellness apresentam suas composições visuais
com estados skeleton explicitamente identificados como prévia. Profile apresenta
visitante e seleção funcional de idioma. Não são módulos completos das etapas
seguintes.

Tema centralizado preserva as cinco cores obrigatórias e os tokens adicionais.
Fontes de sistema; ilustrações originais em CustomPainter. Riverpod para injeção
e preferência de idioma; GoRouter com cinco branches persistentes; localização
oficial ARB en_US/es_US com fallback en_US e preferência manual salva localmente.

## Verificações

- `flutter pub get`: aprovado após adequar os arquivos base/regionais exigidos
  pelo gerador oficial.
- `dart format .`: executado.
- `flutter analyze`: análise final aprovada, sem problemas. A sugestão de
  sintaxe null-aware nos testes foi corrigida.
- `flutter test`: 5 testes aprovados. Cobrem idiomas do dispositivo, fallback,
  prioridade e persistência manual, retorno ao idioma do dispositivo, cinco abas,
  preservação da rolagem, sheet de notificações e espanhol em tela pequena com
  texto ampliado a 200%.
- `flutter run -d chrome --web-port 5180`: compilou e iniciou a aplicação;
  serviço de debug conectado e execução de main confirmada.
- Inspeção visual pelo controle do computador: interrompida porque a ferramenta
  não conseguiu identificar a URL do Chrome com confiança. Não foi possível
  validar visualmente a janela por essa ferramenta.
- APK Android: primeira tentativa falhou ao baixar dependências Kotlin/AndroidX
  e Flutter por erro de DNS em dl.google.com, repo.maven.apache.org e
  storage.googleapis.com. Segunda tentativa, sem reutilizar o daemon Gradle,
  aprovada: `flutter build apk --debug --no-pub`, com
  `GRADLE_OPTS=-Dorg.gradle.daemon=false` apenas no processo do comando.
  APK gerado em `build/app/outputs/flutter-apk/app-debug.apk` (149.542.420 bytes).
- iOS: não compilado; exige macOS/Xcode.

## Limites e próximo passo

O Dia 1 entrega a base navegável. Onboarding, autenticação demo, relatórios,
comparação, meditação, diário, comunidade, planos e configurações completas
permanecem nas etapas correspondentes. Componentes específicos desses módulos
serão implementados junto com seus fluxos. Sem backend, banco, pagamentos ou IA.

Próximo passo, somente mediante solicitação: Dia 2, onboarding e Home completa.
