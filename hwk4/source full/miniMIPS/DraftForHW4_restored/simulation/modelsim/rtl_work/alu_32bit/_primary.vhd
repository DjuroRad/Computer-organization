library verilog;
use verilog.vl_types.all;
entity alu_32bit is
    port(
        result_final    : out    vl_logic_vector(31 downto 0);
        alu_op          : in     vl_logic_vector(2 downto 0);
        a               : in     vl_logic_vector(31 downto 0);
        b               : in     vl_logic_vector(31 downto 0);
        zero            : out    vl_logic
    );
end alu_32bit;
