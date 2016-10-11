require 'spec_helper'

describe BitmapImage do

  context "Draw a valid image" do
    let(:image) { BitmapImage.new(6,5) }

    describe "#new" do
      it "returns a new image" do
        expect(image).to be_an_instance_of(BitmapImage)
      end
    end

    describe "#show new_image" do
      it "has 6x5 blank pixels" do
        expect_output(image, "O O O O O O\n" \
                             "O O O O O O\n" \
                             "O O O O O O\n" \
                             "O O O O O O\n" \
                             "O O O O O O\n")
      end
    end

    describe "#color_pixel" do
      it "contains pixel C in first row fourth position" do
        image.color_pixel(4,1,"C")
        expect_output(image, "O O O C O O\n" \
                             "O O O O O O\n" \
                             "O O O O O O\n" \
                             "O O O O O O\n" \
                             "O O O O O O\n")
      end
    end

    describe "#draw_vertical" do
      it "draws pixel V from second row fourth position to fifth row" do
        image.draw_vertical(4, 2, 5, "V")
        expect_output(image, "O O O O O O\n" \
                             "O O O V O O\n" \
                             "O O O V O O\n" \
                             "O O O V O O\n" \
                             "O O O V O O\n")
      end
    end

    describe "#draw_horizontal" do
      it "draws pixel H in the complete first row" do
        image.draw_horizontal(1, 6, 1, "H")
        expect_output(image, "H H H H H H\n" \
                             "O O O O O O\n" \
                             "O O O O O O\n" \
                             "O O O O O O\n" \
                             "O O O O O O\n")
      end
    end

    describe "#clear" do
      it "resets all pixels to blank" do
        image.color_pixel(5,2,"C")
        image.clear
        expect_output(image, "O O O O O O\n" \
                             "O O O O O O\n" \
                             "O O O O O O\n" \
                             "O O O O O O\n" \
                             "O O O O O O\n")
      end
    end

    describe "#show drawing" do
      it "shows the current image" do
        image.color_pixel(4,1,"C")
        image.draw_vertical(4, 2, 5, "V")
        image.draw_horizontal(1, 6, 1, "H")
        expect_output(image, "H H H H H H\n" \
                             "O O O V O O\n" \
                             "O O O V O O\n" \
                             "O O O V O O\n" \
                             "O O O V O O\n")
      end
    end
  end

  private

  def expect_output(image, message)
    expect do
      image.show
    end.to output(message).to_stdout
  end

end
