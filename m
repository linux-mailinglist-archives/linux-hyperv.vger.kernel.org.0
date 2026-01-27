Return-Path: <linux-hyperv+bounces-8547-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EBn7HIDueGkCuAEAu9opvQ
	(envelope-from <linux-hyperv+bounces-8547-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 27 Jan 2026 17:57:36 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E5E9810D
	for <lists+linux-hyperv@lfdr.de>; Tue, 27 Jan 2026 17:57:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E22F63025909
	for <lists+linux-hyperv@lfdr.de>; Tue, 27 Jan 2026 16:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6975E31328C;
	Tue, 27 Jan 2026 16:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="a9gZz/zj"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazolkn19011015.outbound.protection.outlook.com [52.103.1.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497D43570C0;
	Tue, 27 Jan 2026 16:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.1.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769533047; cv=fail; b=f74YHPMqe7isG4Tm3Dmwt+u6FtsG8xbJe8PSHrKfuesiWKRWm8Q8wqflUb+48pwLNIRqo4g9/sO7WQHoi0NeziwGTihdPdM2Wka0xeXCH2FrSYZo5rqrctcZ1z8UryhuOnLXT+TRRz8Gb5b8pHYj45lGMPDxt31H4bKvAkWaqDM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769533047; c=relaxed/simple;
	bh=8JX2K6EwuUtXcKri+nIVHKv9B538Pyhmhz05IKNGk/o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RlkuPl6YusiKsNmWKygNy5xyvClvTYerY4KPghLr1SRUo/jYE6gtXd+7OE1RCjUMDq8z4WqlpCkZ6tgVfVZiJoA2tXBify3D7FC/im1PL+492T6pg2O/fOkml/7p7lqu3DB0H0pFl8M17d/G31nW/WvpCirfAWmvFAl+UrVaYGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=a9gZz/zj; arc=fail smtp.client-ip=52.103.1.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sstw/5AqPoKVp2eyr5kdxkMUYe7d3Jjr4EUSUAPti/L4GTh+UJ/yhtih2JTLzrJOh4B0+KeGH4XhK629f3jLFRKDpdWfHY7vqGr9cvLskrRB3lfdRW95jh9ciB56H6IwOSkLOro3Wn1o2QUsxLhltBThPlKw/N9tn+QIJhMn/9XDnxs+yXYo3Mv+OgF+fkCL7fobDM+YIqB7ULjQa3FlQR4AFT15RO/dXn/tyyY5PCz4ImZVIa5TGuwLLMut4aR7OKQD9Wz6HvTt/uerouA5pk9peygJ3a0vCLNT11bld2wQ7GIPAJVU9nFMI0wwCyJ6jqQOM/Ijrm+y2peWNT4LVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bGLH+/0aBud5hDgozF0jiAUypWPeqbD2pn6Ar2sDNv4=;
 b=HXVETY18M7I/n15/8DU8SBjI33tgj/6Q09NTIopWj+NpPxGp48/Z0d79MGZqrCl4cxJv3wZeLk/g03lQNAGPqlGXktGNFuZ8D93TTmpl1zxtjBr0AsZJPrgEMDngzRcLuUz34tSnVuOJQ76/RkZNSJfKpV0O1DQWbsDXsrMMswneLyeIjFiukCcKHGVeGjivzZ+p+RvNuwH/Hchpy6Tf9IJ911DJz4Ga9C3ga2S0DKkfWZbFsF7yzVVb8mxnzU6jmdqrXQIdGTyA6nZ0X6T26BsEln7WKd6i7JZIe7ZQBTEexPZ/lX5JMvfCWP2UgxC5uIAZSH9OZIUiPX4Va9SxUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bGLH+/0aBud5hDgozF0jiAUypWPeqbD2pn6Ar2sDNv4=;
 b=a9gZz/zj104Dy2fplNklAH081zeVFEHCwETIZuxQrOcHKmrnjvBCRfVi3KH7/OQjilMxTEoiGV7SWODZzxQtwmWlxwmr/ngDy6K9A/DSU/k5Y1PEhQnO4XLTxdMCTOWyIdzNjg7Ba2DG6rQpgQxvCi+Pva6iHOI2AYRdr/d9jzmc7MQ/1xqFI3X37x3wJCE/tg16txO7//HzxjLA1N2udGGKL+CIZm/LPh1+XLeC0goNaatpIpv2c0SwpzGDaG+t6mJsAWHNGJvOMXuhHuAZTPPE/lI9tUAp5DsiMH68wcxLFmgQluYnxWOcefUEwfNZ6+PSojeLc+XUEWDGN8QrJw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by BY1PR02MB10459.namprd02.prod.outlook.com (2603:10b6:a03:5a8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Tue, 27 Jan
 2026 16:57:22 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9542.010; Tue, 27 Jan 2026
 16:57:22 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"skinsburskii@linux.microsoft.com" <skinsburskii@linux.microsoft.com>
CC: "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "longli@microsoft.com"
	<longli@microsoft.com>, "prapal@linux.microsoft.com"
	<prapal@linux.microsoft.com>, "mrathor@linux.microsoft.com"
	<mrathor@linux.microsoft.com>, "paekkaladevi@linux.microsoft.com"
	<paekkaladevi@linux.microsoft.com>
Subject: RE: [PATCH v5 6/7] mshv: Add data for printing stats page counters
Thread-Topic: [PATCH v5 6/7] mshv: Add data for printing stats page counters
Thread-Index: AQHcjwYxZUO2/yJg0EmsJOukXrjqTbVmOzBQ
Date: Tue, 27 Jan 2026 16:57:21 +0000
Message-ID:
 <SN6PR02MB41573636E0DB37B394E79FB9D490A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260126205603.404655-1-nunodasneves@linux.microsoft.com>
 <20260126205603.404655-7-nunodasneves@linux.microsoft.com>
In-Reply-To: <20260126205603.404655-7-nunodasneves@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|BY1PR02MB10459:EE_
x-ms-office365-filtering-correlation-id: 67af266a-f614-499b-ae00-08de5dc52391
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799012|13091999003|31061999003|8060799015|8062599012|19110799012|51005399006|461199028|3412199025|440099028|102099032|56899033|40105399003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?pG8O0BOiiQJ9EDeEnasObik2Q0UU/2ibbf4NrggS3X2qFsrsGcq0AwPl9pO2?=
 =?us-ascii?Q?ZVgJMOR8dfo8Gx5Y2sKqEe/+3Y9PbO/ySttW6LcQS3e01s+0ZGKARzWY4Hph?=
 =?us-ascii?Q?/M3fLoDuxZwCoQrUK3WY88aBpAYwqdkcW/HC1revZUrhar9fklf9FBoEviE1?=
 =?us-ascii?Q?OAKef1mgGG6s9Eo3x2etOqcSIuvXRtzS/xFIw/LIo5DQx0xxc1q7T/q7hosi?=
 =?us-ascii?Q?jzeaPFAaKAZ0cUbB+FEUCLN7d1mQ5Y208h46ox2EBMj10mXUznHnmmDm/m6b?=
 =?us-ascii?Q?GpyJLzCEVVAFEKhBywk5SIq5kKlqCfkNGMB5RM76YsDF01oUnF+HZXeBoRIU?=
 =?us-ascii?Q?+YdsZ99ocrv3VX2A0kEuW8nJ0joJY81rDwVYeEH7uveChsirl8fIVNlp6L1T?=
 =?us-ascii?Q?qu0NVqmGGoYJTk30QNJtqJEVsE4ZAgW9iAYqx+S+i7mzs9dpC8OHegLNxxwz?=
 =?us-ascii?Q?wO1p75LOyqW4DfO+gpw6t5ZOcxeq2aKToNx9cVJiM9zKrGtABJp0MC7ydUxS?=
 =?us-ascii?Q?wk0QnxNwkGt1J995A3m8TnnETBhYkO+RyLt24Fpdwy74x8nn046SYDgCOPTc?=
 =?us-ascii?Q?lgdpLzL9XYsZMN6KkmVXDAMRcxKR72tsM6mpQvYH/yGMXunyvzgOfl35qbs3?=
 =?us-ascii?Q?yQ3pp5LmbzVCqSJa9uynNCCR3GqPYAWDeqyy3znvI0VGKnok1dccnUsaYWu0?=
 =?us-ascii?Q?DFAGpVAX4PsmPwxGgJ2155MQ4RG4V/BuBtRAd5nisOV/dbtAbW3jdZ+dXmAb?=
 =?us-ascii?Q?rqiFRLgzFHIYde+2/l5IUOLOy0O9rRGt+0tX/yCaO/EWmyQKez6k4r3Z+hsI?=
 =?us-ascii?Q?Yy+1ewyS+5SKZAm6W0Y69gcscUCcCbE59jtEdTPY+LPH0FCekZU/Hl97qPqK?=
 =?us-ascii?Q?yCu2vDE0EzvGIRWbv3Z0if1jhdI7aYzwopntaoDVg8BmdwzxQLb93pFmU01l?=
 =?us-ascii?Q?w5j8A6JxbzMTdB/apYif6oV7vJqxEiorYAbYq/9tdHNVmHzqsinBvuEHwinR?=
 =?us-ascii?Q?LF0igg8pvinUCIdDvfeUVBYohkrnP06SxorBayNe1HU6HcpTIJVwYa5MpwXB?=
 =?us-ascii?Q?mJ8eTil+zpfP0eqBo8ANKxSm9ljuoij6LxrwoYUBBrqLmvJ6Dih17RxSSVs1?=
 =?us-ascii?Q?1Zz5/0vqU98d0fwgydSHxlw5isTQy5g8OBwry8mFWYempMt8hOJ14A68X3VH?=
 =?us-ascii?Q?Lx3C0j82KX6kNtI1+oUziMcepk2A56dGBvzj0w=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Gk7Llaf2NkZeuH+Kqjry8ukxPAkPPfyMPQbFta4ggc0350HN2TWG7skvLSae?=
 =?us-ascii?Q?NsOOHRuyzvR0ESi8mNvJZeICYVX1FWuVlzvC2fkUAs4rWPYdVkfetou1YWyB?=
 =?us-ascii?Q?x1kudSbhFjX3sYHTGKskCSJ+hq4YGeZCfJ6eSlniQjmrw3RAdfGenC1kkGiw?=
 =?us-ascii?Q?QLngXq0bRoDMz468SlrGOTxOSNTFW1oItR/eLGlpSJcdUqwKthsZ6bg3pLae?=
 =?us-ascii?Q?uHjLRfem+L44SWnjSE/TevX8OrSynrQr983qwYrPKYV65S1xHtxcfDqyyxMy?=
 =?us-ascii?Q?P/Z8PFlC6/vtTsQilQ5kZ69DO9CKD17ZEQwEU7arIgzOY+1VnUsu4DpI0bnj?=
 =?us-ascii?Q?C8tISrP05WLqqfUqrZM4MIY1HSDG2zhHDXCShDt5NMVxSNlkby6fVFECQsMZ?=
 =?us-ascii?Q?378R3t2049K6E/e1mSFEjMFccKkPJSrz+Wd3CBT9uYVj0sGl3T6+krT96ys6?=
 =?us-ascii?Q?MRYS8sBjfX22rjrP34l4ARKqvyz1X6OLo6XS20A0Xyl3JHAgDgre+z33fvvD?=
 =?us-ascii?Q?xcJk0BfagUc2DKYWtnRHn/v4wGAii/waCuHuLHw/365QG3XRH51cfJKjjUEj?=
 =?us-ascii?Q?XPiFuvepjWxbYsALq0ppumw5jbmenGgOJJCrhSDepxxMjPVpqiDjK+b7fALr?=
 =?us-ascii?Q?3hVVoS3jgQ8KcezNExwi+TAy0gJMSeEtz4Bw7isoT9tNXMOx8uMIhXaWqRyE?=
 =?us-ascii?Q?UzF0G2zkCasQsJWySxwt/mi7kwee2fQYXE/FmHJv3qfCqYym4NJQxAmCA/Cp?=
 =?us-ascii?Q?p4T/NUVylvpZdZCc8rBtBzzEBSEEfFfCYYpoJz5KlWUggwUMtUff/mlc17NG?=
 =?us-ascii?Q?7/EcplAL4KrTbSxJ4Boc1i7Qgyu8+t8iGo4UJbZG6Eh3RRBjcB9ve1T2aM4g?=
 =?us-ascii?Q?A8J52Telc2FR6m9RqnxUKp9H5Er+iahFhtd2oD9eBDj6iWfflTx+aPUSiS0N?=
 =?us-ascii?Q?ptfUNHGDJ9FWUv8HvGDdob0bpGiQH0vAqaIPFKYGj++7ZIBEIgl3jFPnVzX6?=
 =?us-ascii?Q?03DqnZ5tDkPqRb3UaAUP94QQ1gXDALEe1Fu8dUBQl2imokZodrqPaWG9eh6A?=
 =?us-ascii?Q?iaJpB/guCbXeo5fK2TkFq/Yu5+UTQtTgoXulUA1VWKr4pBfZo21Z1ECb1s/E?=
 =?us-ascii?Q?abO+BFU1RuITlnkM6dHM7NC+p3bRXHDy2NizJfjP4nZ1PmOjA/dYUrDeWDX9?=
 =?us-ascii?Q?Ll77Und0zkNHc2mTx28BFnhtdpbwsEqH0Y7dx+WL6uvXukCTMueQ9i3OBn1M?=
 =?us-ascii?Q?+eACteX1cqcBBMjcx/MD0HU9H+ah4K7jRMGMT5Ht/fmyRF1D/aNA4dn5LKVC?=
 =?us-ascii?Q?UwdL9gkvJ0lCABChzfQPvQRMji90lLT6wiD3JJX8ClQ8krakvY3zPUaZ4073?=
 =?us-ascii?Q?V6WfpQk=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 67af266a-f614-499b-ae00-08de5dc52391
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2026 16:57:21.9059
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR02MB10459
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8547-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[outlook.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,outlook.com:dkim]
X-Rspamd-Queue-Id: C9E5E9810D
X-Rspamd-Action: no action

From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Monday, Janua=
ry 26, 2026 12:56 PM
>=20
> Introduce mshv_debugfs_counters.c, containing static data
> corresponding to HV_*_COUNTER enums in the hypervisor source.
> Defining the enum members as an array instead makes more sense,
> since it will be iterated over to print counter information to
> debugfs.
>=20
> Include hypervisor, logical processor, partition, and virtual
> processor counters.
>=20
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> ---
>  drivers/hv/mshv_debugfs_counters.c | 490 +++++++++++++++++++++++++++++
>  1 file changed, 490 insertions(+)
>  create mode 100644 drivers/hv/mshv_debugfs_counters.c

I'm getting these warnings when using "git am" to apply the patch:

root:~/linux-next20260109# git am /root/nunodebugfsv5/0006_mshv_add_data_fo=
r_printing_stats_page_counters.patch
Applying: mshv: Add data for printing stats page counters
.git/rebase-apply/patch:99: trailing whitespace.
        [51] =3D "LpPerfmonInterruptCount",
.git/rebase-apply/patch:116: trailing whitespace.
        [46] =3D "LpRunningPriority",
.git/rebase-apply/patch:499: trailing whitespace.
        [105] =3D "VpExpressSchedulingCount",
warning: 3 lines add whitespace errors.

If I open the patch file in 'vim' with the option to show trailing whitespa=
ce,
there is clearly some spurious whitespace after the comma on each of
these three lines.

scripts/checkpatch.pl also shows these trailing whitespace errors.

Michael

>=20
> diff --git a/drivers/hv/mshv_debugfs_counters.c
> b/drivers/hv/mshv_debugfs_counters.c
> new file mode 100644
> index 000000000000..838af4673dd1
> --- /dev/null
> +++ b/drivers/hv/mshv_debugfs_counters.c
> @@ -0,0 +1,490 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2026, Microsoft Corporation.
> + *
> + * Data for printing stats page counters via debugfs.
> + *
> + * Authors: Microsoft Linux virtualization team
> + */
> +
> +/*
> + * For simplicity, this file is included directly in mshv_debugfs.c.
> + * If these are ever needed elsewhere they should be compiled separately=
.
> + * Ensure this file is not used twice by accident.
> + */
> +#ifndef MSHV_DEBUGFS_C
> +#error "This file should only be included in mshv_debugfs.c"
> +#endif
> +
> +/* HV_HYPERVISOR_COUNTER */
> +static char *hv_hypervisor_counters[] =3D {
> +	[1] =3D "HvLogicalProcessors",
> +	[2] =3D "HvPartitions",
> +	[3] =3D "HvTotalPages",
> +	[4] =3D "HvVirtualProcessors",
> +	[5] =3D "HvMonitoredNotifications",
> +	[6] =3D "HvModernStandbyEntries",
> +	[7] =3D "HvPlatformIdleTransitions",
> +	[8] =3D "HvHypervisorStartupCost",
> +
> +	[10] =3D "HvIOSpacePages",
> +	[11] =3D "HvNonEssentialPagesForDump",
> +	[12] =3D "HvSubsumedPages",
> +};
> +
> +/* HV_CPU_COUNTER */
> +static char *hv_lp_counters[] =3D {
> +	[1] =3D "LpGlobalTime",
> +	[2] =3D "LpTotalRunTime",
> +	[3] =3D "LpHypervisorRunTime",
> +	[4] =3D "LpHardwareInterrupts",
> +	[5] =3D "LpContextSwitches",
> +	[6] =3D "LpInterProcessorInterrupts",
> +	[7] =3D "LpSchedulerInterrupts",
> +	[8] =3D "LpTimerInterrupts",
> +	[9] =3D "LpInterProcessorInterruptsSent",
> +	[10] =3D "LpProcessorHalts",
> +	[11] =3D "LpMonitorTransitionCost",
> +	[12] =3D "LpContextSwitchTime",
> +	[13] =3D "LpC1TransitionsCount",
> +	[14] =3D "LpC1RunTime",
> +	[15] =3D "LpC2TransitionsCount",
> +	[16] =3D "LpC2RunTime",
> +	[17] =3D "LpC3TransitionsCount",
> +	[18] =3D "LpC3RunTime",
> +	[19] =3D "LpRootVpIndex",
> +	[20] =3D "LpIdleSequenceNumber",
> +	[21] =3D "LpGlobalTscCount",
> +	[22] =3D "LpActiveTscCount",
> +	[23] =3D "LpIdleAccumulation",
> +	[24] =3D "LpReferenceCycleCount0",
> +	[25] =3D "LpActualCycleCount0",
> +	[26] =3D "LpReferenceCycleCount1",
> +	[27] =3D "LpActualCycleCount1",
> +	[28] =3D "LpProximityDomainId",
> +	[29] =3D "LpPostedInterruptNotifications",
> +	[30] =3D "LpBranchPredictorFlushes",
> +#if IS_ENABLED(CONFIG_X86_64)
> +	[31] =3D "LpL1DataCacheFlushes",
> +	[32] =3D "LpImmediateL1DataCacheFlushes",
> +	[33] =3D "LpMbFlushes",
> +	[34] =3D "LpCounterRefreshSequenceNumber",
> +	[35] =3D "LpCounterRefreshReferenceTime",
> +	[36] =3D "LpIdleAccumulationSnapshot",
> +	[37] =3D "LpActiveTscCountSnapshot",
> +	[38] =3D "LpHwpRequestContextSwitches",
> +	[39] =3D "LpPlaceholder1",
> +	[40] =3D "LpPlaceholder2",
> +	[41] =3D "LpPlaceholder3",
> +	[42] =3D "LpPlaceholder4",
> +	[43] =3D "LpPlaceholder5",
> +	[44] =3D "LpPlaceholder6",
> +	[45] =3D "LpPlaceholder7",
> +	[46] =3D "LpPlaceholder8",
> +	[47] =3D "LpPlaceholder9",
> +	[48] =3D "LpSchLocalRunListSize",
> +	[49] =3D "LpReserveGroupId",
> +	[50] =3D "LpRunningPriority",
> +	[51] =3D "LpPerfmonInterruptCount",
> +#elif IS_ENABLED(CONFIG_ARM64)
> +	[31] =3D "LpCounterRefreshSequenceNumber",
> +	[32] =3D "LpCounterRefreshReferenceTime",
> +	[33] =3D "LpIdleAccumulationSnapshot",
> +	[34] =3D "LpActiveTscCountSnapshot",
> +	[35] =3D "LpHwpRequestContextSwitches",
> +	[36] =3D "LpPlaceholder2",
> +	[37] =3D "LpPlaceholder3",
> +	[38] =3D "LpPlaceholder4",
> +	[39] =3D "LpPlaceholder5",
> +	[40] =3D "LpPlaceholder6",
> +	[41] =3D "LpPlaceholder7",
> +	[42] =3D "LpPlaceholder8",
> +	[43] =3D "LpPlaceholder9",
> +	[44] =3D "LpSchLocalRunListSize",
> +	[45] =3D "LpReserveGroupId",
> +	[46] =3D "LpRunningPriority",
> +#endif
> +};
> +
> +/* HV_PROCESS_COUNTER */
> +static char *hv_partition_counters[] =3D {
> +	[1] =3D "PtVirtualProcessors",
> +
> +	[3] =3D "PtTlbSize",
> +	[4] =3D "PtAddressSpaces",
> +	[5] =3D "PtDepositedPages",
> +	[6] =3D "PtGpaPages",
> +	[7] =3D "PtGpaSpaceModifications",
> +	[8] =3D "PtVirtualTlbFlushEntires",
> +	[9] =3D "PtRecommendedTlbSize",
> +	[10] =3D "PtGpaPages4K",
> +	[11] =3D "PtGpaPages2M",
> +	[12] =3D "PtGpaPages1G",
> +	[13] =3D "PtGpaPages512G",
> +	[14] =3D "PtDevicePages4K",
> +	[15] =3D "PtDevicePages2M",
> +	[16] =3D "PtDevicePages1G",
> +	[17] =3D "PtDevicePages512G",
> +	[18] =3D "PtAttachedDevices",
> +	[19] =3D "PtDeviceInterruptMappings",
> +	[20] =3D "PtIoTlbFlushes",
> +	[21] =3D "PtIoTlbFlushCost",
> +	[22] =3D "PtDeviceInterruptErrors",
> +	[23] =3D "PtDeviceDmaErrors",
> +	[24] =3D "PtDeviceInterruptThrottleEvents",
> +	[25] =3D "PtSkippedTimerTicks",
> +	[26] =3D "PtPartitionId",
> +#if IS_ENABLED(CONFIG_X86_64)
> +	[27] =3D "PtNestedTlbSize",
> +	[28] =3D "PtRecommendedNestedTlbSize",
> +	[29] =3D "PtNestedTlbFreeListSize",
> +	[30] =3D "PtNestedTlbTrimmedPages",
> +	[31] =3D "PtPagesShattered",
> +	[32] =3D "PtPagesRecombined",
> +	[33] =3D "PtHwpRequestValue",
> +	[34] =3D "PtAutoSuspendEnableTime",
> +	[35] =3D "PtAutoSuspendTriggerTime",
> +	[36] =3D "PtAutoSuspendDisableTime",
> +	[37] =3D "PtPlaceholder1",
> +	[38] =3D "PtPlaceholder2",
> +	[39] =3D "PtPlaceholder3",
> +	[40] =3D "PtPlaceholder4",
> +	[41] =3D "PtPlaceholder5",
> +	[42] =3D "PtPlaceholder6",
> +	[43] =3D "PtPlaceholder7",
> +	[44] =3D "PtPlaceholder8",
> +	[45] =3D "PtHypervisorStateTransferGeneration",
> +	[46] =3D "PtNumberofActiveChildPartitions",
> +#elif IS_ENABLED(CONFIG_ARM64)
> +	[27] =3D "PtHwpRequestValue",
> +	[28] =3D "PtAutoSuspendEnableTime",
> +	[29] =3D "PtAutoSuspendTriggerTime",
> +	[30] =3D "PtAutoSuspendDisableTime",
> +	[31] =3D "PtPlaceholder1",
> +	[32] =3D "PtPlaceholder2",
> +	[33] =3D "PtPlaceholder3",
> +	[34] =3D "PtPlaceholder4",
> +	[35] =3D "PtPlaceholder5",
> +	[36] =3D "PtPlaceholder6",
> +	[37] =3D "PtPlaceholder7",
> +	[38] =3D "PtPlaceholder8",
> +	[39] =3D "PtHypervisorStateTransferGeneration",
> +	[40] =3D "PtNumberofActiveChildPartitions",
> +#endif
> +};
> +
> +/* HV_THREAD_COUNTER */
> +static char *hv_vp_counters[] =3D {
> +	[1] =3D "VpTotalRunTime",
> +	[2] =3D "VpHypervisorRunTime",
> +	[3] =3D "VpRemoteNodeRunTime",
> +	[4] =3D "VpNormalizedRunTime",
> +	[5] =3D "VpIdealCpu",
> +
> +	[7] =3D "VpHypercallsCount",
> +	[8] =3D "VpHypercallsTime",
> +#if IS_ENABLED(CONFIG_X86_64)
> +	[9] =3D "VpPageInvalidationsCount",
> +	[10] =3D "VpPageInvalidationsTime",
> +	[11] =3D "VpControlRegisterAccessesCount",
> +	[12] =3D "VpControlRegisterAccessesTime",
> +	[13] =3D "VpIoInstructionsCount",
> +	[14] =3D "VpIoInstructionsTime",
> +	[15] =3D "VpHltInstructionsCount",
> +	[16] =3D "VpHltInstructionsTime",
> +	[17] =3D "VpMwaitInstructionsCount",
> +	[18] =3D "VpMwaitInstructionsTime",
> +	[19] =3D "VpCpuidInstructionsCount",
> +	[20] =3D "VpCpuidInstructionsTime",
> +	[21] =3D "VpMsrAccessesCount",
> +	[22] =3D "VpMsrAccessesTime",
> +	[23] =3D "VpOtherInterceptsCount",
> +	[24] =3D "VpOtherInterceptsTime",
> +	[25] =3D "VpExternalInterruptsCount",
> +	[26] =3D "VpExternalInterruptsTime",
> +	[27] =3D "VpPendingInterruptsCount",
> +	[28] =3D "VpPendingInterruptsTime",
> +	[29] =3D "VpEmulatedInstructionsCount",
> +	[30] =3D "VpEmulatedInstructionsTime",
> +	[31] =3D "VpDebugRegisterAccessesCount",
> +	[32] =3D "VpDebugRegisterAccessesTime",
> +	[33] =3D "VpPageFaultInterceptsCount",
> +	[34] =3D "VpPageFaultInterceptsTime",
> +	[35] =3D "VpGuestPageTableMaps",
> +	[36] =3D "VpLargePageTlbFills",
> +	[37] =3D "VpSmallPageTlbFills",
> +	[38] =3D "VpReflectedGuestPageFaults",
> +	[39] =3D "VpApicMmioAccesses",
> +	[40] =3D "VpIoInterceptMessages",
> +	[41] =3D "VpMemoryInterceptMessages",
> +	[42] =3D "VpApicEoiAccesses",
> +	[43] =3D "VpOtherMessages",
> +	[44] =3D "VpPageTableAllocations",
> +	[45] =3D "VpLogicalProcessorMigrations",
> +	[46] =3D "VpAddressSpaceEvictions",
> +	[47] =3D "VpAddressSpaceSwitches",
> +	[48] =3D "VpAddressDomainFlushes",
> +	[49] =3D "VpAddressSpaceFlushes",
> +	[50] =3D "VpGlobalGvaRangeFlushes",
> +	[51] =3D "VpLocalGvaRangeFlushes",
> +	[52] =3D "VpPageTableEvictions",
> +	[53] =3D "VpPageTableReclamations",
> +	[54] =3D "VpPageTableResets",
> +	[55] =3D "VpPageTableValidations",
> +	[56] =3D "VpApicTprAccesses",
> +	[57] =3D "VpPageTableWriteIntercepts",
> +	[58] =3D "VpSyntheticInterrupts",
> +	[59] =3D "VpVirtualInterrupts",
> +	[60] =3D "VpApicIpisSent",
> +	[61] =3D "VpApicSelfIpisSent",
> +	[62] =3D "VpGpaSpaceHypercalls",
> +	[63] =3D "VpLogicalProcessorHypercalls",
> +	[64] =3D "VpLongSpinWaitHypercalls",
> +	[65] =3D "VpOtherHypercalls",
> +	[66] =3D "VpSyntheticInterruptHypercalls",
> +	[67] =3D "VpVirtualInterruptHypercalls",
> +	[68] =3D "VpVirtualMmuHypercalls",
> +	[69] =3D "VpVirtualProcessorHypercalls",
> +	[70] =3D "VpHardwareInterrupts",
> +	[71] =3D "VpNestedPageFaultInterceptsCount",
> +	[72] =3D "VpNestedPageFaultInterceptsTime",
> +	[73] =3D "VpPageScans",
> +	[74] =3D "VpLogicalProcessorDispatches",
> +	[75] =3D "VpWaitingForCpuTime",
> +	[76] =3D "VpExtendedHypercalls",
> +	[77] =3D "VpExtendedHypercallInterceptMessages",
> +	[78] =3D "VpMbecNestedPageTableSwitches",
> +	[79] =3D "VpOtherReflectedGuestExceptions",
> +	[80] =3D "VpGlobalIoTlbFlushes",
> +	[81] =3D "VpGlobalIoTlbFlushCost",
> +	[82] =3D "VpLocalIoTlbFlushes",
> +	[83] =3D "VpLocalIoTlbFlushCost",
> +	[84] =3D "VpHypercallsForwardedCount",
> +	[85] =3D "VpHypercallsForwardingTime",
> +	[86] =3D "VpPageInvalidationsForwardedCount",
> +	[87] =3D "VpPageInvalidationsForwardingTime",
> +	[88] =3D "VpControlRegisterAccessesForwardedCount",
> +	[89] =3D "VpControlRegisterAccessesForwardingTime",
> +	[90] =3D "VpIoInstructionsForwardedCount",
> +	[91] =3D "VpIoInstructionsForwardingTime",
> +	[92] =3D "VpHltInstructionsForwardedCount",
> +	[93] =3D "VpHltInstructionsForwardingTime",
> +	[94] =3D "VpMwaitInstructionsForwardedCount",
> +	[95] =3D "VpMwaitInstructionsForwardingTime",
> +	[96] =3D "VpCpuidInstructionsForwardedCount",
> +	[97] =3D "VpCpuidInstructionsForwardingTime",
> +	[98] =3D "VpMsrAccessesForwardedCount",
> +	[99] =3D "VpMsrAccessesForwardingTime",
> +	[100] =3D "VpOtherInterceptsForwardedCount",
> +	[101] =3D "VpOtherInterceptsForwardingTime",
> +	[102] =3D "VpExternalInterruptsForwardedCount",
> +	[103] =3D "VpExternalInterruptsForwardingTime",
> +	[104] =3D "VpPendingInterruptsForwardedCount",
> +	[105] =3D "VpPendingInterruptsForwardingTime",
> +	[106] =3D "VpEmulatedInstructionsForwardedCount",
> +	[107] =3D "VpEmulatedInstructionsForwardingTime",
> +	[108] =3D "VpDebugRegisterAccessesForwardedCount",
> +	[109] =3D "VpDebugRegisterAccessesForwardingTime",
> +	[110] =3D "VpPageFaultInterceptsForwardedCount",
> +	[111] =3D "VpPageFaultInterceptsForwardingTime",
> +	[112] =3D "VpVmclearEmulationCount",
> +	[113] =3D "VpVmclearEmulationTime",
> +	[114] =3D "VpVmptrldEmulationCount",
> +	[115] =3D "VpVmptrldEmulationTime",
> +	[116] =3D "VpVmptrstEmulationCount",
> +	[117] =3D "VpVmptrstEmulationTime",
> +	[118] =3D "VpVmreadEmulationCount",
> +	[119] =3D "VpVmreadEmulationTime",
> +	[120] =3D "VpVmwriteEmulationCount",
> +	[121] =3D "VpVmwriteEmulationTime",
> +	[122] =3D "VpVmxoffEmulationCount",
> +	[123] =3D "VpVmxoffEmulationTime",
> +	[124] =3D "VpVmxonEmulationCount",
> +	[125] =3D "VpVmxonEmulationTime",
> +	[126] =3D "VpNestedVMEntriesCount",
> +	[127] =3D "VpNestedVMEntriesTime",
> +	[128] =3D "VpNestedSLATSoftPageFaultsCount",
> +	[129] =3D "VpNestedSLATSoftPageFaultsTime",
> +	[130] =3D "VpNestedSLATHardPageFaultsCount",
> +	[131] =3D "VpNestedSLATHardPageFaultsTime",
> +	[132] =3D "VpInvEptAllContextEmulationCount",
> +	[133] =3D "VpInvEptAllContextEmulationTime",
> +	[134] =3D "VpInvEptSingleContextEmulationCount",
> +	[135] =3D "VpInvEptSingleContextEmulationTime",
> +	[136] =3D "VpInvVpidAllContextEmulationCount",
> +	[137] =3D "VpInvVpidAllContextEmulationTime",
> +	[138] =3D "VpInvVpidSingleContextEmulationCount",
> +	[139] =3D "VpInvVpidSingleContextEmulationTime",
> +	[140] =3D "VpInvVpidSingleAddressEmulationCount",
> +	[141] =3D "VpInvVpidSingleAddressEmulationTime",
> +	[142] =3D "VpNestedTlbPageTableReclamations",
> +	[143] =3D "VpNestedTlbPageTableEvictions",
> +	[144] =3D "VpFlushGuestPhysicalAddressSpaceHypercalls",
> +	[145] =3D "VpFlushGuestPhysicalAddressListHypercalls",
> +	[146] =3D "VpPostedInterruptNotifications",
> +	[147] =3D "VpPostedInterruptScans",
> +	[148] =3D "VpTotalCoreRunTime",
> +	[149] =3D "VpMaximumRunTime",
> +	[150] =3D "VpHwpRequestContextSwitches",
> +	[151] =3D "VpWaitingForCpuTimeBucket0",
> +	[152] =3D "VpWaitingForCpuTimeBucket1",
> +	[153] =3D "VpWaitingForCpuTimeBucket2",
> +	[154] =3D "VpWaitingForCpuTimeBucket3",
> +	[155] =3D "VpWaitingForCpuTimeBucket4",
> +	[156] =3D "VpWaitingForCpuTimeBucket5",
> +	[157] =3D "VpWaitingForCpuTimeBucket6",
> +	[158] =3D "VpVmloadEmulationCount",
> +	[159] =3D "VpVmloadEmulationTime",
> +	[160] =3D "VpVmsaveEmulationCount",
> +	[161] =3D "VpVmsaveEmulationTime",
> +	[162] =3D "VpGifInstructionEmulationCount",
> +	[163] =3D "VpGifInstructionEmulationTime",
> +	[164] =3D "VpEmulatedErrataSvmInstructions",
> +	[165] =3D "VpPlaceholder1",
> +	[166] =3D "VpPlaceholder2",
> +	[167] =3D "VpPlaceholder3",
> +	[168] =3D "VpPlaceholder4",
> +	[169] =3D "VpPlaceholder5",
> +	[170] =3D "VpPlaceholder6",
> +	[171] =3D "VpPlaceholder7",
> +	[172] =3D "VpPlaceholder8",
> +	[173] =3D "VpContentionTime",
> +	[174] =3D "VpWakeUpTime",
> +	[175] =3D "VpSchedulingPriority",
> +	[176] =3D "VpRdpmcInstructionsCount",
> +	[177] =3D "VpRdpmcInstructionsTime",
> +	[178] =3D "VpPerfmonPmuMsrAccessesCount",
> +	[179] =3D "VpPerfmonLbrMsrAccessesCount",
> +	[180] =3D "VpPerfmonIptMsrAccessesCount",
> +	[181] =3D "VpPerfmonInterruptCount",
> +	[182] =3D "VpVtl1DispatchCount",
> +	[183] =3D "VpVtl2DispatchCount",
> +	[184] =3D "VpVtl2DispatchBucket0",
> +	[185] =3D "VpVtl2DispatchBucket1",
> +	[186] =3D "VpVtl2DispatchBucket2",
> +	[187] =3D "VpVtl2DispatchBucket3",
> +	[188] =3D "VpVtl2DispatchBucket4",
> +	[189] =3D "VpVtl2DispatchBucket5",
> +	[190] =3D "VpVtl2DispatchBucket6",
> +	[191] =3D "VpVtl1RunTime",
> +	[192] =3D "VpVtl2RunTime",
> +	[193] =3D "VpIommuHypercalls",
> +	[194] =3D "VpCpuGroupHypercalls",
> +	[195] =3D "VpVsmHypercalls",
> +	[196] =3D "VpEventLogHypercalls",
> +	[197] =3D "VpDeviceDomainHypercalls",
> +	[198] =3D "VpDepositHypercalls",
> +	[199] =3D "VpSvmHypercalls",
> +	[200] =3D "VpBusLockAcquisitionCount",
> +	[201] =3D "VpLoadAvg",
> +	[202] =3D "VpRootDispatchThreadBlocked",
> +	[203] =3D "VpIdleCpuTime",
> +	[204] =3D "VpWaitingForCpuTimeBucket7",
> +	[205] =3D "VpWaitingForCpuTimeBucket8",
> +	[206] =3D "VpWaitingForCpuTimeBucket9",
> +	[207] =3D "VpWaitingForCpuTimeBucket10",
> +	[208] =3D "VpWaitingForCpuTimeBucket11",
> +	[209] =3D "VpWaitingForCpuTimeBucket12",
> +	[210] =3D "VpHierarchicalSuspendTime",
> +	[211] =3D "VpExpressSchedulingAttempts",
> +	[212] =3D "VpExpressSchedulingCount",
> +#elif IS_ENABLED(CONFIG_ARM64)
> +	[9] =3D "VpSysRegAccessesCount",
> +	[10] =3D "VpSysRegAccessesTime",
> +	[11] =3D "VpSmcInstructionsCount",
> +	[12] =3D "VpSmcInstructionsTime",
> +	[13] =3D "VpOtherInterceptsCount",
> +	[14] =3D "VpOtherInterceptsTime",
> +	[15] =3D "VpExternalInterruptsCount",
> +	[16] =3D "VpExternalInterruptsTime",
> +	[17] =3D "VpPendingInterruptsCount",
> +	[18] =3D "VpPendingInterruptsTime",
> +	[19] =3D "VpGuestPageTableMaps",
> +	[20] =3D "VpLargePageTlbFills",
> +	[21] =3D "VpSmallPageTlbFills",
> +	[22] =3D "VpReflectedGuestPageFaults",
> +	[23] =3D "VpMemoryInterceptMessages",
> +	[24] =3D "VpOtherMessages",
> +	[25] =3D "VpLogicalProcessorMigrations",
> +	[26] =3D "VpAddressDomainFlushes",
> +	[27] =3D "VpAddressSpaceFlushes",
> +	[28] =3D "VpSyntheticInterrupts",
> +	[29] =3D "VpVirtualInterrupts",
> +	[30] =3D "VpApicSelfIpisSent",
> +	[31] =3D "VpGpaSpaceHypercalls",
> +	[32] =3D "VpLogicalProcessorHypercalls",
> +	[33] =3D "VpLongSpinWaitHypercalls",
> +	[34] =3D "VpOtherHypercalls",
> +	[35] =3D "VpSyntheticInterruptHypercalls",
> +	[36] =3D "VpVirtualInterruptHypercalls",
> +	[37] =3D "VpVirtualMmuHypercalls",
> +	[38] =3D "VpVirtualProcessorHypercalls",
> +	[39] =3D "VpHardwareInterrupts",
> +	[40] =3D "VpNestedPageFaultInterceptsCount",
> +	[41] =3D "VpNestedPageFaultInterceptsTime",
> +	[42] =3D "VpLogicalProcessorDispatches",
> +	[43] =3D "VpWaitingForCpuTime",
> +	[44] =3D "VpExtendedHypercalls",
> +	[45] =3D "VpExtendedHypercallInterceptMessages",
> +	[46] =3D "VpMbecNestedPageTableSwitches",
> +	[47] =3D "VpOtherReflectedGuestExceptions",
> +	[48] =3D "VpGlobalIoTlbFlushes",
> +	[49] =3D "VpGlobalIoTlbFlushCost",
> +	[50] =3D "VpLocalIoTlbFlushes",
> +	[51] =3D "VpLocalIoTlbFlushCost",
> +	[52] =3D "VpFlushGuestPhysicalAddressSpaceHypercalls",
> +	[53] =3D "VpFlushGuestPhysicalAddressListHypercalls",
> +	[54] =3D "VpPostedInterruptNotifications",
> +	[55] =3D "VpPostedInterruptScans",
> +	[56] =3D "VpTotalCoreRunTime",
> +	[57] =3D "VpMaximumRunTime",
> +	[58] =3D "VpWaitingForCpuTimeBucket0",
> +	[59] =3D "VpWaitingForCpuTimeBucket1",
> +	[60] =3D "VpWaitingForCpuTimeBucket2",
> +	[61] =3D "VpWaitingForCpuTimeBucket3",
> +	[62] =3D "VpWaitingForCpuTimeBucket4",
> +	[63] =3D "VpWaitingForCpuTimeBucket5",
> +	[64] =3D "VpWaitingForCpuTimeBucket6",
> +	[65] =3D "VpHwpRequestContextSwitches",
> +	[66] =3D "VpPlaceholder2",
> +	[67] =3D "VpPlaceholder3",
> +	[68] =3D "VpPlaceholder4",
> +	[69] =3D "VpPlaceholder5",
> +	[70] =3D "VpPlaceholder6",
> +	[71] =3D "VpPlaceholder7",
> +	[72] =3D "VpPlaceholder8",
> +	[73] =3D "VpContentionTime",
> +	[74] =3D "VpWakeUpTime",
> +	[75] =3D "VpSchedulingPriority",
> +	[76] =3D "VpVtl1DispatchCount",
> +	[77] =3D "VpVtl2DispatchCount",
> +	[78] =3D "VpVtl2DispatchBucket0",
> +	[79] =3D "VpVtl2DispatchBucket1",
> +	[80] =3D "VpVtl2DispatchBucket2",
> +	[81] =3D "VpVtl2DispatchBucket3",
> +	[82] =3D "VpVtl2DispatchBucket4",
> +	[83] =3D "VpVtl2DispatchBucket5",
> +	[84] =3D "VpVtl2DispatchBucket6",
> +	[85] =3D "VpVtl1RunTime",
> +	[86] =3D "VpVtl2RunTime",
> +	[87] =3D "VpIommuHypercalls",
> +	[88] =3D "VpCpuGroupHypercalls",
> +	[89] =3D "VpVsmHypercalls",
> +	[90] =3D "VpEventLogHypercalls",
> +	[91] =3D "VpDeviceDomainHypercalls",
> +	[92] =3D "VpDepositHypercalls",
> +	[93] =3D "VpSvmHypercalls",
> +	[94] =3D "VpLoadAvg",
> +	[95] =3D "VpRootDispatchThreadBlocked",
> +	[96] =3D "VpIdleCpuTime",
> +	[97] =3D "VpWaitingForCpuTimeBucket7",
> +	[98] =3D "VpWaitingForCpuTimeBucket8",
> +	[99] =3D "VpWaitingForCpuTimeBucket9",
> +	[100] =3D "VpWaitingForCpuTimeBucket10",
> +	[101] =3D "VpWaitingForCpuTimeBucket11",
> +	[102] =3D "VpWaitingForCpuTimeBucket12",
> +	[103] =3D "VpHierarchicalSuspendTime",
> +	[104] =3D "VpExpressSchedulingAttempts",
> +	[105] =3D "VpExpressSchedulingCount",
> +#endif
> +};
> --
> 2.34.1


