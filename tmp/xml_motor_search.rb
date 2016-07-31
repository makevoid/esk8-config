# xsplit = XMLMotor.splitter @config_raw
# xtags  = XMLMotor.indexify xsplit
#
# xres   = XMLMotor.xmldata xsplit, xtags, "MCConfiguration"
#
# xsplit = XMLMotor.splitter xres.first
# xtags  = XMLMotor.indexify xsplit
# xres   = XMLMotor.xmldata xsplit, xtags, nil, ''
