# AGENTS.md — Celestial: Flutter Frontend (instruções para Codex)

> **Como usar:** coloque este arquivo na raiz do repositório Flutter. Codex deve ler e respeitar este documento antes de criar ou alterar código. Esta especificação define **somente o frontend** de um aplicativo de astrologia, autoconhecimento e bem-estar para o mercado dos Estados Unidos. **Não** implementar backend, banco, pagamentos reais nem IA agora.
>
> **Nome provisório de trabalho:** Celestial. É um placeholder técnico/visual, não uma decisão de marca. Toda identidade deve ser original, sem reproduzir logotipo, ilustrações, textos ou telas do Auraly ou de terceiros.

## 0. Missão e resultado esperado

Implementar em Flutter um aplicativo iOS/Android com aparência **premium, mística, moderna, acolhedora, editorial e original**. Criar o frontend completo, navegável e consistente, com interações de demonstração plausíveis, conteúdo ilustrativo em inglês americano e espanhol, tradução automática conforme idioma do dispositivo e opção de trocar manualmente o idioma.

Ao fim do trabalho o projeto deve compilar, permitir percorrer os fluxos principais e mostrar todas as telas previstas mesmo sem serviços conectados. Componentes devem estar prontos para receber dados remotos futuramente, por contratos/repositórios substituíveis, **sem** iniciar a implementação do backend.

### RESTRIÇÕES ABSOLUTAS DESTA ETAPA
- **Somente Flutter/Dart/frontend.** Não configurar Supabase, PostgreSQL, Firebase, Next.js, servidores, endpoints, credenciais, SDKs de IA, redes reais ou compras in-app.
- Não criar Chat com IA, conversa por voz, leitura de alma gêmea ou retrato de alma gêmea com IA. Não exibir botões, menus, banners ou paywalls que anunciem esses quatro recursos.
- Não usar conteúdo copiado de Auraly. Sem imagens proprietárias, personagens copiados, logos de terceiros ou screenshots clonados.
- Não usar API para gerar horóscopos ou relatórios. O conteúdo inicial será ilustrativo e salvo localmente como mock, rotulado como demonstração quando puder ser confundido com um cálculo real.
- **Não alegar** que cálculos astrológicos complexos, compatibilidade ou numerologia mock são resultados reais. O desenho visual é o objetivo agora.
- Botões importantes devem navegar ou produzir uma ação demonstrativa coerente; não deixar elementos falsamente clicáveis ou sem resposta.
- Em vez de pedir confirmação para decisões menores, seguir os padrões especificados aqui, documentar decisões e implementar por etapas.
- Não declarar um módulo como concluído sem executar verificações disponíveis.

## 1. Escopo do produto (somente UI)

### Módulos incluídos
1. Entrada e onboarding: boas-vindas, slides introdutórios, entrada de nome, data, horário e cidade de nascimento, interesses, conclusão.
2. Autenticação demonstrativa: login, cadastro, recuperar senha — **sem autenticação real**, com modo visitante/demo explícito.
3. Home personalizada: saudação, signo, resumo do dia, atalhos, descobertas, calendário e destaques.
4. Horóscopo: visão diária/semanal/mensal; categorias amor, carreira, bem-estar; navegação de datas; favoritos.
5. Mapa astral: gráfico zodiacal circular **ilustrativo**, lista de planetas/casas/aspectos, detalhes e interpretações mock.
6. Numerologia: tela principal, caminho de vida, números, ciclos e relatório ilustrativo.
7. Amor e compatibilidade: dados de uma segunda pessoa, comparação, resultados e relatório **demonstrativo**, sem soulmate.
8. Bem-estar: biblioteca de meditação, filtros, detalhes, player visual e exercício de respiração com animação funcional; diário pessoal/humor.
9. Comunidade: feed demonstrativo, post, comentários, criação de publicação em estado local, denunciar/bloquear no modo demo.
10. Premium: comparação de planos em USD, benefícios, créditos e histórico simulados; **sem checkout real**.
11. Engajamento: notificações, calendário de eventos astrológicos ilustrativos e conquistas.
12. Perfil e configurações: perfil, preferências, idioma, tema, configurações de notificações, privacidade e suporte com textos demonstrativos.

### Excluídos definitivamente deste escopo
- Chat com IA.
- Conversa por voz.
- Leitura de alma gêmea.
- Retrato de alma gêmea com IA.

### Preparação discreta para IA futura (sem instalar nem conectar nada)
Definir contrato abstrato para **fonte de interpretações**: `InterpretationRepository` ou equivalente, com implementação `MockInterpretationRepository`. A UI deve depender desse contrato, nunca de um SDK ou fornecedor. Uma implementação remota futura poderá gerar textos de horóscopo/mapa/numerologia/compatibilidade, mas **nenhuma lógica de IA é implementada agora**. Não criar módulos de chat.

## 2. Público, idioma, formatos

- Público prioritário: **Estados Unidos**; copy principal em **English (United States)**, tom natural, calmo e contemporâneo.
- Idiomas da primeira versão: `en_US` e `es_US`; fallback para `en_US` caso o idioma do dispositivo não esteja disponível.
- Usar `flutter_localizations` + `intl` + arquivos ARB, `gen_l10n` ou solução Flutter oficial equivalente. **Não** hardcode strings visíveis dentro dos widgets.
- Detectar a lista de idiomas preferenciais do dispositivo, não apenas o país ou geolocalização. `en-*` resolve para inglês, `es-*` resolve para espanhol, outros para inglês. O idioma escolhido manualmente tem prioridade; permitir opção **Use device language**.
- Persistir a escolha manual de idioma localmente (por exemplo `shared_preferences`). Localização é uma preferência de frontend, não requer banco.
- Formatação: USD (`$9.99`), datas conforme locale (`MM/dd/yyyy` em en_US), 12-hour time nos EUA onde cabível; respeitar fuso horário do dispositivo. Nomes de signos e meses devem ser localizados.
- Textos de relatório/meditação/comunidade mock devem possuir variantes nos dois idiomas, não somente rótulos de botão.
- Garantir layout para texto espanhol maior e Dynamic Type / text scaling.

## 3. Design system — IDENTIDADE VISUAL OBRIGATÓRIA

### 3.1 Direção criativa
Um universo visual com céu noturno elegante, profundidade sutil e espiritualidade sem clichê visual infantil. Visual **editorial premium**, com superfícies translúcidas discretas, formas orbitais finas e iluminação lavanda. Evitar excesso de estrelas, glitter, emojis, contornos brilhantes e gradientes em tudo. A leitura e a hierarquia do conteúdo são mais importantes do que os efeitos.

Palavras-chave: `cosmic minimalism`, `premium wellness`, `dark celestial`, `soft lavender glow`, `modern editorial`, `quiet luxury`.

### 3.2 Paleta exata (cores acordadas)

| Token | HEX | Uso |
|---|---|---|
| `background` | **#141126** | Fundo principal do aplicativo |
| `primary` | **#5532A8** | CTA, seleção, destaques |
| `lavender` | **#A991F0** | Ícones, foco, detalhes, gráficos |
| `gold` | **#DABD89** | Destaques astrológicos e assinatura, sem excesso |
| `textPrimary` | **#F7F4FF** | Texto principal no tema escuro |

Tokens complementares propostos para completar o sistema, sem substituir as cinco cores acima:

| Token | HEX | Uso |
|---|---|---|
| `backgroundDeep` | `#0D0A19` | Região superior / fundos profundos |
| `surface` | `#211B38` | Cards e containers |
| `surfaceElevated` | `#2C2348` | Cards elevados e modal |
| `textSecondary` | `#B8B0CC` | Descrições e metadados |
| `muted` | `#827995` | Informação terciária |
| `border` | `#403653` | Separadores discretos |
| `success` | `#79C8AD` | Confirmações |
| `danger` | `#E98C9C` | Erros e ações destrutivas |

### 3.3 Gradientes e iluminação
- Fundo principal sólido `#141126`; adicionar **poucos** brilhos radiais lavanda, com baixa opacidade (aprox. 8–16%) em telas hero.
- Para hero cards: gradiente `#33245E` → `#211B38` com detalhe `#5532A8` e fino contorno lavanda translúcido.
- Cards comuns: superfícies sólidas. Gradientes **não** devem aparecer em todos os cards.
- Dourado é um **acento**, não cor de botão principal nem fundo dominante.
- Usar elementos orbitais desenhados com `CustomPainter`/SVG próprio, sem dependência de imagens geradas ou direitos de terceiros.

### 3.4 Tipografia
- Headings: estética editorial suave. Preferir `Cormorant Garamond` **se** uma licença aberta e o pacote de fonte estiver disponível por dependência normal; caso contrário, usar serif padrão do sistema. Nunca distribuir fonte sem licença.
- Corpo, botões, rótulos: `Inter`/`Manrope` se disponível com licença adequada; fallback para tipografia padrão do sistema.
- Tamanhos de referência: display 34–40, H1 28–32, H2 22–24, H3 18–20, corpo 15–16, legenda 12–13; entrelinha confortável (1.3–1.5 para corpo).
- Nunca usar serif em textos longos de relatório ou botões. Alinhar textos longos à esquerda, largura confortável.

### 3.5 Componentes e espaçamentos
- Grid base de 4px. Padding horizontal da tela: 20–24px; espaçamento entre seções: 24–32px.
- Cards: raio 20–24px, padding interno 16–20px, borda de 1px suave; cards secundários podem usar raio 16px.
- Botões principais: altura 52–56px, raio 16px, fundo `#5532A8`, texto claro e estado de pressionado/disabled/loading.
- Inputs: altura ~56px, labels explícitas, contraste forte, erro abaixo do campo; datas usando date picker acessível.
- Chips: raio pill, selecionado em lavanda/roxo com contraste adequado.
- Ícones: linha consistente (Material Symbols/Lucide equivalente no Flutter), strokes discretos; não misturar estilos conflitantes.
- Navegação inferior: barra arredondada ou superfície elevada escura, seleção lavanda, labels legíveis; considerar safe areas iPhone/Android.
- Animações: 180–350ms para transições, easing suave; respiração 3–5 segundos por fase; respeitar `disableAnimations` quando possível.
- Acessibilidade: área de toque >=44x44, contraste AA sempre que possível, suporte a leitores de tela e escalonamento de texto.

### 3.6 Componentes reutilizáveis esperados
`CelestialScaffold`, `CosmicBackground`, `SectionHeader`, `AstrologyHeroCard`, `PrimaryButton`, `SecondaryButton`, `FeatureTile`, `ZodiacBadge`, `PlanetChip`, `InsightCard`, `EmptyState`, `LoadingSkeleton`, `DemoNotice`, `PremiumBadge`, `AppTextField`, `AppBottomNav`, `DateSelector`, `MoodSelector`, `MeditationCard`, `CommunityPostCard`, `PlanCard`.

## 4. Navegação e arquitetura de informação

### Barra inferior — exatamente cinco abas
1. **Home** (ícone house)
2. **Astrology** (ícone orbit/stars)
3. **Love** (ícone heart)
4. **Wellness** (ícone flower/lotus)
5. **Profile** (ícone user-circle)

Acessos secundários:
- **Numerology** via Astrology e Home.
- **Community** via Home e Wellness/Discover (entrada visível, não uma sexta aba).
- **Notifications** via botão de sino no topo da Home.
- **Premium** via destaque na Home e no Profile.
- **Journal** via Wellness e Home.
- **Calendar** via Home e Astrology.

Fluxo de primeira utilização:
`Splash → Welcome → Intro → Demo Sign In/Sign Up → Onboarding (Name → Birth Info → Interests) → Home`.
Permitir pular a autenticação real no modo demo; dados de onboarding local e editáveis. Persistência local simples é permitida; não armazenar informações sensíveis fictícias como se fossem conta real.

## 5. Catálogo completo de telas — entregar todas, mesmo que algumas sejam demo

### A. Entrada e onboarding (7)
1. `SplashScreen`: marca textual provisória, detalhe orbital, transição suave.
2. `WelcomeScreen`: hero cósmico, slogan inglês, CTA “Explore your universe”.
3. `IntroScreen`: carrossel 3 cards curtos com astrologia, autoconhecimento, bem-estar.
4. `SignInScreen`: interface login demo; aviso visível de que não há autenticação real.
5. `SignUpScreen`: interface cadastro demo; não prometer conta criada no servidor.
6. `BirthDetailsScreen`: nome, data, horário opcional, cidade; indicar quando horário não é conhecido.
7. `InterestsScreen`: interesses, conclusão e entrada na Home.

### B. Home e descoberta (4)
8. `HomeScreen`: saudação, signo, hero “Your cosmic outlook”, insight do dia, cards para funções, mini calendário, premium discreto.
9. `DiscoverScreen`: catálogo pesquisável de funcionalidades, categorias e favoritos.
10. `CosmicCalendarScreen`: calendário mensal e eventos ilustrativos rotulados `Preview`.
11. `NotificationsScreen`: listas de avisos mock, lidos/não lidos.

### C. Astrologia (7)
12. `AstrologyHubScreen`: visões de horóscopo, natal chart e numerologia.
13. `HoroscopeScreen`: tabs Today / Week / Month, categorias love/career/wellness, textos mock por signo.
14. `ZodiacSignsScreen`: explorar os 12 signos e seus elementos.
15. `BirthChartScreen`: roda circular criada com CustomPainter, setores zodiacais, posições **illustrative/demo**; sem fingir cálculos verdadeiros.
16. `ChartDetailsScreen`: lista de Sol, Lua, Ascendente, planetas, casas e aspectos; placeholders identificados.
17. `AstrologicalInsightScreen`: interpretação demonstrativa com seções e save/favorite local.
18. `PlanetDetailScreen`: significado geral de planeta/casa/aspecto, em conteúdo editorial localizado.

### D. Numerologia (3)
19. `NumerologyHubScreen`: números principais e introdução.
20. `LifePathScreen`: entrada de data e exibição `Preview` do caminho de vida; não alegar fórmula pronta sem implementá-la.
21. `NumerologyReportScreen`: relatório de demonstração por tópicos.

### E. Amor e compatibilidade (4)
22. `LoveHubScreen`: introdução e CTA comparação.
23. `PartnerDetailsScreen`: nome opcional, data e horário de nascimento (opcional); inputs locais.
24. `CompatibilityResultScreen`: visual de dois perfis, afinidades e diferenças; score **apenas demo** ou omitir score para não sugerir precisão inexistente.
25. `CompatibilityReportScreen`: áreas Communication, Emotional connection, Shared values; trechos previamente preparados.

### F. Bem-estar e diário (7)
26. `WellnessHubScreen`: meditação, respiração, diário e progresso visual.
27. `MeditationLibraryScreen`: filtro por Sleep, Calm, Focus, duração, lista de cards.
28. `MeditationDetailsScreen`: descrição, duração e objetivos; botão só habilitar playback quando houver áudio local licenciado.
29. `MeditationPlayerScreen`: interface do player. Se não houver mídia, exibir “Audio preview unavailable” e permitir voltar; nunca simular áudio tocando.
30. `BreathingExerciseScreen`: círculo animado real com fases Inhale / Hold / Exhale, botão iniciar/pausar/reiniciar, contagem local.
31. `JournalScreen`: lista de entradas locais e seleção de humor.
32. `JournalEditorScreen`: criar/editar/excluir entrada demonstrativa em estado local; nenhuma análise de IA.

### G. Comunidade (4)
33. `CommunityFeedScreen`: lista de posts de exemplo claramente rotulada “Community preview”; categorias e filtro.
34. `CommunityPostScreen`: conteúdo, comentários mock e interação demonstrativa.
35. `CreatePostScreen`: formulário local, publicação aparece no feed na sessão; indicar “Visible only in this demo”.
36. `ReportPostScreen`: motivos de denúncia, confirmação demo sem envio real.

### H. Premium e perfil (8)
37. `PremiumScreen`: planos Free / Premium / Premium Plus em USD, preços **illustrative**, benefícios reais do escopo sem recursos excluídos.
38. `CreditsScreen`: tela de saldo fictício e histórico demonstrativo, sem comprar créditos.
39. `ProfileScreen`: dados de nascimento locais, favoritos, progresso, acesso às preferências.
40. `EditProfileScreen`: edição local com validação.
41. `SettingsScreen`: idioma, tema visual, notificações simuladas e links para privacidade.
42. `LanguageSettingsScreen`: Use device language / English / Español; troca instantânea persistida.
43. `PrivacyHelpScreen`: textos provisórios, deixar claro que termos/políticas finais serão fornecidos antes da publicação.
44. `AchievementsScreen`: conquistas locais e progresso visual demonstrativo.

> Observação: telas listadas são a **lista-mestra**. O fluxo e o acabamento da Home e das cinco abas têm prioridade sobre estados secundários, mas nenhuma tela deve faltar ao final. Se houver impossibilidade técnica, entregar a melhor implementação parcial, listar claramente pendências e não fingir conclusão.

## 6. Direção visual por tela-chave

### Welcome
- Fundo `backgroundDeep` + grande arco orbital delicado em lavanda no canto superior.
- Marca textual temporária; título editorial ocupando 2–3 linhas e subtexto curto.
- CTA roxo com bastante espaço negativo. Não usar modelo humano nem personificação de IA.

### Home
- Cabeçalho `Good morning, {firstName}` (adaptar pela hora local) e sino de notificações.
- Card hero em gradiente escuro/roxo: “Your cosmic outlook”, dia e signo, pequena ilustração zodiacal vetorial.
- Bloco “Today’s insight” com texto de demonstração, carimbo `Preview`.
- Grade de atalhos 2x2: Horoscope / Birth Chart / Compatibility / Meditate.
- Seção “Explore more”: Numerology / Journal / Community.
- Banner Premium de baixo contraste e sem aparência de anúncio agressivo.

### Astrology hub e Birth Chart
- Fundo noturno; roda zodiacal vetorial com linhas finas, legível em telas pequenas.
- Usar dourado para pequenos detalhes/posições e lavanda para seleção.
- Lista de elementos em cards e explicações legíveis; mostrar aviso `Illustrative chart — calculations will be connected later`.

### Love
- Visuais de dois círculos orbitais sobrepostos; **não** usar chama, silhueta de alma gêmea, retrato ou qualquer recurso excluído.
- Formulário elegante, cards de interpretação, botão `Compare` funcional em modo demo.

### Wellness
- Estética mais calma, menos partículas. Cards grandes com ícones simples.
- Exercício de respiração deve realmente animar e permitir pausa.
- Meditações em lista e filtros funcionais, sem playback falso.

### Premium
- Prêmios/benefícios separados por plano em tabela/cards; preços ilustrativos em USD.
- Botão `Coming soon` desabilitado com explicação da ausência de pagamentos reais; não mostrar sucesso de compra.

## 7. Dados demonstrativos e contratos futuros

### Arquitetura de dados frontend
- Modelos imutáveis, tipos e interfaces `abstract` no domínio/aplicação por feature.
- Repositórios `Mock...Repository` injetados via Riverpod.
- Nunca acoplar os widgets a mapas/dicionários brutos espalhados pelo código.
- Para conteúdo mock, criar fixtures estruturadas por idioma. Previsões devem ser tratadas como textos ilustrativos.
- `DemoSession` para estado de login/visitante; `UserProfile` com birth info local e `preferredLocale`.
- `FeatureAvailability` pode deixar claro quais fluxos são demo, sem expor integrações futuras ao usuário.
- Um `InterpretationRepository` com métodos de leitura futuros (`getHoroscope`, `getBirthChartInterpretation`, `getNumerologyInterpretation`, `getCompatibilityInterpretation`), todos atualmente resolvidos por `MockInterpretationRepository`. Não conectar IA.
- Persistir somente preferências úteis localmente. Para a demo, conteúdo do diário pode viver em memória ou em armazenamento local simples; documentar a escolha.

### Conteúdos mock mínimos
- 12 signos, cada um com nome, intervalo e elemento, traduzidos.
- Horóscopo demonstrativo com categorias love/career/wellness e versões diárias/semanal/mensal para alguns perfis.
- 6 meditações de exemplo (sem depender de download externo).
- 8 posts fictícios na comunidade com nomes genéricos e claramente identificados como dados de demonstração.
- 3 notificações, 6 conquistas, 3 planos e exemplo de créditos.
- Nenhum depoimento falso apresentado como real; personagens/usuários de feed são fictícios.

## 8. Organização do projeto Flutter

Sugerida; se já houver estrutura boa, adaptar preservando os princípios:

```text
lib/
├── main.dart
├── app/
│   ├── app.dart
│   ├── router/app_router.dart
│   ├── theme/app_colors.dart
│   ├── theme/app_theme.dart
│   └── localization/locale_controller.dart
├── core/
│   ├── models/
│   ├── design_system/
│   ├── widgets/
│   ├── demo/
│   └── utils/
├── features/
│   ├── onboarding/
│   ├── auth/
│   ├── home/
│   ├── astrology/
│   ├── numerology/
│   ├── love/
│   ├── wellness/
│   ├── journal/
│   ├── community/
│   ├── premium/
│   ├── notifications/
│   └── profile/
└── l10n/
    ├── app_en.arb
    └── app_es.arb
assets/
├── illustrations/   # apenas originais e devidamente licenciadas
└── icons/           # se necessário
test/
```

### Dependências permitidas conforme necessidade
`flutter_riverpod`, `go_router`, `flutter_localizations`, `intl`, `shared_preferences`, `google_fonts` (se adequado e compatível), `flutter_svg` (somente para assets próprios/licenciados). Evitar pacotes não essenciais e não adicionar SDKs remotos.

### Regras de implementação
- Usar `ThemeData`, `ColorScheme`, `ThemeExtension`/tokens centralizados para cores e formas.
- Widgets pequenos e testáveis; nenhuma tela enorme com centenas de linhas duplicadas.
- Riverpod para estados compartilhados e fixtures. `StatefulWidget` local onde simples.
- GoRouter com `ShellRoute` ou `StatefulShellRoute` para preservar estado das cinco abas.
- Material 3 customizado com identidade visual. Respeitar notch, safe areas e teclado.
- Inputs validados em demo; estados loading/empty/error/disabled quando relevantes.
- Evitar animações custosas e rebuilds de toda a árvore.
- Manter `analysis_options.yaml` e formatter Dart.
- Dependências e comentários em código preferencialmente em inglês; instruções técnicas deste arquivo podem ser interpretadas em português.
- Não colocar referências a API keys, credenciais, URLs privadas, Firebase, Supabase, serviços de IA ou backend nesta fase.

## 9. Plano de execução em sete dias (somente frontend)

**Dia 1 — Fundação e identidade:** analisar o repositório, configurar Flutter, tema, tokens, fontes, localization en/es, escolha automática/manual, rotas e shell com cinco abas. Criar biblioteca de componentes e algumas telas skeleton.

**Dia 2 — Onboarding e Home:** splash, welcome, intro, login/cadastro demo, birth details, interests, Home, Discover, perfil de demo e persistência do idioma.

**Dia 3 — Astrologia:** hub, horóscopo, 12 signos, birth chart circular ilustrativo, detalhes e insight; numerologia hub/life path/report.

**Dia 4 — Love + Wellness:** love hub, partner details, relatório de compatibilidade, wellness hub, meditações, tela de detalhes, breathing exercise funcional.

**Dia 5 — Journal + Community:** diário local, editor, histórico, feed mock, post, novo post local, denúncia demonstrativa.

**Dia 6 — Premium + Configurações:** planos simulados, créditos, notificações, calendário, conquistas, perfil, idioma, ajuda/privacidade e acabamento responsivo.

**Dia 7 — Qualidade:** testes, traduções completas, correção de overflow, acessibilidade, estados vazios/erro, animações, revisão visual, Android build de debug quando o ambiente permitir.

> Se o prazo ficar curto, preservar a **qualidade dos fluxos principais** e concluir ao máximo os demais; nunca substituir telas por promessas de serviços externos. Reportar precisamente o que ficou pendente.

## 10. Testes e critérios de aceitação

### Verificações técnicas mínimas
- `flutter pub get`
- `dart format .`
- `flutter analyze`
- `flutter test`
- `flutter build apk --debug` quando Android SDK disponível
- Se algum comando não puder executar por falta de ambiente, registrar motivo; não afirmar que passou.

### Casos de teste de UX
1. Primeiro uso → onboarding → Home sem backend.
2. Fechar/reabrir → idioma escolhido persiste.
3. Dispositivo em espanhol → app em espanhol; mudar manualmente para inglês → app em inglês.
4. Dispositivo em outro idioma → fallback `en_US`.
5. Todas as cinco abas abrem, navegação voltar funciona, sem overflow em telas pequenas.
6. Horóscopo troca Today/Week/Month e categorias, com conteúdo demonstrativo claro.
7. Mapa astral apresenta roda ilustrativa legível sem alegar cálculo real.
8. Comparação amorosa mostra resultado demonstrativo e permite editar perfis.
9. Respiração anima e permite iniciar/pausar/reiniciar.
10. Diário cria, edita e remove entradas locais.
11. Feed mock permite interagir em demo; não simula publicação online.
12. Premium não inicia compra real; nunca mostra compra concluída.
13. Nenhuma tela, botão ou rota de chat IA, voz ou alma gêmea.
14. Traduções cobrem todos os textos de navegação, botões, mensagens e conteúdo mock principal.
15. Tamanhos de texto ampliados não cortam CTAs ou títulos principais.

### Entregáveis e relatório ao fim de cada etapa
Ao concluir a etapa atual, responder com: telas concluídas; arquivos mais importantes alterados; comandos executados e resultados; pendências reais; próximo passo sugerido. Não avançar automaticamente após a **primeira etapa** se a execução estiver sendo solicitada por prompts sequenciais.

## 11. Instrução operacional inicial para Codex

Ao receber um pedido para executar este arquivo:

1. Inspecione o repositório e o ambiente Flutter antes de editar; preserve o código existente e não destrua trabalho não relacionado.
2. Releia as restrições e **comece somente pelo Dia 1**: fundação, tema, fontes, tradução, router, barra inferior e componentes base. Implemente de fato, não apenas descreva.
3. Mostre a Home de demonstração e os skeletons das quatro outras abas, com visual coerente. Tudo deverá compilar sem Supabase nem backend.
4. Faça os testes técnicos possíveis e reporte exatamente os resultados.
5. Aguarde pedido explícito para continuar o Dia 2. Nas fases seguintes mantenha a identidade e os padrões aqui definidos.

**Definição de pronto do Dia 1:** app inicia, aparece com a paleta exata e identidade celestial original, as cinco abas navegam, idioma de dispositivo resolve para en/es com fallback en-US, a troca manual funciona e a arquitetura está pronta para receber as próximas telas.
