class ProtocGenStructTransformer < Formula
  desc "Transformation functions generator for Protobuf"
  homepage "https://github.com/bold-commerce/protoc-gen-struct-transformer"
  url "https://github.com/bold-commerce/protoc-gen-struct-transformer/archive/v1.0.5.tar.gz"
  sha256 "bd6c9109e77b8c8389905ced83dc46d7811df201689779414cce9bb41bc626aa"

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
