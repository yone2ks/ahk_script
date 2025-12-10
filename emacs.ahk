;;
;; An AutoHotkey v2 script that provides emacs-like keybinding on Windows
;;
#Requires AutoHotkey v2.0

;; NOTE: Keys that are intentionally *not* remapped to Emacs behavior
;;   - C-c / C-v : Copy / Paste (kept as the application's standard shortcuts)
;;   - C-z       : Undo (kept as the application's standard shortcut)
;;   - C-q, C-t  : Not bound in this script (use the application's default behavior)
;;   - C-Tab     : Prefer app / OS tab switching and similar shortcuts
;;   - Win key   : Prefer OS-level shortcuts
;;
;; In general, any C- / M- style key **not defined in this file**
;; will behave as the application's original shortcut.
;;
SetKeyDelay 0

; turns to be 1 when ctrl-x is pressed
is_pre_x := 0
; turns to be 1 when ctrl-space is pressed
is_pre_spc := 0

; Applications you want to disable emacs-like keybindings
; (Please comment out applications you don't use)
is_target() {
  ;if WinActive("ahk_exe Windsurf.exe") ; Windsurf
  ;  return 1
  return 0
}

delete_char() {
  global is_pre_spc
  Send "{Del}"
  is_pre_spc := 0
}

delete_backward_char() {
  global is_pre_spc
  Send "{BS}"
  is_pre_spc := 0
}

kill_line() {
  global is_pre_spc
  Send "{ShiftDown}{END}{ShiftUp}"
  Sleep 50 ; [ms] this value depends on your environment
  Send "^x"
  is_pre_spc := 0
}

open_line() {
  global is_pre_spc
  Send "{END}{Enter}{Up}"
  is_pre_spc := 0
}

quit() {
  global is_pre_spc
  Send "{Esc}"
  is_pre_spc := 0
}

newline() {
  global is_pre_spc
  Send "{Enter}"
  is_pre_spc := 0
}

indent_for_tab_command() {
  global is_pre_spc
  Send "{Tab}"
  is_pre_spc := 0
}

newline_and_indent() {
  global is_pre_spc
  Send "{Enter}{Tab}"
  is_pre_spc := 0
}

isearch_forward() {
  global is_pre_spc
  Send "^f"
  is_pre_spc := 0
}

isearch_backward() {
  global is_pre_spc
  Send "^f"
  is_pre_spc := 0
}

kill_region() {
  global is_pre_spc
  Send "^x"
  is_pre_spc := 0
}

kill_ring_save() {
  global is_pre_spc
  Send "^c"
  is_pre_spc := 0
}

yank() {
  global is_pre_spc
  Send "^v"
  is_pre_spc := 0
}

undo() {
  global is_pre_spc
  Send "^z"
  is_pre_spc := 0
}

find_file() {
  global is_pre_x
  Send "^o"
  is_pre_x := 0
}

save_buffer() {
  global is_pre_x
  Send "^s"
  is_pre_x := 0
}

kill_emacs() {
  global is_pre_x
  Send "!{F4}"
  is_pre_x := 0
}

move_beginning_of_line() {
  global is_pre_spc
  if is_pre_spc
    Send "+{Home}"
  else
    Send "{Home}"
}

move_end_of_line() {
  global is_pre_spc
  if is_pre_spc
    Send "+{End}"
  else
    Send "{End}"
}

previous_line() {
  global is_pre_spc
  if is_pre_spc
    Send "+{Up}"
  else
    Send "{Up}"
}

next_line() {
  global is_pre_spc
  if is_pre_spc
    Send "+{Down}"
  else
    Send "{Down}"
}

forward_char() {
  global is_pre_spc
  if is_pre_spc
    Send "+{Right}"
  else
    Send "{Right}"
}

backward_char() {
  global is_pre_spc
  if is_pre_spc
    Send "+{Left}"
  else
    Send "{Left}"
}

scroll_up() {
  global is_pre_spc
  if is_pre_spc
    Send "+{PgUp}"
  else
    Send "{PgUp}"
}

scroll_down() {
  global is_pre_spc
  if is_pre_spc
    Send "+{PgDn}"
  else
    Send "{PgDn}"
}

^x::{
  global is_pre_x
  if is_target()
    Send A_ThisHotkey
  else
    is_pre_x := 1
}

^f::{
  global is_pre_x
  if is_target()
    Send A_ThisHotkey
  else {
    if is_pre_x
      find_file()
    else
      forward_char()
  }
}

;;^c::{
;;  global is_pre_x
;;  if is_target()
;;    Send A_ThisHotkey
;;  else {
;;    if is_pre_x
;;      kill_emacs()
;;  }
;;}

^d::{
  if is_target()
    Send A_ThisHotkey
  else
    delete_char()
}

^h::{
  if is_target()
    Send A_ThisHotkey
  else
    delete_backward_char()
}

^k::{
  if is_target()
    Send A_ThisHotkey
  else
    kill_line()
}

;; ^o::{
;;   if is_target()
;;     Send A_ThisHotkey
;;   else
;;     open_line()
;; }

^g::{
  if is_target()
    Send A_ThisHotkey
  else
    quit()
}

;; ^j::{
;;   if is_target()
;;     Send A_ThisHotkey
;;   else
;;     newline_and_indent()
;; }

^m::{
  if is_target()
    Send A_ThisHotkey
  else
    newline()
}

^i::{
  if is_target()
    Send A_ThisHotkey
  else
    indent_for_tab_command()
}

^s::{
  global is_pre_x
  if is_target()
    Send A_ThisHotkey
  else {
    if is_pre_x
      save_buffer()
    else
      isearch_forward()
  }
}

^r::{
  if is_target()
    Send A_ThisHotkey
  else
    isearch_backward()
}

^w::{
  if is_target()
    Send A_ThisHotkey
  else
    kill_region()
}

!w::{
  if is_target()
    Send A_ThisHotkey
  else
    kill_ring_save()
}

^y::{
  if is_target()
    Send A_ThisHotkey
  else
    yank()
}

^/::{
  if is_target()
    Send A_ThisHotkey
  else
    undo()
}

; Ctrl + Space (vk20) toggles selection mode like Emacs' set-mark-command
^vk20::{
  global is_pre_spc
  if is_target()
    Send "{CtrlDown}{Space}{CtrlUp}"
  else {
    if is_pre_spc
      is_pre_spc := 0
    else
      is_pre_spc := 1
  }
}

^@::{
  global is_pre_spc
  if is_target()
    Send A_ThisHotkey
  else {
    if is_pre_spc
      is_pre_spc := 0
    else
      is_pre_spc := 1
  }
}

^a::{
  if is_target()
    Send A_ThisHotkey
  else
    move_beginning_of_line()
}

^e::{
  if is_target()
    Send A_ThisHotkey
  else
    move_end_of_line()
}

^p::{
  if is_target()
    Send A_ThisHotkey
  else
    previous_line()
}

^n::{
  if is_target()
    Send A_ThisHotkey
  else
    next_line()
}

^b::{
  if is_target()
    Send A_ThisHotkey
  else
    backward_char()
}

;;^v::{
;;  if is_target()
;;    Send A_ThisHotkey
;;  else
;;    scroll_down()
;;}

!v::{
  if is_target()
    Send A_ThisHotkey
  else
    scroll_up()
}

^l::{
  if is_target()
    Send A_ThisHotkey
  else
    backward_char()
}