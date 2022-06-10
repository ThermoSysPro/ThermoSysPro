within ThermoSysPro.Fluid.HeatExchangers;
model StaticPlateHeatExchanger "Static plate heat exchanger"
  extends ThermoSysPro.Fluid.Interfaces.IconColors;
  import ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.FluidType;
  import ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region;

  parameter Units.SI.ThermalConductivity lambdam=15.0
    "Metal thermal conductivity";
  parameter Units.SI.CoefficientOfHeatTransfer p_hc=6000
    "Heat transfer coefficient for the hot side if not computed by the correlations";
  parameter Units.SI.CoefficientOfHeatTransfer p_hf=3000
    "Heat transfer coefficient for the cold side if not computed by the correlations";
  parameter Real p_Kc=100 "Pressure loss coefficient for the hot side if not computed by the correlations";
  parameter Real p_Kf=100 "Pressure loss coefficient for the cold side if not computed by the correlations";
  parameter Units.SI.Thickness emetal=0.0006 "Wall thickness";
  parameter Units.SI.Area Sp=2 "Plate area";
  parameter Real nbp=499 "Number of plates";
  parameter Real c1=1.12647 "Correction coefficient";
  parameter Integer exchanger_type=1 "Exchanger type - 1: counter-current. 2: co-current";
  parameter Integer heat_exchange_correlation=1 "Correlation for the computation of the heat exchange coefficient - 0: no correlation. 1: SRI correlations";
  parameter Integer pressure_loss_correlation=1 "Correlation for the computation of the pressure loss coefficient - 0: no correlation. 1: SRI correlations";
  parameter Units.SI.MassFlowRate gamma_diff_c=1e-4
    "Diffusion conductance for the hot fluid (active if diffusion=true in neighbouring volumes)";
  parameter Units.SI.MassFlowRate gamma_diff_f=1e-4
    "Diffusion conductance for the cold fluid (active if diffusion=true in neighbouring volumes)";
  parameter Units.SI.Density p_rhoc=0
    "If > 0, fixed fluid density for the hot fluid"
    annotation (Evaluate=true, Dialog(tab="Fluid", group="Fluid properties"));
  parameter Units.SI.Density p_rhof=0
    "If > 0, fixed fluid density for the cold fluid"
    annotation (Evaluate=true, Dialog(tab="Fluid", group="Fluid properties"));
  parameter IF97Region region_c=IF97Region.All_regions "IF97 region for the hot fluid (active for IF97 water/steam only)" annotation(Evaluate=true, Dialog(enable=(ftype==FluidType.WaterSteam), tab="Fluid", group="Fluid properties"));
  parameter IF97Region region_f=IF97Region.All_regions "IF97 region for the cold fluid (active for IF97 water/steam only)" annotation(Evaluate=true, Dialog(enable=(ftype==FluidType.WaterSteam), tab="Fluid", group="Fluid properties"));

protected
  parameter Integer mode_c=Integer(region_c) - 1 "IF97 region for the hot fluid. 1:liquid - 2:steam - 4:saturation line - 0:automatic";
  parameter Integer mode_f=Integer(region_f) - 1 "IF97 region for the cold fluid. 1:liquid - 2:steam - 4:saturation line - 0:automatic";

public
  Units.SI.Power W "Thermal power exchanged between the two sides";
  ThermoSysPro.Units.SI.PressureDifference DPc
    "Pressure loss of the hot fluid";
  ThermoSysPro.Units.SI.PressureDifference DPf
    "Pressure loss of the cold fluid";
  Units.SI.CoefficientOfHeatTransfer hc
    "Heat transfer coefficient of the hot fluid";
  Units.SI.CoefficientOfHeatTransfer hf
    "Heat transfer coefficient of the cold fluid";
  Units.SI.CoefficientOfHeatTransfer K "Global heat transfer coefficient";
  Units.SI.Area S "Heat exchange surface";
  Units.SI.Temperature Tec "Fluid temperature at the hot inlet";
  Units.SI.Temperature Tsc "Fluid temperature at the hot outlet";
  Units.SI.Temperature Tef "Fluid temperature at the cold inlet";
  Units.SI.Temperature Tsf "Fluid temperature at the cold outlet";
  ThermoSysPro.Units.SI.TemperatureDifference DTm
    "Difference in average temperature";
  ThermoSysPro.Units.SI.TemperatureDifference DT1
    "Temperature difference at the inlet of the exchanger";
  ThermoSysPro.Units.SI.TemperatureDifference DT2
    "Temperature difference at the outlet of the exchanger";
  Real DT12 "DT1/DT2 (s.u.)";
  Units.SI.MassFlowRate Qc(start=500) "Mass flow rate of the hot fluid";
  Units.SI.MassFlowRate Qf(start=500) "Mass flow rate of the cold fluid";
  Real qmc;
  Real qmf;
  Real quc;
  Real quf;
  Real N;
  Units.SI.Density rhoc(start=998) "Hot fluid density";
  Units.SI.Density rhof(start=998) "Cold fluid density";
  Units.SI.DynamicViscosity muc(start=1.e-3) "Hot fluid dynamic viscosity";
  Units.SI.DynamicViscosity muf(start=1.e-3) "Cold fluid dynamic viscosity";
  Units.SI.ThermalConductivity lambdac(start=0.602698)
    "Hot fluid thermal conductivity";
  Units.SI.ThermalConductivity lambdaf(start=0.597928)
    "Cold fluid thermal conductivity";
  Units.SI.Temperature Tmc(start=290) "Hot fluid average temperature";
  Units.SI.Temperature Tmf(start=290) "Cold fluid average temperature";
  Units.SI.AbsolutePressure Pmc(start=1.e5) "Hot fluid average pressure";
  Units.SI.AbsolutePressure Pmf(start=1.e5) "Cold fluid average pressure";
  Units.SI.SpecificEnthalpy Hmc(start=100000)
    "Hot fluid average specific enthalpy";
  Units.SI.SpecificEnthalpy Hmf(start=100000)
    "Cold fluid average specific enthalpy";
  FluidType ftype_c "Fluid type for the hot fluid";
  Integer fluid_c=Integer(ftype_c) "Fluid number for the hot fluid";
  FluidType ftype_f "Fluid type for the cold fluid";
  Integer fluid_f=Integer(ftype_f) "Fluid number for the cold fluid";

public
  Interfaces.Connectors.FluidInlet Ec annotation (Placement(transformation(
          extent={{-110,-10},{-90,10}}, rotation=0)));
  Interfaces.Connectors.FluidInlet Ef annotation (Placement(transformation(
          extent={{-60,-70},{-40,-50}}, rotation=0)));
  Interfaces.Connectors.FluidOutlet Sf annotation (Placement(transformation(
          extent={{40,-70},{60,-50}}, rotation=0)));
  Interfaces.Connectors.FluidOutlet Sc annotation (Placement(transformation(
          extent={{90,-8},{110,12}}, rotation=0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph proce
    annotation (Placement(transformation(extent={{-60,80},{-40,100}}, rotation=
            0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph procs
    annotation (Placement(transformation(extent={{-20,80},{0,100}}, rotation=0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph profe
    annotation (Placement(transformation(extent={{-60,-100},{-40,-80}},
          rotation=0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph profs
    annotation (Placement(transformation(extent={{-20,-100},{0,-80}}, rotation=
            0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph proc
    annotation (Placement(transformation(extent={{-100,80},{-80,100}}, rotation=
           0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph prof
    annotation (Placement(transformation(extent={{-100,-100},{-80,-80}},
          rotation=0)));
equation

  /* Mass flow rates */
  Ec.Q = Sc.Q;

  Ec.h_vol_1 = Sc.h_vol_1;
  Ec.h_vol_2 = Sc.h_vol_2;

  Sc.diff_on_1 = Ec.diff_on_1;
  Ec.diff_on_2 = Sc.diff_on_2;

  Sc.diff_res_1 = Ec.diff_res_1 + 1/gamma_diff_c;
  Ec.diff_res_2 = Sc.diff_res_2 + 1/gamma_diff_c;

  Ec.ftype = Sc.ftype;

  Ec.Xco2 = Sc.Xco2;
  Ec.Xh2o = Sc.Xh2o;
  Ec.Xo2  = Sc.Xo2;
  Ec.Xso2 = Sc.Xso2;

  ftype_c = Ec.ftype;

  Ef.Q = Sf.Q;

  Ef.h_vol_1 = Sf.h_vol_1;
  Ef.h_vol_2 = Sf.h_vol_2;

  Sf.diff_on_1 = Ef.diff_on_1;
  Ef.diff_on_2 = Sf.diff_on_2;

  Sf.diff_res_1 = Ef.diff_res_1 + 1/gamma_diff_f;
  Ef.diff_res_2 = Sf.diff_res_2 + 1/gamma_diff_f;

  Ef.ftype = Sf.ftype;

  Ef.Xco2 = Sf.Xco2;
  Ef.Xh2o = Sf.Xh2o;
  Ef.Xo2  = Sf.Xo2;
  Ef.Xso2 = Sf.Xso2;

  ftype_f = Ef.ftype;

  Qc = Ec.Q;
  Qf = Ef.Q;

  /* Pressures */
  Sc.P = if Qc > 0 then Ec.P - DPc else Ec.P + DPc;
  Sf.P = if Qf > 0 then Ef.P - DPf else Ef.P + DPf;

  /* Heat exchanges between the hot and cold fluids */
  K = hc*hf/(hc + hf + hc*hf*emetal/lambdam);
  W = K*S*DTm;

  if (abs(Qc) > 1.e-3) then
    W = Qc*proc.cp*(Tec - Tsc);
  else
    Tec = Tsc;
  end if;

  if (abs(Qf) > 1.e-3) then
    W = Qf*prof.cp*(Tsf - Tef);
  else
    Tef = Tsf;
  end if;

  /* Difference in average temperatures */
  if noEvent(((DT1 > DT2) and (DT2 > 0)) or ((DT1 < DT2) and (DT2 < 0))) then
    DTm = (DT1 - DT2)/Modelica.Math.log(DT1/DT2);
  else
    DTm = (DT1 + DT2)/2;
  end if;

  if (exchanger_type == 1) then
    /* Counter-current heat exchanger */
    DT1 = Tec - Tsf;
    DT2 = Tsc - Tef;
  elseif (exchanger_type == 2) then
    /* Co-current heat exchanger */
    DT1 = Tec - Tef;
    DT2 = Tsc - Tsf;
  else
    DT1 = 0;
    DT2 = 0;
    assert(false, "StaticWaterWaterExchanger: incorrect exchanger type");
  end if;

  DT12 = if noEvent(abs(DT2) > Modelica.Constants.eps) then DT1/DT2 else 0;

  /* Heat exchange area (for the plate heat exchanger) */
  S = (nbp - 2)*Sp;
  N = (nbp - 1)/2;

  /* Heat exchange coefficients */
  qmc = noEvent(abs(Qc)/(muc*N));
  qmf = noEvent(abs(Qf)/(muf*N));

  if (heat_exchange_correlation == 0) then
    hc = p_hc;
    hf = p_hf;
  elseif (heat_exchange_correlation == 1) then
    hc = noEvent(if (qmc < 1.e-3) then 0 else 11.245*qmc^0.8*abs(muc*proc.cp/lambdac)^0.4*lambdac);
    hf = noEvent(if (qmf < 1.e-3) then 0 else 11.245*qmf^0.8*abs(muf*prof.cp/lambdaf)^0.4*lambdaf);
  else
    hc = 0;
    hf = 0;
    assert(false, "StaticWaterWaterExchanger: incorrect heat exchange correlation number");
  end if;

  /* Pressure losses */
  quc = noEvent(abs(Qc)/N);
  quf = noEvent(abs(Qf)/N);

  if (pressure_loss_correlation == 0) then
    DPc = p_Kc*Qc^2/rhoc;
    DPf = p_Kf*Qf^2/rhof;
  elseif (pressure_loss_correlation == 1) then
    DPc = noEvent(if (qmc < 1.e-3) then 0 else c1*14423.2/rhoc*qmc^(-0.097)*quc^2*(1472.47 + 1.54*(N - 1)/2 + 104.97*qmc^(-0.25)));
    DPf = noEvent(if (qmf < 1.e-3) then 0 else 14423.2/rhof*qmf^(-0.097)*quf^2*(1472.47 + 1.54*(N - 1)/2 + 104.97*qmf^(-0.25)));
  else
    DPc = 0;
    DPf = 0;
    assert(false,
      "StaticWaterWaterExchanger: incorrect pressure loss correlation number");
  end if;

  /* Fluid thermodynamic properties */
  Pmc = (Ec.P + Sc.P)/2;
  Pmf = (Ef.P + Sf.P)/2;
  Hmc = (Ec.h + Sc.h)/2;
  Hmf = (Ef.h + Sf.h)/2;

  proc = ThermoSysPro.Properties.Fluid.Ph(Pmc, Hmc, mode_c, fluid_c);
  prof = ThermoSysPro.Properties.Fluid.Ph(Pmf, Hmf, mode_f, fluid_f);

  Tmc = proc.T;
  Tmf = prof.T;

  if (p_rhoc > 0) then
    rhoc = p_rhoc;
  else
    rhoc = proc.d;
  end if;

  if (p_rhof > 0) then
    rhof = p_rhof;
  else
    rhof = prof.d;
  end if;

  muc = ThermoSysPro.Properties.Fluid.DynamicViscosity_rhoT(rhoc, Tmc, fluid_c);
  muf = ThermoSysPro.Properties.Fluid.DynamicViscosity_rhoT(rhof, Tmf, fluid_f);

  lambdac = ThermoSysPro.Properties.Fluid.ThermalConductivity_rhoT(rhoc, Tmc, Pmc, 0, fluid_c);
  lambdaf = ThermoSysPro.Properties.Fluid.ThermalConductivity_rhoT(rhof, Tmf, Pmf, 0, fluid_f);

  /* Calcul des températures en entrée et en sortie de l'échangeur */
  proce = ThermoSysPro.Properties.Fluid.Ph(Ec.P, Ec.h, mode_c, fluid_c);
  procs = ThermoSysPro.Properties.Fluid.Ph(Sc.P, Sc.h, mode_c, fluid_f);

  profe = ThermoSysPro.Properties.Fluid.Ph(Ef.P, Ef.h, mode_f, fluid_c);
  profs = ThermoSysPro.Properties.Fluid.Ph(Sf.P, Sf.h, mode_f, fluid_f);

  Tec = proce.T;
  Tsc = procs.T;
  Tef = profe.T;
  Tsf = profs.T;

  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Rectangle(
          extent={{-100,60},{100,-60}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Solid,
          fillColor=DynamicSelect({255,255,0}, fill_color_static)),
        Line(points={{-80,60},{-80,-60}}),
        Line(points={{80,60},{80,-60}}),
        Line(points={{-80,0},{-60,0},{-40,20},{40,-20},{60,0},{80,0}}, color={
              28,108,200}),
        Text(
          extent={{-126,24},{-106,14}},
          lineColor={0,0,255},
          fillColor={255,213,170},
          fillPattern=FillPattern.Solid,
          textString="Hot inlet"),
        Text(
          extent={{-82,-66},{-62,-76}},
          lineColor={0,0,255},
          fillColor={255,213,170},
          fillPattern=FillPattern.Solid,
          textString="Cold inlet"),
        Text(
          extent={{66,-66},{90,-76}},
          lineColor={0,0,255},
          fillColor={255,213,170},
          fillPattern=FillPattern.Solid,
          textString="Cold outlet"),
        Text(
          extent={{104,24},{128,10}},
          lineColor={0,0,255},
          fillColor={255,213,170},
          fillPattern=FillPattern.Solid,
          textString="Hot outlet")}),
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Rectangle(
          extent={{-100,60},{100,-60}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Solid,
          fillColor={255,255,0}),
        Line(points={{-80,60},{-80,-60}}),
        Line(points={{80,60},{80,-60}}),
        Line(points={{-80,0},{-60,0},{-40,20},{40,-20},{60,0},{80,0}}, color={
              28,108,200}),
        Text(
          extent={{-122,22},{-102,12}},
          lineColor={0,0,255},
          fillColor={255,213,170},
          fillPattern=FillPattern.Solid,
          textString="Hot inlet"),
        Text(
          extent={{100,24},{124,10}},
          lineColor={0,0,255},
          fillColor={255,213,170},
          fillPattern=FillPattern.Solid,
          textString="Hot outlet"),
        Text(
          extent={{-86,-66},{-62,-76}},
          lineColor={0,0,255},
          fillColor={255,213,170},
          fillPattern=FillPattern.Solid,
          textString="Cold inlet"),
        Text(
          extent={{64,-66},{92,-80}},
          lineColor={0,0,255},
          fillColor={255,213,170},
          fillPattern=FillPattern.Solid,
          textString="Cold outlet")}),
    Window(
      x=0.05,
      y=0.01,
      width=0.93,
      height=0.87),
    Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2021</b> </p>
<p><b>ThermoSysPro Version 4.0</b> </p>
<p>This component model is documented in Sect. 9.6.2 of the <a href=\"https://www.springer.com/us/book/9783030051044\">ThermoSysPro book</a>. </p>
</html>",
   revisions="<html>
<p><u><b>Author</b></u></p>
<ul>
<li>Daniel Bouskela </li>
</ul>
</html>"));
end StaticPlateHeatExchanger;
