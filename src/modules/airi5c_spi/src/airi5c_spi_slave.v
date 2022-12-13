//
// Copyright 2022 FRAUNHOFER INSTITUTE OF MICROELECTRONIC CIRCUITS AND SYSTEMS (IMS), DUISBURG, GERMANY.
// --- All rights reserved --- 
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
// Licensed under the Solderpad Hardware License v 2.1 (the “License”);
// you may not use this file except in compliance with the License, or, at your option, the Apache License version 2.0.
// You may obtain a copy of the License at
// https://solderpad.org/licenses/SHL-2.1/
// Unless required by applicable law or agreed to in writing, any work distributed under the License is distributed on an “AS IS” BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and limitations under the License.
//

module airi5c_spi_slave
#(
    parameter                   DATA_WIDTH = 8
)
(
    input                       clk,
    input                       n_reset,
    input                       enable,

    input                       mosi,
    output                      miso,
    input                       sclk,
    input                       ss,

    input                       clk_polarity,
    input                       clk_phase,

    input                       tx_empty,

    output                      tx_rclk,
    output  reg                 pop,
    input   [DATA_WIDTH-1:0]    data_in,

    output                      rx_wclk,
    output  reg                 push,
    output  [DATA_WIDTH-1:0]    data_out,

    output  reg                 busy
);
    
    wire                        clk_int         = sclk ^ clk_polarity ^ clk_phase;

    reg     [DATA_WIDTH-1:0]    tx_buffer;
    wire    [DATA_WIDTH-1:0]    tx_buffer_din   = tx_empty ? 0 : data_in;
    reg     [4:0]               tx_bit_counter;
    reg                         tx_busy;

    reg     [DATA_WIDTH-1:0]    rx_buffer;
    reg     [4:0]               rx_bit_counter;
    reg                         rx_busy;

    wire                        busy_sclk       = tx_busy || rx_busy;
    reg                         busy_metastable;

    // last bit needs bypass, otherwise there would be no clock edge to push the data
    // first bit needs bypass when phase = 0, because master samples on same clock edge as tx buffer is loaded
    assign                      data_out        = push ? {rx_buffer[DATA_WIDTH-2:0], mosi} : rx_buffer;
    assign                      miso            = clk_phase || tx_busy ? tx_buffer[DATA_WIDTH-1] : tx_buffer_din[DATA_WIDTH-1];
    assign                      tx_rclk         = !clk_int;
    assign                      rx_wclk         = clk_int;

    // busy signal is set in sclk domain and needs to be crossed into clk domain
    always @(posedge clk, negedge n_reset) begin
        if (!n_reset) begin
            busy_metastable <= 1'b0;
            busy            <= 1'b0;
        end

        else begin
            busy_metastable <= busy_sclk;
            busy            <= busy_metastable;
        end
    end

    // posedge
    always @(posedge clk_int, negedge n_reset) begin
        if (!n_reset) begin
            rx_buffer       <= 0;
            rx_bit_counter  <= 5'h00;
            rx_busy         <= 1'b0;
            push            <= 1'b0;
        end

        else if (!enable || ss) begin
            rx_buffer       <= 0;
            rx_bit_counter  <= 5'h00;
            rx_busy         <= 1'b0;
            push            <= 1'b0;
        end

        else begin
            rx_buffer       <= {rx_buffer[DATA_WIDTH-2:0], mosi};
            push            <= rx_bit_counter == DATA_WIDTH - 2;

            if (!rx_busy) begin
                rx_bit_counter  <= 5'd1;
                rx_busy         <= 1'b1;
            end

            else begin
                if (rx_bit_counter == DATA_WIDTH - 1) begin
                    rx_bit_counter  <= 5'd0;
                    rx_busy         <= 1'b0;
                end

                else
                    rx_bit_counter  <= rx_bit_counter + 5'd1;
            end
        end
    end

    // negedge
    always @(negedge clk_int, negedge n_reset) begin
        if (!n_reset) begin
            tx_buffer           <= 0;
            tx_bit_counter      <= 5'h00;
            tx_busy             <= 1'b0;
            pop                 <= 1'b0;
        end

        else if (!enable || ss) begin
            tx_buffer           <= 0;
            tx_bit_counter      <= 5'h00;
            tx_busy             <= 1'b0;
            pop                 <= 1'b0;
        end

        else begin
            if (!tx_busy) begin
                tx_buffer       <= tx_buffer_din << !clk_phase;
                tx_bit_counter  <= 5'd1;
                tx_busy         <= 1'b1;
                pop             <= !tx_empty;
            end

            else begin
                tx_buffer       <= tx_buffer << 1;
                pop             <= 1'b0;

                if (tx_bit_counter == DATA_WIDTH - 1) begin
                    tx_bit_counter  <= 5'd0;
                    tx_busy         <= 1'b0;
                end

                else
                    tx_bit_counter  <= tx_bit_counter + 5'd1;
            end
        end
    end

endmodule