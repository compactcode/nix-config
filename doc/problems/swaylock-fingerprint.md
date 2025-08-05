# Swaylock Fingerprint

When unlocking the system with swaylock I can't use password login.


## Why `swaylock` (and polkit) still ignores your password

* `pam_fprintd.so` is first + `sufficient` in the PAM stack, so PAM stops at the fingerprint scan.
* Keyboard input never reaches `pam_unix.so`, which is the module that checks your password.

### Fix – put the password module first
Use this PAM stack for **both** `swaylock` and `polkit-1`:

```pam
# Try password first
auth    sufficient  pam_unix.so    try_first_pass nullok
# Fallback to fingerprint (short timeout)
auth    sufficient  pam_fprintd.so  max-tries=1 timeout=5
# Anything else is a failure
auth    required    pam_deny.so

# Standard account/session includes
account include login
session include login

## Notes

https://unix.stackexchange.com/questions/615555/pam-fingerprint-login-blocks-password/742393#742393
