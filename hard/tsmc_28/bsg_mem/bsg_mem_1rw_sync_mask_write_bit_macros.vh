`ifndef BSG_MEM_1RW_SYNC_MASK_WRITE_BIT_MACROS_VH
`define BSG_MEM_1RW_SYNC_MASK_WRITE_BIT_MACROS_VH

`define bsg_mem_1rw_sync_mask_write_bit_1rf_macro(words,bits,mux)       \
  if (harden_p && els_p == words && width_p == bits) \
    begin: macro                                     \
          tsmc28_1rw_d``words``_w``bits``_m``mux``_bit_1rf mem  \
            (                                                   \
              .CLK      ( clk_i         )                       \
             ,.CEB      ( ~v_i          )                       \
             ,.WEB      ( ~w_i          )                       \
             ,.BWEB     ( ~w_mask_i     )                       \
             ,.A        ( addr_i        )                       \
             ,.D        ( data_i        )                       \
             ,.Q        ( data_o        )                       \
             ,.CLKW     ( clk_i         )                       \
            );                                                  \
    end

`define bsg_mem_1rw_sync_mask_write_bit_1sram_macro(words,bits,mux)       \
  if (harden_p && els_p == words && width_p == bits) \
    begin: macro                                     \
          tsmc28_1rw_d``words``_w``bits``_m``mux``_bit_1sram mem  \
            (                                                   \
              .CLK      ( clk_i         )                       \
             ,.CEB      ( ~v_i          )                       \
             ,.WEB      ( ~w_i          )                       \
             ,.BWEB     ( ~w_mask_i     )                       \
             ,.A        ( addr_i        )                       \
             ,.D        ( data_i        )                       \
             ,.Q        ( data_o        )                       \
             ,.CLKW     ( clk_i         )                       \
            );                                                  \
    end

`define bsg_mem_1rw_sync_mask_write_bit_1hdsram_macro(words,bits,mux)       \
  if (harden_p && els_p == words && width_p == bits) \
    begin: macro                                     \
          tsmc28_1rw_d``words``_w``bits``_m``mux``_bit_1hdsram mem  \
            (                                                   \
              .CLK      ( clk_i         )                       \
             ,.CEB      ( ~v_i          )                       \
             ,.WEB      ( ~w_i          )                       \
             ,.BWEB     ( ~w_mask_i     )                       \
             ,.A        ( addr_i        )                       \
             ,.D        ( data_i        )                       \
             ,.Q        ( data_o        )                       \
             ,.RTSEL    ( 2'b01         )                       \
             ,.WTSEL    ( 2'b00         )                       \
            );                                                  \
    end

`define bsg_mem_1rw_sync_mask_write_bit_banked_macro(words,bits,wbank,dbank) \
  if (harden_p && els_p == words && width_p == bits) begin: macro \
    bsg_mem_1rw_sync_mask_write_bit_banked #(                     \
      .width_p(width_p)                                                     \
      ,.els_p(els_p)                                                        \
      ,.latch_last_read_p(latch_last_read_p)                                \
      ,.num_width_bank_p(wbank)                                             \
      ,.num_depth_bank_p(dbank)                                             \
    ) bmem (                                                                \
      .clk_i(clk_i)                                                         \
      ,.reset_i(reset_i)                                                    \
      ,.v_i(v_i)                                                            \
      ,.w_i(w_i)                                                            \
      ,.addr_i(addr_i)                                                      \
      ,.data_i(data_i)                                                      \
      ,.w_mask_i(w_mask_i)                                                  \
      ,.data_o(data_o)                                                      \
    );                                                                      \
  end: macro

`endif

