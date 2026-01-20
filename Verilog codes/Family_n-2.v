

module mul8(
    input  signed [7:0] A,
    input  signed [7:0] B,
    output signed [15:0] O
);
  
  wire [8:0] pp [7:0];


  assign pp[0][0] = 1'b0;
  assign pp[0][1] = 1'b0;
  assign pp[0][2] = 1'b0;
  assign pp[0][3] = 1'b0;
  assign pp[0][4] = 1'b0;
  assign pp[0][5] = 1'b0;
  assign pp[0][6] =  A[0] & B[6];
  assign pp[0][7] = ~(A[0] & B[7]);
  assign pp[0][8] =  1'b1;                

 
  assign pp[1][0] = 1'b0;
  assign pp[1][1] = 1'b0;
  assign pp[1][2] = 1'b0;
  assign pp[1][3] = 1'b0;
  assign pp[1][4] = 1'b0;
  assign pp[1][5] =  A[1] & B[5];
  assign pp[1][6] =  A[1] & B[6];
  assign pp[1][7] = ~(A[1] & B[7]);
  assign pp[1][8] =  1'b0;

  
  assign pp[2][0] = 1'b0;
  assign pp[2][1] = 1'b0;
  assign pp[2][2] = 1'b0;
  assign pp[2][3] = 1'b0;
  assign pp[2][4] =  A[2] & B[4];
  assign pp[2][5] =  A[2] & B[5];
  assign pp[2][6] =  A[2] & B[6];
  assign pp[2][7] = ~(A[2] & B[7]);
  assign pp[2][8] =  1'b0;

  assign pp[3][0] = 1'b0;
  assign pp[3][1] = 1'b0;
  assign pp[3][2] = 1'b0;
  assign pp[3][3] =  A[3] & B[3];
  assign pp[3][4] =  A[3] & B[4];
  assign pp[3][5] =  A[3] & B[5];
  assign pp[3][6] =  A[3] & B[6];
  assign pp[3][7] = ~(A[3] & B[7]);
  assign pp[3][8] =  1'b0;

  
  assign pp[4][0] = 1'b0;
  assign pp[4][1] = 1'b0;
  assign pp[4][2] =  A[4] & B[2];
  assign pp[4][3] =  A[4] & B[3];
  assign pp[4][4] =  A[4] & B[4];
  assign pp[4][5] =  A[4] & B[5];
  assign pp[4][6] =  A[4] & B[6];
  assign pp[4][7] = ~(A[4] & B[7]);
  assign pp[4][8] =  1'b0;

 
  assign pp[5][0] = 1'b0;
  assign pp[5][1] =  A[5] & B[1];
  assign pp[5][2] =  A[5] & B[2];
  assign pp[5][3] =  A[5] & B[3];
  assign pp[5][4] =  A[5] & B[4];
  assign pp[5][5] =  A[5] & B[5];
  assign pp[5][6] =  A[5] & B[6];
  assign pp[5][7] = ~(A[5] & B[7]);
  assign pp[5][8] =  1'b0;

  
  assign pp[6][0] =  A[6] & B[0];
  assign pp[6][1] =  A[6] & B[1];
  assign pp[6][2] =  A[6] & B[2];
  assign pp[6][3] =  A[6] & B[3];
  assign pp[6][4] =  A[6] & B[4];
  assign pp[6][5] =  A[6] & B[5];
  assign pp[6][6] =  A[6] & B[6];
  assign pp[6][7] = ~(A[6] & B[7]);
  assign pp[6][8] =  1'b0;

  
  assign pp[7][0] = ~(A[7] & B[0]);
  assign pp[7][1] = ~(A[7] & B[1]);
  assign pp[7][2] = ~(A[7] & B[2]);
  assign pp[7][3] = ~(A[7] & B[3]);
  assign pp[7][4] = ~(A[7] & B[4]);
  assign pp[7][5] = ~(A[7] & B[5]);
  assign pp[7][6] = ~(A[7] & B[6]);
  assign pp[7][7] =  (A[7] & B[7]);
  assign pp[7][8] =  1'b1;               

  
  wire s6a,c7a, s6b,c7b;
  FA fa6a (.a(pp[0][6]), .b(pp[1][5]), .cin(pp[2][4]), .s(s6a), .cout(c7a));
  FA fa6b (.a(pp[3][3]), .b(pp[4][2]), .cin(pp[5][1]), .s(s6b), .cout(c7b));


  wire s7a,c8a, s7b,c8b, s7f,c8f;
  FA  fa7a (.a(pp[0][7]), .b(pp[1][6]), .cin(pp[2][5]), .s(s7a), .cout(c8a));
  FA  fa7b (.a(pp[3][4]), .b(pp[4][3]), .cin(pp[5][2]), .s(s7b), .cout(c8b));
  HA  ha7f (.a(pp[6][1]), .b(pp[7][0]), .s(s7f), .c(c8f));

  
  
wire s71;
 
  wire s8_ac, c9_ac, c_special;
  
  FA ac87 (.a(pp[0][8]), .b(pp[1][7]), .cin(pp[2][6]), .s(s8_ac), .cout(c9_ac)); 
    

  wire s8b,c9b, s8c,c9c, s8d,c9d, t8s,t9d, c9e;
  FA  fa8b (.a(pp[4][4]), .b(pp[5][3]), .cin(pp[6][2]), .s(s8b), .cout(c9b));
  
  HA dh54 (.a(pp[3][5]),.b(pp[7][1]), .s(s71), .c(c_special));



  
  wire s9a,c10a, s9b,c10b;
  FA fa9a (.a(pp[2][7]), .b(pp[3][6]), .cin(pp[4][5]), .s(s9a), .cout(c10a));
  FA fa9b (.a(pp[5][4]), .b(pp[6][3]), .cin(pp[7][2]), .s(s9b), .cout(c10b));

  
  wire s10a,c11a, s10b,c11b;
  FA fa10a (.a(pp[3][7]), .b(pp[4][6]), .cin(pp[5][5]), .s(s10a), .cout(c11a));
  HA fa10b (.a(pp[6][4]), .b(pp[7][3]), .s(s10b), .c(c11b));

 
  wire s11a,c12a;
  FA fa11a (.a(pp[4][7]), .b(pp[5][6]), .cin(pp[6][5]), .s(s11a), .cout(c12a));

  
  wire s12a,c13a;
  FA fa12a (.a(pp[5][7]), .b(pp[6][6]), .cin(pp[7][5]), .s(s12a), .cout(c13a));

 
  wire s13a,c14a;
  HA ha13a (.a(pp[6][7]), .b(pp[7][6]), .s(s13a), .c(c14a));

  
  wire g1,g2,g3,g4,g5,g6,g7,g8,g9,g10,g11,g12,g13,g14,g15,g16,g17;
  wire h1,h2,h3,h4,h5,h6,h7,h8,h9,h10,h11,h12,h13,h14,h15,h16,h17;

  assign g1 = 1'b0;
  assign h1 = 1'b0;
  
  assign g2 = 1'b0;
  assign h2 = 1'b0;

 
  FA  ddd2 (.a(s6a), .b(s6b), .cin(pp[6][0]), .s(g3), .cout(h3));
  
  assign g4 = 1'b0;
  assign h4 = 1'b0;

  
  FA  ddd3 (.a(s7a), .b(s7b), .cin(s7f), .s(g5), .cout(h5));
  HA  dsd3 (.a(c7a), .b(c7b), .s(g6), .c(h6));

  
  FA  ddd4   (.a(s8_ac), .b(s8b), .cin(s71), .s(g7), .cout(h7));
  FA  ddd774 (.a(c8a),   .b(c8b), .cin(c8f),      .s(g8), .cout(h8));

  
  HA  dsd5  (.a(s9a),   .b(s9b),    .s(g9),  .c(h9));
  FA  dsd67 (.a(c9_ac), .b(c9b),    .cin(c_special), .s(g10), .cout(h10));

  
  HA  dsd6    (.a(s10a), .b(s10b), .s(g11), .c(h11));
  HA  dsd6793 (.a(c10a), .b(c10b), .s(g12), .c(h12));

  
  HA  dsd677  (.a(s11a), .b(pp[7][4]), .s(g13), .c(h13));
  HA  dsd7878 (.a(c11a), .b(c11b),     .s(g14), .c(h14));

  
  HA  dsd8 (.a(s12a), .b(c12a), .s(g15), .c(h15));

  
  HA  dsd9 (.a(s13a), .b(c13a), .s(g16), .c(h16));

  
  HA  dsd10(.a(pp[7][7]), .b(c14a), .s(g17), .c(h17));

  
  wire m2,m3,m4,m5,m6,m7,m8,m9,m10,m11;
  wire n2,n3,n4,n5,n6,n7,n8,n9,n10,n11;

  FA  dsd12(.a(g3),  .b(g4),  .cin(h1),  .s(m2),  .cout(n2));  
  FA  dsd13(.a(g5),  .b(g6),  .cin(h3),  .s(m3),  .cout(n3));
  FA  dsd14(.a(g7),  .b(g8),  .cin(h5),  .s(m4),  .cout(n4));
  FA  dsd15(.a(g9),  .b(g10), .cin(h7),  .s(m5),  .cout(n5));
  FA  dsd16(.a(g11), .b(g12), .cin(h9),  .s(m6),  .cout(n6));
  FA  dsd17(.a(g13), .b(g14), .cin(h11), .s(m7),  .cout(n7));
  FA  dsd19(.a(g15), .b(h13), .cin(h14), .s(m8),  .cout(n8));
  HA  dsd20(.a(g16), .b(h15), .s(m9),  .c(n9));
  HA  dsd21(.a(g17), .b(h16), .s(m10), .c(n10));
  HA  ffg21(.a(1'b1), .b(h17), .s(m11), .c(n11));

  
  wire p2,p3,p4,p5,p6,p7,p8,p9,p10;
  wire q1,q2,q3,q4,q5,q6,q7,q8,q9,q10;

  
  wire sum6;
  assign sum6 = m2;
  assign q1   = 1'b0;

  FA  dsd133  (.a(m3),  .b(h4),  .cin(n2), .s(p2),  .cout(q2)); 
  FA  dsd13333(.a(m4),  .b(h6),  .cin(n3), .s(p3),  .cout(q3));
  FA  w32     (.a(m5),  .b(h8),  .cin(n4), .s(p4),  .cout(q4));
  FA  w33     (.a(m6),  .b(h10), .cin(n5), .s(p5),  .cout(q5));
  FA  w34     (.a(m7),  .b(h12), .cin(n6), .s(p6),  .cout(q6));
  HA  w35     (.a(m8),  .b(n7),  .s(p7),  .c(q7));
  HA  w36     (.a(m9),  .b(n8),  .s(p8),  .c(q8));
  HA  w37     (.a(m10), .b(n9),  .s(p9),  .c(q9));
  HA  w38     (.a(m11), .b(n10), .s(p10), .c(q10));

 
  wire sum7,sum8,sum9,sum10,sum11,sum12,sum13,sum14,sum15;
  wire z1,z2,z3,z4,z5,z6,z7,z8,z9;

  HA  ddsd1633(.a(p2),  .b(q1), .s(sum7),  .c(z1));
  FA  ddsd1733(.a(p3),  .b(q2), .cin(z1), .s(sum8),  .cout(z2));
  FA  dsdd1833(.a(p4),  .b(q3), .cin(z2), .s(sum9),  .cout(z3));
  FA  ddsd1933(.a(p5),  .b(q4), .cin(z3), .s(sum10), .cout(z4));
  FA  ddsd1033(.a(p6),  .b(q5), .cin(z4), .s(sum11), .cout(z5));
  FA  ddsd1333(.a(p7),  .b(q6), .cin(z5), .s(sum12), .cout(z6));
  FA  ddsd1343(.a(p8),  .b(q7), .cin(z6), .s(sum13), .cout(z7));
  FA  ddsd1335(.a(p9),  .b(q8), .cin(z7), .s(sum14), .cout(z8));
  FA  ddsd1363(.a(p10), .b(q9), .cin(z8), .s(sum15), .cout(z9));


  assign O = {sum15,sum14,sum13,sum12,sum11,
              sum10,sum9,sum8,sum7,sum6,
              1'b0,1'b0,1'b0,1'b0,1'b0,1'b0};

endmodule

module HA (input a,b, output s,c);
  assign s = a ^ b;
  assign c = a & b;
endmodule

module FA (input a,b,cin, output s,cout);
  assign s    = a ^ b ^ cin;
  assign cout = (a & b) | (a & cin) | (b & cin);
endmodule

