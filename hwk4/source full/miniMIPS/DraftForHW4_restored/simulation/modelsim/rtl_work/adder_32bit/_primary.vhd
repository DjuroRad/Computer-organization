library verilog;
use verilog.vl_types.all;
entity adder_32bit is
    port(
        sum             : out    vl_logic_vector(31 downto 0);
        carry_out       : out    vl_logic;
        a               : in     vl_logic_vector(31 downto 0);
        b               : in     vl_logic_vector(31 downto 0);
        carry_in        : in     vl_logic
    );
end adder_32bit;
