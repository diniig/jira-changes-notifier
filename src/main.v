module main

import os
import json
// import time
import regex
import strconv

const default_frequency_sec := 30

struct Config {
	jira_url string
	searches []Search
}

struct Search {
	name        string
	frequency   string
	query       string
	fields      []string
	max_results int
}

fn main() {
	println('Hello World!')

	filename := 'application.yaml'
	application_props_str := os.read_file(filename) or {
		panic('error reading config, error: ${err}')
	}

	config := json.decode(Config, application_props_str) or {
		eprintln('Failed to decode json, error: ${err}')
		return
	}

	for _, search in config.searches {
		println('search = ${search}')

		spawn search_job(search)
	}

	for true {
		// wait
	}

	println('Buy')
}

fn search_job(srch Search) {
	duration := get_duration_s(srch.frequency)
	println('duration = ${duration}')
	// time.sleep(srch.frequency * time.second)
}

fn get_duration_s(val string) int {
	query := '^(\\d+)s$'
	mut re := regex.regex_opt(query) or {
		println('error compile query ${query}')
		return default_frequency_sec
	}
	if re.matches_string(val) {
		nu := re.get_group_by_id(val, 0)
		return strconv.atoi(nu) or {
			println("error converting string '${nu}' to int")
			return default_frequency_sec
		}
	}

	return default_frequency_sec
}
