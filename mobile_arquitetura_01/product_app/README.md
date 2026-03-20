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

## Perguntas e Respostas de Arquitetura

1. Em qual camada foi implementado o cache e por quê?
- O cache foi implementado na camada de dados, especificamente no datasource (por exemplo, em um `ProductCacheDatasource`). Isso garante que os dados em cache fiquem próximos à fonte de dados e sejam reutilizados antes de fazer novas requisições de rede, desacoplando-o das camadas de domínio e apresentação.

2. Por que o ViewModel não realiza chamadas HTTP diretamente?
- O ViewModel pertence à camada de apresentação e é responsável por gerenciar estado e lógica de UI. Chamadas HTTP pertencem à camada de dados, por isso o ViewModel depende da camada de domínio/repositório para manter responsabilidade única e facilitar testes e manutenção.

3. O que aconteceria se a interface acessasse diretamente o datasource?
- A interface (UI) ficaria fortemente acoplada às implementações de dados, dificultando testes, troca de fonte de dados e manutenção. Isso violaria os princípios de separação de responsabilidades e tornaria a aplicação menos flexível e mais difícil de evoluir.

4. Como essa arquitetura facilitaria a substituição da API por um banco de dados local?
- Com camadas claras e abstrações (`Repository` + `Datasource`), basta criar outra implementação de datasource (ou adapter) para banco local e injetá-la no repositório. A camada de domínio e apresentação não precisam mudar, pois trabalham com interfaces abstratas, permitindo swap rápido entre diferentes fontes de dados.
