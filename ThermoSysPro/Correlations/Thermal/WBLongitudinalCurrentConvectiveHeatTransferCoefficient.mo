within ThermoSysPro.Correlations.Thermal;
function WBLongitudinalCurrentConvectiveHeatTransferCoefficient
  "Convective heat transfer coefficient for co- or counter-current heat exchangers"
  input Modelica.SIunits.Temperature TFilm "Film temperature";
  input Modelica.SIunits.Temperature Tmf "Flue gases average temperature";
  input Modelica.SIunits.MassFlowRate Qf "Flue gases mass flow rate";
  input Real Xh2o "H2O mass fraction";
  input Modelica.SIunits.Area Sgaz "Geometrical parameter";
  input Modelica.SIunits.Diameter Dext "Pipes external diameter";
  input Integer option_interpolation=1
    "1: linear interpolation - 2: spline interpolation";

  output Modelica.SIunits.CoefficientOfHeatTransfer Kcfl
    "Convective heat transfer coefficient for longitudinal flows";

protected
  Real Dextb "Pipes external diameter in feet";
  Real Qfb "Flue gases mass flow rate in pound/hour";
  Real Sgazb "Geometrical parameter Sgaz in feet^2";
  Real TFilmb "Film temperature in Farenheit";
  Real Tmfb "Température moyenne des fumées en °F";

  //**********************************************************************************
  //   Values of "Physical properties factor" for transverse flow combustion flue gases
  //   taken from "The Babcock & Wilcox Company - STEAM/its generation and use"
  //**********************************************************************************/
  constant Real TabUm[5]={0,5,10,15,20};
  constant Real TabTFilm[12]={0,200,400,600,800,1000,1200,1400,1600,2000,2400,
      2800};
  constant Real TabFpp[5, 12]=[0.152, 0.166, 0.180, 0.190, 0.198, 0.205, 0.212,
       0.217, 0.221, 0.229, 0.236, 0.242; 0.158, 0.171, 0.184, 0.195, 0.204,
      0.211, 0.218, 0.222, 0.228, 0.236, 0.244, 0.251; 0.163, 0.176, 0.189,
      0.200, 0.209, 0.216, 0.224, 0.229, 0.234, 0.244, 0.252, 0.260; 0.170,
      0.183, 0.194, 0.205, 0.214, 0.222, 0.229, 0.237, 0.240, 0.250, 0.260,
      0.268; 0.178, 0.189, 0.200, 0.211, 0.220, 0.228, 0.234, 0.241, 0.247,
      0.256, 0.266, 0.275];

  Real CondConv "Base convective conductance";
  Real MassFlow "Mass flow rate";
  Real Fpp "Physical properties factor";
  Real FT "Temperature factor";
  Real Kcb "Heat transfer coefficient in English units";
algorithm

  /* Conversion from SI units to English units */
  Dextb := 3.28084*Dext;
  Qfb := 2.20462*3600*Qf;
  Sgazb := 10.7369*Sgaz;
  Tmfb := 9./5.*Tmf - 459.69;
  TFilmb := 9./5.*TFilm - 459.69;

  /* Mass flow rate */
  MassFlow := abs(Qfb)/Sgazb;

  /* Base convective conductance */
  CondConv := 0.023*MassFlow^0.6/Dextb^0.2;

  /* Physical properties factor */
  if (option_interpolation == 1) then
    Fpp := ThermoSysPro.Functions.TableLinearInterpolation(TabUm, TabTFilm, TabFpp, Xh2o, TFilmb);
  elseif (option_interpolation == 2) then
    Fpp := ThermoSysPro.Functions.TableSplineInterpolation(TabUm, TabTFilm, TabFpp, Xh2o, TFilmb);
  else
    assert(false, "WBLongitudinalCurrentConvectiveHeatTransferCoefficient: incorrect interpolation option");
  end if;

  /* Temperature coefficient */
  FT := (Tmfb/TFilmb)^0.8;

  /* Heat transfer coefficient for longitudinal flow flue gases */
  Kcb := CondConv*Fpp*FT;

  /* Conversion from English units to SI units */
  Kcfl := 5.67826*Kcb;

  annotation (
    smoothOrder=2,
    Icon(graphics),        Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2013</b> </p>
<p><b>ThermoSysPro Version 3.1</h4>
</html>", revisions="<html>
<p><u><b>Author</b></u></p>
<ul>
<li>Baligh El Hefni </li>
</ul>
</html>"));
end WBLongitudinalCurrentConvectiveHeatTransferCoefficient;
