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

    describe "#parse_input F 2 3 R" do
      it "fills region around 2 3 with same color"  do
        new_image
        editor.parse_input("V 2 2 4 V")
        editor.parse_input("H 1 4 3 H")
        editor.parse_input("L 4 4 H")
        editor.parse_input("F 1 3 R")
        expect_output("S", "O O O O\n" \
                           "O V O O\n" \
                           "R R R R\n" \
                           "O V O R\n" \
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

  context "Parse a non-existing command for an image" do
    let(:editor) {BitmapEditor.new }

    describe "#parse_input D" do
      it "returns an error message" do
        message = "unrecognised command :(\n"
        expect_output("D", message)
      end
    end

    describe "#parse_input I 4" do
      it "returns an error message" do
        message = "unrecognised command :(\n"
        expect_output("I 4", message)
      end
    end

    describe "#parse_input L 3 2" do
      it "returns an error message" do
        message = "unrecognised command :(\n"
        expect_output("L 3 2", message)
      end
    end

    describe "#parse_input V 1 3 V" do
      it "returns an error message" do
        message = "unrecognised command :(\n"
        expect_output("V 1 3 V", message)
      end
    end

    describe "#parse_input H 2 4 3" do
      it "returns an error message" do
        message = "unrecognised command :(\n"
        expect_output("H 2 3 4", message)
      end
    end

    describe "#parse_input c" do
      it "returns an error message" do
        message = "unrecognised command :(\n"
        expect_output("c", message)
      end
    end
  end

  context "Parse a command for a non-existing image" do
    let(:editor) {BitmapEditor.new }

    describe "#parse_input C" do
      it "returns an error message" do
        message = "image doesn't exist. Create an image first\n"
        expect_output("C", message)
      end
    end

    describe "#parse_input L 2 3 C" do
      it "returns an error message" do
        message = "image doesn't exist. Create an image first\n"
        expect_output("L 2 3 C", message)
      end
    end

    describe "#parse_input V 1 2 4 V" do
      it "returns an error message" do
        message = "image doesn't exist. Create an image first\n"
        expect_output("V 1 2 4 V", message)
      end
    end

    describe "#parse_input H 3 2 3 H" do
      it "returns an error message" do
        message = "image doesn't exist. Create an image first\n"
        expect_output("H 3 2 3 H", message)
      end
    end

    describe "#parse_input S" do
      it "returns an error message" do
        message = "image doesn't exist. Create an image first\n"
        expect_output("S", message)
      end
    end
  end

  context "Parse an invalid command to create an image" do
    let(:editor) {BitmapEditor.new }

    describe "#parse_input I 0 5" do
      it "returns an error message" do
        message = "can't create image. Width and height must be at least 1\n"
        expect_output("I 0 5", message)
      end
    end
  end

  context "Parse invalid coordinates for an image" do
    let(:editor) {BitmapEditor.new }

    def new_image
      editor.parse_input("I 3 3")
    end

    describe "#parse_input L 4 2 C" do
      it "returns an error message" do
        new_image
        message = "can't color pixel. Coordinates don't exist\n"
        expect_output("L 4 2 C", message)
      end
    end

    describe "#parse_input V 4 2 3 V" do
      it "returns an error message" do
        new_image
        message = "can't draw vertical. Coordinates are not valid\n"
        expect_output("V 4 2 3 V", message)
      end
    end

    describe "#parse_input V 2 3 2 V" do
      it "returns an error message" do
        new_image
        message = "can't draw vertical. Coordinates are not valid\n"
        expect_output("V 2 3 2 V", message)
      end
    end

    describe "#parse_input H 1 3 4 H" do
      it "returns an error message" do
        new_image
        message = "can't draw horizontal. Coordinates are not valid\n"
        expect_output("H 1 3 4 H", message)
      end
    end

    describe "#parse_input H 3 1 3 H" do
      it "returns an error message" do
        new_image
        message = "can't draw horizontal. Coordinates are not valid\n"
        expect_output("H 3 1 3 H", message)
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
