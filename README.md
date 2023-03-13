# A-Low-Power-Radix-4-Booth-Multiplier-With-Pre-Encoded-Mechanism

The major goal of this project is to create a pre-encoded mechanism that will increase multiplication's power efficiency by pre-encoding the two states in the booth multiplier so that it turns off the associated encoder and decoder. This project was created using the Xilinx Vivado tool using Verilog

Traditional radix 4 Booth multipier work as follow
![Screenshot_20230313_174639](https://user-images.githubusercontent.com/95961264/224717873-95bbd1eb-1ec8-452c-8dee-5b7ec80d104a.png)

Modifield booth algo with pre encoder 
![Screenshot_20230313_174948](https://user-images.githubusercontent.com/95961264/224718266-7d0ecee3-5526-4c5f-a7e7-84d70ff35ee4.png)

Implementation of proposed preencoder is done in verilog
![Screenshot_20230313_174910](https://user-images.githubusercontent.com/95961264/224717429-d95f7392-b720-4496-962c-5b33e8bbc4f8.png)

As whole my pre-encoder warks as enable signal for traditional encoder if pre-encoder output is high it disable the associated encoder with saves the dyanamic power since activity factor is reduceds and the partial product is directly evaluted as 0  if my enable signal is low the the associated encoder and decoder works normal as in traditional booth multiplier

![Screenshot_20230313_175122](https://user-images.githubusercontent.com/95961264/224715478-426e47d7-17bf-4281-a59b-28e3bd62e913.png)
