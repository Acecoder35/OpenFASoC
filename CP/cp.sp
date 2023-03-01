.subckt cp dn out up vdd vss
m1 in_2 in_2 vdd vdd sky130_fd_pr__pfet_01v8 L=150e-9 W=21e-7
m2 in_3 in_2 vdd vdd sky130_fd_pr__pfet_01v8 L=150e-9  W=21e-7
m3 out downb in_3 in_3 sky130_fd_pr__pfet_01v8 L=150e-9  W=21e-7
m4 out up 7 7 sky130_fd_pr__nfet_01v8 L=150e-9  W=21e-7
m5 7 8 vss vss sky130_fd_pr__nfet_01v8 L=150e-9  W=21e-7
m6 8 8 vss vss sky130_fd_pr__nfet_01v8 L=150e-9  W=21e-7
m7 9 dn in_3 in_3 sky130_fd_pr__pfet_01v8 L=150e-9  W=21e-7
m8 9 9 vss vss sky130_fd_pr__nfet_01v8 L=150e-9  W=21e-7
m11 up upb vdd vdd sky130_fd_pr__pfet_01v8 L=150e-9  W=21e-7
m12 up upb vss vss sky130_fd_pr__nfet_01v8 L=150e-9  W=21e-7
m13 dn downb vdd vdd sky130_fd_pr__pfet_01v8 L=150e-9  W=21e-7
m14 dn downb vss vss sky130_fd_pr__nfet_01v8 L=150e-9  W=21e-7
m9 10 10 vdd vdd sky130_fd_pr__pfet_01v8 L=150e-9  W=21e-7
m10 10 upb 7 7 sky130_fd_pr__nfet_01v8 L=150e-9  W=21e-7
.ends cp
