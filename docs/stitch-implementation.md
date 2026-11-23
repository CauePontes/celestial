# Celestial — implementação completa do frontend Stitch

## Inventário e cobertura das exportações

Foram analisados recursivamente 25 arquivos em `design/`: 12 HTMLs, 12 PNGs e
`design/screens/celestial/DESIGN.md`. Os HTMLs contêm CSS/configuração Tailwind,
SVGs orbitais, scripts de interação, nove referências remotas a imagens e fontes
Google Fonts. Não há áudio exportado. O inventário com caminhos, tamanhos,
hashes, rotas e arquivos de implementação está em
[design-inventory.json](design-inventory.json).

**Todas as 12 telas exportadas foram implementadas com widgets Flutter reais.**
Os PNGs de referência não são empacotados nem usados para montar telas.

| Tela exportada | Rota | Implementação | Renderização Flutter |
| --- | --- | --- | --- |
| Welcome | `/welcome` | [entry_screens.dart](../lib/features/onboarding/entry_screens.dart) | [Preview](previews/01-welcome.png) |
| Birth Details | `/birth-details` | [birth_details_screen.dart](../lib/features/onboarding/birth_details_screen.dart) | [Preview](previews/02-birth-details.png) |
| Interests | `/interests` | [interests_screen.dart](../lib/features/onboarding/interests_screen.dart) | [Preview](previews/03-interests.png) |
| Home | `/home` | [home_screen.dart](../lib/features/home/home_screen.dart) | [Preview](previews/04-home.png) |
| Astrology Hub | `/astrology` | [astrology_hub_screen.dart](../lib/features/astrology/astrology_hub_screen.dart) | [Preview](previews/05-astrology.png) |
| Horoscope Details | `/horoscope` | [horoscope_screen.dart](../lib/features/astrology/horoscope_screen.dart) | [Preview](previews/06-horoscope.png) |
| Love Hub | `/love` | [love_hub_screen.dart](../lib/features/love/love_hub_screen.dart) | [Preview](previews/07-love.png) |
| Wellness Hub | `/wellness` | [wellness_hub_screen.dart](../lib/features/wellness/wellness_hub_screen.dart) | [Preview](previews/08-wellness.png) |
| Profile | `/profile` | [profile_screen.dart](../lib/features/profile/profile_screen.dart) | [Preview](previews/09-profile.png) |
| Cosmic Calendar | `/calendar` | [cosmic_calendar_screen.dart](../lib/features/engagement/cosmic_calendar_screen.dart) | [Preview](previews/10-calendar.png) |
| Celestial Plus Subscription | `/premium` | [premium_screen.dart](../lib/features/premium/premium_screen.dart) | [Preview](previews/11-subscription.png) |
| Natal Chart Deep Dive | `/birth-chart` | [birth_chart_screen.dart](../lib/features/astrology/birth_chart_screen.dart) | [Preview](previews/12-natal-chart.png) |

## Catálogo completo do AGENTS.md

As 44 telas da lista-mestra foram implementadas. Formulários relacionados
compartilham componentes e validação; são destinos navegáveis, não placeholders.
Existem também recuperação demonstrativa de senha, artigos de relacionamento,
favoritos e variantes de criação/edição. São 48 exemplos concretos de rotas
cobertos pelos testes.

| # | Tela da lista-mestra | Rota de exemplo | Estado |
| --- | --- | --- | --- |
| 1 | Splash | `/splash` | Implementada |
| 2 | Welcome | `/welcome` | Implementada |
| 3 | Intro | `/intro` | Implementada |
| 4 | Demo Sign In | `/sign-in` | Implementada |
| 5 | Demo Sign Up | `/sign-up` | Implementada |
| 6 | Birth Details | `/birth-details` | Implementada |
| 7 | Interests | `/interests` | Implementada |
| 8 | Home | `/home` | Implementada |
| 9 | Discover | `/discover` | Implementada |
| 10 | Cosmic Calendar | `/calendar` | Implementada |
| 11 | Notifications | `/notifications` | Implementada |
| 12 | Astrology Hub | `/astrology` | Implementada |
| 13 | Horoscope | `/horoscope` | Implementada |
| 14 | Zodiac Signs | `/zodiac` | Implementada |
| 15 | Birth Chart | `/birth-chart` | Implementada |
| 16 | Chart Details | `/chart-details` | Implementada |
| 17 | Astrological Insight | `/insight` | Implementada |
| 18 | Planet Detail | `/planet/0` | Implementada |
| 19 | Numerology Hub | `/numerology` | Implementada |
| 20 | Life Path | `/life-path` | Implementada |
| 21 | Numerology Report | `/numerology-report` | Implementada |
| 22 | Love Hub | `/love` | Implementada |
| 23 | Partner Details | `/partner-details` | Implementada |
| 24 | Compatibility Result | `/compatibility-result` | Implementada |
| 25 | Compatibility Report | `/compatibility-report` | Implementada |
| 26 | Wellness Hub | `/wellness` | Implementada |
| 27 | Meditation Library | `/meditations` | Implementada |
| 28 | Meditation Details | `/meditation/moonrise` | Implementada |
| 29 | Meditation Player | `/meditation-player/moonrise` | Implementada |
| 30 | Breathing Exercise | `/breathing` | Implementada |
| 31 | Journal | `/journal` | Implementada |
| 32 | Journal Editor | `/journal/new` | Implementada |
| 33 | Community Feed | `/community` | Implementada |
| 34 | Community Post | `/community/post/sample-0` | Implementada |
| 35 | Create Post | `/community/new` | Implementada |
| 36 | Report Post | `/community/report/sample-0` | Implementada |
| 37 | Premium | `/premium` | Implementada |
| 38 | Credits | `/credits` | Implementada |
| 39 | Profile | `/profile` | Implementada |
| 40 | Edit Profile | `/edit-profile` | Implementada |
| 41 | Settings | `/settings` | Implementada |
| 42 | Language Settings | `/language` | Implementada |
| 43 | Privacy / Help | `/privacy` | Implementada |
| 44 | Achievements | `/achievements` | Implementada |

Destinos adicionais: `/recover`, `/relationship-insight`, `/favorites` e
`/journal/:id/edit`.

## Design system e assets

- Paleta exata acordada no AGENTS.md e no texto do DESIGN.md: #141126, #5532A8,
  #A991F0, #DABD89 e #F7F4FF. Os aliases Material gerados em alguns HTMLs diferem;
  as cores de marca acordadas prevalecem.
- Playfair Display e Plus Jakarta Sans incluídas localmente com licenças SIL OFL.
  Noto Sans Symbols e Symbols 2, também OFL, cobrem os glifos zodiacais/planetários.
  Nenhuma fonte depende de download na execução.
- As nove imagens referenciadas foram incluídas em `assets/stitch/` e usadas
  nos contextos editoriais correspondentes. As URLs de origem estão em
  [sources.json](../assets/stitch/sources.json). Não há Image.network.
- Cabeçalho, moldura responsiva, fundo cósmico sutil, cards de 16/24px, botões
  pill, filtros, brasão orbital, roda natal interativa, cards editoriais,
  menus, métricas, badges, seletor de data/humor, campos de formulário,
  cards de meditação/post/plano, avisos demo e estados vazio/loading/erro
  são componentes compartilhados.
- Cinco abas preservam suas árvores e rolagem via StatefulShellRoute.
  Detalhes têm voltar e transição curta que respeita redução de movimento.
  Voltar no Android a partir de outra aba retorna à Home.

## Interações concluídas

- Splash; introdução em três páginas; login/cadastro/recuperação demonstrativos;
  modo visitante; formulário validado de nome, data, horário/cidade; opção de
  horário desconhecido; interesses e edição local de perfil.
  Credenciais não são enviadas nem guardadas.
- Home abre os fluxos de horóscopo, carta, numerologia, respiração, diário,
  calendário, descoberta, comunidade e planos.
- Horóscopo diário/semanal/mensal; navegação de data; 12 signos; filtros por
  categoria; favoritos; três narrativas completas com variantes en/es.
- Carta com rotação por gesto, três posições principais, dez planetas,
  doze casas, aspectos, detalhes e reflexões salvas.
- Numerologia com entrada de data, número de exemplo, ciclos e relatório.
  O número é explicitamente uma amostra, sem alegar cálculo dos dados inseridos.
- Comparação com segunda pessoa, edição dos perfis e relatório de comunicação,
  conexão emocional e valores. As porcentagens são visivelmente rotuladas demo.
- Seis meditações com filtros por tema/duração e favoritos.
  Detalhes e player explicam a falta de áudio; reprodução fica desabilitada.
- Respiração 4-7-8, em caixa e lunar, com animação real, fases, iniciar/pausar,
  retomar, pular fase, reiniciar e contar ciclos. Com movimento reduzido, o
  círculo fica estático e as fases/contagem continuam funcionais.
- Diário com humor e criação/edição/exclusão validada em memória.
- Oito posts fictícios localizados, filtros, publicação apenas local, comentários,
  curtidas, denúncia sem envio e bloqueio de autor apenas durante a sessão.
- Calendário mensal/semanal, seleção de data, filtros, favoritos e estado vazio.
- Seleção anual/mensal, três planos ilustrativos em USD e histórico de créditos
  tipado. Compra e sincronização com calendários não estão conectadas.
- Perfil com métricas da sessão, favoritos, conquistas, notificações lidas/não
  lidas, preferências simuladas, sistema de casas, idioma, dois temas visuais,
  privacidade/ajuda provisórias e reinício da sessão.
- Inglês e espanhol abrangem labels, erros, descrições, leituras e posts.
  A lista de idiomas do dispositivo é resolvida em ordem; o fallback é en_US.
  A preferência manual tem prioridade e persiste.

## Arquitetura, dados e persistência

Riverpod injeta contratos CatalogRepository, InterpretationRepository,
PremiumRepository e NotificationRepository, com implementações Mock locais e
modelos imutáveis. O catálogo assíncrono tem estados loading/erro/retry; a
substituição do repositório permite testar erro e recuperação sem falhas
aleatórias na UI.

SharedPreferences guarda somente idioma e aparência. Perfil, nascimento,
parceiro, interesses, notificações, sistema de casas, diário, posts, comentários,
bloqueios, favoritos e progresso de conquistas vivem em memória da sessão e
reiniciam quando o processo fecha. Não há banco, backend, endpoints, credenciais,
SDK de IA, integração de calendário, serviço de pagamento ou compra real.

`lib/features/` organiza telas/widgets e repositórios por funcionalidade;
`lib/core/` contém modelos, estado e componentes compartilhados;
`lib/app/` contém router/tema/controladores de preferência;
`lib/l10n/` contém ARBs e código gerado oficial.
`assets/` contém fontes com licença e imagens locais.

## Diferenças deliberadas em relação aos mockups

1. Afirmações de efemérides verificadas/cálculo real viraram avisos ilustrativos.
   Datas atuais locais substituem datas fixas de 2024/2025. Os cinco eventos
   repetem narrativas de exemplo por mês, sem representar trânsitos reais.
2. Escores, posições e números são amostras. Métricas do perfil refletem ações
   locais em vez de simular uso anterior.
3. Assinatura ativa, renovação, restauração de compras e teste grátis foram
   removidos. O CTA é Coming soon, desabilitado e sem checkout.
4. O depoimento não verificável foi removido. Os benefícios descrevem o
   escopo implementado e não prometem áudio ausente.
5. Sincronização fica indisponível com explicação. Preferências de notificações
   não pedem permissões do sistema nem enviam alertas.
6. O card de meditação abre os detalhes. O player permanece desabilitado;
   o script HTML que apenas trocava o ícone play/pause não foi reproduzido.
7. Diagramas são reconstruções CustomPainter, sem screenshots sobrepostos.
   Geometria e glifos aproximam os SVGs originais; filtros e rotação são reais.
8. Texto espanhol e ampliado pode quebrar linhas e rolar. Alturas fixas e
   restrições de zoom do HTML foram adaptadas para evitar cortes.
   A leitura é limitada a 720px de largura em tablets/desktop.
9. A etapa exportada de nascimento/interesses é complementada pela introdução
   e autenticação demo exigidas pelo fluxo da lista-mestra.
10. Retratos e identidades são ilustrativos e não representam conta online.

## Verificações e execução

Os resultados finais serão registrados após a última execução dos comandos.
As prévias em `docs/previews/` foram renderizadas pelo Flutter a 390 × 884 com
as fontes reais e comparadas visualmente às referências. Capturas adicionais
mostram seções após rolagem. Regeneração:

```sh
flutter test tool/render_previews_test.dart --update-goldens
```

A suíte cobre rotas, idiomas a 320 × 740 com texto a 200%, primeiro uso,
navegação/voltar/rolagem, preferências persistidas, validação, diário, comunidade,
períodos, fases e pausa da respiração, filtros, calendário, catálogo com erro e
retry, quantidade de fixtures, áudio indisponível, compra desabilitada e
inventário das exportações.

O ambiente Windows permite Android e Chrome. Compilar iOS exige macOS/Xcode
e não foi validado aqui. Testes em aparelhos físicos, VoiceOver/TalkBack e
assinatura de distribuição ficam para a validação de publicação.

```sh
flutter pub get
flutter run -d chrome --web-port 5181 --no-web-resources-cdn
flutter run
flutter analyze
flutter test
flutter build apk --debug
```
