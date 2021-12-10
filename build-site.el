(setq project-path (file-name-directory (or (buffer-file-name) load-file-name))
      backup-directory-alist `(("." . ,(concat project-path ".backups")))
      publish-project-path (concat project-path "docs/")
      package-user-dir (concat project-path ".packages"))

(require 'package)
(package-initialize)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))
(package-refresh-contents)

(package-install 'rust-mode :dont-select)
(package-install 'htmlize :dont-select)

(require 'org)
(require 'sh-script)
(require 'rust-mode)
(require 'htmlize)
(require 'ox)
(require 'ox-html)
(require 'ox-publish)

(setq org-html-validation-link nil
      org-html-html5-fancy t
      org-html-doctype "html5"
      org-html-htmlize-output-type 'css

      org-publish-project-alist
      `(("static"
         :base-directory ,project-path
         :base-extension "css\\|png\\|jpe?g\\|svg"
         :publishing-directory ,publish-project-path
         :publishing-function org-publish-attachment
         :exclude "docs"
         :recursive t)

        ("org"
         :base-directory ,project-path
         :publishing-directory ,publish-project-path
         :publishing-function org-html-publish-to-html
         :base-extension "org"
         :exclude "docs"
         :time-stamp-file nil)

        ("site" :components ("static" "org"))))

(org-publish-all :force)
