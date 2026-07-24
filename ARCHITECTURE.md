# Flustra

Servidor modular de alta performance.

## Stack

| Camada   | Tecnologia |
|----------|------------|
| Backend  | Rust       |
| Frontend | Flutter    |
| API      | HTTP / WS  |
| Banco    | SQLite / PostgreSQL |

## Licença

MIT

## Estrutura

```
flustra/
├── README.md
├── LICENSE
├── ARCHITECTURE.md
├── Cargo.toml
│
├── server/                     # Rust - Núcleo do servidor
│   ├── Cargo.toml
│   └── src/
│       ├── main.rs
│       ├── lib.rs
│       ├── core/               # runtime, scheduler, eventos
│       ├── network/            # tcp, ws, http
│       ├── api/                # REST + WS para o Flutter
│       ├── config/             # loader, schema, validação
│       ├── plugins/            # sistema de extensões
│       ├── storage/            # banco e cache
│       ├── security/           # auth, crypto, permissões
│       ├── logging/
│       └── metrics/
│
├── admin/                      # Flutter - Painel web administrativo
│   ├── pubspec.yaml
│   └── lib/
│       ├── main.dart
│       ├── app.dart
│       ├── core/               # theme, router, constants
│       ├── screens/            # dashboard, settings, logs, users, plugins
│       ├── widgets/            # sidebar, cards, charts
│       ├── services/           # api, websocket, storage
│       ├── models/             # server, user, config
│       └── providers/          # estado reativo
│
├── app/                        # Flutter - Cliente multiplataforma (mobile, TV, web)
│   ├── pubspec.yaml
│   └── lib/
│       ├── main.dart
│       ├── app.dart
│       ├── core/
│       ├── screens/
│       ├── widgets/
│       ├── services/
│       ├── models/
│       └── providers/
│
├── shared/                     # Protobuf - Contratos compartilhados
│   ├── api/
│   └── protocols/
│
├── config/                     # Configurações padrão (toml)
├── plugins/                    # Plugins externos
│   ├── examples/
│   └── installed/
│
├── data/                       # Dados persistidos
├── logs/                       # Arquivos de log
├── docs/                       # Documentação
├── scripts/                    # build, release
└── docker/                     # Dockerfile opcional
```

## Decisões

### server/ separado do frontend

Permite rodar o servidor sem interface gráfica. Os apps Flutter (admin web e app multiplataforma) consomem a mesma API HTTP/WS, então o backend funciona de forma independente.

### admin/ + app/

O Flutter gera dois alvos: `admin/` (painel web embutido no binário) e `app/` (cliente mobile/TV via lojas). Ambos compartilham contratos e serviços do `shared/`.

### shared/ (Protobuf)

Contratos compartilhados entre Rust e Flutter evitam duplicação de tipos. Protobuf gera código nativo para ambas as pontas e garante compatibilidade de schema.

### plugins/ fora do server/

Usuário pode adicionar módulos sem recompilar o binário. O sistema carrega plugins compilados em tempo de execução.

### config/, data/ e logs/ fora do código

Facilita instalação em produção — os diretórios ficam no mesmo nível do binário, não embutidos no fonte.

### Workspace Cargo

```
[workspace]
members = [
    "server",
    "plugins/*"
]
```

O workspace permite que o core fique estável enquanto plugins evoluem independentemente, preparando o Flustra para crescer como plataforma.

## Princípios

1. Núcleo pequeno, recursos como módulos.
2. Configuração simples, sem dependências externas.
3. Interface nunca bloqueia o servidor.
4. Único binário.

## Roadmap

1. **Fase 1** — core, config, logs, API
2. **Fase 2** — frontend Flutter, plugins, métricas
3. **Fase 3** — cluster, alta disponibilidade
