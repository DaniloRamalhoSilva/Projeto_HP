
# Validador de Produto HP

Um aplicativo Flutter desenvolvido para a Hewlett-Packard (HP) que recebe um link do Mercado Livre, envia para uma API de análise e exibe os resultados em um gráfico, indicando a porcentagem de chance do produto ser falso e uma explicação detalhada.

---

## Índice

- [Visão Geral](#vis%C3%A3o-geral)  
- [Recursos](#recursos)  
- [Pré-requisitos](#pr%C3%A9-requisitos)  
- [Instalação](#instala%C3%A7%C3%A3o)  
- [Configuração de Ativos](#configura%C3%A7%C3%A3o-de-ativos)  
- [Estrutura do Projeto](#estrutura-do-projeto)  
- [Uso](#uso)  
- [Licença](#licen%C3%A7a)  

---

## Visão Geral

Este projeto tem como objetivo criar uma interface amigável e moderna, seguindo a identidade visual da HP, para validar produtos anunciados no Mercado Livre. Ao inserir um link de produto, o aplicativo faz uma chamada a uma API que retorna:

- **`porcentagem_falso`**: número entre 0 e 100 que indica a chance do produto ser falso.  
- **`explicacao`**: texto que descreve os critérios usados na análise.

Os resultados são apresentados em dois cartões:

1. **Entrada do Link**: campo de URL e botão de análise.  
2. **Resultado da Análise**: gráfico de pizza mostrando a porcentagem e texto explicativo.

---

## Recursos

- Validação de URL do Mercado Livre antes de enviar para análise.  
- Chamada HTTP para API de análise.  
- Gráfico de pizza personalizado com animação usando **fl_chart**.  
- Layout modular em cartões, seguindo cores e tipografia HP.  

---

## Pré-requisitos

- Flutter SDK **v3.10.0**  
- Dart SDK **v3.10.0**  
- Ambiente de desenvolvimento configurado (Android Studio, VS Code, Xcode, ou IDE de sua preferência)  

---

## Instalação

1. Clone este repositório:
   ```bash
   git clone https://github.com/seu-usuario/projeto_hp.git
   cd projeto_hp
   ```
2. Baixe as dependências:
   ```bash
   flutter pub get
   ```
3. Execute o aplicativo:
   ```bash
   flutter run
   ```

---

## Configuração de Ativos

- Inclua a logo da HP em `assets/hp_logo_branco.png`.  
- No `pubspec.yaml`, adicione:
  ```yaml
  flutter:
    assets:
      - assets/hp_logo_branco.png
  ```

---

## Estrutura do Projeto

```
front_end/
├── assets/
│   └── hp_logo_branco.png
├── lib/
│   ├── main.dart                # Ponto de entrada do app
│   ├── pages/
│   │   └── validador_page.dart  # Tela principal
│   └── widgets/                 # Componentes reutilizáveis (cards, botões)
├── pubspec.yaml
└── README.md
```

---

## Uso

1. Cole o link do Mercado Livre.  
2. Clique em **Analisar Produto**.  
3. Veja a porcentagem no centro do gráfico e leia a explicação abaixo.  

---

## Licença

Este projeto está licenciado sob a **MIT License**. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.
