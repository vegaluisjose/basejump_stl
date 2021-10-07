`ifndef BSG_MEM_1RW_SYNC_MASK_WRITE_BYTE_MACROS_VH
`define BSG_MEM_1RW_SYNC_MASK_WRITE_BYTE_MACROS_VH

`define bsg_mem_1rw_sync_mask_write_byte_1rf_macro(words,bits,mux) \
  `bsg_mem_1rw_sync_mask_write_byte_macro(words,bits)
`define bsg_mem_1rw_sync_mask_write_byte_1sram_macro(words,bits,mux) \
  `bsg_mem_1rw_sync_mask_write_byte_macro(words,bits)
`define bsg_mem_1rw_sync_mask_write_byte_1hdsram_macro(words,bits,mux) \
  `bsg_mem_1rw_sync_mask_write_byte_macro(words,bits)

`define bsg_mem_1rw_sync_mask_write_byte_macro(words,bits) \
if (els_p == words && data_width_p == bits)                     \
  begin: wrap                                                   \
    logic [data_width_p-1:0] w_mask_li;                         \
    bsg_expand_bitmask                                          \
     #(.in_width_p(write_mask_width_lp), .expand_p(8))          \
     wmask_expand                                               \
      (.i(write_mask_i)                                         \
       ,.o(w_mask_li)                                           \
       );                                                       \
                                                                \
    bsg_mem_1rw_sync_mask_write_bit                             \
     #(.width_p(data_width_p), .els_p(els_p))                   \
     bit_mem                                                    \
      (.w_mask_i(w_mask_li), .*);                               \
  end

`endif 
