;; global-replace.el -- replace commands for emacs acting on several open buffers

;; Copyright (C) 2013 Sebastian Riese

;; This file is distributed under the terms of the GNU General Public
;; License as published by the Free Software Foundation, either
;; version 3 of the license, or (at your option) any later version.

;; It is distributed in the hope that it will be useful, but WITHOUT
;; ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
;; or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
;; License for more details.

;; You should have received a copy of the GNU General Public License
;; along with global-replace.el.  If not, see
;; <http://www.gnu.org/licenses/>.

;; Commentary:

;; Provide the ability to do replace operations on all open buffers,
;; that are not read-only and point to a file.

;; This file relies on the interals of replace.el from the Emacs core and
;; was written against GNU Emacs 23.3.

;; Code:

(defmacro global-replace-for-buffer-query (&rest body)
  `(save-window-excursion
     (dolist (buf (buffer-list))
       (set-buffer buf)
       (if (and (not (null buffer-file-name))
                (not buffer-read-only))
           (progn (switch-to-buffer buf)
                  (save-excursion
                    (goto-char (point-min))
                    ,@body))))))

(defmacro global-replace-for-buffer (&rest body)
  `(save-excursion
     (dolist (buf (buffer-list))
       (set-buffer buf)
       (if (and (not (null buffer-file-name))
                (not buffer-read-only))
           (save-excursion
             (goto-char (point-min))
             ,@body)))))


(defun global-query-replace (from-string to-string &optional delimited)
  "Iterate over all writable buffers which point to a file. In each of
them do `query-replace'"
  (interactive
     (let ((common
	  (query-replace-read-args
	   (concat "Replace"
		   (if current-prefix-arg " word" "")
		   " string"
		   (if (and transient-mark-mode mark-active) " in region" ""))
	   nil)))
       (list (nth 0 common) (nth 1 common) (nth 2 common))))

  (global-replace-for-buffer-query
    (perform-replace from-string to-string t nil delimited)))


(defun global-replace-string (from-string to-string &optional delimited)
  "Iterate over all writable buffers which point to a file. In each of the
 do `replace-string'"
  (interactive
     (let ((common
	  (query-replace-read-args
	   (concat "Replace"
		   (if current-prefix-arg " word" "")
		   " string")
	   nil)))
       (list (nth 0 common) (nth 1 common) (nth 2 common))))

  (global-replace-for-buffer
    (perform-replace from-string to-string nil nil delimited)))


(defun global-query-replace-regexp (from-string to-string &optional delimited)
  "Iterate over all writable buffers which point to a file. In each of
them do `query-replace-regexp'"
  (interactive
     (let ((common
	  (query-replace-read-args
	   (concat "Replace"
		   (if current-prefix-arg " word" "")
		   " regexp")
	   nil)))
     (list (nth 0 common) (nth 1 common) (nth 2 common))))

  (global-replace-for-buffer-query
    (perform-replace from-string to-string t t delimited)))

(defun global-replace-regexp (from-string to-string &optional delimited)
  "Iterate over all writable buffers which point to a file. In each of the
 do `replace-regexp'"
  (interactive
     (let ((common
	  (query-replace-read-args
	   (concat "Replace"
		   (if current-prefix-arg " word" "")
		   " regexp")
	   nil)))
     (list (nth 0 common) (nth 1 common) (nth 2 common))))

  (global-replace-for-buffer
    (perform-replace from-string to-string nil t delimited)))
