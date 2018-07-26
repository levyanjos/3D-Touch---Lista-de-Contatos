#  Exemplo de uso do 3D Touch

## Descrição
Aplicativo iOS de demostração de como usar o 3D Touch em um App. O projeto é uma aplicação simples de gerenciamento de contatos e nela foi usada Quick Actions (Dinâmicas e Estáticas) e "Peek and Pop". O código está comentado, explicando os passos e métodos, nas partes necessárias para usar as funcionalidades.


## Quick Actions

São uma forma de usar ações específicas de um App direto da *home screen*. Para ativa-las só precisa colocar um pouco de pressão no ícone. Existem dois modos de adicioná-las, de modo estático, ou seja, sempre estarão presentes, e de modo dinâmico, nesse modo o desenvolvedor pode configurar quais devem aparecer.

### Quick Actions Estático

O primeiro passo para criar um Quick Actions Estático é criar dentro do arquivo `info.plist` uma nova linha de tipo array e com o nome `UIApplicationShortcutItems`. Dentro desse array é possível fazer algumas configurações como tipo, título, icone e subtítulo.

- A chave `UIApplicationShortcutItemType` é responsável por dizer o tipo do seu quick action, nela basicamente é definido uma *id* para conseguir acessá-la na aplicação.
- A chave `UIApplicationShortcutItemTitle` é onde define o título da quick action que vai ser exibido na home.
- A chave `UIApplicationShortcutItemIcon` é onde pode-se escolher um ícone para a action. Já existem vários disponíveis ([Referência](https://developer.apple.com/documentation/uikit/uiapplicationshortcuticon/icontype))

![info.plist](https://raw.githubusercontent.com/LevyCristian/3D-Touch---Lista-de-Contatos/master/screem%20form%20info-plist.png)

### Quick Actions Dinâmico

Nesse modo, é preciso criar um novo objeto da classe `UIApplicationShortcutItem`, e adicionar ao *array* dos shortcut items da aplicação. As propriedades são as mesmas da versão estática, basicamente é um modo de fazer programaticamente.

Código de exemplo (`ViewController.swift`, ln 60)
````swift
  let shortcutItem = UIApplicationShortcutItem(
      type: "ActionType",
      localizedTitle: "Action Title",
      localizedSubtitle: "Action Subtitle",
      icon: UIApplicationShortcutIcon.init(type: .contact),
      userInfo: nil)

  UIApplication.shared.shortcutItems = [shortcutItem]
````

### Peek and Pop

É outra forma de interação com o seu App respondendo a pressão. O processo ocorre em três partes:
1. Ao pressionar, é indicado ao usuário que o *preview* está disponível. Ao redor do elemento que está sendo pressionado fica desfocado.
2. Ao pressionar um pouco mais, aparece um *preview* da *view*, comumente é o conteúdo da *view*. Se deixar de pressionar, retorna ao estado inicial.
    - Se o usuário fizer um *swipe* para cima, são mostradas as *Peek quick actions*. Basicamente são como as *quick actions* na *home screen*.
3. Entra na *view* mostrada no *preview*, chamado de *Pop*.

Para habilitar a função é preciso registrar a view que deve ser possível o *preview*.
````swift
  registerForPreviewing(with: self, sourceView: self.table)
````
O primeiro argumento é a classe que implementa o protocolo `UIViewControllerPreviewingDelegate`, que disponibilizam métodos que controlam o funcionamento do efeito.
````swift
previewingContext(_:viewControllerForLocation:)
````
Esse controla quando o usuário pressiona a *source view*, tudo relacionada ao *preview* e a parte do *Peek* fica aqui. Além disso cria o efeito de desfoque para indicar disponibilidade do *preview*.

````swift
previewingContext(_:commit:)
````
Esse é chamado para preparar a *view* que será apresentada na etapa do *Pop*.

Toda essa parte está exemplificada e comentada no arquivo `ViewController.swift` a partir da linha 128.

#### Peek Quick Actions

Nesse caso, tudo deve ser feito na view que será apresentada após o *peek* (no caso do exemplo na `ContatoViewController.swift`). Basicamente é necessário criar objetos da classe `UIPreviewActionItem`, e defini-las na propriedade padrão `UIViewController.previewActionItems`. Na aplicação de exemplo, essa parte está demostrada no arquivo `ContatoViewController.swift`, a partir da linha 22.

## Autores

### João Levy Cristian dos Anjos
### Matheus Oliveira Costa

## Requirements

### Build

iOS 11.3 SDK, Xcode 9.3.

### Runtime

iOS 11.3 ou posterior.
