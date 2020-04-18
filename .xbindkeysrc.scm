;;   This configuration is guile based.
;;   http://www.gnu.org/software/guile/guile.html
;;   This config script us supposed to live in the homedirectory.
;;   This was a not so quick but probably yet dirty hack by Zero Angel
;;   You'll need xdotool and xbindkeys with -guile support compiled for this to work (The Ubuntu xbindkeys will have this support by default).
;;   This is heavily based on Vee Lee's configuration file
;;   It assigns keybindings to the scroll wheel  on the fly when mouse modifier keys are pressed. Useful for mice with lots of buttons!
;;	 * Found on: https://www.linuxquestions.org/questions/linux-desktop-74/%5Bxbindkeys%5D-advanced-mouse-binds-4175428297/#post4785538

(define (first-binding)
"First binding"
;; Logitech Front Shoulder Button
(xbindkey-function '("b:9") b9-second-binding)
;; Logitech Rear Shoulder Button
(xbindkey-function '("b:8") b8-second-binding)
)


(define (reset-first-binding)
"reset first binding"
(ungrab-all-keys)
(remove-all-keys)
(first-binding)
(grab-all-keys))


(define (b9-second-binding)
"Front Shoulder Button Extra Functions"
(ungrab-all-keys)
(remove-all-keys)

;; Scroll Up
(xbindkey-function '("b:4")
                (lambda ()
                   (run-command "xdotool key --clearmodifiers ctrl+alt+Up&")
))

;; Scroll Down
(xbindkey-function '("b:5")
                (lambda ()
                  (run-command "xdotool key --clearmodifiers ctrl+alt+Down&")
))

(xbindkey-function '(release "b:9") (lambda ()
 (run-command "echo -e 'Placeholder for button release command' &")
(reset-first-binding)))
(grab-all-keys))

(define (b8-second-binding)
"Rear Shoulder Button Extra Functions"
(ungrab-all-keys)
(remove-all-keys)

;; Scroll Up
(xbindkey-function '("b:4")
                (lambda ()
                   (run-command "xdotool key --clearmodifiers alt+shift+tab&")
))

;; Scroll Down
(xbindkey-function '("b:5")
                (lambda ()
                  (run-command "xdotool key --clearmodifiers alt+tab&")
))

(xbindkey-function '(release "b:8") (lambda ()
 (run-command "echo -e 'Placeholder for button release command'&")
(reset-first-binding)))
(grab-all-keys))

;; (define (scroll-apps-binding)
;; "scroll-apps-binding"
;; (ungrab-all-keys)
;; (remove-all-keys)
;; (xbindkey-function '("b:4")(run-command "echo -e 'KeyStrPress Tab\nKeyStrRelease Tab' | xmacroplay :0 &"))
;; (xbindkey-function '("b:5")(run-command "echo -e 'KeyStrPress Shift_L\nKeyStrPress Tab\nKeyStrRelease Tab\nKeyStrRelease Shift_L' | xmacroplay :0 &"))
;; (xbindkey-function '("b:1") reset-first-binding)
;; (grab-all-keys))
;; (debug)
(grab-all-keys)
(first-binding)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; End of xbindkeys configuration ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;