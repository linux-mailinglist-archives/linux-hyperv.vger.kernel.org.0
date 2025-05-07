Return-Path: <linux-hyperv+bounces-5398-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB286AAD5E9
	for <lists+linux-hyperv@lfdr.de>; Wed,  7 May 2025 08:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C01A69836AB
	for <lists+linux-hyperv@lfdr.de>; Wed,  7 May 2025 06:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B590204866;
	Wed,  7 May 2025 06:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="XWIBDK+0"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023135.outbound.protection.outlook.com [40.107.44.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B0820459A;
	Wed,  7 May 2025 06:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746598956; cv=fail; b=X5Sq9vsV1roq++VYozZvMrIh56F36BVZkuvjCffraQrgyl/Aww2ivdRF9NC2MVYuE0Pzb06Xw9jcNBI7CWsgBPQNNhKRqk816gID1MSavE6hF2GhzWVa4PfBUIYlm5GdOV7L+m2PB621C7LUgJdSPJUAr87C/t9wBX/+x2Bpk1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746598956; c=relaxed/simple;
	bh=I0fhsXRsz6Zgn+veBglNa1d5cmGtzYsz/rQg9nBeDPw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tt7FXXfqs+KoLLKyDTZjCyOxcDg7BxaSXNLCBY24YXCspbUX7zNCOCa2wInEkgwgzI07yWtXWgnz6C+G5bXBIaOXLMVF5ubNOwlFz9B0xm6YKswFCcyn0wB6CV/B1mtmFha8768FYc17m3L8LBc6HExZ5+B4ZkevowHGnv/t1Qo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=XWIBDK+0; arc=fail smtp.client-ip=40.107.44.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=krAjUEi/zOZsStVofVWFGgv4EXHBEA/wauMVsPLKir/AIi6Ge1+Xl4kod6qBw+Vq+Rsd2VSydYfsWoxfE9au/68vHk6ZbSqY0xBzfdWV8FnFIH3Wni+OWxjFuI5RuuX6RX/imzIluGm+TbxJYohYcolIbvOMTwH3QydSxHMyKk9oEDkLauZNKuyDNT6FHlivISOhsnfp2YAVvG49lqNdM2fjhKyDzSOaiGWNnK79KVGBQMdfgXq6Uo6U/z4uERq/LBcVP1PmEroJxE6/enuZWB6MLcVe6dowFkk6ymXBLT4DRrrycPaQZycXcwycmsIhz/1YNZsorwGB97n0pdZatg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I0fhsXRsz6Zgn+veBglNa1d5cmGtzYsz/rQg9nBeDPw=;
 b=yBNNch7Ds547m+SSGOXF67o5tAUQiQ2Kesu1PJhqk21r5L5n3PqowIh+MmY1NYedgnkqNCGANT1AyP48q9/dEj5TVFnjFdhVEe+yWjnlacBXxABdIwhi0OKvp8KVvJPfmTC5KEKX0zdo5c9L8NB6zqYJB2VG/BwjRrOuC4z8uKitFeSRWHOGB3tH9+WoTmLy9oZXNmiryAXq9tMlPeFkGG2HFB7TvhRnL2BROd4WUMR0MBd213B1s3MkAIxOxHr0ZM+aJdriPWtInGaGdjQ0Qv4lnZnDrrFeeVl8Zu5yYUt1/dAQLEU1uM1+v5ACN5Tc7QA4uMj7U/uiJchsRhV2QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I0fhsXRsz6Zgn+veBglNa1d5cmGtzYsz/rQg9nBeDPw=;
 b=XWIBDK+0qW6AvnfQgsU44UHipJB+PpYX21KqJ45jE+8PKT3hd8GhIcFeD0i20te5de84NeAFle/NftyzDyJ6C4rm5ULObGfqXc8MqdOtk3BrkYV5DwF2plDmz7bCyJOUHAlMsU+vBRc65pEP/RmoBKN83xYx/Ud4dAzGSXgpnXA=
Received: from KUZP153MB1444.APCP153.PROD.OUTLOOK.COM (2603:1096:d10:36::22)
 by KUXP153MB1299.APCP153.PROD.OUTLOOK.COM (2603:1096:d10:12::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.3; Wed, 7 May
 2025 06:22:26 +0000
Received: from KUZP153MB1444.APCP153.PROD.OUTLOOK.COM
 ([fe80::1d66:c349:800b:f365]) by KUZP153MB1444.APCP153.PROD.OUTLOOK.COM
 ([fe80::1d66:c349:800b:f365%5]) with mapi id 15.20.8746.002; Wed, 7 May 2025
 06:22:26 +0000
From: Saurabh Singh Sengar <ssengar@microsoft.com>
To: Wei Liu <wei.liu@kernel.org>, Roman Kisel <romank@linux.microsoft.com>
CC: "ardb@kernel.org" <ardb@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, Dexuan Cui
	<decui@microsoft.com>, "dimitri.sivanich@hpe.com" <dimitri.sivanich@hpe.com>,
	Haiyang Zhang <haiyangz@microsoft.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"imran.f.khan@oracle.com" <imran.f.khan@oracle.com>,
	"jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>,
	"jgross@suse.com" <jgross@suse.com>, "justin.ernst@hpe.com"
	<justin.ernst@hpe.com>, "kprateek.nayak@amd.com" <kprateek.nayak@amd.com>,
	"kyle.meyer@hpe.com" <kyle.meyer@hpe.com>, KY Srinivasan <kys@microsoft.com>,
	"lenb@kernel.org" <lenb@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"nikunj@amd.com" <nikunj@amd.com>, "papaluri@amd.com" <papaluri@amd.com>,
	"perry.yuan@amd.com" <perry.yuan@amd.com>, "peterz@infradead.org"
	<peterz@infradead.org>, "rafael@kernel.org" <rafael@kernel.org>,
	"russ.anderson@hpe.com" <russ.anderson@hpe.com>, "steve.wahl@hpe.com"
	<steve.wahl@hpe.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
	"tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
	"tony.luck@intel.com" <tony.luck@intel.com>, "xin@zytor.com" <xin@zytor.com>,
	"yuehaibing@huawei.com" <yuehaibing@huawei.com>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, Allen Pais
	<apais@microsoft.com>, Ben Hillis <Ben.Hillis@microsoft.com>, Brian Perkins
	<Brian.Perkins@microsoft.com>, Sunil Muthuswamy <sunilmut@microsoft.com>
Subject: RE: [EXTERNAL] Re: [PATCH hyperv-next v3] arch/x86: Provide the CPU
 number in the wakeup AP callback
Thread-Topic: [EXTERNAL] Re: [PATCH hyperv-next v3] arch/x86: Provide the CPU
 number in the wakeup AP callback
Thread-Index: AQHbvlSee1k5VC271ECmpiuBKbbY2LPGs9cw
Date: Wed, 7 May 2025 06:22:24 +0000
Message-ID:
 <KUZP153MB1444BF0D51C59D3E24A61B13BE88A@KUZP153MB1444.APCP153.PROD.OUTLOOK.COM>
References: <20250430204720.108962-1-romank@linux.microsoft.com>
 <aBl62kTEAnR790KF@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
In-Reply-To: <aBl62kTEAnR790KF@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=d599c12e-4d18-4994-be94-aa3c0c548d6e;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-05-07T06:21:21Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KUZP153MB1444:EE_|KUXP153MB1299:EE_
x-ms-office365-filtering-correlation-id: 2c9bb848-f164-4647-e7d8-08dd8d2f882e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|366016|1800799024|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?9DbbPgoYIw/t5gk4si4HgL3LCBZKfsu8oJKLiVuRBtQu7X7KEAiptJYQhlhl?=
 =?us-ascii?Q?05oIesAyaJ+qDmS4BsBkpgl3gSnEtpKa2RKBbzAt4fzQXqiyjdjbIs7wabFS?=
 =?us-ascii?Q?tsnknBVhB3f5COZSrh0dJv2nV0S/TthjAiwT+E9kPKqgxjF81TcpO6y4RUj6?=
 =?us-ascii?Q?hM4khrR2K5UrBc831Y4aUvgmpuM4yEHFEm2lhN5qMDJb1Zvk4k4Re0EKnWtr?=
 =?us-ascii?Q?+3C1pj839huAxtFxKyISW86RXHuK/Lr3S/f4AI+xj/fDZUFXRP07xGdSgTjz?=
 =?us-ascii?Q?jhDoMqR78llOqxLEBjpzs15ZlTiQT1wTqa7Q0r4FrQ8dYz8FwtFxKkRsgByC?=
 =?us-ascii?Q?AkaIUD7O5N7pnb8MpHg4zxjWFR6HFFkCFP7J+o3YCosPzLr6I4bEHSnIRth9?=
 =?us-ascii?Q?U5p5P174rH9iZzt43cJBLNk3PtgRwM2K3dXYCln4Jh7BpSZ5kSW3kG1CAZw2?=
 =?us-ascii?Q?44PTx9P1AQg5riOeCYgOGYMlXczISbBcvTKUbU04F3IoPW0tV5ddQHA0oEEa?=
 =?us-ascii?Q?+/y6PtEYpbGATnkcBgwAus7tQS8K3gEkibvWefweJBXcWvwZ9utSW+3vNjMw?=
 =?us-ascii?Q?t21UpIwTs7bqExeXHbL4zj+ymE49RnBcylZRgZyBbM2gmZYGbzies2kNzFNT?=
 =?us-ascii?Q?4BNJ12HkSi4rPFAW5rIoAVxSs3Mz+vmntmzMyCKd+vfye2DDqnZIeJTY/oQh?=
 =?us-ascii?Q?2Mynz4u07jw3nfRAlYEzLew2laNMSiNYfEJuSKwljMhMmINOaTqN4fBth3MP?=
 =?us-ascii?Q?MStqbOlk/TW+i0PdBw1B5kOR+kuYs7tuon7HOVq8dAaVNHtyL9VyiBe02/ym?=
 =?us-ascii?Q?w/UKgcN/VlLwgM/yaJN91FnEeFHOQiCbs0MZ1r0+6mngo3FojeEaQe2ITrhI?=
 =?us-ascii?Q?Yst0wlcM0gKnN3vkO7iZ+4VieC0X96NYvLIBh075bwCmRZYUUQMTrBXnafdt?=
 =?us-ascii?Q?tvvyA2QAgxeNeVgOdL6wuKdnWAbH0lEg+gheL25T7KE02UQUl3tQUY+8YT/Q?=
 =?us-ascii?Q?QAZX304XG/7lJMpG6q7qA08cZrDBr+7qArO9Ahu4lnhdgVTYszIy5HbPAuu1?=
 =?us-ascii?Q?TuAf1ZdXfRzuB2W0CwGQQDPVZKz1SXPBniTaptoqHDGQZzxMinYxbwDWfyFl?=
 =?us-ascii?Q?OC5hcFpI/3BhI+jmow0xUf+TBi9NxPUQJQhvyUjc+KVdKThtbsVUWXvnMtxw?=
 =?us-ascii?Q?KhyRh2TcB4cH1rpu0+S2M+VuYU3sV3YDT8q1+aeUJD0B0dE33V7D9GIqgf4k?=
 =?us-ascii?Q?KndPwJ2EzO/7RmgQO5B+4fRaCQ1fiswxWIn+DhRt1sBxYkUsJmFbDezyFEBc?=
 =?us-ascii?Q?4a447NC0/K7IEqddZPRx+X8tsLVZmpsy1AfGeb6/IRjrc0KPXtpXXn33eVYh?=
 =?us-ascii?Q?+LHR0K/4IsY5d38MemZ+/twROsFjssNCo9cEIf38Soit2V0XodMY0OHlil4Z?=
 =?us-ascii?Q?5dRmqJREQAMSuiWZk2SLhjsspLs4zrujj8hPKgyMjqsDgeJCEDRkPg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KUZP153MB1444.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(366016)(1800799024)(7416014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?kQuzXvnN41SAdPe6s9ndDh/CxmOA/IDbbM03cuBlbHqeypfrFzuQ1IX2dev4?=
 =?us-ascii?Q?huYc2n+SXunnMVhc6RaNhRXYMuBtwqGVw9q6S91xEHIQyRWYV3BthN450sRh?=
 =?us-ascii?Q?DW/6wOKVwa29TkKIE/XTGqb+Mz1gDR8/tjCvoIG3CRP11L4i8zXj2hpHWp8I?=
 =?us-ascii?Q?QVRGwLpwCeVrG1iSsbGETNnQ/bj9+jjWYaO5qHBeeOEEHvjcI/IaLUJSYJqw?=
 =?us-ascii?Q?7czno2/5zKfwp9bIwIDQooKbo1HHW5cohDaeC2NNMi4ub6b7gFpIsm5tpetk?=
 =?us-ascii?Q?TN8bHGY0Ne4j0Sfvfw5Rwo/nYxovSvqVbMswaT5YajEYS7ItPyS1/Y32S9vE?=
 =?us-ascii?Q?4P5yAa8ihPa24xmTdqF5skuuNylM0wDVEkv1KlG/bx63F6IrX4EA+X3kC7NA?=
 =?us-ascii?Q?SsIX7WDX5HyIthY7mN4g+kpomIhNuP/iZcDU8OwmM7UUVKuyxApYKfl89zYA?=
 =?us-ascii?Q?M/0wqq7STliZh5XfI6DgwG585vIvx8MWezpp5/Ld8pzM2zSzTXSZD4iKd/ay?=
 =?us-ascii?Q?U4lVfeqyoq04yzCzZ+LoKc3AkudN/7oMdl5ag51L7bKqSDibuzLlzVn1mIJJ?=
 =?us-ascii?Q?scwQewjPmrwn47kVP/x5ED9lwgD9z7M1/Zl45NlT31WinoU/m2FIvMVehYFB?=
 =?us-ascii?Q?2cm2Xp85vmhYtsxJ5ZPJxo2c4eMeloYvofLW72ISkgJyOfcovtJXV1GAaiof?=
 =?us-ascii?Q?2fIZTi4Trb2GpRxvBz8kniAWlhB/YD4BUk4f2KFJJ8sS4JrqL0JcVO1xpqJj?=
 =?us-ascii?Q?IuhKOQgotxc4e9k+owchjiaFLTAR67N6zaKwgmD0ISHLfpPvsK8QFPYXB/qX?=
 =?us-ascii?Q?v5XHNe0S+W92Tf1tb+nSrzGo+x8ZSiRmYFPw0CDffhUawHs/mOEDwOvQYh7f?=
 =?us-ascii?Q?9EyQJkaqddBOLz20eJ8AcPONu/UBsvWkb7SQ6fRDwUCnq9jainaarsqKsyLv?=
 =?us-ascii?Q?zvTRKYB6KuH0UX9ynX44kEi0DUuA09MLg5yLf/vOMTbARYEFqzb3/qx5pyGK?=
 =?us-ascii?Q?aWFtIu3trRPUwF2oMkwP8KyyP2a3vzB5OAQpZ7EzCIYRnhIRwiku4e+2yaW1?=
 =?us-ascii?Q?vwY/LgLd+lPhyw/SdRRbMbo3Fk0HBTBDsttmIhWdtAtvFW13Gusrbhm5LlDx?=
 =?us-ascii?Q?TT0Hps6APZ3vOgheb3yzryAbjhr5XAn0LqZHu8pqEAxxR60LLQPDX8cBrZx0?=
 =?us-ascii?Q?8gn7ZQ4dNUYLGsnDg1dziIkRyG1IcNqnG2Z1cbOZ8Kdbk2PeZCLb8cfg1A40?=
 =?us-ascii?Q?e0gmDxkmqEhMr2PaD1XlYQiM/xENoS/e5Ne2DRuIz5yGh7BkiFt9G3jWwi9i?=
 =?us-ascii?Q?qfJ1MqfHzVyGNReWCxA786Pz3btzqnWnIrgh80maSGMzCBKRasX8h4J09cbD?=
 =?us-ascii?Q?AFOgkbraEK4RPOOywAhcB/2abSEFIJS1RZmjkAqWaLYNwaoXK0Y7ufdHO7Q5?=
 =?us-ascii?Q?KHLcztzgXLw6AvrkNbFu/S6OXvnmNyWurlk2xTjk1qQa91zdVqvGfzsq02D3?=
 =?us-ascii?Q?ILKQPtwfPhZe6z33e/kfl02gtlyNlaLw+wz488+qwgxl2wrgiTmfLidLL0U4?=
 =?us-ascii?Q?FWxaOp9drTzhaMPFbaDGeFp+ZtF+Xy+QGa9CjmXp?=
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
X-MS-Exchange-CrossTenant-AuthSource: KUZP153MB1444.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c9bb848-f164-4647-e7d8-08dd8d2f882e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2025 06:22:24.3897
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z6pk+wtWqLMlnc88UflKUwlfMnwpafF65q24o3oNL17toLZFU/6o2lDz2Y5a75QkZgVi9vHGgPh4RW9zH1Vc4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUXP153MB1299

> On Wed, Apr 30, 2025 at 01:47:20PM -0700, Roman Kisel wrote:
> > When starting APs, confidential guests and paravisor guests need to
> > know the CPU number, and the pattern of using the linear search has
> > emerged in several places. With N processors that leads to the O(N^2)
> > time complexity.
> >
> > Provide the CPU number in the AP wake up callback so that one can get
> > the CPU number in constant time.
> >
> > Suggested-by: Michael Kelley <mhklinux@outlook.com>
> > Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> > Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
>=20
> Queued to hyperv-next. Thanks.

We need to update numachip_wakeup_secondary as well, otherwise this will br=
eak the builds.

Regards,
Saurabh


