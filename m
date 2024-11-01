Return-Path: <linux-hyperv+bounces-3232-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D042E9B88AC
	for <lists+linux-hyperv@lfdr.de>; Fri,  1 Nov 2024 02:39:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2AD81C21F82
	for <lists+linux-hyperv@lfdr.de>; Fri,  1 Nov 2024 01:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87AD81741;
	Fri,  1 Nov 2024 01:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="CTCh3qgW"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azolkn19011035.outbound.protection.outlook.com [52.103.12.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C6D73451;
	Fri,  1 Nov 2024 01:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.12.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730425124; cv=fail; b=hDL4wbGnSUj+/w7AT9tCGenD/QgX+xx/F7ObVrguP5zDaeGR4Ew0RNgtA54dj96kbU8VWLpLbb/YH4NBpo8d/l+ICOx1PkE0w+9vx0IO15/ldHMcodeYa5jeJ4FMml8w5kOmatqVWWT6MMKZRi9HfhtAL2++dC6CvwZj9eeANrc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730425124; c=relaxed/simple;
	bh=GQuGhAowCGbxZwD0MLbTqQYKLxrJl966HHk429KDVhM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WGabQqcSRV2Gt+9nABcK7DJhxYB6/j02hHDEdFZSYhZoCZC0hh7law1qE6w4FHC21SsWGlDGVxzEzQr7155r9mLNe4gLyYAa8CyfCAZKoJ855qO9p6+fug5ONQyfFfQJjq9gmkAFcc0NvVJhu7KihrCO40zwSY9UClExiiOBiKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=CTCh3qgW; arc=fail smtp.client-ip=52.103.12.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mn2M1K/rvxW4d3t/BZ5QJ827KoghBQkBiGFG50TBHdRSYWd4N9tmfBJpEtlZSEo59yccTAYJEWbjZEQn57A8doXpEdoo0x9sKj+c7DKJmMUnUO+W5SYa5kzDgW/v0U/Y9sW7JZpdGsWw7jQnFB+Af1EKswsNUsfOvHs9VhvgKEiI3qgE37PRmdiCB3b5fPphM6ama5KnheoMak3lEOAecORHWybno47In9vXW5/jz5njTieEuHePSKGeVvXt6DWnaoyoNqq5gkltJBsCRMc4SX6wAU7jSpzrRppQVyASAeSV9PMA6Lq4r3J1lTuOL0T5mbDHl2H1t/HAJaj5jw2Aiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GVBjdjXqjzhpUI3aofa6BFj+CQ50QYIO7B/f2k0yDCg=;
 b=MG6F3jLm6AuRyjoq4E2UG7K5+D1cfQwB5TlZWGpQ5H9amvozIJHZUxSDJxKbjJD9zF3TcuFNJeC6toO5r6IQ9pTgTMDe/IQjvaGRQpiokB+2wSipnJw//WAO48Dd1Lc/uJORS+l+Wr7h8gq2Eu1JdVjPq1Q4zOeERlmdazN7IiKueEKTJCAlcBp7tE24/5Oe+L/uCFopTyhDkLpn80PgLc9UX/zwe4CJ6c8zPyUNibqMSsZ8kJj6UrmlK7fLH4Uelcthb080AZlyan2ctE5gLUbI2cL+Ol9oLLBZGPJapqtXbGY/gTm2zqry/DxX5m/aSQJ/Y/uW8xwP++/6gzEJcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GVBjdjXqjzhpUI3aofa6BFj+CQ50QYIO7B/f2k0yDCg=;
 b=CTCh3qgWzFzLDP/JIYDFg+fQuvIU2MstyvXLOZeUYLzwrYFRkDjpXAKJdgtiCEjgTv7B8rftJCkJhqXvC5AiSkKeEqlNDe/NJ72AYRJpv5cyTf34Ihz3Tc5N1JUfpC+xoeaQe1ZrrDBBauX4cup8p79hix78qu6u5iQUWv/gJah6IijtWCNmy0BDHupuYaxKccVxbPCQTwdKjHJxP9sGeNZSW1zO8dTeoDGuykh6aLdN/5O8Xxc7q00iXc17ddG3JT+FyqLVhrjtZEfZ3z/18wlfdDt63a1OpqwufmNb9Kf1Tqat64BjPDjWai9n+mWsPEKRdjbLiKVQBCkr7MWzZw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SJ2PR02MB9896.namprd02.prod.outlook.com (2603:10b6:a03:547::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Fri, 1 Nov
 2024 01:38:34 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8114.015; Fri, 1 Nov 2024
 01:38:33 +0000
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
Thread-Index: AQHbAxLFR0Ovyi2Whk6CD70yxEN1m7KerxPQgAFHmYCAAFK20IABlxyAgAATwVA=
Date: Fri, 1 Nov 2024 01:38:33 +0000
Message-ID:
 <SN6PR02MB4157D9B44F3B94E17993BB6DD4562@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240909164719.41000-1-decui@microsoft.com>
 <SN6PR02MB4157630C523459A75C83C498D44B2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <SA1PR21MB131794D6AF620CB201958EFCBF542@SA1PR21MB1317.namprd21.prod.outlook.com>
 <SN6PR02MB4157CDB89A61BA857E6FC0BFD4552@SN6PR02MB4157.namprd02.prod.outlook.com>
 <SA1PR21MB1317A021B6C5D552B38C4368BF562@SA1PR21MB1317.namprd21.prod.outlook.com>
In-Reply-To:
 <SA1PR21MB1317A021B6C5D552B38C4368BF562@SA1PR21MB1317.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=f2ddb8d8-b0cc-4ed7-8c4d-806213566d4b;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-10-30T18:35:53Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SJ2PR02MB9896:EE_
x-ms-office365-filtering-correlation-id: 9cdf6e4b-803d-425a-b748-08dcfa15e5e6
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599003|461199028|8060799006|19110799003|15080799006|3412199025|440099028|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?GLfoxqk+TXHBX7Kuo7qEJ9QZb6qywcw9x5ERMg/vn7gdIJEGB1cTDzcNokxh?=
 =?us-ascii?Q?EsZbkunyaRqvnn0/2uhZerZgan+D+jRzRwWuDVyI6nLJnCmN/B/1/dr2xkEn?=
 =?us-ascii?Q?ZFKS0U8Q8iKbQ1uMNGvU+6uQ3CeaEuZU+xuHZAivwdrz7rSKIycYJ8Bq8yVD?=
 =?us-ascii?Q?4WVTLPIs08lAVYRdI+I9cOsJM7GlQQYCmhf29Z/5jdmlFacytBPoIexY9p6u?=
 =?us-ascii?Q?ldNJPJPVRkwiAodOsUZGLFnwWBx5jfpGvbcCXim7pn+XiaZS4Fv3jm1pABta?=
 =?us-ascii?Q?wag5oxk8pJsoTRV8+MUiHjHzmzHS4fxapXqL/ANlDxzNBsh5XiLnjRtmGZoD?=
 =?us-ascii?Q?+enjilEe/YIm0VyuoImJa0lPl9au9twioFPNPc/B3wT0TZqNEySjjFJq71tR?=
 =?us-ascii?Q?YdYnpuCU3FGFu5HdLlv6GlAMOgpwK6+iEmm/WnsCzzS5TN1wVh/UNbh7rZe/?=
 =?us-ascii?Q?Widqqg1IWj0ZREl6D5zN+vCWZ+w2D5DHoXLhE9wTOXtEf79AEe13Qr1kIwq0?=
 =?us-ascii?Q?1yIhzfm7Lcqo4Koul5r+kqLxeScuvESs5utIb3aKnNDvBLG0qmuovGX+/ZtI?=
 =?us-ascii?Q?EAAq6RN2HF9jfEw1kzUnCyVevyRBw29VsB5L4V9WG8+kRLiCXoIsIA6R5sJN?=
 =?us-ascii?Q?YDITmI4n5lV8lWvA+MqBK7M4FBcUTTnGJfoukDyFUoc+T404gd/6WdEWrRHG?=
 =?us-ascii?Q?SZlTrcGkfaCrI+g0NNjgvef2mkSiwfKZbJjJpcApYI2+o1RuB7Rc9badpNEy?=
 =?us-ascii?Q?jc15DT8C8TbI97JbtJgv7LMLYSR8EzKPyWJby2bNvsJYmMxnPW4dNbnmvsR/?=
 =?us-ascii?Q?GSDK4ywcL24BnC9/DXoKlg1Ght/8HL0kF7lcTQJHUMCnIV2Uh6VWFEF5wxlr?=
 =?us-ascii?Q?itPGWK5PJojSJMwGPEq3t1zcSn5PSt3Ta+H3UaH3kaIBFCFDUjObh5DDDdG8?=
 =?us-ascii?Q?FyzkyFGnC4oKzkpFXlSfajkOrq7CWzb22ROkN3rxfQx3FUV0GkUdw0sZqAr3?=
 =?us-ascii?Q?5hWyN5zlCJySzwuCVners/cFdA=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?luw1le9VFZA7sCrqlqZ0CHNJ8pQuneui7dZfC+ljqJuh0hqNWfceS8z5S7SE?=
 =?us-ascii?Q?5dco0UDVYjlgWFW4X0AT0wGms1GQ+pT3PQMxXoBrbolWBeFZnj2dx/vqbGTJ?=
 =?us-ascii?Q?A8HBaiWv3Wtz/QnrCeUqan6o7L8ahk3bovBjX4/nMVARxl6ky3KSNB4NegmE?=
 =?us-ascii?Q?2Q4s9nsXmYGLjLu9+6X2pKU+PKRXBeoloZJUTSQUTdRRmHWv6D4qEbECzSBc?=
 =?us-ascii?Q?G9aXHeOhAm2f0GXfRN9Avd6XYjwJrtJUIETktpvAtKi0lEjnhJLH7UfywAh8?=
 =?us-ascii?Q?ZVtRrzqdpZRZvb9nyI17abxzw2/NSHNtUw0Eo5YM9Mmpvp+pEst8bvnwaKKV?=
 =?us-ascii?Q?OOlxF2YfoPOYqNWXSb+q3PtEB1om9BGyy+k5AaT2GMm4eaPJdQBQM+F2qofv?=
 =?us-ascii?Q?Cbevr37px8GhZ1nfnNxH9dvvleZzBR6cmT9D1D8y/t/rJsWtuKp3Zh32nS9B?=
 =?us-ascii?Q?k1AfNUKsMgo2XOzgAo4cdqRJxQRkQ1B6Gp26+s4SzxsNOvA+iUhQV5pNeFjr?=
 =?us-ascii?Q?Po/Nu8THm0eKyegy+QPPcCseSMxOSczqvnQjmw6ABb0dWTgVQqBYusv6kQcX?=
 =?us-ascii?Q?KErBvu6QnrOwXx8HssFIfnn89wMlpcZnDX7q0PYlMiHhhHuC8nG2Uu0H2fpU?=
 =?us-ascii?Q?17aPJ2uk/305zb4iK8jmr8k0N6f+fC4u00ShjxGWdYCGiV6RQ59SI+oJmPY+?=
 =?us-ascii?Q?mN0o8MLsXCv9iXujVQsTy/QrfT2Tl04Y8qlr2cubbmAxgkv4YrTnKzlHMl3S?=
 =?us-ascii?Q?2An4dKBuPOLLBbKyfWMIyuW5itWdvIr8AN4fnsVmN9rfsGNebsDlUzgtT4Vy?=
 =?us-ascii?Q?iSjwSaO3U12IF7tvuHT7SQVBx1CaLV8bGPxqYTprYZJDHfddqnkxrHZfMhFF?=
 =?us-ascii?Q?rP/WGnrJVyQ5+LkGGQzFgeSZ4d6VPbdlzjhFh/acyv19df+eA/co0dP7tex1?=
 =?us-ascii?Q?ppuCgBQF8jISxuioVCUnwSq7fSPc+1vKKL4FZPYBHbPYJnDBa87e7Q40gLeb?=
 =?us-ascii?Q?E89FQgzLhGW7QAvSUjU+4zasQzvEtBbJ/9aSzvp9MJR70ECFD1IcwCjlCmTl?=
 =?us-ascii?Q?kt0JlLz7ylI11LUTcZo5vJV8QDeh4JVAs0cgUwDDOZskpp77ilR2fLId9/fv?=
 =?us-ascii?Q?gIaX8cKO2Roibe1wZOglwCS8HWeAyAo34aPhy5uJX8W7aRNjGZLE9NPaDxs1?=
 =?us-ascii?Q?gvN16amtamhV0VWmUozPKwMI9mMASBj7Iogjzenj2AL+rNq4iHTNYd5xuDY?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cdf6e4b-803d-425a-b748-08dcfa15e5e6
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2024 01:38:33.7878
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR02MB9896

From: Dexuan Cui <decui@microsoft.com> Sent: Thursday, October 31, 2024 5:1=
7 PM
>=20
> > From: Michael Kelley <mhklinux@outlook.com>
> > Sent: Wednesday, October 30, 2024 5:12 PM
> > [...]
> > What do you think about this (compile tested only), which splits the
> > "init" function into two parts for devices that have char devs? I'm
> > trying to avoid adding yet another synchronization point by just
> > doing the init operations in the right order -- i.e., don't create the
> > user space /dev entry until the VMBus channel is ready.
> >
> > Michael
>=20
> Thanks, I think this works! This is a better fix.
>=20
> > +	if (srv->util_init_transport) {
> > +		ret =3D srv->util_init_transport();
> > +		if (ret) {
> > +			ret =3D -ENODEV;
> IMO we don't need the line above, since the 'ret' from
> srv->util_init_transport()  is already a standard error code.

I was just now looking at call_driver_probe(), and it behaves
slightly differently for ENODEV and ENXIO vs. other error
codes. ENODEV and ENXIO don't output a message to the
console unless debugging is enabled, while other error codes
always output a message to the console. Forcing the error to
ENODEV has been there since the util_probe() code came out
of staging in year 2011. But I don't really have a preference
either way.

>=20
> BTW, I noticed that the line "ret =3D -ENODEV;"
>         if (srv->util_init) {
>                 ret =3D srv->util_init(srv);
>                 if (ret) {
>                         ret =3D -ENODEV;
>                         goto error1;
>                 }
>         }
> I think we don't really need that line, either.
> The existing 4 .util_init callbacks also already return a
> standard error code. We can make a separate patch to clean
> that up.

Same here.

Michael

