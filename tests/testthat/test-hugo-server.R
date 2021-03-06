test_that("can start, restart, and stop server", {
  skip_if_no_hugo()
  site <- test_path("minimal")

  suppressMessages(hugo_start(site, browse = FALSE))
  expect_true(hugo_running())
  expect_true(port_active(1313))

  suppressMessages(hugo_start(site, browse = FALSE))
  expect_true(hugo_running())

  suppressMessages(hugo_stop())
  expect_false(hugo_running())
  expect_false(port_active(1313))
})

# build -------------------------------------------------------------------

test_that("default builds into public", {
  skip_if_no_hugo()

  path <- local_dir(test_path("minimal"))
  hugo_build(path)
  expect_true(file_exists(path(path, "public", "index.html")))
})

test_that("can build into any directory", {
  skip_if_no_hugo()
  path <- dir_create(file_temp())

  hugo_build(test_path("minimal"), path)
  expect_true(file_exists(path(path, "index.html")))
})
