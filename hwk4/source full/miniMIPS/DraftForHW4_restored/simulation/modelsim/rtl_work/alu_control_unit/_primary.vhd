library verilog;
use verilog.vl_types.all;
entity alu_control_unit is
    port(
        alu_ctr         : out    vl_logic_vector(2 downto 0);
        func            : in     vl_logic_vector(2 downto 0);
        alu_op          : in     vl_logic_vector(2 downto 0)
    );
end alu_control_unit;
