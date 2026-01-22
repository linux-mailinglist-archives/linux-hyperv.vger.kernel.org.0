Return-Path: <linux-hyperv+bounces-8474-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KGTGNGKHcmnAlwAAu9opvQ
	(envelope-from <linux-hyperv+bounces-8474-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Jan 2026 21:24:02 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E9DE36D64C
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Jan 2026 21:24:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 945EF300B9EC
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Jan 2026 20:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A964A39CB34;
	Thu, 22 Jan 2026 20:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="XCH5sifE"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazolkn19013093.outbound.protection.outlook.com [52.103.20.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270EB353ECA;
	Thu, 22 Jan 2026 20:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.20.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769113437; cv=fail; b=M0GFgyUMGVVKkNMxVvxLqSUax/p8gAXfhglezHfxFnP+9eNQ5A2GAkw5NNpIacKrmvZdecDX2pMeZdxHxSxXBZTwiSAUEjHkVTwwIOsHylahT5Ia4esWk5K7tgZzfrNHNx10xpk4Jup26E4GIMQ9wQ5HQJguIBxcI39+8dmAgNs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769113437; c=relaxed/simple;
	bh=i7h2+za/EHZGgvLFWW3Bb2DQpnXB+1ITpTphtcnCIOA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bxGsU3Xo8ADxuipHPSuxfZ3A8k285bK/S1Glki8o/GK8e2MGV+/jUYosNWcFCx7bHG6ONkcOg+nil/FeBvs63uDo07hd7E4Zb9r4TjaD54FRzYmnXcc+j1vThqxfEK99eH4GY4AwpI+H+6FmIQ4sJVSLrOBMloQJO2wl69bQPSQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=XCH5sifE; arc=fail smtp.client-ip=52.103.20.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NaeBlrwtGbu5tyCz5SvHY3pHNyMjj03TGbC5LD/Xkcyd/VH08zlhmENnp0/vfzQV7GsJHos+u6+jNEfVVfTu2mzDyaBpYqZC7CY8rHs95+afMGmjNHSxqOVLz/nwN+FUl+wzynl98Mzu+jtH+NdZCeiu/1M6Lxtt9lkuIWpNQsHVjcmzTYSRwqNfBV0nPfZJ5QtC2VP080b8NFRYwz30OS4i+JM6p8MMRtWjihLARqBKKfLS/7YEoGEUjOtWUY9L+eV6AXhcGHOZPjVM9ZYAVJ2y2MaBCCaQ+HWfCdMiduqdnnkXYrM/x59y7zXNN2w0Hx1eG7XHXN4N5eowx/LUhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D35TU3ZnwwD96+06xe6ipaWi67rUrf1irtQLNDEgurs=;
 b=l5gwGXTzTRRDJLfOFZv6b+9jj7etgvlI+y38rbmglvE8bdHpgUtX/42IlDcOY97EcQQsOqF1DAMXg45jw/xejtLJarrFsark2XkSI/F/a/OM/eCrQelXImPF/xHVCCMziikRZ9P0Vr78s8lvep+DAG30RiMbGLX8hlxoeyoTaCJdQEBhaa2xhui1ayKR4rAK8OqEnIoCtcQ9ETNdJfyY1ojLdB53cvj1A4F3TOP/mmrc6x/1qJ57xsO8294bYKBg4yJYHyFE1s4D+CHr4L9nwDYe1/BnNrDwMjZQs+ZltNRLvT/exjidi8uQ6PPel/e0ct2rtA/GoeCcdaqfpVxZsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D35TU3ZnwwD96+06xe6ipaWi67rUrf1irtQLNDEgurs=;
 b=XCH5sifEV5lBxZPfPU6PqNaYCn+Ae9AIdbyA79QpopcxZKpfAHsU4oZ3mYIDDvQSxlDFlfH/M/7AXOc1mdF8BJK1Yjo5fX0WebjA2V8gRjdDdnxWiaPsxb26+Z6x1ym/lJrfh9u+F9GiqSk34NLNcxHabV7i8+I9gevoRovHaSUDoOemGnpSNjBgwEdch7iR+LGLosCGNMGK5b3KWohhAWSszeVi+ZcLTJiR+2Y0wQok1h4EsQUX/oKj2A5ulsNYsLSyU4qhLtIAp4ZqBD6UwTheXIc8SmME2MEgwnYgSq2P4ttR/5AOi+uuq/SvrfoJ/KeWGLycfmljPYD625CYsw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by IA0PR02MB9510.namprd02.prod.outlook.com (2603:10b6:208:403::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Thu, 22 Jan
 2026 20:22:51 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9542.008; Thu, 22 Jan 2026
 20:22:51 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Long Li <longli@microsoft.com>, Dexuan Cui <DECUI@microsoft.com>, KY
 Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "kwilczynski@kernel.org" <kwilczynski@kernel.org>,
	"mani@kernel.org" <mani@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, Jake Oshins
	<jakeo@microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] PCI: hv: Allocate MMIO from above 4GB for the config
 window
Thread-Topic: [PATCH] PCI: hv: Allocate MMIO from above 4GB for the config
 window
Thread-Index: AQHci0NePIGSa/9NGkCUvIR93cd3gLVdwUXwgADOvQCAABBuYA==
Date: Thu, 22 Jan 2026 20:22:50 +0000
Message-ID:
 <SN6PR02MB4157545DAFDCCE0028439DB2D497A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260122020337.94967-1-decui@microsoft.com>
 <BN7PR02MB41486A6DBF839D5BC5D5BC2ED497A@BN7PR02MB4148.namprd02.prod.outlook.com>
 <DS3PR21MB5735C620871D15F75A9B7BAFCE97A@DS3PR21MB5735.namprd21.prod.outlook.com>
In-Reply-To:
 <DS3PR21MB5735C620871D15F75A9B7BAFCE97A@DS3PR21MB5735.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=04fd0f2d-618b-490a-a536-685b349fef9a;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-01-22T19:05:02Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|IA0PR02MB9510:EE_
x-ms-office365-filtering-correlation-id: 5640e4c1-fa43-4ca8-02ea-08de59f40425
x-ms-exchange-slblob-mailprops:
 WaIXnCbdHrPy8Gg0T1tV+ubdyTLMpos/xMTiDdqg6wCDTjrcviZWIXVCybGSzKCriMTnqTLWJEhM/xRM0Hx9ZffOfNfwNhHqzSpMo7g9r4T9ZGloD302uuUs9oPvtgz5fJX8fsYEekEhUgnlq12QntaHIMAX4rweBDGcP+oAeqfETJCreM1SlvablyiJbV0GPsT5Ms+0VO92m6AZvbzFS72xOLCSAO/zNYoLFXeL7p6fPF/3XJ1pQRYDw3+mY/Qx3oF2+O1zM7OnTFskHPg+QXfrVvoDQIY/O3DdIgxn6Mct/b8e7sM/pQqo+eRNVsm9y9NYgDW6XXZgGMHB1G/iCXsqfJLJNfN6Gu7T7FPHLUT+kIs0awExFoL4tCmZhcG6BCEyRlbg1T938EZyVbpWS1SlDbIp9KUIJ5aOt7NyqzgWTISY3fOASkmNKRB5BiBlLnKsDPWIs3jjhpc0i2yziqQYTs65i8esxo2m+rNpXmDhdKqwu/s0O20HcGMhr5WFV71KIG6QoY1ZyWhsQCcJHP7HMtCPszYGnt6J+a+e73PEhpUQQmJxuaVKk6dWknWQ2U0nyvlXerZrxBPhB5+qJ0ihWGX1Avx/aadaydC5bgF/VulyI6eFbpYBFIBInTTlH7HiEPMN/7rN1teaIlYteDPswE4S+0IDLzINUAifzArG2rJ9RphfHfvJbCyl6GPpy21/BWenxGLPqO3ZoXLxJRN5AerXdmIrtsRXJ/6IjTskM2gNJdGGChxmugPRHeKYvnLAB4X7aUI=
x-microsoft-antispam:
 BCL:0;ARA:14566002|31061999003|461199028|19110799012|8062599012|12121999013|8060799015|13091999003|51005399006|41001999006|15080799012|440099028|3412199025|40105399003|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?KsDCMyB2ds3Xrt34GZDVkuRSPjcIgTpftay7hlsuN4ZYL2KR9cFQLpnAMSGK?=
 =?us-ascii?Q?5VbSuZNOUnyNzzWKNXP0C80n5Z98y86DGu6fLih6RvjHl05UUfQLJsjdg20b?=
 =?us-ascii?Q?muawJxDs+lKSviSGlgQFZ/pF8A75h5/8n+0R4rE6ZbIFE09EqlrL3WRBnsFS?=
 =?us-ascii?Q?n0NFq5qT9CSHOoGW5kqi8fj+4Jweq3xfXE1vkEZLLWZOSQwV0LrteoFvmaBN?=
 =?us-ascii?Q?j1w8IQBjbIAlb0x4Np0aRGYadAIHqNV16v7Dd0oBCCdH+BNawdCZh35PBPWK?=
 =?us-ascii?Q?JjHzTkfS5GyJppUNOhuWz/V1+6R5sn11dJsRbiDNqmPdXTNfu3zTvyL7LOOr?=
 =?us-ascii?Q?81/aHHZs1HFQPnfHiBZ4+F2D+XfWrLilg9yTr5+0h2yqtaPi2yyipRFTWNMY?=
 =?us-ascii?Q?YJmbFP5BBNdbRJiKZ2A8Rx7AA1vJSucso5yaANt1SW4KMH37IrbMkuQzwYIR?=
 =?us-ascii?Q?BCY3QwsICnj2Dna8WjNE1J9wv1CTNeCX6p+P4KwcvQsuDWlEHSbuV6OD/XvD?=
 =?us-ascii?Q?ZnFjUajyzsor7kjm1dObnUZZ7Zf7ITZ5JnJiv/EIcIXaGqsvCVOiMH36o4eW?=
 =?us-ascii?Q?k2+OVjA2qnESVPQX6kawftk/da4niToQrUCJZQTfyJeW6vG0SDMU+rzbFDsV?=
 =?us-ascii?Q?kmWB5vSwdTfI7pdiAXRkOPy8XKC0XldwqK3dcNFLg3moRyMgOA/RpEhEXA+P?=
 =?us-ascii?Q?mmER40P6DtaWKJfgL5eSFT+xSVO2sNV+UqNsY0Df8YWs7gP8w8P+Ad/bh1h9?=
 =?us-ascii?Q?7pp1og1idPFvs7i9TjOMJ4KxMt6oV9qDmczRi/cdTDGStqM2BhffcnHR+lMG?=
 =?us-ascii?Q?r27aOO62Sew0MVPJ0nJwcvnUKujkqCQ1Iphoajfn+xP08SlcLWcDEzbmAsLx?=
 =?us-ascii?Q?rnde1LA1I360gN4UVR74nsneO4o+TZNalICRiAtbKSeuBXEZIvW+y9Pc0SJc?=
 =?us-ascii?Q?TcrPXLuAQ8KwbE9Z+BDFwSebYDM1QH9RFvS61FAwSSqT7MURw5shjo1Z828X?=
 =?us-ascii?Q?mosVfdnTiG62LOYQwxvEKzX7cT8ckXFBraE2SHZ0OczlZUlvzWNQMaCjSz4r?=
 =?us-ascii?Q?qQUpVoHujLQC8GsWec/wVwpA+znP4j0HWKkn72n0QeUyF4WFBPZo3skFXo8I?=
 =?us-ascii?Q?pyhniPDM+342gIeCHCgK3Kl4ow4yg8hTHHx9nBToIioat78XLIx70GXN6O31?=
 =?us-ascii?Q?FCp3y7KDmbKNdC9ZBxmufrpORFmxZiOMqtOWBXPzkvMyHLFiDVRiAzk2GBUX?=
 =?us-ascii?Q?748M5am47Ol39+h2qRXX9ASWKIyfTtfc1g9zrmox+w=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ugLOYH/ZjkiSA4jDs4TBuQ1pUNEqAyxaWm4IRgJmDEqY5BykIk7LP+sFQNWZ?=
 =?us-ascii?Q?qIuLymoxpeRfHTfaEoVstoD0DekZSAQMIA3RhbYbSUFcqBar/Erx65byblaU?=
 =?us-ascii?Q?Vb5nAo2wQWnQVrgZ7gTTYTfv1pnZpTM+e9/qa0wHMm5xIaknAkzOBCHdhYQ8?=
 =?us-ascii?Q?ja671rLkje4Klwx15TdyrpH6af60gxjpWyuNjv+8seT6kv08jw9N5nevdr4/?=
 =?us-ascii?Q?knS/MRlCSuBHywk0qC5cvxWmxCf5c4hP1ad4D7hEVYTBiGuyE732hO2ZlERz?=
 =?us-ascii?Q?fhxiQPyNrqBpN0Xq0riwaRs4580CLKt1MJT0Ucs6h+PXY1y8ZpIwELK96TNE?=
 =?us-ascii?Q?YY9tVBBdrHj48Qlh3BzWT3AiHHfP7OhcpCklO/0VkZxNyElU4YE50lViWV61?=
 =?us-ascii?Q?InWWyb8Sw1BVjNS4CJ9zel+5YlH2BoQjOV5zTIughVPWnwZyG1PZL5WraPYV?=
 =?us-ascii?Q?CVRifI2uurwbAhswLp6ygxJiJS0YgQzj8eoqMXqNc7GgVAiEJHeQB4QPD1HB?=
 =?us-ascii?Q?ObOqJFlepErcRLQnFxwil8/13Pcwy0k7E2g9rEe89xZPi8MSkqfwX+Uq6Knv?=
 =?us-ascii?Q?EzVB24PTMV0BrQ957eD2YK0oXro9ywKXVhN9wUla6QL5BELsoqAegfZgFNct?=
 =?us-ascii?Q?/BdIldT7j8zqFbqM0K/7qxzBOyGIosQH9oi+IVQaraeNwXyg/9SmZvZHxtXO?=
 =?us-ascii?Q?Veg3++/fCVW4rG3N7T09L60khiPz1b3+MEe2VJ9Co+ioxFxZB9h83AtkBhBH?=
 =?us-ascii?Q?Lm2AX7jV8/a2QRD+tHIpVxM+yFn7ohgBjkMNoG9DVErRAgtQ7IX520sewon6?=
 =?us-ascii?Q?tWuQXjsC8NWsyv7uJSh7TRRphrMIOtkAidUpeia4QyAwjw1ytArDQXlsdQCn?=
 =?us-ascii?Q?cXDjxTsdffofupStRlF8WjcmPtJgqSzhmrOhoVsPeVjZn7ZpsErArlzbKCmp?=
 =?us-ascii?Q?bWKlvEzNEbrwUMbWQUWOyInJ1eZogpOukitvmzHc0jKaUWUxhTM6FFm0EvLI?=
 =?us-ascii?Q?WVtg+fnKs/Q/RKx22y5Pion6NE0qxUgmNPYMXc+LBQ4o08oKdaiAgukPoxCa?=
 =?us-ascii?Q?tVOFT3kjY7uROrJIP3nUWH+JWReINfzDgPNinrO7zQ39NzS/z2twIIaippDR?=
 =?us-ascii?Q?NsnxLP8MNBA8VwhKPosP+OXKe2W49lwRQcpdiNrMOVWsSPZdhesPQ+oI7rQR?=
 =?us-ascii?Q?sMZxR72u73DJUzHY5DT1eBMmHtl2XtCScN58dnU8yn9Rq9hG0alSMffsoQ9U?=
 =?us-ascii?Q?jgN1MrR7QWbhumEvKhGX6tNASznK3KsoULAXwq3pFKbQWIx2hy+ZD215Ag/p?=
 =?us-ascii?Q?/Dre+/2HQonpgmpeVkUNOQPmWuv8l01yVr+P+8Wy9IurQVcOKjt0D8nz7OiZ?=
 =?us-ascii?Q?NgYM6Zw=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5640e4c1-fa43-4ca8-02ea-08de59f40425
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2026 20:22:50.9125
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR02MB9510
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8474-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	RCPT_COUNT_TWELVE(0.00)[15];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,SN6PR02MB4157.namprd02.prod.outlook.com:mid]
X-Rspamd-Queue-Id: E9DE36D64C
X-Rspamd-Action: no action

From: Long Li <longli@microsoft.com> Sent: Thursday, January 22, 2026 11:14=
 AM
>=20
> > From: Dexuan Cui <decui@microsoft.com> Sent: Wednesday, January 21, 202=
6 6:04 PM
> > >
> > > There has been a longstanding MMIO conflict between the pci_hyperv
> > > driver's config_window (see hv_allocate_config_window()) and the
> > > hyperv_drm (or hyperv_fb) driver (see hyperv_setup_vram()): typically
> > > both get MMIO from the low MMIO range below 4GB; this is not an issue
> > > in the normal kernel since the VMBus driver reserves the framebuffer
> > > MMIO in vmbus_reserve_fb(), so the drm driver's hyperv_setup_vram()
> > > can always get the reserved framebuffer MMIO; however, a Gen2 VM's
> > > kdump kernel fails to reserve the framebuffer MMIO in
> > > vmbus_reserve_fb() because the screen_info.lfb_base is zero in the
> > > kdump kernel: the screen_info is not initialized at all in the kdump
> > > kernel, because the EFI stub code, which initializes screen_info, doe=
sn't run in
> > the case of kdump.
> >
> > I don't think this is correct. Yes, the EFI stub doesn't run, but scree=
n_info should
> > be initialized in the kdump kernel by the code that loads the kdump ker=
nel into
> > the reserved crash memory. See discussion in the commit message for com=
mit
> > 304386373007.
>=20
> On AMD64 the screen_info is passed through kexec system call. But this is=
 not the case
> for ARM64, it relies on EFI to get screen_info.

Hmmm. So does the problem described here only happen on arm64? If so, that
might be worth noting in the commit message.

I found my notes from working on commit 304386373007. I don't remember
testing on arm64, and my notes don't mention it. So I'm wondering if the pr=
oblem
fixed by that commit could happen on arm64. That's potentially a separate i=
ssue
from this one. I'll do some experiments to verify.

>=20
> However, Hyper-v guarantees the framebuffer MMIO is below 4GB. So, the pa=
tch works
> by allocating PCI MMIO separately from that of the framebuffer.

Yes, that seems right. But there's still something nagging at me about this=
,
though I can't immediately identify a problem.  I'll follow up if something
comes to me. :-)

Michael

>=20
> Long
>=20
> >
> > I wonder if commit a41e0ab394e4 broke the initialization of screen_info=
 in the
> > kdump kernel. Or perhaps there is now a rev-lock between the kernel wit=
h this
> > commit and a new version of the user space kexec command.
> >
> > There's a parameter to the kexec() command that governs whether it uses=
 the
> > kexec_file_load() system call or the kexec_load() system call.
> > I wonder if that parameter makes a difference in the problem described =
for this
> > patch.
> >
> > I can't immediately remember if, when I was working on commit 304386373=
007, I
> > tested kdump in a Gen 2 VM with an NVMe OS disk to ensure that MMIO spa=
ce
> > was properly allocated to the frame buffer driver (either hyperv_fb or
> > hyperv_drm). I'm thinking I did, but tomorrow I'll check for any defini=
tive notes on
> > that.
> >
> > Michael
> >
> > >
> > > When vmbus_reserve_fb() fails to reserve the framebuffer MMIO in the
> > > kdump kernel, if pci_hyperv in the kdump kernel loads before
> > > hyperv_drm loads, pci_hyperv's vmbus_allocate_mmio() gets the
> > > framebuffer MMIO and tries to use it, but since the host thinks that
> > > the MMIO range is still in use by hyperv_drm, the host refuses to
> > > accept the MMIO range as the config window, and pci_hyperv's
> > hv_pci_enter_d0() errors out:
> > > "PCI Pass-through VSP failed D0 Entry with status c0370048".
> > >
> > > This PCI error in the kdump kernel was not fatal in the past because
> > > the kdump kernel normally doesn't reply on pci_hyperv, and the root
> > > file system is on a VMBus SCSI device.
> > >
> > > Now, a VM on Azure can boot from NVMe, i.e. the root FS can be on a
> > > NVMe device, which depends on pci_hyperv. When the PCI error occurs,
> > > the kdump kernel fails to boot up since no root FS is detected.
> > >
> > > Fix the MMIO conflict by allocating MMIO above 4GB for the
> > > config_window.
> > >
> > > Note: we still need to figure out how to address the possible MMIO
> > > conflict between hyperv_drm and pci_hyperv in the case of 32-bit PCI
> > > MMIO BARs, but that's of low priority because all PCI devices
> > > available to a Linux VM on Azure should use 64-bit BARs and should no=
t
> > > use 32-bit BARs -- I checked Mellanox VFs, MANA VFs, NVMe devices, an=
d
> > > GPUs in Linux VMs on Azure, and found no 32-bit BARs.
> > >
> > > Fixes: 4daace0d8ce8 ("PCI: hv: Add paravirtual PCI front-end for
> > > Microsoft Hyper-V VMs")
> > > Signed-off-by: Dexuan Cui <decui@microsoft.com>
> > > Cc: stable@vger.kernel.org
> > > ---
> > >  drivers/pci/controller/pci-hyperv.c | 8 ++++++--
> > >  1 file changed, 6 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/pci/controller/pci-hyperv.c
> > > b/drivers/pci/controller/pci-hyperv.c
> > > index 1e237d3538f9..a6aecb1b5cab 100644
> > > --- a/drivers/pci/controller/pci-hyperv.c
> > > +++ b/drivers/pci/controller/pci-hyperv.c
> > > @@ -3406,9 +3406,13 @@ static int hv_allocate_config_window(struct
> > > hv_pcibus_device *hbus)
> > >
> > >  	/*
> > >  	 * Set up a region of MMIO space to use for accessing configuration
> > > -	 * space.
> > > +	 * space. Use the high MMIO range to not conflict with the hyperv_d=
rm
> > > +	 * driver (which normally gets MMIO from the low MMIO range) in the
> > > +	 * kdump kernel of a Gen2 VM, which fails to reserve the framebuffe=
r
> > > +	 * MMIO range in vmbus_reserve_fb() due to screen_info.lfb_base bei=
ng
> > > +	 * zero in the kdump kernel.
> > >  	 */
> > > -	ret =3D vmbus_allocate_mmio(&hbus->mem_config, hbus->hdev, 0, -1,
> > > +	ret =3D vmbus_allocate_mmio(&hbus->mem_config, hbus->hdev, SZ_4G, -=
1,
> > >  				  PCI_CONFIG_MMIO_LENGTH, 0x1000, false);
> > >  	if (ret)
> > >  		return ret;
> > > --
> > > 2.43.0


