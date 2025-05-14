Return-Path: <linux-hyperv+bounces-5499-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81EF4AB61C3
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 May 2025 06:53:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29A9E3BEDAA
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 May 2025 04:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1FCD1F0996;
	Wed, 14 May 2025 04:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="PAaefQs0"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazolkn19011025.outbound.protection.outlook.com [52.103.13.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11367404E;
	Wed, 14 May 2025 04:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.13.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747198420; cv=fail; b=p/kbzMWsuWuYIgTZVhrkHVZ72H53gQGry+xuwuuS7o4RnsVwEORIn1eX06Z8bNzrQglTqJoykjyZhUxmYlifHFdA8lA16aIrK322UcQEQcgioGcLiTjgVCxKhCwxcwD7faIpVgOkb6ALGRVCmfQJlTdHyYpe7lEX36miNVzRmRQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747198420; c=relaxed/simple;
	bh=VifOxEif6/+NoZ1jxqOzkv5qZ0K1aQZQQo6St5j3GvA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=t9kDvrP+nsN2oyIqDlVYiguc6kxs3MWMUYaYvpUuD3QGDhttuDI4BkDfBg7R3lURUU2nvD7PHKk9Sj/W3JAEbup03oRsXPrlz0k3vFR5mIKzfW6d4KDWRA/XPPQLyaxcd58jf1mvyL+Aq3dpMJmVzK91Sd5ySP4AV5DJQjNFdt0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=PAaefQs0; arc=fail smtp.client-ip=52.103.13.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ew/Kt8qi2tlkv8ZffcoSq+XZzyZ4WlScTT9B/zN8B3RnzWe/N2tSbYh2R3dMZFp0r9uhhdEoW15hoWzaJ3MU386PJXSQPvD/JPBy2lOAbPmAFQZBw+81jve3JywvsbDyPcImgtLZ23sfL+tJZGU5rLjxxOzvSTgRWPNTBcfGSYBOHLapv0MIu3XDMAlBWJF3ZWCjIwYFajkbYabfm25bzW4kb6AAhURruKw+L4l6n6bfamlvV1JOD0d7yCLijYShWy6Bl4e0wd83sMehdUA3rJ8upBs4E1l1iV7Q0lJ2gvm9shpjPA8dINl04QvE2mQRVDzo+9YNLWzzsCqHeepWdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VifOxEif6/+NoZ1jxqOzkv5qZ0K1aQZQQo6St5j3GvA=;
 b=Reuk4WyOSg3LEX3A/gV5I7tpGnzEZEeEjME+5ug555riQVydwmbUOr5fWuQ+g4nUwukqcllweNXW0BUwvayGN9AhyYqgUkGxDOEEnjdWjBrZEw/LI18F2PJmfOwaZurXmwpkglWu5PZEnanWbBmbBKCDRTVw7Xo74x/cLHNBtG6jen50s6r2mrC9o1heSClWqGq0wkwcQzvEys4v1kCmGceRdDaijNqdEw4uW1QqtGvuJ128R/V175cZQoxSbGWwWtveHxkVrnssbfaDzdHAuEj1NVU7otPI+jWTWU7RzpHLCXR7vX2tLvbZu150C4Kwwe+MVB/mVGx3VBMRgCWrIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VifOxEif6/+NoZ1jxqOzkv5qZ0K1aQZQQo6St5j3GvA=;
 b=PAaefQs0SKSZgteVSFso1//t1spMmsTl59y/FGA6hQItUIWOX0p6+q9ne+8nBxewpJz25i22VfZt7nySaGwSUkIAB2BsyKCyGay32lo5LsPQvxetXD4/8EyeH2WGtOjPCTmtPbfkKAnnSdczUZb46dIcV22qbDg9C9E1PZrWlL5/9Mikpq5DuyVNt1iXd9eYwMQu/odE0Yv+Z1YWQuWb5K0Ql6MDdy4gO5N3GXoXMYXvJyilT9mEt4v7mpm3IP3P3oEXYp5eD2XhKu9GtWSKKfcu+JyDUjEYhF9rZOJB9k0wojZbxTJ3kjNLkQYTJvm2pr2hdR7LpwIrn4GKgLLV4w==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CO6PR02MB8756.namprd02.prod.outlook.com (2603:10b6:303:140::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Wed, 14 May
 2025 04:53:34 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.8722.027; Wed, 14 May 2025
 04:53:34 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>, Dexuan Cui
	<decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Haiyang Zhang
	<haiyangz@microsoft.com>, "K. Y. Srinivasan" <kys@microsoft.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Konstantin Taranov <kotaranov@microsoft.com>, Simon
 Horman <horms@kernel.org>, Leon Romanovsky <leon@kernel.org>, Maxim Levitsky
	<mlevitsk@redhat.com>, Erni Sri Satya Vennela <ernis@linux.microsoft.com>,
	Peter Zijlstra <peterz@infradead.org>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Nipun Gupta
	<nipun.gupta@amd.com>, Yury Norov <yury.norov@gmail.com>, Jason Gunthorpe
	<jgg@ziepe.ca>, Jonathan Cameron <Jonathan.Cameron@huwei.com>, Anna-Maria
 Behnsen <anna-maria@linutronix.de>, Kevin Tian <kevin.tian@intel.com>, Long
 Li <longli@microsoft.com>, Thomas Gleixner <tglx@linutronix.de>, Bjorn
 Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>, Manivannan
 Sadhasivam <manivannan.sadhasivam@linaro.org>,
	=?utf-8?B?S3J6eXN6dG9mIFdpbGN6ee+/vX5Ec2tp?= <kw@linux.com>, Lorenzo
 Pieralisi <lpieralisi@kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, Paul Rosswurm <paulros@microsoft.com>, Shradha
 Gupta <shradhagupta@microsoft.com>
Subject: RE: [PATCH v3 3/4] net: mana: Allow irq_setup() to skip cpus for
 affinity
Thread-Topic: [PATCH v3 3/4] net: mana: Allow irq_setup() to skip cpus for
 affinity
Thread-Index: AQHbwMtMGWa1o0c+K0aOc8evtmVPbbPP9fjQ
Date: Wed, 14 May 2025 04:53:34 +0000
Message-ID:
 <SN6PR02MB41577E2FAA79E2803C3384B0D491A@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <1746785566-4337-1-git-send-email-shradhagupta@linux.microsoft.com>
 <1746785625-4753-1-git-send-email-shradhagupta@linux.microsoft.com>
In-Reply-To:
 <1746785625-4753-1-git-send-email-shradhagupta@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CO6PR02MB8756:EE_
x-ms-office365-filtering-correlation-id: 1e80d3e8-5c4c-4e07-8010-08dd92a34806
x-ms-exchange-slblob-mailprops:
 0wLWl8rLpvtDJkhNY0/IVOpfW0xPqUJOn5HJoq7QoI6zEhEwdimaEEzNO+Yr0bXhD6ctAGT2b18+OM0iK8pMyAmIpKQd8NpLJSz+rYCMLE+D4WG6GgQBIWd9xCEiktxwsu2WNE2gXVpTRyJho1Hwrw43goj/i10JsyYvaoGSOZIJZTeMAUtgCBt7P8yUmJq9D9zxXwYWCwVbt3KYmJ5ak2XHe2VO5b4XwLs/bzvuErZEY50MObIdmrq0Ti3zgQf0/KFydrcySK14Fgzh8SlQVL5SEbkXT9qxxcNzML0Md1bi/GYyDx0W6eF7ncuMpqwdKChrLse0LhYfgVQW9tSn0GStdlM7JJKYjBfZpSmD6FbDtzbZOY4sT0KZHmBmK5xd+SjCSe/BRF3kTZOWPCjoqSC6TbIoVSusfyB5RmhRWsipjd/RWVwpcbyzNkGtoFu4OwdbWLTlfo/JgnsLpYCAzBXYEDcN2cZZFMsUfEZo5hQYUBWFAQjRmwacL4N/CS8rONuoIpJQp/PJhaQiU085pZSQhkujWNCn5nrku0qlk/99SBEdUjh8rFsEG8/+ghwXcbcEHDpjFoLlmWSBchQLuG83o72wsm1xBMi+i//UUfkudHI63zNa3VjwaS2wJyQHWOQCIjJ1rCqrLB3gyjhoWWSMUJ0zkdcgd2lx212AzBBj8uZqDLv3lhhWYF9oEraKh1yVEIU8YUkL6ActKJZFhZHGbCDAWzwffe2LF9iLPfYUPix2swv3i6j479bxOfR96KgJFmdtXUI=
x-microsoft-antispam:
 BCL:0;ARA:14566002|12121999007|15080799009|8062599006|8060799009|19110799006|41001999006|461199028|3412199025|440099028|102099032|12091999003;
x-microsoft-antispam-message-info:
 =?utf-8?B?Y000bVpoVXgrUGs0TkZDVVY2V05EaXNDVzBlZ1l1dERSb1hjOWVMUHBlcGQ3?=
 =?utf-8?B?SDgyOHhienZ6VWt4WFNRQXY5ejdmWHA2VkE5WjhyWHhJM2dTT3JJZjlIazYr?=
 =?utf-8?B?WlNPeWlaY0RheXozalR2SlQrZllkcFdoY0haUnJGazdmWGZoZXdIZmp4QnVM?=
 =?utf-8?B?MFVzTm9ac3h4NUU5WnB3UnlRaTU2UXBheExEdHRjM0lLYjEzZHF0bVFZaCtV?=
 =?utf-8?B?b1Z3TFR6RENqcGRuVTN4d2E1SlJpaEF0UW9qSUhQK1gzTXZzTENvOFhtZUhN?=
 =?utf-8?B?MkhaSFNUUDMzWm9ZcTI2dmFISGpmSkpmeFVnNm45enBFQzV0MDJEV2xtNlhv?=
 =?utf-8?B?dEtEUFE3dGdzMzhkcndqZitxbURtcWw3K21TS0xNRXV4YjhDdHV0ekNCeElh?=
 =?utf-8?B?UWc2VUt0RjJJR2tuSkp0SWlyOWR5c1BjME9YaHlGYWloTHlVZ29wTis3Sm5w?=
 =?utf-8?B?WlFQUytKV0x5LzV0U1R5ZmN2cTlvKzJZMXl1TFZOTVlGYUsybkc0enFvVlAv?=
 =?utf-8?B?NzM4QWdyTXd6ZnVaTCtDVlkrQWpRUWF5UXBEOWFKMjM1azlXT0RyaHY2V3FF?=
 =?utf-8?B?aDNHMkNLWEFlc3pZMWtRdi91MllSTUJBRkNwM2VyaWJrNjlHNkIwcE81Y0xz?=
 =?utf-8?B?NzRQMTc3OEJ0UEJVYTFrZVk0RlcybHZ3T3ZsVE1ScjRoVjA0RDlQSmZNS2ZO?=
 =?utf-8?B?SVFveE1ZTXlNWW85U09aNHRIWnNIeHo3RThLNXYwWHJ5U2JTTHFCL3phNXUy?=
 =?utf-8?B?WS91SHo3bUFyNm5Pb1NlS1h1OTlBUUVnbmFUUVhBazg5VUNHNGQwa2N3NTZP?=
 =?utf-8?B?VWtBaCt5dmZXVVZxdEk1UTNiQjhRcGtzMWphaFVwTWQ5bUUwSE5MQ1hwSGxh?=
 =?utf-8?B?RjZkTXlJNGI3azZFWEJ5SEQ2aGpyZmIxaVNnaDh4SFhYeVFYWW5GclQ4cUZn?=
 =?utf-8?B?c2RlMmVaL01qeTB1UWYwZmFNV1VoZ0Jza2J1NnZNbm9adzJRS2ZJSVYvWGhG?=
 =?utf-8?B?aXlMaHR3b24vemNQRDVOREVTSHR0U2x2QXVsYWkxS0lmYjFNM0xZbEEvU0k5?=
 =?utf-8?B?ek9pcFRJaVVOdVVENUxzYUZLcDduK2syRjJnbGdvNnV2aVpwTVh1d1pQWEVz?=
 =?utf-8?B?TWJzMWxwM21nUThOK1pBME9ndDNXQ25ZZnVwNjdWVENFKzNFZmRCa0JkSzhZ?=
 =?utf-8?B?bFNFTDJ1SmdFa0NpTjNnVHl6MDZyRlc0NE5ZKzFiRm9oUXVpZGh1YWZuQUpD?=
 =?utf-8?B?RjZDaE0vUU16M1hNeDZpNlkwK1NHSHg0WWF3NldjWG9LL21GZnU5TGVKOWNs?=
 =?utf-8?B?RkZYT29CL3VuM3dEUVI1MWxyY01halh3R24yb01xQ05WbTVGcGx1WHU4L2p2?=
 =?utf-8?B?eCszK1NaNjRmUkV5NnVjQi9uU2c3cWN0UUNKVEwrbFdkSnl2ZUVVd1lMSjR6?=
 =?utf-8?B?V0g4aDFydjMrblBZV2JWc2tIU0NMMW1IOGlFYllsOHo3RXlWT2Q3UHRsUGlm?=
 =?utf-8?B?Yi82NlBPU2c2dHVsUG0rRWNoK1ppSGFRZ1JZZHZLbGhNK2pScGVPbnhSbjZ5?=
 =?utf-8?Q?PhwK3mAlBqBIAh0sqa2km9AcVUHCaqSPbUPoVohu2j4byT?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?d0dHYmtPN1RZQUVNWXcwTVdiSHVLZk15dVhUd1ZIQzFiMWNXREp2NFlndCtY?=
 =?utf-8?B?clA3TmdNd3YxMllWeG8zQVI5YzU4b0FZbWRzaG9XQ291SitxcG52OXlPYXZa?=
 =?utf-8?B?QnBQbDdMMStDOWtrbmF4eHJsajhVWHFXcVZscGNGZHk3SGZFSE15TmlPVWh4?=
 =?utf-8?B?OFZMdStvMnJMeS96WHhFdTl2UEVTdlp0UzY4U2pieXN5ZVpicStqaXN0OVg4?=
 =?utf-8?B?KzlNTkxJY3Vodzhya3VJQnRjeVdUc0p4WkdHVWRPZU5lamJTOEloNk9XQWxS?=
 =?utf-8?B?eFBTbkRmWk9GMWlhWGVJOUQvMEZmaE5tNFMwdllhVHNEUmNPNGVnb0hpdU83?=
 =?utf-8?B?RnlhNklNZklZTGxMb1h3dUt3SEpiSUROTVZNUzNWc1lqUExUZ252aHdtNGg5?=
 =?utf-8?B?MndaUE1sYUtRN2doZmk5eEExb1VDTk5NN0hmSW9hNDEzRXdtaUxFYWJ4VVNQ?=
 =?utf-8?B?TUZDVUlGSTBzNmJvUHNvNFlZTk5YMmJhYjY4MDR2b2FFZVV2L2FQZUFUMTBi?=
 =?utf-8?B?ZGlSQ1d1L0VqVS9JM0lrMUl5RFJjM28xVVg1OWJKT3VNRFhoa0g4N1JJUld3?=
 =?utf-8?B?ZmtJQ3lMN1NnVEJ6UnU3WVRuRG13aEJQRlVNaEYyWDZhRHJMK2tQVUxVQ3hY?=
 =?utf-8?B?cGlRclhtYXovT0I3bVA2MmdDTlNHTG5SeU9kN1YrdE1pdDlDZC9uZHZBMEp6?=
 =?utf-8?B?MnA3T3IzR1prN3EzWTVTLzJkdkRvYVRvNXdxNUgwRCs2RE4xcVY2TkxGcFNx?=
 =?utf-8?B?dG9GemxjN3B6TExVR29FRWY5eVFaVFhIdlJXbVhVWU5pMHQ2KzNzanFkYjln?=
 =?utf-8?B?K2x5WE1pL082V1RGRWZlYW1XcThuSlp6bk9yT0E4VmdMeTRHNWQrcUYyajNC?=
 =?utf-8?B?NzlwaDE4ejFvZVJPLy8zeGt0YzBubWpOaXYxR3VtSGRkQmxVUndrQ1JIWERm?=
 =?utf-8?B?ZDl3MVRvSmFJUVQ1WDJFM0pObU9yTjl1d0Z1aTExVHBSY0tkVW1yVHg4aERS?=
 =?utf-8?B?YW5kREI4ZmdDSVFHNCt5VWZGVmFPSVpQZlhHRTN1NzlqSExoMDFERkxtNUxF?=
 =?utf-8?B?L0tKL0RnYk4zRDZiaUcxa0hzVitQempac0ZPVVp1MDZkY0ZjWjZMdDdpNjND?=
 =?utf-8?B?b0FYMVY4MnM3U0paa1N6cmw1RzhnNm42UEZmZnFnbXdZdDhWVUZiUWEzd3ZM?=
 =?utf-8?B?SmlGYXZxMFJRb0NtY2FxaXpiNXR5MTNtYUZ3Y0FkQUtUdjNseTllYXE1Y3lU?=
 =?utf-8?B?QmFyNHphcDRibk1qYm5tdkQ4L1BoTmxGTWJDUXZ5Y3BVTGp6Zi9tWTIxN3dz?=
 =?utf-8?B?dEczdGsvbWxXa1pQWDYxVDVsVm0vc1FzbFJvQVIrVlg5YkNlQVVjVUxzdkM5?=
 =?utf-8?B?dU5uc1VSOGJNQlhnRUFnUkJKV2c1eVhpRDc3NlU0UnE1SHE1bHRVbXpUNzdI?=
 =?utf-8?B?dVdqc2pvT2o2Y2lMMmFkQ3lWK002U2VNWDJFRzdmNmhrL2xuOFRLclJoSzk3?=
 =?utf-8?B?NFNCWHo0SHcxb2kvcDNrY05FbVBDRmw4bW1zOWhtc1pOaFcwMkprTzFuL0sy?=
 =?utf-8?B?bGZkb3ZZU3dVV1kxRk42Sm9peFlleUtMWHhWdmFoSHZvNm16ZGYwaHhNWlVi?=
 =?utf-8?Q?GrkoLjzzX9trXH6kX0xkJiRgOSYoWwg/ANU8xtRlZybw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e80d3e8-5c4c-4e07-8010-08dd92a34806
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2025 04:53:34.2158
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB8756

RnJvbTogU2hyYWRoYSBHdXB0YSA8c2hyYWRoYWd1cHRhQGxpbnV4Lm1pY3Jvc29mdC5jb20+IFNl
bnQ6IEZyaWRheSwgTWF5IDksIDIwMjUgMzoxNCBBTQ0KPiANCj4gSW4gb3JkZXIgdG8gcHJlcGFy
ZSB0aGUgTUFOQSBkcml2ZXIgdG8gYWxsb2NhdGUgdGhlIE1TSS1YIElSUXMNCj4gZHluYW1pY2Fs
bHksIHdlIG5lZWQgdG8gcHJlcGFyZSB0aGUgaXJxX3NldHVwKCkgdG8gYWxsb3cgc2tpcHBpbmcN
Cg0Kcy9wcmVwYXJlIHRoZSBpcnFfc2V0dXAoKS9lbmhhbmNlIGlycV9zZXR1cCgpLw0KDQo+IGFm
ZmluaXRpemluZyBJUlFzIHRvIGZpcnN0IENQVSBzaWJsaW5nIGdyb3VwLg0KDQpzL3RvIGZpcnN0
L3RvIHRoZSBmaXJzdC8NCg0KPiANCj4gVGhpcyB3b3VsZCBiZSBmb3IgY2FzZXMgd2hlbiBudW1i
ZXIgb2YgSVJRcyBpcyBsZXNzIHRoYW4gb3IgZXF1YWwNCg0Kcy93aGVuIG51bWJlci93aGVuIHRo
ZSBudW1iZXIvDQoNCj4gdG8gbnVtYmVyIG9mIG9ubGluZSBDUFVzLiBJbiBzdWNoIGNhc2VzIGZv
ciBkeW5hbWljYWxseSBhZGRlZCBJUlFzDQoNCnMvdG8gbnVtYmVyL3RvIHRoZSBudW1iZXIvDQoN
Cj4gdGhlIGZpcnN0IENQVSBzaWJsaW5nIGdyb3VwIHdvdWxkIGFscmVhZHkgYmUgYWZmaW5pdGl6
ZWQgd2l0aCBIV0MgSVJRDQoNCkFkZCBhIHBlcmlvZCBhdCB0aGUgZW5kIG9mIHRoZSBzZW50ZW5j
ZS4NCg0KPiANCj4gU2lnbmVkLW9mZi1ieTogU2hyYWRoYSBHdXB0YSA8c2hyYWRoYWd1cHRhQGxp
bnV4Lm1pY3Jvc29mdC5jb20+DQo+IFJldmlld2VkLWJ5OiBIYWl5YW5nIFpoYW5nIDxoYWl5YW5n
ekBtaWNyb3NvZnQuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvbmV0L2V0aGVybmV0L21pY3Jvc29m
dC9tYW5hL2dkbWFfbWFpbi5jIHwgMTYgKysrKysrKysrKysrKystLQ0KPiAgMSBmaWxlIGNoYW5n
ZWQsIDE0IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9uZXQvZXRoZXJuZXQvbWljcm9zb2Z0L21hbmEvZ2RtYV9tYWluLmMNCj4gYi9kcml2
ZXJzL25ldC9ldGhlcm5ldC9taWNyb3NvZnQvbWFuYS9nZG1hX21haW4uYw0KPiBpbmRleCA0ZmZh
Zjc1ODg4ODUuLjJkZTQyY2U0MzM3MyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJu
ZXQvbWljcm9zb2Z0L21hbmEvZ2RtYV9tYWluLmMNCj4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJu
ZXQvbWljcm9zb2Z0L21hbmEvZ2RtYV9tYWluLmMNCj4gQEAgLTEyODgsNyArMTI4OCw4IEBAIHZv
aWQgbWFuYV9nZF9mcmVlX3Jlc19tYXAoc3RydWN0IGdkbWFfcmVzb3VyY2UgKnIpDQo+ICAJci0+
c2l6ZSA9IDA7DQo+ICB9DQo+IA0KPiAtc3RhdGljIGludCBpcnFfc2V0dXAodW5zaWduZWQgaW50
ICppcnFzLCB1bnNpZ25lZCBpbnQgbGVuLCBpbnQgbm9kZSkNCj4gK3N0YXRpYyBpbnQgaXJxX3Nl
dHVwKHVuc2lnbmVkIGludCAqaXJxcywgdW5zaWduZWQgaW50IGxlbiwgaW50IG5vZGUsDQo+ICsJ
CSAgICAgYm9vbCBza2lwX2ZpcnN0X2NwdSkNCj4gIHsNCj4gIAljb25zdCBzdHJ1Y3QgY3B1bWFz
ayAqbmV4dCwgKnByZXYgPSBjcHVfbm9uZV9tYXNrOw0KPiAgCWNwdW1hc2tfdmFyX3QgY3B1cyBf
X2ZyZWUoZnJlZV9jcHVtYXNrX3Zhcik7DQo+IEBAIC0xMzAzLDkgKzEzMDQsMjAgQEAgc3RhdGlj
IGludCBpcnFfc2V0dXAodW5zaWduZWQgaW50ICppcnFzLCB1bnNpZ25lZCBpbnQgbGVuLCBpbnQg
bm9kZSkNCj4gIAkJd2hpbGUgKHdlaWdodCA+IDApIHsNCj4gIAkJCWNwdW1hc2tfYW5kbm90KGNw
dXMsIG5leHQsIHByZXYpOw0KPiAgCQkJZm9yX2VhY2hfY3B1KGNwdSwgY3B1cykgew0KPiArCQkJ
CS8qDQo+ICsJCQkJICogaWYgdGhlIENQVSBzaWJsaW5nIHNldCBpcyB0byBiZSBza2lwcGVkIHdl
DQo+ICsJCQkJICoganVzdCBtb3ZlIG9uIHRvIHRoZSBuZXh0IENQVXMgd2l0aG91dCBsZW4tLQ0K
PiArCQkJCSAqLw0KPiArCQkJCWlmICh1bmxpa2VseShza2lwX2ZpcnN0X2NwdSkpIHsNCj4gKwkJ
CQkJc2tpcF9maXJzdF9jcHUgPSBmYWxzZTsNCj4gKwkJCQkJZ290byBuZXh0X2NwdW1hc2s7DQo+
ICsJCQkJfQ0KPiArDQo+ICAJCQkJaWYgKGxlbi0tID09IDApDQo+ICAJCQkJCWdvdG8gZG9uZTsN
Cj4gKw0KPiAgCQkJCWlycV9zZXRfYWZmaW5pdHlfYW5kX2hpbnQoKmlycXMrKywgdG9wb2xvZ3lf
c2libGluZ19jcHVtYXNrKGNwdSkpOw0KPiArbmV4dF9jcHVtYXNrOg0KPiAgCQkJCWNwdW1hc2tf
YW5kbm90KGNwdXMsIGNwdXMsIHRvcG9sb2d5X3NpYmxpbmdfY3B1bWFzayhjcHUpKTsNCj4gIAkJ
CQktLXdlaWdodDsNCj4gIAkJCX0NCg0KV2l0aCBhIGxpdHRsZSBiaXQgb2YgcmVvcmRlcmluZyBv
ZiB0aGUgY29kZSwgeW91IGNvdWxkIGF2b2lkIHRoZSBuZWVkIGZvciB0aGUgIm5leHRfY3B1bWFz
ayINCmxhYmVsIGFuZCBnb3RvIHN0YXRlbWVudC4gICJjb250aW51ZSIgaXMgdXN1YWxseSBjbGVh
bmVyIHRoYW4gYSAiZ290byIuIEhlcmUncyB3aGF0IEknbSB0aGlua2luZzoNCg0KCQlmb3JfZWFj
aF9jcHUoY3B1LCBjcHVzKSB7DQoJCQljcHVtYXNrX2FuZG5vdChjcHVzLCBjcHVzLCB0b3BvbG9n
eV9zaWJsaW5nX2NwdW1hc2soY3B1KSk7DQoJCQktLXdlaWdodDsNCg0KCQkJSWYgKHVubGlrZWx5
KHNraXBfZmlyc3RfY3B1KSkgew0KCQkJCXNraXBfZmlyc3RfY3B1ID0gZmFsc2U7DQoJCQkJY29u
dGludWU7DQoJCQl9DQoNCgkJCUlmIChsZW4tLSA9PSAwKQ0KCQkJCWdvdG8gZG9uZTsNCg0KCQkJ
aXJxX3NldF9hZmZpbml0eV9hbmRfaGludCgqaXJxcysrLCB0b3BvbG9neV9zaWJsaW5nX2NwdW1h
c2soY3B1KSk7DQoJCX0NCg0KSSB3aXNoIHRoZXJlIHdlcmUgc29tZSBjb21tZW50cyBpbiBpcnFf
c2V0dXAoKSBleHBsYWluaW5nIHRoZSBvdmVyYWxsIGludGVudGlvbiBvZg0KdGhlIGFsZ29yaXRo
bS4gSSBjYW4gc2VlIGhvdyB0aGUgZ29hbCBpcyB0byBmaXJzdCBhc3NpZ24gQ1BVcyB0aGF0IGFy
ZSBsb2NhbCB0byB0aGUgY3VycmVudA0KTlVNQSBub2RlLCBhbmQgdGhlbiBleHBhbmQgb3V0d2Fy
ZCB0byBDUFVzIHRoYXQgYXJlIGZ1cnRoZXIgYXdheS4gQW5kIHlvdSB3YW50DQp0byAqbm90KiBh
c3NpZ24gYm90aCBzaWJsaW5ncyBpbiBhIGh5cGVyLXRocmVhZGVkIGNvcmUuIEJ1dCBJIGNhbid0
IGZpZ3VyZSBvdXQgd2hhdA0KIndlaWdodCIgaXMgdHJ5aW5nIHRvIGFjY29tcGxpc2guIE1heWJl
IHRoaXMgd2FzIGRpc2N1c3NlZCB3aGVuIHRoZSBjb2RlIGZpcnN0DQp3ZW50IGluLCBidXQgSSBj
YW4ndCByZW1lbWJlciBub3cuIDotKA0KDQpNaWNoYWVsDQoNCj4gQEAgLTE0MDMsNyArMTQxNSw3
IEBAIHN0YXRpYyBpbnQgbWFuYV9nZF9zZXR1cF9pcnFzKHN0cnVjdCBwY2lfZGV2ICpwZGV2KQ0K
PiAgCQl9DQo+ICAJfQ0KPiANCj4gLQllcnIgPSBpcnFfc2V0dXAoaXJxcywgKG52ZWMgLSBzdGFy
dF9pcnFfaW5kZXgpLCBnYy0+bnVtYV9ub2RlKTsNCj4gKwllcnIgPSBpcnFfc2V0dXAoaXJxcywg
KG52ZWMgLSBzdGFydF9pcnFfaW5kZXgpLCBnYy0+bnVtYV9ub2RlLCBmYWxzZSk7DQo+ICAJaWYg
KGVycikNCj4gIAkJZ290byBmcmVlX2lycTsNCj4gDQo+IC0tDQo+IDIuMzQuMQ0KPiANCg0K

