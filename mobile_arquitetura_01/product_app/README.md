# product_app

A new Flutter project.

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
