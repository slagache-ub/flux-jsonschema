# flux-jsonschema

Projet librement inspiré de [yannh/kubernetes-json-schema](https://github.com/yannh/kubernetes-json-schema)

Le but est d'obtenir des json-schemas à jour pour valider les ressources issues de CRDs flux. Ces schémas peuvent par exemple être utilisés avec l'extension [YAML](https://marketplace.visualstudio.com/items?itemName=redhat.vscode-yaml) pour VSCode afin d'avoir directement dans l'IDE du linting, de l'autocomplétion et de la doc (cf ci-dessous).

## Comment utiliser les jsonschemas

Le repo étant privé, à moins de pouvoir set up une méthode d'authentification avec l'outil utilisé, il faut cloner le repo localement. Pensez à adapter les exemples qui suivent avec le chemin où vous avez cloné le repo.

### Extension YAML pour VSCode

L'extension [YAML](https://marketplace.visualstudio.com/items?itemName=redhat.vscode-yaml) pour VSCode (développée par RedHat) permet de valider la syntaxe des fichiers YAML dans VSCode. Il est possible d'ajouter des schemas de validation pour des utilisations spécifiques (Kubernetes, Gitlab CICD, etc.). Chaque schema est associé à un glob pattern et s'appliquera aux fichiers concernés.

Pour cela, il faut modifier le fichier `~/.config/Code/User/settings.json` (pour Ubuntu) et y ajouter par exemple les lignes suivantes :

```json
"yaml.schemas": {
    "file:///home/ubuntu/flux-jsonschema/helm-controller/v1.4.5/all.json": [
        "/home/ubuntu/flux2/**/*.yaml"
    ],
    "file:///home/ubuntu/flux-jsonschema/image-automation-controller/v1.0.4/all.json": [
        "/home/ubuntu/flux2/**/*.yaml"
    ],
    "file:///home/ubuntu/flux-jsonschema/image-reflector-controller/v1.0.4/all.json": [
        "/home/ubuntu/flux2/**/*.yaml"
    ],
    "file:///home/ubuntu/flux-jsonschema/kustomize-controller/v1.7.3/all.json": [
        "/home/ubuntu/flux2/**/*.yaml"
    ],
    "file:///home/ubuntu/flux-jsonschema/notification-controller/v1.7.5/all.json": [
        "/home/ubuntu/flux2/**/*.yaml"
    ],
    "file:///home/ubuntu/flux-jsonschema/source-controller/v1.7.4/all.json": [
        "/home/ubuntu/flux2/**/*.yaml"
    ],
    "file:///home/ubuntu/flux-jsonschema/source-watcher/v2.0.3/all.json": [
        "/home/ubuntu/flux2/**/*.yaml"
    ]
}
```

Dans cet exemple, tous les fichiers YAML du repo flux2 seront validés via l'extension. Ce faisant, l'utilisateur aura accès directement dans VSCode à :

* Un linter : affichages de vaguelettes rouges si un élément n'est pas conforme (typo dans un champ, mauvais type pour une valeur, etc.)
* De l'autocomplétion : en tapant les première lettres d'un nouveau champ, l'utilisateur voit en un coup d'oeil quels sont les champs supportés par la CRD
* De la documentation : en passant sa souris sur un champ, l'éditeur affiche une pop up qui décrit son utilisation

## Comment ça marche

nightly pipeline -> #TODO