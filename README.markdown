# hogeapplication

Docker-composeを使ったCommon Lisp Webアプリケーション([Caveman 2](https://github.com/fukamachi/caveman/))のサンプル

以下のようにして作成した:

```
shell% ros run

* (ql:quickload :caveman2)
* (caveman2:make-project #P"./hogeapplication")

writing ./hogeapplication/hogeapplication.asd
writing ./hogeapplication/hogeapplication-test.asd
writing ./hogeapplication/app.lisp
writing ./hogeapplication/README.markdown
writing ./hogeapplication/.gitignore
writing ./hogeapplication/db/schema.sql
writing ./hogeapplication/src/config.lisp
writing ./hogeapplication/src/db.lisp
writing ./hogeapplication/src/main.lisp
writing ./hogeapplication/src/view.lisp
writing ./hogeapplication/src/web.lisp
writing ./hogeapplication/static/css/main.css
writing ./hogeapplication/t/hogeapplication.lisp
writing ./hogeapplication/templates/index.html
writing ./hogeapplication/templates/_errors/404.html
writing ./hogeapplication/templates/layouts/default.html
*
```

## Usage

0. Clone this repository
0. Follow blog article

## Installation

- `docker-compose build`
  - build image
- `docker-compose run --rm app qlot install`
  - install libraries
- `docker-compose run --rm app qlot bundle`
  - download dependency
- `docker-compose run --rm app qlot exec ros run -l bundle-libs/bundle.lisp -S . -e '(asdf/operate:compile-system :hogeapplication)' -q`
  - compile subsystems
