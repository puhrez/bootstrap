;;; package --- Michael's .emacs

;;; Commentary:
;; First load up all the packages, require the necessary ones, and configure

;;; Code:

(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(add-to-list 'package-archives
	                  '("elpy" . "http://jorgenschaefer.github.io/packages/"))
(package-initialize)

(defvar prelude-packages
  '(elpy company company-jedi git-gutter org python-django
	 smartparens rainbow-delimiters markdown-mode py-autopep8
	 flycheck yaml-mode ng2-mode web-mode terraform-mode
	 dockerfile-mode ansible ensime auto-complete kotlin-mode
	 nand2tetris rainbow-mode dimmer json-mode highlight-symbol)
  "A list of packages to ensure are installed at launch.")

(defun prelude-packages-installed-p ()
  "Ensure packages are installed."
  (cl-loop for p in prelude-packages
        when (not (package-installed-p p)) do (cl-return nil)
        finally (cl-return t)))

(unless (prelude-packages-installed-p)
  ;; check for new packages (package versions)
  (message "%s" "Emacs Prelude is now refreshing its package database...")
  (package-refresh-contents)
  (message "%s" " done.")
  ;; install the missing packages
  (dolist (p prelude-packages)
    (when (not (package-installed-p p))
      (package-install p))))

(provide 'prelude-packages)

;; package installation
(elpy-enable)

;; package requires
(require 'smartparens-config)
(require 'yaml-mode)
(require 'web-mode)
(require 'flycheck)
(require 'ng2-mode)
(require 'nand2tetris)
(require 'rainbow-delimiters)
(require 'dimmer)
(require 'yasnippet)
(require 'linum)
(require 'highlight-symbol)
(require 'dockerfile-mode)
(require 'python-django)
(require 'py-autopep8)

;; key bindings
(when (fboundp 'windmove-default-keybindings)
    (windmove-default-keybindings))
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
(global-set-key (kbd "TAB") #'company-indent-or-complete-common)
(global-set-key [(control f3)] 'highlight-symbol)
(global-set-key [f3] 'highlight-symbol-next)
(global-set-key [(shift f3)] 'highlight-symbol-prev)
(global-set-key [(meta f3)] 'highlight-symbol-query-replace)
(global-set-key (kbd "C-x j") 'python-django-open-project)

;; global modes
(global-git-gutter-mode)
(global-company-mode)
(global-linum-mode)
(dimmer-mode)
(yas-global-mode 1)
(global-flycheck-mode)


;; hooks
(add-hook 'elpy-mode 'smartparens-mode)
(add-hook 'elpy-mode #'rainbow-delimiters-mode)
(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.kts\\'" . kotlin-mode))
(add-to-list 'auto-mode-alist '("\\.hdl?\\'" . nand2tetris-mode))
(add-to-list 'auto-mode-alist '("Dockerfile\'" . dockerfile-mode))
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
(add-hook 'prog-mode-hook 'smartparens-mode)
(add-hook 'yaml-mode-hook '(lambda () (ansible 1)))

;; misc
(autoload 'markdown-mode "markdown-mode"
  "Major mode for editing Markdown files" t)
(setq web-mode-enable-auto-pairing t)
(setq web-mode-enable-css-colorization t)
(setq web-mode-enable-block-face t)
(setq web-mode-enable-part-face t)
(setq web-mode-enable-comment-keywords t)
(setq web-mode-enable-current-element-highlight t)
(setq web-mode-enable-current-column-highlight t)
(setq company-idle-delay 0.2)
(setq company-minimum-prefix-length 1)
(setq-default fill-column 80)
(setq-default indent-tabs-mode nil)
(setq kotlin-tab-width 4)
(setq linum-format "%4d \u2502 ")
(setq company-tooltip-align-annotations t)
(setq nand2tetris-core-base-dir "~/classes/nand2tetris")
(defvar backup-dir (expand-file-name "~/.emacs.d/backup/"))
(defvar autosave-dir (expand-file-name "~/.emacs.d/autosave/"))
(setq backup-directory-alist (list (cons ".*" backup-dir)))
(setq auto-save-list-file-prefix autosave-dir)
(setq auto-save-file-name-transforms `((".*" ,autosave-dir t)))

(setq python-shell-interpreter "ipython"
      python-shell-interpreter-args "-i --simple-prompt")

(eval-after-load 'company
  '(push 'company-jedi company-backends))

;; aligns annotation to the right hand side
(setq company-tooltip-align-annotations t)
(setq yas-indent-line 'fixed)


;;; .emacs ends here
