class ProtocGenStructTransformer < Formula
  desc "Transformation functions generator for Protobuf"
  homepage "https://github.com/bold-commerce/protoc-gen-struct-transformer"
  url "https://github.com/bold-commerce/protoc-gen-struct-transformer/archive/v1.0.7.tar.gz"
  sha256 "23092381966720c8afdcd723506ed7ea04697fb50ccbc2b2a8df9886fd98c6bf"

  head "https://github.com/bold-commerce/protoc-gen-struct-transformer.git"

  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath

    bin_path = buildpath/"src/github.com/bold-commerce/protoc-gen-struct-transformer"
    bin_path.install Dir["*"]
    cd bin_path do
      system "make", "OUTPUT=#{bin}/protoc-gen-struct-transformer", "VERSION=#{version}", "build"
    end
  end

  test do
    protofile = testpath/"messages.proto"
    protofile.write <<~EOS
      syntax = "proto3";
      package messages;
      message Order {
        int64 id = 1;
        string number = 2;
      }
    EOS

    system "protoc", "--struct-transformer_out=.","messages.proto"
  end
end
