(load "~/.sbclrc")

(sb-ext:save-lisp-and-die "bin/udl"
                          :executable t
                          :save-runtime-options t
                          :toplevel 'udl:main)
