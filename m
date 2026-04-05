Return-Path: <linux-hyperv+bounces-9999-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GPSlKtjs0mk6cQcAu9opvQ
	(envelope-from <linux-hyperv+bounces-9999-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 06 Apr 2026 01:14:32 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1273A3A0219
	for <lists+linux-hyperv@lfdr.de>; Mon, 06 Apr 2026 01:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC1543006167
	for <lists+linux-hyperv@lfdr.de>; Sun,  5 Apr 2026 23:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BFCA38425C;
	Sun,  5 Apr 2026 23:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Sejp5663"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazolkn19012077.outbound.protection.outlook.com [52.103.11.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF01326B75B;
	Sun,  5 Apr 2026 23:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.11.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775430812; cv=fail; b=gf0RY2KiDYSJicmueASQbrPO/eW+NHnYVoRbt2aSYhgdeY2BLXpZ/O7WkiloLJQ41+02QMVh7aafSxKDdN7/ZGVZ9FINACQetvTqCvsZAmyxkSPgvJi5Gdp8D1JsO1nYd+rIOQO3USn2aD2Z7+W+ktcQh5i87XIcYLZze1p66Pk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775430812; c=relaxed/simple;
	bh=mxzYC2Ms4r6w/kxeX/aASwIZnc+TsfrOtb/Vb0eZcBQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BFKui3mEFf7rHzRfLWyR8VDqxeMvAo63A10/AhrwVbQDnrwwdo9/WffL02CBkyugt05Q0XzIyI5X2a1BGygR4/2v0T7ZJH8NH8U9tq5xaOydPqbTBK7mQWhFWFpxG8/T8ty3CT3mogWGb65bnX5zrHFeVK0uC8fuv/2BM3m7cyk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Sejp5663; arc=fail smtp.client-ip=52.103.11.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yrBvpf9pZj1vbeAYgamht6Cyz2ooRBVrOYmqF0WfEnb3iK4Z/Tru3xFJhJug+6GtCC17f+JaGoGB/wqJ/ZRnh+TiQHYsmgsIdKemIcPV+H5Qz+NwglP0IJA5jY+72w4QS4NVY2wWolgAfcTupCJTLzTRbpQrIlslVA1CHAdZbLYh1iueFaRDXDKCEu8bncSvZ5jjxdSB4/J8lfS6ylIPtAKkM8qAExG3AXGDfjlBvdNGscx2zparQok4/d1CE9ufE31CRCXlRF8aDPd4vPPLCqK/Sby/frwlfgLlyS7hNDqvEgMZzC1NfJy5OHhkTZqPQ4FY6uOSoy4hS8iCkYoaKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Znjyqjr69eQcdI2ncKvdKeVLOaBjrb4QCLTIaxGrXCE=;
 b=upEWZzJqDYqOXaaDllYaa1z7+ILB/8pMb/lz7qBWJx4FwdSRCjr+kN0xSV9VRQRQTTs1b4CW0e2ju/jkvDLJomkldMvCK9k+3PHcwdwXCFVj2nDbgoOVYR+JlFmvkF0vFr57rcSAclE7WG6X6D7+EtlNwBE2rfDujOWoKXwVB7kEYU2cc57vo+lfB3RWqTU4poxv0HYC497p5ahb0idqVjIExLZOup3piu94vFMrL3R5+VYkjMPcibmeNbTKOrbWdqUriBQBU/t0B5/VBtl1F8FeTw3v8QmDLT9tM8vYUKC/hUI5yQGrH1qsHzvhw6gCYlrfNuvJpHvwHhaIuWq6QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Znjyqjr69eQcdI2ncKvdKeVLOaBjrb4QCLTIaxGrXCE=;
 b=Sejp5663QlaiwnkJ384ie+4GOOHO5zbmD3eXo6gbqMCaAzxX7NSI/QfO4Qv/FiECuiV7s5wwvCc8zJ+Xgblez2edLqahCZoi3Ij1GYYZUxqAzbafZ4YpahvROcg5NgrsS3DTRU9DZjNoPTumLCLOj4X+RsC48VpryUBDL65XsRo2PM9SCdl1I/dO+PodfbncfnXUjvyxvW/LTALVGqnQP9VBpCHhNMa3tgrlKDRPHBFpnYg62qiDTijyEunpNIH+i60Bm8faATv+NfwKMGlV8648SqAQVp2i5nS8PafQt8Bt8Uk5/+yO+qaXJA1rF+q2wEg0HWT2Ib53EQk0kLaqFw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by MW4PR02MB7201.namprd02.prod.outlook.com (2603:10b6:303:79::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Sun, 5 Apr
 2026 23:13:27 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9769.014; Sun, 5 Apr 2026
 23:13:27 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Dexuan Cui <DECUI@microsoft.com>, Michael Kelley <mhklinux@outlook.com>,
	Matthew Ruffell <matthew.ruffell@canonical.com>
CC: "bhelgaas@google.com" <bhelgaas@google.com>, Haiyang Zhang
	<haiyangz@microsoft.com>, Jake Oshins <jakeo@microsoft.com>,
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>, KY Srinivasan
	<kys@microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, Long Li <longli@microsoft.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "mani@kernel.org"
	<mani@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>
Subject: RE: [PATCH] PCI: hv: Allocate MMIO from above 4GB for the config
 window
Thread-Topic: [PATCH] PCI: hv: Allocate MMIO from above 4GB for the config
 window
Thread-Index:
 AQHci0NePIGSa/9NGkCUvIR93cd3gLVdwUXwgADOvQCAABBuYIAAnjqAgAALUwCAAMhuoIBsfVtQgAT9UMA=
Date: Sun, 5 Apr 2026 23:13:27 +0000
Message-ID:
 <SN6PR02MB4157F48F3B37D74E3A9F1AFBD45CA@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <SN6PR02MB4157545DAFDCCE0028439DB2D497A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20260123053909.95584-1-matthew.ruffell@canonical.com>
 <SN6PR02MB41573CD2EA6CD82A0C238F66D494A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <SN6PR02MB415759DBA9428256D379841AD494A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <SA1PR21MB69213185A6FE899BD2D4BFC3BF51A@SA1PR21MB6921.namprd21.prod.outlook.com>
In-Reply-To:
 <SA1PR21MB69213185A6FE899BD2D4BFC3BF51A@SA1PR21MB6921.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|MW4PR02MB7201:EE_
x-ms-office365-filtering-correlation-id: 98fb869f-8eba-40d3-dcc5-08de9368f1ea
x-ms-exchange-slblob-mailprops:
 vuaKsetfIZmcv7cN2CQdJd4XVKwegu/4gmvfM/dqyPbIhBrW5sBI7TsCJt0gc+/kowzt9xEC9IRt8QYZi4XO+QtZ0uemJ7gOEgMxkeZ3/xTbHkevEkBwMKuQxcBMbLPrByGuHZvpBIPMsbk85HtTEacsCu1839ZN3jLacg72qR5Z5uE3ZrJmVBH/IGXXpnUXgXI4oj/PJju50JbL8oLYI3aXk6Nrz9AtaKwd21UTAApI3W6jtld8bemxrXjm7/FP7yxpC2F6UiEh0vBi5afDYtRrt0UvjWpwFXRlgsL+k9L/ZW2NLBaqHjpg7lv5HJDMRJAth5I8EmOxue8E0hp4SZ1WHycy0U9HiTtPxn6kmhRLTou7PJjtMfpkl14/KZSjbny86KhLsP7/jzFmC3zVd3Ri7ZEhIqFLsmGbVt6G85FP3klP8uqHo5xx2v44CGDsU6uzPUlS+COd3nLrSQoGzvhIYb02Pggy8CtoBfpydptuErkEs0WtjkVCmNKi6BJZYVRGJOuIHqQMjYzy0I7aesrnVmXKLcVIZSNYwvekbot1SjwTv3u9NI5id99+xOXAHV0TZNykRyfKXBFkHvpdMypkYswIANVva/OSjIObnt3OwhL5K2ZlxEAR81dxChNc3MZuSh0rKCsgwoBLNnI/fiQ3ppDvKBNdvSTqFv9KPA++VC5YNbSYKXkSBY2q8kInOE9/vNFq4mA6ngoFOOmLC3N55IhtJxU+rQNrb5XnJ2HoRYa0Pv2T7Pr2j6ve+JLDt2eiVjFhVzOZ6yCRPvvjGkDvmuB+cLjdqkAfToT18lYvQTPHANd7G6c3HTjQLNg6
x-microsoft-antispam:
 BCL:0;ARA:14566002|13091999003|19110799012|31061999003|8060799015|51005399006|461199028|37011999003|8062599012|15080799012|1602099012|40105399003|4302099013|3412199025|440099028|10035399007|102099032|26121999003|1710799026;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Sshv+4cKhL1BtamD6Fz0NDOlJFEiX6Q8gAOZKasc62UZs78AayLlgxDB0/yR?=
 =?us-ascii?Q?lEz2/+H0N6diyvJxprwXJbk8mj7g4cAu09MExg5Pna4I0FsY6rbeJq47mbSW?=
 =?us-ascii?Q?Fk9bDqVWXD699ox0J3vsfVIxPxRPwI1Mm4mAZ1px2L0WU8OO2Fo5WopfXVbo?=
 =?us-ascii?Q?Owdcz4FTARVqG1dXsn0TwAqJI6UqRNcrQplsgIbQ4nFB2g0O6NNUr8dtnjDG?=
 =?us-ascii?Q?HvRXDdI4copf0I4wILaaFl/xEraSYOKFH6+KJE5ToZt3WE35zWVoFgmxqTbF?=
 =?us-ascii?Q?uzcx61Qvlf3WDHVculgDQsPm8AqwTqfss2k9HJoRY5x08wppsdws4Djh32/9?=
 =?us-ascii?Q?UgkhtcDMcmax4PbiJQdMskDX4EL2GMbIQxurdB2/PnH9Zkd+A1nF0qTq00b7?=
 =?us-ascii?Q?JTaXFbRvPSj1X5bYh60AzdE+SvUu6Nip5UvDB4+lMdONs5+Ji3ON0vLZmJIR?=
 =?us-ascii?Q?PUjUKVBg3XyKAfvGaeela/oOd1q0/T22mxsMt7iFdcd9nl/3PYYDGt04Z+JK?=
 =?us-ascii?Q?2VRH5Hfq+zdY/4l4mnaofFzMD7I2RDSxwFP8AtAlGrn38tF4UitZSP0MJeqX?=
 =?us-ascii?Q?hWJyuzO8kqoVE2Vjh1Twvri3cqxOSqGvCKWJ3po4dOqXBuwZuXkZP1rwPSNN?=
 =?us-ascii?Q?LpcgDTnuXKfS39A7t9PtY1d+MrmmX+iLRsbpT8KdHXAdJpuxz1E7BpaOVPxA?=
 =?us-ascii?Q?maKhbsdhBJJ24L6D89sVa3Mi+KJgT4u0NQO+cRGIw2gRe516WAYMoAfBxhCE?=
 =?us-ascii?Q?16rIdSvNf6P80tu5g6J5AiFCF8iJt38fXK5pCzbHSXuxxO/wPZzBufJ7TyRa?=
 =?us-ascii?Q?h+9YF/inX32uSfSq+Fg+jvungOguTiB5SJTX0cd7BemC7vVcACQzQ8SEWLUh?=
 =?us-ascii?Q?Dd9PgcTEyGDYL/obwfMml0ULAbsF//XpNUrXHD5W+K5amdR7uquaPzRjkIAe?=
 =?us-ascii?Q?Wch5sXcZRBHjxja+Cx5mvzcdSjg0vtCyzw+efW+M5Ls59V6FPJBXmFAiyfSx?=
 =?us-ascii?Q?aHFo1wADx/zeoOnJVwIWYWPZ7HAK5iqd8+s02N+isX2dTxAxtkZASCs1LxIG?=
 =?us-ascii?Q?sZ2EtUMGbrG8NoN4e6o/RO5pGviui/vLhvqK+TabDk8f+g5dmePvw4GcJM25?=
 =?us-ascii?Q?VSvzO4EfFAUnSkbk2jboJz2A2M6DEGc1VonDJYx/ylqFheYMOBXb+JE=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?bC6ihVaqpIn70fNYsoIS3tFM9EpF5f7FMDkWtjQ4lbKuEexkPXE5pnvGGgP7?=
 =?us-ascii?Q?UpSD0ej+mjjq/JkazY7W9Ezzepkt0QkHbLm54r0PUB0gjTUS1RIJiM7E7sqk?=
 =?us-ascii?Q?armLdyr9W543c3mpiMRqs8QHiPLQj7ljzQxHjtuGESogNf8t9ZXu9q6obXOB?=
 =?us-ascii?Q?eJuIL2g3GuWLRDvMgmpD8u3a8hgnAvIlNpaK7uJUY9mnYnqq0EReh+HTfVxU?=
 =?us-ascii?Q?ip3Ww2JAGRUI74lz2FUT8ncmvMdCOhN0ZChG789Xd98dLtJSZ75Pk9HUrtEa?=
 =?us-ascii?Q?Ray197Bg9cjE6LZr2VqLMfTZz4d97Xvb/ikvs0mXwlgCzhU5Pnk12Rsixl8w?=
 =?us-ascii?Q?hP7H9A391r+FWoeUkA9vKE5s8/qCpZ5sYN8MrQaHyiVcVs4WSd3yYEWyraDL?=
 =?us-ascii?Q?shWT7HWbnkjbdKkIh0Eoe6PVRrXow1YXhZImv998s/jfxtDQhJwmWWz1pvqp?=
 =?us-ascii?Q?7LnNEvchPOlrxCfpytxdr5YFkYBASHV8/UvnFAuyQLpHij0GlS05yfwkIE2h?=
 =?us-ascii?Q?WpZGMzU+lLrs7mJ4zCmlN6EIIvK21ccm/fyjmjFM4iQjg8TFkIBywMZy9QIz?=
 =?us-ascii?Q?TioHHRDyGYDQy7Q22F7oABGoRpzqn94LflmOntBe5saeofUBhrCd6aa/1Mz7?=
 =?us-ascii?Q?Hdp4RmbNqNWOqncibCq9IEHZvbwLKzCSqOjA/rLy2res7AGh7KgHmDiGbU2I?=
 =?us-ascii?Q?cIXZzotVJtWv6+D6GGGReNQiqxHPUzKWvfO71tCbzx6HbHCU6GhdD7s1KxvC?=
 =?us-ascii?Q?DdKDCIkwOP5DYdpfgBoGwgbqp+B+OCd38ah0ap5MYd8FJZcHoOyjwQXtRbBd?=
 =?us-ascii?Q?5HmG/59DuyqKUDzaveC3+yR5Iepo74cHiGYYe2dz8J/vmz92r+BRhzVXFEOI?=
 =?us-ascii?Q?3JMhTWTttzCx3wq5p/qLpBxh/gyMY2hw3WUgZpM+/D2bdxMgtwt5aUz4ebk8?=
 =?us-ascii?Q?u8OUH5Ukq1htxBHZ1LzVRG5wt2eV4JGU4yKPFKXSIkNA8OzfNvR7PmTKeVgK?=
 =?us-ascii?Q?H7X4werJs3XUNXS2+diPhC2foJeuNS5oYYfC0+/B7mXarQo3CqE11/Rvdz6u?=
 =?us-ascii?Q?4HdRJZKsniHUVFflvBP2AryTOIl6w3GtalaK/k5Q/2Iq7R7Z+VawYAObjHO3?=
 =?us-ascii?Q?JanCDGaEORAyAA7zvdp/zid8GdATWpomjf6Mm0DwYbljr/6UMsaswIrY3RQg?=
 =?us-ascii?Q?pNTxMv/INOcYLRvWEvrAu1IB53n3JlpOEUW2zbkJ7PLSUr1OLn3dO0csqMaJ?=
 =?us-ascii?Q?p6w3qywKMi1q/47CcKhG5cuh7sQAK8p+FdgLLHsVsTsA0kzZJ89ZnBUIy+x0?=
 =?us-ascii?Q?ZA5+36KwHgFltU+LEb80AjNO04qkmkEXPIa9qDYR45E5cVgWHZqLQ79kdZFJ?=
 =?us-ascii?Q?gVqfzMs=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 98fb869f-8eba-40d3-dcc5-08de9368f1ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2026 23:13:27.7540
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR02MB7201
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9999-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	FREEMAIL_TO(0.00)[microsoft.com,outlook.com,canonical.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[outlook.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,SN6PR02MB4157.namprd02.prod.outlook.com:mid,outlook.com:dkim,outlook.com:email]
X-Rspamd-Queue-Id: 1273A3A0219
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Dexuan Cui <DECUI@microsoft.com> Sent: Thursday, April 2, 2026 12:24 =
PM
>=20
> > From: Michael Kelley <mhklinux@outlook.com>
> > Sent: Friday, January 23, 2026 10:28 AM
> >  ...
> > One more thought here: Is commit 96959283a58d relevant? The
> > commit message describes a scenario where vmbus_reserve_fb()
> > doesn't do anything because CONFIG_SYSFB is not set. Looking at
> > the code for vmbus_reserve_fb(), it doing nothing might imply that
> > screen_info.lfb_base is 0. But when CONFIG_SYSFB is not set,
> > screen_info.lfb_base is just ignored, with the same result. This behavi=
or
> > started with the 6.7 kernel due to commit a07b50d80ab6.
> >
> > Note that commit 96959283a58d has a follow-on to correct a
> > problem when CONFIG_EFI is not set.  See commit 7b89a44b2e8c.
> > If there's a reason to backport 96959283a58d, also get
> > 7b89a44b2e8c.
> >
> > Michael
>=20
> In my opinion,
> 96959283a58d ("Drivers: hv: Always select CONFIG_SYSFB for Hyper-V guests=
")
> is not a good fix for a07b50d80ab6: the commit message of a07b50d80ab6
> says "the vmbus_drv code marks the original EFI framebuffer as reserved, =
but
> this is not required if there is no sysfb" -- IMO the message is incorrec=
t.
>=20
> Even if CONFIG_SYSFB is not set, we still need to reserve the framebuffer
> MMIO range, because we need to make sure that hv_pci doesn't allocate
> MMIO from there.
>=20
> 96959283a58d adds "select SYSFB if !HYPERV_VTL_MODE", but we can
> still manually unset CONFIG_SYSFB (I happened to do this when debugging
> the kdump issue), and hv_pci won't work.

Just curious -- how would you manually unset CONFIG_SYSFB? The kernel
makefile always resync's .config against the Kconfig rules, which would add
CONFIG_SYSFB back again. The Kconfig files essentially say that removing
CONFIG_SYSFB is an invalid configuration.

>=20
> IMO vmbus_reserve_fb() should unconditionally reserve the frame buffer
> MMIO range. I'll post a patch like this:
>=20
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -2395,10 +2398,8 @@ static void __maybe_unused vmbus_reserve_fb(void)
>=20
>         if (efi_enabled(EFI_BOOT)) {
>                 /* Gen2 VM: get FB base from EFI framebuffer */
> -               if (IS_ENABLED(CONFIG_SYSFB)) {
> -                       start =3D sysfb_primary_display.screen.lfb_base;
> -                       size =3D max_t(__u32, sysfb_primary_display.scree=
n.lfb_size, 0x800000);
> -               }
> +               start =3D sysfb_primary_display.screen.lfb_base;
> +               size =3D max_t(__u32, sysfb_primary_display.screen.lfb_si=
ze, 0x800000);

On arm64 the existence of sysfb_primary_display is conditional on
several config variables, including CONFIG_SYSFB and CONFIG_EFI_EARLYCON.
(see drivers/firmware/efi/efi-init.c) If you can take away CONFIG_SYSFB, yo=
u
could also take away CONFIG_EFI_EARLYCON and end up with build error on
arm64. So I'm not clear how this approach would be more robust against
invalid .config changes.

Also this recent patch set [1] submitted by Thomas Zimmerman is even more
explicit about sysfb_primary_display being conditional on CONFIG_SYSFB.

Michael

[1] https://lore.kernel.org/linux-hyperv/20260402092305.208728-1-tzimmerman=
n@suse.de/

>         } else {
>                 /* Gen1 VM: get FB base from PCI */
>                 pdev =3D pci_get_device(PCI_VENDOR_ID_MICROSOFT,
>=20
>=20
> diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
> index 7937ac0cbd0f..78d7f8c66278 100644
> --- a/drivers/hv/Kconfig
> +++ b/drivers/hv/Kconfig
> @@ -9,7 +9,6 @@ config HYPERV
>         select PARAVIRT
>         select X86_HV_CALLBACK_VECTOR if X86
>         select OF_EARLY_FLATTREE if OF
> -       select SYSFB if EFI && !HYPERV_VTL_MODE
>         select IRQ_MSI_LIB if X86
>         help
>           Select this option to run Linux as a Hyper-V client operating
>=20
> Thanks,
> Dexuan


