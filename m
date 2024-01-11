Return-Path: <linux-hyperv+bounces-1416-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 219E282B0B1
	for <lists+linux-hyperv@lfdr.de>; Thu, 11 Jan 2024 15:35:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F4E21F22F72
	for <lists+linux-hyperv@lfdr.de>; Thu, 11 Jan 2024 14:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E465482C2;
	Thu, 11 Jan 2024 14:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="bpj4EKA4"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04olkn2013.outbound.protection.outlook.com [40.92.46.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A130935890;
	Thu, 11 Jan 2024 14:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R0chT+xtMyY5t5MraqoY8zg1fwLydaYUKFokbTPuMQelZ8odT39HIB4J/8lICwHDlZRThYpBmSfBqOiHRv5qu0nKdRJ5p7Xzsi0ChbgJWqgQ5t5uP0NvrC9YvFQH1tcgk2QzuwvPap4vl/l9oI2uc+WA607FMAQO06t9M/ZCifF1dmGpfgKelfapr0gd0BknmS5rfB0g+gWNTmxLuSsgWAQP9CnMDJoii6yjsztfB5z0w9IRQ18tMLKM86w1/4CkOUExAHWhjOLY3s0URp/tzDOwjFTsJh8PZPz8c/5JneSla9BDlrr86PpBYWmL5CWFalKEryPNjAwI9vSR07z8nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s/ub8nCHesBw1DG21k+Oc7mJ7bnjJx4UVtmqSOLPHZ0=;
 b=gd3c0DKRfRLDDvIoOqaRX3r4+pzrwk/+WOpE0ZijH0UaQi22qBtEN9wXXMu/SmctroTqnrCNr0zF8zX5kefEEoGT+p1z/4tb7YCpayuiXMJshn9KeeLTKANluBw59/iKJH2GMShT6nZ1ts1tH6JAcodCLX9emiVdeJiiNH+QEGwS1Eh2j485AhybIr1UYvuO+Lt0f+xuW7tgEQyOLsiBpPxJ38fZ6pmHg5PFNQmngm8/EcGTMR2h7ppGP30owlZnXoAGVvIWMZbyam1InVRrK9mUb2yIIAlb6VhsjDkCwb7fp0CCl7u0L7C07OK6okEFrKtBDIT6WAV7lHyVkTlvGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s/ub8nCHesBw1DG21k+Oc7mJ7bnjJx4UVtmqSOLPHZ0=;
 b=bpj4EKA4Nkv9a3TmvdrhKvPG+4sC/ZRmXP8AF97wHZt4KzD2Sk1iuDGRpaelzMhoaSVIM1Nzzr4v1ZZSjH/gcHBuuPQ9ZW5qGMUsVD08SEjSqTWl3BFUo1W2T9iB668Nz87BSg52yVUWI75jOuy2fh9m7B/o2zyUu3mZxb15eGBVM8pbHd0DTDQpWd0/biiE5oJNvGkOOPW1aqj94Vy8cv5iG94sbFN/oNBOzREEYWTgjKrfP2dPA2l5PTTV0VaVWdNEr9dA4MA+4ttxmB7ovVCUq00Ms+WSccmHFipDvo6Ss4LwH19Ehpwkdz4rF8hxUSDFFqvDRbLw4ct+4Djsdg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by DS7PR02MB9475.namprd02.prod.outlook.com (2603:10b6:8:e0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Thu, 11 Jan
 2024 14:35:18 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::3524:e4b3:632d:d8b2]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::3524:e4b3:632d:d8b2%4]) with mapi id 15.20.7181.015; Thu, 11 Jan 2024
 14:35:18 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: Markus Elfring <Markus.Elfring@web.de>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "kernel-janitors@vger.kernel.org"
	<kernel-janitors@vger.kernel.org>, Dexuan Cui <decui@microsoft.com>, Haiyang
 Zhang <haiyangz@microsoft.com>, "K. Y. Srinivasan" <kys@microsoft.com>, Wei
 Liu <wei.liu@kernel.org>, "cocci@inria.fr" <cocci@inria.fr>, LKML
	<linux-kernel@vger.kernel.org>
Subject: RE: Drivers: hv: vmbus: One function call less in
 create_gpadl_header() after error detection
Thread-Topic: Drivers: hv: vmbus: One function call less in
 create_gpadl_header() after error detection
Thread-Index: AQHaQ7PyvvrIb8tUYUye7rRKlkvVrLDTNj6ggAAqigCAADt1QIAAlVWAgAB9o+A=
Date: Thu, 11 Jan 2024 14:35:18 +0000
Message-ID:
 <SN6PR02MB41570E0E960C9D588B9EF96DD4682@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <6d97cafb-ad7c-41c1-9f20-41024bb18515@web.de>
 <SN6PR02MB4157AA51AD8AEBB24D0668B7D4692@SN6PR02MB4157.namprd02.prod.outlook.com>
 <82054a0a-72e5-45b2-8808-e411a9587406@web.de>
 <SN6PR02MB4157CA3901DD8D069C755C72D4692@SN6PR02MB4157.namprd02.prod.outlook.com>
 <d3c13efc-a1a3-4f19-b0b9-f8c02cc674d5@moroto.mountain>
 <SN6PR02MB415710A52835BC82B1FA1EAFD4692@SN6PR02MB4157.namprd02.prod.outlook.com>
 <4ba5ab3c-80ae-448f-9377-01087ec9e858@moroto.mountain>
In-Reply-To: <4ba5ab3c-80ae-448f-9377-01087ec9e858@moroto.mountain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [mxXJc2n0iS+lCwBV+getet8W9s+iM1dV]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|DS7PR02MB9475:EE_
x-ms-office365-filtering-correlation-id: bad24b10-0c51-4995-0566-08dc12b28887
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 SsREecwkMRZYyJMT94wrx1kIdKPWUzlmWGndPWqOrz7rw7s0TFAlZNG66oCoINwmUfjkYFAW1hOmijluomfGNQx0aLMQVd+lyFM/6bH4E0YVFyYMY8EDbIihF/QR/kaS4pimHEaSIe90Merek/JLOMXIOernzALr4fshKZVyf/rxXlDaTv7voIBMCoOJ5VI3Z8EXKvtphEeGG+Fa02DOt6Mwww0LCLNoAv0iYY2lxwar482azLW6KmkTLW98jI7P38Llh6Z6lsjunSRcyj2UmN7h4iYvLyd/2SiyemY10RsAGUpoeQWzqOvfFGYbkn4Ubxe5Pv1mj8uWbBA4XthGEfS2C0QXGpcOOiPDSRb65ha8it5bMALjc6+uqL5cv489bZdKgND8h2rBQbG0NCxiHOUogKXIq80iR+SlEZ6N++fQn2xdEBMLyUV7mARKmVpaI0GU19l7k+tLiMGNkfN7GFvFMQ01jmW/Va8uitm+eXqk0bzrTdDOnGyCnIsadu2xwd2QOMp0g1nqB2yU4XWfzT1N/th1YKgwfQML9qq7KsLT9jnWqmJ/3xPfMIvbRTyd
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?tqX3OrZANY+7JmoUEjtNnu/s4wbkKjpIBJoAXWwTocLRaCm3BFixvlnS8Vtk?=
 =?us-ascii?Q?LQl1906XuRJhxN8R0rfyzvaqT/eW6mmO6QvTsOteJws+SykD8JjGJkXQ8V6g?=
 =?us-ascii?Q?zt1UpplxdvPPVd82atV1E9GOqEbM3iZvf27QKV2U6g4JHa6f25RH4WKeikdj?=
 =?us-ascii?Q?Zj/+BFT878KqMgOyVHZjB6RAL+TtQWE9SMYkS7FYIKxBZRaIwEV+pl9qVrpW?=
 =?us-ascii?Q?TFVIXC0AEvBu+56AcTOvz09p4vbjeqXPABTA3T4MtuU4IdhvtTZEgz57ZnMP?=
 =?us-ascii?Q?ERufldgfGzaAT+0eFtwOYNc0sAmGR3kJM2s7JkL5XxPc0+oAGszMB2+c8cVU?=
 =?us-ascii?Q?jm4wHEA8T+h4h9oBgw2ZuZuA3GRQPXFm66IiRzSj8EcXFmi7TEP+MTJMXAjy?=
 =?us-ascii?Q?/+Q+YspmRpzw5/yVL3pivfviRtHKCjK2IDIDtLfw68SOZQ+oW7I/igrvoazw?=
 =?us-ascii?Q?eqNg+f3IBW5XYWAXEF7jyWFNiCrU1gpizSGLVnmMOvNrj1BB5BXb0cuXipQi?=
 =?us-ascii?Q?gECliG2sVitG8aZM7VZ2MiGA6F0KnfytsxHieM+EFIfW+j0BHnU5Vok4u71m?=
 =?us-ascii?Q?4ZCeRWOyTOdBFEH2XDRmgo1wK1K46cVFLg/Umz+k6spUu7slGT6jC5XwQorB?=
 =?us-ascii?Q?tJ0M/LlRl/SUYjar9U6zU+u3VKiZL9IVSvjGkmH9lfw+XePjbCr2GN8pU2E5?=
 =?us-ascii?Q?md7ZntDzumRP04I1u/+dn9DbctabcKYiF9sqC6uFZZSWC7Ls7Nip3joKjGYb?=
 =?us-ascii?Q?KtVC61wWNyL2mEjo3tD59uHu7cGw8bYJCae7E0vluxgxT8El04ONwMnpvxTK?=
 =?us-ascii?Q?NAy+ksH14R8ScrpieDby+d5bf+XEA7/Uk0xIdgz7unPjjbGsmZ0Nz3EcKmYc?=
 =?us-ascii?Q?FNqvfAhTZc4jV8rYnKwn9Sz3RAi1ng0Cqo1XJ4B/n1sspT1t/AKzPs6fjy82?=
 =?us-ascii?Q?NrUpFZJPQ7xmU52CGmDTGNZYmHzKx4A5odnOh4ynCIou7CwpdBEgCNSFz5C4?=
 =?us-ascii?Q?0YJO06MwedBVfxqhsZ2HfhSWguVG155pUzSxWL81YeZ3JcsauX1Ke4do354H?=
 =?us-ascii?Q?6HlUhDPBtaZsoTP128E2r1szbdpp255Owa7nEUIQwDh7Pg1B06BVkYQZw4Me?=
 =?us-ascii?Q?TwyK9R0EYvMF6kBt5sLSjInBpdp/CU0+yxK/GpHyxIIEQDnn1LQqVmyPXsnM?=
 =?us-ascii?Q?Uenz2eXVJlHwlrAGB4xBts4Ynojzc2bHrcHMYQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bad24b10-0c51-4995-0566-08dc12b28887
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2024 14:35:18.3518
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR02MB9475

From: Dan Carpenter <dan.carpenter@linaro.org> Sent: Wednesday, January 10,=
 2024 11:05 PM
>=20
> On Wed, Jan 10, 2024 at 10:17:17PM +0000, Michael Kelley wrote:
> > From: Dan Carpenter <dan.carpenter@linaro.org> Sent: Wednesday, January
> 10, 2024 10:38 AM
> > >
> > > The second half of the if statement is basically duplicated.  It does=
n't
> > > need to be treated as a special case.  We could do something like bel=
ow.
> > > I deliberately didn't delete the tabs.  Also I haven't tested it.
> >
> > Indeed!  I looked at the history, and this function has been
> > structured with the duplication since sometime in 2010, which
> > pre-dates my involvement by several years.  I don't know of
> > any reason why the duplication is needed, and agree it could
> > be eliminated.
> >
> > Assuming Markus is OK with my proposal on the handling of
> > memory allocation failures, a single patch could simplify this
> > function quite a bit.
> >
> > Dan -- do you want to create and submit the patch?  I'll test the
> > code on Hyper-V.  Or I can create, test, and submit the patch with
> > a "Suggested-by: Dan Carpenter".
>=20
> I messed up the if statement the first couple times I tried to think
> about it so I don't trust myself here.  Could you give me the
> Suggested-by tag?
>=20

Will do.

Michael

