Return-Path: <linux-hyperv+bounces-5194-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D3B1A9F2A6
	for <lists+linux-hyperv@lfdr.de>; Mon, 28 Apr 2025 15:47:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C59BF3BE587
	for <lists+linux-hyperv@lfdr.de>; Mon, 28 Apr 2025 13:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9772E25E465;
	Mon, 28 Apr 2025 13:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ntTClD3+"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CY4PR05CU001.outbound.protection.outlook.com (mail-westcentralusazolkn19010007.outbound.protection.outlook.com [52.103.7.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA03186349;
	Mon, 28 Apr 2025 13:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.7.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745848048; cv=fail; b=CCgwdepEYDNcs8AGzcyqdo+ZJc+SLhLMspqs72shfO6Hx6AuXRF8iLYUvaAGOwn/8v7vKQw20Y6MB4cVdAxChLMXrGSt0WF7sqYJx+WhhC8xjGnyFgyQq0eLzJyrRyX0BF2laX3e4ywcFG5SlJB/P0TsWeL+YsuuqnPbHGgfpKk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745848048; c=relaxed/simple;
	bh=gj07RSXROiLzns5Yvuxgh7CcNekeYPXZEwb/xHzHI+M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sw0kPEEnX7PKJcal9F3jVjkQ+o8qVilrQgFZumEeZmd3pDZB4wdnUS9tWzZKcHDzhlE4bv/fGFy7zyhVVu2YiLLgL8NcUME+NnPuAZ8DYS3OnfRazYHBccjyet+H37a1cYsoidTi6d9Ku21kyxvCCXdxeC1dQvUfYnEFEXbEl2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ntTClD3+; arc=fail smtp.client-ip=52.103.7.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f6BPf1ChnRnWkT1VxMmvTBnS0MB7TF15j5MrANXmvPUHI7iJsNb0LauX+aB8+JwTzUTspqHP51hFZRE3qFsUgMQq+LgxRlAmsZwIaLL6FmLD8oziIlGronqMz/Pf4B3oVw92jTKMae6sdlk/8M2Sw6abn87LmGz6jkI1wGZLd76kPlHFbI8Tuw4aypSnpp07cLPWqttLVqDP6ZrXkY82xiZTCENc+UbAx9zmu5i/s2K4hF1Q6qhjNkXkrpeorKQUZWy1uL3VPhiImnzUO/lg/3tuXHJUcvuPP4tJV2rZJX0o/lHIO02JAvK6q2q3HXKnm4HVCtLYXMLM5s3N8h+Bsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S80nHl413On0YZ5v2eD0P/XGRuFBHKYLaXyF1ox7N0Q=;
 b=QCv776nwi9JCQGyVhDXSStxFpYd+Blj4dzUeGirGsjdiIfPCH7FzSnZZeN9LQZhoo6lz7g7KwYJbm5icbewcb7Y3KgFH6GEvXLJcZlbRW7vK2MvYthBXHIv5VEyFkSvvc/mFeauzK+S8V2MwCDJE7/Z8f7XRU5hVgCC6GuehN0I8IZdnvbRZOpTVkJLKIqsv6uhXHBThuRaiFzG0QBZviUB2YCQNeVcNZFDanrQiu1NI/I0RV4p7xoFeTgcOuTYqj4Ynmmg5hvQZ4vhpNZkf2dE4J8W5xcIL+gqAfxuwwOQvZfkc45cw5xouWxnGdOOM8KQPYdejID0GgG8vtSF86g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S80nHl413On0YZ5v2eD0P/XGRuFBHKYLaXyF1ox7N0Q=;
 b=ntTClD3+iHIL7QEXDxQrpGPdfSsXMMBppiQhbJKAoblk8zAFlGTBnOVXXbwzJRkM08Lcr0qdakrkKn28mTmCxYm2yaU6Thpw3UW9WhHPG9kLRfNJmQBHtqBXpW5MPDpLEMXlhVW7chNJEjRpTjy9FmOPry9fPaM03OM73f2h/20VME1/doXg60K5+o9SXHM4a8PrsNjsSNl7uxEjpjGMfUoolP36WIVZE/kzu0Bmg3QtXGbjGAN8jXhFhhj9ceYNJynZ5f7KpandixtWoKccvILbRW/MTg6xLJDTaToXKQbBMBvKHOoa4i6dktDGwZH/gp9RP3BiwhE5xyKS2Zre0A==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by IA1PR02MB9496.namprd02.prod.outlook.com (2603:10b6:208:3f0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.15; Mon, 28 Apr
 2025 13:47:22 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.8699.008; Mon, 28 Apr 2025
 13:47:22 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Nipun Gupta
	<nipun.gupta@amd.com>, Yury Norov <yury.norov@gmail.com>, Jason Gunthorpe
	<jgg@ziepe.ca>, Jonathan Cameron <Jonathan.Cameron@huwei.com>, Anna-Maria
 Behnsen <anna-maria@linutronix.de>, Kevin Tian <kevin.tian@intel.com>, Long
 Li <longli@microsoft.com>, Thomas Gleixner <tglx@linutronix.de>, Bjorn
 Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>, Manivannan
 Sadhasivam <manivannan.sadhasivam@linaro.org>,
	=?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>, Dexuan Cui <decui@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Haiyang Zhang <haiyangz@microsoft.com>, "K. Y.
 Srinivasan" <kys@microsoft.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Konstantin
 Taranov <kotaranov@microsoft.com>, Simon Horman <horms@kernel.org>, Leon
 Romanovsky <leon@kernel.org>, Maxim Levitsky <mlevitsk@redhat.com>, Erni Sri
 Satya Vennela <ernis@linux.microsoft.com>, Peter Zijlstra
	<peterz@infradead.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, Paul Rosswurm
	<paulros@microsoft.com>
CC: Shradha Gupta <shradhagupta@microsoft.com>
Subject: RE: [PATCH v2 2/3] PCI: hv: Allow dynamic MSI-X vector allocation
Thread-Topic: [PATCH v2 2/3] PCI: hv: Allow dynamic MSI-X vector allocation
Thread-Index: AQHbtdCWRcDvObzyf0yxeG1Lt72g1rO31mow
Date: Mon, 28 Apr 2025 13:47:22 +0000
Message-ID:
 <SN6PR02MB4157247E1BCF02CEED0B23BCD4812@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <1745578407-14689-1-git-send-email-shradhagupta@linux.microsoft.com>
 <1745578459-15084-1-git-send-email-shradhagupta@linux.microsoft.com>
In-Reply-To:
 <1745578459-15084-1-git-send-email-shradhagupta@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|IA1PR02MB9496:EE_
x-ms-office365-filtering-correlation-id: 3fe03602-e7f7-46b2-6ea4-08dd865b33bc
x-ms-exchange-slblob-mailprops:
 70qbaZjg4mvbis83qL2U5WvEmRMBS6OgzCHaEno8A2kkpmDgZwK5XsVusQuXWRDSGoNmyPowv3rVxG2Hhga2HCNNJ8mDZHmpQnvAe9xKALe96XiD4y2wmwpU9urXSs7mLk35pJLhrizE2KaN4ljcs44iWUAQ3kVXiRbZ5/Qm/sKWvzTfJvNU0Cz3aETNjthEKaKM+oBZez3sBeEi2KOcR2cpGH5CL0zc0Ggi7qvTI609MUayaZ89oppH0iEWIsF/r5rOz6IPlDrtWClSd7ilWR/FIXvs09y1XEAABrhl/GaSE/3Wy5OFbWfLulRwmyzfLrzuUWHfFkLX4b+55H0AJie6Qeug14/bwSiSaB5uTLpjcI6fnd6P2sx8uFjpZL1dgD+FqpFFo86f03ejdQ0K0C2O+qrpuFu+1dE8WJn4ZDiJ7dtMknZc6jysWP63a9hRwgGAaQMTyRlobL2/jP5hWNtfZTKU9OkJZiNAYk/+32chkTutr05LIcLtYB9tftQDKP7ltrD103uD2XPvApaUnSaIFesT5MRieVhmjiDhsQe8MxyRZ/316pcAsFiWj1OyLsuT7LTmZ1zeZ6OC0E/nbO0myxaEtli+Bywo8S5n5b3okX5gfFl/jmcjLobZz7xhoAcZ0YmqsdgxKOoTF4f+uXtugN70WJpU1gTn6NO0FuoTv3rQiY8qY6f+Ev0YjH+Kl5BoS3cCFfdsyFLH4f6E56IzNjaWEeoKHGTv6nmVkjLErh/S6EYxbA==
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599003|19110799003|461199028|15080799006|8060799006|102099032|3412199025|440099028|41001999003|12091999003;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?NLvHZrlOAlUjf2eI2KdDnbCrMklBkueLGyTczfLx+DQsGiBThX1N3b5PvN?=
 =?iso-8859-2?Q?R9Uq75vTdk86duVEUI17Kv08YtUbHIvfYWw4ayV1iqKeMpNbQLlnnT0MZd?=
 =?iso-8859-2?Q?BDHIPfMGcGfZ6Vx4wbTFR8STVgj1T9WPnIUTQy6c8yCh5WJfWjHoMOHOFJ?=
 =?iso-8859-2?Q?JZ+zdTFQxjUOfZoVQZoL5RezdsxRiBSvn+SN2kZ6xmj5EQG1LO/nxt6Oue?=
 =?iso-8859-2?Q?hv3iLPU5AE8DGkmw1Nl2vfSx/didYzbwkqIG7fIgJc1Wsj/HT3ROiI8+Cb?=
 =?iso-8859-2?Q?BcQYtE5TDMXe6xzqmz24KYjUInLZaiXZelE4viB3Zp+Wl98ECPk7WrB+/p?=
 =?iso-8859-2?Q?DvFe5fdp44lyiGE4eAgNmEv1+3GnbZVkndqSo3l3Sk9WxnaXBL6k9Cd15D?=
 =?iso-8859-2?Q?WkYm4nN35O6llAAGP4pKiCe7uGXI1z6Fi/T5MUoMOr59wTXoH9tD3fYq3m?=
 =?iso-8859-2?Q?/MuiYHHp2HyjJpin43tlRbWiC8yhbPeK6B1pfx7tkrETyjPeNP4UUbdObY?=
 =?iso-8859-2?Q?jX8FQZsG3zIc7Hy7t9zG+I2zwmFQKeEzghl9Bg20zfKVy+sYL83O40a+2H?=
 =?iso-8859-2?Q?zNvMC3oqaIM0OfygLsMJW5CJUxtyFrk1fJ3+G48RMT+qLYRFIk83y7NKSb?=
 =?iso-8859-2?Q?tvq+6k/f0XV66Yy58kr1GoWef2Xs2iJE9dddWZywH+R93w138baPIeMcqt?=
 =?iso-8859-2?Q?i2dfXdsqmhFFe+/Is4HXXe/96n3ipIvoSED3ic6Fb2cgURNxKuhM91vq3T?=
 =?iso-8859-2?Q?YwLoiHtY/8sz4BYLrtPbkshuEQayolH6care1k3KH5qCLTaijz/j0+P40i?=
 =?iso-8859-2?Q?moat+4UzQcZ4nfaicFSxu32oT60XLJTJ6Cm6C9EX6OlpzfbQte5LIbP2sM?=
 =?iso-8859-2?Q?7/Ml+THEG01BtyXAzmJjPZLaJdg10NG5ZXo7TYbqgj6UG/ZX/hKBAVnxuj?=
 =?iso-8859-2?Q?tkOLxeQdu7RzVurq2yAKaHz7aYRHEP0ccIG8e0V+Vj6LCEcZ3xbOjJH1rj?=
 =?iso-8859-2?Q?WDkjcCJZwN8ysuda1pBi0obrbnX3lxZUeyXk68LX8bVC5Mg+XMkCoZcxDz?=
 =?iso-8859-2?Q?YyBV7Mrcd6yXV5/Qw+7Z37wfIdbX+MxmhfSMjflOgNcgxdc2G6Tshv46XX?=
 =?iso-8859-2?Q?XUertk180I4IjQzoZdYf2WH7JvBYyHMT29ZM8XiMdGrkIT0fDcezcT84dK?=
 =?iso-8859-2?Q?8KuUCv0lM+jtUA=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?1hlTdcNEAjG2KI4zpjAfj3pGD6t6Wq/PgHEFao26y9JuGCCJERBuDN7Umd?=
 =?iso-8859-2?Q?fMadfKrK8jBWcq+xSFjoRt1kjQL7yrU98C7g8qzYorwYwm6j4nOZinMcqd?=
 =?iso-8859-2?Q?SznGHl8Gxj12x9hQjrnK7zzW6RWFKqzyV8m74++hCXl4d3CXyfTlAeTbUd?=
 =?iso-8859-2?Q?MTPvpftILbXv+7nl6Y3NLFGaiKB0vFRLpZFkBB2WP3sF+QvdYfaXN/fFP/?=
 =?iso-8859-2?Q?UeZPd+76mrKhNE1/v9etrZFQIHRI4+eKo3xR+fDagB/r569aClRnbtclxg?=
 =?iso-8859-2?Q?ENSxH7ZxjMT3+cLYoa2KpaYyVhzvPNAhu5zZxGY81SfqI5HLBreFz/8hWq?=
 =?iso-8859-2?Q?vqfas7ZytQ3aHB+G6zU5ATEMcwvBNpDeHQ2zzPD/6sawqPEB4VV8wYcwe7?=
 =?iso-8859-2?Q?G3pL/538Y3HiEBxMTCMLed/AX71ijCxPFu38ECa/T3aBcb72vrIIHUvzmk?=
 =?iso-8859-2?Q?HqqDlMXn4+zDOOCI47vTQhmO52x6IAiCLOPoTXtlM7LSKtYBzLtM9hBcl+?=
 =?iso-8859-2?Q?xtYI7yVOgbDH7ukzJoBKAyRgYH4j5q7TwRne4lLMMFmII0p/c+ZcKbePZp?=
 =?iso-8859-2?Q?y7rryLzFAIR5j26SQcKH9eSS81w1uhu3JrT/sBKh5midQ5vlzOOXbySEMa?=
 =?iso-8859-2?Q?YR31rTbhUTobVteackD/Ms8rZ5flCDZbd6nvVOvOn8eLFFMIgrxL3f2jrB?=
 =?iso-8859-2?Q?tz+St0dUx5mIF5SKbfTY1zWE506SDj3nEUzYvO7BOrfy8wBb66jACoKs42?=
 =?iso-8859-2?Q?rctBdqqL6VDbDDi5tJJ6kl1e9DckjkKhPK/2ldk334jcR4SB56lKiKCczs?=
 =?iso-8859-2?Q?wvlLrq42RRd6U6DLhiZO1YwYSJn91nzmkrdqDvPAZzRiFXTjGql/eEhd6w?=
 =?iso-8859-2?Q?X/RuW0gMAumLjahu0f5a7xCgx+Fnihegzd6Ch+FFI0RU7A5FwxVNtEW0Ve?=
 =?iso-8859-2?Q?pcYkgMKOMi6aP0jhk5S6XyTV8KctT8Xii8gk4XorL39A8sveLUji0zzXQd?=
 =?iso-8859-2?Q?Ne1L8Ov38q6OXX+suqKjxGIMlhuT59Inj5JFwURPN+yDCJC1YBscw/Vrfd?=
 =?iso-8859-2?Q?VXP8kTRvz6LxPKLfYZliOSLEvclp59/uV0VsNbCnn+Hrd0uftZeUA8vEfA?=
 =?iso-8859-2?Q?sZllytMcDHB/97TYwy5TRWGwIQBUhliBpGcxbCSH/l0W49q85RPWIAcpZD?=
 =?iso-8859-2?Q?pvBQ/rQn9CP7cTPxD8UkSbHBfTahOyS1cVUCfr+0rgabqc1c/O3yC7l6gT?=
 =?iso-8859-2?Q?not9mns1+AtLj5WdEra0iU+qxFTFdrlBhK0X0Kubs=3D?=
Content-Type: text/plain; charset="iso-8859-2"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fe03602-e7f7-46b2-6ea4-08dd865b33bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2025 13:47:22.4569
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR02MB9496

From: Shradha Gupta <shradhagupta@linux.microsoft.com> Sent: Friday, April =
25, 2025 3:54 AM
>=20
> Allow dynamic MSI-X vector allocation for pci_hyperv PCI controller
> by adding support for the flag MSI_FLAG_PCI_MSIX_ALLOC_DYN and using
> pci_msix_prepare_desc() to prepare the descriptors.

I'm unclear from the code below whether the intent is to support dynamic
allocation only x86, or on both x86 and arm64. On arm64, you've defined
hv_msi_prepare_desc as NULL, but hv_msi_prepare is also defined as NULL
on arm64, so I'm not sure what to conclude. MSI_FLAG_PCI_MSIX_ALLOC_DYN
is being set for both architectures.

In any case, please be explicit about your intent in the commit message.
If the intent is to not support arm64, why is that?

Michael

>=20
> Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
> ---
>  Changes in v2:
>  * split the patch to keep changes in PCI and pci_hyperv controller
>    seperate
>  * replace strings "pci vectors" by "MSI-X vectors"
> ---
>  drivers/pci/controller/pci-hyperv.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller=
/pci-hyperv.c
> index ac27bda5ba26..f2fa6bdb6bb8 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -598,7 +598,8 @@ static unsigned int hv_msi_get_int_vector(struct irq_=
data *data)
>  	return cfg->vector;
>  }
>=20
> -#define hv_msi_prepare		pci_msi_prepare
> +#define hv_msi_prepare			pci_msi_prepare
> +#define hv_msix_prepare_desc		pci_msix_prepare_desc
>=20
>  /**
>   * hv_arch_irq_unmask() - "Unmask" the IRQ by setting its current
> @@ -727,6 +728,7 @@ static void hv_arch_irq_unmask(struct irq_data *data)
>  #define FLOW_HANDLER		NULL
>  #define FLOW_NAME		NULL
>  #define hv_msi_prepare		NULL
> +#define hv_msix_prepare_desc	NULL
>=20
>  struct hv_pci_chip_data {
>  	DECLARE_BITMAP(spi_map, HV_PCI_MSI_SPI_NR);
> @@ -2063,6 +2065,7 @@ static struct irq_chip hv_msi_irq_chip =3D {
>  static struct msi_domain_ops hv_msi_ops =3D {
>  	.msi_prepare	=3D hv_msi_prepare,
>  	.msi_free	=3D hv_msi_free,
> +	.prepare_desc	=3D hv_msix_prepare_desc,
>  };
>=20
>  /**
> @@ -2084,7 +2087,7 @@ static int hv_pcie_init_irq_domain(struct hv_pcibus=
_device *hbus)
>  	hbus->msi_info.ops =3D &hv_msi_ops;
>  	hbus->msi_info.flags =3D (MSI_FLAG_USE_DEF_DOM_OPS |
>  		MSI_FLAG_USE_DEF_CHIP_OPS | MSI_FLAG_MULTI_PCI_MSI |
> -		MSI_FLAG_PCI_MSIX);
> +		MSI_FLAG_PCI_MSIX | MSI_FLAG_PCI_MSIX_ALLOC_DYN);
>  	hbus->msi_info.handler =3D FLOW_HANDLER;
>  	hbus->msi_info.handler_name =3D FLOW_NAME;
>  	hbus->msi_info.data =3D hbus;
> --
> 2.34.1
>=20


