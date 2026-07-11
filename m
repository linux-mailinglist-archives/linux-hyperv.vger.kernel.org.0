Return-Path: <linux-hyperv+bounces-11948-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tYvTN/qLUmoXQwMAu9opvQ
	(envelope-from <linux-hyperv+bounces-11948-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 11 Jul 2026 20:31:22 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2135F7427E6
	for <lists+linux-hyperv@lfdr.de>; Sat, 11 Jul 2026 20:31:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=outlook.com header.s=selector1 header.b=i8YdWXv7;
	dmarc=pass (policy=none) header.from=outlook.com;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11948-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11948-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E2BEB300E3A7
	for <lists+linux-hyperv@lfdr.de>; Sat, 11 Jul 2026 18:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE49246BBA;
	Sat, 11 Jul 2026 18:31:19 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazolkn19012080.outbound.protection.outlook.com [52.103.20.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8DC381C4;
	Sat, 11 Jul 2026 18:31:17 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783794679; cv=fail; b=Ju506XEDJxcwct42pqf2ggXh7HX6eMGu+mUXxQc/VzPh7BGSiCmwGTff0+d9ktGekV6xndGwTzjb8p5AQ+ygIIyU1wbN9HPxjZNuZpE8VHl31BsFpnw3ccIL74+TOlSIkGlaW7BesmQb8SKI0C4Gqev4y49sXmUZJf+9yLWnAV4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783794679; c=relaxed/simple;
	bh=mzk+nE810ZGzalmvRifw43EatL463W6Kl4sI6km3H+o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lvS4qZmRySw6i3UOME3SA10HmzYR65WU4dwP9Urj0+TXR86jfqBXkzXu4sVBAHptxCjtsPz8iK90gSRme7jZgCt1jk9m21Z2Cfjfra3NNz5TLXGUq+XgP0nMLBgsCzePL9JA2DgpR5P1uav8Y/K1OtY4qpf6i90SZ3l9TYwbPUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=i8YdWXv7; arc=fail smtp.client-ip=52.103.20.80
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SyPCkxXpDvSItvrhEQj1n7/9yH9PAP33UDYXiV5nFCIjdGCz0WrSgkshVt/2Re63/ti4nO4NVOipZiO4OncOQ+OrEDQT7d0kvJMlNNOQhp5TZzEvN5n+ARkEEZkcSwyXVb5/KQsVjucgK2knhWsqvMr0onpbP6nEhKThUV7tB+ACTLF3lI8ELWt/G8wlmM6DF+ZOyfNbegqosk8RUklU43Adoaapa8ewFkKTRXlINulUWXuUztqu0zF4joxBEIaDJ30Ij7KGjVVkRZQt37iR8EIumptowrmNagOzPidLVJ0q86b5EIQdUa3ok7O6SydhWMdp4GB0ziBV4QQv9jRYNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ptfsfjP4yaWjYKkuZsB1YC4EJyqHAhubPBCC/CPSYgI=;
 b=w0lKQCSYdnBBojB9/xyp6byPWZ6ch7xyHvfox4NKTqxlqDiFIVDYqyE36icSr2KTeEI+gdvIcwkCD9/T9ZjlkCbrVl9kixRYJZ/wjzvhXzyVJ8xPD4tmR7UyVZvrkBvHQNpLDKxtQFdnWYOg2dOU9ga10LktuSQ+yvZJfsQr8/thFq6w7lOzFfYgArf+5E4i6f5X28Fv4Rjw2Ud11oXVYfog610YGdrUYZ6Wui42rEHgZ6bTqD4+FwOq+vPIAdadS6XwiyC7sQJ+Zi0X8mw7tDMOZjfW+xNurB9VQE/TwCdUHW3chHsImYVwcVwPM9DJHe/m5gQtll3QFWJBYhMDlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ptfsfjP4yaWjYKkuZsB1YC4EJyqHAhubPBCC/CPSYgI=;
 b=i8YdWXv7IRRr0G0hsNetZTCXfQxWfSmeF3U+NwxgV13Jx35j6bKHFQGsziYhiciNYLb6OgAsfJvMU/Qg6mlhTjLjQGgKPKKXuC2+JVo2HrSZLA8ihjCpOSmpAppokPlgvQi21596spCtWVTcj7rcGmFVSu4zaAdViPD3PNYvzkzlZU6gG1B6V808h93UrQluS6gHsA2o9p4vlaGtER5mVrBQr63hIEpKndRt0FjysGbVXexjWZJVj6LpbCJX8yZ5qohjEziBXX/DzyPdua+TJq1nYr+T3h160OTcWC7KqIrwIIbXwjXIwc2KyIBhcc+GAyuyCH6GDFQLEZwY8tcGlA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by DM8PR02MB8122.namprd02.prod.outlook.com (2603:10b6:8:1b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.22; Sat, 11 Jul
 2026 18:31:15 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.21.0181.017; Sat, 11 Jul 2026
 18:31:15 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Yu Zhang <zhangyu1@linux.microsoft.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "decui@microsoft.com" <decui@microsoft.com>,
	"longli@microsoft.com" <longli@microsoft.com>, "joro@8bytes.org"
	<joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "kwilczynski@kernel.org" <kwilczynski@kernel.org>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "mani@kernel.org"
	<mani@kernel.org>, "robh@kernel.org" <robh@kernel.org>, "arnd@arndb.de"
	<arnd@arndb.de>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"jacob.pan@linux.microsoft.com" <jacob.pan@linux.microsoft.com>,
	"tgopinath@linux.microsoft.com" <tgopinath@linux.microsoft.com>,
	"easwar.hariharan@linux.microsoft.com"
	<easwar.hariharan@linux.microsoft.com>, "mrathor@linux.microsoft.com"
	<mrathor@linux.microsoft.com>
Subject: RE: [PATCH v2 3/4] iommu/hyperv: Add para-virtualized IOMMU support
 for Hyper-V guest
Thread-Topic: [PATCH v2 3/4] iommu/hyperv: Add para-virtualized IOMMU support
 for Hyper-V guest
Thread-Index: AQHdCjyk3FoDd2PvoEaR3JQ0We2DX7ZlmCnQgADQU4CAAknxcA==
Date: Sat, 11 Jul 2026 18:31:15 +0000
Message-ID:
 <SN6PR02MB4157805F23ACA85A668FA065D4FC2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260702160518.311234-1-zhangyu1@linux.microsoft.com>
 <20260702160518.311234-4-zhangyu1@linux.microsoft.com>
 <SN6PR02MB4157253E030D477FD91B7E26D4FE2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <enpkphavwmqrkded73c43vprczslvei4755lkxuedof4z2k3kk@y2jtklbk4efz>
In-Reply-To: <enpkphavwmqrkded73c43vprczslvei4755lkxuedof4z2k3kk@y2jtklbk4efz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|DM8PR02MB8122:EE_
x-ms-office365-filtering-correlation-id: 95bdc038-4f46-4c5d-17bd-08dedf7a975c
x-microsoft-antispam:
 BCL:0;ARA:14566002|51005399006|37011999003|24021099003|15080799012|12121999013|19110799012|8060799015|8062599012|13091999003|31061999003|25010399006|40105399003|56899033|102099032|3412199025|440099028;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?4s+BdUF0Mxu/D0R2M9jIzschtzcAoJcAOLfjrg0HhKgAi//bT2AFylOShX+t?=
 =?us-ascii?Q?zZ1kCb9eWe7k4GnGCnsg1R7+SAdoGQMxS5sHyD9WbeL8ZD22JwkqrVnubKl0?=
 =?us-ascii?Q?KCary4WzNc3/WShJ5jGgd7EB3SsCVpLmPzDD/4o5jHoxVEy+zBU3xB0dFo7r?=
 =?us-ascii?Q?f11k0s5d3Tg5lhEMjE+oKCMROvUqpBoUYH5+17G8s0PVX/LLVaQAENwL3OE6?=
 =?us-ascii?Q?sn1uEgDrKiyoBgY5FGkw86rzeWzakxp7E6gwZQ5PxV8VnJheXOBqUua5Uf4q?=
 =?us-ascii?Q?QsBs5sMlHbi6A1gJR+O4yKCZ9PXP5qvFt50VqU5XpZ7/R0eT7mGqvfO8hZ8V?=
 =?us-ascii?Q?YyXBIcPPetqJ6XEea3Kw2EQc+6t/DGYV3X4PJarSqkjhG1ybWcuhmdH/C463?=
 =?us-ascii?Q?EBCY7nKrI862KtqoCcVExSLOSlIHMf6hSM/NexA2vvbUbhJOIac4U+6ILzDE?=
 =?us-ascii?Q?UOe5rXPidKy/YnriZAKaVJR87NMOybQDVST8kFCKS3Cjin6H1xWA2eKS4fBe?=
 =?us-ascii?Q?AKYBj7onlAQk3DIt71H/2qD09boU2iicL3zZSnpoXqkfiyNPIIdw7hFPq5fv?=
 =?us-ascii?Q?KK5MokJPvrrW3NPLOGl7eGOiINYV9kfQNEIHbLe8Jja8EbL7zcJmANLRN54i?=
 =?us-ascii?Q?7D69OPuQauNj8+pgPZ91b/6b5p2TkuvJpZIgy6u/dYQVSH0C8Gywok9NRpAU?=
 =?us-ascii?Q?urwITMypc7TuBWqOcmanYdUxdOG3FWF+Th3scsUnWo4GBJEbJbG6vhBPsv42?=
 =?us-ascii?Q?iobJ7+i7Vkhp+vp58XdSOTxSKxi1+X01rJZNUgSMnLe9BHCLwW3DppnMLJ1d?=
 =?us-ascii?Q?iKJDCpvb692p7J50sFLpzEtUgvTg6bJfLDy1n1MklOaPRFxKASL8Dtl4A/hR?=
 =?us-ascii?Q?l4+2uiX80DgOGsK++HGizAXHgd9yo1UFs28M+7Ngzv1rS+26nsZWXIuKBojJ?=
 =?us-ascii?Q?wKJ50d/tm2ZQnm8SoR+49xzABvVTs7dGtmNVSltMipzInbUpFgtb1BnWdPHt?=
 =?us-ascii?Q?wMEh1Dak4gYcqWpqmZ1r8/lML7beEuBmIy8Y7OwtWQmnmcg=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?OU5vXTytmTlvrF2PrpUmWqV+mpXVkgEvnl7KxR+mK2D/IJRcm0hN5CZrvv1Z?=
 =?us-ascii?Q?rHL62UQDkJJmZ75uHqZxYNZFYuYYLXzkHuw6ZDwkz3KHpiOjjNjiIAOv7kNz?=
 =?us-ascii?Q?qikGV8T6NwQtS8hR5jFpOGIxgkdukKRNKPC7d7nXSci3BhGKUZ7KUfatXSa/?=
 =?us-ascii?Q?REdhkojWaie6dEU30QjA3KznRahmIFSAD5gM2VjO0coGEwbzTEf0m1i4zVj2?=
 =?us-ascii?Q?GLy/3SKnscN9Hc3HXioLxiRDo3nzN/v5SaQYquxniEVhi+j9R5yCtmbPRGHb?=
 =?us-ascii?Q?ckdIhOerxyuLtDJjhrYoigm+Lr2aHD34gYs3SiFwEuIpT02rW7P83SJz2Md6?=
 =?us-ascii?Q?7ruQMjZaZQI0q4mJB5UdleLyWpBhMsE6b5eamWwQX/ND+1WABrm0ebddh6l4?=
 =?us-ascii?Q?mEhF4jONKbEcp+JYhf7xSZ7XdqAO6iEnTQ+3kAPVe1p0VIigiYZWifxb467i?=
 =?us-ascii?Q?qZqzdY+5L6UrN9/Pid/0BSZaDgQXwZk5aM3kHb+Ug+fJ+WxFUxRUG23hjbEt?=
 =?us-ascii?Q?xbUWy7T2YV0P6tnADwsxjLLq05j3bjl6adsRkCWC53zZeoA3UjyMXbx9SMof?=
 =?us-ascii?Q?Ni7vpuvi23boNgRlSmsexvXaMM6YQjL7Gy/Ih7MSqYcKLY9n15YNzRvmZcbU?=
 =?us-ascii?Q?3sPxf8+ye46Yqbv35nppMcA7Cf43xD+SkFJQbO9vceHMeVV+rbGhS/mEMvOA?=
 =?us-ascii?Q?ASuMdeRErJ+bVrOCGdMaRcriW5377TVAUL57gxy/cNO70VXdAELv6VkGZe1P?=
 =?us-ascii?Q?YSRSMGnasW6wbHJjYYNq1UP0ZSvmKvMFmtF+8eXEkaPZIvqpG0LN6w8AR0R4?=
 =?us-ascii?Q?Bw2uJlXAvwXuStB4feRkIu1htwoaa6BrTqEbN6XyJaAPfaOZf6CxynhgyjlA?=
 =?us-ascii?Q?8HgA9+e69L8zTDzFKlhv8PVrBMLJyH/mqahcemqnOwpcI9NQYCDkQJgr4RLB?=
 =?us-ascii?Q?cpTLflOZVQaraLUcnfSDmBedgMCMKjwSgTxAIegH3ansZM35eiS/DkBTPRhN?=
 =?us-ascii?Q?871WnJWqJ2oC9H7Af4sqBuU3bXdUZQ0Hb1DIs9MOmIK8M92Bms5yVxtxWctQ?=
 =?us-ascii?Q?2EwX7NwXTnpsdAMQ/VSiKHUhdvuaJHzZyF+ILCWwhlOgLCA/CjK+vbzegQfz?=
 =?us-ascii?Q?s7f13A+uzD0M/S/UWsl+PzXFcGaO/ltbzJ3Hq6Cnouor/mXUWzam79Iy/4x/?=
 =?us-ascii?Q?SphgfIjKBHz0oLhq/C1HQc/kY8UhpL0p9lGVSQK5CIvnX+Lu7M4O/JXSNOy4?=
 =?us-ascii?Q?RBb9hJV2rD0VYjz9Qu9vmc/nRWtojafWidunMe4GxYGhwDq9CACdJK5Yx2zb?=
 =?us-ascii?Q?QWNbArl5zBjDuMjgxNFECJgzUO/Tz7l+7jn0sGdcrKXTAi7MeIG8UHQCnX5h?=
 =?us-ascii?Q?u3GTsUo=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 95bdc038-4f46-4c5d-17bd-08dedf7a975c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2026 18:31:15.1553
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR02MB8122
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11948-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:zhangyu1@linux.microsoft.com,m:linux-kernel@vger.kernel.org,m:linux-hyperv@vger.kernel.org,m:iommu@lists.linux.dev,m:linux-pci@vger.kernel.org,m:linux-arch@vger.kernel.org,m:wei.liu@kernel.org,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:decui@microsoft.com,m:longli@microsoft.com,m:joro@8bytes.org,m:will@kernel.org,m:robin.murphy@arm.com,m:bhelgaas@google.com,m:kwilczynski@kernel.org,m:lpieralisi@kernel.org,m:mani@kernel.org,m:robh@kernel.org,m:arnd@arndb.de,m:jgg@ziepe.ca,m:jacob.pan@linux.microsoft.com,m:tgopinath@linux.microsoft.com,m:easwar.hariharan@linux.microsoft.com,m:mrathor@linux.microsoft.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[outlook.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[outlook.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,outlook.com:from_mime,outlook.com:dkim,SN6PR02MB4157.namprd02.prod.outlook.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2135F7427E6

From: Yu Zhang <zhangyu1@linux.microsoft.com> Sent: Friday, July 10, 2026 1=
2:34 AM
>=20
> On Thu, Jul 09, 2026 at 07:08:26PM +0000, Michael Kelley wrote:
> > From: Yu Zhang <zhangyu1@linux.microsoft.com> Sent: Thursday, July 2, 2=
026 9:05 AM
> > >
> > > Add a para-virtualized IOMMU driver for Linux guests running on Hyper=
-V.
> > > This driver implements stage-1 IO translation within the guest OS.
> > > It integrates with the Linux IOMMU core, utilizing Hyper-V hypercalls
> > > for:
> > >  - Capability discovery
> > >  - Domain allocation, configuration, and deallocation
> > >  - Device attachment and detachment
> > >  - IOTLB invalidation
> > >
> > > The driver constructs x86-compatible stage-1 IO page tables in the
> > > guest memory using consolidated IO page table helpers. This allows
> > > the guest to manage stage-1 translations independently of vendor-
> > > specific drivers (like Intel VT-d or AMD IOMMU).
> > >
> > > Hyper-V consumes this stage-1 IO page table when a device domain is
> > > created and configured, and nests it with the host's stage-2 IO page
> > > tables, therefore eliminating the VM exits for guest IOMMU mapping
> > > operations. For unmapping operations, VM exits to perform the IOTLB
> > > flush are still unavoidable.
> > >
> > > To identify a device in its hypercall interface, the driver looks up =
the
> > > logical device ID prefix registered for the device's PCI domain (see =
the
> > > logical device ID registry in hv_common.c) and combines it with the P=
CI
> > > function number of the endpoint device.
> > >
> > > Co-developed-by: Wei Liu <wei.liu@kernel.org>
> > > Signed-off-by: Wei Liu <wei.liu@kernel.org>
> > > Co-developed-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.c=
om>
> > > Signed-off-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com=
>
> > > Signed-off-by: Yu Zhang <zhangyu1@linux.microsoft.com>
> > > ---
> > >  arch/x86/hyperv/hv_init.c       |   4 +
> > >  arch/x86/include/asm/mshyperv.h |   4 +
> > >  drivers/iommu/Kconfig           |   1 +
> > >  drivers/iommu/hyperv/Kconfig    |  16 +
> > >  drivers/iommu/hyperv/Makefile   |   1 +
> > >  drivers/iommu/hyperv/iommu.c    | 620 ++++++++++++++++++++++++++++++=
++
> > >  drivers/iommu/hyperv/iommu.h    |  51 +++
> > >  7 files changed, 697 insertions(+)
> > >  create mode 100644 drivers/iommu/hyperv/Kconfig
> > >  create mode 100644 drivers/iommu/hyperv/iommu.c
> > >  create mode 100644 drivers/iommu/hyperv/iommu.h
> > >
> > > diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> > > index 55a8b6de2865..094f9f7ddb72 100644
> > > --- a/arch/x86/hyperv/hv_init.c
> > > +++ b/arch/x86/hyperv/hv_init.c
> > > @@ -578,6 +578,10 @@ void __init hyperv_init(void)
> > >  	old_setup_percpu_clockev =3D x86_init.timers.setup_percpu_clockev;
> > >  	x86_init.timers.setup_percpu_clockev =3D hv_stimer_setup_percpu_clo=
ckev;
> > >
> > > +#ifdef CONFIG_HYPERV_PVIOMMU
> > > +	x86_init.iommu.iommu_init =3D hv_iommu_init;
> > > +#endif
> > > +
> >
> > This approach to .iommu_init is a bit different from the Intel VT-d and
> > AMD IOMMU initialization. Those cases detect the existence of the
> > IOMMU first via a "detect" function that is called in pci_iommu_alloc()=
.
> > If the detect function finds an IOMMU, it sets .iommu_init. Any
> > reason not to use the same approach for the Hyper-V pvIOMMU?
> > One problem with exactly the same approach is that Hyper-V
> > hypercalls aren't set up at the time pci_iommu_alloc() runs.
>=20
> Yes. That's why I did not follow Intel VT-d and AMD IOMMU's approach -
> the hv_hypercall_pg is not ready yet.
>=20
> > So you'd have to call the "detect" function here in hyperv_init(),
> > and have the detect function set .iommu_init if pvIOMMU
> > support is present.
> >
>=20
> The detecion of the presense and capabilities of the pvIOMMU are done
> in one hypercall. But I guess we can:
> - do the HVCALL_GET_IOMMU_CAPABILITIES in hyperv_init();
> - check the presense and only set .iommu_init to hyperv_iommu_init()
>   if pvIOMMU is present;
> - and then do other capalibities check in hv_iommu_init();
> - only give the error log if an pvIOMMU is present yet its capabilities
>   are not legal.
> So below errors will not be printed for guest kernels built with
> CONFIG_HYPERV_PVIOMMU and running on a host w/o one.

I see your point about detection and capabilities coming from
single hypercall, and that separating those two functions
would duplicate code. My biggest concern is about errors in the
dmesg log for a valid configuration where the host doesn't
supply a pvIOMMU. Fixing that problem in the context of the
current code structure would be acceptable.

A minor concern is arguably misusing the .iommu_init function
to do detection. But that function is only called once at boot
time, so leaving it set to hv_iommu_init() even if there isn't
a Hyper-V pvIOMMU is probably more a conceptual issue
than a real issue. I wouldn't object if you prefer to leave that
"as is" to avoid duplicating the hypercall.

One new thought:  Have you considered the hibernate/resume
cycle? Does anything need to be done with the pvIOMMU to
make it functional again after resume? I see that the Intel and
AMD IOMMU drivers have suspend and resume functions. I
don't know enough about the Hyper-V pvIOMMU to know if it
might also need suspend and resume functions.

Michael

>=20
> > While the code currently in this patch works, it generates boot
> > time errors if the kernel is built with CONFIG_HYPERV_PVIOMMU
> > but run in a guest on a host without pvIOMMU support:
> >
> > [    0.101673] Hyper-V pvIOMMU: HVCALL_GET_IOMMU_CAPABILITIES failed, s=
tatus 2
> > [    0.101675] Hyper-V pvIOMMU: HVCALL_GET_IOMMU_CAPABILITIES failed: -=
22
> >
> > We really don't want errors if it's just the case that there's no
> > pvIOMMU support. A less alarming message (at INFO level instead
> > of ERROR level) about running without an IOMMU might be OK, but
> > perhaps is unnecessary since you have an INFO message if the
> > pvIOMMU is found and successfully initialized.
> >

