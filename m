Return-Path: <linux-hyperv+bounces-3678-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CDDDA0FEE6
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Jan 2025 03:43:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5989B18862A3
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Jan 2025 02:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D316230276;
	Tue, 14 Jan 2025 02:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="AEkMyc+c"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azolkn19011024.outbound.protection.outlook.com [52.103.12.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C16B230998;
	Tue, 14 Jan 2025 02:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.12.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736822617; cv=fail; b=PFveEvmsVV2RufRtc3gPdb4dZa+vw13O5R6LrUra7OftTDKX+D4sG88rUedEu5Dw+KPfA+oPzIcv3kxOPrqzmlTaKUdIppEV63q+8gx8XpANA3r5EgWQONrRI1u9TUMRT/NKcYZIhrBWZoXtfSICyDmGaH1q40VlDGAJZNmRTg4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736822617; c=relaxed/simple;
	bh=VbLyvUrgZ1XIPQNv97g/SOApuomBPYCLZDNHNq6ojDU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qvIAhajagFRVyZmQP64nSbVk0HABgcZZ7JxqZVH2D8EKogokOnNqqyOy9pMyOFghFqBCVA1hV33osev6iMWEY3Gul/rdAFruw4yqCwfaYdpX47RPiUe13eLdHWAgfxJQbTx4Qpa7qIPqSG7W3cM1e5puY6iOmMFCZBqNJBWAomo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=AEkMyc+c; arc=fail smtp.client-ip=52.103.12.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rnsavg+vmvZAErIsukPr/gVBe3AhHVQE7bADEmy6bJszgMXqrZfJEg0Q9eMmCwguiTR/Fr3y5hZGW5qiVRG7+sxs5wsM3i9O6gMi1+SHEl7u3cxWpk90BYfwkKG0Z/OYXrcHNc3pClD0eK+Mpr129Ks7qFQyXSQr7qs2ah8g7JsR85U6ESko44saVKwd0MTvIXRKGdOVuMBogt8qucvukf7vaTAbZeM/UHp0brX2QB8HNF6fN6VfBH7Q3NpqOyMBY/Pg5Mj8lARkYranFcflA3IcUxtbeWa0x7SpTymYfUl/U4V5z5QrkMnNlU9uDjo+wfrUz2orNKUzN2fkujLMfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qk8wW+6lLLYxvLKdOyCd8i7SYzCjYKmllgAGlyNNWe0=;
 b=S9pG//4ajp3I28/V3pLqc51vm4ytx1nk/eUY8Vrpm9Ry+tv9UgiNzgHUldUXbPFBe0dAeLbypLYGjXxWIRIeEisNFQ5sVkiFv8QMOJ7sbogBSukWoA7yU77m22L5+XlAxdlSz0AocbQi0fit5IQWnc3yzIBJMqsM48dz8JLLf2uyjylehhm6FKKmnuZvS9jYOfd+RJLk/TX0CeKU8TtTjsqzTTjOpFR8TkTiLespzSgjSD/k7wuwPM52W37gjNboqXKWsgJUNJdmJz8ZD1soVueTIXjx7GhoF9nTe6w4aZl5dF5KgzioJdVRcvSS4l7G0XJmQHxjzmxYnwTCWuihEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qk8wW+6lLLYxvLKdOyCd8i7SYzCjYKmllgAGlyNNWe0=;
 b=AEkMyc+cKG9J2Y3ePeJ6Fimum9rXir6K45Q33HAaXqw6tylI+5fgNEA1VaA21QvktkKV+HRwkM/AETpV7suko9Zi1dlTn0q8/zGvj1fM/jkX1h6ON5XY1KosJLU5hJCAc7bWrcKHLOMvvhTyOzcd6ulSReuDgtbKXOLGJjm3Dyz1RVYJWtOaNxdYlwfJFthp+eUtWTaHsPt7tmBlkN39YLyqe75KtVYbTvzZ8Eg8hmjs7aluPiY/zkZo53vujPKKOco07S/kvkkbBZRRNep/r1wHCVj6/HVb/EcOhMCh+YRYJLmOzDmeo+38FR5n8rF4D3JCrnwlZln7sDrkwzXqCQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CH3PR02MB10464.namprd02.prod.outlook.com (2603:10b6:610:206::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Tue, 14 Jan
 2025 02:43:33 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8335.017; Tue, 14 Jan 2025
 02:43:33 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
CC: Boqun Feng <boqun.feng@gmail.com>, Wei Liu <wei.liu@kernel.org>, "K. Y.
 Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 2/2] drivers/hv: add CPU offlining support
Thread-Topic: [PATCH v2 2/2] drivers/hv: add CPU offlining support
Thread-Index: AQHbY6sXkGWI1+MW60mlhk/nGWrisLMVSbig
Date: Tue, 14 Jan 2025 02:43:33 +0000
Message-ID:
 <SN6PR02MB4157906A4E40E416D61AFEEBD4182@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250110215951.175514-1-hamzamahfooz@linux.microsoft.com>
 <20250110215951.175514-2-hamzamahfooz@linux.microsoft.com>
In-Reply-To: <20250110215951.175514-2-hamzamahfooz@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CH3PR02MB10464:EE_
x-ms-office365-filtering-correlation-id: 75930747-ec33-48b5-5ad2-08dd34453ca5
x-ms-exchange-slblob-mailprops:
 vuaKsetfIZkOVoj0UqpnLtxcZHTVbEDrqHxMdGcV/Zpuf9TxHE65np5npPsjUvsaNgxBigzRq9ZsWELkh2NcWEBSWs5dpmra+dasoiYdXwI3ftSr9eo8tJk5tvm1D+o7rfN+KhuCAIA966/IaO4h7FzXwqRTQOKHt5m2Mcp44PiUyyqFOSlM9mZTKKimt+kqUV1vwpjFTyrrkqZeHjl8VXAmrRxBo5C2hbgKa4BFjEqEgsznQFRu3ZK8+kIMUmjlFohstlXaPlZeE1gGTETF9vsbsWXuAVatBWsOoTo2//gNfJxY4thlj8jNNB+BtrI9ZlY1v9XcdUWi5o+UCIQp81nJP/Q9lVhCil5OlT9ji7eIeg/UMJz6jseuOKFUYzukoEqIWyLgJ0G3LehE+bqd6bqW31mB2xmJm071Ey3sGYWYWc1DPWhe6+WfXskv5XqwXMMQlFPaBcBU22TGENm9I80wbXkSeD0cUpUgJArRG8YU7wUnk30qHNnzGRAUA8zt2gwkblS66XXKQcD62hCVdNKGCLqXD9PiJNjvD/6Ev2BcAajd7fNkfJbC1glxUDiZvmXEQPMrZqO02p2Gdu1cpxIQFR0OP5ppXdKqLezYtP9JSiZgjlbnf/pEZXpjTJkFDK+Uz3ilAP8GV4tyLzzd7dVbe1MtbpbeIPwCFue1GtXpPuu0XY0qBBayRfWdXWq7DewNfl9ghkJaDyHcP5IpvdVUiht8RaO1VwonAfLW+ERKnQ/0PdUMYj2311jFCgxN7Yut5jjpQdeqhrlpmAD/Jx+8C+06yct3A2nmUfgbZJDitVRRfg92TaeEPxm8TIDX
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599003|15080799006|8060799006|19110799003|461199028|10035399004|4302099013|440099028|102099032|3412199025|1602099012;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?oDm+nq3SY7qk8f7Lv6NQUqrGVpQnyoNkhu/RHr00bh3rxE7ycQfF8zw2lenx?=
 =?us-ascii?Q?Fr7lPNtWqMDs8Yy1Ub0nztxuyV+MukNlaw01guxq8im8yf70DWh+UNvhA2P8?=
 =?us-ascii?Q?UHZmzQySGUBDphF3CLoydfOdjCRO/R/VCbcHXS/RwthsjebFk6bhLUJjUN3k?=
 =?us-ascii?Q?+JWYjZNfULIds+Jek4M0ACu5TXvcWFcZpxnWyd4qL3ilMrAWDH0nefdb/QjU?=
 =?us-ascii?Q?23jGp9L4xWRohT0w2r5Q5Lj43PpifZSqgR3RfCylGxkQpBiTkH32IQvKL89k?=
 =?us-ascii?Q?upR4MY6EKBivdI44QfSyfbUBOyDv6PePDAREsgxHYBnYByLSJiX0huJeDHfQ?=
 =?us-ascii?Q?0qyrJ1f6LrNUa4lfbwIQj/rrAiX33H6Yv4LfbDDwevkS1l3pfz5z12Caedf0?=
 =?us-ascii?Q?wKlNKVmp5E1ZEy6dRIoCCGfvlZnZ4p6bNlMQRwqAy9bpggipIM1YBiJSVP3j?=
 =?us-ascii?Q?iUfGBUTp5dpdk8kXYHBNcKpgIhapRzeDQqYZ1lLG68Rp4zUSw/ZS+EQeHkTS?=
 =?us-ascii?Q?16SCnVTxjDPky9Dw6gyXbMppfGRksIPs2uPXo4ruqvA3PzmsKi61X5l4ZeFH?=
 =?us-ascii?Q?jJ75NhIcOATTOh51ydwb+AuhgIp7+Utk6f915YU663rLchvrZIhjbT5XSTSj?=
 =?us-ascii?Q?UpGux/dVgRfjViilrq4iVg2Ruun7oDcL6zRpeIM0rp1/TjgAgemsAOi8HELZ?=
 =?us-ascii?Q?DuyMrO8dxQMX/Rx2IJIcw5fMYoNWRAIsNtshF1OOAL6qpvmBdnLqCqSuVM3K?=
 =?us-ascii?Q?VxLp/36gvt5Hk70UKVT6h+/y7Q7eQNhiRYL+Pf35ngx4W3xYYANb7zc7xJey?=
 =?us-ascii?Q?hjOiRufd2plX04i82wKOEvt+exGCl+87BVP43AS6+NUs5w7Q8hH0v4oOzhHv?=
 =?us-ascii?Q?1v7YCq0e/Qw/dzfjRtTGR24fSl+OcZbZXjNEuVxj9yvB1QcuuOjE3XkhoLNl?=
 =?us-ascii?Q?0olqtOrlbGUIjBEH47QTS0bcjyca5UgeJwmmFgLn6+hzj2RFmvPwKoCexxdO?=
 =?us-ascii?Q?h9m3ECabMXhlNg1jlviekfR8lfsLnUQ0Fm/sF+ExqUEEaqxzygzkHKkTyPzV?=
 =?us-ascii?Q?kTp9Om/0xftYmJEDAW4c36Fml8S8rEzDvSqnOe4736bWKD87Uao3vJAKyhed?=
 =?us-ascii?Q?kvGVpnERnzeg0aH4DIPZpaQNO0kRZsv1v7p8APoY5jEOdoM2TeaMWVqyv+2p?=
 =?us-ascii?Q?6DZmjqMHJlj97PDh7GdTlH4mTujCRubOIQabZaeWh3394JunwlqpEXkEhDY?=
 =?us-ascii?Q?=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ftiO7q5Qh/15vBf7ADQDH+Lw20FnsBDGXc19n5vuJFFVnbdzMTUc8MAoirm6?=
 =?us-ascii?Q?NmW8u1foTP0u4XovEb87hOc6nt3Cq+kjQv4xuI89QNZefL14Jl0E8Au4ei4M?=
 =?us-ascii?Q?EQf/bMyZ1hMWHKYZtF5Fn5hp79KyLfYiFeYtAx+7wtIsrVpKkisHiHZ8ikSH?=
 =?us-ascii?Q?JeUy1tI50JsxIFvfBnDRbQKvpAIcy84YcGEelUvj5dH7qwQHnB2GSv3G2FS9?=
 =?us-ascii?Q?Kz+9MeTfNgtc9k8wzqhgZH4jr9NIk5AH2X26L7V4FB1X9n54dX5szdyRYvy5?=
 =?us-ascii?Q?QEx4aizvMcZnR+KQbIOYB/jnI00tsZSsVSs4YsaukRmhzRXV5+8BqwJLmp+o?=
 =?us-ascii?Q?vDhvdwj+Qp2M0eYzO6xFMGUINBqZmYHXL3bBy3aEmEA2zMUg3v3T8L7Po5nt?=
 =?us-ascii?Q?Xma3yz5kTqjtdg/LchvRIKJV258sFsUjBOiY+Uz5AH8v2NUHrkp7WQYkVHqy?=
 =?us-ascii?Q?4MHGk2BlY1Z9CYVFa5mnZ6NIiBNb6jS7Ys2O9HOrAflfAuHl8Bb2smA753mt?=
 =?us-ascii?Q?I2CqPWAzt/wnJJXdZ7lOVRsY+P5tKxUgmGu50lqR/B1uFc9znrCoLwWgfOk+?=
 =?us-ascii?Q?nFusdrSzLRTJA8CJCvsD5tSsH8ZXHPJQ+11F5ZayNnCYGIq5+YXIJzdYdYFF?=
 =?us-ascii?Q?IYxT8mDm6NxVXnrSjXHKpUVlPD/048RIm6Hq1VgTZVst570cTvoQYeDoMK5U?=
 =?us-ascii?Q?VE603lQqIJ84UCNNf6+gztnzRS3c/SaTizBkfolJct6VKxLiioadcQwODgvW?=
 =?us-ascii?Q?XoRKqwy06XbNGE8RjMnGy0j5/5hRKjsuyFqiV0YWK0PyVQByPpW0+Q4i2Qd+?=
 =?us-ascii?Q?YqqAE/jClkyD5PkQjbq6/8hVBYH03d3QuZ3eGlaa+J6YtM+HjDJAK95CqBSu?=
 =?us-ascii?Q?guuwUIOP4Bmzz1JNRuQ4VmeVZYwOD3uB9L9OwOgcIxjHKQrxiwLBOZS8vxT9?=
 =?us-ascii?Q?jYJKAELWbmALv+zY6St/9wO1slfsHYbQ3O63p/Kpky5S0AazbHbihew92gE/?=
 =?us-ascii?Q?zjqKGqLg4wsTwu49EHUJ/vvypGtZ2/1WYsUO0f80PHmniCwWIf6EYppQzgoA?=
 =?us-ascii?Q?if4FYBUyIx+4+keo+bpYjaBlltnAcVG52CEJxKMw35J1SAeu6iaqhqa8xSS7?=
 =?us-ascii?Q?NOCiXpvTRawG4SO61Upxm1R85/oua+DqW+nyBM+QF8Va403I7ET/ID7R0pen?=
 =?us-ascii?Q?m+v4zEMpDJIyLAvfUg8J/le5+nqeYK9MQuoXEWHwDnS5pkv+H02LxxD0fGA?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 75930747-ec33-48b5-5ad2-08dd34453ca5
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2025 02:43:33.1288
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB10464

From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com> Sent: Friday, Januar=
y 10, 2025 2:00 PM
>=20
> Currently, it is effectively impossible to offline CPUs. Since, most
> CPUs will have vmbus channels attached to them. So, as made mention of
> in commit d570aec0f2154 ("Drivers: hv: vmbus: Synchronize
> init_vp_index() vs. CPU hotplug"), rebind channels associated with CPUs
> that a user is trying to offline to a new "randomly" selected CPU.

Let me provide some additional context and thoughts about the new
functionality proposed in this patch set.

1. I would somewhat challenge the commit message statement that
"it is effectively impossible to offline CPUs". VMBus device interrupts
can be assigned to a different CPU via a /sys interface and the code
in target_cpu_store().  So a CPU *can* be taken offline by first reassignin=
g
any VMBus device interrupts, and then the offlining operation will succeed.
That reassigning requires manual sysadmin actions or some scripting,
which isn't super easy or automatic, but it's not "effectively impossible".

2. As background, when a CPU goes offline, the Linux kernel already has
functionality to reassign unmanaged IRQs that are assigned to the CPU
going offline.  (Managed IRQs are just shut down.)  See fixup_irqs().
Unfortunately, VMBus device interrupts are not modelled as Linux IRQs,
so the existing mechanism is not applied to VMBus devices.

3. In light of #2 and for other reasons, I submitted a patch set in June 20=
24
that models VMBus device interrupts as Linux IRQs. See [1]. This patch set
got feedback from Thomas Gleixner about how to demultiplex the IRQs, but
no one from Microsoft gave feedback on the overall idea. I think it would
be worthwhile to pursue these patches, but I would like to get some
macro-level thoughts from the Microsoft folks. There are implications for
things such as irqbalance.

4. As the cover letter in my patch set notes, there's still a problem with
the automatic Linux IRQ reassignment mechanism for the new VMBus IRQs.
The cover letter doesn't give full details, but the problem is ultimately d=
ue
to needing to get an ack from Hyper-V that the change in VMBus device
interrupt assignment has been completed. I have investigated alternatives
for making it work, but they are all somewhat convoluted. Nevertheless,
if we want to move forward with the patch set, further work on these
alternatives would be warranted.

5. In May 2020, Andrea Parri worked on a patch set that does what this
patch set does -- automatically reassign VMBus device interrupts when
a CPU tries to go offline. That patch set took a broader focus on making a
smart decision about the CPU to which to assign the interrupt in several
different circumstances, one of which was offlining a CPU. It was
somewhat complex and posted as an RFC [2]. I think Andrea ended up
having to work on some other things, and the patch set was not pursued
after the initial posting. It might be worthwhile to review it for comparis=
on
purposes, or maybe it's worth reviving.

All of that is to say that I think there are two paths forward:

A. The quicker fix is to take the approach of this patch set and continue
handling VMBus device interrupts outside of the Linux IRQ mechanism.
Do the automatic reassignment when taking a CPU offline, as coded
in this patch. Andrea Parri's old patch set might have something to add
to this approach, if just for comparison purposes.

B. Take a broader look at the problem by going back to my patch set
that models VMBus device interrupts as Linux IRQs. Work to get
the existing Linux IRQ reassignment mechanism to work for the new
VMBus IRQs. This approach will probably take longer than (A).

I lean toward (B) because it converges with standard Linux IRQs, but I
don't know what's driving doing (A). If there's need to do (A) sooner,
see my comments in the code below. I'm less inclined to add the
complexity of Andrea Parri's old patch set because I think it takes
us even further down the path of doing custom VMBus-related
work when we would do better to converge toward existing Linux
IRQ mechanisms.

[1] https://lore.kernel.org/linux-hyperv/20240604050940.859909-1-mhklinux@o=
utlook.com/
[2] https://lore.kernel.org/linux-hyperv/20200526223218.184057-1-parri.andr=
ea@gmail.com/

>=20
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Wei Liu <wei.liu@kernel.org>
> Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
> ---
> v2: remove cpus_read_{un,}lock() from hv_pick_new_cpu() and add
>     lockdep_assert_cpus_held().
> ---
>  drivers/hv/hv.c | 56 ++++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 41 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
> index 36d9ba097ff5..9fef71403c86 100644
> --- a/drivers/hv/hv.c
> +++ b/drivers/hv/hv.c
> @@ -433,13 +433,39 @@ static bool hv_synic_event_pending(void)
>  	return pending;
>  }
>=20
> +static int hv_pick_new_cpu(struct vmbus_channel *channel,
> +			   unsigned int current_cpu)
> +{
> +	int ret =3D 0;
> +	int cpu;
> +
> +	lockdep_assert_cpus_held();
> +	lockdep_assert_held(&vmbus_connection.channel_mutex);
> +
> +	/*
> +	 * We can't assume that the relevant interrupts will be sent before
> +	 * the cpu is offlined on older versions of hyperv.
> +	 */
> +	if (vmbus_proto_version < VERSION_WIN10_V5_3)
> +		return -EBUSY;

I'm not sure why this test is here.  The function vmbus_set_channel_cpu()
tests the vmbus_proto_version against V4_1 and returns an appropriate
error. Do we *need* to filter against V5_3 instead of V4_1?

> +
> +	cpu =3D cpumask_next(get_random_u32_below(nr_cpu_ids), cpu_online_mask)=
;
> +
> +	if (cpu >=3D nr_cpu_ids || cpu =3D=3D current_cpu)
> +		cpu =3D VMBUS_CONNECT_CPU;

Picking a random CPU like this seems to have some problems:

1. The selected CPU might be an isolated CPU, in which case the
call to vmbus_channel_set_cpu() will return an error, and the
attempt to take the CPU offline will eventually fail. But if you try
again to take the CPU offline, a different random CPU may be
chosen that isn't an isolated CPU, and taking the CPU offline
will succeed. Such inconsistent behavior should be avoided.

2. I wonder if we should try to choose a CPU in the same NUMA node
as "current_cpu".  The Linux IRQ mechanism has the concept of CPU
affinity for an IRQ, which can express the NUMA affinity. The normal
Linux reassignment mechanism obeys the IRQ's affinity if possible,
and so would do the right thing for NUMA. So we need to consider
whether to do that here as well.

3. The handling of the current_cpu feels a bit hacky. There's
also no wrap-around in the mask search. Together, I think that
creates a small bias toward choosing the VMBUS_CONNECT_CPU,
which is arguably already somewhat overloaded because all the
low-speed devices use it. I haven't tried to look for alternative
approaches to suggest.

Michael

> +
> +	ret =3D vmbus_channel_set_cpu(channel, cpu);
> +
> +	return ret;
> +}
> +
>  /*
>   * hv_synic_cleanup - Cleanup routine for hv_synic_init().
>   */
>  int hv_synic_cleanup(unsigned int cpu)
>  {
>  	struct vmbus_channel *channel, *sc;
> -	bool channel_found =3D false;
> +	int ret =3D 0;
>=20
>  	if (vmbus_connection.conn_state !=3D CONNECTED)
>  		goto always_cleanup;
> @@ -456,31 +482,31 @@ int hv_synic_cleanup(unsigned int cpu)
>=20
>  	/*
>  	 * Search for channels which are bound to the CPU we're about to
> -	 * cleanup.  In case we find one and vmbus is still connected, we
> -	 * fail; this will effectively prevent CPU offlining.
> -	 *
> -	 * TODO: Re-bind the channels to different CPUs.
> +	 * cleanup.
>  	 */
>  	mutex_lock(&vmbus_connection.channel_mutex);
>  	list_for_each_entry(channel, &vmbus_connection.chn_list, listentry) {
>  		if (channel->target_cpu =3D=3D cpu) {
> -			channel_found =3D true;
> -			break;
> +			ret =3D hv_pick_new_cpu(channel, cpu);
> +
> +			if (ret) {
> +				mutex_unlock(&vmbus_connection.channel_mutex);
> +				return ret;
> +			}
>  		}
>  		list_for_each_entry(sc, &channel->sc_list, sc_list) {
>  			if (sc->target_cpu =3D=3D cpu) {
> -				channel_found =3D true;
> -				break;
> +				ret =3D hv_pick_new_cpu(channel, cpu);
> +
> +				if (ret) {
> +					mutex_unlock(&vmbus_connection.channel_mutex);
> +					return ret;
> +				}
>  			}
>  		}
> -		if (channel_found)
> -			break;
>  	}
>  	mutex_unlock(&vmbus_connection.channel_mutex);
>=20
> -	if (channel_found)
> -		return -EBUSY;
> -
>  	/*
>  	 * channel_found =3D=3D false means that any channels that were previou=
sly
>  	 * assigned to the CPU have been reassigned elsewhere with a call of
> @@ -497,5 +523,5 @@ int hv_synic_cleanup(unsigned int cpu)
>=20
>  	hv_synic_disable_regs(cpu);
>=20
> -	return 0;
> +	return ret;
>  }
> --
> 2.47.1
>=20


