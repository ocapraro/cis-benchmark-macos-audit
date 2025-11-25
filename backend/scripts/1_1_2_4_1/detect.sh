#!/bin/bash
findmnt -kn /var 2>/dev/null || echo ""
