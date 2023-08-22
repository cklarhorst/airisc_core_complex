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
	output reg mem_filled_int,
	input sys_clk,
	input sys_rst
);

reg tmu_mem_filled = 1'd0;
reg tmu_int_enable = 1'd0;
reg tmu_sink_sink_valid = 1'd0;
wire tmu_sink_sink_ready;
reg tmu_sink_sink_first = 1'd0;
reg tmu_sink_sink_last = 1'd0;
reg [31:0] tmu_sink_sink_payload_haddr = 32'd0;
reg tmu_sink_sink_payload_hwrite = 1'd0;
reg [2:0] tmu_sink_sink_payload_hsize = 3'd0;
reg tmu_sink_sink_payload_error = 1'd0;
reg [8:0] tmu_sink_sink_payload_compressed_entries = 9'd0;
reg [1:0] tmu_sink_sink_payload_compression_type = 2'd0;
reg [7:0] tmu_sink_sink_payload_master_idle_counter = 8'd0;
reg [7:0] tmu_sink_sink_payload_waitstate_counter = 8'd0;
wire tmu_source_source_valid;
reg tmu_source_source_ready = 1'd0;
wire tmu_source_source_first;
wire tmu_source_source_last;
wire [31:0] tmu_source_source_payload_haddr;
wire tmu_source_source_payload_hwrite;
wire [2:0] tmu_source_source_payload_hsize;
wire tmu_source_source_payload_error;
wire [8:0] tmu_source_source_payload_compressed_entries;
wire [1:0] tmu_source_source_payload_compression_type;
wire [7:0] tmu_source_source_payload_master_idle_counter;
wire [7:0] tmu_source_source_payload_waitstate_counter;
wire tmu_pipe_valid_sink_valid;
wire tmu_pipe_valid_sink_ready;
wire tmu_pipe_valid_sink_first;
wire tmu_pipe_valid_sink_last;
wire [31:0] tmu_pipe_valid_sink_payload_haddr;
wire tmu_pipe_valid_sink_payload_hwrite;
wire [2:0] tmu_pipe_valid_sink_payload_hsize;
wire tmu_pipe_valid_sink_payload_error;
wire [8:0] tmu_pipe_valid_sink_payload_compressed_entries;
wire [1:0] tmu_pipe_valid_sink_payload_compression_type;
wire [7:0] tmu_pipe_valid_sink_payload_master_idle_counter;
wire [7:0] tmu_pipe_valid_sink_payload_waitstate_counter;
reg tmu_pipe_valid_source_valid = 1'd0;
wire tmu_pipe_valid_source_ready;
reg tmu_pipe_valid_source_first = 1'd0;
reg tmu_pipe_valid_source_last = 1'd0;
reg [31:0] tmu_pipe_valid_source_payload_haddr = 32'd0;
reg tmu_pipe_valid_source_payload_hwrite = 1'd0;
reg [2:0] tmu_pipe_valid_source_payload_hsize = 3'd0;
reg tmu_pipe_valid_source_payload_error = 1'd0;
reg [8:0] tmu_pipe_valid_source_payload_compressed_entries = 9'd0;
reg [1:0] tmu_pipe_valid_source_payload_compression_type = 2'd0;
reg [7:0] tmu_pipe_valid_source_payload_master_idle_counter = 8'd0;
reg [7:0] tmu_pipe_valid_source_payload_waitstate_counter = 8'd0;
reg tmu_sink_valid = 1'd0;
wire tmu_sink_ready;
reg tmu_sink_first = 1'd0;
reg tmu_sink_last = 1'd0;
reg [31:0] tmu_sink_payload_haddr = 32'd0;
reg tmu_sink_payload_hwrite = 1'd0;
reg [2:0] tmu_sink_payload_hsize = 3'd0;
reg tmu_sink_payload_error = 1'd0;
reg [8:0] tmu_sink_payload_compressed_entries = 9'd0;
reg [1:0] tmu_sink_payload_compression_type = 2'd0;
reg [7:0] tmu_sink_payload_master_idle_counter = 8'd0;
reg [7:0] tmu_sink_payload_waitstate_counter = 8'd0;
wire tmu_source_valid;
reg tmu_source_ready = 1'd0;
wire tmu_source_first;
wire tmu_source_last;
wire [31:0] tmu_source_payload_haddr;
wire tmu_source_payload_hwrite;
wire [2:0] tmu_source_payload_hsize;
wire tmu_source_payload_error;
wire [8:0] tmu_source_payload_compressed_entries;
wire [1:0] tmu_source_payload_compression_type;
wire [7:0] tmu_source_payload_master_idle_counter;
wire [7:0] tmu_source_payload_waitstate_counter;
wire tmu_re;
reg tmu_readable = 1'd0;
wire tmu_syncfifo_we;
wire tmu_syncfifo_writable;
wire tmu_syncfifo_re;
wire tmu_syncfifo_readable;
wire [65:0] tmu_syncfifo_din;
wire [65:0] tmu_syncfifo_dout;
reg [3:0] tmu_level0 = 4'd0;
reg tmu_replace = 1'd0;
reg [2:0] tmu_produce = 3'd0;
reg [2:0] tmu_consume = 3'd0;
reg [2:0] tmu_wrport_adr;
wire [65:0] tmu_wrport_dat_r;
wire tmu_wrport_we;
wire [65:0] tmu_wrport_dat_w;
wire tmu_do_read;
wire [2:0] tmu_rdport_adr;
wire [65:0] tmu_rdport_dat_r;
wire tmu_rdport_re;
wire [3:0] tmu_level1;
wire [31:0] tmu_fifo_in_payload_haddr;
wire tmu_fifo_in_payload_hwrite;
wire [2:0] tmu_fifo_in_payload_hsize;
wire tmu_fifo_in_payload_error;
wire [8:0] tmu_fifo_in_payload_compressed_entries;
wire [1:0] tmu_fifo_in_payload_compression_type;
wire [7:0] tmu_fifo_in_payload_master_idle_counter;
wire [7:0] tmu_fifo_in_payload_waitstate_counter;
wire tmu_fifo_in_first;
wire tmu_fifo_in_last;
wire [31:0] tmu_fifo_out_payload_haddr;
wire tmu_fifo_out_payload_hwrite;
wire [2:0] tmu_fifo_out_payload_hsize;
wire tmu_fifo_out_payload_error;
wire [8:0] tmu_fifo_out_payload_compressed_entries;
wire [1:0] tmu_fifo_out_payload_compression_type;
wire [7:0] tmu_fifo_out_payload_master_idle_counter;
wire [7:0] tmu_fifo_out_payload_waitstate_counter;
wire tmu_fifo_out_first;
wire tmu_fifo_out_last;
reg tmu_config_record = 1'd0;
reg tmu_config_compress = 1'd1;
reg tmu_config_record_errors = 1'd1;
wire tmu_commit;
reg tmu_bus_idle = 1'd0;
reg [31:0] tmu0 = 32'd0;
reg tmu1 = 1'd0;
reg [2:0] tmu2 = 3'd0;
reg tmu3 = 1'd0;
reg [8:0] tmu4 = 9'd0;
reg [1:0] tmu5 = 2'd0;
reg [7:0] tmu6 = 8'd0;
reg [7:0] tmu7 = 8'd0;
reg tmu_config_compress_request = 1'd0;
reg [31:0] tmu8 = 32'd0;
reg tmu9 = 1'd0;
reg [2:0] tmu10 = 3'd0;
reg tmu11 = 1'd0;
reg [8:0] tmu12 = 9'd0;
reg [1:0] tmu13 = 2'd0;
reg [7:0] tmu14 = 8'd0;
reg [7:0] tmu15 = 8'd0;
reg [31:0] tmu_local_address;
reg tmu_write_next_cycle = 1'd0;
reg [31:0] tmu_last_address = 32'd0;
wire [63:0] t_slice_proxy;
wire [63:0] f_slice_proxy;
reg [5:0] basiclowerer_array_muxed0;
reg [5:0] t_array_muxed0;
reg [5:0] basiclowerer_array_muxed1;
reg [5:0] t_array_muxed1;

// synthesis translate_off
reg dummy_s;
initial dummy_s <= 1'd0;
// synthesis translate_on

assign tmu_commit = (((m_hready == 1'd1) & (m_hresp == 1'd0)) & (~tmu_bus_idle));

// synthesis translate_off
reg dummy_d;
// synthesis translate_on
always @(*) begin
	tmu_local_address <= 32'd0;
	if (((i_haddr >= 32'd3221228064) & (i_haddr < 32'd3221228128))) begin
		tmu_local_address <= ((i_haddr - 32'd3221228064) >>> 2'd2);
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
assign tmu_pipe_valid_sink_payload_haddr = tmu_sink_sink_payload_haddr;
assign tmu_pipe_valid_sink_payload_hwrite = tmu_sink_sink_payload_hwrite;
assign tmu_pipe_valid_sink_payload_hsize = tmu_sink_sink_payload_hsize;
assign tmu_pipe_valid_sink_payload_error = tmu_sink_sink_payload_error;
assign tmu_pipe_valid_sink_payload_compressed_entries = tmu_sink_sink_payload_compressed_entries;
assign tmu_pipe_valid_sink_payload_compression_type = tmu_sink_sink_payload_compression_type;
assign tmu_pipe_valid_sink_payload_master_idle_counter = tmu_sink_sink_payload_master_idle_counter;
assign tmu_pipe_valid_sink_payload_waitstate_counter = tmu_sink_sink_payload_waitstate_counter;
assign tmu_source_source_valid = tmu_pipe_valid_source_valid;
assign tmu_pipe_valid_source_ready = tmu_source_source_ready;
assign tmu_source_source_first = tmu_pipe_valid_source_first;
assign tmu_source_source_last = tmu_pipe_valid_source_last;
assign tmu_source_source_payload_haddr = tmu_pipe_valid_source_payload_haddr;
assign tmu_source_source_payload_hwrite = tmu_pipe_valid_source_payload_hwrite;
assign tmu_source_source_payload_hsize = tmu_pipe_valid_source_payload_hsize;
assign tmu_source_source_payload_error = tmu_pipe_valid_source_payload_error;
assign tmu_source_source_payload_compressed_entries = tmu_pipe_valid_source_payload_compressed_entries;
assign tmu_source_source_payload_compression_type = tmu_pipe_valid_source_payload_compression_type;
assign tmu_source_source_payload_master_idle_counter = tmu_pipe_valid_source_payload_master_idle_counter;
assign tmu_source_source_payload_waitstate_counter = tmu_pipe_valid_source_payload_waitstate_counter;
assign tmu_syncfifo_din = {tmu_fifo_in_last, tmu_fifo_in_first, tmu_fifo_in_payload_waitstate_counter, tmu_fifo_in_payload_master_idle_counter, tmu_fifo_in_payload_compression_type, tmu_fifo_in_payload_compressed_entries, tmu_fifo_in_payload_error, tmu_fifo_in_payload_hsize, tmu_fifo_in_payload_hwrite, tmu_fifo_in_payload_haddr};
assign {tmu_fifo_out_last, tmu_fifo_out_first, tmu_fifo_out_payload_waitstate_counter, tmu_fifo_out_payload_master_idle_counter, tmu_fifo_out_payload_compression_type, tmu_fifo_out_payload_compressed_entries, tmu_fifo_out_payload_error, tmu_fifo_out_payload_hsize, tmu_fifo_out_payload_hwrite, tmu_fifo_out_payload_haddr} = tmu_syncfifo_dout;
assign tmu_sink_ready = tmu_syncfifo_writable;
assign tmu_syncfifo_we = tmu_sink_valid;
assign tmu_fifo_in_first = tmu_sink_first;
assign tmu_fifo_in_last = tmu_sink_last;
assign tmu_fifo_in_payload_haddr = tmu_sink_payload_haddr;
assign tmu_fifo_in_payload_hwrite = tmu_sink_payload_hwrite;
assign tmu_fifo_in_payload_hsize = tmu_sink_payload_hsize;
assign tmu_fifo_in_payload_error = tmu_sink_payload_error;
assign tmu_fifo_in_payload_compressed_entries = tmu_sink_payload_compressed_entries;
assign tmu_fifo_in_payload_compression_type = tmu_sink_payload_compression_type;
assign tmu_fifo_in_payload_master_idle_counter = tmu_sink_payload_master_idle_counter;
assign tmu_fifo_in_payload_waitstate_counter = tmu_sink_payload_waitstate_counter;
assign tmu_source_valid = tmu_readable;
assign tmu_source_first = tmu_fifo_out_first;
assign tmu_source_last = tmu_fifo_out_last;
assign tmu_source_payload_haddr = tmu_fifo_out_payload_haddr;
assign tmu_source_payload_hwrite = tmu_fifo_out_payload_hwrite;
assign tmu_source_payload_hsize = tmu_fifo_out_payload_hsize;
assign tmu_source_payload_error = tmu_fifo_out_payload_error;
assign tmu_source_payload_compressed_entries = tmu_fifo_out_payload_compressed_entries;
assign tmu_source_payload_compression_type = tmu_fifo_out_payload_compression_type;
assign tmu_source_payload_master_idle_counter = tmu_fifo_out_payload_master_idle_counter;
assign tmu_source_payload_waitstate_counter = tmu_fifo_out_payload_waitstate_counter;
assign tmu_re = tmu_source_ready;
assign tmu_syncfifo_re = (tmu_syncfifo_readable & ((~tmu_readable) | tmu_re));
assign tmu_level1 = (tmu_level0 + tmu_readable);

// synthesis translate_off
reg dummy_d_1;
// synthesis translate_on
always @(*) begin
	tmu_wrport_adr <= 3'd0;
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
assign tmu_syncfifo_writable = (tmu_level0 != 4'd8);
assign tmu_syncfifo_readable = (tmu_level0 != 1'd0);
assign t_slice_proxy = {tmu_source_payload_waitstate_counter, tmu_source_payload_master_idle_counter, tmu_source_payload_compression_type, tmu_source_payload_compressed_entries, tmu_source_payload_error, tmu_source_payload_hsize, tmu_source_payload_hwrite, tmu_source_payload_haddr};
assign f_slice_proxy = {tmu_source_payload_waitstate_counter, tmu_source_payload_master_idle_counter, tmu_source_payload_compression_type, tmu_source_payload_compressed_entries, tmu_source_payload_error, tmu_source_payload_hsize, tmu_source_payload_hwrite, tmu_source_payload_haddr};

// synthesis translate_off
reg dummy_d_2;
// synthesis translate_on
always @(*) begin
	basiclowerer_array_muxed0 <= 6'd0;
	case (tmu10)
		1'd0: begin
			basiclowerer_array_muxed0 <= 1'd1;
		end
		1'd1: begin
			basiclowerer_array_muxed0 <= 2'd2;
		end
		2'd2: begin
			basiclowerer_array_muxed0 <= 3'd4;
		end
		2'd3: begin
			basiclowerer_array_muxed0 <= 4'd8;
		end
		3'd4: begin
			basiclowerer_array_muxed0 <= 5'd16;
		end
		default: begin
			basiclowerer_array_muxed0 <= 6'd32;
		end
	endcase
// synthesis translate_off
	dummy_d_2 <= dummy_s;
// synthesis translate_on
end

// synthesis translate_off
reg dummy_d_3;
// synthesis translate_on
always @(*) begin
	t_array_muxed0 <= 6'd0;
	case (tmu10)
		1'd0: begin
			t_array_muxed0 <= 1'd1;
		end
		1'd1: begin
			t_array_muxed0 <= 2'd2;
		end
		2'd2: begin
			t_array_muxed0 <= 3'd4;
		end
		2'd3: begin
			t_array_muxed0 <= 4'd8;
		end
		3'd4: begin
			t_array_muxed0 <= 5'd16;
		end
		default: begin
			t_array_muxed0 <= 6'd32;
		end
	endcase
// synthesis translate_off
	dummy_d_3 <= dummy_s;
// synthesis translate_on
end

// synthesis translate_off
reg dummy_d_4;
// synthesis translate_on
always @(*) begin
	basiclowerer_array_muxed1 <= 6'd0;
	case (tmu10)
		1'd0: begin
			basiclowerer_array_muxed1 <= 1'd1;
		end
		1'd1: begin
			basiclowerer_array_muxed1 <= 2'd2;
		end
		2'd2: begin
			basiclowerer_array_muxed1 <= 3'd4;
		end
		2'd3: begin
			basiclowerer_array_muxed1 <= 4'd8;
		end
		3'd4: begin
			basiclowerer_array_muxed1 <= 5'd16;
		end
		default: begin
			basiclowerer_array_muxed1 <= 6'd32;
		end
	endcase
// synthesis translate_off
	dummy_d_4 <= dummy_s;
// synthesis translate_on
end

// synthesis translate_off
reg dummy_d_5;
// synthesis translate_on
always @(*) begin
	t_array_muxed1 <= 6'd0;
	case (tmu10)
		1'd0: begin
			t_array_muxed1 <= 1'd1;
		end
		1'd1: begin
			t_array_muxed1 <= 2'd2;
		end
		2'd2: begin
			t_array_muxed1 <= 3'd4;
		end
		2'd3: begin
			t_array_muxed1 <= 4'd8;
		end
		3'd4: begin
			t_array_muxed1 <= 5'd16;
		end
		default: begin
			t_array_muxed1 <= 6'd32;
		end
	endcase
// synthesis translate_off
	dummy_d_5 <= dummy_s;
// synthesis translate_on
end

always @(posedge sys_clk) begin
	tmu_mem_filled <= (tmu_level1 > 3'd7);
	mem_filled_int <= (tmu_mem_filled & tmu_int_enable);
	tmu5 <= 2'd3;
	tmu4 <= 1'd0;
	if (tmu_commit) begin
		tmu6 <= 1'd0;
	end else begin
		if ((m_htrans == 1'd0)) begin
			if ((tmu6 < 6'd63)) begin
				tmu6 <= (tmu6 + 1'd1);
			end
		end
	end
	if (tmu_commit) begin
		tmu7 <= 1'd0;
	end else begin
		if (((m_hready == 1'd0) & (m_hresp == 1'd0))) begin
			if ((tmu7 < 6'd63)) begin
				tmu7 <= (tmu7 + 1'd1);
			end
		end
	end
	if (tmu_config_record) begin
		if ((m_htrans == 2'd2)) begin
			tmu_bus_idle <= 1'd0;
		end else begin
			if ((((m_htrans == 1'd0) & (m_hready == 1'd1)) & (m_hresp != 1'd1))) begin
				tmu_bus_idle <= 1'd1;
			end
		end
		if (tmu_commit) begin
			tmu3 <= 1'd0;
		end else begin
			if ((m_hresp == 1'd1)) begin
				tmu3 <= 1'd1;
			end
		end
	end
	if ((((m_htrans == 2'd2) & (m_hready == 1'd1)) & tmu_config_record)) begin
		tmu0 <= m_haddr;
		tmu1 <= m_hwrite;
		tmu2 <= m_hsize;
	end
	if (tmu_config_record) begin
		tmu_sink_sink_payload_haddr <= tmu0;
		tmu_sink_sink_payload_hwrite <= tmu1;
		tmu_sink_sink_payload_hsize <= tmu2;
		tmu_sink_sink_payload_error <= tmu3;
		tmu_sink_sink_payload_compressed_entries <= tmu4;
		tmu_sink_sink_payload_compression_type <= tmu5;
		tmu_sink_sink_payload_master_idle_counter <= tmu6;
		tmu_sink_sink_payload_waitstate_counter <= tmu7;
		if ((tmu_commit & ((~tmu3) | tmu_config_record_errors))) begin
			tmu_sink_sink_valid <= 1'd1;
		end else begin
			tmu_sink_sink_valid <= 1'd0;
		end
	end else begin
		tmu_sink_sink_valid <= 1'd0;
	end
	if (tmu_config_compress) begin
		tmu_sink_payload_haddr <= tmu8;
		tmu_sink_payload_hwrite <= tmu9;
		tmu_sink_payload_hsize <= tmu10;
		tmu_sink_payload_error <= tmu11;
		tmu_sink_payload_compressed_entries <= tmu12;
		tmu_sink_payload_compression_type <= tmu13;
		tmu_sink_payload_master_idle_counter <= tmu14;
		tmu_sink_payload_waitstate_counter <= tmu15;
		tmu_source_source_ready <= 1'd1;
		if (tmu_source_source_valid) begin
			if (((((((tmu8 + basiclowerer_array_muxed0) == tmu_source_source_payload_haddr) & ((tmu13 == 1'd1) | (tmu13 == 2'd3))) & (tmu9 == tmu_source_source_payload_hwrite)) & (tmu10 == tmu_source_source_payload_hsize)) & (tmu11 == tmu_source_source_payload_error))) begin
				tmu13 <= 1'd1;
				tmu8 <= (tmu8 + t_array_muxed0);
				if ((tmu12 < 7'd80)) begin
					tmu12 <= (tmu12 + 1'd1);
				end
				if (((tmu14 + tmu_source_source_payload_master_idle_counter) < 6'd63)) begin
					tmu14 <= (tmu14 + tmu_source_source_payload_master_idle_counter);
				end else begin
					tmu14 <= 6'd63;
				end
				if (((tmu15 + tmu_source_source_payload_waitstate_counter) < 6'd63)) begin
					tmu15 <= (tmu15 + tmu_source_source_payload_master_idle_counter);
				end else begin
					tmu15 <= 6'd63;
				end
				tmu_sink_valid <= 1'd0;
			end else begin
				if (((((((tmu8 - basiclowerer_array_muxed1) == tmu_source_source_payload_haddr) & ((tmu13 == 2'd2) | (tmu13 == 2'd3))) & (tmu9 == tmu_source_source_payload_hwrite)) & (tmu10 == tmu_source_source_payload_hsize)) & (tmu11 == tmu_source_source_payload_error))) begin
					tmu13 <= 2'd2;
					tmu8 <= (tmu8 - t_array_muxed1);
					if ((tmu12 < 7'd80)) begin
						tmu12 <= (tmu12 + 1'd1);
					end
					if (((tmu14 + tmu_source_source_payload_master_idle_counter) < 6'd63)) begin
						tmu14 <= (tmu14 + tmu_source_source_payload_master_idle_counter);
					end else begin
						tmu14 <= 6'd63;
					end
					if (((tmu15 + tmu_source_source_payload_waitstate_counter) < 6'd63)) begin
						tmu15 <= (tmu15 + tmu_source_source_payload_master_idle_counter);
					end else begin
						tmu15 <= 6'd63;
					end
					tmu_sink_valid <= 1'd0;
				end else begin
					if ((((((tmu8 == tmu_source_source_payload_haddr) & ((tmu13 == 1'd0) | (tmu13 == 2'd3))) & (tmu9 == tmu_source_source_payload_hwrite)) & (tmu10 == tmu_source_source_payload_hsize)) & (tmu11 == tmu_source_source_payload_error))) begin
						tmu13 <= 1'd0;
						if ((tmu12 < 7'd80)) begin
							tmu12 <= (tmu12 + 1'd1);
						end
						if (((tmu14 + tmu_source_source_payload_master_idle_counter) < 6'd63)) begin
							tmu14 <= (tmu14 + tmu_source_source_payload_master_idle_counter);
						end else begin
							tmu14 <= 6'd63;
						end
						if (((tmu15 + tmu_source_source_payload_waitstate_counter) < 6'd63)) begin
							tmu15 <= (tmu15 + tmu_source_source_payload_master_idle_counter);
						end else begin
							tmu15 <= 6'd63;
						end
						tmu_sink_valid <= 1'd0;
					end else begin
						tmu_config_compress <= tmu_config_compress_request;
						tmu8 <= tmu_source_source_payload_haddr;
						tmu9 <= tmu_source_source_payload_hwrite;
						tmu10 <= tmu_source_source_payload_hsize;
						tmu11 <= tmu_source_source_payload_error;
						tmu12 <= tmu_source_source_payload_compressed_entries;
						tmu13 <= tmu_source_source_payload_compression_type;
						tmu14 <= tmu_source_source_payload_master_idle_counter;
						tmu15 <= tmu_source_source_payload_waitstate_counter;
						tmu_sink_valid <= 1'd1;
					end
				end
			end
		end else begin
			tmu_sink_valid <= 1'd0;
		end
	end
	if ((~tmu_config_compress)) begin
		tmu_sink_payload_haddr <= tmu_source_source_payload_haddr;
		tmu_sink_payload_hwrite <= tmu_source_source_payload_hwrite;
		tmu_sink_payload_hsize <= tmu_source_source_payload_hsize;
		tmu_sink_payload_error <= tmu_source_source_payload_error;
		tmu_sink_payload_compressed_entries <= tmu_source_source_payload_compressed_entries;
		tmu_sink_payload_compression_type <= tmu_source_source_payload_compression_type;
		tmu_sink_payload_master_idle_counter <= tmu_source_source_payload_master_idle_counter;
		tmu_sink_payload_waitstate_counter <= tmu_source_source_payload_waitstate_counter;
		tmu_sink_valid <= tmu_source_source_valid;
		tmu_source_source_ready <= tmu_sink_ready;
		tmu_config_compress <= tmu_config_compress_request;
	end
	if (((tmu_write_next_cycle & (tmu_last_address == 2'd3)) & (i_hwdata == 1'd1))) begin
		tmu_source_ready <= 1'd1;
	end else begin
		tmu_source_ready <= 1'd0;
	end
	if (i_hsel) begin
		tmu_last_address <= tmu_local_address;
		if (tmu_write_next_cycle) begin
			if ((tmu_last_address == 1'd1)) begin
				tmu_config_record <= (i_hwdata & 1'd1);
				tmu_int_enable <= ((i_hwdata & 2'd2) >>> 1'd1);
				tmu_config_compress_request <= ((i_hwdata & 3'd4) >>> 2'd2);
				tmu_config_record_errors <= ((i_hwdata & 4'd8) >>> 2'd3);
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
					o_hrdata <= {tmu_config_compress, tmu_int_enable, tmu_config_record};
				end else begin
					tmu_write_next_cycle <= 1'd1;
				end
			end else begin
				if ((tmu_local_address == 2'd2)) begin
					if ((~i_hwrite)) begin
						o_hrdata <= {(tmu_level1 >= 4'd8), (tmu_level1 == 1'd0), mem_filled_int};
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
		tmu_pipe_valid_source_payload_haddr <= tmu_pipe_valid_sink_payload_haddr;
		tmu_pipe_valid_source_payload_hwrite <= tmu_pipe_valid_sink_payload_hwrite;
		tmu_pipe_valid_source_payload_hsize <= tmu_pipe_valid_sink_payload_hsize;
		tmu_pipe_valid_source_payload_error <= tmu_pipe_valid_sink_payload_error;
		tmu_pipe_valid_source_payload_compressed_entries <= tmu_pipe_valid_sink_payload_compressed_entries;
		tmu_pipe_valid_source_payload_compression_type <= tmu_pipe_valid_sink_payload_compression_type;
		tmu_pipe_valid_source_payload_master_idle_counter <= tmu_pipe_valid_sink_payload_master_idle_counter;
		tmu_pipe_valid_source_payload_waitstate_counter <= tmu_pipe_valid_sink_payload_waitstate_counter;
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
		tmu_sink_sink_valid <= 1'd0;
		tmu_sink_sink_payload_haddr <= 32'd0;
		tmu_sink_sink_payload_hwrite <= 1'd0;
		tmu_sink_sink_payload_hsize <= 3'd0;
		tmu_sink_sink_payload_error <= 1'd0;
		tmu_sink_sink_payload_compressed_entries <= 9'd0;
		tmu_sink_sink_payload_compression_type <= 2'd0;
		tmu_sink_sink_payload_master_idle_counter <= 8'd0;
		tmu_sink_sink_payload_waitstate_counter <= 8'd0;
		tmu_source_source_ready <= 1'd0;
		tmu_pipe_valid_source_valid <= 1'd0;
		tmu_pipe_valid_source_payload_haddr <= 32'd0;
		tmu_pipe_valid_source_payload_hwrite <= 1'd0;
		tmu_pipe_valid_source_payload_hsize <= 3'd0;
		tmu_pipe_valid_source_payload_error <= 1'd0;
		tmu_pipe_valid_source_payload_compressed_entries <= 9'd0;
		tmu_pipe_valid_source_payload_compression_type <= 2'd0;
		tmu_pipe_valid_source_payload_master_idle_counter <= 8'd0;
		tmu_pipe_valid_source_payload_waitstate_counter <= 8'd0;
		tmu_sink_valid <= 1'd0;
		tmu_sink_payload_haddr <= 32'd0;
		tmu_sink_payload_hwrite <= 1'd0;
		tmu_sink_payload_hsize <= 3'd0;
		tmu_sink_payload_error <= 1'd0;
		tmu_sink_payload_compressed_entries <= 9'd0;
		tmu_sink_payload_compression_type <= 2'd0;
		tmu_sink_payload_master_idle_counter <= 8'd0;
		tmu_sink_payload_waitstate_counter <= 8'd0;
		tmu_source_ready <= 1'd0;
		tmu_readable <= 1'd0;
		tmu_level0 <= 4'd0;
		tmu_produce <= 3'd0;
		tmu_consume <= 3'd0;
		tmu_config_record <= 1'd0;
		tmu_config_compress <= 1'd1;
		tmu_config_record_errors <= 1'd1;
		tmu_bus_idle <= 1'd0;
		tmu0 <= 32'd0;
		tmu1 <= 1'd0;
		tmu2 <= 3'd0;
		tmu3 <= 1'd0;
		tmu4 <= 9'd0;
		tmu5 <= 2'd0;
		tmu6 <= 8'd0;
		tmu7 <= 8'd0;
		tmu_config_compress_request <= 1'd0;
		tmu8 <= 32'd0;
		tmu9 <= 1'd0;
		tmu10 <= 3'd0;
		tmu11 <= 1'd0;
		tmu12 <= 9'd0;
		tmu13 <= 2'd0;
		tmu14 <= 8'd0;
		tmu15 <= 8'd0;
		tmu_write_next_cycle <= 1'd0;
		tmu_last_address <= 32'd0;
	end
end

reg [65:0] storage[0:7];
reg [65:0] memdat;
reg [65:0] memdat_1;
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
