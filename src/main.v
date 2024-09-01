module main

import prantlf.yaml

fn main() {
	println('Hello World!')

	any := yaml.parse_file("application.yaml")!
	// dump(any)
	println("${any}}\n\n")

	config := any.object()!
	println("config = ${config}")

	searches := config["search"].array()!
	println("searches = ${searches}")

	for _, search in searches {
		println("search = ${search}")
	}

	println('Buy')
}
