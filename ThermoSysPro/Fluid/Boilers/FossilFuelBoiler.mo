within ThermoSysPro.Fluid.Boilers;
model FossilFuelBoiler "Fossil fuel boiler"
  extends
    ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.FlueGasesFluidTypeParameterInterface;
  extends ThermoSysPro.Fluid.Interfaces.IconColors;
  import ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.FluidType;
  import ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region;

  parameter Units.SI.Temperature Tsf=400 "Flue gases temperature at the outlet";
  parameter Integer Boiler_efficiency_type = 1 "1: Taking into account LHV only - 2: Using the total incoming power";
  parameter ThermoSysPro.Units.xSI.PressureLossCoefficient Kf=0.05
    "Flue gases pressure loss coefficient";
  parameter ThermoSysPro.Units.xSI.PressureLossCoefficient Ke=1e4
    "Water/steam pressure loss coefficient";
  parameter Real etacomb=1 "Combustion efficiency (between 0 and 1)";
  parameter Units.SI.Power Wloss=1e5 "Thermal losses";
  parameter Units.SI.MassFlowRate gamma_diff_ws=1e-4
    "Diffusion conductance for the water/steam side (active if diffusion=true in neighbouring volumes)";
  parameter Boolean continuous_flow_reversal=false "true: continuous flow reversal - false: discontinuous flow reversal";
  parameter Boolean diffusion=false "true: energy balance equation with diffusion - false: energy balance equation without diffusion";
  parameter IF97Region region=IF97Region.All_regions "IF97 region (active for IF97 water/steam only)" annotation(Evaluate=true, Dialog(enable=(ftype==FluidType.WaterSteam), tab="Fluid", group="Fluid properties"));

protected
  constant Real amC=12.01115 "Carbon atomic mass";
  constant Real amH=1.00797 "Hydrogen atomic mass";
  constant Real amO=15.9994 "Oxygen atomic mass";
  constant Real amS=32.064 "Sulfur atomic mass";
  constant Real amCO2 = amC + 2*amO "CO2 molecular mass";
  constant Real amH2O = 2*amH + amO "H2O molecular mass";
  constant Real amSO2 = amS + 2*amO "SO2 molecular mass";
  constant Real teps=1e-6 "Small number";
  parameter Integer mode=Integer(region) - 1 "IF97 region. 1:liquid - 2:steam - 4:saturation line - 0:automatic";
  parameter Units.SI.MassFlowRate gamma0=1.e-4
    "Pseudo-diffusion conductance use for continuous flow reversal (active if diffusion=false and continuous_flow_reversal = true)";
  parameter Real eps=1.e-0 "Small number for pressure loss equation";

public
  Units.SI.MassFlowRate Qea(start=400) "Air mass flow rate at the inlet";
  Units.SI.AbsolutePressure Pea(start=1e5) "Air pressure at the inlet";
  Units.SI.Temperature Tea(start=400) "Air temperature at the inlet";
  Units.SI.SpecificEnthalpy Hea(start=50e3)
    "Air specific enthalpy at the inlet";
  Units.SI.SpecificEnthalpy Hrair(start=10e3) "Air reference specific enthalpy";
  Real XeaCO2(start=0) "CO2 mass fraction at the inlet";
  Real XeaH2O(start=0.1) "H2O mass fraction at the inlet";
  Real XeaO2(start=0.2) "O2 mass fraction at the inlet";
  Real XeaSO2(start=0) "SO2 mass fraction at the inlet";
  Real XeaO2c(start=0.2) "Intermediate variable for the computation of the O2 mass fraction";

  Units.SI.MassFlowRate Qcomb(start=5) "Fuel mass flow rate";
  Units.SI.Temperature Tcomb(start=300) "Fuel temperature";
  Units.SI.SpecificEnthalpy Hcomb(start=10e3) "Fuel specific enthalpy";
  Units.SI.SpecificEnthalpy Hrcomb(start=10e3)
    "Fuel reference specific enthalpy";
  Real XCcomb(start=0.8) "Carbon mass fraction";
  Real XHcomb(start=0.2) "Hydrogen mass fraction";
  Real XOcomb(start=0) "Oxygen mass fraction";
  Real XScomb(start=0) "Sulfur mass fraction";
  Real PCIcomb(start=5e7) "Fuel PCI (J/kg)";
  Units.SI.SpecificHeatCapacity Cpcomb(start=2000)
    "Fuel specific heat capacity";

  Units.SI.MassFlowRate Qe(start=100) "Water/steam mass flow rate";
  Units.SI.AbsolutePressure Pee(start=50e5) "Water/steam pressure at the inlet";
  Units.SI.AbsolutePressure Pse(start=50e5)
    "Water/steam pressure at the outlet";
  ThermoSysPro.Units.SI.PressureDifference deltaPe(start=1e5)
    "Water/steam pressure losses";
  Units.SI.Temperature Tse(start=500) "Water/steam temperature at the outlet";
  Units.SI.SpecificEnthalpy Hee(start=400e3)
    "Water/steam specific enthalpy at the inlet";
  Units.SI.SpecificEnthalpy Hse(start=400e3)
    "Water/steam specific enthalpy at the outlet";
  Units.SI.Density rhoe(start=998) "Average water/steam density";

  Units.SI.MassFlowRate Qsf(start=400)
    "Flue gases mass flow rate at the outlet";
  Units.SI.AbsolutePressure Psf(start=1e5) "Flue gases pressure at the outlet";
  Units.SI.Temperature Tf(start=1500) "Flue gases temperature after combustion";
  Units.SI.SpecificEnthalpy Hsf(start=50e3)
    "Flue gases specific enthalpy at the outlet";
  Units.SI.SpecificEnthalpy Hf(start=100e3)
    "Flue gases specific enthalpy after combustion";
  Units.SI.SpecificEnthalpy Hrfum(start=10e3)
    "Flue gases reference specific enthalpy";
  ThermoSysPro.Units.SI.PressureDifference deltaPf(start=1e3)
    "Pressure losses in the combusiton chamber";
  Units.SI.Density rhof(start=0.05) "Flue gases density";
  Real XsfCO2(start=0.2) "CO2 mass fraction at the outlet";
  Real XsfH2O(start=0.15) "H2O mass fraction at the outlet";
  Real XsfO2(start=0) "O2 mass fraction at the outlet";
  Real XsfSO2(start=0) "SO2 mass fraction at the outlet";

  Units.SI.Power Wfuel(start=5e8) "Fuel available power PCI";
  Units.SI.Power Wtot(start=5e8) "Total incoming power";
  Units.SI.Power Wboil(start=5e9) "Power exchanged in the boiler";
  Real eta_boil(start=90) "Boiler efficiency (%) ";
  Real exc(start=1) "Air combustion ratio";
  Real exc_air(start=0.1) "Pertcentage of air in excess";

  FluidType fluids[2] "Fluids mixing in volume";
  Units.SI.SpecificEnthalpy h(start=10e5) "Flue gases specific enthalpy";
  Units.SI.Power Jair "Thermal power diffusion from inlet Cair";
  Units.SI.Power Jfg "Thermal power diffusion from outlet Cfg";
  Units.SI.Power J "Total thermal power diffusion";
  Units.SI.MassFlowRate gamma_air "Diffusion conductance for inlet Cair";
  Units.SI.MassFlowRate gamma_fg "Diffusion conductance for outlet Cfg";
  Real rair "Value of r(Q/gamma) for inlet Cair";
  Real rfg "Value of r(Q/gamma) for outlet Cfg";
  FluidType ftype_ws "Water/steam fluid type";
  Integer fluid_ws=Integer(ftype_ws) "Water/steam fluid number";

public
  Interfaces.Connectors.FuelInlet Cfuel "Fuel inlet"
    annotation (Placement(transformation(extent={{-10,-90},{10,-70}}, rotation=
            0)));
  Interfaces.Connectors.FluidInlet Cair "Air inlet"
                                        annotation (Placement(transformation(
          extent={{-110,-72},{-90,-52}}, rotation=0)));
  Interfaces.Connectors.FluidOutlet Cfg "Flue gases outlet"
                                        annotation (Placement(transformation(
          extent={{90,-72},{110,-52}}, rotation=0)));
public
  Interfaces.Connectors.FluidInlet Cws1 "Water inlet"
                                        annotation (Placement(transformation(
          extent={{-110,50},{-90,70}}, rotation=0)));
  Interfaces.Connectors.FluidOutlet Cws2 "Water/steam outlet"
                                         annotation (Placement(transformation(
          extent={{90,50},{110,70}}, rotation=0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph pros
    annotation (Placement(transformation(extent={{-100,84},{-80,104}}, rotation=
           0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph prom
    annotation (Placement(transformation(extent={{80,84},{100,104}}, rotation=0)));
equation

  /* Check that incoming fluids are compatible with fluid in volume */
  fluids[1] = ftype;
  fluids[2] = Cair.ftype;

  assert(ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.isCompatible(fluids), "InternalCombustionEngine: fluids mixing in volume are not compatible with each other");

  // ----------------
  // Water/steam side

  assert((ftype_ws == FluidType.WaterSteam) or (ftype_ws == FluidType.WaterSteamSimple), "InternalCombustionEngine: the fluid type for the water/steam side must be water/steam");

  Cws1.Q = Cws2.Q;

  Cws1.h_vol_1 = Cws2.h_vol_1;
  Cws1.h_vol_2 = Cws2.h_vol_2;

  Cws2.diff_on_1 = if (gamma_diff_ws > 0) then Cws1.diff_on_1 else false;
  Cws1.diff_on_2 = if (gamma_diff_ws > 0) then Cws2.diff_on_2 else false;

  Cws2.diff_res_1 = Cws1.diff_res_1 + (if (gamma_diff_ws > 0) then 1/gamma_diff_ws else 0);
  Cws1.diff_res_2 = Cws2.diff_res_2 + (if (gamma_diff_ws > 0) then 1/gamma_diff_ws else 0);

  Cws1.ftype = Cws2.ftype;

  Cws1.Xco2 = Cws2.Xco2;
  Cws1.Xh2o = Cws2.Xh2o;
  Cws1.Xo2  = Cws2.Xo2;
  Cws1.Xso2 = Cws2.Xso2;

  ftype_ws = Cws1.ftype;

  Qe = Cws1.Q;

  Pee = Cws1.P;
  Hee = Cws1.h;

  Pse = Cws2.P;
  Hse = Cws2.h;

  // ---------------
  // Combustion side

  /* Fuel inlet */
  Qcomb = Cfuel.Q;
  Tcomb = Cfuel.T;
  XCcomb = Cfuel.Xc;
  XHcomb = Cfuel.Xh;
  XOcomb = Cfuel.Xo;
  XScomb = Cfuel.Xs;
  PCIcomb = Cfuel.LHV;
  Cpcomb = Cfuel.cp;

  /* Air inlet */
  Qea = Cair.Q;
  Pea = Cair.P;
  Hea = Cair.h;

  XeaCO2 = Cair.Xco2;
  XeaH2O = Cair.Xh2o;
  XeaO2 = Cair.Xo2;
  XeaSO2 = Cair.Xso2;

  /* Flue gases outlet */
  Qsf = Cfg.Q;
  Psf = Cfg.P;
  Hsf = Cfg.h;

  /* Mass balance equation for the flue gases */
  0 = Qcomb + Qea - Qsf;

  /* Energy balance equation for the flue gases */
  0 = Qcomb*(Hcomb - Hrcomb + PCIcomb*etacomb) + Qea*(Hea - Hrair) - Qsf*(Hf - Hrfum) - Wloss + J;

  Hcomb = Cpcomb*Tcomb;

  Cair.h_vol_2 = h;
  Cfg.h_vol_1 = h;

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

  /* Flue gases composition balance equations */
  0 = Qcomb*XCcomb*amCO2/amC + Qea*XeaCO2 - Qsf*XsfCO2;
  0 = Qcomb*XHcomb*(amH2O/2)/amH + Qea*XeaH2O - Qsf*XsfH2O;
  0 = Qea*XeaO2c - Qcomb*amO*(2*XCcomb/amC + 0.5*XHcomb/amH + 2*XScomb/amS) + Qcomb*XOcomb - Qsf*XsfO2;
  0 = Qcomb*XScomb*amSO2/amS + Qea*XeaSO2 - Qsf*XsfSO2;

  Cfg.ftype = ftype;

  Cfg.Xco2 = XsfCO2;
  Cfg.Xh2o = XsfH2O;
  Cfg.Xo2  = XsfO2;
  Cfg.Xso2 = XsfSO2;

  /* Combustion air ratio */
  exc = Qea*(1 - XeaH2O) / ((Qcomb*amO*(2*XCcomb/amC + 0.5*XHcomb/amH + 2*XScomb/amS - XOcomb/amO)) / (XeaO2c/(1 - XeaH2O)));

  /* Air excess */
  exc_air = (exc - 1)*100;

  /* Flue gases pressure losses */
  Pea - Psf = deltaPf;
  deltaPf = Kf*ThermoSysPro.Functions.ThermoSquare(Qsf, eps)/rhof;

  /* Water/steam pressure losses */
  Pee - Pse = deltaPe;
  deltaPe = Ke*ThermoSysPro.Functions.ThermoSquare(Qe, eps)/rhoe;

  /* No flow reversal */
  Cfg.h = Cfg.h_vol_1;

  /* Diffusion power */
  if diffusion then
    rair = if Cair.diff_on_1 then exp(-0.033*(Cair.Q*Cair.diff_res_1)^2) else 0;
    rfg = if Cfg.diff_on_2 then exp(-0.033*(Cfg.Q*Cfg.diff_res_2)^2) else 0;

    gamma_air = if Cair.diff_on_1 then 1/Cair.diff_res_1 else gamma0;
    gamma_fg = if Cfg.diff_on_2 then 1/Cfg.diff_res_2 else gamma0;

    Jair = if Cair.diff_on_1 then rair*gamma_air*(Cair.h_vol_1 - Cair.h_vol_2) else 0;
    Jfg = if Cfg.diff_on_2 then rfg*gamma_fg*(Cfg.h_vol_2 - Cfg.h_vol_1) else 0;
  else
    rair = 0;
    rfg = 0;

    gamma_air = gamma0;
    gamma_fg = gamma0;

    Jair = 0;
    Jfg = 0;
  end if;

  J = Jair + Jfg;

  Cair.diff_res_2 = 0;
  Cfg.diff_res_1 = 0;

  Cair.diff_on_2 = diffusion;
  Cfg.diff_on_1 = diffusion;

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

    annotation (             Icon(graphics={
        Rectangle(
          extent={{-100,80},{100,-80}},
          lineColor={0,0,255},
          fillColor= DynamicSelect({255,255,0},
          if diffusion then fill_color_singular
          else fill_color_static),
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
          fillPattern=FillPattern.Solid),
        Line(points={{-92,60},{92,60},{88,60},{80,60}}, color={28,108,200}),
        Line(points={{-92,-62},{92,-62},{88,-62},{80,-62}},
                                                        color={255,0,0})}),
    Documentation(revisions="<html>
<p><u><b>Author</b></u></p>
<ul>
<li>Baligh El Hefni </li>
</ul>
</html>",
   info="<html>
<p><b>Copyright &copy; EDF 2002 - 2021</b> </p>
<p><b>ThermoSysPro Version 4.0</b> </p>
<p>This component model is documented in Sect. 7.2 of the <a href=\"https://www.springer.com/us/book/9783030051044\">ThermoSysPro book</a>. </p>
</html>"),
    Diagram(graphics={
        Rectangle(
          extent={{-100,80},{100,-80}},
          lineColor={0,0,255},
          fillColor= {127,255,0},
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
          fillPattern=FillPattern.Solid),
        Text(
          extent={{68,-30},{108,-56}},
          lineColor={238,46,47},
          textString="Flue Gases"),
        Line(points={{-92,60},{92,60},{88,60},{80,60}}, color={28,108,200}),
        Line(points={{-92,-62},{92,-62},{88,-62},{80,-62}},
                                                        color={255,0,0}),
        Text(
          extent={{-112,-36},{-86,-52}},
          lineColor={28,108,200},
          textString="Air")}));
end FossilFuelBoiler;
