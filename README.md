# IPA to S3 Buildkite Plugin

A Buildkite plugin that will push an IPA to S3 and output both a link and a QR code as an annotation for easy download/install.

This plugin requires the presence of the `qrencode` CLI tool, it can be installed for your instance using:

### Ubuntu, Debian, Linux Mint:
```sh
apt install qrencode -y
```

### Red Hat, Fedora, AlmaLinux, Rocky Linux, CentOS:
```sh
dnf install qrencode -y
```

### Arch Linux and Manjro:
```sh
pacman -S qrencode --noconfirm
```

### MacOS:
```sh
brew install qrencode
```

ℹ️ Using this plugin is still possible without the installation of `qrencode`, but you will need to set `generate-qr-code` to `false` in the `pipeline.yaml` (see [opting out of qr generation](https://github.com/mcncl/ipa-to-s3-buildkite-plugin?tab=readme-ov-file#opting-out-of-qr-code-generation))

## Options

These are all the options available to configure this plugin's behaviour.

### Required

#### `title` (string)

The `title` is the title/name of the application IPA being pushed.

#### `bundle-id` (string)

The `bundle-id` is the ID for the IPA bundle.

#### `plist-path` (string)

The `plist-path` is the path for the IPA properties list, in the format "app.plist".

#### `s3-bucket` (string)

The `s3-bucket` is the name of the bucket that the IPA should be pushed to. It is assumed that an authentication method has been used already and the required permissions are available.

## Examples

```yaml
steps:
  - label: "🚀 Push "
    plugins:
      - ipa-to-s3#v1.0.0:
            title: cool-app
            bundle-id: jdc.io.cool-app
            plist-path: app.plist
            s3-bucket: bucket-for-cool-app
```

In the above example, the `ipa-path` will default to `cool-app.ipa`.

### Optional

#### `ipa-path` (string)

The `ipa-path` is the location, including extension, of the IPA in the form `app-name.ipa`.

Default: `[title].ipa`

#### `generate-qr-code` (boolean)

Whether or not a QR code should be posted as a build annotation. If set to `false` then no QR code will be posted as a build annotation.

Whether set to `true` or `false`, a link to download the app will still be posted as a build annotation. Setting to `false` removes the requirement for having `qrencode` available on the machine.

Default: `true`

### Opting out of QR code generation

```yaml
steps:
  - label: "🚀 Push "
    plugins:
      - ipa-to-s3#v1.0.0:
            title: cool-app
            bundle-id: jdc.io.cool-app
            plist-path: app.plist
            s3-bucket: bucket-for-cool-app
            generate-qr-code: false
```

In the above example, no QR code will be generated/posted as a build annotation.

## Specifying an IPA path

```yaml
steps:
  - label: "🚀 Push "
    plugins:
      - ipa-to-s3#v1.0.0:
            title: cool-app
            bundle-id: jdc.io.cool-app
            plist-path: app.plist
            ipa-path: not-a-cool-app.ipa
            s3-bucket: bucket-for-cool-app
```

Where the `ipa-path` doesn't use the `title` it can be set separately. 

## ⚒ Developing

You can use the [bk cli](https://github.com/buildkite/cli) to run the [pipeline](.buildkite/pipeline.yml) locally:

```bash
bk local run
```

## 👩‍💻 Contributing

Your policy on how to contribute to the plugin!

## 📜 License

The package is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
