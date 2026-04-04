# product_app

Uma aplicação Flutter que demonstra um sistema completo de controle de favoritos em uma lista de produtos, com arquitetura estruturada e navegação entre telas.

## 🎯 Funcionalidades

- ✅ Visualizar lista de produtos com nome, preço e status de favorito
- ✅ Marcar/desmarcar produtos como favoritos (persistido localmente)
- ✅ Contador dinâmico de produtos favoritados no AppBar
- ✅ Navegação entre telas: Home → Lista → Detalhes → Formulário
- ✅ Tela de detalhes com informações completas do produto
- ✅ Formulário unificado para criação e edição de produtos
- ✅ Estrutura organizada com separação de responsabilidades
- ✅ Persistência local usando SharedPreferences

## 📂 Estrutura do Projeto

```
lib/
├── main.dart                                   # Ponto de entrada
├── models/
│   └── product.dart                           # Modelo de dados do produto
├── services/
│   └── product_service.dart                   # Serviço para operações com API
├── screens/
│   ├── home_screen.dart                       # Tela inicial
│   ├── product_list_screen.dart               # Tela de listagem de produtos
│   ├── product_detail_screen.dart             # Tela de detalhes do produto
│   └── product_form_screen.dart               # Tela de formulário (criar/editar)
├── widgets/
│   └── product_card.dart                      # Componente reutilizável do cartão de produto
└── (pastas antigas podem ser removidas)
```

## 🏗️ Arquitetura

O projeto utiliza uma estrutura simplificada adequada para aplicações móveis:

### Models
- Contém as classes de modelo de dados (Product)
- Inclui métodos para conversão JSON ↔ objeto Dart

### Services
- Centraliza as chamadas de rede e operações com dados
- Gerencia persistência local (favoritos via SharedPreferences)
- Prepara estrutura para operações CRUD completas

### Screens
- Telas da aplicação com navegação
- Gerenciamento de estado local com setState
- Separação clara entre listagem, detalhes e formulários

### Widgets
- Componentes reutilizáveis
- Promove consistência visual e reutilização de código

## 🔄 Navegação

A aplicação implementa fluxo de navegação completo:

```
HomeScreen
    ↓
ProductListScreen (lista produtos + CRUD)
    ↓
ProductDetailScreen (detalhes + editar)
    ↓
ProductFormScreen (criar/editar produto)
```

## 💾 Persistência

- **Favoritos**: Armazenados localmente usando SharedPreferences
- **Produtos**: Carregados da API FakeStore (https://fakestoreapi.com)
- **Estrutura preparada** para futuras operações de escrita na API

## 🎛️ Gerenciamento de Estado

Para este projeto de tamanho moderado, utilizamos:
- **setState** - Para gerenciamento de estado local nas telas
- **SharedPreferences** - Para persistência de dados locais (favoritos)
- **FutureBuilder** - Para operações assíncronas (carregamento de dados)

Esta abordagem é adequada para aplicações simples e mantém o código legível.

## 📋 Respostas às Perguntas sobre a Evolução do Projeto

### 1. Qual era a estrutura do seu projeto antes da inclusão das novas telas?
Antes da reestruturação, o projeto tinha uma arquitetura em camadas (Domain/Data/Presentation) com ViewModels e repositórios. Após a reestruturação, foi simplificada para uma estrutura mais direta com Models, Services, Screens e Widgets.

### 2. Como ficou o fluxo da aplicação após a implementação da navegação?
O fluxo atual é: HomeScreen → ProductListScreen → ProductDetailScreen/ProductFormScreen, com navegação push/pop e possibilidade de criar/editar produtos.

### 3. Qual é o papel do Navigator.push() no seu projeto?
Usado para navegar para novas telas, como da lista para detalhes ou para o formulário de criação/edição.

### 4. Qual é o papel do Navigator.pop() no seu projeto?
Usado para voltar à tela anterior, fechando a tela atual.

### 5. Como os dados do produto selecionado foram enviados para a tela de detalhes?
Passados como parâmetro no construtor da ProductDetailScreen.

### 6. Por que a tela de detalhes depende das informações da tela anterior?
Porque exibe dados específicos do produto selecionado na lista.

### 7. Quais foram as principais mudanças feitas no projeto original?
- Reestruturação completa das pastas (models/, services/, screens/, widgets/)
- Simplificação da arquitetura removendo camadas desnecessárias
- Criação de ProductService para centralizar operações
- Implementação de ProductFormScreen unificada para CRUD
- Persistência local de favoritos
- Separação de widgets reutilizáveis

### 8. Quais dificuldades você encontrou durante a adaptação do projeto para múltiplas telas?
- Reorganização da estrutura de arquivos
- Adaptação do gerenciamento de estado para setState
- Manutenção da consistência entre telas
- Implementação de persistência local


## 📱 Tela Principal

![Conceito da Tela]

```
┌─────────────────────────────┐
│ Produtos    [❤️ Favoritos]   │
├─────────────────────────────┤
│ Notebook - R$ 3500      [❤]│
├─────────────────────────────┤
│ Mouse - R$ 120          [☆] │
├─────────────────────────────┤
│ Teclado - R$ 250        [★] │
├─────────────────────────────┤
│ Monitor - R$ 900        [☆] │
└─────────────────────────────┘
```

## 🚀 Como Executar

1. Instale as dependências:
   ```bash
   flutter pub get
   ```

2. Execute a aplicação:
   ```bash
   flutter run
   ```

## 🌐 Integração com API

A aplicação agora consome dados reais da **FakeStore API** (https://fakestoreapi.com/products):

### Funcionalidades da API
- ✅ **Carregamento automático** - Produtos são carregados da API ao iniciar
- ✅ **Botão de refresh** - Permite recarregar produtos manualmente
- ✅ **Tratamento de erros** - Interface amigável para falhas de conexão
- ✅ **Botão de retry** - Permite tentar novamente em caso de erro

### Estrutura dos Dados
```json
{
  "id": 1,
  "title": "Fjallraven - Foldsack No. 1 Backpack",
  "price": 109.95,
  "image": "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg"
}
```

### Tratamento de Estado
- **Loading** - Indicador de progresso durante carregamento
- **Success** - Lista de produtos exibida normalmente
- **Error** - Tela de erro com opção de tentar novamente

## 📚 Para Saber Mais

Veja o arquivo [IMPLEMENTACAO_FAVORITOS.md](IMPLEMENTACAO_FAVORITOS.md) para documentação completa sobre a implementação.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


## Perguntas e Respostas de Arquitetura Geral

1. Em qual camada foi implementado o cache e por quê?
- O cache foi implementado na camada de dados, especificamente no datasource (por exemplo, em um `ProductCacheDatasource`). Isso garante que os dados em cache fiquem próximos à fonte de dados e sejam reutilizados antes de fazer novas requisições de rede, desacoplando-o das camadas de domínio e apresentação.

2. Por que o ViewModel não realiza chamadas HTTP diretamente?
- O ViewModel pertence à camada de apresentação e é responsável por gerenciar estado e lógica de UI. Chamadas HTTP pertencem à camada de dados, por isso o ViewModel depende da camada de domínio/repositório para manter responsabilidade única e facilitar testes e manutenção.

3. O que aconteceria se a interface acessasse diretamente o datasource?
- A interface (UI) ficaria fortemente acoplada às implementações de dados, dificultando testes, troca de fonte de dados e manutenção. Isso violaria os princípios de separação de responsabilidades e tornaria a aplicação menos flexível e mais difícil de evoluir.

4. Como essa arquitetura facilitaria a substituição da API por um banco de dados local?
- Com camadas claras e abstrações (`Repository` + `Datasource`), basta criar outra implementação de datasource (ou adapter) para banco local e injetá-la no repositório. A camada de domínio e apresentação não precisam mudar, pois trabalham com interfaces abstratas, permitindo swap rápido entre diferentes fontes de dados.


## Perguntas e Respostas - Gerenciamento de Estado

### 1. O que significa gerenciamento de estado em uma aplicação Flutter?

Gerenciamento de estado é basicamente a forma como a gente controla os dados que mudam dentro do app. Tudo que pode mudar é estado, como lista de produtos, usuário, favoritos, tema e por aí vai. A ideia é simples: quando esses dados mudam, a interface precisa acompanhar automaticamente. Então serve pra guardar os dados, permitir mudanças organizadas e avisar a UI quando algo mudou.

### 2. Por que manter o estado diretamente dentro dos widgets pode gerar problemas em aplicações maiores?

No começo funciona, mas depois vira bagunça. Você acaba com código duplicado, estados desatualizados, dificuldade pra testar e muita informação sendo passada entre vários widgets. Além disso, fica difícil de manter e entender onde as coisas estão sendo alteradas. Não escala bem.

### 3. Qual é o papel do método notifyListeners() na abordagem Provider?

Ele é o que avisa que algo mudou. Quando você altera o estado, chama o notifyListeners() e todos os widgets que estão escutando são atualizados automaticamente. Sem isso, a interface não saberia que precisa se reconstruir.

### 4. Qual é a principal diferença conceitual entre Provider e Riverpod?

Provider é mais simples e fácil de usar, principalmente pra quem está começando. Já o Riverpod é mais moderno, tem menos dependência da árvore de widgets, é mais seguro e facilita testes. Resumindo: Provider é mais simples, Riverpod é mais robusto.

### 5. No padrão BLoC, por que a interface não altera diretamente o estado da aplicação?

Porque cada parte tem sua responsabilidade. A interface só exibe e envia eventos, quem realmente processa e muda o estado é o BLoC. Isso deixa tudo mais organizado, previsível e fácil de testar.

### 6. Qual é a vantagem de organizar o fluxo dessa forma (Evento → BLoC → Novo estado → Interface)?

Fica tudo mais previsível. Você sabe exatamente o que causou a mudança e qual foi o resultado. Isso facilita debug, testes e mantém o código desacoplado, já que a UI não depende da lógica interna.

### 7. Qual estratégia de gerenciamento de estado foi utilizada em sua implementação?

Usei ValueNotifier com ViewModel. Escolhi porque é simples, não precisa de biblioteca externa e já resolve bem o problema. O ViewModel controla o estado e a UI só escuta e se atualiza quando necessário.

### 8. Durante a implementação, quais foram as principais dificuldades encontradas?

Teve algumas partes chatinhas, tipo ajustar o modelo de produto que era imutável, organizar onde cada responsabilidade ficava, resolver problema de importação e dependência circular e garantir que a interface só atualizasse o necessário. Também precisei cuidar da imutabilidade e fazer as camadas se integrarem direitinho sem virar bagunça.

### 1. Qual era a estrutura do seu projeto antes da inclusão das novas telas?
Antes da implementação da navegação e múltiplas telas, o projeto consistia em uma única tela (`ProductPage`) que exibia uma lista simples de produtos carregados da API, sem funcionalidades de favoritos ou navegação para detalhes.

### 2. Como ficou o fluxo da aplicação após a implementação da navegação?
O fluxo atual segue: `HomePage` (tela inicial com botão para acessar produtos) → `ProductListPage` (lista de produtos com favoritos) → `ProductDetailPage` (detalhes do produto selecionado). O usuário pode navegar para frente com botões e voltar usando o botão "Voltar" ou o botão de navegação do sistema.

### 3. Qual é o papel do Navigator.push() no seu projeto?
O `Navigator.push()` é usado para navegar para uma nova tela, empilhando-a sobre a atual. No projeto, é utilizado para ir da tela inicial para a lista de produtos e da lista para os detalhes do produto selecionado, permitindo a criação de um fluxo de navegação sequencial.

### 4. Qual é o papel do Navigator.pop() no seu projeto?
O `Navigator.pop()` remove a tela atual da pilha de navegação, retornando à tela anterior. É usado no botão "Voltar para produtos" da tela de detalhes para retornar à lista de produtos.

### 5. Como os dados do produto selecionado foram enviados para a tela de detalhes?
Os dados são passados através do construtor da `ProductDetailPage`, recebendo o objeto `Product` como parâmetro. Na `ProductListPage`, ao tocar em um produto, é executado: `Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailPage(product: product)))`.

### 6. Por que a tela de detalhes depende das informações da tela anterior?
A tela de detalhes depende das informações da tela anterior porque exibe dados específicos do produto selecionado na lista. Sem esses dados (como título, preço, descrição, imagem), a tela não teria conteúdo para mostrar, tornando-a dependente da seleção feita pelo usuário.

### 7. Quais foram as principais mudanças feitas no projeto original?
- Separação da funcionalidade em múltiplas telas (HomePage, ProductListPage, ProductDetailPage)
- Implementação de navegação com Navigator.push() e Navigator.pop()
- Adição de sistema de favoritos com contador dinâmico
- Criação de tela de detalhes com layout aprimorado
- Reestruturação da arquitetura de apresentação com ViewModels

### 8. Quais dificuldades você encontrou durante a adaptação do projeto para múltiplas telas?
- Gerenciamento de estado entre telas, especialmente para o contador de favoritos que precisa ser compartilhado
- Passagem de dados entre telas através de parâmetros de construtor
- Adaptação da arquitetura ViewModel para funcionar com navegação
- Manutenção da consistência visual e funcional entre as telas
- Tratamento de casos onde o usuário navega de volta sem completar ações

---

## 📝 Respostas sobre a Evolução do Projeto

### 1. Quais eram as limitações da versão inicial do projeto?

No começo, a aplicação era bem simples: apenas exibia uma lista de produtos da API sem nenhuma interação. Não tinha sistema de favoritos, navegação entre telas, possibilidade de editar ou criar produtos novos, e toda a lógica estava concentrada em poucos widgets. Era basicamente um "olhe e pronto", sem muito para fazer dentro do app.

### 2. Quais mudanças estruturais você realizou na aplicação?

Refatorei bastante! Sai de uma estrutura monolítica para uma arquitetura em camadas bem definida: separei o código em **Models** (dados), **Services** (lógica de API e persistência), **Screens** (telas) e **Widgets** (componentes reutilizáveis). Também implementei gerenciamento de estado com `setState` e `SharedPreferences`, criei um serviço centralizado para operações, e preparei a aplicação para operações completas de CRUD, não apenas leitura.

### 3. Como ficou a organização das telas e do fluxo de navegação?

O fluxo ficou bem intuitivo: você começa na **HomeScreen** (tela inicial com um botão), vai para a **ProductListScreen** (lista de produtos), pode clicar em um produto para ver os **Detalhes** na **ProductDetailScreen**, e de lá pode editar usando a **ProductFormScreen**. As telas se comunicam passando objetos como parâmetros e usam `Navigator.push()` para ir para frente e `Navigator.pop()` para voltar. Tudo conectado e fluindo naturalmente.

### 4. Quais atributos do produto passaram a ser utilizados na nova versão?

O modelo **Product** usa sete atributos principais: **id** (identificador único), **title** (nome), **price** (preço), **image** (URL da imagem), **description** (descrição completa), **category** (categoria do produto) e **favorite** (boolean para controlar favoritos). Cada um tem seu papel, seja na exibição ou no gerenciamento de estado.

### 5. Como você organizou a camada de acesso a dados?

Centralizei tudo em uma classe **ProductService** que funciona como um "gerente de dados". Ela cuida de buscar produtos da API (`fetchProducts`), salvar e recuperar favoritos usando `SharedPreferences`, e também gerenciar operações locais de CRUD (criar, atualizar, deletar produtos criados pelo usuário). Dessa forma, a aplicação não se preocupa com os detalhes de como os dados são obtidos, só chama o serviço e recebe o resultado.

### 6. Seu projeto foi preparado para operações além do GET? Explique.

Sim, totalmente! Apesar da FakeStore API ser apenas leitura, implementei métodos completos de CRUD no **ProductService**: `addProduct()` (POST), `updateProduct()` (PUT) e `deleteProduct()` (DELETE). Esses produtos são armazenados localmente em `SharedPreferences`, funcionando como um banco de dados local. Dessa forma, o usuário pode criar e editar produtos, tudo sincronizado com a interface em tempo real. Se futuramente conectarmos a uma API completa, é só adaptar esses métodos.

### 7. Houve uso ou planejamento de persistência local? Justifique.

Com certeza! Usamos `SharedPreferences` em dois contextos. Primeiro, para **persistir favoritos** - quando você marca um produto como favorito, fica salvo localmente e não é perdido ao fechar o app. Segundo, para **persistir produtos criados** - qualquer produto novo ou editado é armazenado localmente já que a API não permite escrita. Essa combinação garante que a aplicação funcione bem mesmo offline e mantém os dados do usuário intactos.

### 8. Quais foram as principais dificuldades encontradas durante a evolução do projeto?

Teve sim! A maior dificuldade foi **sincronizar estado entre telas** - fazer os favoritos atualizarem em tempo real em toda a aplicação foi um quebra-cabeça. Também foi desafiador **gerenciar produtos locais e de API juntos** sem gerar duplicatas ou conflitos. A **imutabilidade do modelo** também foi importante: precisei usar `copyWith()` para manter padrões de boa prática. Por fim, teve bastante **organização arquitetural** - decidir o que vai onde, como separar responsabilidades corretamente e manter tudo testável foi um processo de ajustes e refinamento.


