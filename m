Return-Path: <linux-hyperv+bounces-3555-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 973B39FE024
	for <lists+linux-hyperv@lfdr.de>; Sun, 29 Dec 2024 19:02:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4601E1881B18
	for <lists+linux-hyperv@lfdr.de>; Sun, 29 Dec 2024 18:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2840E189BB3;
	Sun, 29 Dec 2024 18:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="YH6aVD6m"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazolkn19012060.outbound.protection.outlook.com [52.103.2.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CA02594B6;
	Sun, 29 Dec 2024 18:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.2.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735495360; cv=fail; b=myY+M8BOXp4zgjeQlmEX6y3g+G+1fCN3UVSdHWp9sPVSHHei2iiuVvbmM+FvZTo+SO9Dx5LmKpEr1h5hEfKn82m6dW1ZKjZRgmYmUF+T9YRLA+WwZMSwis4AETojoEeslVWvfN15PfxX5H/wp6PK3SOGgdFu5PRUXuZG38QIWEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735495360; c=relaxed/simple;
	bh=8i7xrBnwxFDO54sZcEWHizF2iY+sj2/Csq0wZZgVym4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KYRpS/BZ3nLRRiVNcdOwyVkLYXig+wpFTJOepYAKBmuaFrka+bNdlUAHjfc17TAq0JNAJT62J7iaDFVRnWSA70q3fBHRcIEGHaEbKKHf7wkqn6WtwGYeRYpNUO2NpWAHu1qpMYiwBStOjGK0SbajOQoGy6KNfWDjrMDrg5Jf9GU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=YH6aVD6m; arc=fail smtp.client-ip=52.103.2.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PeFxtwhC14tcAaKcyRz55TVMohfDgom4K1rP6DHM8x3x+AXpP2TSLOCXu8hn267BNgY7thupslNyKh1keSQDayjGWu4whX5BwUy9S5JYYk5hH1YkiY/9uLWC7gzvmVKIK/iptvp9yJOkVKYWHp2YqBAkFzFFbKSNZQyzQNVuxyUrMh9YCFns3zg4w08aBVzf2YKDSGF8aSP1ng6MHC9sG2zcVVi3z9E2+yr5R/ryGYmxAQXo+v+d5GjEYEojRUHq+9GT33SAxWIRtbdXCTI+XmJiX9wGS7mxwvKmQJGgHG0Yi30L0/mt5uUdY2wz56Nx5SVGVldRgbVgCjL6PCqe6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rYN8MPM7lg7m0V1+WGVBAqKOOx6FcrNb/x8+LGSEDUs=;
 b=NYmxLM4YKnpTAqIMliLzSX+igdDwX33M6SLduam8LaO5rt2TfqeUXq952Fpmd+o99z1lliaZ1QDZeGNPEhlZWlzDw//WfxlzVRAQEtkVS6fyXMn2DxiPLDPbz1rTe52DEkt0Pa43w0eKzxPHKwOAH5fpjTlESKHp5UwLiBhCscSqS+lxaL4ba3ziPwf4eNi71MIe6X6lasJPZ7CLr81HsBDKuXClK1/esXaFGMiKLrCwFDyrHux5xWy4AL5i90BKfx8q31nnteXUpYStYjpcPfKXTQsbcxVSdmNgg9DIIHK6af94ph2hUf6a/9BoShaHSoOgPfSDNF1oDooKsrithQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rYN8MPM7lg7m0V1+WGVBAqKOOx6FcrNb/x8+LGSEDUs=;
 b=YH6aVD6mBXpRv7358xnek+k9yuwC3n2NE0PhcmYo9kkhUYdev6osfjAtPwhzKGsLY1dYjZqoeqPOAqe5dqQRA4obVQ1Flz/ilzr79zvLLN57Z3dQbsetLcBE52Ir7daWdnmuxGgkHwZCilJ4vvYkHl1arObdssGd6064HuFf5NDYfqppaxgpcyaLFF4ox8fIMZ38qAB6eLIZGYII9Zoq8JXGkbmWyQNzGEhhnvI3A7PoNojpbznTKoiQQP9/0pc2I8cfsoKpI3cTeRxzZKwD0ukmMfSXM6dUO5r5ZCXkJCS0qENoKx9ijNTgWLivmHeCwmcxTgr/zdpwcdwUFS5Dmg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by MW4PR02MB7267.namprd02.prod.outlook.com (2603:10b6:303:7b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.19; Sun, 29 Dec
 2024 18:02:34 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%6]) with mapi id 15.20.8293.000; Sun, 29 Dec 2024
 18:02:34 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Sonia Sharma <sosha@linux.microsoft.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "sosha@microsoft.com" <sosha@microsoft.com>, "decui@microsoft.com"
	<decui@microsoft.com>, "ssengar@linux.microsoft.com"
	<ssengar@linux.microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH] Drivers: hv: Allow single instance of hv_util devices
Thread-Topic: [PATCH] Drivers: hv: Allow single instance of hv_util devices
Thread-Index: AQHbUzq2cRawx7B8V0aI4pf3U15rY7L78dZA
Date: Sun, 29 Dec 2024 18:02:34 +0000
Message-ID:
 <SN6PR02MB41579A7AA47BC6751F57EC72D4082@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <1734738938-21274-1-git-send-email-sosha@linux.microsoft.com>
In-Reply-To: <1734738938-21274-1-git-send-email-sosha@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|MW4PR02MB7267:EE_
x-ms-office365-filtering-correlation-id: a7ef126e-d62d-4167-48a0-08dd2832f8b7
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799006|8060799006|19110799003|461199028|8062599003|102099032|3412199025|440099028|56899033;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?JIsuWhfbBzRdXfD8LpYzt169ETFChuYlbvZUwhjN9GQAyUnHWmmy1+wnUf1c?=
 =?us-ascii?Q?iR6bIy+R3pFnpRT20ncO2yi2aQAbEzq78Qh9tZlenzetyFLMRuzA6DQ6LC/J?=
 =?us-ascii?Q?5XGrfRKjvx+/OIheB1rW7cjsHWiXIyHnnZqJYzLekTS/mkTu+cYez1HpxPzJ?=
 =?us-ascii?Q?H4cbG4Ph6jLPhyKSCGUhspvjcP+EvphN33X3kFFhnFsNEVXbzFz4gqDRTcoD?=
 =?us-ascii?Q?1LyzdR2zZwU5OgHjGxOiz7QSMlzfTzPMHfb7BcsGvH8T6VYRwTUgUffNAAao?=
 =?us-ascii?Q?drvZn3VPXiXwqbPS1l5+aO4tAV7+9HwD4KKhbMdsSDNr12uoHKgnUy7EWMUw?=
 =?us-ascii?Q?p0x6T5vYML0D7CT+XTpxz5Cu8QQbbq8P9V0NELBbOfdTPlkjOgr24pQf/KEf?=
 =?us-ascii?Q?Uq+wGp9tq3dDhu24YMXwlt8iVDaHjhGCx99UFZ8mkDGJU1VpCG8xKO786U3K?=
 =?us-ascii?Q?+kGlg4MfaPc4Fx5CD4YDPXdhzrXolRfcX0UnKSTjY7tMLbIi0hhiJagHI+ij?=
 =?us-ascii?Q?/kMCCkGk0VvTzmvdrekrXd1OcsgJZ+whVTG99Bpt7REjjo/aNZWAQyYtDU4i?=
 =?us-ascii?Q?LGdJCJYTXXCHeiJb5SRPpOVV0Q/Tn6+kwkABrHi9Gmqp1PbUf6OHrJLLv7Wg?=
 =?us-ascii?Q?YD6McI3Pd91bt5fKXBGp4CKlnxaYuznSkbFAKUSOri/oNei/t3erglrd5CQu?=
 =?us-ascii?Q?YayeXMY/CzTjzEzoiLzkTraAQKgrWa7sVlZjUn8TpdLaL09/eB2QzJj1A0Dt?=
 =?us-ascii?Q?NANJm/eT/vBfTzisx4kAokOk7ORV09NdYARDV6G26JtliGDUv7TmyZsQsPpl?=
 =?us-ascii?Q?nJpctIAArEb6awTjZCJn+NTySmIQgpXx3Zgs1ROnlPOudgldZhQxbmAjdd1f?=
 =?us-ascii?Q?6ZmD5ah04uLhNPjdiUihX6TDqWzPk5FkGASlT/ybKGcn7kr97j7hc0cOqrVP?=
 =?us-ascii?Q?KtTs+3F7JSyQihuacTikmw78cYKDQ3IYasv9ez4ajnE97KRY6Wj6qEncjCYJ?=
 =?us-ascii?Q?XfnLK6V//EpZ6mA2bDOVGqlOOW0MQUssJ7vWac6gluowqYY=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?gFGuSJ6lpBF03HGqkT30ogj4jPm6Iu7Mxo6yOE2gYbm95IaoW4co/+Kb7ePL?=
 =?us-ascii?Q?O90jBDTYhQ00Ge/DTwS9rv3if9TLkgbPcMa/9/jLeovirX6poce/mbo2ImJR?=
 =?us-ascii?Q?/xZ/JrcrQNv7KKMZSsIxeJVXk9PbZvllhQdzQb68Hlxy7uGjhYJIJa0OPLez?=
 =?us-ascii?Q?h8V2Bnh4shzalyq8zca9kAuOPKJPKA5mh5OFQmRQ8fyhtNBlLVWAUuHU6tBe?=
 =?us-ascii?Q?5PumIYkpiHCkXgEhRr4RZYWKEDaw86n/6e7wQTpTRlb1JamlQ6V4cRd+Okr3?=
 =?us-ascii?Q?44DIrDoHwXrk8MVxvOhBhPL17ckIu7jt8S99EOWDP7AFUztloccUdVq5QN0E?=
 =?us-ascii?Q?TphC7Co9Ck0kICzkbVKMA2AZR+ncL3YL/saS5DBRJzRNJFxYnX04/mMdRT7A?=
 =?us-ascii?Q?9IdX4nCcnqA1m+jEczbu70XyJc82EbWrxRV8NnBIEc2UDP5c0W58OsaMhwPO?=
 =?us-ascii?Q?ItO6zZlqs4cuxTq06kOWccuYyg70wmYflyZ+57zXXERxvcnX0ma7Lhfq77cX?=
 =?us-ascii?Q?TxucI0vOdwvfvNj54HV61/XpzJgTuphN66Bud8IXIYhBSTgUUmApIj51hHWx?=
 =?us-ascii?Q?GdRWnAv04x29hbXd3sPwyjRl7Dtt6gKYQT7QiAn6IRJUuK/w+e2aX3DoEWnJ?=
 =?us-ascii?Q?oD69QcuE0Z5zvQtQaMUoUye8FbQO+aKdxprGvypVRYUSBszC2GgeaI2+1Znf?=
 =?us-ascii?Q?C7cnkM27v4nb96ZvN+HVZdTCGOrP4SxO6OAYMqy0VoUVYxLyJxEhlc4JTu+F?=
 =?us-ascii?Q?WBEuhbB9mM06tY38yIoT7Svvq6eBgHLJbK3hhwsfQU70xAupYG6u9lON3AH4?=
 =?us-ascii?Q?ZNQn+595V6S0VPmsmtAnlALgfXgSd96MhvG6BbLVszw7aVAepwoGO7YXyDM0?=
 =?us-ascii?Q?r8ayfnkWbDWaZGcLJcLoFL8y7YQCSV9iDyWt7lkNyAaWC4tDkZeRP0cMof38?=
 =?us-ascii?Q?/VQ6A5HyPDB3LgY+NZyIBL9Rd0BWm42p7Fc0DogHVt/+m3bYvv3DaxP0N51B?=
 =?us-ascii?Q?NxXqqSyjkeZ1vEp1ijYuFqLun7VwA2q1eTcIQUbSJKJbERw+Ax3fPFNo/GrP?=
 =?us-ascii?Q?2zawXw9hCYsniecPtrnrpC4fJPdLoHx2h6qLpaPL5z8CLoXXxoZcAw6471bp?=
 =?us-ascii?Q?MSHFkyJQ0/NB7CL1FwEp5mUtnjZ1jgZ9m/cXPVwn1vlhWWV9LNvzSESet9k8?=
 =?us-ascii?Q?yVUTymGoQJFWlu+6zn57GsOlgjHvhTs6+233k3gw+B+qwZm/7cjOVFOgw5A?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a7ef126e-d62d-4167-48a0-08dd2832f8b7
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Dec 2024 18:02:34.2169
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR02MB7267

From: Sonia Sharma <sosha@linux.microsoft.com> Sent: Friday, December 20, 2=
024 3:56 PM
>=20

Please include the "linux-hyperv@vger.kernel.org" mailing list
when submitting patches related to Hyper-V.

> Harden hv_util type device drivers to allow single
> instance of the device be configured at given time.
>

I think the reason for this patch needs more explanation. For several
VMBus devices, a well-behaved Hyper-V is expected to offer only one
instance of the device in a given VM. Linux guests originally assumed
that the Hyper-V host is well-behaved, so the device drivers for many
of these devices were written assuming only a single instance. But
with the introduction of Confidential Computing (CoCo) VMs, Hyper-V
is no longer assumed to be well-behaved. If a compromised & malicious
Hyper-V were to offer multiple instances of such a device, the device
driver assumption about a single instance would be false, and
memory corruption could occur, which has the potential to lead to
compromise of the CoCo VM. The intent is to prevent such a scenario.

Note that this problem extends beyond just "util" devices. Hyper-V
is expected to offer only a single instance of keyboard, mouse, frame
buffer, and balloon devices as well. So this patch should be extended
to include them as well (and your new function names containing
"hv_util" should be adjusted). Interestingly, the Hyper-V keyboard driver
does not assume a single instance, so it should be safe regardless. But
the mouse, frame buffer, and balloon drivers are not safe.

With this understanding, there are two ways to approach the problem:

1) Enforce the expectation that a well-behaved Hyper-V only offers a
single instance of these VMBus devices. That's the approach that this
patch takes.

2) Update the device drivers to remove the assumption of a single
instance. With this approach, if a compromised & malicious Hyper-V
were to offer multiple instances, the extra devices might be bogus,=20
but memory corruption would not occur and the integrity of the
CoCo VM should not be compromised. As mentioned above, such
is already the case with the keyboard driver.

I've thought about the tradeoffs for the two approaches, and don't
really have a strong opinion either way. In some sense, #2 is the
more correct approach as ideally device drivers shouldn't make
single instance assumptions. But #1 is an easier fix, and perhaps
more robust. Other reviewers might have other reasons to prefer
one over the other, and have a stronger viewpoint on the tradeoffs.
I would be interested in any such comments. But I'm OK with
approach #1 unless someone points out a good reason to
prefer #2.

>
> New function vmbus_is_valid_hvutil_offer() is added.
> It checks if the new offer is for hv_util device type,
> then read the refcount for that device and accept or
> reject the offer accordingly.
>=20
> Signed-off-by: Sonia Sharma <sonia.sharma@linux.microsoft.com>
> ---
>  drivers/hv/channel_mgmt.c | 64 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 63 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
> index 3c6011a48dab..1a135cfad81f 100644
> --- a/drivers/hv/channel_mgmt.c
> +++ b/drivers/hv/channel_mgmt.c
> @@ -20,6 +20,7 @@
>  #include <linux/delay.h>
>  #include <linux/cpu.h>
>  #include <linux/hyperv.h>
> +#include <linux/refcount.h>
>  #include <asm/mshyperv.h>
>  #include <linux/sched/isolation.h>
>=20
> @@ -156,6 +157,8 @@ const struct vmbus_device vmbus_devs[] =3D {
>  };
>  EXPORT_SYMBOL_GPL(vmbus_devs);
>=20
> +static refcount_t singleton_vmbus_devs[HV_UNKNOWN + 1];
> +

From what I can see, these refcounts always have a value of either
0 or 1. The refcount never goes above 1 because the intent of this
patch is to enforce having only a single instance. The patch reads
the refcount, sets it to 1, or decrements it. I think you could just
use an array of booleans here, and set them to true or false.
READ_ONCE() and WRITE_ONCE() should be used because the
booleans are accessed from multiple threads.

>  static const struct {
>  	guid_t guid;
>  } vmbus_unsupported_devs[] =3D {
> @@ -198,6 +201,25 @@ static bool is_unsupported_vmbus_devs(const guid_t *=
guid)
>  	return false;
>  }
>=20
> +static bool is_dev_hv_util(u16 dev_type)
> +{
> +	switch (dev_type) {
> +	case HV_SHUTDOWN:
> +		fallthrough;
> +	case HV_TS:
> +		fallthrough;
> +	case HV_HB:
> +		fallthrough;
> +	case HV_KVP:
> +		fallthrough;
> +	case HV_BACKUP:
> +		return true;
> +
> +	default:
> +		return false;
> +	}
> +}
> +

Rather than have a big case statement here, we already have
the "vmbus_devs" array that statically specifies various properties
of each VMBus device type. I'd suggest adding a field to those array
entries to indicate whether the device type is expected to be a
singleton. Then you can just do a direct lookup, like with the
"perf_device" and "allowed_in_isolated" properties.

>  static u16 hv_get_dev_type(const struct vmbus_channel *channel)
>  {
>  	const guid_t *guid =3D &channel->offermsg.offer.if_type;
> @@ -1004,6 +1026,26 @@ find_primary_channel_by_offer(const struct vmbus_c=
hannel_offer_channel *offer)
>  	return channel;
>  }
>=20
> +static u16 vmbus_is_valid_hvutil_offer(const struct vmbus_channel_offer_=
channel *offer)
> +{
> +	const guid_t *guid =3D &offer->offer.if_type;
> +	u16 i;
> +
> +	if (is_hvsock_offer(offer))
> +		return HV_UNKNOWN;
> +
> +	for (i =3D HV_IDE; i < HV_UNKNOWN; i++) {
> +		if (guid_equal(guid, &vmbus_devs[i].guid) && is_dev_hv_util(i)) {

Ideally, we should avoid coding yet another case of searching through
the vmbus_devs[] array for a matching GUID. The function hv_get_dev_type()
already does this, and returns the index into the vmbus_devs[] array.
You could probably use that function, and then just pass the index as
the argument to this function.

That index is also stored as the "device_id" (arguably mis-named) in the
struct vmbus_channel, so it's already available in the rescind path.

> +			if (refcount_read(&singleton_vmbus_devs[i]))
> +				return HV_UNKNOWN;
> +			refcount_set(&singleton_vmbus_devs[i], 1);
> +			return i;
> +		}
> +	}
> +
> +	return i;
> +}
> +
>  static bool vmbus_is_valid_offer(const struct vmbus_channel_offer_channe=
l *offer)
>  {
>  	const guid_t *guid =3D &offer->offer.if_type;
> @@ -1031,6 +1073,7 @@ static void vmbus_onoffer(struct vmbus_channel_mess=
age_header *hdr)
>  	struct vmbus_channel_offer_channel *offer;
>  	struct vmbus_channel *oldchannel, *newchannel;
>  	size_t offer_sz;
> +	u16 dev_type;
>=20
>  	offer =3D (struct vmbus_channel_offer_channel *)hdr;
>=20
> @@ -1115,11 +1158,29 @@ static void vmbus_onoffer(struct vmbus_channel_me=
ssage_header *hdr)
>  		return;
>  	}
>=20
> +	/*
> +	 * If vmbus_is_valid_offer() returns -
> +	 *	HV_UNKNOWN - Subsequent offer received for hv_util dev, thus reject =
offer.
> +	 *	HV_SHUTDOWN|HV_TS|HV_KVP|HV_HB|HV-KVP|HV_BACKUP - Increment refcount
> +	 *	Others - Continue as is without doing anything.
> +	 *
> +	 * NOTE - We do not want to increase refcount if we resume from hiberna=
tion.
> +	 */
> +	dev_type =3D vmbus_is_valid_hvutil_offer(offer);
> +	if (dev_type =3D=3D HV_UNKNOWN) {
> +		pr_err_ratelimited("Invalid hv_util offer %d from the host supporting =
"
> +			"isolation\n", offer->child_relid);

This check for multiple instances of a singleton device is not limited
to just CoCo VMs (a.k.a. "isolated VMs"). So the error message here really
shouldn't reference "host supporting isolation".

> +		atomic_dec(&vmbus_connection.offer_in_progress);
> +		return;
> +	}
> +
>  	/* Allocate the channel object and save this offer. */
>  	newchannel =3D alloc_channel();
>  	if (!newchannel) {
>  		vmbus_release_relid(offer->child_relid);
>  		atomic_dec(&vmbus_connection.offer_in_progress);
> +		if (is_dev_hv_util(dev_type))
> +			refcount_dec(&singleton_vmbus_devs[dev_type]);

It might be good to have a function that combines the above two lines.
Then the two parallel functions are:

1) vmbus_is_valid_hvutil_offer() which marks a singleton device as
"already present" [and that function probably needs a new name]

2) vmbus_clear_singleton_device(), [or something similar] that clears
the boolean if it is a singleton device.

vmbus_clear_singleton_device() would also be used in the
rescind path and in the vmbus_add_channel_work() error path
that I mention below.

>  		pr_err("Unable to allocate channel object\n");
>  		return;
>  	}

There's another error case in the channel offer path that needs
to be handled.  vmbus_add_channel_work() can fail, in which case
the new channel is cleaned up and removed. The accounting of
singleton devices must be updated if the channel is deleted via
this error path.

> @@ -1235,7 +1296,6 @@ static void vmbus_onoffer_rescind(struct vmbus_chan=
nel_message_header *hdr)
>  	/*
>  	 * At this point, the rescind handling can proceed safely.
>  	 */
> -

This is a spurious whitespace change that should be avoided.

>  	if (channel->device_obj) {
>  		if (channel->chn_rescind_callback) {
>  			channel->chn_rescind_callback(channel);
> @@ -1251,6 +1311,8 @@ static void vmbus_onoffer_rescind(struct vmbus_chan=
nel_message_header *hdr)
>  		 */
>  		dev =3D get_device(&channel->device_obj->device);
>  		if (dev) {
> +			if (is_dev_hv_util(hv_get_dev_type(channel)))

As noted above, the "dev_type" is already stored in the channel structure
as field "device_id" (which is a bit mis-named).

Michael

> +				refcount_dec(&singleton_vmbus_devs[hv_get_dev_type(channel)]);
>  			vmbus_device_unregister(channel->device_obj);
>  			put_device(dev);
>  		}

