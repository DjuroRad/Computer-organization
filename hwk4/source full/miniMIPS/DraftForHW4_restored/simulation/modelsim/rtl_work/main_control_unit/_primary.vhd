library verilog;
use verilog.vl_types.all;
entity main_control_unit is
    port(
        opcode          : in     vl_logic_vector(3 downto 0);
        reg_dest        : out    vl_logic;
        alusrc          : out    vl_logic;
        mem_to_reg      : out    vl_logic;
        reg_wr          : out    vl_logic;
        mem_rd          : out    vl_logic;
        mem_wr          : out    vl_logic;
        branch          : out    vl_logic;
        alu_op          : out    vl_logic_vector(2 downto 0)
    );
end main_control_unit;
