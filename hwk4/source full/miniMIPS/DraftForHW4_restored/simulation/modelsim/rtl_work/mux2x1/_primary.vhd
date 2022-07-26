library verilog;
use verilog.vl_types.all;
entity mux2x1 is
    port(
        res             : out    vl_logic;
        s               : in     vl_logic;
        a               : in     vl_logic;
        b               : in     vl_logic
    );
end mux2x1;
