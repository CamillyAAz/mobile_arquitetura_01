# Product App - Flutter + DummyJSON

Aplicativo Flutter desenvolvido para a disciplina de arquitetura mobile. O projeto implementa autenticação, sessão de usuário, listagem de produtos, detalhes e controle de favoritos usando a API pública DummyJSON.

## Funcionalidades

- Login com validação de usuário e senha.
- Autenticação via `POST /auth/login`.
- Sessão autenticada persistida localmente.
- Bloqueio de acesso à lista de produtos sem login.
- Exibição do nome do usuário autenticado.
- Logout com limpeza de sessão.
- Listagem de produtos via `GET /products`.
- Tela de detalhes via `GET /products/{id}`.
- Lista com título, preço e imagem do produto.
- Detalhes com nome, preço, descrição, categoria, estoque, avaliação e imagem.
- Sistema de favoritos com persistência local.
- Marcar e remover produtos dos favoritos.
- Atualização automática da interface com `setState`.
- Tratamento de carregamento e erro nas requisições.

## API Utilizada

O projeto consome a API pública DummyJSON:

- Base URL: `https://dummyjson.com`
- Login: `POST /auth/login`
- Produtos: `GET /products`
- Detalhes: `GET /products/{id}`

Usuário de teste:

```text
Usuário: emilys
Senha: emilyspass
```

## Tecnologias

- Flutter
- Dart
- HTTP
- SharedPreferences
- Material Design 3

## Organização do Projeto

```text
lib/
├── core/
│   └── errors/
├── models/
│   ├── auth_user.dart
│   └── product.dart
├── screens/
│   ├── login_screen.dart
│   ├── product_list_screen.dart
│   └── product_detail_screen.dart
├── services/
│   ├── auth_service.dart
│   └── product_service.dart
├── session/
│   └── session_controller.dart
├── widgets/
│   └── product_card.dart
└── main.dart
```

## Arquitetura

O app foi separado por responsabilidades:

- `models`: representação dos dados recebidos da API.
- `services`: chamadas HTTP e persistência local.
- `session`: controle da sessão autenticada.
- `screens`: telas e estado visual da aplicação.
- `widgets`: componentes reutilizáveis.

O gerenciamento de estado foi feito com `setState`, pois os estados utilizados são locais e simples, como carregamento, erro, busca e favoritos. A sessão e os favoritos ficam isolados em classes próprias, evitando que a regra de negócio fique misturada diretamente na interface.

## Fluxo da Aplicação

```text
SessionGate
  ├── Usuário sem sessão -> LoginScreen
  └── Usuário autenticado -> ProductListScreen
                                └── ProductDetailScreen
```

Ao iniciar o app, o `SessionGate` verifica se existe uma sessão salva. Caso exista, o usuário acessa diretamente a lista de produtos. Caso contrário, permanece na tela de login.

## Como Executar

Entre na pasta do projeto:

```bash
cd product_app
```

Instale as dependências:

```bash
flutter pub get
```

Execute o aplicativo:

```bash
flutter run
```

## Como Validar

Execute a análise estática:

```bash
flutter analyze
```

Execute os testes:

```bash
flutter test
```

## Checklist do Projeto

- [x] Repositório chamado `mobile_arquitetura_01`
- [x] Projeto Flutter executável
- [x] Organização em camadas ou pastas separadas
- [x] Uso da API DummyJSON
- [x] Tela de login
- [x] Validação de usuário e senha
- [x] `POST /auth/login` funcionando
- [x] Tratamento de erro no login
- [x] Sessão de usuário autenticado
- [x] Bloqueio de acesso sem login
- [x] Tela principal de produtos
- [x] Nome do usuário autenticado exibido
- [x] Botão de logout
- [x] `GET /products` funcionando
- [x] Modelo `Product` ajustado para DummyJSON
- [x] Lista com título, preço e imagem
- [x] Tela de detalhes do produto
- [x] `GET /products/{id}` funcionando
- [x] Detalhes com nome, preço, descrição e imagem
- [x] Navegação entre telas
- [x] Uso de `Navigator.push`
- [x] Uso de `Navigator.pop`
- [x] Controle de favoritos
- [x] Marcar produto como favorito
- [x] Remover produto dos favoritos
- [x] Atualização automática da interface
- [x] Uso de `setState` justificado
- [x] Separação entre modelo, serviço, sessão e tela
- [x] Tratamento de carregamento
- [x] Tratamento de erro nas requisições

## Autor

Projeto desenvolvido como atividade acadêmica de Flutter e arquitetura mobile.
