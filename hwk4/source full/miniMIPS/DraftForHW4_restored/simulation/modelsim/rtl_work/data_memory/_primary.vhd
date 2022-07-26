library verilog;
use verilog.vl_types.all;
entity data_memory is
    port(
        read_data       : out    vl_logic_vector(31 downto 0);
        address         : in     vl_logic_vector(31 downto 0);
        write_data      : in     vl_logic_vector(31 downto 0);
        mem_write       : in     vl_logic;
        mem_read        : in     vl_logic;
        clk             : in     vl_logic
    );
end data_memory;
