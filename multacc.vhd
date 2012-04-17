-- IP Core: matmul.multacc functionality
-- Computes out_3 = in_0*in_1 + in_2
-- Sven van Haastregt, LIACS, Leiden University

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity multacc is
   port (
      RST   : in  std_logic;
      CLK   : in  std_logic;

      in_0  : in  std_logic_vector(31 downto 0);
      in_1  : in  std_logic_vector(31 downto 0);
      in_2  : in  std_logic_vector(31 downto 0);

      out_3 : out std_logic_vector(31 downto 0);

      EN    : in  std_logic
   );
end multacc;

architecture RTL of multacc is

  constant c_STAGES : natural := 4;
  type t_token is array (c_STAGES-1 downto 0) of std_logic_vector(31 downto 0);

  signal pipe3: t_token;

begin

  process (RST,CLK)
    variable val: unsigned(63 downto 0);
  begin
    if (RST = '1') then
    elsif (rising_edge(CLK)) then
      if (EN = '1') then
        val := unsigned(in_0) * unsigned(in_1);
        pipe3(0) <= std_logic_vector(unsigned(in_2) + val(31 downto 0));

        for i in 1 to c_STAGES-1 loop
          pipe3(i) <= pipe3(i-1);
        end loop;

      end if;
    end if;
  end process;

  out_3 <= pipe3(c_STAGES-1);

end RTL;
