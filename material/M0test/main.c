#include<stdint.h>

int main(void)
{
    uint32_t ROM;
    uint32_t SRAM;
    uint32_t UART;
    //uint32_t dataout;
    int i;
    
    // Enable CPU interrupts (NVIC_ISER in SCS)
    *((uint32_t*) 0xE000E100)=0x00000001;   // 0-UART 
    
    //SRAM test
    *((uint32_t*) 0x20000088)=0x12345678;  //write SRAM
    SRAM=*((uint32_t*) 0x20000088);        //read SRAM
    
    //GPIO test
    *((uint32_t*) 0x40000004)=0xfffffffd;   
    *((uint32_t*) 0x40000008)=0x00000000;   
    *((uint32_t*) 0x40000000)=0x00000001;   
    *((uint32_t*) 0x40000000)=0x00000000;   
    *((uint32_t*) 0x40000000)=0x00000001;   
    *((uint32_t*) 0x40000000)=0x00000000;  
    *((uint32_t*) 0x40000000)=0x00000001;   
  
    //UART test 
    //please finish yourself

    while(1)
    {
      for(i=0;i<9999;i++);
    }
    
    return 0;
}