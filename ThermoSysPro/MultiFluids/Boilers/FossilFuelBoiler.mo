within ThermoSysPro.MultiFluids.Boilers;
model FossilFuelBoiler "Fossil fuel boiler"
  parameter Modelica.SIunits.Temperature Tsf=400
    "Flue gases temperature at the outlet";
  parameter Integer Boiler_efficiency_type = 1
    "1: Taking into account LHV only - 2: Using the total incoming power";
  parameter ThermoSysPro.Units.PressureLossCoefficient Kf=0.05
    "Flue gases pressure loss coefficient";
  parameter ThermoSysPro.Units.PressureLossCoefficient Ke=1e4
    "Water/steam pressure loss coefficient";
  parameter Real etacomb=1 "Combustion efficiency (between 0 and 1)";
  parameter Modelica.SIunits.Power Wloss=1e5 "Thermal losses";
  parameter Integer mode=0
    "IF97 region. 1:liquid - 2:steam - 4:saturation line - 0:automatic";

protected
  constant Real amC=12.01115 "Carbon atomic mass";
  constant Real amH=1.00797 "Hydrogen atomic mass";
  constant Real amO=15.9994 "Oxygen atomic mass";
  constant Real amS=32.064 "Sulfur atomic mass";
  constant Real amCO2 = amC + 2*amO "CO2 molecular mass";
  constant Real amH2O = 2*amH + amO "H2O molecular mass";
  constant Real amSO2 = amS + 2*amO "SO2 molecular mass";
  constant Real teps=1e-6 "Small number";
  parameter Real eps=1.e-0 "Small number for pressure loss equation";
  Real XeaO2c(start=0.2)
    "Intermediate variable for the computation of the O2 mass fraction";

public
  Modelica.SIunits.MassFlowRate Qea(start=400)
    "Air mass flow rate at the inlet";
  Modelica.SIunits.AbsolutePressure Pea(start=1e5) "Air pressure at the inlet";
  Modelica.SIunits.Temperature Tea(start=400) "Air temperature at the inlet";
  Modelica.SIunits.SpecificEnthalpy Hea(start=50e3)
    "Air specific enthalpy at the inlet";
  Modelica.SIunits.SpecificEnthalpy Hrair(start=10e3)
    "Air reference specific enthalpy";
  Real XeaCO2(start=0) "CO2 mass fraction at the inlet";
  Real XeaH2O(start=0.1) "H2O mass fraction at the inlet";
  Real XeaO2(start=0.2) "O2 mass fraction at the inlet";
  Real XeaSO2(start=0) "SO2 mass fraction at the inlet";

  Modelica.SIunits.MassFlowRate Qcomb(start=5) "Fuel mass flow rate";
  Modelica.SIunits.Temperature Tcomb(start=300) "Fuel temperature";
  Modelica.SIunits.SpecificEnthalpy Hcomb(start=10e3) "Fuel specific enthalpy";
  Modelica.SIunits.SpecificEnthalpy Hrcomb(start=10e3)
    "Fuel reference specific enthalpy";
  Real XCcomb(start=0.8) "Carbon mass fraction";
  Real XHcomb(start=0.2) "Hydrogen mass fraction";
  Real XOcomb(start=0) "Oxygen mass fraction";
  Real XScomb(start=0) "Sulfur mass fraction";
  Real PCIcomb(start=5e7) "Fuel PCI (J/kg)";
  Modelica.SIunits.SpecificHeatCapacity Cpcomb(start=2000)
    "Fuel specific heat capacity";

  Modelica.SIunits.MassFlowRate Qe(start=100) "Water/steam mass flow rate";
  Modelica.SIunits.AbsolutePressure Pee(start=50e5)
    "Water/steam pressure at the inlet";
  Modelica.SIunits.AbsolutePressure Pse(start=50e5)
    "Water/steam pressure at the outlet";
  ThermoSysPro.Units.DifferentialPressure deltaPe(start=1e5)
    "Water/steam pressure losses";
  Modelica.SIunits.Temperature Tse(start=500)
    "Water/steam temperature at the outlet";
  Modelica.SIunits.SpecificEnthalpy Hee(start=400e3)
    "Water/steam specific enthalpy at the inlet";
  Modelica.SIunits.SpecificEnthalpy Hse(start=400e3)
    "Water/steam specific enthalpy at the outlet";
  Modelica.SIunits.Density rhoe(start=998) "Average water/steam density";

  Modelica.SIunits.MassFlowRate Qsf(start=400)
    "Flue gases mass flow rate at the outlet";
  Modelica.SIunits.AbsolutePressure Psf(start=1e5)
    "Flue gases pressure at the outlet";
  Modelica.SIunits.Temperature Tf(start=1500)
    "Flue gases temperature after combustion";
  Modelica.SIunits.SpecificEnthalpy Hsf(start=50e3)
    "Flue gases specific enthalpy at the outlet";
  Modelica.SIunits.SpecificEnthalpy Hf(start=100e3)
    "Flue gases specific enthalpy after combustion";
  Modelica.SIunits.SpecificEnthalpy Hrfum(start=10e3)
    "Flue gases reference specific enthalpy";
  ThermoSysPro.Units.DifferentialPressure deltaPf(start=1e3)
    "Pressure losses in the combusiton chamber";
  Modelica.SIunits.Density rhof(start=0.05) "Flue gases density";
  Real XsfCO2(start=0.2) "CO2 mass fraction at the outlet";
  Real XsfH2O(start=0.15) "H2O mass fraction at the outlet";
  Real XsfO2(start=0) "O2 mass fraction at the outlet";
  Real XsfSO2(start=0) "SO2 mass fraction at the outlet";

  Modelica.SIunits.Power Wfuel(start=5e8) "Fuel available power PCI";
  Modelica.SIunits.Power Wtot(start=5e8) "Total incoming power";
  Modelica.SIunits.Power Wboil(start=5e9) "Power exchanged in the boiler";
  Real eta_boil(start=90) "Boiler efficiency (%) ";
  Real exc(start=1) "Air combustion ratio";
  Real exc_air(start=0.1) "Pertcentage of air in excess";
public
  ThermoSysPro.Combustion.Connectors.FuelInlet Cfuel
    annotation (Placement(transformation(extent={{-10,-90},{10,-70}}, rotation=
            0)));
  ThermoSysPro.FlueGases.Connectors.FlueGasesInlet Cair
    annotation (Placement(transformation(extent={{-110,-72},{-90,-52}},
          rotation=0)));
  ThermoSysPro.FlueGases.Connectors.FlueGasesOutlet Cfg
    annotation (Placement(transformation(extent={{90,-72},{110,-52}}, rotation=
            0)));
public
  ThermoSysPro.WaterSteam.Connectors.FluidInlet Cws1
                          annotation (Placement(transformation(extent={{-110,50},
            {-90,70}}, rotation=0)));
  ThermoSysPro.WaterSteam.Connectors.FluidOutlet Cws2
                          annotation (Placement(transformation(extent={{90,50},
            {110,70}}, rotation=0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph pros
    annotation (Placement(transformation(extent={{-100,84},{-80,104}}, rotation=
           0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph prom
    annotation (Placement(transformation(extent={{80,84},{100,104}}, rotation=0)));
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
  PCIcomb = Cfuel.LHV;
  Cpcomb = Cfuel.cp;

  /* Flue gases outlet */
  Qsf = Cfg.Q;
  Psf = Cfg.P;
  Tsf = Cfg.T;
  XsfCO2 = Cfg.Xco2;
  XsfH2O = Cfg.Xh2o;
  XsfO2 = Cfg.Xo2;
  XsfSO2 = Cfg.Xso2;

  /* Water/steam inlet */
  Hee = Cws1.h;
  Pee = Cws1.P;
  Qe = Cws1.Q;

  /* Water/steam outlet */
  Cws2.h = Hse;
  Cws2.P = Pse;
  Cws2.Q = Qe;

  /* Flow reversal */
  0 = if (Qe > 0) then Cws1.h - Cws1.h_vol else Cws2.h - Cws2.h_vol;

  /* Mass balance equation for the flue gases */
  Qsf = Qea + Qcomb;

  /* CO2 flue gases composition */
  XsfCO2*Qsf = Qea*XeaCO2 + Qcomb*XCcomb*amCO2/amC;

  /* H2O flue gases composition */
  XsfH2O*Qsf = Qea*XeaH2O + Qcomb*XHcomb*(amH2O/2)/amH;

  /* O2 flue gases composition */
  XsfO2*Qsf = Qea*XeaO2c - Qcomb*amO*(2*XCcomb/amC + 0.5*XHcomb/amH + 2*XScomb/amS) + Qcomb*XOcomb;

  /* SO2 flue gases composition */
  XsfSO2*Qsf = Qea*XeaSO2 + Qcomb*XScomb*amSO2/amS;

  /* Combustion air ratio */
  exc = Qea*(1 - XeaH2O) / ((Qcomb*amO*(2*XCcomb/amC + 0.5*XHcomb/amH + 2*XScomb/amS - XOcomb/amO)) / (XeaO2c/(1 - XeaH2O)));

  /* Air excess */
  exc_air = (exc - 1)*100;

  /* Flue gases pressure losses */
  Pea - Psf = deltaPf;
  deltaPf = Kf*ThermoSysPro.Functions.ThermoSquare(
                                                  Qsf, eps)/rhof;

  /* Water/steam pressure losses */
  Pee - Pse = deltaPe;
  deltaPe = Ke*ThermoSysPro.Functions.ThermoSquare(
                                                  Qe, eps)/rhoe;

  /* Fuel specific enthalpy at the inlet */
  Hcomb = Cpcomb*Tcomb;

  /* Energy balance equation for the flue gases */
  0 = (Qsf*(Hf - Hrfum)  + Wloss) - (Qcomb*(Hcomb - Hrcomb + PCIcomb*etacomb) + Qea*(Hea - Hrair));

  /* Fuel power */
  Wfuel = Qcomb*PCIcomb;

  /* Total incoming power */
  Wtot = Qcomb*(Hcomb - Hrcomb + PCIcomb*etacomb) + Qea*(Hea - Hrair);

  /* Power exchanged in the boiler */
  Wboil = Wtot - Qsf*(Hsf - Hrfum) - Wloss;

  /* Water/steam specific enthalpy at the outlet */
  Hse = Wboil/Qe + Hee;

  /* Boiler efficiency*/
  if (Boiler_efficiency_type == 1) then
     eta_boil = 100*Wboil/Wfuel;
  else
     eta_boil = 100*Wboil/Wtot;
  end if;

  /* Air specific enthalpy at the inlet */
  Hea = ThermoSysPro.Properties.FlueGases.FlueGases_h(Pea, Tea, XeaCO2, XeaH2O, XeaO2c, XeaSO2);

  /* Flue gases tempretaure after combustion */
  // Changed from FlueGases_T to FlueGases_h to provide a differentiable function
  Hf = ThermoSysPro.Properties.FlueGases.FlueGases_h(Pea, Tf, XsfCO2, XsfH2O, XsfO2, XsfSO2);

  /* Flue gases specific enthalpy at the outlet */
  Hsf = ThermoSysPro.Properties.FlueGases.FlueGases_h(Psf, Tsf, XsfCO2, XsfH2O, XsfO2, XsfSO2);

  /* Flue gases density */
  rhof = ThermoSysPro.Properties.FlueGases.FlueGases_rho(Pea, (Tea + Tf)/2, XsfCO2, XsfH2O, XsfO2, XsfSO2);

  0 = if (XeaO2 > teps) then (XeaO2c - XeaO2) else (XeaO2c - teps);

  /* Reference specific enthalpies */
  Hrair = 2501.569e3*XeaH2O;
  Hrcomb = 0;
  Hrfum = 2501.569e3*XsfH2O;

  /* Water/steam thermodynamic properties */
  prom = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph((Pee + Pse)/2, (Hee + Hse)/2, mode);
  rhoe = prom.d;

  pros = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph(Pse, Hse, mode);
  Tse = pros.T;

    annotation (Diagram(graphics={
        Rectangle(
          extent={{-100,80},{100,-80}},
          lineColor={0,0,255},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{0,-42},{12,-46},{22,-34},{26,-20},{24,-6},{22,2},{18,12},{14,
              22},{12,30},{10,36},{6,54},{2,44},{-2,36},{-6,24},{-6,20},{-8,16},
              {-10,24},{-12,26},{-14,22},{-18,14},{-20,8},{-24,0},{-26,-10},{
              -28,-20},{-28,-28},{-22,-36},{-18,-42},{-8,-48},{0,-42}},
          lineColor={255,0,128},
          fillColor={255,128,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-8,-22},{-6,-18},{-2,-16},{2,-16},{6,-18},{8,-20},{10,-26},{
              10,-30},{8,-28},{6,-24},{4,-20},{-2,-20},{-4,-22},{-8,-26},{-10,
              -28},{-10,-28},{-8,-22}},
          lineColor={127,0,0},
          fillColor={127,0,0},
          fillPattern=FillPattern.Solid)}),
                             Icon(graphics={
        Rectangle(
          extent={{-100,80},{100,-80}},
          lineColor={0,0,255},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-2,-42},{10,-46},{20,-34},{24,-20},{22,-6},{20,2},{16,12},{
              12,22},{10,30},{8,36},{4,54},{0,44},{-4,36},{-8,24},{-8,20},{-10,
              16},{-12,24},{-14,26},{-16,22},{-20,14},{-22,8},{-26,0},{-28,-10},
              {-30,-20},{-30,-28},{-24,-36},{-20,-42},{-10,-48},{-2,-42}},
          lineColor={255,0,128},
          fillColor={255,128,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-10,-24},{-8,-20},{-4,-18},{0,-18},{4,-20},{6,-22},{8,-28},{
              8,-32},{6,-30},{4,-26},{2,-22},{-4,-22},{-6,-24},{-10,-28},{-12,
              -30},{-12,-30},{-10,-24}},
          lineColor={127,0,0},
          fillColor={127,0,0},
          fillPattern=FillPattern.Solid)}),
    Documentation(revisions="<html>
<p><u><b>Author</b></u></p>
<ul>
<li>Baligh El Hefni </li>
</ul>
</html>",
   info="<html>
<p><b>Copyright &copy; EDF 2002 - 2019</b> </p>
<p><b>ThermoSysPro Version 3.2</h4>
<p>This component model is documented in Sect. 7.2 of the <a href=\"https://www.springer.com/us/book/9783030051044\">ThermoSysPro book</a>. </h4>
</html>"));
end FossilFuelBoiler;
