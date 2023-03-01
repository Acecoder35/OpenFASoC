# AUX CELL GENERATION FOR - OpenFASoC(Fully Open-Source Autonomous SoC)

## GENERATING .lef, .gds for Aux cells

**Discription** : In Open FASoC Flow to generate a automated Analog design, few auxilaury cells(.lef,.gds) are required to be created which cannot be implemented with existing library cells (like Header and SLC in temp_sence_gen). To generate these .lef and .gds files of AUX cells we use ALIGN.

<img width="285" alt="image" src="https://user-images.githubusercontent.com/110079648/199926204-bcb62999-de84-437b-b318-967db250c25e.png">


### Reduired inputs from previous step of flow:
 - SCHEMATIC and SPECIFICATIONS of AUX cell to be generated.
(usually AUX cell contains less than 12 transistors)

### First Step 

- Based upon given SCHEMATIC and SPECIFICATIONS of AUX cell, a SPICE Netlist should be created with .sp file extension.

### Using ALIGN: Analog Layout, Intelligently Generated from Netlists:

**About:**

ALIGN is an open source automatic layout generator for analog circuits jointly developed under the DARPA IDEA program by the University of Minnesota, Texas A&M University, and Intel Corporation.

The goal of ALIGN (Analog Layout, Intelligently Generated from Netlists) is to automatically translate an unannotated (or partially annotated) SPICE netlist of an analog circuit to a GDSII layout. The repository also releases a set of analog circuit designs.

The ALIGN flow includes the following steps:

Circuit annotation creates a multilevel hierarchical representation of the input netlist. This representation is used to implement the circuit layout in using a hierarchical manner.
Design rule abstraction creates a compact JSON-format represetation of the design rules in a PDK. This repository provides a mock PDK based on a FinFET technology (where the parameters are based on published data). These design rules are used to guide the layout and ensure DRC-correctness.
Primitive cell generation works with primitives, i.e., blocks at the lowest level of design hierarchy, and generates their layouts. Primitives typically contain a small number of transistor structures (each of which may be implemented using multiple fins and/or fingers). A parameterized instance of a primitive is automatically translated to a GDSII layout in this step.
Placement and routing performs block assembly of the hierarchical blocks in the netlist and routes connections between these blocks, while obeying a set of analog layout constraints. At the end of this step, the translation of the input SPICE netlist to a GDSII layout is complete.

#### Installing ALIGN:
**Prerequisites**

- gcc >= 6.1.0 (For C++14 support)
- python >= 3.7 

Use the following commands to install ALIGN tool.

```
export CC=/usr/bin/gcc
export CXX=/usr/bin/g++
git clone https://github.com/ALIGN-analoglayout/ALIGN-public
cd ALIGN-public

#Create a Python virtualenv
python -m venv general
source general/bin/activate
python -m pip install pip --upgrade

# Install ALIGN as a USER
pip install -v .

# Install ALIGN as a DEVELOPER
pip install -e .

pip install setuptools wheel pybind11 scikit-build cmake ninja
pip install -v -e .[test] --no-build-isolation
pip install -v --no-build-isolation -e . --no-deps --install-option='-DBUILD_TESTING=ON'
```

#### Making ALIGN Portable to Sky130 tehnology

Clone the following Repository inside ALIGN-public directory

```
git clone https://github.com/ALIGN-analoglayout/ALIGN-pdk-sky130
```

move `SKY130_PDK` folder to `/home/anvith/ALIGN-public/pdks`

#### Running ALIGN TOOL

Everytime we start running tool in new terminal run following commands.

```
python -m venv general
source general/bin/activate
```
Commands to run ALIGN (goto ALIGN-public directory)


```
mkdir work
cd work
```
General syntax to give inputs
```
schematic2layout.py <NETLIST_DIR> -p <PDK_DIR> -c
```

Running a EXAMPLE:
```
schematic2layout.py ../examples/telescopic_ota -p ../pdks/FinFET14nm_Mock_PDK/
```
Running a EXAMPLE on Sky130pdk
```
schematic2layout.py ../ALIGN-pdk-sky130/examples/five_transistor_ota -p ../pdks/SKY130_PDK/
```

#### FLOW

Create a Python virtual environment
Now Running design we get-


#### Generated .lef and .gds files for example (using Sky130pdk)

- TELESCOPIC_OTA .gds 

<img width="725" alt="image" src="https://user-images.githubusercontent.com/110079648/199927903-0633843d-cc26-47a0-845c-2e32b301565b.png">

- TELESCOPIC_OTA .lef

<img width="729" alt="image" src="https://user-images.githubusercontent.com/110079648/199928376-ea9d82d4-e14a-4f2f-acca-f6ddd12dbbd6.png">

- FIVE_TRANSISTOR_OTA .gds

<img width="755" alt="image" src="https://user-images.githubusercontent.com/110079648/199897042-c22c79a4-aecd-4091-acdb-798dbd229e57.png">

- FIVE_TRANSISTOR_OTA .lef

<img width="755" alt="image" src="https://user-images.githubusercontent.com/110079648/199897231-8e85a4ab-67a6-4482-bca6-98121c485561.png">


## RUNNING ALIGN FOR input user SPICE Netlist

A simple SPICE Netlist for inverter is written to generate .lef and .gds files

```
.subckt inverter vinn voutn vdd 0
m1 voutn vinn vdd vdd pmos_rvt w=840e-9 l=150e-9 nf=2
m2 voutn vinn 0 0 nmos_rvt w=840e-9 l=150e-9 nf=2
.ends inverter
** End of subcircuit definition.
```
- .gds


<img width="857" alt="image" src="https://user-images.githubusercontent.com/110079648/199897719-b3037219-6157-4331-b9f7-80edf3a226dd.png">

- .lef


<img width="860" alt="image" src="https://user-images.githubusercontent.com/110079648/199897814-4ac68600-abc6-4ca1-88bb-092bf7098d0f.png">


# DESIGNING AUX CELLS FOR PLL
Source Repo for SPICE FILES - https://github.com/lakshmi-sathi/avsdpll_1v8

## 1 - Charge Pump

### Circuit:

![CP](https://user-images.githubusercontent.com/110079648/201048674-4052a8b5-e5a2-4ce2-ba25-bcc11d337d27.jpg)

```
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

```
### .GDS

<img width="393" alt="image" src="https://user-images.githubusercontent.com/110079648/206165878-cf4a4321-e14b-49ae-b290-4fec42fe62f7.png">

### .LEF

<img width="392" alt="image" src="https://user-images.githubusercontent.com/110079648/206165962-119ae4a0-7a0e-49b7-ab17-887c266b3223.png">


# POST LAYOUT SIMULATIONS
Magic Tool is used to post layout Spice file. SPICE file can be simulated in NGSPICE and compare with prelayout.

- Open terminal in work directory where our final gds stored.

set PDK ROOT for Magic using the command -
```
export PDK_ROOT=/path/to/your/pdks/
# I have used pdks Sky130 pdks from openlane
```

- Then type `magic` in terminal which open magic.

- Then goto file and press read GDS and select our gds file

<img width="403" alt="image" src="https://user-images.githubusercontent.com/110079648/206182472-3fb5c83f-8613-42a2-ad3b-1992653f56db.png">

- Place the curser outside layout press `s` which select entire layout.
Then goto tkcon and type `ext2spice`

<img width="278" alt="image" src="https://user-images.githubusercontent.com/110079648/206182880-d5c8aa21-23d4-43cf-8c38-248dd11d5e64.png">

- post layout spice file is created in work directory


# AUTHORS
-  *SAI ANVITH VATTIKUTI IMT2018528*, International Institute of Information Technology, Bangalore
# Contributers
-  *KUNAL GHOSH*, Director, VSD Corp. Pvt. Ltd


# Acknowledgments
- Kunal Ghosh, Director, VSD Corp. Pvt. Ltd.
	
# REFERENCE 
- GOPALA KRISHNA REDDY github: https://github.com/sanampudig/OpenFASoC/tree/main/AUXCELL
- Lakshmi S, MS ECE - MAIL: lakshmi.sathi96@gmail.com GITHUB: https://github.com/lakshmi-sathi/avsdpll_1v8
