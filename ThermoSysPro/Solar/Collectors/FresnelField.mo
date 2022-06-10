within ThermoSysPro.Solar.Collectors;
model FresnelField "Fresnel field"
  parameter Units.SI.Area A=10e4 "Aperture area of a train";
  parameter Integer mode_efficency=1 "1:Definition of each parameter : rho, a, tau , geo. 2:Definition of the global optical efficency";
  parameter Real eta0=0.625 "Global optical efficency at normal irradiation";
  parameter Real rho=0.935 "Reflexivity of the primary reflector";
  parameter Real a=0.955 "Absorptivity of the collector";
  parameter Real tau=0.965 "Transmissivity of the glass envelope";
  parameter Real geo=0.725 "Geometric default factor";
  parameter Real dispo=1 "Mean disponibility of the field";
  parameter Real clean=1 "Mean cleanliness factor";
  parameter Units.SI.Length h=7.4 "Height of a collector";
  parameter ThermoSysPro.Units.SI.Length Lc=44.8 "Length of a collector";
  parameter Units.SI.Length w=11.46 "Aperture width of a collector";
  parameter Units.SI.CoefficientOfHeatTransfer hc=1 "Heat transfer coefficient";
  parameter Boolean thermalLossPhy=true "true: thermal loss using a physical equation - false: thermal loss using a polynomial equation f(deltaT)";
  parameter Units.SI.Diameter D=0.07 "External tube diameter (active if thermalLossPhy=true)";
  parameter Real F12=1 "View factor to surroundings radiation heat loss (active if thermalLossPhy=true)";
  parameter Real Emi=0.8 "Tube emissivity (active if thermalLossPhy=true)";
  parameter Real A1=0.1598 "x coefficient of the linear thermal loss caracteristics Qloss=f(deltaT) (active if thermalLossPhy=false)";
  parameter Real A2=0.0057 "x^2 coefficient of the linear thermal loss caracteristics Qloss=f(deltaT) (active if thermalLossPhy=false)";
  parameter Real B0=0.995 "Constant coefficient of the KT caracteristics KT=f(thetaT)";
  parameter Real B1=-4e-4 "x coefficient of the KT caracteristics KT=f(thetaT)";
  parameter Real B2=-3e-5 "x^2 coefficient of the KT caracteristics KT=f(thetaT)";
  parameter Real B3=1e-6 "x^3 coefficient of the KT caracteristics KT=f(thetaT)";
  parameter Real B4=-5e-8 "x^4 coefficient of the KT caracteristics KT=f(thetaT)";
  parameter Real B5=3e-10 "x^5 coefficient of the KT caracteristics KT=f(thetaT)";
  parameter Real B6=0 "x^6 coefficient of the KT caracteristics KT=f(thetaT)";
  parameter Units.SI.Temperature T0=300 "Atmospheric temperature";
  parameter Integer Ns=10 "Number of cells (sections) in the field";
  parameter ThermoSysPro.Units.nonSI.Angle_deg SunA0=90 "Sun azimuth angle by default";
  parameter ThermoSysPro.Units.nonSI.Angle_deg SunG0=1e-6 "Sun elevation angle by default";
  parameter Units.SI.Irradiance SunDNI0=1000 "Direct normal irradiance by default";
  parameter Real trackingFactor=1 "Mean sun tracking system factor";

protected
  constant Real pi=Modelica.Constants.pi "pi";
  parameter Real eps=1e-6 "epsilon";

public
  Units.SI.Length L(start=44.8) "Length of a train";
  Units.SI.Power dPth[Ns](start=fill(80e7/Ns, Ns)) "Thermal Power transfered to the fluid for each section";
  Real ETA0(start=0.625) "Definition of efficency at normal irradiation";
  Real sin_alphaS(start=1) "Used in the definition of thetaL and thetaT";
  ThermoSysPro.Units.nonSI.Angle_deg thetaT(start=0) "Transversal incidence angle";
  ThermoSysPro.Units.nonSI.Angle_deg thetaL(start=0) "Longitudinal incidence angle";
  Real track "Mean sun tracking system factor";
  Units.SI.Power Pth(start=563e6) "Thermal Power transfered to the the fluid";
  Units.SI.Power Qrec(start=625e6) "Thermal Power received by the receptor";
  Units.SI.Power Qloss(start=625e5) "Thermal loss on the receptor";
  Real KT(start=1) "Transversal incidence modifier fonction";
  Real KL(start=1) "Longitudinal incidence modifier fonction";
  ThermoSysPro.Units.SI.TemperatureDifference deltaT[Ns](start=fill(50, Ns)) "Mean tempertaure difference";
  ThermoSysPro.Units.nonSI.Angle_deg gammaS(start=90) "Sun azimuth angle";
  ThermoSysPro.Units.nonSI.Angle_deg alphaS(start=1e-6) "Sun elevation angle";
  Units.SI.Irradiance DNI(start=2000) "Direct normal irradiance";
  Units.SI.Temperature T[Ns](start=fill(300, Ns)) "Pipe wall Temperature ";
  Units.SI.Power dQloss[Ns](start=fill(563e6/Ns, Ns)) "Thermal loss on the receptor by each cell (section)";

  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal SunG
    "Azimuthal angle of the sun as function of time"
    annotation (Placement(transformation(
        origin={68,70},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal SunDNI
    "Direct Normal Irradiance as fnction of time"
    annotation (Placement(transformation(
        origin={110,40},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal SunA
    "Elevation angle of the sun as function of time"
    annotation (Placement(transformation(
        origin={92,70},
        extent={{-10,-10},{10,10}},
        rotation=270)));

  ThermoSysPro.Thermal.Connectors.ThermalPort P[Ns]
    "Thermal Power transfered to the fluid"
    annotation (Placement(transformation(extent={{-10,-70},{10,-50}}, rotation=
            0)));

  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal Track "Track"
    annotation (Placement(transformation(
        origin={-90,70},
        extent={{-10,-10},{10,10}},
        rotation=270)));
equation
  /* Input connectors */
  alphaS = SunA.signal;
  gammaS = SunG.signal;
  DNI = SunDNI.signal;
  track = Track.signal;

  if (cardinality(SunA) == 0) then
    SunA.signal = SunA0;
  end if;

  if (cardinality(SunG) == 0) then
    SunG.signal = SunG0;
  end if;

  if (cardinality(SunDNI) == 0) then
    SunDNI.signal = SunDNI0;
  end if;

  if (cardinality(Track) == 0) then
    Track.signal = trackingFactor;
  end if;

  /* Output connectors */
  P.W = -dPth;
  P.T = T;

  /* Power conservation + Thermal loss on the receptor */
  for i in 1:Ns loop
    /* Power conservation + Thermal loss on the receptor */
    deltaT[i] = T[i] - T0;
    dQloss[i] = if thermalLossPhy then pi*D*L/Ns*(0.5*F12*Emi*5.67e-8*(T[i]^4 - (0.0552*T0^(1.5))^4) + hc*(T[i] - T0)) else L/Ns*(A1*deltaT[i] + A2*deltaT[i]^2);
    dPth[i] = Qrec/Ns - dQloss[i];
  end for;

  Pth = sum(dPth);
  Qloss = Qrec - Pth;

  /* Definition of thetaT and thetaL */
  sin_alphaS = abs(sin(pi*alphaS/180));
  thetaT = if noEvent(sin_alphaS <= eps) then 90 else 180*atan(sin(pi*gammaS/180)/tan(pi*alphaS/180))/pi;
  thetaL = 180*acos(sqrt(1 - (cos(pi*alphaS/180)*cos(pi*gammaS/180))^2))/pi;

  /* Optical efficency at normal irradiation */
  if (mode_efficency == 1) then
    ETA0 = rho*a*tau*geo;
  else
    ETA0 = eta0;
  end if;

  /* Definition of KT */
  KT = B6*abs(thetaT)^6 + B5*abs(thetaT)^5 + B4*abs(thetaT)^4 + B3*abs(thetaT)^3 + B2*abs(thetaT)^2 + B1*abs(thetaT) + B0;

  /* Definition of KL */
  KL = cos(pi*thetaL/180)*(1 - h*tan(pi*thetaL/180)/Lc);

  /* Thermal Power received by the receptor */
  Qrec = A*DNI*ETA0*KT*KL*dispo*track*clean;

  /* Length of the pipe and pipe section */
  L = A/w;

  annotation (Icon(graphics={
        Rectangle(
          extent={{-100,60},{100,-60}},
          lineColor={0,0,255},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{100,22},{60,60}},
          lineColor={0,0,255},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-84,-10},{-80,-60}},
          lineColor={255,255,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Line(points={{80,56},{-80,-24},{-16,-56}}, color={255,255,0}),
        Line(points={{80,52},{-80,-28},{-24,-56}}, color={255,255,0}),
        Line(points={{80,48},{-80,-32},{-32,-56}}, color={255,255,0}),
        Line(points={{80,44},{-80,-36},{-40,-56}}, color={255,255,0}),
        Line(points={{80,40},{-80,-40},{-48,-56}}, color={255,255,0}),
        Line(points={{80,36},{-80,-44},{-56,-56}}, color={255,255,0}),
        Line(points={{80,32},{-80,-48},{-64,-56}}, color={255,255,0}),
        Ellipse(extent={{22,-28},{86,-40}}, lineColor={0,0,255}),
        Rectangle(
          extent={{-74,-56},{0,-60}},
          lineColor={0,0,0},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid)}),
                            Diagram(graphics={
        Rectangle(
          extent={{-100,60},{100,-60}},
          lineColor={0,0,255},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{100,22},{60,60}},
          lineColor={0,0,255},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-84,-10},{-80,-60}},
          lineColor={255,255,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Line(points={{80,56},{-80,-24},{-16,-56}}, color={255,255,0}),
        Line(points={{80,52},{-80,-28},{-24,-56}}, color={255,255,0}),
        Line(points={{80,48},{-80,-32},{-32,-56}}, color={255,255,0}),
        Line(points={{80,44},{-80,-36},{-40,-56}}, color={255,255,0}),
        Line(points={{80,40},{-80,-40},{-48,-56}}, color={255,255,0}),
        Line(points={{80,36},{-80,-44},{-56,-56}}, color={255,255,0}),
        Line(points={{80,32},{-80,-48},{-64,-56}}, color={255,255,0}),
        Ellipse(extent={{22,-28},{86,-40}}, lineColor={0,0,255}),
        Rectangle(
          extent={{-74,-56},{0,-60}},
          lineColor={0,0,0},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid)}),
    Documentation(info="<html>
<h4>Copyright &copy; EDF 2002 - 2021</h4>
<h4>ThermoSysPro Version 4.0</h4>
<p>This component model is documented in Sect. 16.2 of the <a href=\"https://www.springer.com/us/book/9783030051044\">ThermoSysPro book</a>. </p>
</html>",
   revisions="<html>
</html>"));
end FresnelField;
