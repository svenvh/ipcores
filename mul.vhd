-- IP Core: copies input1*input2 to output (registered) when ENabled
-- Sven van Haastregt, LIACS, Leiden University

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity mul is
   port (
      RST   : in  std_logic;
      CLK   : in  std_logic;

      in_0  : in  std_logic_vector(31 downto 0);
      in_1  : in  std_logic_vector(31 downto 0);

      out_2 : out std_logic_vector(31 downto 0);

      EN    : in  std_logic
   );
end mul;

architecture RTL of mul is
  signal in0_d1: std_logic_vector(31 downto 0);
  signal in1_d1: std_logic_vector(31 downto 0);
  signal out_d1: std_logic_vector(31 downto 0);
  signal out_d2: std_logic_vector(31 downto 0);
  signal out_d3: std_logic_vector(31 downto 0);

begin

  process (CLK) begin
    if (rising_edge(CLK)) then
      if (EN = '1') then
        -- Pipeline inputs to multiply (will be pushed into DSP48E)
        in0_d1 <= in_0;
        in1_d1 <= in_1;

        out_d1 <= std_logic_vector(unsigned(in0_d1) * unsigned(in1_d1));

        -- Pipeline output of multiply twice (will be pushed into DSP48E)
        out_d2 <= out_d1;
        out_d3 <= out_d2;
        out_2 <= out_d3;
      end if;
    end if;
  end process;

end RTL;
