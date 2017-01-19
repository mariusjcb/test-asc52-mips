# subiect 52.

# Ilie Marius
# grupa 143
# marius@iliemarius.ro

.data
    s: .asciiz "01000011"
.text

convert:
    subu    $sp, 4                  
    sw      $fp, 0($sp)             # salvez $fp 
    addiu   $fp, $sp, 0             # stiva este $sp:($fp v)(adr.s)

    lw      $t1, 4($fp)             # incarc stringul
    li      $v0, 0

while:
    lb      $t0, ($t1)              # incarc caracterul curent

    beqz    $t0, endWhile           # skip daca $t0 == '\0'

    sll     $v0, $v0, 1             # $v0 = $v0 << 1

    subu    $t0, 0x30               # scad 48 pt a avea codul 1 / 0

    blez    $t0, skip               # if(s[i]=='1')
    ori     $v0, $v0, 0x01          # $v0 = $v0 | 0x01
    
    skip:
    addiu   $t1, $t1, 1             # incrementez $t1 cu 1
    j       while

endWhile:
    lw      $fp, 0($fp)             # restaurez $fp
    addu    $sp, 4                  # stiva initiala

    jr      $ra                     # jump inapoi in main

main:  
    la      $t1, s                  # incac adresa stringului

    subu    $sp, 4                  # salvez in stiva
    sw      $t1, 0($sp) 
       
    jal     convert                 # jump la procedura de conversie
    addi    $sp, $sp, 4             # scot din stiva

    move    $a0, $v0                # afisez rezultatul din $v0
    li      $v0, 1
    syscall

end: 
    li $v0, 10                      # end
    syscall
