# udl-lisp

### Install quicklisp to install packages:
https://www.quicklisp.org/beta/

### Install rove for testing:
```
(ql:quickload :rove)
```

### Install cl-project to generate projects:
```
(ql:quickload :cl-project)
```

### Load array-operations library
(ql:quickload :array-operations)


### Add to ~/.sbclrc:
```
(ql:quickload 'cl-project)
(ql:quickload 'magicl)
(pushnew "~/dev/ml/udl-lisp/udl/" asdf:*central-registry* :test #'equal)
(ql:quickload 'udl)
```

### Generate project:
```
(cl-project:make-project #P"~/dev/ml/udl-lisp/udl/")
```

### Build executable:
```
./build.sh
```

### Run tests:
```
(asdf:test-system :udl)
```

### Include package:
```
(in-package #:udl)
```
