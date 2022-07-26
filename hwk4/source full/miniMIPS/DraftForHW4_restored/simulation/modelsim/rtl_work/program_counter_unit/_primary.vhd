library verilog;
use verilog.vl_types.all;
entity program_counter_unit is
    port(
        new_program_counter: out    vl_logic_vector(5 downto 0);
        program_counter : in     vl_logic_vector(5 downto 0);
        shifted_immediate_extended: in     vl_logic_vector(31 downto 0);
        branch          : in     vl_logic
    );
end program_counter_unit;
