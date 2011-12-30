Before('@resync_off') do
  page.driver.options[:resynchronize] = false
end