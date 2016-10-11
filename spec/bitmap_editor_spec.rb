require 'spec_helper'

describe BitmapEditor do

  context "Parse a valid command" do
    let(:editor) {BitmapEditor.new }

    def new_image
      editor.parse_input("I 4 5")
    end

    describe "#new" do
      it "returns a new editor" do
        expect(editor).to be_an_instance_of(BitmapEditor)
      end
    end

    describe "#parse_input I 4 5" do
      it "has 4x5 blank pixels" do
        new_image
        expect_output("S", "O O O O\n" \
                           "O O O O\n" \
                           "O O O O\n" \
                           "O O O O\n" \
                           "O O O O\n")
      end
    end

    describe "#parse_input L 3 4 C" do
      it "contains pixel C in fourth row third position" do
        new_image
        editor.parse_input("L 3 4 C")
        expect_output("S", "O O O O\n" \
                           "O O O O\n" \
                           "O O O O\n" \
                           "O O C O\n" \
                           "O O O O\n")
      end
    end

    describe "#parse_input V 2 2 4 V" do
      it  "draws pixel V from second row second position to fifthfourth row" do
        new_image
        editor.parse_input("V 2 2 4 V")
        expect_output("S", "O O O O\n" \
                           "O V O O\n" \
                           "O V O O\n" \
                           "O V O O\n" \
                           "O O O O\n")
      end
    end

    describe "#parse_input H 1 4 3 H" do
      it "draws pixel H in the complete third row"  do
        new_image
        editor.parse_input("H 1 4 3 H")
        expect_output("S", "O O O O\n" \
                           "O O O O\n" \
                           "H H H H\n" \
                           "O O O O\n" \
                           "O O O O\n")
      end
    end

    describe "#parse_input C" do
      it "resets all pixels to blank"  do
        new_image
        editor.parse_input("L 3 2 D")
        editor.parse_input("C")
        expect_output("S", "O O O O\n" \
                           "O O O O\n" \
                           "O O O O\n" \
                           "O O O O\n" \
                           "O O O O\n")
      end
    end

    describe "#parse_input S" do
      it "shows the current image"  do
        new_image
        editor.parse_input("L 4 5 D")
        editor.parse_input("V 3 1 5 V")
        editor.parse_input("H 1 4 2 H")
        expect_output("S", "O O V O\n" \
                           "H H H H\n" \
                           "O O V O\n" \
                           "O O V O\n" \
                           "O O V D\n")
      end
    end

    describe "#parse_input ?" do
      it "shows help menu"  do
        new_image
        expect_output("?", "? - Help\n" \
                           "I M N - Create a new M x N image with all pixels coloured white (O).\n" \
                           "C - Clears the table, setting all pixels to white (O).\n" \
                           "L X Y C - Colours the pixel (X,Y) with colour C.\n" \
                           "V X Y1 Y2 C - Draw a vertical segment of colour C in column X between rows Y1 and Y2 (inclusive).\n" \
                           "H X1 X2 Y C - Draw a horizontal segment of colour C in row Y between columns X1 and X2 (inclusive).\n" \
                           "S - Show the contents of the current image\n" \
                           "X - Terminate the session\n")
      end
    end

  end

  private

  def expect_output(input, message)
    expect do
      editor.parse_input(input)
    end.to output(message).to_stdout
  end

end
