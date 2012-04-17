-- IP Core: compares and swaps (if necessary) its arguments, such that out_2 < out_3
-- Sven van Haastregt, LIACS, Leiden University

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity compareswap1 is
   port (
      RST   : in  std_logic;
      CLK   : in  std_logic;

      in_0  : in  std_logic_vector(31 downto 0);
      in_1  : in  std_logic_vector(31 downto 0);

      out_2 : out std_logic_vector(31 downto 0);
      out_3 : out std_logic_vector(31 downto 0);

      EN    : in  std_logic
   );
end compareswap1;

architecture RTL of compareswap1 is
begin

  process (RST,CLK) begin
    if (RST = '1') then
      out_2 <= X"FFEEDDCC";
      out_3 <= X"FFEEDDCC";
    elsif (rising_edge(CLK)) then
      if (EN = '1') then
        if (unsigned(in_0) > unsigned(in_1)) then
          out_2 <= in_1;
          out_3 <= in_0;
        else 
          out_2 <= in_0;
          out_3 <= in_1;
        end if;
      end if;
    end if;
  end process;

end RTL;
