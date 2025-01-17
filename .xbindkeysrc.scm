;;   This configuration is guile based.
;;   http://www.gnu.org/software/guile/guile.html
;;   This config script is supposed to live in the homedirectory.
;;   Awesome script created by Zero Angel
;;   This couldnt have been possible without seeing Vee Lee's configuration file
;;   You'll need xdotool and xbindkeys with -guile support compiled for this to work (The Ubuntu xbindkeys will have this support by default).
;;   It assigns keybindings to the scroll wheel  on the fly when mouse modifier keys are pressed. Useful for mice with lots of buttons!
;;   v1.0 -- Shoulder button + scrollwheel bindings
;;   v1.1 -- Fixes some 'stuckness' problems with the modifer keys (ctrl, alt, shift)
;;   v1.2 -- Can trigger events properly if the modifier button is simply pressed and released by itself. Forcefully clears modifier keys when the shoulder buttons are depressed.
;;	 * Found on: https://www.linuxquestions.org/questions/linux-desktop-74/%5Bxbindkeys%5D-advanced-mouse-binds-4175428297/#post4785538


(define actionperformed 0)

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
;; Set Action Performed state back to 0
(set! actionperformed 0)
;; Forcefully release all modifier keys!
(run-command "xdotool keyup ctrl keyup alt keyup shift keyup super&")

(first-binding)
(grab-all-keys))


(define (b9-second-binding)
"Front Shoulder Button Extra Functions"
(ungrab-all-keys)
(remove-all-keys)

;; Scroll Up
(xbindkey-function '("b:4")
                (lambda ()
;; Emulate Ctrl+Alt+Up (Workspace Up)
                (run-command "xdotool keydown ctrl keydown alt key Up keyup ctrl keyup alt&")
		(set! actionperformed 1)
))

;; Scroll Down
(xbindkey-function '("b:5")
                (lambda ()
;; Emulate Ctrl+Alt+Down (Workspace Down)
                (run-command "xdotool keydown ctrl keydown alt key Down keyup ctrl keyup alt&")
		(set! actionperformed 1)
))

(xbindkey-function '(release "b:9") (lambda ()
;; Perform Action if Button 8 is pressed and released by itself
(if (= actionperformed 0) (run-command "xdotool key Super&"))
(reset-first-binding)))
(grab-all-keys))

(define (b8-second-binding)
"Rear Shoulder Button Extra Functions"
(ungrab-all-keys)
(remove-all-keys)

;; Scroll Up
(xbindkey-function '("b:4")
                (lambda ()
;; Emulate Alt+Shift+Tab (previous window)
                (run-command "xdotool keydown alt keydown shift key Tab keyup alt keyup shift")
		(set! actionperformed 1)
))

;; Scroll Down
(xbindkey-function '("b:5")
                (lambda ()
;; Emulate Alt+Tab (next window)
                (run-command "xdotool keydown alt key Tab keyup alt")
		(set! actionperformed 1)
))

(xbindkey-function '(release "b:8") (lambda ()
;; Perform Action if Button 8 is pressed and released by itself
     (if (= actionperformed 0) (run-command "zenity --info --title=hi --text=Button8ReleaseEvent &"))
(reset-first-binding)
))
(grab-all-keys)
)

;; (debug)
(first-binding)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; End of xbindkeys configuration ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;