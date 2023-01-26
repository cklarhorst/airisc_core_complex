/* Machine-generated using Migen */
module tmu_ahb_monitor_dmem(
	input [1:0] m_htrans,
	input [2:0] m_hsize,
	input [31:0] m_haddr,
	input [3:0] m_hprot,
	input m_hresp,
	input m_hready,
	input m_hwrite,
	input i_hsel,
	input [31:0] i_haddr,
	input [1:0] i_trans,
	input [2:0] i_hsize,
	input [31:0] i_hwdata,
	input i_hwrite,
	output reg o_hreadyout,
	output reg o_hresp,
	output reg [31:0] o_hrdata,
	input dbg_does_monitor,
	output reg mem_filled_int,
	input sys_clk,
	input sys_rst
);

reg tmu_mem_filled = 1'd0;
reg tmu_int_enable = 1'd0;
reg tmu_record = 1'd0;
reg tmu_sink_sink_valid = 1'd0;
wire tmu_sink_sink_ready;
reg tmu_sink_sink_first = 1'd0;
reg tmu_sink_sink_last = 1'd0;
reg tmu_sink_sink_payload_success = 1'd0;
reg [31:0] tmu_sink_sink_payload_haddr = 32'd0;
reg [1:0] tmu_sink_sink_payload_htrans = 2'd0;
reg [2:0] tmu_sink_sink_payload_hsize = 3'd0;
reg [3:0] tmu_sink_sink_payload_hprot = 4'd0;
reg tmu_sink_sink_payload_hwrite = 1'd0;
reg tmu_sink_sink_payload_hready = 1'd0;
reg tmu_sink_sink_payload_hresp = 1'd0;
reg [6:0] tmu_sink_sink_payload_idle = 7'd0;
wire tmu_source_source_valid;
wire tmu_source_source_ready;
wire tmu_source_source_first;
wire tmu_source_source_last;
wire tmu_source_source_payload_success;
wire [31:0] tmu_source_source_payload_haddr;
wire [1:0] tmu_source_source_payload_htrans;
wire [2:0] tmu_source_source_payload_hsize;
wire [3:0] tmu_source_source_payload_hprot;
wire tmu_source_source_payload_hwrite;
wire tmu_source_source_payload_hready;
wire tmu_source_source_payload_hresp;
wire [6:0] tmu_source_source_payload_idle;
wire tmu_pipe_valid_sink_valid;
wire tmu_pipe_valid_sink_ready;
wire tmu_pipe_valid_sink_first;
wire tmu_pipe_valid_sink_last;
wire tmu_pipe_valid_sink_payload_success;
wire [31:0] tmu_pipe_valid_sink_payload_haddr;
wire [1:0] tmu_pipe_valid_sink_payload_htrans;
wire [2:0] tmu_pipe_valid_sink_payload_hsize;
wire [3:0] tmu_pipe_valid_sink_payload_hprot;
wire tmu_pipe_valid_sink_payload_hwrite;
wire tmu_pipe_valid_sink_payload_hready;
wire tmu_pipe_valid_sink_payload_hresp;
wire [6:0] tmu_pipe_valid_sink_payload_idle;
reg tmu_pipe_valid_source_valid = 1'd0;
wire tmu_pipe_valid_source_ready;
reg tmu_pipe_valid_source_first = 1'd0;
reg tmu_pipe_valid_source_last = 1'd0;
reg tmu_pipe_valid_source_payload_success = 1'd0;
reg [31:0] tmu_pipe_valid_source_payload_haddr = 32'd0;
reg [1:0] tmu_pipe_valid_source_payload_htrans = 2'd0;
reg [2:0] tmu_pipe_valid_source_payload_hsize = 3'd0;
reg [3:0] tmu_pipe_valid_source_payload_hprot = 4'd0;
reg tmu_pipe_valid_source_payload_hwrite = 1'd0;
reg tmu_pipe_valid_source_payload_hready = 1'd0;
reg tmu_pipe_valid_source_payload_hresp = 1'd0;
reg [6:0] tmu_pipe_valid_source_payload_idle = 7'd0;
reg tmu_sink_valid = 1'd0;
wire tmu_sink_ready;
reg tmu_sink_first = 1'd0;
reg tmu_sink_last = 1'd0;
reg tmu_sink_payload_success = 1'd0;
reg [31:0] tmu_sink_payload_haddr = 32'd0;
reg [1:0] tmu_sink_payload_htrans = 2'd0;
reg [2:0] tmu_sink_payload_hsize = 3'd0;
reg [3:0] tmu_sink_payload_hprot = 4'd0;
reg tmu_sink_payload_hwrite = 1'd0;
reg tmu_sink_payload_hready = 1'd0;
reg tmu_sink_payload_hresp = 1'd0;
reg [6:0] tmu_sink_payload_idle = 7'd0;
reg tmu_sink_payload_parity = 1'd0;
reg [8:0] tmu_sink_payload_continuous = 9'd0;
reg tmu_sink_payload_continued_same = 1'd0;
wire tmu_source_valid;
reg tmu_source_ready = 1'd0;
wire tmu_source_first;
wire tmu_source_last;
wire tmu_source_payload_success;
wire [31:0] tmu_source_payload_haddr;
wire [1:0] tmu_source_payload_htrans;
wire [2:0] tmu_source_payload_hsize;
wire [3:0] tmu_source_payload_hprot;
wire tmu_source_payload_hwrite;
wire tmu_source_payload_hready;
wire tmu_source_payload_hresp;
wire [6:0] tmu_source_payload_idle;
wire tmu_source_payload_parity;
wire [8:0] tmu_source_payload_continuous;
wire tmu_source_payload_continued_same;
wire tmu_re;
reg tmu_readable = 1'd0;
wire tmu_syncfifo_we;
wire tmu_syncfifo_writable;
wire tmu_syncfifo_re;
wire tmu_syncfifo_readable;
wire [64:0] tmu_syncfifo_din;
wire [64:0] tmu_syncfifo_dout;
reg [6:0] tmu_level0 = 7'd0;
reg tmu_replace = 1'd0;
reg [5:0] tmu_produce = 6'd0;
reg [5:0] tmu_consume = 6'd0;
reg [5:0] tmu_wrport_adr;
wire [64:0] tmu_wrport_dat_r;
wire tmu_wrport_we;
wire [64:0] tmu_wrport_dat_w;
wire tmu_do_read;
wire [5:0] tmu_rdport_adr;
wire [64:0] tmu_rdport_dat_r;
wire tmu_rdport_re;
wire [6:0] tmu_level1;
wire tmu_fifo_in_payload_success;
wire [31:0] tmu_fifo_in_payload_haddr;
wire [1:0] tmu_fifo_in_payload_htrans;
wire [2:0] tmu_fifo_in_payload_hsize;
wire [3:0] tmu_fifo_in_payload_hprot;
wire tmu_fifo_in_payload_hwrite;
wire tmu_fifo_in_payload_hready;
wire tmu_fifo_in_payload_hresp;
wire [6:0] tmu_fifo_in_payload_idle;
wire tmu_fifo_in_payload_parity;
wire [8:0] tmu_fifo_in_payload_continuous;
wire tmu_fifo_in_payload_continued_same;
wire tmu_fifo_in_first;
wire tmu_fifo_in_last;
wire tmu_fifo_out_payload_success;
wire [31:0] tmu_fifo_out_payload_haddr;
wire [1:0] tmu_fifo_out_payload_htrans;
wire [2:0] tmu_fifo_out_payload_hsize;
wire [3:0] tmu_fifo_out_payload_hprot;
wire tmu_fifo_out_payload_hwrite;
wire tmu_fifo_out_payload_hready;
wire tmu_fifo_out_payload_hresp;
wire [6:0] tmu_fifo_out_payload_idle;
wire tmu_fifo_out_payload_parity;
wire [8:0] tmu_fifo_out_payload_continuous;
wire tmu_fifo_out_payload_continued_same;
wire tmu_fifo_out_first;
wire tmu_fifo_out_last;
reg [31:0] tmu0 = 32'd0;
reg [1:0] tmu1 = 2'd0;
reg [2:0] tmu2 = 3'd0;
reg [3:0] tmu3 = 4'd0;
reg tmu4 = 1'd0;
reg tmu5 = 1'd0;
reg tmu6 = 1'd0;
reg [6:0] tmu7 = 7'd0;
reg [31:0] tmu8 = 32'd0;
reg [1:0] tmu9 = 2'd0;
reg [2:0] tmu10 = 3'd0;
reg [3:0] tmu11 = 4'd0;
reg tmu12 = 1'd0;
reg tmu13 = 1'd0;
reg tmu14 = 1'd0;
reg [6:0] tmu15 = 7'd0;
reg [8:0] tmu16 = 9'd0;
reg tmu17 = 1'd0;
reg [1:0] tmu_initial_delay = 2'd1;
reg [31:0] tmu_local_address;
reg tmu_write_next_cycle = 1'd0;
reg [31:0] tmu_last_address = 32'd0;
wire [63:0] t_slice_proxy;
wire [63:0] f_slice_proxy;

// synthesis translate_off
reg dummy_s;
initial dummy_s <= 1'd0;
// synthesis translate_on

assign tmu_source_source_ready = (tmu_sink_ready & tmu_source_source_valid);

// synthesis translate_off
reg dummy_d;
// synthesis translate_on
always @(*) begin
	tmu_local_address <= 32'd0;
	if (((i_haddr >= 32'd3221225576) & (i_haddr < 32'd3221225640))) begin
		tmu_local_address <= ((i_haddr - 32'd3221225576) >>> 2'd2);
	end else begin
		tmu_local_address <= 8'd255;
	end
// synthesis translate_off
	dummy_d <= dummy_s;
// synthesis translate_on
end
assign tmu_pipe_valid_sink_ready = ((~tmu_pipe_valid_source_valid) | tmu_pipe_valid_source_ready);
assign tmu_pipe_valid_sink_valid = tmu_sink_sink_valid;
assign tmu_sink_sink_ready = tmu_pipe_valid_sink_ready;
assign tmu_pipe_valid_sink_first = tmu_sink_sink_first;
assign tmu_pipe_valid_sink_last = tmu_sink_sink_last;
assign tmu_pipe_valid_sink_payload_success = tmu_sink_sink_payload_success;
assign tmu_pipe_valid_sink_payload_haddr = tmu_sink_sink_payload_haddr;
assign tmu_pipe_valid_sink_payload_htrans = tmu_sink_sink_payload_htrans;
assign tmu_pipe_valid_sink_payload_hsize = tmu_sink_sink_payload_hsize;
assign tmu_pipe_valid_sink_payload_hprot = tmu_sink_sink_payload_hprot;
assign tmu_pipe_valid_sink_payload_hwrite = tmu_sink_sink_payload_hwrite;
assign tmu_pipe_valid_sink_payload_hready = tmu_sink_sink_payload_hready;
assign tmu_pipe_valid_sink_payload_hresp = tmu_sink_sink_payload_hresp;
assign tmu_pipe_valid_sink_payload_idle = tmu_sink_sink_payload_idle;
assign tmu_source_source_valid = tmu_pipe_valid_source_valid;
assign tmu_pipe_valid_source_ready = tmu_source_source_ready;
assign tmu_source_source_first = tmu_pipe_valid_source_first;
assign tmu_source_source_last = tmu_pipe_valid_source_last;
assign tmu_source_source_payload_success = tmu_pipe_valid_source_payload_success;
assign tmu_source_source_payload_haddr = tmu_pipe_valid_source_payload_haddr;
assign tmu_source_source_payload_htrans = tmu_pipe_valid_source_payload_htrans;
assign tmu_source_source_payload_hsize = tmu_pipe_valid_source_payload_hsize;
assign tmu_source_source_payload_hprot = tmu_pipe_valid_source_payload_hprot;
assign tmu_source_source_payload_hwrite = tmu_pipe_valid_source_payload_hwrite;
assign tmu_source_source_payload_hready = tmu_pipe_valid_source_payload_hready;
assign tmu_source_source_payload_hresp = tmu_pipe_valid_source_payload_hresp;
assign tmu_source_source_payload_idle = tmu_pipe_valid_source_payload_idle;
assign tmu_syncfifo_din = {tmu_fifo_in_last, tmu_fifo_in_first, tmu_fifo_in_payload_continued_same, tmu_fifo_in_payload_continuous, tmu_fifo_in_payload_parity, tmu_fifo_in_payload_idle, tmu_fifo_in_payload_hresp, tmu_fifo_in_payload_hready, tmu_fifo_in_payload_hwrite, tmu_fifo_in_payload_hprot, tmu_fifo_in_payload_hsize, tmu_fifo_in_payload_htrans, tmu_fifo_in_payload_haddr, tmu_fifo_in_payload_success};
assign {tmu_fifo_out_last, tmu_fifo_out_first, tmu_fifo_out_payload_continued_same, tmu_fifo_out_payload_continuous, tmu_fifo_out_payload_parity, tmu_fifo_out_payload_idle, tmu_fifo_out_payload_hresp, tmu_fifo_out_payload_hready, tmu_fifo_out_payload_hwrite, tmu_fifo_out_payload_hprot, tmu_fifo_out_payload_hsize, tmu_fifo_out_payload_htrans, tmu_fifo_out_payload_haddr, tmu_fifo_out_payload_success} = tmu_syncfifo_dout;
assign tmu_sink_ready = tmu_syncfifo_writable;
assign tmu_syncfifo_we = tmu_sink_valid;
assign tmu_fifo_in_first = tmu_sink_first;
assign tmu_fifo_in_last = tmu_sink_last;
assign tmu_fifo_in_payload_success = tmu_sink_payload_success;
assign tmu_fifo_in_payload_haddr = tmu_sink_payload_haddr;
assign tmu_fifo_in_payload_htrans = tmu_sink_payload_htrans;
assign tmu_fifo_in_payload_hsize = tmu_sink_payload_hsize;
assign tmu_fifo_in_payload_hprot = tmu_sink_payload_hprot;
assign tmu_fifo_in_payload_hwrite = tmu_sink_payload_hwrite;
assign tmu_fifo_in_payload_hready = tmu_sink_payload_hready;
assign tmu_fifo_in_payload_hresp = tmu_sink_payload_hresp;
assign tmu_fifo_in_payload_idle = tmu_sink_payload_idle;
assign tmu_fifo_in_payload_parity = tmu_sink_payload_parity;
assign tmu_fifo_in_payload_continuous = tmu_sink_payload_continuous;
assign tmu_fifo_in_payload_continued_same = tmu_sink_payload_continued_same;
assign tmu_source_valid = tmu_readable;
assign tmu_source_first = tmu_fifo_out_first;
assign tmu_source_last = tmu_fifo_out_last;
assign tmu_source_payload_success = tmu_fifo_out_payload_success;
assign tmu_source_payload_haddr = tmu_fifo_out_payload_haddr;
assign tmu_source_payload_htrans = tmu_fifo_out_payload_htrans;
assign tmu_source_payload_hsize = tmu_fifo_out_payload_hsize;
assign tmu_source_payload_hprot = tmu_fifo_out_payload_hprot;
assign tmu_source_payload_hwrite = tmu_fifo_out_payload_hwrite;
assign tmu_source_payload_hready = tmu_fifo_out_payload_hready;
assign tmu_source_payload_hresp = tmu_fifo_out_payload_hresp;
assign tmu_source_payload_idle = tmu_fifo_out_payload_idle;
assign tmu_source_payload_parity = tmu_fifo_out_payload_parity;
assign tmu_source_payload_continuous = tmu_fifo_out_payload_continuous;
assign tmu_source_payload_continued_same = tmu_fifo_out_payload_continued_same;
assign tmu_re = tmu_source_ready;
assign tmu_syncfifo_re = (tmu_syncfifo_readable & ((~tmu_readable) | tmu_re));
assign tmu_level1 = (tmu_level0 + tmu_readable);

// synthesis translate_off
reg dummy_d_1;
// synthesis translate_on
always @(*) begin
	tmu_wrport_adr <= 6'd0;
	if (tmu_replace) begin
		tmu_wrport_adr <= (tmu_produce - 1'd1);
	end else begin
		tmu_wrport_adr <= tmu_produce;
	end
// synthesis translate_off
	dummy_d_1 <= dummy_s;
// synthesis translate_on
end
assign tmu_wrport_dat_w = tmu_syncfifo_din;
assign tmu_wrport_we = (tmu_syncfifo_we & (tmu_syncfifo_writable | tmu_replace));
assign tmu_do_read = (tmu_syncfifo_readable & tmu_syncfifo_re);
assign tmu_rdport_adr = tmu_consume;
assign tmu_syncfifo_dout = tmu_rdport_dat_r;
assign tmu_rdport_re = tmu_do_read;
assign tmu_syncfifo_writable = (tmu_level0 != 7'd64);
assign tmu_syncfifo_readable = (tmu_level0 != 1'd0);
assign t_slice_proxy = {tmu_source_payload_continued_same, tmu_source_payload_continuous, tmu_source_payload_parity, tmu_source_payload_idle, tmu_source_payload_hresp, tmu_source_payload_hready, tmu_source_payload_hwrite, tmu_source_payload_hprot, tmu_source_payload_hsize, tmu_source_payload_htrans, tmu_source_payload_haddr, tmu_source_payload_success, mem_filled_int};
assign f_slice_proxy = {tmu_source_payload_continued_same, tmu_source_payload_continuous, tmu_source_payload_parity, tmu_source_payload_idle, tmu_source_payload_hresp, tmu_source_payload_hready, tmu_source_payload_hwrite, tmu_source_payload_hprot, tmu_source_payload_hsize, tmu_source_payload_htrans, tmu_source_payload_haddr, tmu_source_payload_success, mem_filled_int};

always @(posedge sys_clk) begin
	tmu_mem_filled <= (tmu_level1 > 6'd57);
	mem_filled_int <= (tmu_mem_filled & tmu_int_enable);
	tmu0 <= m_haddr;
	tmu1 <= m_htrans;
	tmu2 <= m_hsize;
	tmu3 <= m_hprot;
	tmu4 <= m_hwrite;
	tmu5 <= m_hready;
	tmu6 <= m_hresp;
	if (((m_hready & (~m_hresp)) & (tmu1 == 2'd2))) begin
		tmu_sink_sink_payload_haddr <= tmu0;
		tmu_sink_sink_payload_htrans <= tmu1;
		tmu_sink_sink_payload_hsize <= tmu2;
		tmu_sink_sink_payload_hprot <= tmu3;
		tmu_sink_sink_payload_hwrite <= tmu4;
		tmu_sink_sink_payload_hready <= tmu5;
		tmu_sink_sink_payload_hresp <= tmu6;
		tmu_sink_sink_payload_idle <= tmu7;
		tmu_sink_sink_valid <= tmu_record;
		tmu7 <= 1'd0;
	end else begin
		if (tmu_record) begin
			tmu7 <= (tmu7 + 1'd1);
		end else begin
			tmu7 <= 1'd0;
		end
		tmu_sink_sink_valid <= 1'd0;
	end
	if (((((tmu_source_source_valid & (tmu_source_source_payload_haddr == tmu8)) & (tmu_source_source_payload_hwrite == tmu12)) & (tmu_source_source_payload_hsize == tmu10)) & (tmu16 < 9'd511))) begin
		tmu17 <= 1'd1;
		tmu16 <= (tmu16 + 1'd1);
		tmu15 <= (tmu15 + tmu_source_source_payload_idle);
		tmu_sink_valid <= 1'd0;
	end else begin
		if ((((((tmu_source_source_valid & (tmu17 == 1'd0)) & (tmu_source_source_payload_haddr == (tmu8 + 3'd4))) & (tmu_source_source_payload_hwrite == tmu12)) & (tmu_source_source_payload_hsize == tmu10)) & (tmu16 < 9'd511))) begin
			tmu17 <= 1'd0;
			tmu16 <= (tmu16 + 1'd1);
			tmu15 <= (tmu15 + tmu_source_source_payload_idle);
			tmu8 <= (tmu8 + 3'd4);
			tmu_sink_valid <= 1'd0;
		end else begin
			if (tmu_source_source_valid) begin
				tmu8 <= tmu_source_source_payload_haddr;
				tmu9 <= tmu_source_source_payload_htrans;
				tmu10 <= tmu_source_source_payload_hsize;
				tmu11 <= tmu_source_source_payload_hprot;
				tmu12 <= tmu_source_source_payload_hwrite;
				tmu13 <= tmu_source_source_payload_hready;
				tmu14 <= tmu_source_source_payload_hresp;
				tmu15 <= tmu_source_source_payload_idle;
				tmu16 <= 1'd0;
				tmu17 <= 1'd0;
				if ((tmu_initial_delay > 1'd0)) begin
					tmu_initial_delay <= (tmu_initial_delay - 1'd1);
				end else begin
					tmu_sink_valid <= 1'd1;
				end
			end else begin
				tmu_sink_valid <= 1'd0;
			end
		end
	end
	tmu_sink_payload_haddr <= tmu8;
	tmu_sink_payload_htrans <= tmu9;
	tmu_sink_payload_hsize <= tmu10;
	tmu_sink_payload_hprot <= tmu11;
	tmu_sink_payload_hwrite <= tmu12;
	tmu_sink_payload_hready <= tmu13;
	tmu_sink_payload_hresp <= tmu14;
	tmu_sink_payload_idle <= tmu15;
	tmu_sink_payload_continuous <= tmu16;
	tmu_sink_payload_continued_same <= tmu17;
	if (((tmu_write_next_cycle & (tmu_last_address == 2'd3)) & (i_hwdata == 1'd1))) begin
		tmu_source_ready <= 1'd1;
	end else begin
		tmu_source_ready <= 1'd0;
	end
	if (i_hsel) begin
		tmu_last_address <= tmu_local_address;
		if (tmu_write_next_cycle) begin
			if ((tmu_last_address == 1'd1)) begin
				tmu_record <= (i_hwdata & 1'd1);
				tmu_int_enable <= ((i_hwdata & 2'd2) >>> 1'd1);
			end
			if ((~i_hwrite)) begin
				tmu_write_next_cycle <= 1'd0;
			end
		end else begin
			if (tmu_source_ready) begin
			end
		end
		if ((tmu_local_address == 1'd0)) begin
			if ((~i_hwrite)) begin
				o_hrdata <= 31'd1414354256;
			end
		end else begin
			if ((tmu_local_address == 1'd1)) begin
				if ((~i_hwrite)) begin
					o_hrdata <= {tmu_int_enable, tmu_record};
				end else begin
					tmu_write_next_cycle <= 1'd1;
				end
			end else begin
				if ((tmu_local_address == 2'd2)) begin
					if ((~i_hwrite)) begin
						o_hrdata <= {(tmu_level1 >= 7'd64), (tmu_level1 == 1'd0), mem_filled_int};
					end
				end else begin
					if ((tmu_local_address == 2'd3)) begin
						if ((i_trans == 2'd2)) begin
							if ((~i_hwrite)) begin
								o_hrdata <= tmu_source_ready;
							end else begin
								tmu_write_next_cycle <= 1'd1;
							end
						end
					end else begin
						if ((tmu_local_address == 3'd4)) begin
							o_hrdata <= t_slice_proxy[31:0];
						end else begin
							if ((tmu_local_address == 3'd5)) begin
								o_hrdata <= f_slice_proxy[63:32];
							end
						end
					end
				end
			end
		end
	end
	o_hreadyout <= 1'd1;
	o_hresp <= 1'd0;
	if (((~tmu_pipe_valid_source_valid) | tmu_pipe_valid_source_ready)) begin
		tmu_pipe_valid_source_valid <= tmu_pipe_valid_sink_valid;
		tmu_pipe_valid_source_first <= tmu_pipe_valid_sink_first;
		tmu_pipe_valid_source_last <= tmu_pipe_valid_sink_last;
		tmu_pipe_valid_source_payload_success <= tmu_pipe_valid_sink_payload_success;
		tmu_pipe_valid_source_payload_haddr <= tmu_pipe_valid_sink_payload_haddr;
		tmu_pipe_valid_source_payload_htrans <= tmu_pipe_valid_sink_payload_htrans;
		tmu_pipe_valid_source_payload_hsize <= tmu_pipe_valid_sink_payload_hsize;
		tmu_pipe_valid_source_payload_hprot <= tmu_pipe_valid_sink_payload_hprot;
		tmu_pipe_valid_source_payload_hwrite <= tmu_pipe_valid_sink_payload_hwrite;
		tmu_pipe_valid_source_payload_hready <= tmu_pipe_valid_sink_payload_hready;
		tmu_pipe_valid_source_payload_hresp <= tmu_pipe_valid_sink_payload_hresp;
		tmu_pipe_valid_source_payload_idle <= tmu_pipe_valid_sink_payload_idle;
	end
	if (tmu_syncfifo_re) begin
		tmu_readable <= 1'd1;
	end else begin
		if (tmu_re) begin
			tmu_readable <= 1'd0;
		end
	end
	if (((tmu_syncfifo_we & tmu_syncfifo_writable) & (~tmu_replace))) begin
		tmu_produce <= (tmu_produce + 1'd1);
	end
	if (tmu_do_read) begin
		tmu_consume <= (tmu_consume + 1'd1);
	end
	if (((tmu_syncfifo_we & tmu_syncfifo_writable) & (~tmu_replace))) begin
		if ((~tmu_do_read)) begin
			tmu_level0 <= (tmu_level0 + 1'd1);
		end
	end else begin
		if (tmu_do_read) begin
			tmu_level0 <= (tmu_level0 - 1'd1);
		end
	end
	if (sys_rst) begin
		o_hreadyout <= 1'd1;
		o_hresp <= 1'd0;
		o_hrdata <= 32'd0;
		mem_filled_int <= 1'd0;
		tmu_mem_filled <= 1'd0;
		tmu_int_enable <= 1'd0;
		tmu_record <= 1'd0;
		tmu_sink_sink_valid <= 1'd0;
		tmu_sink_sink_payload_haddr <= 32'd0;
		tmu_sink_sink_payload_htrans <= 2'd0;
		tmu_sink_sink_payload_hsize <= 3'd0;
		tmu_sink_sink_payload_hprot <= 4'd0;
		tmu_sink_sink_payload_hwrite <= 1'd0;
		tmu_sink_sink_payload_hready <= 1'd0;
		tmu_sink_sink_payload_hresp <= 1'd0;
		tmu_sink_sink_payload_idle <= 7'd0;
		tmu_pipe_valid_source_valid <= 1'd0;
		tmu_pipe_valid_source_payload_success <= 1'd0;
		tmu_pipe_valid_source_payload_haddr <= 32'd0;
		tmu_pipe_valid_source_payload_htrans <= 2'd0;
		tmu_pipe_valid_source_payload_hsize <= 3'd0;
		tmu_pipe_valid_source_payload_hprot <= 4'd0;
		tmu_pipe_valid_source_payload_hwrite <= 1'd0;
		tmu_pipe_valid_source_payload_hready <= 1'd0;
		tmu_pipe_valid_source_payload_hresp <= 1'd0;
		tmu_pipe_valid_source_payload_idle <= 7'd0;
		tmu_sink_valid <= 1'd0;
		tmu_sink_payload_haddr <= 32'd0;
		tmu_sink_payload_htrans <= 2'd0;
		tmu_sink_payload_hsize <= 3'd0;
		tmu_sink_payload_hprot <= 4'd0;
		tmu_sink_payload_hwrite <= 1'd0;
		tmu_sink_payload_hready <= 1'd0;
		tmu_sink_payload_hresp <= 1'd0;
		tmu_sink_payload_idle <= 7'd0;
		tmu_sink_payload_continuous <= 9'd0;
		tmu_sink_payload_continued_same <= 1'd0;
		tmu_source_ready <= 1'd0;
		tmu_readable <= 1'd0;
		tmu_level0 <= 7'd0;
		tmu_produce <= 6'd0;
		tmu_consume <= 6'd0;
		tmu0 <= 32'd0;
		tmu1 <= 2'd0;
		tmu2 <= 3'd0;
		tmu3 <= 4'd0;
		tmu4 <= 1'd0;
		tmu5 <= 1'd0;
		tmu6 <= 1'd0;
		tmu7 <= 7'd0;
		tmu8 <= 32'd0;
		tmu9 <= 2'd0;
		tmu10 <= 3'd0;
		tmu11 <= 4'd0;
		tmu12 <= 1'd0;
		tmu13 <= 1'd0;
		tmu14 <= 1'd0;
		tmu15 <= 7'd0;
		tmu16 <= 9'd0;
		tmu17 <= 1'd0;
		tmu_initial_delay <= 2'd1;
		tmu_write_next_cycle <= 1'd0;
		tmu_last_address <= 32'd0;
	end
end

reg [64:0] storage[0:63];
reg [64:0] memdat;
reg [64:0] memdat_1;
always @(posedge sys_clk) begin
	if (tmu_wrport_we)
		storage[tmu_wrport_adr] <= tmu_wrport_dat_w;
	memdat <= storage[tmu_wrport_adr];
end

always @(posedge sys_clk) begin
	if (tmu_rdport_re)
		memdat_1 <= storage[tmu_rdport_adr];
end

assign tmu_wrport_dat_r = memdat;
assign tmu_rdport_dat_r = memdat_1;

endmodule
