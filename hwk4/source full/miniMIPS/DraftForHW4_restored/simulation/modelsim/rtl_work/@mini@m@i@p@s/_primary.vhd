library verilog;
use verilog.vl_types.all;
entity MiniMIPS is
    port(
        instruction     : in     vl_logic_vector(15 downto 0);
        result          : out    vl_logic_vector(31 downto 0);
        clk             : in     vl_logic
    );
end MiniMIPS;
