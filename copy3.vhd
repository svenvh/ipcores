-- IP Core: copies input to output (registered) when ENabled
-- Sven van Haastregt, LIACS, Leiden University

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity copy3 is
   port (
      RST   : in  std_logic;
      CLK   : in  std_logic;

      in_0  : in  std_logic_vector(31 downto 0);

      out_1 : out std_logic_vector(31 downto 0);

      EN    : in  std_logic
   );
end copy3;

architecture RTL of copy3 is
begin

  process (RST,CLK) begin
    if (RST = '1') then
      out_1 <= X"FFEEDDCC";
    elsif (rising_edge(CLK)) then
      if (EN = '1') then
        out_1 <= in_0;
      end if;
    end if;
  end process;

end RTL;
