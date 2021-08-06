
`include "bsg_defines.v"

module bsg_fifo_1r1w_small_hardened_cov

 #(parameter els_p = "inv"
  ,localparam ptr_width_lp = `BSG_SAFE_CLOG2(els_p)
  )

  (input clk_i
  ,input reset_i

  // interface signals
  ,input v_i
  ,input yumi_i

  // internal registers
  ,input [ptr_width_lp-1:0] rptr_r
  ,input [ptr_width_lp-1:0] wptr_r
  ,input full
  ,input empty
  ,input read_write_same_addr_r
  );

  // reset
  covergroup cg_reset @(negedge clk_i);
    coverpoint reset_i;
  endgroup

  // empty
  covergroup cg_empty @ (negedge clk_i iff ~reset_i & empty & ~full);

    cp_v: coverpoint v_i;
    // cannot deque when empty
    cp_yumi: coverpoint yumi_i {ignore_bins ig = {1};}
    cp_rptr: coverpoint rptr_r;
    cp_wptr: coverpoint wptr_r;
    // fifo cannot be empty if write happened in previous cycle
    cp_rwsa: coverpoint read_write_same_addr_r {ignore_bins ig = {1};}

    cross_all: cross cp_v, cp_yumi, cp_rptr, cp_wptr, cp_rwsa {
      ignore_bins ig0 = cross_all with (cp_rptr != cp_wptr);
    }

  endgroup

  // full
  covergroup cg_full @ (negedge clk_i iff ~reset_i & ~empty & full);

    cp_v: coverpoint v_i;
    cp_yumi: coverpoint yumi_i;
    cp_rptr: coverpoint rptr_r;
    cp_wptr: coverpoint wptr_r;
    // If read write same address happened in previous cycle, fifo should
    // only have one element in current cycle, which contradicts with the
    // condition that fifo is full.
    cp_rwsa: coverpoint read_write_same_addr_r {ignore_bins ig = {1};}

    cross_all: cross cp_v, cp_yumi, cp_rptr, cp_wptr, cp_rwsa {
      ignore_bins ig0 = cross_all with (cp_rptr != cp_wptr);
    }

  endgroup

  // fifo normal
  covergroup cg_normal @ (negedge clk_i iff ~reset_i & ~empty & ~full);

    cp_v: coverpoint v_i;
    cp_yumi: coverpoint yumi_i;
    cp_rptr: coverpoint rptr_r;
    cp_wptr: coverpoint wptr_r;
    cp_rwsa: coverpoint read_write_same_addr_r;

    cross_all: cross cp_v, cp_yumi, cp_rptr, cp_wptr, cp_rwsa {
      ignore_bins ig0 = cross_all with (cp_rptr == cp_wptr);
      // If read write same address happened in previous cycle, fifo should
      // only have one element in current cycle. Write pointer should be read
      // pointer plus one (or wrapped-around).
      ignore_bins ig1 = cross_all with (
        (cp_rwsa == 1)
        && (cp_wptr - cp_rptr != 1)
        && (cp_wptr - cp_rptr != 1-els_p)
        );
    }

  endgroup

  initial
  begin
    cg_reset reset = new;
    cg_empty empty = new;
    cg_full full = new;
    cg_normal normal = new;
  end

endmodule
