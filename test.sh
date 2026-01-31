#!/bin/bash

echo "Running basic validation tests..."

if [ -f index.html ]; then
  echo "index.html exists ✅"
else
  echo "index.html missing ❌"
  exit 1
fi

if grep -q "To-Do List" index.html; then
  echo "Title check passed ✅"
else
  echo "Title missing ❌"
  exit 1
fi

echo "All tests passed ✅"
