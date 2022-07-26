library verilog;
use verilog.vl_types.all;
entity alu_1bit is
    port(
        res             : out    vl_logic;
        c_i_plus_1      : out    vl_logic;
        alu_op          : in     vl_logic_vector(2 downto 0);
        a               : in     vl_logic;
        b               : in     vl_logic;
        c_i             : in     vl_logic;
        less_i          : in     vl_logic
    );
end alu_1bit;
