Return-Path: <linux-hyperv+bounces-3225-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C30E39B8127
	for <lists+linux-hyperv@lfdr.de>; Thu, 31 Oct 2024 18:28:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BF06282D4F
	for <lists+linux-hyperv@lfdr.de>; Thu, 31 Oct 2024 17:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94321BDAAE;
	Thu, 31 Oct 2024 17:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="crA6FEzH"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11023084.outbound.protection.outlook.com [40.93.201.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A1B1BD515;
	Thu, 31 Oct 2024 17:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730395732; cv=fail; b=scPhZw7RaCJWqTKRG34/4V0kmnCWTjdL9X32WFn5r8MVbiWOqH6tqmAim8A/R7UTMdE1SvGna0ZYbjLoX5r/trd4tP4KzW9rW5XokT/ByHc1IjWPvz/Rpa+U5CgLPDU/y5VESWoRjvy/p6AXyD03puZifOkYQh/4z20fbDrV/Uo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730395732; c=relaxed/simple;
	bh=awsacV67wingB2t2oPzD3KWasw8b60c+PaP+CTEKGTc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=loRyo/V86XGisxxXnGYQVAoK0gPYrJEepWdIO1TkPY68LomRQgJHgSR2xu3bOmT+RXkEIC8v3Aj1ysYbAbjZeRWGLrXQZFNFoylhNthWXHDV5hP+B8JKlHtubBpR6J0kR5zruFq4OSI0ToYQlQ6DZWFZOjiW7W8PLdpYeZZKMmI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=crA6FEzH; arc=fail smtp.client-ip=40.93.201.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LrLPrgjyCxpoQqBp/NIar+VpNmlHDFu+naJpDXj7MvJATyGWD7H6Lr80vSPHeahsZRS5v2lR0DPBJbxTA9M32Jjehte8pqqATeYhFx2KB9GI+oF++TEvIDgLRE9D505b3Fu0vJwVKecOwKpzMXywMKe3uYm3m6I89cM3SekxOXZ8wwqpzF2jYtkO4HIUFd/w26oyjvspqSHha6NIDccl2FY19qaC7D/eERbeGrP3Rxi1pWQ3GhDKCQn74OXrfRxPP/YerCGH+h4g36/0JPUmQG8AAxkyo/+201pPe7Dg/vhWfPduAHve8lvedVLf1FYtJG+a4hyQYEIz/jan2mCwqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h0JCfaZZYgTnCxE4ELrrspeVBp9UFM9yx5jjnEcfAvM=;
 b=jvWbAQ2Pyvy5cfDIy78gcT61EuevvJRWg+J4LZyNdEYLL3SWnuGK2UDcopcVq0ZaB6GClXCZD5f1fS/M8/O2THFaxAJE9YBQu6hWupSt9GEu+rum2S+o7KpRUsDrotNWLwEP9YVjl7fiOnDMh8qHDhusPcqcNaefvHgf41UDykfE1ZRAhYKImhGn50hlO/KhEfGl0v57P30i6Bky93j8BoESWutw1/wKWsfkb6wcrGbDK8bGT5e+EQpB5ktNhxjmXvU2DDgdDB0iDCfiHDrBnsXBLpnblppvSFjCo5TaNuf9ioxrDN309jrGRMNMyyvngVlir8U4fJ7l9qemdaxBZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h0JCfaZZYgTnCxE4ELrrspeVBp9UFM9yx5jjnEcfAvM=;
 b=crA6FEzHwGFLK7FOqauTILofn3u0T1TDsQCvR6DYI5IsOuymiIFIGn45ELGBtCDvRG2pgHoB8opEc4gq8D5ujhBJPCqyDZHfrwrhHPhveh0m83gyXB0HMHP7nroenmi1xpbr/7KLzU55ftdcbfF3ykTnvCtS2qnF+pN16v+AmSs=
Received: from SA0PR21MB1867.namprd21.prod.outlook.com (2603:10b6:806:ef::13)
 by SA6PR21MB4261.namprd21.prod.outlook.com (2603:10b6:806:417::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.7; Thu, 31 Oct
 2024 17:28:47 +0000
Received: from SA0PR21MB1867.namprd21.prod.outlook.com
 ([fe80::89d7:b5f0:88f0:ce8d]) by SA0PR21MB1867.namprd21.prod.outlook.com
 ([fe80::89d7:b5f0:88f0:ce8d%3]) with mapi id 15.20.8137.008; Thu, 31 Oct 2024
 17:28:47 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Easwar Hariharan <eahariha@linux.microsoft.com>, KY Srinivasan
	<kys@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
	<decui@microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, Anna-Maria Behnsen
	<anna-maria@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>, Geert
 Uytterhoeven <geert@linux-m68k.org>, Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>, Luiz Augusto von Dentz
	<luiz.dentz@gmail.com>, "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Praveen Kumar
	<kumarpraveen@linux.microsoft.com>, Naman Jain <namjain@linux.microsoft.com>
CC: Michael Kelley <mhklinux@outlook.com>, "Von Dentz, Luiz"
	<luiz.von.dentz@intel.com>
Subject: RE: [PATCH v3 1/2] jiffies: Define secs_to_jiffies()
Thread-Topic: [PATCH v3 1/2] jiffies: Define secs_to_jiffies()
Thread-Index: AQHbKvPZQr18YQXB106MlgZPikXLubKhAkLQgAAWJICAAAWzIA==
Date: Thu, 31 Oct 2024 17:28:47 +0000
Message-ID:
 <SA0PR21MB18673610EE997A0D62048679CA552@SA0PR21MB1867.namprd21.prod.outlook.com>
References:
 <20241030-open-coded-timeouts-v3-0-9ba123facf88@linux.microsoft.com>
 <20241030-open-coded-timeouts-v3-1-9ba123facf88@linux.microsoft.com>
 <SA0PR21MB1867075CEEBDFB9D909AFFF2CA552@SA0PR21MB1867.namprd21.prod.outlook.com>
 <59a29847-2a3b-4aac-82f4-db9f1e52bb10@linux.microsoft.com>
In-Reply-To: <59a29847-2a3b-4aac-82f4-db9f1e52bb10@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=3da3696e-dceb-4e2f-8fc3-97e9f167e5e0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-10-31T17:26:21Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR21MB1867:EE_|SA6PR21MB4261:EE_
x-ms-office365-filtering-correlation-id: f65ed01e-44a5-4cf6-7bbf-08dcf9d17a19
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?NiGD91rYkYqqV0XkpZ2NtU3q1nI8hnBLuaRMWF1xHfWoEaJIpBFPuTc/QjEY?=
 =?us-ascii?Q?3RFXeczZVGVy1ezw4fZ0iQ3gpZVJJGGJ82DVKT+ZAq5cvtjKtl9h1IQBvsIo?=
 =?us-ascii?Q?JVBS/jEaCkXva7o2s/3wJLImLrnpg08g5CrFTufzNKvRG4PfJ5Rbr2FUhUEd?=
 =?us-ascii?Q?j1eUzxrbZ/Ha2rIE5/FxbwKD3G/rIIJNcDtS4vpVKP/9GNse32vUNcl3D+ED?=
 =?us-ascii?Q?xYts0RwW3LWFHksTHaZlc2BWa0kN7Mwj8YdbtnVJVXjNw4QVc6eC1G8e2qCy?=
 =?us-ascii?Q?WhW8GPTKQ30xExjE1p5fnD7FPPhFzAlxX+dlLiuSyPsInYEXlmk8NDE9zZEm?=
 =?us-ascii?Q?G8LH/6+zSECj04hqxuCCf45mTxa5cgBtsFWrh+TChA82nQ3rhKOcllNNv9Hi?=
 =?us-ascii?Q?pdKemPkb3dWdXArSLq5t+a2Jk7Ji0PV2DwW7Kn9Ylt8dGabvObjjfR9kIbEO?=
 =?us-ascii?Q?VcEEza4Nrd8+F3zJHd8xke8xZ1OiDrxXcIvrFTJXTnXhctCDbxygnntP2+0s?=
 =?us-ascii?Q?pvaTcYiVQ/5cBJsScgNPdDhSk7DaBCrB76gTjAjg1mG6SvpIsp4zfHdxYxp6?=
 =?us-ascii?Q?vPGQZNIJieNwpIiSryz9LRtxcTKiCK6Qm1kxSMRMnoSy2mQeKqx5v16UhAVy?=
 =?us-ascii?Q?SV162C+/fCNgkPvc7Zo4RPiHg23cNJh9pxBJSgsb50HcDaKPq8ScHlhIKuwQ?=
 =?us-ascii?Q?e6NpXfTCOyep+zHcWlI9SncUoCuMNkObPJUmB0l2qc062fCWdm+reRKdiIBy?=
 =?us-ascii?Q?/z1FIO4lY6DMgHN8FvdQD2effdE/u3fhiZDUuPW11Ny4JLCK5I7NikmuGzff?=
 =?us-ascii?Q?CR3gMDXjIVu+In6DNtGbnYyQ1Kr8Ytmn0jogueuvCemWWEUYd8IaXrXIT3pC?=
 =?us-ascii?Q?iyqk8FD8CVevWhCm1KiYPdKtlhAaJy5DkShlH9/AqhlHddCrSmDCB3LxhIgJ?=
 =?us-ascii?Q?tzNpQwCHaZAUtvJUr4TTxX6xSrWtMYinNBKr7/u6UJHeOLVl5aWWebyxFH0Z?=
 =?us-ascii?Q?c/5vPnEh6SCDmkswlDz5egiTVqhuDEBwK2G2p5tMwmOOVLL+FbLDdkOFS2+g?=
 =?us-ascii?Q?C0/mHWJLIH4C+ERhEV9YLROia9afdRmcMesQTIwcF8y6KaOrq6cp85kSbylR?=
 =?us-ascii?Q?P3f4QaNOlu5xyN8nswLMAPAhw8E53wQCoiiCwRrOpdVSDyt7igZ6aiOWJXVe?=
 =?us-ascii?Q?2EN3pY3qzL4NZbMEkyiB6yFTvt+eLs/s/uXgwXsppQNB3oAiGSOBIgN1jjTS?=
 =?us-ascii?Q?2mvVwCQldJW9rW5tW4ukx+NeKV7Fi4p6EOEB7pHVboFRacTHkh5B0Mr2NstI?=
 =?us-ascii?Q?09YYN0+86l/piC8QrPo9TyPkP60bwKPj/lU2LXM2XZtEvA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR21MB1867.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?YOTT3cjy2U01OrgzYF4b60RC8ti/8xxZwV/yZznfuQOk+m2JOSDm/mTPSeGP?=
 =?us-ascii?Q?iqxF/oChqpcFsCGrOnFigq1kgcGFJiKsfqjnZSf3LO1+6F6uJzr9icWD+WYI?=
 =?us-ascii?Q?e8AVziWRM5Fy0imzt4XUnR/DseUIJ4RexSPHOphUfr/AG2SnX+mU54pMx7aX?=
 =?us-ascii?Q?5Y7d5o8bW1+a9cbL2Wcx4h7qfUc8dvYiB35QoiQJlEgkIgYGU35ZXEneH34L?=
 =?us-ascii?Q?Y4fhxUFUmQ9lmUerSYmbHxzutNh/AuSm7gHeqNXkAF+WCWjZe8hOtahfrrNx?=
 =?us-ascii?Q?ciHrTuyMjG0MJHh9H09Eosa4pKFTpu9QRmHh3QnWtrZMAf80rAQYLx+kIeap?=
 =?us-ascii?Q?WN1HJfoe52ghVqlAfIZCDgx9vtF9h8lUlxpjoIxldet6y/MpeO3ZCiuHw2rJ?=
 =?us-ascii?Q?nX6Jz2j5DdQ8fYWJjSkujOmX4y3QuChUtmsIautx1VR/Q6kMcJ4so1rbDjv2?=
 =?us-ascii?Q?nnnZ7fsIzkjTb/vwg0z0yG5igDHW3Zhe/PHQwdgOOltadeKqPsIozTOuTExG?=
 =?us-ascii?Q?gjqSK1sPSfhl2kwxW8nwOinlczsjx+sUUAVGvb/VJXwPO4rMDG+q3hwHHo3H?=
 =?us-ascii?Q?47aSOH2Jgc+N63grbiCxoGxRfAy1c/DnTX23kNgcXs8OOF0UJgiF1Y4T8AkM?=
 =?us-ascii?Q?zmwpR4T9SmSQoaCFnf6rdbUJwv4jCUNa5zukrr2fJVlvmqcSPVZC9xXKsMX1?=
 =?us-ascii?Q?jy6JFqHAC72kSbE8iYMVrVLgEV2sxS9rzRcmaqF3IxPHNff6Bx9r/VaGcuIC?=
 =?us-ascii?Q?7a9WjJZ0kAhWi+QJEzb4HtbF5mtRB9cJMaU+JEWOunk5TFapUPBYLUv0g4HD?=
 =?us-ascii?Q?6RaeEquLEDJ9SCIZg0hV3UlK+5DyZ4Vhpu6VTJaEmi9b64pSmKugw/e1KeNo?=
 =?us-ascii?Q?QzDFKB3Xhm7+sFWUkihKLVvkd1VskAWUqZMZ6sZqNWBxsO6T0VRR1vt1ZZtC?=
 =?us-ascii?Q?wHa47V2VNn6OCXeHvA2vzFSzBy++dyF/G/sA8PwlO1fPzrSosUsXGpBupziO?=
 =?us-ascii?Q?gKJeGxCsm3W+b1C10Aj5ZrQAAp9I2aLPzGOQq6iGF+Sa94J0e1r9pyv5Pj1i?=
 =?us-ascii?Q?MZCgbQTHcyKBmfsdJEI8e8LZ6h9Twga/o0OlKjtgb51nXxxnp0SOSKUd3r+0?=
 =?us-ascii?Q?uo6ckF3eDEoPfZDxIZsgd8+GmSnU5uL1w6ziN3+6sqqF33qZOb3l58r1L8te?=
 =?us-ascii?Q?d9z9wEMpYIjT4E786DR7FXanQuLpJeIbhlI2rnraIHPCAX7syFkHgsSbnR79?=
 =?us-ascii?Q?bJ9ci3nt0UlHrf283i/9xTI5FcSBX5T6eEVWHlkv5bmtRv/miWkrOawAaccS?=
 =?us-ascii?Q?DK8v3lmSv7wcK6RuBfoJsV9ubKcZa+V16O7n+P6icr7CmAJRPQPdJD1THlej?=
 =?us-ascii?Q?C7tQx0aztNCL/Apa1K3hbG1zkA/m2JbTpfSQ1rD/GBI3mFfGdy0SjxCdUEBP?=
 =?us-ascii?Q?O1fc2AGYzeHUcp7FmuzrZI82QraWIgNppCRxwiFz7alMXFZhmGMIlyl3hl8F?=
 =?us-ascii?Q?I5RPt/4JF4P0/tku9GZd7AkSiHiJe+YLbsM/JLcrPKDsVgIrI/1Sffnnu6NW?=
 =?us-ascii?Q?Ky8IDaN8TOngHkC9uUB6tat/TDbPWdwbwx46IjPO?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR21MB1867.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f65ed01e-44a5-4cf6-7bbf-08dcf9d17a19
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2024 17:28:47.1526
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R1FDzg0W82G2s2RawqfLHaMU2P2w1TiU+36FK3ogMR+mlIBIAts96ii82UcRR7tFlSMJzbXeRTqJdY6hbh1v5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR21MB4261



> -----Original Message-----
> From: Easwar Hariharan <eahariha@linux.microsoft.com>
> Sent: Thursday, October 31, 2024 1:06 PM
> To: Haiyang Zhang <haiyangz@microsoft.com>; KY Srinivasan
> <kys@microsoft.com>; Wei Liu <wei.liu@kernel.org>; Dexuan Cui
> <decui@microsoft.com>; linux-hyperv@vger.kernel.org; Anna-Maria Behnsen
> <anna-maria@linutronix.de>; Thomas Gleixner <tglx@linutronix.de>; Geert
> Uytterhoeven <geert@linux-m68k.org>; Marcel Holtmann
> <marcel@holtmann.org>; Johan Hedberg <johan.hedberg@gmail.com>; Luiz
> Augusto von Dentz <luiz.dentz@gmail.com>; linux-
> bluetooth@vger.kernel.org; linux-kernel@vger.kernel.org; Praveen Kumar
> <kumarpraveen@linux.microsoft.com>; Naman Jain
> <namjain@linux.microsoft.com>
> Cc: eahariha@linux.microsoft.com; Michael Kelley <mhklinux@outlook.com>;
> Von Dentz, Luiz <luiz.von.dentz@intel.com>
> Subject: Re: [PATCH v3 1/2] jiffies: Define secs_to_jiffies()
>
> On 10/31/2024 8:54 AM, Haiyang Zhang wrote:
> >
> >
> >> -----Original Message-----
> >> From: Easwar Hariharan <eahariha@linux.microsoft.com>
> >> Sent: Wednesday, October 30, 2024 1:48 PM
> >> To: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> >> <haiyangz@microsoft.com>; Wei Liu <wei.liu@kernel.org>; Dexuan Cui
> >> <decui@microsoft.com>; linux-hyperv@vger.kernel.org; Anna-Maria
> Behnsen
> >> <anna-maria@linutronix.de>; Thomas Gleixner <tglx@linutronix.de>;
> Geert
> >> Uytterhoeven <geert@linux-m68k.org>; Marcel Holtmann
> >> <marcel@holtmann.org>; Johan Hedberg <johan.hedberg@gmail.com>; Luiz
> >> Augusto von Dentz <luiz.dentz@gmail.com>; linux-
> >> bluetooth@vger.kernel.org; linux-kernel@vger.kernel.org; Praveen Kumar
> >> <kumarpraveen@linux.microsoft.com>; Naman Jain
> >> <namjain@linux.microsoft.com>
> >> Cc: Michael Kelley <mhklinux@outlook.com>; Easwar Hariharan
> >> <eahariha@linux.microsoft.com>; Von Dentz, Luiz
> >> <luiz.von.dentz@intel.com>
> >> Subject: [PATCH v3 1/2] jiffies: Define secs_to_jiffies()
> >>
> >> secs_to_jiffies() is defined in hci_event.c and cannot be reused by
> >> other call sites. Hoist it into the core code to allow conversion of
> the
> >> ~1150 usages of msecs_to_jiffies() that either:
> >> - use a multiplier value of 1000 or equivalently MSEC_PER_SEC, or
> >> - have timeouts that are denominated in seconds (i.e. end in 000)
> >>
> >> This will also allow conversion of yet more sites that use (sec * HZ)
> >> directly, and improve their readability.
> >>
> >> TO: K. Y. Srinivasan <kys@microsoft.com>
> >> TO: Haiyang Zhang <haiyangz@microsoft.com>
> >> TO: Wei Liu <wei.liu@kernel.org>
> >> TO: Dexuan Cui <decui@microsoft.com>
> >> TO: linux-hyperv@vger.kernel.org
> >> TO: Anna-Maria Behnsen <anna-maria@linutronix.de>
> >> TO: Thomas Gleixner <tglx@linutronix.de>
> >> TO: Geert Uytterhoeven <geert@linux-m68k.org>
> >> TO: Marcel Holtmann <marcel@holtmann.org>
> >> TO: Johan Hedberg <johan.hedberg@gmail.com>
> >> TO: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> >> TO: linux-bluetooth@vger.kernel.org
> >> TO: linux-kernel@vger.kernel.org
> >> Suggested-by: Michael Kelley <mhklinux@outlook.com>
> >> Reviewed-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >> Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
> >> ---
> >>  include/linux/jiffies.h   | 12 ++++++++++++
> >>  net/bluetooth/hci_event.c |  2 --
> >>  2 files changed, 12 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/include/linux/jiffies.h b/include/linux/jiffies.h
> >> index
> >>
> 1220f0fbe5bf9fb6c559b4efd603db3e97db9b65..e17c220ed56e587fd55fb9cf4a133a5
> >> 3588af940 100644
> >> --- a/include/linux/jiffies.h
> >> +++ b/include/linux/jiffies.h
> >> @@ -526,6 +526,18 @@ static __always_inline unsigned long
> >> msecs_to_jiffies(const unsigned int m)
> >>    }
> >>  }
> >>
> >> +/**
> >> + * secs_to_jiffies: - convert seconds to jiffies
> >> + * @_secs: time in seconds
> >> + *
> >> + * Conversion is done by simple multiplication with HZ
> >> + * secs_to_jiffies() is defined as a macro rather than a static
> inline
> >> + * function due to its potential application in struct initializers.
> >> + *
> >> + * Return: jiffies value
> >> + */
> >> +#define secs_to_jiffies(_secs) ((_secs) * HZ)
> >> +
> >>  extern unsigned long __usecs_to_jiffies(const unsigned int u);
> >>  #if !(USEC_PER_SEC % HZ)
> >>  static inline unsigned long _usecs_to_jiffies(const unsigned int u)
> >> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> >> index
> >>
> 0bbad90ddd6f87e87c03859bae48a7901d39b634..7b35c58bbbeb79f2b50a02212771fb2
> >> 83ba5643d 100644
> >> --- a/net/bluetooth/hci_event.c
> >> +++ b/net/bluetooth/hci_event.c
> >> @@ -42,8 +42,6 @@
> >>  #define ZERO_KEY "\x00\x00\x00\x00\x00\x00\x00\x00" \
> >>             "\x00\x00\x00\x00\x00\x00\x00\x00"
> >>
> >> -#define secs_to_jiffies(_secs) msecs_to_jiffies((_secs) * 1000)
> >> -
> >>  /* Handle HCI Event packets */
> >>
> >>  static void *hci_ev_skb_pull(struct hci_dev *hdev, struct sk_buff
> *skb,
> >>
> >> --
> >> 2.34.1
> >
> > All looks good.
> > But can you consider naming the macro as s2jiffy()? Just
> > to be shorter, so after adopting this macro we don't have
> > to split some lines for over 80 characters:)
> >
> > Thanks,
> > - Haiyang
> >
>
> Thanks for the review! The patch introducing the macro has already been
> accepted into timers/core in tip[1], so unfortunately I can't make that
> change anymore. For readability considerations, I also find it better to
> match the remaining APIs in the jiffies family, i.e. msecs_to_jiffies(),
> nsecs_to_jiffies(), usecs_to_jiffies().
>
> [1]
> https://git.ker/
> nel.org%2Ftip%2Fb35108a51cf7bab58d7eace1267d7965978bcdb8&data=3D05%7C02%7=
Ch
> aiyangz%40microsoft.com%7C7d5db079ed124f62ac2a08dcf9ce4b20%7C72f988bf86f1
> 41af91ab2d7cd011db47%7C1%7C0%7C638659911651280804%7CUnknown%7CTWFpbGZsb3d
> 8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFp
> bCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3Dhz5UtwU9CLw068z4tpr9kPMANntwX58=
De
> A5dXi9pqSg%3D&reserved=3D0
>

Then, that's fine.

Thanks
- Haiyang



