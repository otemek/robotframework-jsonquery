from pathlib import Path
import json
import pytest
from JsonQuery.JsonQuery import JsonQuery

from JsonQuery.queries import JmesPath, JsonPathNg, Querable

sample_file = Path().cwd() / "data" / "sample.json"

with open(sample_file, "r") as fl:
    jsn = json.load(fl)


@pytest.mark.parametrize(
    ["module_name", "expected"],
    [
        ("jsonpath_ng", JsonPathNg),
        ("jmespath", JmesPath),
        ("jsonpath_ng.ext", JsonPathNg),
    ],
)
def test_can_create_proper_instance_based_on_imported_module(
    module_name: str, expected: Querable
):
    actual = JsonQuery(module_name)
    assert type(actual.qmodule) == expected


def test_can_get_imported_module_name():
    module_name: str = "jsonpath_ng"
    actual = JsonQuery(module_name)
    assert module_name == actual.get_query_module()
