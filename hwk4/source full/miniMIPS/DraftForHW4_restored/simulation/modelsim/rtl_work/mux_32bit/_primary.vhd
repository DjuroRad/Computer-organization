library verilog;
use verilog.vl_types.all;
entity mux_32bit is
    port(
        result          : out    vl_logic_vector(31 downto 0);
        \select\        : in     vl_logic;
        num1            : in     vl_logic_vector(31 downto 0);
        num2            : in     vl_logic_vector(31 downto 0)
    );
end mux_32bit;
