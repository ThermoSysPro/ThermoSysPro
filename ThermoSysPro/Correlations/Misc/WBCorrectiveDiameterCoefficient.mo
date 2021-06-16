within ThermoSysPro.Correlations.Misc;
function WBCorrectiveDiameterCoefficient "Corrective diameter coefficient"
  input Real PasTD "Transverse step on the diameter";
  input Real PasLD "Longitudinal steap on the diameter";
  input Modelica.SIunits.Diameter Dext "Pipes external diameter";
  input Integer option_interpolation=1
    "1: linear interpolation - 2: spline interpolation";

  output Real Optl;

protected
  constant Real TabTD[6]={1.,1.6,2.2,3.,3.6,6.};
  constant Real TabLD[4]={1.,2.,3.,4.};
  constant Real TabOpt[4, 6]=[0.4, 1., 2.3, 5.1, 6.8, 12.; 1.7, 3.1, 5., 7.1,
      8.5, 13.1; 5.1, 6.3, 7.5, 9.1, 10.2, 14.3; 7.7, 8.7, 9.7, 11., 11.9, 16.];
  Real Opt "Interpolated parameter";
algorithm

  if (PasLD > 0) then
    if (option_interpolation == 1) then
      Opt := ThermoSysPro.Functions.TableLinearInterpolation(TabLD, TabTD, TabOpt, PasLD, PasTD);
    elseif (option_interpolation == 2) then
      Opt := ThermoSysPro.Functions.TableSplineInterpolation(TabLD, TabTD, TabOpt, PasLD, PasTD);
    else
      assert(false, "WBCorrectiveDiameterCoefficient: incorrect interpolation option");
    end if;
    Optl := Opt*Dext;
  else
    Optl := 0;
  end if;

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
end WBCorrectiveDiameterCoefficient;
