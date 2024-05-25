# typed: true
# frozen_string_literal: true

require "utils/cp"

module UnpackStrategy
  # Strategy for unpacking directories.
  class Directory
    include UnpackStrategy

    sig { returns(T::Array[String]) }
    def self.extensions
      []
    end

    def self.can_extract?(path)
      path.directory?
    end

    private

    sig { override.params(unpack_dir: Pathname, basename: Pathname, verbose: T::Boolean).returns(T.untyped) }
    def extract_to_dir(unpack_dir, basename:, verbose:)
      path.children.each do |child|
        Utils::Cp.copy_recursive (child.directory? && !child.symlink?) ? "#{child}/." : child,
                                 unpack_dir/child.basename,
                                 verbose:
      end
    end
  end
end
