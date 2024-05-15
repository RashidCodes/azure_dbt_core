#!/usr/bin/env bash
set -eu

main() {
    export TOP_DIR=$(git rev-parse --show-toplevel)

    # install dbt dependencies
    pip install -r ${TOP_DIR}/transform/requirements.txt --no-index --find-links=${pip_download_dir}

    # Remove trailing whitespaces
    find . -type f -name '*.sql' -exec sed --in-place 's/[[:space:]]\+$//' {} \+

    # Lint dbt models
    echo "##[debug] Perform linting checks with sqlfluff"
    cd ${TOP_DIR}/transform/adventureworks

    dbt deps
    sqlfluff lint .

    # If the linter produce diffs, fail the linter
    # Perform linting locally
    # if [ -z "$(git status --porcelain)" ]; then
    #     echo "Working directory clean, linting passed"
    #     exit 0
    # else
    #     echo "Linting failed. Please commit these changes:"
    #     git --no-pager diff HEAD
    #     exit 1
    # fi

}

main
