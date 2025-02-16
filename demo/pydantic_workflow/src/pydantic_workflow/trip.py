from typing_extensions import Self

from pydantic import BaseModel, model_validator

from datetime import datetime


class Trip(BaseModel):
    id: int
    tpep_pickup_datetime: datetime = datetime.now()
    tpep_dropoff_datetime: datetime = datetime.now()
    trip_distance: float = -1.0
    fare_amount: float = -1.0
    pickup_zip: int = -1
    dropoff_zip: int = -1

    @model_validator(mode='after')
    def enforce_different_zips(self) -> Self:
        if self.pickup_zip == self.dropoff_zip:
            raise ValueError('pickup_zip and dropoff_zip must be different')
        return self
