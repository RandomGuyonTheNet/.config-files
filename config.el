(add-to-list 'default-frame-alist
             '(ns-transparent-titlebar . t))
(add-to-list 'default-frame-alist
             '(ns-appearance . light))

(global-auto-revert-mode t)

(add-hook! 'org-mode-hook #'+org-pretty-mode #'mixed-pitch-mode)


(add-hook! 'org-mode-hook (company-mode -1))
(add-hook! 'org-capture-mode-hook (company-mode -1))

(setq baby-blue '("#d2ecff" "#d2ecff" "brightblue"))




(add-hook! reason-mode
  (add-hook 'before-save-hook #'refmt-before-save nil t))

(use-package! org-super-agenda
  :after org-agenda
  :init
  (setq org-super-agenda-groups
       '((:name "Today"
                :time-grid
                :scheduled today)
         (:name "Due today"
                :deadline today)
         (:name "Important"
                :priority "A")
         (:name "Overdue"
                :deadline past)
         (:name "Due soon"
                :deadline future)
         (:name "Big Outcomes"
                :tag "bo")))
  :config
  (org-super-agenda-mode))
(add-hook!
  js2-mode 'prettier-js-mode
  (add-hook 'before-save-hook #'refmt-before-save nil t))

(map! :desc "Create Sparse Tree" :ne "SPC / s" #'org-sparse-tree)
(map! :desc "Create Spars Tree for Tags" :ne "SPC / t" #'org-tags-sparse-tree)


(map! :ne "M-/" #'comment-or-uncomment-region)
(map! :ne "SPC / r" #'deadgrep)
(map! :ne "SPC n b" #'org-brain-visualize)

(use-package! org-fancy-priorities
  :ensure t
  :hook (org-mode org-fancy-priorities-mode)
  :config
  (setq org-fancy-priorities-list '("⚡" "⬆" "⬇" "☕")))

;; (def-package! parinfer ; to configure it
;;   :bind (("C-," . parinfer-toggle-mode)
;;          ("<tab>" . parinfer-smart-tab:dwim-right)
;;          ("S-<tab>" . parinfer-smart-tab:dwim-left))
;;   :hook ((clojure-mode emacs-lisp-mode common-lisp-mode lisp-mode) . parinfer-mode)
;;   :config (setq parinfer-extensions '(defaults pretty-parens evil paredit)))

(defun make-youtube-linK (youtube_id)
  (browse-url (concat "https://www.youtube.com/embed/" youtube_id)))

(after! org
  (require 'org-tempo)
  (map! :map org-mode-map
        :n "M-j" #'org-metadown
        :n "M-k" #'org-metaup)

  (setq org-fancy-priorities-list '("⚡" "⬆" "⬇" "☕")
        org-agenda-skip-scheduled-if-done t
        org-priority-faces '((65 :foreground "#e45649")
                             (66 :foreground "#da8548")
                             (67 :foreground "#0098dud"))
        org-directory "~/Notes/"
        org-bullets-bullet-list '("﮸﮸"﮸܀)
        org-tags-column -80
        org-todo-keywords '((sequence "TODO(t)" "INPROGRESS(i)" "WAITING(w)" "|" "DONE(d)" "CANCELLED(c)"))
        org-todo-keyword-faces
        '(("TODO" :foreground "#7c7c75" :weight normal :underline t)
          ("WAITING" :foreground "#9f7efe" :weight normal :underline t)
          ("INPROGRESS" :foreground "#0098dd" :weight normal :underline t)
          ("DONE" :foreground "#50a14f" :weight normal :underline t)
          ("CANCELLED" :foreground "#ff6480" :weight normal :underline t))
        org-agenda-files (list "~/Notes/"))

  (org-add-link-type "yt" "make-youtube-link")

  (set-face-attribute 'org-link nil
                      :weight 'normal
                      :background nil)
  (set-face-attribute 'org-code nil
                      :foreground "#a9a1e1"
                      :background nil)
  (set-face-attribute 'org-date nil
                      :foreground "#5B6268"
                      :background nil)
  (set-face-attribute 'org-level-1 nil
                      :foreground "steelblue2"
                      :background nil
                      :height 1.2
                      :weight 'normal)
  (set-face-attribute 'org-level-2 nil
                      :foreground "slategray2"
                      :background nil
                      :height 1.0
                      :weight 'normal)
  (set-face-attribute 'org-level-3 nil
                      :foreground "SkyBlue2"
                      :background nil
                      :height 1.0
                      :weight 'normal)
  (set-face-attribute 'org-level-4 nil
                      :foreground "DodgerBlue2"
                      :background nil
                      :height 1.0
                      :weight 'normal)
  (set-face-attribute 'org-level-5 nil
                      :weight 'normal)
  (set-face-attribute 'org-level-6 nil
                      :weight 'normal)
  (set-face-attribute 'org-document-title nil
                      :foreground "SlateGray1"
                      :background nil
                      :height 1.75
                      :weight 'bold))
(after! ruby
  (add-to-list 'hs-special-modes-alist
               `(ruby-mode
                 ,(rx (or "def" "class" "module" "do" "{" "[")) ; Block start
                 ,(rx (or "}" "]" "end"))                       ; Block end
                 ,(rx (or "#" "=begin"))                        ; Comment start
                 ruby-forward-sexp nil)))

(after! web-mode
  (add-to-list 'auto-mode-alist '("\\.njk\\'" . web-mode)))

(defun +data-hideshow-forward-sexp (arg)
  (let ((start (current-indentation)))
    (forward-line)
    (unless (= start (current-indentation))
      (require 'evil-indent-plus)
      (let ((range (evil-indent-plus--same-indent-range)))
        (goto-char (cadr range))
        (end-of-line)))))

(add-to-list 'hs-special-modes-alist '(yaml-mode "\\s-*\\_<\\(?:[^:]+\\)\\_>" "" "#" +data-hideshow-forward-sexp nil))

(remove-hook 'enh-ruby-mode-hook #'+ruby|init-robe)

(setq +magit-hub-features t)

(set-popup-rule! "^\\*Org Agenda" :side 'bottom :size 0.90 :select t :ttl nil)
(set-popup-rule! "^CAPTURE.*\\.org$" :side 'bottom :size 0.90 :select t :ttl nil)
(set-popup-rule! "^\\*org-brain" :side 'right :size 1.00 :select t :ttl nil)


