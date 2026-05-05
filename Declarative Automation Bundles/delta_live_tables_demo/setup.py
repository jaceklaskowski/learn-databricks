"""
setup.py configuration script describing how to build and package this project.

This file is primarily used by the setuptools library and typically should not
be executed directly. See README.md for how to deploy, test, and run
the delta_live_tables_demo project.
"""
from setuptools import setup, find_packages

import sys
sys.path.append('./src')

import delta_live_tables_demo

setup(
    name="delta_live_tables_demo",
    version=delta_live_tables_demo.__version__,
    url="https://databricks.com",
    author="jacek@japila.pl",
    description="wheel file based on delta_live_tables_demo/src",
    packages=find_packages(where='./src'),
    package_dir={'': 'src'},
    entry_points={
        "packages": [
            "main=delta_live_tables_demo.main:main"
        ]
    },
    install_requires=[
        # Dependencies in case the output wheel file is used as a library dependency.
        # For defining dependencies, when this package is used in Databricks, see:
        # https://docs.databricks.com/dev-tools/bundles/library-dependencies.html
        "setuptools"
    ],
)
