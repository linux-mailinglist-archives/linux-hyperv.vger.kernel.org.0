Return-Path: <linux-hyperv+bounces-9976-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eJ1bIMdn0Gla7QYAu9opvQ
	(envelope-from <linux-hyperv+bounces-9976-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 04 Apr 2026 03:22:15 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D621F399723
	for <lists+linux-hyperv@lfdr.de>; Sat, 04 Apr 2026 03:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 591A43039892
	for <lists+linux-hyperv@lfdr.de>; Sat,  4 Apr 2026 01:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF3A919343E;
	Sat,  4 Apr 2026 01:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="AAGD8Mrl"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazolkn19013088.outbound.protection.outlook.com [52.103.20.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8684F1A6805
	for <linux-hyperv@vger.kernel.org>; Sat,  4 Apr 2026 01:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.20.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775265732; cv=fail; b=LA9C8yQkn4Gtg2K+NO3LpQDl65YGQbnda7H/yom+FQZCnSWKUzIQD9/5Ljg4jcx9J7NCN/SGtaXyQ9M4+tqbVvPOaYXgfuQBJfT8Od5O2KbPed0FCofrd9PI8CCQy0RlMiOHDZhq59AaB7mQm17tCPcjw3rakswjIvejwPh0jT4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775265732; c=relaxed/simple;
	bh=gtZXLmAeIBCRJB34+wGI/G53KvlyYtlVktqBjDJeMwA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eluAft2HN/hEZ2CXwYrUzKP7GwUHZ3/h9E/fchhnrZXi406sk0xJW7u8mNBTOviOKZwwXgQN6CjbRrSxcFP3CpBUK8ZihhGCq72WC/qyypfDWgUCsRsP6LMsa3Y57Lpd0KPv2Nl/BOPN6jax14hbb5/wqaNniNkptMoVhbB6NBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=AAGD8Mrl; arc=fail smtp.client-ip=52.103.20.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vQgse+bcddZAl2RT+ADoiUrBsVIoSQM8bRY0Lnd6+WXapjYVjQe1/CLF1heFojlT/8toui93mhAvPvM9XNzinkuZGgPwmXOsa6hbCckGoxTSy682aT0Dn3sX+mjklYwoMljrFPKmKRYliNRxtKuy3WAz6TM6jfkFC5TOKvFmVyYMKpETh99QCMNgMwpWjPR9NanJwAsbWih8/4V512yUo3RZJt8DYg9TlaeKrDrOG9CoemEZ2cGK9E22rby3F6zqGbJxtfPXLe83m0dopWNtOxp0X98SXFQTWfwxFhcBmOqBCCxqijHRud9eK/QvUx+lvL62wmGzuGTJwloHSGm9+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YOC2WsfUzF44df2V+9emGBRkNMbII2juOFeFbDStCYQ=;
 b=pdzHpUFKQOITzPLf3b9p/aDyOBgiqB863RI9c2ro64/lOehFlpHRyZzVR4wF1inZn1BRaeCj4kUjQtgZWjPC3R21b2zRZ5IWPbcdHv6G0JcNilVlwvthj/DwSMqxnu2CI1O91ybx2BKtaVvSQobMMFZAvWCLwtk7U+aVaV/k77RbEGWt5pSE0g6xBTHHv/vvZibRUPgC+sKwBDXWCYkLe0Toib9NcIMW5jTIuohjzAydONJsdH0+duOGCqzZJFZOmj/sIfoqD7jSP8ftntFyijMVe4kVslRwX8apECbAhkr0RvDrmCmR70YVwPIOiohd4qP/+85ZuV96O8FLv2wL+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YOC2WsfUzF44df2V+9emGBRkNMbII2juOFeFbDStCYQ=;
 b=AAGD8Mrl/YGBKpher08De5r+xJLUKr3GklwQsXUCpF5Qp1Zdc/fWJaVCdZv375tmpsgcmRtMnXe+heBU7pQmUFrWnC5ET3Ri9TSmluSVwcGFW5WR7AsNESrUjBcE/1rd/MSwsDc2F5v/9SNOc+PVKAWofiBzqrJezt9+aMytNh1z5Be6ilXrzYkLB8KgB7HGVv9P14jgjYlrEaaKkSW3cUOL87/Fjki20Eoo1P4fda4gHzXJlY1DRqflE9y4x74sU5BsCg733LAc1i6G3xjyYL0pytQBQ+2jDAp5xgy0om/zTpNtCILD+68u6LSfI4LlNqj7RtvL+aNb0Ous2mKdoA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SJ0PR02MB7424.namprd02.prod.outlook.com (2603:10b6:a03:29b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.24; Sat, 4 Apr
 2026 01:22:08 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9769.014; Sat, 4 Apr 2026
 01:22:08 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-rt-devel@lists.linux.dev" <linux-rt-devel@lists.linux.dev>
CC: "K. Y. Srinivasan" <kys@microsoft.com>, Dexuan Cui <decui@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>, Jan Kiszka <jan.kiszka@siemens.com>,
	Long Li <longli@microsoft.com>, Wei Liu <wei.liu@kernel.org>
Subject: RE: [PATCH 1/2] hv: vmbus: Replace lockdep_hardirq_threaded() with
 lockdep annotation
Thread-Topic: [PATCH 1/2] hv: vmbus: Replace lockdep_hardirq_threaded() with
 lockdep annotation
Thread-Index: AQHcwepdrKBOXzId6USmM56dY1Icq7XN/Ekg
Date: Sat, 4 Apr 2026 01:22:08 +0000
Message-ID:
 <SN6PR02MB4157524E39FC4ABD058A4A52D45FA@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260401151517.1743555-1-bigeasy@linutronix.de>
 <20260401151517.1743555-2-bigeasy@linutronix.de>
In-Reply-To: <20260401151517.1743555-2-bigeasy@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SJ0PR02MB7424:EE_
x-ms-office365-filtering-correlation-id: 1c24c0f2-8cec-4f67-f38b-08de91e89729
x-ms-exchange-slblob-mailprops:
 EgT5Wr3QDKyO+K31TYcDJnS3Nb0QmDRHjg0+Xk0ATooWxJHkxycy4OVci/mcf+T2x2sjRbps0oKSLid39msWiy6A7voVMwBHCPeY10rnQugut4UmCFyJw7sxQZK0Msn2LvoVRI4H3132C6f8BdvAjk+eL2G/ywBNATvsVNdGj745p3gFEDJh10NbcdvgELfZ4UgHQsU6pMgmEOwLwCPYe6SJWOnBhynIgy4Au74bdcpKXVETwNqbGiYCvDgLWRgc+0Yml8SGYQYjBuKaJNC58mVW3njyO3BYL8t+zdU58EigwTPgS8EzZrfdIAtvqCFOoH9XBJN+yJk5+lEBymKbCRO2PTWOvsetNIU8lEmFC+V2F04d6xBqZLni1soShVzlO0xzOQZHA44aXI6zKPnyoefOUYnAWxmQAfBWj06YZ/Ix6vnuQ+X3Bv9G119d/iklDhVZYKwF8XNL1G49IGsxjflZlSLt+eNUv0I1Cf8iMXEyRI2c4WjqB2+oZCHrKrw0x4QuqIxLZwNAWcy2JE8zuVy2va7Xs0eBtnZentULf91XLd7ZRQHLepsqqM2pvXDy5Zl2GkoI8vWjqZJch5Rg0bGdEBIkAJNmehg+TWXSJEKvOfCgJ3TvpDe9b2TmNLHlKZx+DpYQbpHPFetJwv+cz6WX+wPY+gYwOTmVfwTlxUeSjTOtgzntnr88txJChn4lUk1WGnrpKjZdWNCtbpAwjAPozMCHz6fOyGPQQr5jsvU=
x-microsoft-antispam:
 BCL:0;ARA:14566002|51005399006|13091999003|37011999003|19110799012|461199028|31061999003|8060799015|8062599012|15080799012|40105399003|440099028|3412199025|26121999003|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?qlvFLegMcPjRydxd/4TFueoqJgoMrW1WxII1bZOZ80XuVqJAbKHNIhR+F2V8?=
 =?us-ascii?Q?xwC6lcEY4HeubP801vzEVI7hAvcF3qvudsEfGAIaG/K4Nhck2k7jH+dois0y?=
 =?us-ascii?Q?eOuJQ9Zq+IbbCTED4HtOuLspYbBXWRXB6sh3/B3z8JU7dD83l5UY8vP+Sy/c?=
 =?us-ascii?Q?kxPz/M6cNMuAUNHjJ6CKsU2cGSmVhrDBWlHAHkad3fDmzcg9BONH7z4Cqx/i?=
 =?us-ascii?Q?1G2DQtDBoJy+texp0QeAtWN0wEP3vFjplmf5rh+PVSIC1utaIeFQO1AZvTmN?=
 =?us-ascii?Q?mEZIHQQ1htmt5PrCgRmoOCveaQSxyh8iVc7z3PDdqLJI2BFbcan0mpCcSFKH?=
 =?us-ascii?Q?fEIU36CBkuLVMp3rcrTa/HRIJTakZG/Ro/ItREEpOAIc/Xivw4i5IrMGTtyQ?=
 =?us-ascii?Q?e9coLDAZevPTeHIUJaDVx/zlLZMPSHY3DaBcwSMCLX4sMG83YeN9Wn2zeyGL?=
 =?us-ascii?Q?JhrFfFxwCjTuZ9JTZNlSHH21ghNO90569lNTP3q4ZNxgcqMfKdQ95IBT86HE?=
 =?us-ascii?Q?2w5ZPZ7URTo7fuXt1509lp5QM7Cxqg8OYGHXN00NcaZH4wdatSKiaf4fD3Lj?=
 =?us-ascii?Q?cZEr51YQZ+CDZ2f3EdaePKOhSolYKeG5TAGk7MQc8nwTo+gmMyPbUQbdfejE?=
 =?us-ascii?Q?2uah63pz1VOnRJWzVK0JPRm+rGcz8YFZap35K6vDkAQRkwnSXya7SMU0LJXg?=
 =?us-ascii?Q?SSyS0xGNn/zitRavwlGQHxaImS8sUNX6FHtexKoNiX5bEEYHJvd5dljtX8ex?=
 =?us-ascii?Q?X7gAypuRzpkcx+bzHuyakb+4EKipZmpP2DUmYEgRGKbHO8ljTQYgTUw/yzR7?=
 =?us-ascii?Q?Sz2iEvmXD/hhWOfewaPrBxrTsYxkYP3jhAoT1WNP2DimB62niw+CzfrWKBWi?=
 =?us-ascii?Q?20pEbslzSNaQei8nPZttxeFjJgLDWrpqATnT4lPujrcSlJTqdx0MEc58ColU?=
 =?us-ascii?Q?Q9+Mic3EIN1Vu4D2WHnlFjdWqYhpDcZkTSSqJs3yzQSkm7x+qFY6End/Wa8T?=
 =?us-ascii?Q?6A5L?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?p8CHdEYbnjXR+fGKEdeW+AGJ6K81cOBSC3Y+IcrFvi/KTCp00LAqyHxR6BmD?=
 =?us-ascii?Q?T1BWIVmgSNlvjNqhMsq7yBsgE81il10C73cH6betb51QajT56ZdtZMur31MK?=
 =?us-ascii?Q?2lntkAZ18/fp13IwNG2AmCL9TuuAgbxLgjbr5ihdzWx90f2YgwUks72GXQSS?=
 =?us-ascii?Q?Lu49LhbLJKAvjM1SX+gEDXXL4rvFdnSaXwUnslagzVmVKNyGsGReG9+BIsC+?=
 =?us-ascii?Q?AbXEQSVIBx1OY+73xDvBCfkJeQkxCn87hnu8xI5yjxX5MSMkMqD2XRvbWMML?=
 =?us-ascii?Q?XjEwdhsMg7iz0z7eVpaUEIuvuOvrLB/oMwL5XhO/1U7OwbDBJGIoJ2ZRLJuT?=
 =?us-ascii?Q?ThZFPsNXYJMXLsumRtruqsl1qAN6bsQIiCg5Etqp7ON2hCzp79ynA4fkjz1m?=
 =?us-ascii?Q?6V1X/DJOJYDYjdVKD+ZhoL3NYLl0q+MqbGE5vi/rEBr92PYOacvbiTlYa0o/?=
 =?us-ascii?Q?6P8T3Ue3cv5cy8vG+h3psq1TgvoH1WFzBLRB1ybi2/cet7K/Bz2v2Z6lfo/b?=
 =?us-ascii?Q?FPFqVPXzQ/wBntwattQIku/pOEPxi9oQySqTSkmUpV+jUrpP69NK7ahaFoDi?=
 =?us-ascii?Q?yJ/ssub5uC73IH43ymXPm7PEHV5CTATu8kdzBLV4fFE9lGyls1A23/4Ku90f?=
 =?us-ascii?Q?YsE4f1qjmNd1FseukEftw6zGiUYrEzYDBHnhvPtcQXJemHh4y7ApVT99MQyj?=
 =?us-ascii?Q?jrq+1YqvK+mhUt4yRKDxkKgdVpDyXMBlSy0BO55pIWwRUvrXTOeVRDzLZlYy?=
 =?us-ascii?Q?Zt5fkv7BdwnX0hwuQyP9mbjvnwhwXISEHxOc/IGj3raCiGEO22MoIfjWWurN?=
 =?us-ascii?Q?deXwG5Ulcd63zKqEg22D6iQ0705tQmN4JpyXQhpAXzoC3xIVcJhvQpLB70vw?=
 =?us-ascii?Q?0eL5V93TeAkPMQ97WrfvpDdOfwoWr9U3UnOQsNwSpOu58dswqg6TwcQDBXpR?=
 =?us-ascii?Q?A1j0A6vB0dxgWfAiIrMnXGF+ckDQHfxVbCumIRdHdNG98m5iNOxAihCUcee+?=
 =?us-ascii?Q?OrOWDB8V8+q0L3g8g5H5Y97YwHJzkKDjSCjRmVe4LeHHR0tAMgthvZFglrAC?=
 =?us-ascii?Q?RawE5yvmKQ71F78/UeaSBDmTx7Mbe9CqQ3mcVMeisqqcTyqi4l80xpsgjRwY?=
 =?us-ascii?Q?E4pFXFPEXLjrxiHil+lfI/z4795rjfa9KVdNKFmkNdVKBIMivDav5D3z8W2b?=
 =?us-ascii?Q?4IjWetRK7WL3c0FhWKl+ckqodkzCWGzYshYBhOgiQ6kAxV5vxntB8ewxO8H1?=
 =?us-ascii?Q?HfXqYh+l/JHj+Q/584p2K31i5F58zcndGUsEvvM5w4V9rxiWZnaqZhUMBqUx?=
 =?us-ascii?Q?FY86GWwA+Z4S7koxKI6u49pCvmg1KEYtsf+p/L7vviYgoM1IiW1m6KYMI5PR?=
 =?us-ascii?Q?dblosCk=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c24c0f2-8cec-4f67-f38b-08de91e89729
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2026 01:22:08.7173
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7424
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-9976-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,outlook.com:dkim]
X-Rspamd-Queue-Id: D621F399723
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de> Sent: Wednesday, Ap=
ril 1, 2026 8:15 AM
>=20

Nit: For historical consistency, use "Drivers: hv: vmbus:" as the prefix fo=
r the
patch "Subject:" line.  Same in Patch 2 of this series.

Also, any reason not to have copied linux-kernel@vger.kernel.org? I know th=
is
is pretty much just a Hyper-V thing, but I would have liked to see what the
Sashiko AI did with these two patches. :-)

> lockdep_hardirq_threaded() is supposed to be used within IRQ core code
> and not within drivers. It is not obvious from within the driver, that
> this is the only interrupt service routing and that it is not shared
> handler.

I presume you meant "routine". And what do you mean by "the only interrupt
service routine"? And why is the lack of obviousness relevant here? I don't=
 have
deep expertise in lockdep, but evidently there's some conclusion to reach a=
nd it
would have helped me to have it spelled out.

>=20
> Replace lockdep_hardirq_threaded() with a lockdep annotation limiting
> threaded context on PREEMPT_RT to __vmbus_isr().

Again, I'm not clear what "limiting threaded context" means. But see my
additional comment further down.

>=20
> Fixes: f8e6343b7a89c ("Drivers: hv: vmbus: Use kthread for vmbus interrup=
ts on PREEMPT_RT")
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  drivers/hv/vmbus_drv.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index bc4fc1951ae1c..e44275370ac2a 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -1407,8 +1407,11 @@ void vmbus_isr(void)
>  	if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
>  		vmbus_irqd_wake();
>  	} else {
> -		lockdep_hardirq_threaded();

I see two similar occurrences of LD_WAIT_CONFIG in the kernel:
__kfree_rcu_sheaf() and adjacent to printk_legacy_allow_spinlock_enter().
Both occurrences have a multi-line comment explaining the "why". I'd like
to see a similar comment here so that drive-by readers of the code have=20
some idea of what's going on. My suggestion is something like this:

   vmbus_isr() always runs at hard IRQ level -- the interrupt is not thread=
ed. It
   calls __vmbus_isr() here, which may obtain the spinlock_t sched_lock for
   a VMBus channel in vmbus_chan_sched(). If CONFIG_PROVE_LOCKING=3Dy,
   lockdep complains because obtaining spinlock_t's is not permitted at har=
d
   IRQ level in PREEMPT_RT configurations. However, the PREEMPT_RT path
   is handled separately above, so there's actually not a problem. Tell
   lockdep that acquiring the spinlock_t is valid by temporarily raising
   the wait-type to LD_WAIT_CONFIG using the "fake" lock vmbus_map.
   If lockdep is not enabled, the acquire & release of the fake lock are no=
-ops,
   so performance is not impacted.

Please review my suggested text and revise as appropriate, as I'm far
from an expert on any of this. The above is based on what I've learned
just now from a bit of research.

And thanks for jumping in and making all this better ....

Michael

> +		static DEFINE_WAIT_OVERRIDE_MAP(vmbus_map, LD_WAIT_CONFIG);
> +
> +		lock_map_acquire_try(&vmbus_map);
>  		__vmbus_isr();
> +		lock_map_release(&vmbus_map);
>  	}
>  }
>  EXPORT_SYMBOL_FOR_MODULES(vmbus_isr, "mshv_vtl");
> --
> 2.53.0


