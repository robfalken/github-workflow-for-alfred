# frozen_string_literal: true

# Cache is a class that reads, writes and clears repository data from a cache file
class Cache
  CACHE_FILE = "tmp/output.cache"

  def read
    @cache ||= File.read(CACHE_FILE) if exist?
  end

  def write(data)
    File.write(CACHE_FILE, data)
  end

  def clear
    File.delete(CACHE_FILE) if exist?
  end

  def exist?
    File.exist?(CACHE_FILE)
  end
end
