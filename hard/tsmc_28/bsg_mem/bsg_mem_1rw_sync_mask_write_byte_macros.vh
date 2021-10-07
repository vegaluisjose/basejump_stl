`ifndef BSG_MEM_1RW_SYNC_MASK_WRITE_BYTE_MACROS_VH
`define BSG_MEM_1RW_SYNC_MASK_WRITE_BYTE_MACROS_VH

`define bsg_mem_1rw_sync_mask_write_2hdsram_byte_macro(words,bits,mux) \
if (els_p == words && width_p == bits)                          \
  begin: wrap                                                   \              
    logic [width_p-1:0] w_mask_li;                              \
    bsg_expand_bitmask                                          \
     #(.in_width_p(write_mask_width_lp), .expand_p(8))          \
     wmask_expand                                               \
      (.i(w_mask_i)                                             \
       ,.o(w_mask_li)                                           \
       );                                                       \
                                                                \
    bsg_mem_1rw_sync_mask_write_bit                             \
     #(.width_p(width_p), .els_p(els_p))                        \
     bit_mem                                                    \
      (.w_mask_i(w_mask_li), .*);                               \
  end

`endif 
