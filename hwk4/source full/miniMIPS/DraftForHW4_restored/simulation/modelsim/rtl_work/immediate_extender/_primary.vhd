library verilog;
use verilog.vl_types.all;
entity immediate_extender is
    port(
        immediate_extended: out    vl_logic_vector(31 downto 0);
        immed_in        : in     vl_logic_vector(5 downto 0)
    );
end immediate_extender;
