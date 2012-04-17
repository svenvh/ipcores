-- IP Core: copies input1+input2 to output (registered) when ENabled
-- Sven van Haastregt, LIACS, Leiden University

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity add is
   port (
      RST   : in  std_logic;
      CLK   : in  std_logic;

      in_0  : in  std_logic_vector(31 downto 0);
      in_1  : in  std_logic_vector(31 downto 0);

      out_2 : out std_logic_vector(31 downto 0);

      EN    : in  std_logic
   );
end add;

architecture RTL of add is
begin

  process (RST,CLK) begin
    if (RST = '1') then
      out_2 <= X"FFEEDDCC";
    elsif (rising_edge(CLK)) then
      if (EN = '1') then
        out_2 <= std_logic_vector(unsigned(in_0) + unsigned(in_1));
      end if;
    end if;
  end process;

end RTL;
