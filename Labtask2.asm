org 100h
num1 db 24h
num2 db 29h
  
start:
   mov al, num1   ;moving number1 value to AL Register
   add al, num2   ;adding number2 value with existing value in AL register
   mov bl,al 
   
   ;to covert upper nibble(4 bits) of AL to a character
   mov ah,al
   and ah,0F0h  ;mask the lower nibble(all lower bits become 0's) 
   shr ah,4     ;shift right by 4 to get upper nibble
   add ah,30h   ;convert to ASCHII digits(0-9)
   cmp ah,39h   ;compare ah value if ah is less than 39h
   jle print_first_digit
   add ah,7     ;covert to ASCHII letter(A-F) if ah>39h 
   
print_first_digit:
   mov dl,ah    ;move first digit to DL for printing
   mov ah,02h   ;BIOS interrupt to display character
   int 21h
   
   ;to convert lower nibble(4 bits) of AL to a character
   mov ah,bl
   and ah,0Fh   ;mask the upper nibble(all upper nibbles become 0's)
   add ah,30h   
   cmp ah,39h
   jle print_second_digit
   add ah,7     
   
print_second_digit:
   mov dl,ah    ;move second digit to DL for printing
   mov ah,02h   ;BIOS interrupt to display character
   int 21h
   
   ;End the program
   mov ah,4Ch  ;Terminate the program
   int 21h