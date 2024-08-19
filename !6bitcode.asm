org 100h
num1 dw 1234h  ; First 16-bit number
num2 dw 5678h  ; Second 16-bit number

start:
    mov ax, num1  ; Load num1 into AX register (16-bit register)
    add ax, num2  ; Add num2 to AX

    ; Store the result in BX so we can convert it to hexadecimal
    mov bx, ax

    ; Convert and print the upper byte (higher 8 bits)
    mov ah, bh   ; Move upper byte of BX to AH
    call convert_to_hex  ; Convert upper nibble to hex
    mov dl, ah   ; Move first character to DL for printing
    mov ah, 02h  ; BIOS interrupt to display character
    int 21h

    mov ah, bh   ; Move upper byte of BX to AH again
    call convert_lower_nibble  ; Convert lower nibble to hex
    mov dl, ah   ; Move second character to DL for printing
    mov ah, 02h  ; BIOS interrupt to display character
    int 21h

    ; Convert and print the lower byte (lower 8 bits)
    mov ah, bl   ; Move lower byte of BX to AH
    call convert_to_hex  ; Convert upper nibble to hex
    mov dl, ah   ; Move third character to DL for printing
    mov ah, 02h  ; BIOS interrupt to display character
    int 21h

    mov ah, bl   ; Move lower byte of BX to AH again
    call convert_lower_nibble  ; Convert lower nibble to hex
    mov dl, ah   ; Move fourth character to DL for printing
    mov ah, 02h  ; BIOS interrupt to display character
    int 21h

    ; End the program
    mov ah, 4Ch  ; Terminate the program
    int 21h

convert_to_hex:
    ; Mask the upper nibble and convert it to a character
    and ah, 0F0h
    shr ah, 4    ; Shift the upper nibble to the lower nibble
    add ah, 30h  ; Convert to ASCII digit
    cmp ah, 39h  ; Compare if the value is less than or equal to '9'
    jle skip_conversion
    add ah, 7    ; Convert to ASCII letter (A-F)

skip_conversion:
    ret           ; Return from the procedure

convert_lower_nibble:
    ; Mask the lower nibble and convert it to a character
    and ah, 0Fh  ; Mask upper nibble, keep lower nibble
    add ah, 30h  ; Convert to ASCII digit
    cmp ah, 39h  ; Compare if the value is less than or equal to '9'
    jle skip_lower_conversion
    add ah, 7    ; Convert to ASCII letter (A-F)

skip_lower_conversion:
    ret           ; Return from the procedure




