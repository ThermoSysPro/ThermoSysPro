within ThermoSysPro.Correlations.Thermal;
function WBCrossedCurrentConvectiveHeatTransferCoefficient
  "Convective heat transfer coefficient for crossed current heat exchangers"
  input Modelica.SIunits.Temperature TFilm "Film temperature";
  input Modelica.SIunits.MassFlowRate Qf "Flue gases mass flow rate";
  input Real Xh2o "H2O mass fraction in the flue gases";
  input Modelica.SIunits.Area Sgaz "Geometrical parameter";
  input Modelica.SIunits.Diameter Dext "Pipes external diameter";
  input Real Fa "Pipes position coefficient";
  input Integer option_interpolation=1
    "1: linear interpolation - 2: spline interpolation";

  output Modelica.SIunits.CoefficientOfHeatTransfer Kcfc
    "Convective heat transfer coefficient for crossed current heat exchanger";

protected
  Real Dextb "Pipes external diameter in feet";
  Real Qfb "Flue gases mass flow rate in pound/hour";
  Real Sgazb "Sgaz in feet^2";
  Real TFilmb "Film temperature in Farenheit";

  //**********************************************************************************
  //   Values of "Physical properties factor" for cross-current combustion flue gases
  //   taken from "The Babcock & Wilcox Company - STEAM/its generation and use"
  //**********************************************************************************/
  constant Real TabUm[5]={0,5,10,15,20};
  constant Real TabTFilm[6]={0,600,1200,1800,2400,3000};
  constant Real TabFpp[5, 6]=[0.0825, 0.11, 0.129, 0.142, 0.155, 0.165; 0.085,
      0.112, 0.132, 0.148, 0.161, 0.172; 0.087, 0.114, 0.136, 0.152, 0.167,
      0.18; 0.0885, 0.117, 0.139, 0.158, 0.173, 0.1872; 0.09, 0.1183, 0.1422,
      0.163, 0.18, 0.195];

  Real CondConv "Base convective conductance";
  Real MassFlow "Mass flow rate";
  Real Fpp "Physical properties factor";
  Real Kcb "Heat transfer coefficient in English units";
algorithm

  /* Conversion from SI units to English units */
  Dextb := 3.28084*Dext;
  Qfb := 2.20462*3600.*Qf + 0.5;
  Sgazb := 10.7369*Sgaz;
  TFilmb := 9/5*TFilm - 459.69;

  /* Mass flow rate */
  MassFlow := abs(Qfb)/Sgazb;

  /* Base convective conductance */
  CondConv := 0.287*MassFlow^0.61/Dextb^0.39;

  /* Physical properties factor */
  if (option_interpolation == 1) then
    Fpp := ThermoSysPro.Functions.TableLinearInterpolation(TabUm, TabTFilm, TabFpp, Xh2o, TFilmb);
  elseif (option_interpolation == 2) then
    Fpp := ThermoSysPro.Functions.TableSplineInterpolation(TabUm, TabTFilm, TabFpp, Xh2o, TFilmb);
  else
    assert(false, "WBCrossedCurrentConvectiveHeatTransferCoefficient: incorrect interpolation option");
  end if;

  /* Heat transfer coefficient for crossed-current flue gases */
  Kcb := CondConv*Fpp*Fa;

  /* Conversion from English units to SI units */
  Kcfc := 5.67826*Kcb;

  annotation (
      smoothOrder=2,
      Icon(graphics),      Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2013</b> </p>
<p><b>ThermoSysPro Version 3.1</h4>
</html>", revisions="<html>
<p><u><b>Author</b></u></p>
<ul>
<li>Baligh El Hefni </li>
</ul>
</html>"));
end WBCrossedCurrentConvectiveHeatTransferCoefficient;
