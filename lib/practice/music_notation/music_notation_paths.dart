import 'dart:ui';

class MusicNotationPath {
  static Path fClef(Size size) {
    return Path()
      ..moveTo(size.width * 0.8450075, size.height * 0.5000000)
      ..cubicTo(
          size.width * 0.8450075,
          size.height * 0.4624352,
          size.width * 0.8792846,
          size.height * 0.4326425,
          size.width * 0.9225037,
          size.height * 0.4326425)
      ..cubicTo(size.width * 0.9657228, size.height * 0.4326425, size.width,
          size.height * 0.4624352, size.width, size.height * 0.5000000)
      ..cubicTo(
          size.width,
          size.height * 0.5375648,
          size.width * 0.9657228,
          size.height * 0.5673575,
          size.width * 0.9225037,
          size.height * 0.5673575)
      ..cubicTo(
          size.width * 0.8792846,
          size.height * 0.5673575,
          size.width * 0.8450075,
          size.height * 0.5375648,
          size.width * 0.8450075,
          size.height * 0.5000000)
      ..close()
      ..moveTo(size.width * 0.8450075, size.height * 0.1761658)
      ..cubicTo(
          size.width * 0.8450075,
          size.height * 0.1386010,
          size.width * 0.8792846,
          size.height * 0.1088083,
          size.width * 0.9225037,
          size.height * 0.1088083)
      ..cubicTo(size.width * 0.9657228, size.height * 0.1088083, size.width,
          size.height * 0.1386010, size.width, size.height * 0.1761658)
      ..cubicTo(
          size.width,
          size.height * 0.2137306,
          size.width * 0.9657228,
          size.height * 0.2435233,
          size.width * 0.9225037,
          size.height * 0.2435233)
      ..cubicTo(
          size.width * 0.8792846,
          size.height * 0.2435233,
          size.width * 0.8450075,
          size.height * 0.2137306,
          size.width * 0.8450075,
          size.height * 0.1761658)
      ..close()
      ..moveTo(size.width * 0.3636364, 0)
      ..cubicTo(
          size.width * 0.6184799,
          0,
          size.width * 0.7988077,
          size.height * 0.1113990,
          size.width * 0.7988077,
          size.height * 0.3212435)
      ..cubicTo(
          size.width * 0.7988077,
          size.height * 0.6619171,
          size.width * 0.4053651,
          size.height * 0.8588083,
          size.width * 0.02831595,
          size.height * 0.9961140)
      ..cubicTo(
          size.width * 0.02533532,
          size.height * 0.9987047,
          size.width * 0.02086438,
          size.height * 1.000000,
          size.width * 0.01639344,
          size.height * 1.000000)
      ..cubicTo(size.width * 0.007451565, size.height * 1.000000, 0,
          size.height * 0.9935233, 0, size.height * 0.9857513)
      ..cubicTo(
          0,
          size.height * 0.9818653,
          size.width * 0.001490313,
          size.height * 0.9779793,
          size.width * 0.004470939,
          size.height * 0.9753886)
      ..cubicTo(
          size.width * 0.3070045,
          size.height * 0.8225389,
          size.width * 0.6229508,
          size.height * 0.6321244,
          size.width * 0.6229508,
          size.height * 0.3354922)
      ..cubicTo(
          size.width * 0.6229508,
          size.height * 0.1787565,
          size.width * 0.5275708,
          size.height * 0.02849741,
          size.width * 0.3636364,
          size.height * 0.02849741)
      ..cubicTo(
          size.width * 0.2459016,
          size.height * 0.02849741,
          size.width * 0.1579732,
          size.height * 0.1023316,
          size.width * 0.1192250,
          size.height * 0.2007772)
      ..cubicTo(
          size.width * 0.1400894,
          size.height * 0.1904145,
          size.width * 0.1609538,
          size.height * 0.1839378,
          size.width * 0.1833085,
          size.height * 0.1839378)
      ..cubicTo(
          size.width * 0.2652757,
          size.height * 0.1839378,
          size.width * 0.3323398,
          size.height * 0.2422280,
          size.width * 0.3323398,
          size.height * 0.3134715)
      ..cubicTo(
          size.width * 0.3323398,
          size.height * 0.3886010,
          size.width * 0.2667660,
          size.height * 0.4520725,
          size.width * 0.1833085,
          size.height * 0.4520725)
      ..cubicTo(
          size.width * 0.09388972,
          size.height * 0.4520725,
          size.width * 0.01639344,
          size.height * 0.3898964,
          size.width * 0.01639344,
          size.height * 0.3134715)
      ..cubicTo(size.width * 0.01639344, size.height * 0.1424870,
          size.width * 0.1698957, 0, size.width * 0.3636364, 0)
      ..close();
  }

  static Path blackHead(Size size) {
    return Path()
      ..moveTo(size.width * 0.9112494, size.height * 0.09733441)
      ..cubicTo(
          size.width * 0.8606517,
          size.height * 0.04402262,
          size.width * 0.7972818,
          size.height * 0.01878029,
          size.width * 0.7342394,
          size.height * 0.007067851)
      ..cubicTo(
          size.width * 0.4805960,
          size.height * -0.04058966,
          size.width * 0.1614541,
          size.height * 0.1583199,
          size.width * 0.04503029,
          size.height * 0.4408320)
      ..cubicTo(
          size.width * 0.02914688,
          size.height * 0.4796042,
          size.width * 0.01604716,
          size.height * 0.5216074,
          size.width * 0.008514819,
          size.height * 0.5638126)
      ..cubicTo(
          size.width * -0.02750942,
          size.height * 0.7683764,
          size.width * 0.05190765,
          size.height * 0.9271002,
          size.width * 0.2159817,
          size.height * 0.9812197)
      ..cubicTo(
          size.width * 0.2444736,
          size.height * 0.9907108,
          size.width * 0.2741117,
          size.height * 0.9985864,
          size.width * 0.3034223,
          size.height * 0.9995961)
      ..cubicTo(
          size.width * 0.5523170,
          size.height * 1.007472,
          size.width * 0.7533977,
          size.height * 0.8867124,
          size.width * 0.9078107,
          size.height * 0.6484249)
      ..cubicTo(
          size.width * 0.9729818,
          size.height * 0.5478595,
          size.width * 1.003439,
          size.height * 0.4295234,
          size.width * 0.9996725,
          size.height * 0.3002827)
      ..cubicTo(
          size.width * 0.9968888,
          size.height * 0.2102181,
          size.width * 0.9618471,
          size.height * 0.1504443,
          size.width * 0.9112494,
          size.height * 0.09713247)
      ..close();
  }

  static Path gClef(Size size) => Path()
    ..moveTo(size.width * 0.6747068, size.height * 0.0005099133)
    ..cubicTo(
        size.width * 0.7226982,
        size.height * 0.01427757,
        size.width * 0.7511436,
        size.height * 0.03203455,
        size.width * 0.7742660,
        size.height * 0.05105132)
    ..cubicTo(
        size.width * 0.8292439,
        size.height * 0.09631363,
        size.width * 0.8477086,
        size.height * 0.1436456,
        size.width * 0.8354820,
        size.height * 0.1941570)
    ..cubicTo(
        size.width * 0.8294103,
        size.height * 0.1984763,
        size.width * 0.8300757,
        size.height * 0.2020157,
        size.width * 0.8294935,
        size.height * 0.2066649)
    ..cubicTo(
        size.width * 0.7941446,
        size.height * 0.2728636,
        size.width * 0.7043167,
        size.height * 0.3273943,
        size.width * 0.5804708,
        size.height * 0.3751762)
    ..cubicTo(
        size.width * 0.5664144,
        size.height * 0.3805753,
        size.width * 0.5620893,
        size.height * 0.3857644,
        size.width * 0.5653331,
        size.height * 0.3927532)
    ..cubicTo(
        size.width * 0.5777260,
        size.height * 0.4195687,
        size.width * 0.5900358,
        size.height * 0.4463841,
        size.width * 0.6010147,
        size.height * 0.4732895)
    ..cubicTo(
        size.width * 0.6035099,
        size.height * 0.4793785,
        size.width * 0.6105797,
        size.height * 0.4816581,
        size.width * 0.6267986,
        size.height * 0.4819281)
    ..cubicTo(
        size.width * 0.6630625,
        size.height * 0.4824980,
        size.width * 0.6985777,
        size.height * 0.4845676,
        size.width * 0.7335108,
        size.height * 0.4883170)
    ..cubicTo(
        size.width * 0.9718040,
        size.height * 0.5138426,
        size.width * 1.048906,
        size.height * 0.6087165,
        size.width * 0.9702237,
        size.height * 0.6754252)
    ..cubicTo(
        size.width * 0.9290526,
        size.height * 0.7103092,
        size.width * 0.8622640,
        size.height * 0.7368547,
        size.width * 0.7655327,
        size.height * 0.7525421)
    ..cubicTo(
        size.width * 0.7304333,
        size.height * 0.7582411,
        size.width * 0.7328454,
        size.height * 0.7569813,
        size.width * 0.7390002,
        size.height * 0.7706590)
    ..cubicTo(
        size.width * 0.7533893,
        size.height * 0.8023036,
        size.width * 0.7702736,
        size.height * 0.8338282,
        size.width * 0.7788406,
        size.height * 0.8658028)
    ..cubicTo(
        size.width * 0.7849954,
        size.height * 0.8887789,
        size.width * 0.7819180,
        size.height * 0.9114850,
        size.width * 0.7641188,
        size.height * 0.9337113)
    ..cubicTo(
        size.width * 0.7422440,
        size.height * 0.9610366,
        size.width * 0.6959162,
        size.height * 0.9803233,
        size.width * 0.6208101,
        size.height * 0.9904616)
    ..cubicTo(
        size.width * 0.5325626,
        size.height * 1.002400,
        size.width * 0.4435665,
        size.height * 1.003359,
        size.width * 0.3549863,
        size.height * 0.9924113)
    ..cubicTo(
        size.width * 0.2312235,
        size.height * 0.9771439,
        size.width * 0.1659320,
        size.height * 0.9322115,
        size.width * 0.2029444,
        size.height * 0.8898587)
    ..cubicTo(
        size.width * 0.2300591,
        size.height * 0.8588140,
        size.width * 0.3010064,
        size.height * 0.8422568,
        size.width * 0.3944107,
        size.height * 0.8451963)
    ..cubicTo(
        size.width * 0.4750894,
        size.height * 0.8477459,
        size.width * 0.5384679,
        size.height * 0.8693722,
        size.width * 0.5491974,
        size.height * 0.8980473)
    ..cubicTo(
        size.width * 0.5610081,
        size.height * 0.9296620,
        size.width * 0.5171754,
        size.height * 0.9557275,
        size.width * 0.4327539,
        size.height * 0.9672756)
    ..cubicTo(
        size.width * 0.4233552,
        size.height * 0.9685653,
        size.width * 0.4138734,
        size.height * 0.9698251,
        size.width * 0.3961574,
        size.height * 0.9722247)
    ..cubicTo(
        size.width * 0.4767529,
        size.height * 0.9789136,
        size.width * 0.5459536,
        size.height * 0.9773538,
        size.width * 0.6111619,
        size.height * 0.9650559)
    ..cubicTo(
        size.width * 0.6688015,
        size.height * 0.9541978,
        size.width * 0.6970806,
        size.height * 0.9354210,
        size.width * 0.7102221,
        size.height * 0.9131048)
    ..cubicTo(
        size.width * 0.7242785,
        size.height * 0.8891688,
        size.width * 0.7157116,
        size.height * 0.8653229,
        size.width * 0.7068119,
        size.height * 0.8416269)
    ..cubicTo(
        size.width * 0.6987441,
        size.height * 0.8200906,
        size.width * 0.6863512,
        size.height * 0.7987942,
        size.width * 0.6754554,
        size.height * 0.7774078)
    ..cubicTo(
        size.width * 0.6683024,
        size.height * 0.7634002,
        size.width * 0.6679697,
        size.height * 0.7633402,
        size.width * 0.6307910,
        size.height * 0.7652899)
    ..cubicTo(
        size.width * 0.5426266,
        size.height * 0.7699091,
        size.width * 0.4554604,
        size.height * 0.7678995,
        size.width * 0.3717874,
        size.height * 0.7571013)
    ..cubicTo(
        size.width * 0.1767446,
        size.height * 0.7319656,
        size.width * 0.04749231,
        size.height * 0.6843037,
        size.width * 0.009232305,
        size.height * 0.6096764)
    ..cubicTo(
        size.width * -0.01688431,
        size.height * 0.5588650,
        size.width * 0.01364052,
        size.height * 0.5101533,
        size.width * 0.07876570,
        size.height * 0.4643511)
    ..cubicTo(
        size.width * 0.1332446,
        size.height * 0.4260476,
        size.width * 0.2116776,
        size.height * 0.3945529,
        size.width * 0.2974299,
        size.height * 0.3651579)
    ..cubicTo(
        size.width * 0.3433419,
        size.height * 0.3494106,
        size.width * 0.3892539,
        size.height * 0.3336333,
        size.width * 0.4356650,
        size.height * 0.3180659)
    ..cubicTo(
        size.width * 0.4502204,
        size.height * 0.3131768,
        size.width * 0.4541296,
        size.height * 0.3083476,
        size.width * 0.4510522,
        size.height * 0.3008489)
    ..cubicTo(
        size.width * 0.4344174,
        size.height * 0.2599658,
        size.width * 0.4161191,
        size.height * 0.2190228,
        size.width * 0.4211927,
        size.height * 0.1774798)
    ..cubicTo(
        size.width * 0.4257673,
        size.height * 0.1397762,
        size.width * 0.4416535,
        size.height * 0.1028225,
        size.width * 0.4829078,
        size.height * 0.06775848)
    ..cubicTo(
        size.width * 0.5123513,
        size.height * 0.04274273,
        size.width * 0.5533561,
        size.height * 0.02096644,
        size.width * 0.6189803,
        size.height * 0.004799184)
    ..cubicTo(
        size.width * 0.6371954,
        size.height * 0.002189628,
        size.width * 0.6529152,
        size.height * -0.001319776,
        size.width * 0.6746236,
        size.height * 0.0005099133)
    ..close()
    ..moveTo(size.width * 0.5624220, size.height * 0.5564054)
    ..cubicTo(
        size.width * 0.5007070,
        size.height * 0.5624044,
        size.width * 0.4561258,
        size.height * 0.5744623,
        size.width * 0.4268485,
        size.height * 0.5935091)
    ..cubicTo(
        size.width * 0.3868419,
        size.height * 0.6194847,
        size.width * 0.3934126,
        size.height * 0.6557785,
        size.width * 0.4770024,
        size.height * 0.6759051)
    ..cubicTo(
        size.width * 0.4895617,
        size.height * 0.6789346,
        size.width * 0.5019546,
        size.height * 0.6819941,
        size.width * 0.5142643,
        size.height * 0.6851435)
    ..cubicTo(
        size.width * 0.5242452,
        size.height * 0.6876931,
        size.width * 0.5353905,
        size.height * 0.6905126,
        size.width * 0.5300674,
        size.height * 0.6956417)
    ..cubicTo(
        size.width * 0.5242452,
        size.height * 0.7012808,
        size.width * 0.5096898,
        size.height * 0.7014308,
        size.width * 0.4957997,
        size.height * 0.7008609)
    ..cubicTo(
        size.width * 0.4636946,
        size.height * 0.6995711,
        size.width * 0.4334193,
        size.height * 0.6960617,
        size.width * 0.4083839,
        size.height * 0.6886529)
    ..cubicTo(
        size.width * 0.3267903,
        size.height * 0.6645070,
        size.width * 0.2862014,
        size.height * 0.6331324,
        size.width * 0.2985944,
        size.height * 0.5953388)
    ..cubicTo(
        size.width * 0.3147301,
        size.height * 0.5460272,
        size.width * 0.3826000,
        size.height * 0.5087135,
        size.width * 0.5126008,
        size.height * 0.4885569)
    ..cubicTo(
        size.width * 0.5304001,
        size.height * 0.4857974,
        size.width * 0.5334775,
        size.height * 0.4822880,
        size.width * 0.5304001,
        size.height * 0.4761091)
    ..cubicTo(
        size.width * 0.5232471,
        size.height * 0.4616815,
        size.width * 0.5175081,
        size.height * 0.4471340,
        size.width * 0.5109374,
        size.height * 0.4326465)
    ..cubicTo(
        size.width * 0.5071945,
        size.height * 0.4244878,
        size.width * 0.5029527,
        size.height * 0.4163592,
        size.width * 0.4979622,
        size.height * 0.4061010)
    ..cubicTo(
        size.width * 0.4497214,
        size.height * 0.4219983,
        size.width * 0.4063878,
        size.height * 0.4354660,
        size.width * 0.3657157,
        size.height * 0.4499235)
    ..cubicTo(
        size.width * 0.2799634,
        size.height * 0.4804283,
        size.width * 0.2090992,
        size.height * 0.5145925,
        size.width * 0.1728354,
        size.height * 0.5567953)
    ..cubicTo(
        size.width * 0.1214339,
        size.height * 0.6167552,
        size.width * 0.1687599,
        size.height * 0.6764450,
        size.width * 0.2990102,
        size.height * 0.7122589)
    ..cubicTo(
        size.width * 0.3973218,
        size.height * 0.7393143,
        size.width * 0.5093571,
        size.height * 0.7486427,
        size.width * 0.6317059,
        size.height * 0.7423138)
    ..cubicTo(
        size.width * 0.6507527,
        size.height * 0.7413240,
        size.width * 0.6563254,
        size.height * 0.7389844,
        size.width * 0.6524994,
        size.height * 0.7317556)
    ..cubicTo(
        size.width * 0.6321218,
        size.height * 0.6927922,
        size.width * 0.6134076,
        size.height * 0.6537089,
        size.width * 0.5935291,
        size.height * 0.6132457)
    ..cubicTo(
        size.width * 0.5822174,
        size.height * 0.5935691,
        size.width * 0.5794727,
        size.height * 0.5746723,
        size.width * 0.5624220,
        size.height * 0.5564054)
    ..close()
    ..moveTo(size.width * 0.5702404, size.height * 0.1177900)
    ..cubicTo(
        size.width * 0.5029527,
        size.height * 0.1591529,
        size.width * 0.4938867,
        size.height * 0.2041753,
        size.width * 0.5064460,
        size.height * 0.2503974)
    ..cubicTo(
        size.width * 0.5095234,
        size.height * 0.2617355,
        size.width * 0.5079431,
        size.height * 0.2737035,
        size.width * 0.5228312,
        size.height * 0.2863013)
    ..cubicTo(
        size.width * 0.5936122,
        size.height * 0.2611956,
        size.width * 0.6586542,
        size.height * 0.2371997,
        size.width * 0.7032355,
        size.height * 0.2070548)
    ..cubicTo(
        size.width * 0.7527239,
        size.height * 0.1735805,
        size.width * 0.7594610,
        size.height * 0.1386664,
        size.width * 0.7281045,
        size.height * 0.1028225)
    ..cubicTo(
        size.width * 0.7059802,
        size.height * 0.07756681,
        size.width * 0.6845213,
        size.height * 0.07540718,
        size.width * 0.6231390,
        size.height * 0.09202436)
    ..cubicTo(
        size.width * 0.6003493,
        size.height * 0.1002130,
        size.width * 0.5847958,
        size.height * 0.1088215,
        size.width * 0.5702404,
        size.height * 0.1177900)
    ..close()
    ..moveTo(size.width * 0.6688015, size.height * 0.5530160)
    ..cubicTo(
        size.width * 0.6373617,
        size.height * 0.5515462,
        size.width * 0.6356151,
        size.height * 0.5522061,
        size.width * 0.6411877,
        size.height * 0.5641441)
    ..cubicTo(
        size.width * 0.6556600,
        size.height * 0.5951588,
        size.width * 0.6698827,
        size.height * 0.6261736,
        size.width * 0.6846877,
        size.height * 0.6571583)
    ..cubicTo(
        size.width * 0.6965816,
        size.height * 0.6821140,
        size.width * 0.7092240,
        size.height * 0.7070098,
        size.width * 0.7222823,
        size.height * 0.7334353)
    ..cubicTo(
        size.width * 0.7757631,
        size.height * 0.7259666,
        size.width * 0.8112784,
        size.height * 0.7134287,
        size.width * 0.8369791,
        size.height * 0.6969915)
    ..cubicTo(
        size.width * 0.8714131,
        size.height * 0.6750052,
        size.width * 0.8813940,
        size.height * 0.6511593,
        size.width * 0.8751560,
        size.height * 0.6247638)
    ..cubicTo(
        size.width * 0.8547783,
        size.height * 0.5828909,
        size.width * 0.7829993,
        size.height * 0.5583551,
        size.width * 0.6688015,
        size.height * 0.5529560)
    ..close();

  static Path singleTail(Size size) => Path()
    ..moveTo(size.width * 0.0001842978, size.height * 0.3227820)
    ..cubicTo(0, size.height * 0.2301358, 0, size.height * 0.1374895, 0,
        size.height * 0.04484334)
    ..cubicTo(
        0,
        size.height * 0.03435630,
        size.width * -0.0003685957,
        size.height * 0.02380493,
        size.width * 0.003317361,
        size.height * 0.01344657)
    ..cubicTo(
        size.width * 0.006081828,
        size.height * 0.006047739,
        size.width * 0.02230004,
        size.height * 0.0009007270,
        size.width * 0.04386288,
        size.height * 0.00006433764)
    ..cubicTo(
        size.width * 0.06690011,
        size.height * -0.0008363894,
        size.width * 0.08109104,
        size.height * 0.004503635,
        size.width * 0.08938445,
        size.height * 0.01132343)
    ..cubicTo(
        size.width * 0.09454478,
        size.height * 0.01556971,
        size.width * 0.09675636,
        size.height * 0.02026636,
        size.width * 0.09988942,
        size.height * 0.02476999)
    ..cubicTo(
        size.width * 0.1426465,
        size.height * 0.08531172,
        size.width * 0.2161813,
        size.height * 0.1412211,
        size.width * 0.3133063,
        size.height * 0.1963585)
    ..cubicTo(
        size.width * 0.4389974,
        size.height * 0.2570289,
        size.width * 0.5600811,
        size.height * 0.3157692,
        size.width * 0.6824548,
        size.height * 0.3741234)
    ..cubicTo(
        size.width * 0.8429783,
        size.height * 0.4506209,
        size.width * 0.9616661,
        size.height * 0.5338738,
        size.width * 0.9900479,
        size.height * 0.6290291)
    ..cubicTo(
        size.width * 1.027092,
        size.height * 0.7527504,
        size.width * 0.9590859,
        size.height * 0.8704240,
        size.width * 0.7959823,
        size.height * 0.9812134)
    ..cubicTo(
        size.width * 0.7899005,
        size.height * 0.9853310,
        size.width * 0.7823443,
        size.height * 0.9892556,
        size.width * 0.7736823,
        size.height * 0.9927298)
    ..cubicTo(
        size.width * 0.7598599,
        size.height * 0.9983916,
        size.width * 0.7421673,
        size.height * 1.001801,
        size.width * 0.7206045,
        size.height * 0.9989063)
    ..cubicTo(
        size.width * 0.6968301,
        size.height * 0.9957537,
        size.width * 0.6959086,
        size.height * 0.9880332,
        size.width * 0.7003317,
        size.height * 0.9813421)
    ..cubicTo(
        size.width * 0.7077036,
        size.height * 0.9700187,
        size.width * 0.7185772,
        size.height * 0.9589526,
        size.width * 0.7294508,
        size.height * 0.9479508)
    ..cubicTo(
        size.width * 0.8112790,
        size.height * 0.8659203,
        size.width * 0.8673056,
        size.height * 0.7822814,
        size.width * 0.8615923,
        size.height * 0.6947179)
    ..cubicTo(
        size.width * 0.8591965,
        size.height * 0.6594609,
        size.width * 0.8453741,
        size.height * 0.6246542,
        size.width * 0.8063030,
        size.height * 0.5920993)
    ..cubicTo(
        size.width * 0.6732400,
        size.height * 0.4817603,
        size.width * 0.4710652,
        size.height * 0.3910442,
        size.width * 0.1785846,
        size.height * 0.3265135)
    ..cubicTo(
        size.width * 0.1616292,
        size.height * 0.3227820,
        size.width * 0.1439366,
        size.height * 0.3195007,
        size.width * 0.1260597,
        size.height * 0.3163482)
    ..cubicTo(
        size.width * 0.1205308,
        size.height * 0.3153831,
        size.width * 0.1135275,
        size.height * 0.3155118,
        size.width * 0.1056027,
        size.height * 0.3151258)
    ..cubicTo(
        size.width * 0.09270181,
        size.height * 0.3175706,
        size.width * 0.08864725,
        size.height * 0.3211092,
        size.width * 0.08791006,
        size.height * 0.3249051);
}
