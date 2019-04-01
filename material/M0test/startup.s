;/******************** (C) COPYRIGHT 2009 STMicroelectronics ********************
;* File Name          : startup_stm32f10x_hd.s
;* Author             : MCD Application Team
;* Version            : V3.1.2
;* Date               : 09/28/2009
;* Description        : STM32F10x High Density Devices vector table for EWARM5.x 
;*                      toolchain.
;*                      This module performs:
;*                      - Set the initial SP
;*                      - Set the initial PC == __iar_program_start,
;*                      - Set the vector table entries with the exceptions ISR address,
;*                      - Configure external SRAM mounted on STM3210E-EVAL board
;*                       to be used as data memory (optional, to be enabled by user)
;*                      After Reset the Cortex-M3 processor is in Thread mode,
;*                      priority is Privileged, and the Stack is set to Main.
;********************************************************************************
;* THE PRESENT FIRMWARE WHICH IS FOR GUIDANCE ONLY AIMS AT PROVIDING CUSTOMERS
;* WITH CODING INFORMATION REGARDING THEIR PRODUCTS IN ORDER FOR THEM TO SAVE TIME.
;* AS A RESULT, STMICROELECTRONICS SHALL NOT BE HELD LIABLE FOR ANY DIRECT,
;* INDIRECT OR CONSEQUENTIAL DAMAGES WITH RESPECT TO ANY CLAIMS ARISING FROM THE
;* CONTENT OF SUCH FIRMWARE AND/OR THE USE MADE BY CUSTOMERS OF THE CODING
;* INFORMATION CONTAINED HEREIN IN CONNECTION WITH THEIR PRODUCTS.
;*******************************************************************************/
;
;
; The modules in this file are included in the libraries, and may be replaced
; by any user-defined modules that define the PUBLIC symbol _program_start or
; a user defined start symbol.
; To override the cstartup defined in the library, simply add your modified
; version to the workbench project.
;
; The vector table is normally located at address 0.
; When debugging in RAM, it can be located in RAM, aligned to at least 2^6.
; The name "__vector_table" has special meaning for C-SPY:
; it is where the SP start value is found, and the NVIC vector
; table register (VTOR) is initialized to this address if != 0.
;
; Cortex-M version
;     
  
    MODULE  ?cstartup
        
  ;; ICODE is the same segment as cstartup. By placing __low_level_init
  ;; in the same segment, we make sure it can be reached with BL. */

      SECTION	   CSTACK:DATA:NOROOT(3)
      SECTION .icode:CODE:NOROOT(2)
      PUBLIC  __low_level_init

      PUBWEAK SystemInit_ExtMemCtl
      SECTION .text:CODE:REORDER(2)
      THUMB
SystemInit_ExtMemCtl
      BX LR 
   
__low_level_init:

  ;;  Initialize hardware.
                LDR  R0, = SystemInit_ExtMemCtl ; initialize external memory controller
                MOV  R11, LR
                BLX  R0 
                LDR  R1, =sfe(CSTACK)        ; restore original stack pointer
                MSR  MSP, R1   
                ;;MOV  R0,#1
		MOVS  R0,#1
   ;; Return with BX to be independent of mode of caller
                BX    R11

        ;; Forward declaration of sections.
        SECTION .intvec:CODE:NOROOT(2)

        EXTERN  __iar_program_start
        PUBLIC  __vector_table

        DATA
__intial_sp      EQU     0x00000000       
__vector_table
        DCD     __intial_sp
        DCD     __iar_program_start

        DCD     NMI_Handler               ; NMI Handler
        DCD     HardFault_Handler         ; Hard Fault Handler
        DCD     MemManage_Handler         ; MPU Fault Handler
        DCD     BusFault_Handler          ; Bus Fault Handler
        DCD     UsageFault_Handler        ; Usage Fault Handler
        DCD     0                         ; Reserved
        DCD     0                         ; Reserved
        DCD     0                         ; Reserved
        DCD     0                         ; Reserved
        DCD     SVC_Handler               ; SVCall Handler
        DCD     DebugMon_Handler          ; Debug Monitor Handler
        DCD     0                         ; Reserved
        DCD     PendSV_Handler            ; PendSV Handler
        DCD     SysTick_Handler           ; SysTick Handler

         ; External Interrupts
		DCD     UART_IRQHandler                           ; 0: UART_IRQHandler 
		DCD     0                                         ; 1
		DCD     0                                         ; 2:  UART1
		DCD     0                                         ; 3:  I2C0
		DCD     0                                         ; 4:  SPI0
		DCD     0                                         ; 5:  UART2
                DCD     0                                         ; 6:  UART3
                DCD     0                                         ; 7:  I2C1
		DCD     0                                         ; 8: ASIC Device
		DCD     0            				  ; 9
		DCD     0				          ; 10
		DCD     0                                         ; 11
		DCD     0                                         ; 12:  GPIOA
		DCD     0                                         ; 13: GPIOB
		DCD     0                                         ; 14: GPIOC
		DCD     0                                         ; 15: GPIOD
                DCD     0				          ; RSVD
		DCD     0				          ; RSVD
		DCD     0				          ; RSVD
		DCD     0				          ; RSVD
		DCD     0				          ; RSVD
		DCD     0				          ; RSVD
                DCD     0				          ; RSVD
		DCD     0				          ; RSVD
		DCD     0				          ; RSVD
		DCD     0				          ; RSVD
		DCD     0				          ; RSVD
		DCD     0				          ; RSVD
		DCD     0				          ; RSVD
		DCD     0				          ; RSVD
		DCD     0				          ; RSVD
                DCD     0       				  ; RSVD
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Default interrupt handlers.
;;

          PUBWEAK NMI_Handler               
          PUBWEAK HardFault_Handler         
          PUBWEAK MemManage_Handler         
          PUBWEAK BusFault_Handler          
          PUBWEAK UsageFault_Handler        
          PUBWEAK SVC_Handler               
          PUBWEAK DebugMon_Handler          
          PUBWEAK PendSV_Handler            
          PUBWEAK SysTick_Handler
          ;; COCOA	   
          PUBWEAK UART_IRQHandler
        THUMB
        SECTION .text:CODE:REORDER(1)
NMI_Handler               
HardFault_Handler         
MemManage_Handler         
BusFault_Handler          
UsageFault_Handler        
SVC_Handler               
DebugMon_Handler          
PendSV_Handler            
SysTick_Handler  
;; COCOA
UART_IRQHandler      
Default_Handler
        B Default_Handler

        END

/******************* (C) COPYRIGHT 2009 STMicroelectronics *****END OF FILE****/
