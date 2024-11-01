Return-Path: <linux-hyperv+bounces-3234-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F529B99E5
	for <lists+linux-hyperv@lfdr.de>; Fri,  1 Nov 2024 22:11:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F39A1F21AF7
	for <lists+linux-hyperv@lfdr.de>; Fri,  1 Nov 2024 21:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 898391A2643;
	Fri,  1 Nov 2024 21:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="LIdNM8u5"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazolkn19011034.outbound.protection.outlook.com [52.103.14.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE55C1581F8;
	Fri,  1 Nov 2024 21:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.14.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730495464; cv=fail; b=nV009UmIJHHIidUmOPiQyd6L/sxJNlVlzHt5J0Ho240mJRBVtMJuWjvkhRYpDeSNWcFkAm8MgxEVNn5fyUJhQGuKQZyI+P4w2z3eI5v0wBXWldTrBTH8nvB0sncBmkyfO3cs6k6MbbVDivX9+cFX7Y1ICTxQE4WJ0WyHntv87NU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730495464; c=relaxed/simple;
	bh=woUxSv7I3SsO8lYDWUYDSLsOsmM6zMqHRySqgGzd894=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fYyrdqmcjVBB16hOZ6sSEBCyeaA+EwyspOzPRReY5MynCo3I8kJZ1akXh/Q6jgjRz9twZbNMeeX0RCirT40Hc1IojPidxpjZqrQRuQlhF+Nze64+D2wYpAcDbn0VwAvBLOKRluTajFPbLnipjjtA4O4Fb2AckfL930TSyb9aPtc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=LIdNM8u5; arc=fail smtp.client-ip=52.103.14.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NnvhxRWp6QbHloko2ZBTkITJh8f8zw2Zqijj1Hwipx15YNuKopK4DfIJTfBecTcnjMaRs2SHHpjiq7YjFGU9w713dpXr+fM+VWzFEGEiVHcfPBYnjth+zEQNuZnCSf2/5yJTJ7+x/9BBoCoBwxQ1uN4u7YBX69ZtXRaxIJYZTjlYE0T7K4e/s/88UBmUgN+/wHgmoz0xxRuf/FUyiqdYW6skRDxqiDdovdJWMWre2nXoymj7c5GaZvob2OeyiHUJBKa0JoFuu/iyz8mIPQU6fPg5+S5m2rOkcAAuq7a0P0P6Z4Pqzak4p7q+Mp59Evl50XrxzAN7VyL4+xVmDba7Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=12UdhKKr03t3j2AvC8E80IoXaxQ8Qe7z5ai+zzHFUaY=;
 b=ciR6Qio9breCtWAm/4KKIShy07Jnz2R8+hDRinfzq55FEuo8g3ge0vpiplwxS9SLUxItosqM5uRSXIW7G+API/eqbXiBLOgPTUeQOMvjB3aQfDofCA8aWnCS1iAmnr5blqtzB0H2pQfZzq7DEQiB+H9Ohcn/7OutlvZsWM+DAbYGOtdKdL9d0lVNqJ1rp9ezS6ebYSW4WrQ2wzNJXAV+fOCHHaw9zhbGwUEptWvKRHSi0rXt1KIL0viNCzNpYK3Xt4Vth/LnSUJtHiQzXXQm+tcQDuUmlUuIUJc9gL7qpcfwohyJfOWlzCCG32AVJWkEKmrRBUvhYwH02nOD8X4DQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=12UdhKKr03t3j2AvC8E80IoXaxQ8Qe7z5ai+zzHFUaY=;
 b=LIdNM8u5ArSS+BSyBilnx8twJ/8EtVhBXSHf1GWR7cC4Dog96q00iLGkdIIN/VCdJfbk9QlodJfDFLJxVXw2PRCQPPb4MGuFeI+dNNxEDs8eSyOxm2y6+pqHtSQ04zLjohQJoRg/eh6Fo0Z/w4L5jwhRSWsnf9USAT4VJA3vxxc+mPpfU52KibhQtMTrrm1Ub8UyeizlRugYbF6I0BAhJ4dBrfpIDBYTbNC9bAOAneJAjvAJhEdh7VJXvuHX98njQVEZvtJAiM+hj04q1GR3xxD4DGHCSiQrAi0KD4nDMTg+I5IUqz9ULkmK0+oE14yMqcwOAVnDHtrF7cvFA3gBpA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SA3PR02MB10083.namprd02.prod.outlook.com (2603:10b6:806:3a0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Fri, 1 Nov
 2024 21:11:00 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8114.015; Fri, 1 Nov 2024
 21:11:00 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Dexuan Cui <decui@microsoft.com>, KY Srinivasan <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Vitaly
 Kuznetsov <vkuznets@redhat.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "open list:Hyper-V/Azure CORE AND DRIVERS"
	<linux-hyperv@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] Drivers: hv: kvp/vss: Avoid accessing a ringbuffer not
 initialized yet
Thread-Topic: [PATCH] Drivers: hv: kvp/vss: Avoid accessing a ringbuffer not
 initialized yet
Thread-Index:
 AQHbAxLFR0Ovyi2Whk6CD70yxEN1m7KerxPQgAFHmYCAAFK20IABlxyAgAATwVCAAT5NAIAAC46g
Date: Fri, 1 Nov 2024 21:11:00 +0000
Message-ID:
 <SN6PR02MB41570A66CB3660C803BB6063D4562@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240909164719.41000-1-decui@microsoft.com>
 <SN6PR02MB4157630C523459A75C83C498D44B2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <SA1PR21MB131794D6AF620CB201958EFCBF542@SA1PR21MB1317.namprd21.prod.outlook.com>
 <SN6PR02MB4157CDB89A61BA857E6FC0BFD4552@SN6PR02MB4157.namprd02.prod.outlook.com>
 <SA1PR21MB1317A021B6C5D552B38C4368BF562@SA1PR21MB1317.namprd21.prod.outlook.com>
 <SN6PR02MB4157D9B44F3B94E17993BB6DD4562@SN6PR02MB4157.namprd02.prod.outlook.com>
 <SA1PR21MB13170389BCF4A5A05FE359EDBF562@SA1PR21MB1317.namprd21.prod.outlook.com>
In-Reply-To:
 <SA1PR21MB13170389BCF4A5A05FE359EDBF562@SA1PR21MB1317.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=f2ddb8d8-b0cc-4ed7-8c4d-806213566d4b;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-10-30T18:35:53Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SA3PR02MB10083:EE_
x-ms-office365-filtering-correlation-id: cbcc57d9-d51e-41ac-ae52-08dcfab9af96
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|15080799006|8060799006|8062599003|19110799003|102099032|440099028|3412199025;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?SyCY65+8Z7xOd5Pd161EvrdWFqfgAD7TBw4RWIjnwD+zrp9nZ35hKWIJma4p?=
 =?us-ascii?Q?/6xrrLe3iWnUSJh1U2oxnWctaMjCZdYdHtLxl1ZTCWFgOApFlLbdL1SBSV3E?=
 =?us-ascii?Q?xcneclUAwtvsJpBDD68iQMTDyQOeaOBgqEh8s+3I7x2kqEEzert0ZiQKKweK?=
 =?us-ascii?Q?uHmVlkOm4dGtfHzzYwqbQvQ+c9oVJVUab+LyEjG3eM/ZPNxGGGv3yKkZiamf?=
 =?us-ascii?Q?Y/Z82UkkewP1qouNXfTjBozQombffbaVHk4ByNWIx1NgqY8c/a6IeWSc3zgO?=
 =?us-ascii?Q?8DnztfZ+DmJEZEfywxv+yQ/ZFkYj745kwq4qBBGz3PW0U/uA11DH32ESwMos?=
 =?us-ascii?Q?B0D6pTuuRYC2eESxsoTxbEKVhLplr5lSDpkfMQPuXbOFuHg2cP8qhjm03EbZ?=
 =?us-ascii?Q?kgxVRMLxT9sZEK6qC1K7iWHm0dXYJZwubX+ytQOIhvTKlILepdCjnULV5NNS?=
 =?us-ascii?Q?RjFXNLYbtoO0JwI9ifo8VSKUNU15rxu2JdP5MHG0vQSAdYvpjiVlgCYc1yO8?=
 =?us-ascii?Q?jbV82mVSezlgCFC9bE4bzri1mWNMdBea2laG9PcOAfOnmt0zZvyzEMtfqGfe?=
 =?us-ascii?Q?9aLXEz1v+9gxQprf2/beHHYj6qFI4isdUquBeuPJB4sCt6/VdLNIAPWMdN3x?=
 =?us-ascii?Q?bh+H4XsLuyntlxUyxFi++ciuOHcQxpUgWYNgL5msIkQ7qkI7Xlbq0Q+7x3/7?=
 =?us-ascii?Q?7I2Huq0TuYPZcKtMUfiMq6QITHGOiiEbIyuF6SJIqnrR0l0FXxrCkkRvEHbr?=
 =?us-ascii?Q?U6GV8wJXFEp/N5W6LWlKZgGd74vvDCdK1onRcoYyhsQ05hCbqlsZsfDFlqgK?=
 =?us-ascii?Q?Wd13oqHV+e095uedFMf6fnv0KYNfEfx/k9hu5FO0u3I3m1ucx4hBeo9xy/YY?=
 =?us-ascii?Q?1lkMGJP06brwF8eaxeOI4TZgL/a/KeWcqM4YCQTrEShhyBkxt3HoLg0lmUbW?=
 =?us-ascii?Q?0/hWm5O/FvUGTNscQT5PP9nzaTHS7R3mPr3QqCqdWuX8pxWuraHSWro++V7t?=
 =?us-ascii?Q?hKdB?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Av+iITcMNP/leDybrTCAuxRtCuoCKTPW85xsidc9mnIp/zN02d5SgDaDBk7t?=
 =?us-ascii?Q?WvxrPUds6Qx61rc4qX+6EHag3KmkrPHv0o8lsw8jVb0xxv9vaoBhmvyy8pEZ?=
 =?us-ascii?Q?pt7374nrxsTHN39HM65Dj0ca08Yj1l47RbVxyp8P7O9zJ5P7XJpuPhyqDTlZ?=
 =?us-ascii?Q?/pqIIlhpm6am6orLEM83FoUzD5TuXFQdbkvATjptdXppgR+uB0QH3mjeCAxL?=
 =?us-ascii?Q?ehx9KoM7fVVhu8wq2yPh8VOy86hCeumCq4iFhPyCVdVVOh0JlCApMiVVsgLB?=
 =?us-ascii?Q?p39nRmO7NWeaeXhZJO5jY34yuFBJU2Iv8DdMUcF/EpbIoq/kpNXAQ+ohDsff?=
 =?us-ascii?Q?WO21nDw9mtIzVTw4ZLIVdPAJhVAejXOh+L3GqwvMvST6ftQ2EYdrcULShHpu?=
 =?us-ascii?Q?Lv3pVViE69FSp9EkuTxkR//EGmAetcH/L3mZb8h/lTRdiswQwjmlit25EhWT?=
 =?us-ascii?Q?Tg1FuEcq/4tjuhhYgUESRbf7HS32tajGwKXj+xOF53Y2kUXo5m20EG7XPozK?=
 =?us-ascii?Q?0juupdsjZUbGdxqGHHY2bwT5NDa1GTu1d4x+IcA2N/QmEmm4+tBzQGvnnnwk?=
 =?us-ascii?Q?teh8qoC4/gw2TZOhvFNHba//30a3ARQCSXrtTynozGc835KxyUd0A4nCoywj?=
 =?us-ascii?Q?RMUZfv4D+qTMI3XB8cXRdp/u4+DJ5NCBLFh8VJWrXuoazvdGyRqkta8KKMEE?=
 =?us-ascii?Q?csfuFskCSNqGetfWzrHRCSA04dmTV5k1JTROYIZr8ftk+k23t4EX3Xvu4biF?=
 =?us-ascii?Q?ysaooWvWeQZqU/n0P0xBg6eRlTJ1eGaRs2ZJt7lac4aNznJNzosKw15saeNQ?=
 =?us-ascii?Q?JgmFpNgya0txT2kBe6y8KOZFZN3kwDCyGKbedrB/9ReIT+C6iuA5FgUNLZyH?=
 =?us-ascii?Q?0WykVJRYL13SPQh/wfgxxpm6v8yrHLCx9y0eIMCWDE9aqXjkvHV/0qRJOOke?=
 =?us-ascii?Q?0t1MVHvSF1iIErwbse8Q5j279yKOxAQfQYmrOS1lDNIXaTa/ktNH5vx43GsX?=
 =?us-ascii?Q?5e3Y+eDersmyc87wDvw+b+0T11QYp1VYI3uYHsh3shKHHvi1/p23DeEMoVex?=
 =?us-ascii?Q?pUFRn5in4Gt6B7exahpNUYYizvK22o3byGenO0T871fZBAUDmYphJLY7jbcI?=
 =?us-ascii?Q?q1KUonK6IYSdQWbGaZn+/JnNF4igkWEpP/p6hH9S5ApGt4w+EM/NaFJiw6XP?=
 =?us-ascii?Q?8V4oMmPOE9oY3ETJkPNfZ1qOTSOJg99eocBjdYB6jlfN7+dSbhTSRYbVbTA?=
 =?us-ascii?Q?=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4157.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: cbcc57d9-d51e-41ac-ae52-08dcfab9af96
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2024 21:11:00.1333
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR02MB10083

From: Dexuan Cui <decui@microsoft.com> Sent: Friday, November 1, 2024 1:27 =
PM
>=20
> > From: Michael Kelley <mhklinux@outlook.com>
> > Sent: Thursday, October 31, 2024 6:39 PM
> > > > From: Michael Kelley <mhklinux@outlook.com>
> > > > Sent: Wednesday, October 30, 2024 5:12 PM
> > > > [...]
> > > > What do you think about this (compile tested only), which splits th=
e
> > > > "init" function into two parts for devices that have char devs? I'm
> > > > trying to avoid adding yet another synchronization point by just
> > > > doing the init operations in the right order -- i.e., don't create =
the
> > > > user space /dev entry until the VMBus channel is ready.
> > > >
> > > > Michael
> > >
> > > Thanks, I think this works! This is a better fix.
>=20
> Michael, will you post a formal patch or want me to do it?
> Either works for me.

I can do it. You probably have more pressing issues to keep
you busy .... :-)

>=20
> > > > +	if (srv->util_init_transport) {
> > > > +		ret =3D srv->util_init_transport();
> > > > +		if (ret) {
> > > > +			ret =3D -ENODEV;
> > > IMO we don't need the line above, since the 'ret' from
> > > srv->util_init_transport()  is already a standard error code.
> >
> > I was just now looking at call_driver_probe(), and it behaves
> > slightly differently for ENODEV and ENXIO vs. other error
> > codes. ENODEV and ENXIO don't output a message to the
> > console unless debugging is enabled, while other error codes
> > always output a message to the console. Forcing the error to
> > ENODEV has been there since the util_probe() code came out
> > of staging in year 2011. But I don't really have a preference
> > either way.
>=20
> util_probe() is called by vmbus_probe(), which uses pr_err() to print
> the 'ret'. If the 'ret' is forced to ENODEV, the message in vmbus_probe()
> may be a little misleading since the real error code is hidden,
> especially when srv->util_init_transport() doesn't print any error
> message.
>=20
> vmbus_probe() is called by call_driver_probe. I guess originally
> KY wanted to use ENODEV to avoid the extra message for the util
> devices in call_driver_probe() in non-debugging mode, but the other
> VSC drivers don't follow this usage.
>=20
> util_probe() can return a non-ENODEV error code anyway, e.g.
> ENOMEM and whatever error code from vmbus_open(). IMO,
> srv->util_init and srv->util_init_transport should not be treated
> specially.
>=20
> IMO it's better to not add new code to force the 'ret' to
> ENODEV, and we'd want to clean up the existing use of ENODEV
> in util_probe().
>=20

Fair enough. I'll do it that way.

Michael

