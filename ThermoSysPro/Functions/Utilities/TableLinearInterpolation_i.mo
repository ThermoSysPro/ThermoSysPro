within ThermoSysPro.Functions.Utilities;
function TableLinearInterpolation_i
  "Table linear interpolation (internal function)"
  input Real TabP[:] "1st reference table";
  input Real TabX[:] "2nd reference table";
  input Real TabY[:, :] "Results table";
  input Real P "1st reference value";
  input Real X "2nd reference value";

  output Real Y "Interpolated result";
  output Real DeltaYX "Y step wrt. X";
  output Real DeltaYP "Y step wrt. P";

protected
  Integer dimP=size(TabP, 1) "TabP dimension";
  Integer dimX=size(TabX, 1) "TabX dimension";
  Integer dimY1=size(TabY, 1) "TabY 1st dimension";
  Integer dimY2=size(TabY, 2) "TabY 2nd dimension";
  Integer IndP=0 "Reference index";
  Boolean IndPcal "Computed index";
  Real Y1;
  Real DeltaYX1;
  Real Y2;
  Real DeltaYX2;

algorithm
  if ((dimX <> dimY2) or (dimP <> dimY1)) then
    assert(false, "TableLinearInterpolation: the dimensions of the tables are different");
  end if;

  IndPcal := false;

  for i in 2:dimP - 1 loop
    if ((P <= TabP[i]) and (not IndPcal)) then
      IndP := i;
      IndPcal := true;
    end if;
  end for;

  if (not IndPcal) then
    IndP := dimP;
  end if;

  (Y1,DeltaYX1) := ThermoSysPro.Functions.Utilities.LinearInterpolation_i(
    TabX,
    TabY[IndP - 1, :],
    X);
  (Y2,DeltaYX2) := ThermoSysPro.Functions.Utilities.LinearInterpolation_i(
    TabX,
    TabY[IndP, :],
    X);

  DeltaYP := (Y2 - Y1)/(TabP[IndP] - TabP[IndP - 1]);
  DeltaYX := DeltaYX1 + (P - TabP[IndP - 1])*(DeltaYX2 - DeltaYX1)/(TabP[IndP] - TabP[IndP - 1]);

  Y := Y1 + (P - TabP[IndP - 1])*DeltaYP;

  annotation (
    smoothOrder=2,
    Icon(graphics),        Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2012</b></p>
</HTML>
<html>
<p><b>ThermoSysPro Version 3.0</b></p>
</HTML>
",        revisions="<html>
<p><u><b>Author</b></u></p>
<ul>
<li>Baligh El Hefni </li>
</ul>
</html>"));
end TableLinearInterpolation_i;
