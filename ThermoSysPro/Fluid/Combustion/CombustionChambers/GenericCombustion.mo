within ThermoSysPro.Fluid.Combustion.CombustionChambers;
model GenericCombustion "Generic combustion chamber"
  extends
    ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.FlueGasesFluidTypeParameterInterface;
  extends ThermoSysPro.Fluid.Interfaces.IconColors;
  import ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.FluidType;
  import ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region;

  parameter ThermoSysPro.Units.xSI.PressureLossCoefficient kcham=1 "Pressure loss coefficient in the combustion chamber";
  parameter Units.SI.Area Acham=1 "Average corss-sectional area of the combusiton chamber";
  parameter Real Xpth=0.01 "Thermal loss fraction in the body of the combustion chamber (0-1 over Q.HHV)";
  parameter Real ImbCV=0 "Unburnt particles ratio in the volatile ashes (0-1)";
  parameter Real ImbBF=0 "Unburnt particle ratio in the low furnace ashes (0-1)";
  parameter Units.SI.SpecificHeatCapacity Cpcd=500 "Ashes specific heat capacity";
  parameter Units.SI.Temperature Tbf=500 "Ashes temperature at the outlet of the low furnace";
  parameter Real Xbf=0.1 "Ashes ration in the low furnace (0-1)";
  parameter Boolean diffusion=false "true: energy balance equation with diffusion - false: energy balance equation without diffusion";

protected
  constant Real amC=12.01115 "Carbon atomic mass";
  constant Real amH=1.00797 "Hydrogen atomic mass";
  constant Real amO=15.9994 "Oxygen atomic mass";
  constant Real amS=32.064 "Sulfur atomic mass";
  constant Units.SI.SpecificEnergy HHVcarbone=32.8e6 "Unburnt carbon higher heating value";
  constant Real amCO2=amC + 2*amO "CO2 molecular mass";
  constant Real amH2O=2*amH + amO "H2O molecular mass";
  constant Real amSO2=amS + 2*amO "SO2 molecular mass";
  parameter Units.SI.MassFlowRate gamma0=1.e-4
    "Pseudo-diffusion conductance use for continuous flow reversal (active if diffusion=false and continuous_flow_reversal = true)";

public
  Units.SI.MassFlowRate Qea(start=400) "Air mass flow rate";
  Units.SI.AbsolutePressure Pea(start=1e5) "Air pressure at the inlet";
  Units.SI.Temperature Tea(start=600) "Air temperature at the inlet";
  Units.SI.SpecificEnthalpy Hea(start=50e3) "Air specific enthalpy at the inlet";
  Real XeaCO2(start=0) "CO2 mass fraction at the air inlet";
  Real XeaH2O(start=0.1) "H2O mass fraction at the air inlet";
  Real XeaO2(start=0.2) "O2 mass fraction at the air inlet";
  Real XeaSO2(start=0) "SO2 mass fraction at the air inlet";
  Units.SI.MassFlowRate Qfuel(start=5) "Fuel mass flow rate";
  Units.SI.Temperature Tfuel(start=300) "Fuel temperature";
  Units.SI.SpecificEnthalpy Hfuel(start=10e3) "Fuel specific enthalpy";
  Real XCfuel(start=0.8) "C mass fraction in the fuel";
  Real XHfuel(start=0.2) "H mass fraction in the fuel";
  Real XOfuel(start=0) "O mass fraction in the fuel";
  Real XSfuel(start=0) "S mass fraction in the fuel";
  Real Xwfuel(start=0) "H2O mass fraction in the fuel";
  Real XCDfuel(start=0) "Ashes mass fraction in the fuel";
  Units.SI.SpecificEnergy LHVfuel(start=5e7) "Fuel lower heating value";
  Units.SI.SpecificHeatCapacity Cpfuel(start=1000) "Fuel specific heat capacity";
  Units.SI.SpecificEnergy HHVfuel "Fuel higher heating value";
  Units.SI.MassFlowRate Qews(start=1) "Water/steam mass flow rate";
  Units.SI.SpecificEnthalpy Hews(start=10e3) "Water/steam specific enthalpy at the inlet";
  Units.SI.MassFlowRate Qsf(start=400) "Flue gases mass flow rate";
  Units.SI.AbsolutePressure Psf(start=12e5) "Flue gases pressure at the outlet";
  Units.SI.Temperature Tsf(start=1500) "Flue gases temperature at the outlet";
  Units.SI.SpecificEnthalpy Hsf(start=50e4) "Flue gases specific enthalpy at the outlet";
  Real XsfCO2(start=0.5) "CO2 mass fraction in the flue gases";
  Real XsfH2O(start=0.1) "H2O mass fraction in the flue gases";
  Real XsfO2(start=0) "O2 mass fraction in the flue gases";
  Real XsfSO2(start=0) "SO2 mass fraction in the flue gases";
  Units.SI.Power Wfuel(start=5e8) "LHV power available in the fuel";
  Units.SI.Power Wpth(start=1e6) "Thermal losses power";
  Real exc(start=1) "Combustion air ratio";
  Units.SI.MassFlowRate Qcv(start=1) "Volatile ashes mass flow rate";
  Units.SI.MassFlowRate Qbf(start=1) "Low furnace ashes mass flow rate";
  Units.SI.SpecificEnthalpy Hcv(start=10e3)
    "Volatile ashes specific enthalpy at the outlet";
  Units.SI.SpecificEnthalpy Hbf(start=10e3)
    "Low furnace ashes specific enthalpy at the outlet";
  ThermoSysPro.Units.SI.PressureDifference deltaPccb(start=1e3) "Pressure loss in the combustion chamber";
  Units.SI.SpecificEnthalpy Hrair(start=10e3) "Air reference specific enthalpy";
  Units.SI.SpecificEnthalpy Hrws(start=10e4) "Water/steam reference specific enthalpy";
  Units.SI.SpecificEnthalpy Hrfuel(start=10e3) "Fuel reference specific enthalpy";
  Units.SI.SpecificEnthalpy Hrcd(start=10e3) "Ashes reference specific enthalpy";
  Units.SI.SpecificEnthalpy Hrfg(start=10e3) "Flue gases reference specific enthalpy";
  Real Vea(start=0.001) "Air volume mass (m3/kg)";
  Real Vsf(start=0.001) "Flue gases volume mass (m3/kg)";
  Units.SI.Density rhoea(start=0.001) "Air density at the inlet";
  Units.SI.Density rhosf(start=0.001) "Flue gases density at the outlet";
  Units.SI.MassFlowRate Qm(start=400) "Average mlass flow rate in the combusiton chamber";
  Real Vccbm(start=0.001) "Average volume mass in the combustion chamber";
  Units.SI.Velocity v(start=100) "Flue gases reference velocity in the combusiton chamber";
  Units.SI.SpecificEnthalpy h(start=10e5) "Fluid specific enthalpy";
  FluidType fluids[3] "Fluids mixing in volume";
  Units.SI.Power Ja "Thermal power diffusion from inlet Ca";
  Units.SI.Power Jws "Thermal power diffusion from inlet Cws";
  Units.SI.Power Jfg "Thermal power diffusion from outlet Cfg";
  Units.SI.Power J "Total thermal power diffusion";
  Units.SI.MassFlowRate gamma_a "Diffusion conductance for inlet Ca";
  Units.SI.MassFlowRate gamma_ws "Diffusion conductance for inlet Cws";
  Units.SI.MassFlowRate gamma_fg "Diffusion conductance for outlet Cfg";
  Real ra "Value of r(Q/gamma) for inlet Ca";
  Real rws "Value of r(Q/gamma) for inlet Cws";
  Real rfg "Value of r(Q/gamma) for outlet Cfg";
  FluidType ftype_ws "Water/steam fluid type";
  Integer fluid_ws=Integer(ftype_ws) "Water/steam fluid number";

public
  ThermoSysPro.Fluid.Interfaces.Connectors.FuelInlet Cfuel "Fuel inlet"
    annotation (Placement(transformation(extent={{60,-100},{80,-80}}, rotation=
            0)));
  ThermoSysPro.Fluid.Interfaces.Connectors.FluidInlet Ca "Air inlet"
    annotation (Placement(transformation(extent={{-40,-100},{-20,-80}},
          rotation=0)));
  ThermoSysPro.Fluid.Interfaces.Connectors.FluidOutlet Cfg "Flue gases outlet"
    annotation (Placement(transformation(extent={{-40,80},{-20,100}}, rotation=
            0)));
  ThermoSysPro.Fluid.Interfaces.Connectors.FluidInlet Cws "Water/steam inlet"
    annotation (Placement(transformation(extent={{-100,0},{-80,20}}, rotation=0)));
equation

  /* Check that incoming fluids are compatible with fluid in volume */
  fluids[1] = ftype;
  fluids[2] = Ca.ftype;
  fluids[3] = Cfg.ftype;

  assert(ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.isCompatible(fluids),
    "GenericCombustion1D: fluids mixing in volume are not compatible with each other");

  /* Fuel inlet */
  Qfuel = Cfuel.Q;
  Tfuel = Cfuel.T;

  XCfuel = Cfuel.Xc;
  XHfuel = Cfuel.Xh;
  XOfuel = Cfuel.Xo;
  XSfuel = Cfuel.Xs;
  Xwfuel = Cfuel.hum;
  XCDfuel = Cfuel.Xashes;

  LHVfuel = Cfuel.LHV;
  Cpfuel = Cfuel.cp;

  /* Water inlet */
  assert((ftype_ws == FluidType.WaterSteam) or (ftype_ws == FluidType.WaterSteamSimple), "GenericCombustion: the fluid type for the water/steam inlet must be water/steam");

  Cws.diff_res_2 = 0;
  Cws.diff_on_2 = diffusion;

  ftype_ws = Cws.ftype;

  Qews = Cws.Q;
  Hews = Cws.h;

  /* Air inlet */
  Qea = Ca.Q;
  Pea = Ca.P;
  Hea = Ca.h;

  XeaCO2 = Ca.Xco2;
  XeaH2O = Ca.Xh2o;
  XeaO2 = Ca.Xo2;
  XeaSO2 = Ca.Xso2;

  /* Flue gases outlet */
  Qsf = Cfg.Q;
  Psf = Cfg.P;
  Hsf = Cfg.h;

  XsfCO2 = Cfg.Xco2;
  XsfH2O = Cfg.Xh2o;
  XsfO2 = Cfg.Xo2;
  XsfSO2 = Cfg.Xso2;

  /* Mass balance equation */
  0 = Qea + Qews + Qfuel*(1 - XCDfuel) - Qcv*ImbCV - Qbf*ImbBF - Qsf;

  Qcv = Qfuel*XCDfuel*(1 - Xbf)/(1 - ImbCV);
  Qbf = Qfuel*XCDfuel*Xbf/(1 - ImbBF);

  /* Energy balance equation */
  0 = ((Qea + Qews + Qfuel*(1 - XCDfuel))*(Hsf - Hrfg) + Wpth + Qcv*(Hcv - Hrcd)+ Qbf*(Hbf - Hrcd)+(Qcv*ImbCV+Qbf*ImbBF)*HHVcarbone)
      - (Qfuel*(Hfuel - Hrfuel + LHVfuel) + Qea*(Hea - Hrair) + Qews*(Hews - Hrws)) + J;

  Hfuel = Cpfuel*(Tfuel - 273.16);
  Hcv = Cpcd*(Tsf - 273.16);
  Hbf = Cpcd*(Tbf - 273.16);

  Cws.h_vol_2 = h;
  Ca.h_vol_2 = h;
  Cfg.h_vol_1 = h;

  Cfg.ftype = ftype;

  /* No flow reversal */
  Cfg.h = Cfg.h_vol_1;

  /* Diffusion power */
  if diffusion then
    ra = if Ca.diff_on_1 then exp(-0.033*(Ca.Q*Ca.diff_res_1)^2) else 0;
    rws = if Cws.diff_on_1 then exp(-0.033*(Cws.Q*Cws.diff_res_1)^2) else 0;
    rfg = if Cfg.diff_on_2 then exp(-0.033*(Cfg.Q*Cfg.diff_res_2)^2) else 0;

    gamma_a = if Ca.diff_on_1 then 1/Ca.diff_res_1 else gamma0;
    gamma_ws = if Cws.diff_on_1 then 1/Cws.diff_res_1 else gamma0;
    gamma_fg = if Cfg.diff_on_2 then 1/Cfg.diff_res_2 else gamma0;

    Ja = if Ca.diff_on_1 then ra*gamma_a*(Ca.h_vol_1 - Ca.h_vol_2) else 0;
    Jws = if Cws.diff_on_1 then rws*gamma_ws*(Cws.h_vol_1 - Cws.h_vol_2) else 0;
    Jfg = if Cfg.diff_on_2 then rfg*gamma_fg*(Cfg.h_vol_2 - Cfg.h_vol_1) else 0;
  else
    ra = 0;
    rws = 0;
    rfg = 0;

    gamma_a = gamma0;
    gamma_ws = gamma0;
    gamma_fg = gamma0;

    Ja = 0;
    Jws = 0;
    Jfg = 0;
  end if;

  J = Ja + Jws + Jfg;

  Ca.diff_res_2 = 0;
  Cfg.diff_res_1 = 0;

  Ca.diff_on_2 = diffusion;
  Cfg.diff_on_1 = diffusion;

 /* Reference specific enthalpies */
  Hrair = 2501.569e3*XeaH2O;
  Hrfuel = 0;
  Hrws = 2501.569e3;
  Hrfg = 2501.569e3*XsfH2O;
  Hrcd = 0;

  /* Air specific enthalpy at the inlet */
  Hea = ThermoSysPro.Properties.FlueGases.FlueGases_h(Pea, Tea, XeaCO2, XeaH2O, XeaO2, XeaSO2);

  /* Flue gases specific enthalpy at the outlet */
  Hsf = ThermoSysPro.Properties.FlueGases.FlueGases_h(Psf, Tsf, XsfCO2, XsfH2O, XsfO2, XsfSO2);

  /* Air density at the inlet */
  rhoea = ThermoSysPro.Properties.FlueGases.FlueGases_rho(Pea, Tea, XeaCO2, XeaH2O, XeaO2, XeaSO2);
  Vea = if (rhoea > 0.001) then 1/rhoea else 1/1.1;

  /* Flue gases density at the outlet */
  rhosf = ThermoSysPro.Properties.FlueGases.FlueGases_rho(Psf, Tsf, XsfCO2, XsfH2O, XsfO2, XsfSO2);
  Vsf = if (rhosf > 0.001) then 1/rhosf else 1/0.1;

  /* CO2 flue gases mass fraction */
  XsfCO2*Qsf = (Qea*XeaCO2) + ((Qfuel*XCfuel - Qcv*ImbCV - Qbf*ImbBF)*amCO2/amC);

  /* H2O flue gases mass fraction */
  XsfH2O*Qsf = Qews + (Qea*XeaH2O+Qfuel*XHfuel*amH2O/2 /amH);

  /* O2 flue gases mass fraction */
  XsfO2*Qsf = (Qea*XeaO2) - (Qfuel*amO*(2*XCfuel/amC + 0.5*XHfuel/amH + 2*XSfuel/amS)) + (Qfuel*XOfuel);

  /* SO2 flue gases mass fraction */
  XsfSO2*Qsf = (Qea*XeaSO2) + (Qfuel*XSfuel*amSO2/amS);

  /* Fuel thermal power */
  HHVfuel = LHVfuel + 224.3e5*XHfuel + 25.1e5*Xwfuel;
  Wfuel = Qfuel*HHVfuel;
  Wpth = Qfuel*LHVfuel*Xpth;

  /* Combustion air ratio */
  exc = Qea*(1 - XeaH2O)/((Qfuel*amO*(2*XCfuel/amC + 0.5*XHfuel/amH + 2*XSfuel/amS - XOfuel/amO)
        - Qfuel*amO*2*(Qcv*ImbCV + Qbf*ImbBF)/amC)/(XeaO2/(1 - XeaH2O)));

  /* Pressure losses */
  Pea - Psf = deltaPccb;
  Qm = Qea + (Qfuel + Qews)/2;
  Vccbm = (Vea + Vsf)/2;
  v = Qm*Vccbm/Acham;
  deltaPccb = (kcham*(v^2))/(2*Vccbm);

    annotation (Diagram(graphics={
        Rectangle(
          extent={{-80,80},{80,-80}},
          lineColor={0,0,255},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-50,-36},{-44,30},{-34,-2},{-10,66},{10,-4},{44,54},{66,-44},
              {38,-80},{-34,-80},{-50,-36}},
          lineColor={0,0,0},
          fillColor={255,128,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-32,-36},{-18,-44},{-26,-16},{-16,6},{4,-44},{8,-28},{36,-72},
              {16,-80},{-16,-80},{-32,-36}},
          lineColor={0,0,0},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid)}),
                             Icon(graphics={
        Rectangle(
          extent={{-80,80},{80,-80}},
          lineColor={0,0,255},
          fillColor=DynamicSelect({255,255,0},
          if diffusion then fill_color_singular
          else fill_color_static),
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-50,-36},{-44,30},{-34,-2},{-10,66},{10,-4},{44,54},{66,-44},
              {38,-80},{-34,-80},{-50,-36}},
          lineColor={0,0,0},
          fillColor={255,128,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-32,-36},{-18,-44},{-26,-16},{-16,6},{4,-44},{8,-28},{36,-72},
              {16,-80},{-16,-80},{-32,-36}},
          lineColor={0,0,0},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{82,-76},{108,-104}},
          lineColor={28,108,200},
          textString="Fuel inlet"),
        Text(
          extent={{-66,-78},{-42,-102}},
          lineColor={28,108,200},
          textString="Air inlet"),
        Text(
          extent={{-110,42},{-82,14}},
          lineColor={28,108,200},
          textString="Water inlet"),
        Text(
          extent={{-18,106},{30,70}},
          lineColor={238,46,47},
          textString="Flue gases outlet")}),
    Documentation(revisions="<html>
<p><u><b>Authors</b></u></p>
<ul>
<li>Beno&icirc;t Bride</li>
<li>Baligh El Hefni </li>
</ul>
</html>",
   info="<html>
<p><b>Copyright &copy; EDF 2002 - 2021</b> </p>
<p><b>ThermoSysPro Version 4.0</b> </p>
</html>"));
end GenericCombustion;
