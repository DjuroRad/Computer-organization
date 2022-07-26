library verilog;
use verilog.vl_types.all;
entity mux8x1 is
    port(
        res             : out    vl_logic;
        s               : in     vl_logic_vector(2 downto 0);
        i0              : in     vl_logic;
        i1              : in     vl_logic;
        i2              : in     vl_logic;
        i3              : in     vl_logic;
        i4              : in     vl_logic;
        i5              : in     vl_logic;
        i6              : in     vl_logic;
        i7              : in     vl_logic
    );
end mux8x1;
