require 'spec_helper'

describe BitmapImage do

  context "Draw a valid image" do
    let(:image) { BitmapImage.new(6,5) }

    describe "#new 6, 5" do
      it "returns a new image" do
        expect(image).to be_an_instance_of(BitmapImage)
      end
    end

    describe "#new 250, 2" do
      it "returns a new image" do
        expect(BitmapImage.new(250,2)).to be_an_instance_of(BitmapImage)
      end
    end

    describe "#new 2, 250" do
      it "returns a new image" do
        expect(BitmapImage.new(2, 250)).to be_an_instance_of(BitmapImage)
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

    describe "#fill_region" do
      it "fill region with the color of the pixel" do
        image.draw_vertical(4, 2, 5, "V")
        image.draw_horizontal(1, 6, 3, "H")
        image.color_pixel(3, 1, "V")
        image.fill_region(4, 3, "R")
        expect_output(image, "O O V O O O\n" \
                             "O O O R O O\n" \
                             "R R R R R R\n" \
                             "O O O R O O\n" \
                             "O O O R O O\n")
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

  context "Draw an invalid image" do
    let(:image) { BitmapImage.new(3,4) }

    describe "#new 0, 5" do
      it "raises a BitmapImage error" do
        message = "can't create image. Width and height must be at least 1"
        expect{ BitmapImage.new(0,5) }.to raise_error(BitmapImage::Error, message)
      end
    end

    describe "#new 251, 2" do
      it "raises a BitmapImage error" do
        message = "can't create image. Width and height must be at least 1"
        expect{ BitmapImage.new(251,2) }.to raise_error(BitmapImage::Error, message)
      end
    end

    describe "#new 2, 251" do
      it "raises a BitmapImage error" do
        message = "can't create image. Width and height must be at least 1"
        expect{ BitmapImage.new(2, 251) }.to raise_error(BitmapImage::Error, message)
      end
    end

    describe "#color_pixel" do
      it "raises a BitmapImage error" do
        message = "can't color pixel. Coordinates don't exist"
        expect{ image.color_pixel(4,4,"C") }.to raise_error(BitmapImage::Error, message)
        expect{ image.color_pixel(3,5,"C") }.to raise_error(BitmapImage::Error, message)
      end
    end

    describe "#draw_vertical" do
      it "raises a BitmapImage error" do
        message = "can't draw vertical. Coordinates are not valid"
        expect{ image.draw_vertical(4,1,2,"V") }.to raise_error(BitmapImage::Error, message)
        expect{ image.draw_vertical(2,0,2,"V") }.to raise_error(BitmapImage::Error, message)
        expect{ image.draw_vertical(1,1,5,"V") }.to raise_error(BitmapImage::Error, message)
        expect{ image.draw_vertical(1,2,1,"V") }.to raise_error(BitmapImage::Error, message)
      end
    end

    describe "#draw_horizontal" do
      it "raises a BitmapImage error" do
        message = "can't draw horizontal. Coordinates are not valid"
        expect{ image.draw_horizontal(5,1,2,"H") }.to raise_error(BitmapImage::Error, message)
        expect{ image.draw_horizontal(0,3,2,"H") }.to raise_error(BitmapImage::Error, message)
        expect{ image.draw_horizontal(1,3,5,"H") }.to raise_error(BitmapImage::Error, message)
        expect{ image.draw_horizontal(3,1,2,"H") }.to raise_error(BitmapImage::Error, message)
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
