module tt_um_example (
 (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path
    input  wire       ena,      // always 1 when the design is powered or selected
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low active
);

    // ইনপুট ও আউটপুট ম্যাপিং
    wire rst = !rst_n;          // rst_n কে active-high করা হলো
    wire en  = ui_in[0];        // ui_in এর ০ নম্বর পিনটি Enable হিসেবে কাজ করবে
    reg [3:0] count;

    // ৪-বিট আউটপুটকে uo_out এর প্রথম ৪টি পিনের সাথে জুড়ে দেওয়া হলো
    assign uo_out = {4'b0000, count}; 

    // ব্যবহার না করা পিনগুলো বন্ধ রাখা হলো
    assign uio_out = 8'b00000000;
    assign uio_oe  = 8'b00000000;

    // ৪-বিট ডাউন কাউন্টার লজিক
    always @(posedge clk) begin
        if (rst)
            count <= 4'b0000;
        else if (en)
            count <= count - 4'b0001; 
    end

endmodule
