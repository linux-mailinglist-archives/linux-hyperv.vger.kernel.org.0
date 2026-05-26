Return-Path: <linux-hyperv+bounces-11199-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kEkhHmC9FWrYZgcAu9opvQ
	(envelope-from <linux-hyperv+bounces-11199-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 26 May 2026 17:33:52 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EA5545D8CF5
	for <lists+linux-hyperv@lfdr.de>; Tue, 26 May 2026 17:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6379B302D309
	for <lists+linux-hyperv@lfdr.de>; Tue, 26 May 2026 15:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1DA3212B2F;
	Tue, 26 May 2026 15:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="cgnGe7NS"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazolkn19012063.outbound.protection.outlook.com [52.103.2.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63AC2271A71
	for <linux-hyperv@vger.kernel.org>; Tue, 26 May 2026 15:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.2.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779808511; cv=fail; b=c/ELp+7Bu0UzIKTD+OYaQ9RXRUI8fWEAolKwDX9vNaeIHwCTC5ooXOtolxOLixSfo82oCa6fyGVfI4nPSVjp00fUseE7y3bnQwoGcqbqVTrlSSUIxdunuUSe1zSSGnFcyvAegOh4zm9ygDNRTi7IVMtNqEqmC1v42jAZcVU2gmg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779808511; c=relaxed/simple;
	bh=PJhggXffpYC6NamOaZohzZs+ObmQzffJagXP4/lvym8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=c6XMeS8DFhFFSMVaeFFw9hcJINCvpMpx6WVUbfhplc0s173xmHkZLeJIztmx6+HkHqkoEO8eDrscPELJgfTxJC0IGtFqcuZSB0ejWGKhU0AZZrOLz/1T/qPKml5dGHvsRKlKIq5D+HAdHEyr9CdvsNTeyy5RlBhQDiLw6FYk5cs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=cgnGe7NS; arc=fail smtp.client-ip=52.103.2.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cwnI65/xLaWdPjEfBNCa8GTuamu0Egp8Ab58RNdnLaiDhBQDgudMNiudep/g25AlEq3khyHs8wYtPKQByEHss2D0mzylhrFVKCGOKjAsVQAxt0KRjCAlaVv35/QpwA1sgtEXYD1kIdpGQs3No3RSyjd1MujMMkmrnJTDq5/VzDldVX2+OwWMgJJZ2ssUmyNaSroOS1UPaX0SVEojhpq9peyXByBi3rexIgq56euXf1Qg8k6MbZvWJHjCz+q1rlxk+Dypqot9Y5UQgLQ4upTf9Kph7KvrmKwhfDk1z7rNhwIHIjccmATklL27yYtw/dtMw7xmt64H7/2rQrWCuTbHlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ot3HRSf0Ax4crVTddh+/5NO6l4fgap5gYadMFOB1nY=;
 b=bZXTBGuO9Kgozwrh+YcYv5oFw0QSrcfZh0ignplX/8NKCSDeYOLshSqiUe+RjTLNIovXidoD6gd8+2y1RRmpARUwiuhYgeHhD9APk9dwNX60Qkvb9Iud1KcymBfX87xIys60iasuXKQpMGlFoIhtXqMB0n+V9K3qZuBuvLhD1cbLV3c6z0FR3MTRK7uOcunr0z1366GLEIQU0bqQ46cOD4enwuDdj9TckbodykWS/hg41j3BnaCN5NGtuvveTbJVdE95KynLVxtGTds4h9c91OPTVjk9cQcQLu/mTLpCfKjNXRFbX4D6kIGuGHMXBvZOU8ep3qTixtwXEktzRN9GLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ot3HRSf0Ax4crVTddh+/5NO6l4fgap5gYadMFOB1nY=;
 b=cgnGe7NSqfeQRaPoNc+9hMv44+m+lVLzhV7DhqB06DNVBQIGF/G9iMBo/J9DCh3t//aTIC4M8Dt32ecpEJBzBeJLuZUazL1oWR26WQdEsXBxYIzU8Z1UfJQ/G9xbJGm//8U56++bzDv32l3/2nu/TA6A4IPjU1uXDOQgI9oxrlpXQ521smMIA7HWDQwH+CuktE8+wo1D/sEdhQFKFD7Ad4pZsnF0yOxDbjqJfDn2Yq0Bf0VCQJcofw7ILGLpW06NukI2uEfgfOmbmUhVd/KMTrOl2VlcP0yJmQgGOZbsC6czZXxyOH9D0WjplgXkAA1oc2aRkcrUbuiYXIqgfW7vxQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by DS3PR02MB11572.namprd02.prod.outlook.com (2603:10b6:8:366::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Tue, 26 May
 2026 15:15:09 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.21.0048.019; Tue, 26 May 2026
 15:15:08 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Naman Jain <namjain@linux.microsoft.com>, Ben Hutchings <benh@debian.org>
CC: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang
	<haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
	<decui@microsoft.com>, Long Li <longli@microsoft.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH] uio_hv_generic: Bind to FCopy device by default
Thread-Topic: [PATCH] uio_hv_generic: Bind to FCopy device by default
Thread-Index: AQHc7SDgZcEhH/qB9k2DCo25Y9OAa7Ygap3A
Date: Tue, 26 May 2026 15:15:08 +0000
Message-ID:
 <SN6PR02MB41574FDA377FF59597181B7BD40B2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <aa420dc1-029c-408b-aef0-f02d6bfa002c@linux.microsoft.com>
In-Reply-To: <aa420dc1-029c-408b-aef0-f02d6bfa002c@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|DS3PR02MB11572:EE_
x-ms-office365-filtering-correlation-id: e21f2741-888d-4baf-5001-08debb39931d
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799012|8062599012|8060799015|13091999003|31061999003|19110799012|51005399006|37011999003|19101099003|440099028|3412199025|12091999003|102099032|40105399003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?HibnjVLVWYmGNtultR7hkpV7afVuOYzX3fYh6J8C+B3QqSUv16qAMwy4evfT?=
 =?us-ascii?Q?koT6PsWHvAerHk7CwMLDe5nT05QLsesDbfMQh1GUMkLM4yKWsjcMBlvp855v?=
 =?us-ascii?Q?/NMTXtFF6NL7ZksppcADhOliOSuVJcUkelal4+0CCuuHqG0t0UrOfUBxUp4S?=
 =?us-ascii?Q?Vz0yJ3qBUW2OW+LdZHkQZBrVuVqoJiodE8gcofr5cUpz7s1zDcsfHYNG+if5?=
 =?us-ascii?Q?RRGdtRshq/X8h/eRFzX0Qqhltc8JkzAPT06EVYbroK6Q5movUq3Zd92fMzsR?=
 =?us-ascii?Q?xHuHgad+TMyxKrCYECCWuZGAJypTxnSjnT0GDl7sfewmTKgVuNyG1CheahXq?=
 =?us-ascii?Q?MXMpMJ5DSndcpSRMYrs4aLNBoABAALIdD2j73jB8vfnxK6iYDFLe8q8cjxKZ?=
 =?us-ascii?Q?za2HFEghlZa2OJVAuVtmhvrm7YUoPpyVAeg1BHNhJtg8CqvX90tnbLJYvNP1?=
 =?us-ascii?Q?SuFRaGTJnEkM17qQqKk2S7tBYNcpvzzXMYIgizqBg8c3mD4CyExVkSIsFW3D?=
 =?us-ascii?Q?hxzpkuBLfD9dO49PGEz/zGfm4kmq3YovhoAEVGHdAiDoVt5UF0fT2tLt2zIJ?=
 =?us-ascii?Q?dVayuhACk32xESXuAa6HpJVZScjHiLFY8VYM5USZGlcRgJfQuvhJaBmXwWOo?=
 =?us-ascii?Q?N7fW11hIUga2//BFH/jVycwhWZ9ohh+7J3po1ErtajThtWpSIJDAAllzZ8Q9?=
 =?us-ascii?Q?inuFEZLTOM99ZykQ2p6nQU263MAZTNF/twJAWF28Im+VroGQaM4pkzl1lzBA?=
 =?us-ascii?Q?X8q20rrCYsayCIn7E/D+OPYsYrGjtWp0eEBcthukAx8znXjLeEaOd3Mux2Cs?=
 =?us-ascii?Q?uZL9br1iZ3EWNwov5oH+JoS5EMS9JZpFcSTZcEnZlTs9D3v9KHJ2aTCqDCJ2?=
 =?us-ascii?Q?Ram4KMKcrWfJtyE+B6w+yKlH/8/d24Ou8C9l9XoVdE9491HntwHE2EinFeNG?=
 =?us-ascii?Q?j8m2euolWaEnyKVUOwzONwyZE4tPsNBOXeF7civ8P4oLZ0z6VS6SaPGbvAlG?=
 =?us-ascii?Q?eRzsPMifAxYJ0qyaAJJPJf8cg1QF/e0g9A89lshByaviHxQ=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?5BB4Ai+8y4p5eqFWz8H6tvhD6wD5+CkUXozJxneGUD2B+nrOvHK3fPmc/B53?=
 =?us-ascii?Q?BeZiZurclOTiAKdcCyFMB3EMcsAAWa2BHCEWhM+5b0Jy85Pi3nMmaBU3SCAI?=
 =?us-ascii?Q?YmiX/YWn3TyTp6d/KMtVTleJO9o6uW4aQI5VmKgCQGvuysNfT1bSCP6zD4WH?=
 =?us-ascii?Q?yAHhHgcOxfvMQAqdA8/Q3ldw1KL/YwuDFhT3nRzfjsZ3vWvgmt2cInN+jY71?=
 =?us-ascii?Q?KE5aFU4ieEj75BJQfRW7QQSdS3oSF5FQbqt8y3d6IU4HrP7uflCVxE7F/LY2?=
 =?us-ascii?Q?i/lVLOwaXdVui+Apk0qDCWp855osdpPQz25kCjIPA1Mb/P+wQrkPC1f5fYlt?=
 =?us-ascii?Q?Yd6gvYcqhZZucN4fbInfskhC64ixGCtmdPdRzaVhajxgyteT4QrgqDIosJKn?=
 =?us-ascii?Q?pXRVf7yHTqVJy5n91dLw4Z/6U/PILobvqIMu9+lpsH8Pkk9mXPhK0AT/4JHs?=
 =?us-ascii?Q?jZjInzM0hJFxqVqrXE+kMk9kcFTXR49ZkZ9fP81ReRZR1vC6ajVTehg8H8+Q?=
 =?us-ascii?Q?kjDQ8somMymFbjhJtX66YUiCEUzAgQ5PoXt+1NOHrAAhxhjiLvoB2kXnHzAL?=
 =?us-ascii?Q?vyFqXlYSa88j6UP1DkNzN+gsI8PlzN8pcq6UU+RgZ4TLa6pubxEanrGwDrwo?=
 =?us-ascii?Q?CWGZQNFazBg+cYVFrpf31M6cicjgcSTUl1W/pssDzek6swD8+aQ1rccfxPlS?=
 =?us-ascii?Q?ZUrUk2z6rfjue0A98KNq8Ju11iYOS7p1u1Sy69MqMgNRrxmk9osxGXTyTExi?=
 =?us-ascii?Q?oWdiOxw9SfZ3G4EXndbxrSDmBvWwEBs40/6Q4X6j8TeQoiSJL/2vY2e67QZQ?=
 =?us-ascii?Q?ufgGowJLjAN9VUgUVBpjs01Nxen/c+/y8BvfCY+RYTqTAISToSO5tQlNxqlh?=
 =?us-ascii?Q?ogFIj2Gwp0WqoE6MnAoryW2RRmwMspiyt8IvU9sP9MlwcN1JZ28G0igWAgeC?=
 =?us-ascii?Q?yzkCVEZ6S4cgdVUIrAS413wHi5TWzaVh4TU3t1or4hI1NmAbFX0GAUIeu6LZ?=
 =?us-ascii?Q?3qYSxov4qaHHHQVtquCvX3VGZHPCUizz1d/zgrohrYQp9uySm1BW34Z1/1n9?=
 =?us-ascii?Q?16Z8cdgqOI6Au8pJSH0F8S6ljeRbtgy4qt9/bqqoDFwDJiebHwW7DNcdRV4G?=
 =?us-ascii?Q?w7lST7BHqJd3ClZcVhceoYS4hEOzUw2ZKa277klXgbERnP+N7BCtyLa+Sj20?=
 =?us-ascii?Q?bMoAWaz23uVYccRI0o4NPtBUIkRrnFlEnusTTd/HLwvhOViKmZ4/h8Y6Ecxr?=
 =?us-ascii?Q?3dQWU3MN7Gen/KnmOSTeWvOnBhv/rpof9OHVsJMBFsCS48/T2vGPZzbOsRDZ?=
 =?us-ascii?Q?KUxpbOXZRJZTtV4i2R/G5DFsDzRS6QK2vgR5TO7m1/NYVf8adCPdez5/Xznr?=
 =?us-ascii?Q?8oM/J3U=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e21f2741-888d-4baf-5001-08debb39931d
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2026 15:15:08.8444
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR02MB11572
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11199-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[outlook.com];
	DKIM_TRACE(0.00)[outlook.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: EA5545D8CF5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Naman Jain <namjain@linux.microsoft.com> Sent: Tuesday, May 26, 2026 =
3:10 AM
>=20
> On 5/26/2026 1:59 PM, Ben Hutchings wrote:
> > On Tue, 2026-05-26 at 12:15 +0530, Naman Jain wrote:
> >>
> >> On 5/25/2026 5:34 PM, Ben Hutchings wrote:
> >>> The Hyper-V kernel-mode fcopy driver was removed in 6.10 and the new
> >>> fcopy daemon requires this uio driver to function.  However, by
> >>> default the driver does not bind to any devices, and must be
> >>> configured through the sysfs "new_id" file.
> >>>
> >>> Since the FCopy device is now only usable through this driver, add it=
s
> >>> ID to the driver's ID table so that the daemon will work "out of the
> >>> box".
> >>>
> >>> Signed-off-by: Ben Hutchings <benh@debian.org>
> >>> Fixes: ec314f61e4fc ("Drivers: hv: Remove fcopy driver")
> >>> ---
> >>> --- a/drivers/uio/uio_hv_generic.c
> >>> +++ b/drivers/uio/uio_hv_generic.c
> >>> @@ -395,9 +395,15 @@ hv_uio_remove(struct hv_device *dev)
> >>>    	vmbus_free_ring(dev->channel);
> >>>    }
> >>>
> >>> +static const struct hv_vmbus_device_id hv_uio_id_table[] =3D {
> >>> +	{ HV_FCOPY_GUID },
> >>> +	{}
> >>> +};
> >>> +MODULE_DEVICE_TABLE(vmbus, hv_uio_id_table);
> >>> +
> >>>    static struct hv_driver hv_uio_drv =3D {
> >>>    	.name =3D "uio_hv_generic",
> >>> -	.id_table =3D NULL, /* only dynamic id's */
> >>> +	.id_table =3D hv_uio_id_table,
> >>>    	.probe =3D hv_uio_probe,
> >>>    	.remove =3D hv_uio_remove,
> >>>    };
> >>
>=20
> ++ recipients, assuming you mistakenly clicked reply instead of reply all=
.

Ben --

Regarding recipients, please include the full LKML
(linux-kernel@vger.kernel.org) on the original patch posting, even
though it is about a narrow Hyper-V issue. I dabble in areas beyond
just Hyper-V so subscribe to the full LKML instead of the
linux-hyperv mailing list. I miss patches like this one unless I happen
to be looking through the lore.kernel.org archives for linux-hyperv.

Thx,

Michael

>=20
>=20
> >> Two things worth considering before applying:
> >>
> >> 1. Please add Cc: stable@vger.kernel.org or is it that we do not want
> >> this to be ported to older kernels?
> >>
> >> 2. Every Hyper-V guest (with UIO_HV_GENERIC enabled) will now have an
> >> additional auto-bound /dev/uio0 node for FCopy.
> >
> > I don't think that's quite true.  I tested with a Windows 11 host and
> > needed to enable "Guest services" for the VM, which was disabled by
> > default.  But if that includes other features besides FCopy it might be
> > enabled for other reasons.
> >
>=20
> Yes, meaning if these two conditions are satisfied (enabling guest
> services is also one time step for a Hyper-V VM), we would see uio0 by
> default for fcopy.
>=20
> >> Anything that hardcodes
> >> /dev/uio0 (e.g. ad-hoc DPDK scripts that bind a NetVSC NIC via
> >> uio_hv_generic + new_id) may see its index shift, since FCopy now wins
> >> uio0 at boot.
> >
> > OK, so maybe I should implement the new_id dance in the fcopy service
> > startup, to avoid that?  I did already looked at doing it in a systemd
> > unit, but it's hard to do right because adding the same ID twice is an
> > error.  Maybe the daemon itself ould do it?
>=20
> Implementing it in uio daemon can introduce race conditions with sysfs
> creation. I guess it's OK then to implement it here, in kernel.
>=20
> >
> >> The fix for such consumers is the same thing DPDK and the
> >> in-tree daemon already do: resolve uio via
> >> /sys/bus/vmbus/devices/<guid>/uio/ rather than by number. This is not =
a
> >> regression in the patch, but it's a behavior change worth calling out.
> >
> > It would be a good reason *not* to make this change in stable.
> >
> > Ben.
> >
>=20
> What issues are you fixing with this patch exactly? Is there any
> particular sequence of events you are targeting where traditional
> approach does not work?
>=20
> Regards,
> Naman


