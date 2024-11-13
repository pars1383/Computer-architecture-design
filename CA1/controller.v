module controller (input clk, sclr, start, bZero, co, lt, qNotZero, cNine, output reg init0, dvz, ovf, busy, valid, shLQ, shLACC, setQ0, ldACC, ldC, ldB, ldQ, inc);
    reg [3:0] ps, ns;
	parameter [3:0]
    s0 =0 , s1 = 1, s2 =2, s3 = 3, s4 = 4 , s5 = 5 , s6 = 6 , s7 = 7 , s8 = 8 , s9 = 9 , s10 = 10, s11 = 11;
    
	always @(ps, start, bZero, co, lt, qNotZero, cNine) begin
        ns = s0;
 
        case(ps)
            s0: ns = start ? s1 : s0;
			s1: ns = s2;
            s2: ns = bZero ? s3 : s4;
            s3: ns = s4;
            s4: ns = s5;
            s5: ns = co ? s11 : (lt ? s8 : s6);
            s6: ns = s7;
            s7: ns = s9;
            s8: ns = s9;
            s9: ns = (qNotZero & cNine) ? s10 : s5;
            s10: ns = s0;
            s11: ns = s0;
        endcase
    end


	always @(ps) begin
		{busy, ldB, ldQ, ldC, ldACC, dvz, init0, shLQ, shLACC, setQ0, inc, ovf, valid} = 13'b0;
 
        case(ps)
            s0: {busy} = 1'b0;
			s1: {ldB, ldQ, init0, busy} = 4'b1111;
			s2: ;
            s3: {dvz} = 1'b1;
            s4: {shLQ, shLACC, setQ0, ldC} = 4'b1101;
            s5: {inc} = 1'b1;
            s6: {ldACC} = 1'b1;
            s7: {shLQ , shLACC , setQ0} = 3'b111;
            s8: {shLQ , shLACC , setQ0} = 3'b110;
			s9: ;
            s10: {ovf} = 1'b1;
            s11: {valid} = 1'b1;
        endcase
    end

    always @(posedge clk) begin
		if(sclr)
			ps <= 4'b0;
		else
        	ps <= ns;
    end
endmodule