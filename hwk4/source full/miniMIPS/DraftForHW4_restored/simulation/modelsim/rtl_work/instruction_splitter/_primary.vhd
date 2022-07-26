library verilog;
use verilog.vl_types.all;
entity instruction_splitter is
    port(
        opcode          : out    vl_logic_vector(3 downto 0);
        rs              : out    vl_logic_vector(2 downto 0);
        rt              : out    vl_logic_vector(2 downto 0);
        rd              : out    vl_logic_vector(2 downto 0);
        immed           : out    vl_logic_vector(5 downto 0);
        funct           : out    vl_logic_vector(2 downto 0);
        instruction     : in     vl_logic_vector(15 downto 0)
    );
end instruction_splitter;
