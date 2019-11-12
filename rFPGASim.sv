module rFPGASim;

    localparam NUMBER_OF_POSTS = 10;

    initial begin
        plantASeed();
        displayTitle();
        repeat (NUMBER_OF_POSTS) begin
            case (rollDice(3))
                0: HomeworkHelp();
                1: WhichBoardToBuy();
                2: ProjectHelp();
                3: HowDoIGetStarted();
            endcase
        end
    end

    task displayTitle();
        $display("");
        $display("Welcome to /r/FPGA!");
        $display("");
    endtask

    task HomeworkHelp();
        if (coinFlip())
            $write("Help! ");
        else
            $write("I don't understand. ");

        if (coinFlip())
            $display("What's wrong with my %s?", randAssignment());
        else
            $display("How do I get this %s to work?", randAssignment());

        $display("");
    endtask

    task WhichBoardToBuy();
        string rand_board1, rand_board2;

        case (rollDice(2))
            0: $write("Need advice: ");
            1: $write("Can't decide between ");
            2: $write("Which board should I buy? ");
        endcase

        rand_board1 = {randBrand(), randModel(), randSeller()};
        rand_board2 = {randBrand(), randModel(), randSeller()};

        $display("%s or %s", rand_board1, rand_board2);
        $display("");

    endtask

    task ProjectHelp();

        $write("Hi I'd like to make a ");

        case (rollDice(5))
            0: $write("bitcoin miner ");
            1: $write("HFT algorithm ");
            2: $write("web page ");
            3: $write("database ");
            4: $write("transistor radio ");
            5: $write("time machine ");
        endcase

        $write("with FPGAs. ");

        case (rollDice(2))
            0: $display("Where should I start?");
            1: $display("Which is better for this: Verilog or VHDL?");
            2: $display("Is there a book for this?");
        endcase

        $display("");

    endtask

    task HowDoIGetStarted();

        $write("I'm ");

        case (rollDice(4))
            0: $write("a noob. ");
            1: $write("a sophomore. ");
            2: $write("a junior. ");
            3: $write("a software engineer. ");
            4: $write("an unemployed janitor. ");
        endcase

        $write("I want to learn how to ");

        case (rollDice(2))
            0: $write("build ");
            1: $write("program ");
            2: $write("design ");
        endcase

        $display("FPGAs. Where do I start?");
        $display("");

    endtask

    function string randAssignment();
        randAssignment = "";
        // generate 2 adjectives
        repeat (2)
            case (rollDice(5))
                0: randAssignment = {randAssignment, "ripple "};
                1: randAssignment = {randAssignment, "carry "};
                2: randAssignment = {randAssignment, "look-ahead "};
                3: randAssignment = {randAssignment, "Mealy "};
                4: randAssignment = {randAssignment, "Moore "};
                5: randAssignment = {randAssignment, "DDR "};
            endcase
        // generate a noun
        case (rollDice(4))
            0: randAssignment = {randAssignment, "LFSR"};
            1: randAssignment = {randAssignment, "adder"};
            2: randAssignment = {randAssignment, "multiplier"};
            3: randAssignment = {randAssignment, "FSM"};
            4: randAssignment = {randAssignment, "truth table"};
        endcase
    endfunction

    function string randBrand();
        if (coinFlip())
            randBrand = "Altera ";
        else
            randBrand = "Xilinx ";
    endfunction

    function string randModel();
        if (coinFlip()) begin
            randModel = "DE";
            case (rollDice(4))
                0: randModel = {randModel, "0 "};
                1: randModel = {randModel, "1 "};
                2: randModel = {randModel, "10 "};
                3: randModel = {randModel, "27 "};
                4: randModel = {randModel, "3.14 "};
            endcase
        end else
            case (rollDice(3))
                0: randModel = "Zybo ";
                1: randModel = "Zynq ";
                2: randModel = "Zygote ";
                3: randModel = "Zydeco ";
            endcase
    endfunction

    function string randSeller();
        case (rollDice(2))
            0: randSeller = "from Digilent";
            1: randSeller = "from Terasic";
            2: randSeller = "on eBay";
        endcase
    endfunction

    // seed the random number generator (if one was provided)
    task plantASeed();
        int x;
        `ifdef RANDOM_SEED
            x = $urandom(`RANDOM_SEED);
        `endif
    endtask

    // generate a random int: 0 or 1
    function coinFlip();
        coinFlip = $urandom_range(0, 1);
    endfunction

    // generate a random int: 0 to max (inclusive)
    function int rollDice(
        input int max
    );
        rollDice = $urandom_range(0, max);
    endfunction

endmodule
