# Validador de Produtos HP 🕵️‍♂️📦

Aplicativo em Flutter desenvolvido para validar produtos HP anunciados no Mercado Livre. Basta fornecer o link do anúncio, e o app mostrará, de forma visual e intuitiva, a chance de o produto ser original ou falso com base em uma análise realizada por uma API especializada.

---

## 📚 Índice

- [Visão Geral](#visão-geral)
- [Recursos Principais](#recursos-principais)
- [Tecnologias](#tecnologias)
- [Pré-requisitos](#pré-requisitos)
- [Instalação](#instalação)
- [Configuração de Ativos](#configuração-de-ativos)
- [Estrutura do Projeto](#estrutura-do-projeto)
- [Como Usar](#como-usar)
- [Back-end](#back-end)
- [Autores](#autores)
- [Licença](#licença)

---

## 📝 Visão Geral

Este aplicativo apresenta uma interface elegante e moderna, respeitando a identidade visual da HP. Ao inserir um link de produto do Mercado Livre, o app envia uma requisição HTTP à API, obtendo:

- `` – Probabilidade do produto ser original (0% a 100%).
- `` – Uma descrição detalhada sobre os critérios utilizados na análise.

Os resultados são apresentados em três cartões:

- 🔗 Entrada do Link
- 📖 Dados do produto
- 📊 Gráfico e Texto explicativo
---

## ✨ Recursos Principais

- ✅ Validação automática de URL do Mercado Livre
- 🌐 Integração direta com API via HTTP
- 📈 Gráfico de pizza interativo com animações utilizando **fl\_chart**
- 🎨 Design modular, com paleta de cores e tipografia inspiradas na identidade visual da HP

---

## ⚙️ Tecnologias

- **Flutter 3.10**
- **Dart 3.10**
- Pacotes essenciais: `http`, `fl_chart`, entre outros no `pubspec.yaml`.

---

## 📋 Pré-requisitos

- Flutter SDK 3.10
- Dart SDK 3.10
- IDE recomendado: Android Studio, VS Code ou Xcode

---

## 🛠️ Instalação

Siga estes passos para rodar o projeto localmente:

```bash
git clone https://github.com/seu-usuario/projeto_hp.git
cd projeto_hp
flutter pub get
flutter run
```

---

## 📁 Configuração de Ativos

1. Coloque a logo da HP no diretório:

   ```
   assets/hp_logo_branco.png
   ```

2. Configure o arquivo `pubspec.yaml`:

   ```yaml
   flutter:
     assets:
       - assets/hp_logo_branco.png
   ```

---

## 💻 Estrutura do Projeto

```
lib/
├── core/
│   └── routes/
│       └── app_router.dart
├── features/
│   └── product_validation/
│       ├── data/
│       │   ├── datasources/
│       │   ├── models/
│       │   └── repositories/
│       ├── domain/
│       │   ├── entities/
│       │   ├── repositories/
│       │   └── usecases/
│       └── presentation/
│           └── pages/
│               └── validator_page.dart
└── main.dart
```

---

## 🚦 Como Usar

1. Insira o link do produto do Mercado Livre.
2. Toque no botão **"Analisar Produto"**.
3. Visualize o resultado no gráfico animado e leia a explicação detalhada.

---

## 🔗 Back-end

O serviço que realiza a análise está disponível neste repositório: [Estrutura\_Dados\_Com\_LLM](https://github.com/DaniloRamalhoSilva/Estrutura_Dados_Com_LLM).

---

## 👨‍🏫 Autores

- Danilo Ramalho Silva | RM: 555183
- Israel Dalcin Alves Diniz | RM: 554668
- João Vitor Pires da Silva | RM: 556213
- Matheus Hungaro | RM: 555677
- Pablo Menezes Barreto | RM: 556389
- Tiago Toshio Kumagai Gibo | RM: 556984

---

## 📜 Licença

Projeto licenciado sob a **MIT License**. Consulte o arquivo `LICENSE` para mais detalhes.

