library verilog;
use verilog.vl_types.all;
entity mux5x1 is
    port(
        result          : out    vl_logic_vector(4 downto 0);
        \select\        : in     vl_logic;
        num1            : in     vl_logic_vector(4 downto 0);
        num2            : in     vl_logic_vector(4 downto 0)
    );
end mux5x1;
