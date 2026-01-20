module AC (input a, input b, input c, input d,
                 output s, cout);
				 
  wire s1,s2,s3,s4,s5,s6,s7,s8;
  assign s1 = a & b;
  assign s2 = c & d;
  assign s3 = a | b;
  assign s4 = c | d;
  assign s5 = s3 & s4;
   assign s = s5;
  assign cout  = s1 | s2 | s5;
  

endmodule