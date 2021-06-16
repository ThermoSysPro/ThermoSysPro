within ThermoSysPro.MultiFluids.Machines;
model AlternatingEngine "Internal combustion engine with electrical output"
  parameter Integer mechanical_efficiency_type = 1
    "1: fixed nominal efficiency - 2: Linear efficiency using Coef_Rm_a, Coef_Rm_b and Coef_Rm_c - 3: Beau de Rochas cycle efficiency";
  parameter Real Rmeca_nom=0.40
    "Fixed nominal mechanical efficiency (active if mechanical_efficiency_type=1)";
  parameter Real Coef_Rm_a=-5.727E-09
    "Coefficient a for the linear mechanical efficiency (active if mechanical_efficiency_type=2)";
  parameter Real Coef_Rm_b=4.5267E-05
    "Coefficient b for the linear mechanical efficiency (active if mechanical_efficiency_type=2)";
  parameter Real Coef_Rm_c=0.312412946
    "Coefficient c for the linear mechanical efficiency (active if mechanical_efficiency_type=2)";
  parameter Real Relec=0.97 "Engine electrical efficiency";
  parameter Real Cosphi=1 "Cos(phi) of the electrical grid";
  parameter Real Xpth=0.03 "Thermal loss fraction - cooling (0-1 sur Q.PCI)";
  parameter Real Xref=0.2 "Cooling power fraction (0-1 sur Q.PCI)";
  parameter Real MMg=30 "Gas average molar mass (g/mol)";
  parameter Real DPe=0
    "Water pressure loss as percent of the pressure at the inlet";
  parameter ThermoSysPro.Units.DifferentialPressure DPaf=0
    "Pressure difference between the air pressure at the inlet and the flue gases pressure at the outlet";
  parameter Real RV=6 "Engine volume ratio (> 1)";
  parameter Real Kc=1.2 "Compression polytropic coefficient";
  parameter Real Kd=1.4 "Expansion polytropic coefficient";
  parameter Real Gamma=1.3333 "Flue gases gamma = Cp/Cv";

protected
  constant Real amC=12.01115 "Carbon atomic mass";
  constant Real amH=1.00797 "Hydrogen atomic mass";
  constant Real amO=15.9994 "Oxygen atomic mass";
  constant Real amS=32.064 "Sulfur atomic mass";
  constant Real amCO2=amC+2*amO "CO2 molecular mass";
  constant Real amH2O=2*amH+amO "H2O molecular mass";
  constant Real amSO2=amS+2*amO "SO2 molecular mass";

public
  Modelica.SIunits.MassFlowRate Qsf(start=400)
    "Flue gases mass flow rate at the outlet";
  Modelica.SIunits.AbsolutePressure Psf(start=12e5)
    "Flue gases pressure at the outlet";
  Modelica.SIunits.Temperature Tsf(start=1500)
    "Flue gases temperature at the outlet";
  Real XsfCO2(start=0.5) "Flue gases CO2 mass fraction at the outlet";
  Real XsfH2O(start=0.1) "Flue gases H2O mass fraction at the outlet";
  Real XsfO2(start=0) "Flue gases O2 mass fraction at the outlet";
  Real XsfSO2(start=0) "Flue gases SO2 mass fraction at the outlet";
  Real Rmeca(start=0.3) "Engine mechanical efficiency";
  Modelica.SIunits.Power Wmeca(start=5e8) "Engine mechanical power";
  Modelica.SIunits.Power Welec(start=5e8) "Engine electrical power";
  Modelica.SIunits.Power Wact(start=5e8) "Active power";
  Modelica.SIunits.Power Wcomb(start=5e8) "Fuel power available (Q.PCS)";
  Modelica.SIunits.Power Wpth_ref(start=1e6)
    "Power of thermal losses + cooling";
  Real exc(start=1) "Combustion air ratio";
  Real PCScomb "Pouvoir Calorifique Supérieur du combustible sur brut(en J/kg)";
  Modelica.SIunits.Temperature Tm(start=500) "Air-gas mixture temperature";
  Modelica.SIunits.Temperature Tfcp(start=500)
    "Temperature at the end of the compression phase";
  Modelica.SIunits.AbsolutePressure Pfcp(start=12e5)
    "Pressure at the end of the compression phase";
  Modelica.SIunits.Temperature Tfcb(start=500)
    "Temperature at the end of the combustion phase";
  Modelica.SIunits.AbsolutePressure Pfcb(start=12e5)
    "Pressure at the end of the combustion phase";
  Modelica.SIunits.Temperature Tfd(start=500)
    "Temperature at the end of the expansion phase";
  Modelica.SIunits.AbsolutePressure Pfd(start=12e5)
    "Pressure at the end of the expansion phase";
  Modelica.SIunits.Temperature Tfe(start=500) "Temperature at the exhaust";
  Modelica.SIunits.SpecificEnthalpy Hea(start=50e3)
    "Air specific enthalpy at the inlet";
  Modelica.SIunits.SpecificEnthalpy Hsf(start=50e4)
    "Flue gases specific enthalpy at the outlet";
  Modelica.SIunits.SpecificEnthalpy Hcomb(start=10e3)
    "Fuel specific enthalpy at the inlet";
  Modelica.SIunits.SpecificEnthalpy Hrfum(start=10e3)
    "Flue gases reference specific enthalpy";
  Modelica.SIunits.SpecificEnthalpy Hrair(start=10e3)
    "Air reference specific enthalpy";
  Modelica.SIunits.SpecificEnthalpy Hrcomb(start=10e3)
    "Fuel reference specific enthalpy";
  Modelica.SIunits.MassFlowRate Qea(start=400)
    "Air mass flow rate at the inlet";
  Modelica.SIunits.AbsolutePressure Pea(start=1e5) "Air pressure at the inlet";
  Modelica.SIunits.Temperature Tea(start=600) "Air temperature at the inlet";
  Real XeaCO2(start=0) "Air CO2 mass fraction at the inlet";
  Real XeaH2O(start=0.1) "Air H2O mass fraction at the inlet";
  Real XeaO2(start=0.2) "Air O2 mass fraction at the inlet";
  Real XeaSO2(start=0) "Air SO2 mass fraction at the inlet";
  Modelica.SIunits.SpecificHeatCapacity Cpair(start=1000)
    "Air specific heat capacity";
  Modelica.SIunits.MassFlowRate Qcomb(start=5) "Fuel mass flow rate";
  Modelica.SIunits.Temperature Tcomb(start=300) "Fuel temperature";
  Real XCcomb(start=0.8) "Fuel carbon fraction";
  Real XHcomb(start=0.2) "Fuel hydrogen fraction";
  Real XOcomb(start=0) "Fuel oxygen fraction";
  Real XScomb(start=0) "Fuel sulfur fraction";
  Real XEAUcomb(start=0) "Fuel H2O fraction";
  Real XCDcomb(start=0) "Fuel ashes fraction";
  Real PCIcomb(start=5e7) "Fuel PCI (J/kg)";
  Modelica.SIunits.SpecificHeatCapacity Cpcomb(start=1000)
    "Fuel specific heat capacity";
  Modelica.SIunits.MassFlowRate Qe(start=1) "Water mass flow rate";
  Modelica.SIunits.SpecificEnthalpy Hev(start=10e3)
    "Water specific enthalpy at the inlet";
  Modelica.SIunits.Density rhoea(start=0.001) "Air density at the inlet";
  Modelica.SIunits.Density rhosf(start=0.001)
    "Flue gases density at the outlet";
  Modelica.SIunits.SpecificEnthalpy Hsv(start=10e3)
    "Water specific enthalpy at the outlet";
  Real MMairgaz(start=30) "Air/gas mixture molecular mass (g/mol)";
  Real MMfumees(start=30) "Flue gases molecular mass (g/mol)";

public
  ThermoSysPro.Combustion.Connectors.FuelInlet Cfuel
    annotation (Placement(transformation(extent={{-50,-100},{-30,-80}},
          rotation=0)));
  ThermoSysPro.FlueGases.Connectors.FlueGasesInlet Cair
    annotation (Placement(transformation(extent={{30,-100},{50,-80}}, rotation=
            0)));
  ThermoSysPro.FlueGases.Connectors.FlueGasesOutlet Cfg
    annotation (Placement(transformation(extent={{-10,80},{10,100}}, rotation=0)));
  ThermoSysPro.WaterSteam.Connectors.FluidInlet Cws1
    annotation (Placement(transformation(extent={{-100,-10},{-80,10}}, rotation=
           0)));
  ThermoSysPro.WaterSteam.Connectors.FluidOutlet Cws2
    annotation (Placement(transformation(extent={{80,-10},{100,10}}, rotation=0)));
equation

  /* Air inlet */
  Qea = Cair.Q;
  Pea = Cair.P;
  Tea = Cair.T;
  XeaCO2 = Cair.Xco2;
  XeaH2O = Cair.Xh2o;
  XeaO2 = Cair.Xo2;
  XeaSO2 = Cair.Xso2;

  /* Fuel inlet */
  Qcomb = Cfuel.Q;
  Tcomb = Cfuel.T;
  XCcomb = Cfuel.Xc;
  XHcomb = Cfuel.Xh;
  XOcomb = Cfuel.Xo;
  XScomb = Cfuel.Xs;
  XEAUcomb = Cfuel.hum;
  XCDcomb = Cfuel.Xashes;
  PCIcomb = Cfuel.LHV;
  Cpcomb = Cfuel.cp;

  /* Water/steam inlet */
  Qe = Cws1.Q;
  Hev = Cws1.h;

  /* Water/steam outlet */
  Cws2.Q = Cws1.Q;
  Hsv = Cws2.h;

  /* Flue gases outlet */
  Qsf = Cfg.Q;
  Psf = Cfg.P;
  Tsf = Cfg.T;
  XsfCO2 = Cfg.Xco2;
  XsfH2O = Cfg.Xh2o;
  XsfO2 = Cfg.Xo2;
  XsfSO2 = Cfg.Xso2;

  /* Flow reversal */
  0 = if (Qe > 0) then Cws1.h - Cws1.h_vol else Cws2.h - Cws2.h_vol;

  /* Mass balance equation for the flue gases */
  Qsf = Qea + Qcomb;

  /* CO2 flue gases composition */
  XsfCO2*Qsf = Qea*XeaCO2 + Qcomb*XCcomb*amCO2/amC;

  /* H2O flue gases composition */
  XsfH2O*Qsf = Qea*XeaH2O + Qcomb*XHcomb*(amH2O/2)/amH;

  /* O2 flue gases composition */
  XsfO2*Qsf = Qea*XeaO2 - Qcomb*amO*(2*XCcomb/amC + 0.5*XHcomb/amH + 2*XScomb/amS) + Qcomb*XOcomb;

  /* SO2 flue gases composition */
  XsfSO2*Qsf = Qea*XeaSO2 + Qcomb*XScomb*amSO2/amS;

  /* Fuel thermal power available */
  PCScomb = PCIcomb + 224.3e5*XHcomb + 25.1e5*XEAUcomb;
  Wcomb = Qcomb*PCIcomb;

  /* Thermal losses */
  Wpth_ref = Qcomb*PCIcomb*(Xpth + Xref);
  Qe*(Hsv - Hev) = Qcomb*PCIcomb*Xref;

  /* Air thermodynamic properties at the inlet */
  Hea = ThermoSysPro.Properties.FlueGases.FlueGases_h(Pea, Tea, XeaCO2, XeaH2O, XeaO2, XeaSO2);
  Cpair = ThermoSysPro.Properties.FlueGases.FlueGases_cp(Pea, Tea, XeaCO2, XeaH2O, XeaO2, XeaSO2);
  rhoea = ThermoSysPro.Properties.FlueGases.FlueGases_rho(Pea, Tea, XeaCO2, XeaH2O, XeaO2, XeaSO2);

  /* Flue gases thermodynamic properties at the outlet */
  Hsf = ThermoSysPro.Properties.FlueGases.FlueGases_h(Psf, Tsf, XsfCO2, XsfH2O, XsfO2, XsfSO2);
  rhosf = ThermoSysPro.Properties.FlueGases.FlueGases_rho(Psf, Tsf, XsfCO2, XsfH2O, XsfO2, XsfSO2);

  //---------------------
  //  BEAU DE ROCHAS CYCLE

  /* (1) Air and gas mixing at constant pressure Pea */
  Tm = (Qcomb*Cpcomb*Tcomb + Qea*Cpair*Tea)/(Qcomb*Cpcomb + Qea*Cpair);

  /* (2) Polytropic compression */
  Tfcp = Tm*RV^(Kc - 1);
  Pfcp = Pea*RV^Kc;

  /* (3) Constant volume combustion (point mort haut) */
  MMairgaz = (Qea*28.9 + Qcomb*MMg)/(Qea + Qcomb);
  MMfumees = (1 - XsfCO2 - XsfH2O - XsfO2 - XsfSO2)*28 + XsfCO2*44 + XsfH2O*18 + XsfO2*32 + XsfSO2*64;
  Pfcb = Pfcp*Tfcb/Tfcp*MMairgaz/MMfumees;
  //Tfcb = (Wcomb - Wpth_ref)/ThermoSysPro.Properties.FlueGases.FlueGases_cp(Pfcp, (Tfcp + Tfcb)/2, XsfCO2, XsfH2O, XsfO2, XsfSO2)/0.75/Qsf + Tfcp;
  Tfcb = Wcomb/ThermoSysPro.Properties.FlueGases.FlueGases_cp(Pfcp, (Tfcp + Tfcb)/2, XsfCO2, XsfH2O, XsfO2, XsfSO2)/Qsf + Tfcp;

  /* (4) Polytropic expansion */
  Tfd = Tfcb *(1/RV)^(Kd - 1);
  Pfd = Pfcb *(1/RV)^Kd;

  /* (5) Echappement */
  Tfe = Tfd*(Psf/Pfd)^((Gamma - 1)/Gamma);

  //---------------------

  /* Efficiency and mechanical power */
  if (mechanical_efficiency_type == 1) then
    Rmeca = Rmeca_nom;
  elseif (mechanical_efficiency_type == 2) then
    Rmeca = Coef_Rm_a * Wcomb/1000*Wcomb/1000 + Coef_Rm_b*Wcomb/1000 + Coef_Rm_c;
  else
    Rmeca = ((Qcomb*(Hcomb - Hrcomb + PCIcomb) + Qea*(Hea - Hrair))
            -(Qsf*(ThermoSysPro.Properties.FlueGases.FlueGases_h(Psf, Tfe, XsfCO2, XsfH2O, XsfO2, XsfSO2)
            -Hrfum) + Wpth_ref))/Wcomb;
  end if;

  Wmeca = Rmeca*Wcomb;

  /* Combustion air ratio */
  exc = Qea*(1 - XeaH2O)/((Qcomb*amO*(2*XCcomb/amC + 0.5*XHcomb/amH + 2*XScomb/amS - XOcomb/amO))/(XeaO2/(1 - XeaH2O)));

  /* Pressure losses */
  Pea - Psf = DPaf;
  Cws2.P = if (Qe > 0) then Cws1.P - DPe*Cws1.P/100 else Cws1.P + DPe*Cws1.P/100;

  /* Energy balance equation for the flue gases */
  (Qsf*(Hsf - Hrfum) + Wpth_ref + Wmeca) - (Qcomb*(Hcomb - Hrcomb + PCIcomb) + Qea*(Hea - Hrair)) = 0;

  Hcomb = Cpcomb*(Tcomb - 273.15);

  /* Electrical power produced and active power*/
  Welec = Wmeca*Relec;
  Wact = Welec*Cosphi;

  /* Reference specific enthalpies */
  Hrair = 2501.569e3*XeaH2O;
  Hrcomb = 0;
  Hrfum = 2501.569e3*XsfH2O;

    annotation (Diagram(graphics={
        Rectangle(
          extent={{-80,80},{80,-80}},
          lineColor={0,0,255},
          fillColor={255,213,170},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-10,-64},{4,-46},{0,-56},{18,-54},{2,-60},{22,-66},{6,-64},{
              -10,-76},{-2,-66},{-10,-64}},
          lineColor={0,0,0},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-46,-42},{-46,0},{-6,0},{-6,58},{0,50},{6,58},{6,0},{48,0},{
              48,-42},{-46,-42}},
          lineColor={0,0,0},
          fillColor={170,255,170},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-80,30},{-34,30},{-34,54},{38,54},{38,30},{80,30},{80,38},{
              46,38},{46,62},{-42,62},{-42,38},{-80,38},{-80,30}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid)}),
                             Icon(graphics={
        Rectangle(
          extent={{-80,80},{80,-80}},
          lineColor={0,0,255},
          fillColor={255,213,170},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-10,-64},{4,-46},{0,-56},{18,-54},{2,-60},{22,-66},{6,-64},{
              -10,-76},{-2,-66},{-10,-64}},
          lineColor={0,0,0},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-46,-42},{-46,0},{-6,0},{-6,58},{0,50},{6,58},{6,0},{48,0},{
              48,-42},{-46,-42}},
          lineColor={0,0,0},
          fillColor={170,255,170},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-80,30},{-34,30},{-34,54},{38,54},{38,30},{80,30},{80,38},{
              46,38},{46,62},{-42,62},{-42,38},{-80,38},{-80,30}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid)}),
    Documentation(revisions="<html>
<p><u><b>Author</b></u></p>
<ul>
<li>Beno&icirc;t Bride </li>
</ul>
</html>",
   info="<html>
<p><b>Copyright &copy; EDF 2002 - 2019</b> </p>
<p><b>ThermoSysPro Version 3.2</h4>
<p>This component model is documented in Chapter 15 of the <a href=\"https://www.springer.com/us/book/9783030051044\">ThermoSysPro book</a>. </h4>
</html>"));
end AlternatingEngine;
