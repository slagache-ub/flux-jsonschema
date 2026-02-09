# flux-jsonschema

Project inspired by [yannh/kubernetes-json-schema](https://github.com/yannh/kubernetes-json-schema)

The goal is to provide up-to-date json-schemas in order to validate FluxCD custom resources. These schemas can be used for instance with VSCode [YAML](https://marketplace.visualstudio.com/items?itemName=redhat.vscode-yaml) extension in order to get linting, autocompletion and documentation directly within the editor (see below).

## How to use the json schemas

Multiple tools can digest the schemas for validation within a CI pipeline, or inside an IDE for instance. Below are some examples.

### VSCode YAML extension

VSCode [YAML](https://marketplace.visualstudio.com/items?itemName=redhat.vscode-yaml) extension (developed by RedHat) enables YAML files' validation within VSCode. Users can provide schemas for specific tools (Kubernetes, Gitlab CICD, etc.). Each schema is associated with a glob pattern and will be applied to the matching files.

For this, the `settings.json` file needs to be edited (`~/.config/Code/User/settings.json` for Ubuntu users). Here is an example :

```json
"yaml.schemas": {
    "https://raw.githubusercontent.com/slagache-ub/flux-jsonschema/refs/heads/master/helm-controller/v1.4.5/all.json": [
        "/home/ubuntu/flux2/**/*.yaml"
    ],
    "https://raw.githubusercontent.com/slagache-ub/flux-jsonschema/refs/heads/master/image-automation-controller/v1.0.4/all.json": [
        "/home/ubuntu/flux2/**/*.yaml"
    ],
    "https://raw.githubusercontent.com/slagache-ub/flux-jsonschema/refs/heads/master/image-reflector-controller/v1.0.4/all.json": [
        "/home/ubuntu/flux2/**/*.yaml"
    ],
    "https://raw.githubusercontent.com/slagache-ub/flux-jsonschema/refs/heads/master/kustomize-controller/v1.7.3/all.json": [
        "/home/ubuntu/flux2/**/*.yaml"
    ],
    "https://raw.githubusercontent.com/slagache-ub/flux-jsonschema/refs/heads/master/notification-controller/v1.7.5/all.json": [
        "/home/ubuntu/flux2/**/*.yaml"
    ],
    "https://raw.githubusercontent.com/slagache-ub/flux-jsonschema/refs/heads/master/source-controller/v1.7.4/all.json": [
        "/home/ubuntu/flux2/**/*.yaml"
    ],
    "https://raw.githubusercontent.com/slagache-ub/flux-jsonschema/refs/heads/master/source-watcher/v2.0.3/all.json": [
        "/home/ubuntu/flux2/**/*.yaml"
    ]
}
```

With these lines added, every flux2 repo's YAML files will be validated. This way, the user will have access to :

* A linter that visually underlines mistakes (mispelled fields, incorrect value types, etc.)
* Autocompletion : when typing a fields' first letters (or using the shortcut `Ctrl+space`), the user can see at a glance the CRD compliant fields
* Documentation : when hovering a field, the editor shows a pop up describing it

## How it works

### Config

Every CRD that needs to be converted is added to the file `config.yaml`. More precisely, for each resource, the following information is given :

* the CRD's repo url (needed to fetch the corresponding versions)
* the CRD's download link
* a regex to select specific versions

### Nightly pipeline

A Github Action workflow runs every night to fetch new CRDs versions. For every new version, the script `openapi2jsonschema.py` (also from [yannh/kubernetes-json-schema](https://github.com/yannh/kubernetes-json-schema)) downloads and converts the CRD to a json schema. Then the new schemas are commited to the repo.

For the moment, users need to manually adjust the versions of the schemas in their tools (e.g. YAML extension) if they want the latest ones.