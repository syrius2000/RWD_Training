#!env gawk -f# /* set expandtab */{　colnames[$0]++==1}# END {#     for (LEN in colnames) {#         print LEN#     }# }