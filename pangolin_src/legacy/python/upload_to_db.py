#!/usr/bin/env python

"""
This scripte reads a summary.json file created by v-pipe and imports the
computed consensus sequences into the s3c database.

usage:

    for testing:

    $ python upload_to_db /path/to/summary_zip_file

    this will create sqlite3 db 'sars_cov_2.db' in the current working directory

    for productive usage:

    $ DBUSER=abcde DBPASSWORD=xyde python upload_to_db /path/to/summary_zip_file

the environment variable DBHOST, DBPORT and DATABASE can also be set to overrun
standard settings.
"""

import json
import os
import sys
import tempfile
import time
import warnings
import zipfile
from datetime import datetime

import sqlalchemy
from sqlalchemy import (
    Column,
    DateTime,
    Integer,
    LargeBinary,
    MetaData,
    String,
    Table,
    bindparam,
    create_engine,
    exc,
    insert,
)
from sqlalchemy.pool import SingletonThreadPool


def connect_to_db(connection_string, *, verbose=False, attempts=5, delay=1):

    if connection_string.startswith("sqlite"):
        from sqlite3 import dbapi2 as sqlite

        engine = create_engine(
            connection_string,
            module=sqlite,
            echo=verbose,
            poolclass=SingletonThreadPool,
        )

    else:
        # pool_pre_ping: check if connection is valid befor submitting a
        # command, if not: remove old connections from pool and setup fresh one.
        engine = create_engine(connection_string, echo=verbose, pool_pre_ping=True)

    stored_exception = None
    for attempt in range(attempts):
        try:
            engine.connect()
        except exc.OperationalError as e:
            stored_exception = e
            warnings.warn(
                "could not connect, sleep for {} sencds and try again".format(delay)
            )
            time.sleep(delay)
            continue
        else:
            break

    else:
        raise TimeoutError(
            "could not connect to {}. Error is {}".format(
                connection_string, stored_exception
            )
        ) from None

    return engine


def create_tables_if_not_exists(engine):
    meta = MetaData()

    consensus_table = Table(
        "new_sequence",
        meta,
        Column("id", Integer, primary_key=True),
        Column("batch", String),
        Column("sample", String),
        Column("header", String),
        Column("created", DateTime(timezone=True)),
        Column("checksum_seguid", String),
        Column("checksum_crc64", String),
        Column("sequence", String),
    )

    raw_data_table = Table(
        "raw_data",
        meta,
        Column("id", Integer, primary_key=True),
        Column("batch", String),
        Column("sample", String),
        Column("data", LargeBinary),
    )

    meta.create_all(engine)
    return consensus_table, raw_data_table


def import_data(engine, consensus_table, raw_data_table, summary_file, batch_size=1000):

    target = tempfile.mkdtemp()
    with zipfile.ZipFile(summary_file, "r") as zip_ref:
        zip_ref.extractall(target)

    summary_file = os.path.join(target, "summary.json")

    with open(summary_file) as fh:
        try:
            summary_data = json.load(fh)
        except json.JSONDecodeError as e:
            raise ValueError(f"{summary_file} is no valid json file: {e}") from None

    prepared_stmt = insert(consensus_table).values(
        batch=bindparam("batch"),
        sample=bindparam("sample"),
        header=bindparam("header"),
        created=bindparam("created"),
        checksum_seguid=bindparam("checksum_seguid"),
        checksum_crc64=bindparam("checksum_crc64"),
        sequence=bindparam("sequence"),
    )

    rows = []
    count = 0

    for entry in summary_data:
        sample = entry["sample"]
        batch = entry["batch"]
        created = datetime.fromisoformat(entry["created"])
        for sequence_data in entry["sequences"]:
            header = sequence_data["header"]
            seguid = sequence_data["seguid"]
            crc64 = sequence_data["crc64"]
            sequence = sequence_data["sequence"]
            rows.append(
                dict(
                    batch=batch,
                    sample=sample,
                    header=header,
                    created=created,
                    checksum_seguid=seguid,
                    checksum_crc64=crc64,
                    sequence=sequence,
                )
            )
        if len(rows) >= batch_size:
            engine.execute(prepared_stmt, rows)
            count += len(rows)
            rows = []

        raw_data_path = entry["raw_data"]
        if raw_data_path:
            with open(os.path.join(target, raw_data_path), "rb") as fh:
                data = fh.read()
            print(batch, sample)
            engine.execute(
                insert(raw_data_table).values(batch=batch, sample=sample, data=data)
            )

    engine.execute(prepared_stmt, rows)
    count += len(rows)
    return count


if __name__ == "__main__":

    if len(sys.argv) < 2:
        raise ValueError("please provide path with summary file")
    if len(sys.argv) > 2:
        warnings.warn(
            "you provided more argments than the summary file. will ignore them."
        )

    summary_file = sys.argv[1]
    if not os.path.exists(summary_file):
        raise IOError(f"provided file {summary_file} does not exist.")

    try:
        with open(summary_file) as fh:
            pass
    except IOError:
        raise IOError(f"counld not open {summary_file} for reading.") from None

    if os.path.exists(".defaults"):
        with open(".defaults") as fh:
            default = dict(line.strip().split("=") for line in fh if line.strip())
    else:
        default = {}

    DBUSER = os.getenv("DBUSER")
    DBPASSWORD = os.getenv("DBPASSWORD")
    DBHOST = os.getenv("DBHOST", default.get("DBHOST"))
    DBPORT = os.getenv("DBPORT", default.get("DBPORT"))
    DATABASE = os.getenv("DATABASE", default.get("DATABASE"))

    if DBUSER is not None and DBPASSWORD is not None:
        connection_string = (
            f"postgresql://{DBUSER}:{DBPASSWORD}@{DBHOST}:{DBPORT}/{DATABASE}"
        )
    else:
        warnings.warn(
            "you did not set DBUSER and DBPASSWORD variables. will write"
            " to local sqlite3 db sars_cov_2.db instead."
        )
        path = "sars_cov_2.db"
        connection_string = "sqlite+pysqlite:///{}".format(path)

    engine = connect_to_db(connection_string)
    consensus_table, raw_data_table = create_tables_if_not_exists(engine)
    count = import_data(engine, consensus_table, raw_data_table, summary_file)

    print(f"imported {count} sequence(s).")
