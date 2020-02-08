library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
entity iis is
	port(bck,lrcki,datai: IN bit;
		data1o,data2o: OUT bit);
	end iis;
architecture behv of iis is
signal counttmp : std_logic_vector(4 downto 0);

signal Lchin : bit_vector(15 downto 0);---iis input
signal Lchout : bit_vector(15 downto 0);
signal Rchbuf : bit_vector(15 downto 0);

signal old_lrck:bit;
--signal cnt_enable : bit;

	begin 
	 Counter1 :process(bck,lrcki,datai)
		begin
		if bck'event and bck ='1' then		
			
			
			if (lrcki /= old_lrck) then-------RESET
				old_lrck <= lrcki;
				counttmp <= "00000";
			else
			
			if (old_lrck='0') then----Left ch
			case counttmp is
				when "00000"=> Lchin(0)<=datai;
				when "00001"=> Lchin(1)<=datai;
				when "00010"=> Lchin(2)<=datai;
				when "00011"=> Lchin(3)<=datai;
				when "00100"=> Lchin(4)<=datai;
				when "00101"=> Lchin(5)<=datai;
				when "00110"=> Lchin(6)<=datai;
				when "00111"=> Lchin(7)<=datai;
				when "01000"=> Lchin(8)<=datai;
				when "01001"=> Lchin(9)<=datai;
				when "01010"=> Lchin(10)<=datai;
				when "01011"=> Lchin(11)<=datai;
				when "01100"=> Lchin(12)<=datai;
				when "01101"=> Lchin(13)<=datai;
				when "01110"=> Lchin(14)<=datai;
				when "01111"=> Lchin(15)<=datai;
				when "10000"=> null;
				when others => counttmp <= "10001"; --cnt_enable<='0';
			end case;
			else-------Right ch
			case counttmp is
				when "00000"=> Rchbuf(0)<=datai;
				when "00001"=> Rchbuf(1)<=datai;
				when "00010"=> Rchbuf(2)<=datai;
				when "00011"=> Rchbuf(3)<=datai;
				when "00100"=> Rchbuf(4)<=datai;
				when "00101"=> Rchbuf(5)<=datai;
				when "00110"=> Rchbuf(6)<=datai;
				when "00111"=> Rchbuf(7)<=datai;
				when "01000"=> Rchbuf(8)<=datai;
				when "01001"=> Rchbuf(9)<=datai;
				when "01010"=> Rchbuf(10)<=datai;
				when "01011"=> Rchbuf(11)<=datai;
				when "01100"=> Rchbuf(12)<=datai;
				when "01101"=> Rchbuf(13)<=datai;
				when "01110"=> Rchbuf(14)<=datai;
				when "01111"=> Rchbuf(15)<=datai;
				when "10000"=> Lchout <= Lchin; counttmp <= "10001"; --cnt_enable<='0';----disable counter,,when LRCk=1.RELOAD LCHOUT
				when others => counttmp <= "10001"; --cnt_enable<='0';
				end case;
			end if;
			
			counttmp <= counttmp + 1;
			
			end if;
			
		end if;		
	end process Counter1 ;
--------------------------------------------------
	SDATAOUT1 :process(bck)
	begin
		if bck'event and bck ='0' then
			----01,output data
			if (old_lrck='0') then----Left ch
			case counttmp is
				when "00000"=> data1o<=Lchout(0);data2o<=Rchbuf(0);
				when "00001"=> data1o<=Lchout(1);data2o<=Rchbuf(1);
				when "00010"=> data1o<=Lchout(2);data2o<=Rchbuf(2);
				when "00011"=> data1o<=Lchout(3);data2o<=Rchbuf(3);
				when "00100"=> data1o<=Lchout(4);data2o<=Rchbuf(4);
				when "00101"=> data1o<=Lchout(5);data2o<=Rchbuf(5);
				when "00110"=> data1o<=Lchout(6);data2o<=Rchbuf(6);
				when "00111"=> data1o<=Lchout(7);data2o<=Rchbuf(7);
				when "01000"=> data1o<=Lchout(8);data2o<=Rchbuf(8);
				when "01001"=> data1o<=Lchout(9);data2o<=Rchbuf(9);
				when "01010"=> data1o<=Lchout(10);data2o<=Rchbuf(10);
				when "01011"=> data1o<=Lchout(11);data2o<=Rchbuf(11);
				when "01100"=> data1o<=Lchout(12);data2o<=Rchbuf(12);
				when "01101"=> data1o<=Lchout(13);data2o<=Rchbuf(13);
				when "01110"=> data1o<=Lchout(14);data2o<=Rchbuf(14);
				when "01111"=> data1o<=Lchout(15);data2o<=Rchbuf(15);
				---when "10000"=> 
				when others=>data1o<='0';data2o<='0';
			end case;
			else-------Right ch
			case counttmp is
				when "00000"=> data1o<=not Lchout(0);data2o<=not Rchbuf(0);
				when "00001"=> data1o<=not Lchout(1);data2o<=not Rchbuf(1);
				when "00010"=> data1o<=not Lchout(2);data2o<=not Rchbuf(2);
				when "00011"=> data1o<=not Lchout(3);data2o<=not Rchbuf(3);
				when "00100"=> data1o<=not Lchout(4);data2o<=not Rchbuf(4);
				when "00101"=> data1o<=not Lchout(5);data2o<=not Rchbuf(5);
				when "00110"=> data1o<=not Lchout(6);data2o<=not Rchbuf(6);
				when "00111"=> data1o<=not Lchout(7);data2o<=not Rchbuf(7);
				when "01000"=> data1o<=not Lchout(8);data2o<=not Rchbuf(8);
				when "01001"=> data1o<=not Lchout(9);data2o<=not Rchbuf(9);
				when "01010"=> data1o<=not Lchout(10);data2o<=not Rchbuf(10);
				when "01011"=> data1o<=not Lchout(11);data2o<=not Rchbuf(11);
				when "01100"=> data1o<=not Lchout(12);data2o<=not Rchbuf(12);
				when "01101"=> data1o<=not Lchout(13);data2o<=not Rchbuf(13);
				when "01110"=> data1o<=not Lchout(14);data2o<=not Rchbuf(14);
				when "01111"=> data1o<=not Lchout(15);data2o<=not Rchbuf(15);
				---when "10000"=>
				when others =>data1o<='0';data2o<='0';
				end case;
			end if;
		end if;
	end process SDATAOUT1;
end behv;