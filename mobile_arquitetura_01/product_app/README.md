# product_app

Uma aplicação Flutter que demonstra um sistema completo de controle de favoritos em uma lista de produtos.

## 🎯 Funcionalidades

- ✅ Visualizar lista de produtos com nome, preço e status de favorito
- ✅ Marcar/desmarcar produtos como favoritos
- ✅ Contador dinâmico de produtos favoritados no AppBar
- ✅ Atualização automática e em tempo real da interface
- ✅ Arquitetura em camadas com padrão ViewModel

## 📂 Estrutura do Projeto

```
lib/
├── main.dart                                   # Ponto de entrada
├── domain/                                     # Camada de Domínio
│   ├── entities/product.dart                  # Modelo de dados
│   └── repositories/                          # Interfaces do repositório
├── data/                                      # Camada de Dados
│   └── repositories/                          # Implementações do repositório
└── presentation/                              # Camada de Apresentação
    ├── pages/                                 # Páginas da aplicação
    └── viewmodels/                            # Lógica de apresentação
```

## 🏗️ Arquitetura

A aplicação implementa uma **arquitetura em camadas** com os seguintes componentes:

### Domain (Domínio)
- Define as entidades (`Product`) e interfaces de repositório
- Independente de frameworks específicos

### Data (Dados)
- Implementa os repositórios
- Gerencia acesso aos dados (API, banco local, etc.)

### Presentation (Apresentação)
- Contém ViewModels que gerenciam estado
- UI responsiva que reage a mudanças de estado
- Widgets reutilizáveis

## 🎛️ Gerenciamento de Estado

A aplicação utiliza:
- **ValueNotifier** - Para reatividade
- **ViewModel Pattern** - Para separação de responsabilidades
- **ValueListenableBuilder** - Para reconstrução eficiente de widgets

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