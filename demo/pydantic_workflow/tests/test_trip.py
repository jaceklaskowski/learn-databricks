from pydantic_workflow.trip import Trip

import pytest


def test_valid_trip():
    Trip(id=10, pickup_zip=10103, dropoff_zip=10110)


def test_invalid_trip():
    with pytest.raises(ValueError):
        Trip(id=10, pickup_zip=10023, dropoff_zip=10023)