# Flustra — command runner
# `just` lista todos os comandos

rust_build := "cargo build --release -p flustra-server"
rust_check := "cargo check -p flustra-server"
rust_test := "cargo test -p flustra-server"
rust_lint := "cargo clippy --all-targets -- -D warnings"
rust_fmt := "cargo fmt"
rust_fmt_check := "cargo fmt --check"
rust_docs := "cargo doc --no-deps -p flustra-server"
flutter_bin := "/home/lucasc/development/flutter/bin/flutter"
flutter_base := "FLUTTER_HOME={{flutter_bin}}"
admin_dir := "admin"
app_dir := "app"

# Lista todos os comandos disponíveis
default:
    @just --list

# Build do servidor Rust (release)
build:
    {{rust_build}}

# Check do servidor Rust
check:
    {{rust_check}}

# Testes do servidor Rust
test:
    {{rust_test}}

# Clippy (linter) do servidor Rust
lint:
    {{rust_lint}}

# Formata código Rust + Flutter
fmt:
    {{rust_fmt}}
    -cd {{admin_dir}} && {{flutter_bin}} format lib/
    -cd {{app_dir}} && {{flutter_bin}} format lib/

# Verifica formatação
fmt-check:
    {{rust_fmt_check}}

# Gera documentação Rust
docs:
    {{rust_docs}}

# Build release + testes + lint (pré-push)
ci:
    {{rust_fmt_check}}
    {{rust_lint}}
    {{rust_test}}
    {{rust_build}}

# Gera código Dart dos protobufs
proto:
    mkdir -p {{admin_dir}}/lib/gen {{app_dir}}/lib/gen
    protoc --dart_out={{admin_dir}}/lib/gen -I shared shared/api/*.proto shared/protocols/*.proto shared/errors/*.proto
    rm -rf {{app_dir}}/lib/gen
    cp -r {{admin_dir}}/lib/gen {{app_dir}}/lib/gen

# Analisa Flutter admin
analyze-admin:
    cd {{admin_dir}} && {{flutter_bin}} analyze

# Analisa Flutter app
analyze-app:
    cd {{app_dir}} && {{flutter_bin}} analyze

# Testes Flutter admin
test-admin:
    cd {{admin_dir}} && {{flutter_bin}} test

# Testes Flutter app
test-app:
    cd {{app_dir}} && {{flutter_bin}} test

# Roda servidor em modo dev
serve:
    cargo run -p flustra-server -- serve

# Migra dados do SQLite para PostgreSQL
db-migrate from to:
    cargo run -p flustra-server -- db migrate --from {{from}} --to {{to}}

# Status do cluster
cluster-health:
    cargo run -p flustra-server -- cluster-health

# Build completo (Rust + Flutter)
all:
    {{rust_build}}
    cd {{admin_dir}} && {{flutter_bin}} build web
    cd {{app_dir}} && {{flutter_bin}} build linux

# Limpa artefatos de build
clean:
    cargo clean
    -cd {{admin_dir}} && {{flutter_bin}} clean
    -cd {{app_dir}} && {{flutter_bin}} clean
