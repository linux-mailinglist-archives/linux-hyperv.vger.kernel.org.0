Return-Path: <linux-hyperv+bounces-9537-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OKPsLetvu2mjkAIAu9opvQ
	(envelope-from <linux-hyperv+bounces-9537-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 04:39:23 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C42232C59D8
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 04:39:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C3D5A301020F
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 03:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3EB7286400;
	Thu, 19 Mar 2026 03:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="KCjhp5Fo"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azolkn19011029.outbound.protection.outlook.com [52.103.12.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82892AD00;
	Thu, 19 Mar 2026 03:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.12.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773891557; cv=fail; b=J/RQYyv4LuG1GDeYYv8gfYeAd/16rrWFxqgeaFhtY6HbIO/ElYT+Ze82L7pP3wpr2nsESfgHUsxqc9URiZj3jhRRzwvTe48XjRmUzOGSHGUU+hst0CLzUr3fWkMeUJ3wUaIXPZlXQ2kz999Jbdwg/2XoYCwu1PBZfaCP1p3Vkzs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773891557; c=relaxed/simple;
	bh=BaJG20CJRbKAWKy5z+qMVnXoSeKI4wYcBuAUW/ueMLk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=b7JMwKqV65dEtU5+7s0XAZ4OKga8FfM60tt1Wp26GSAW1yDY4x4kFk7GHh96Q/zawrvCywvtMgyS+x6skydNePWIZkEAk+MMfCk46U+8sZxRfjmVRL4qeFCFc58Eq7cxzmKel1y93WkwjVkkSmjH/+a2IbPP40HexXY7u7+f6l0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=KCjhp5Fo; arc=fail smtp.client-ip=52.103.12.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jYp67E3HYEYG0WkNvn/0WzvTXF7P3eM+vv+OUML8iE7MNvcmYApmOdaVTFGtw6J5/i7ph7uXaAL5mclqy0glA9zZ7CRRsKi9TKI90z912U2fnoFGZ/jNAKj1cdDxhppcNpPTflOi9TLdXzh0nG9hUt1t3ul0Kp1FDLwBM3AKurBDkRNaMTVfywLvXUPMvCaxwD27UIez57B79euCzTrUuQXC8HMEFofcL53o6pV4BQ6ceSvxFFD6NjJNy8LujOB1zwF2eQiap8FigFUbrqxMPZt0xXjqzO9k1tsk7oBJOYCBFygfEcsxjYFBWIIIvPi3kUEKWmfKYB+DX4l7VJfr7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BaJG20CJRbKAWKy5z+qMVnXoSeKI4wYcBuAUW/ueMLk=;
 b=K5x8nj/+vxnzYHEGqK1qr6Jcav4G+XZpFXQ92EqkmfpIDbZqdQjEg94MGtB05CJU0NxqOIlvna2zXkVGHbuHQKVeK97Pkhr1gkLA5uqboBp37E896esRp5NKN6rEbwpLe4492vndWTMn46jurANPqMn+cA5A4JuSXLQIH+R3caa+NxKWsU1c7I7FDWxtkyYYnxpwPB9TiezEPGdgDy9HkjyXjVoMrTbibtxk6Fb1l+c6aCPOf/xFCZGdU3kMIdxwq3DM3XPCt2YVQdjjjQjiJgVzH89Xv6TO5P0VYjLowxUhrLDR/jYy7vBVR5RLWj54FPJWm0731WxDpBY8lk/ZDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BaJG20CJRbKAWKy5z+qMVnXoSeKI4wYcBuAUW/ueMLk=;
 b=KCjhp5FoFRM5Khef003R9JgUgTiMQOJKUvOlZK21i/yw7jVmBQXlUpPesxtHb/mygz7inKPlOYW1JpNd/VQVRkrD664z2SiFU1aYyf4I++N+j9tHF04/LHYAenOz45yU+p9CO9l5Bd+2fW4O9iMaLYeiFnTzafjtWAd7VmtLZrF7jDEYunWKpdn+H+TBE/3n6OIjsY85gIdJPKBtUkdbrfWlv+MjAw8I43XJqdhDJvkVsWX8ac4uKI4imjS6PlkQ/yDHPjdqmlEzn4MnbmIpmSeanvx9nZ0bLFDgA7LfyDd7sljt0o9PW5kwA2DTIlXV6WSJ2iiPiBQDssv18RJbRg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by BL3PR02MB8914.namprd02.prod.outlook.com (2603:10b6:208:3b5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 03:39:12 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9723.018; Thu, 19 Mar 2026
 03:39:12 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Michael Kelley
	<mhklinux@outlook.com>
CC: Jan Kiszka <jan.kiszka@siemens.com>, "K. Y. Srinivasan"
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Long Li
	<longli@microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, Linux Kernel Mailing List
	<linux-kernel@vger.kernel.org>, Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: RE: RE: [PATCH] Drivers: hv: vmbus: Move add_interrupt_randomness
 back to real interrupt
Thread-Topic: RE: [PATCH] Drivers: hv: vmbus: Move add_interrupt_randomness
 back to real interrupt
Thread-Index:
 AQKoHsdWm1sf+zqRuZikYGt2JgzA3AGnYzL4AVfxRpG0A+1pNoAAQNBggAEYiQCAASTw0A==
Date: Thu, 19 Mar 2026 03:39:12 +0000
Message-ID:
 <SN6PR02MB4157392A02838453BAFBA807D44FA@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <1b53653a-98a5-402a-a224-996b26edaa97@siemens.com>
 <20260317110535.Smn9viQ7@linutronix.de>
 <f718a22c-bbf2-4206-ba7d-391243c84f60@siemens.com>
 <20260317132252.AJlwEyMh@linutronix.de>
 <5262eafa-7f94-41c8-85d7-a2b8d7f27c5a@siemens.com>
 <SN6PR02MB41573332BF202DAE0AF79ED1D441A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20260318101042.-QHDXjlS@linutronix.de>
In-Reply-To: <20260318101042.-QHDXjlS@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|BL3PR02MB8914:EE_
x-ms-office365-filtering-correlation-id: 50265aba-0267-4dd4-92d6-08de8569163c
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|31061999003|15080799012|19110799012|51005399006|37011999003|8060799015|8062599012|13091999003|1602099012|40105399003|3412199025|4302099013|440099028|10035399007|102099032|1710799026;
x-microsoft-antispam-message-info:
 =?utf-8?B?SnR4eHpsZHRXTmJYWHNHS2o1YWVmNWpDUitSZ0FONG5xamR4bTdCa3RGL2Ny?=
 =?utf-8?B?dDYvMFI3YjY0UkZSQ29uZU40NUs5bjRwTDE2TU53MkwrUHpyOXgxL2lYekhl?=
 =?utf-8?B?YVJnN1p6bWhPbWEvakxpQXpzU2xPWG1La1JKQlpSWTI1c1FLaGIrTElXMnU0?=
 =?utf-8?B?YVhNeGI0blpYRGw0d2F6bGN1c0VDNVcyRkpDRndYUWwvQU9vY1IxbHZwd0Rz?=
 =?utf-8?B?V3hnMGFpcGhYd1N2dStFTEM1c2FueDdHa0JKdnJUOEFaNUFpd3dIUS9Zb0Rx?=
 =?utf-8?B?eTJIeFBoS1lSZytpZ2EwT1V2WmJLcFRhbmxhZmxaS0lqam9VMkNSU0l0dU5s?=
 =?utf-8?B?dlVFdi9lb0U5V1FlQzNPa0lOWXJUYmZ6d1d1cVBHNU5DeXlEc1Z4dHAyWjFx?=
 =?utf-8?B?SDZRa2hQdTNzMzBxeFF5M3J6cE90aUVvVXhHREdxUi9OdE5HaGNUT2Z3bFFJ?=
 =?utf-8?B?MEdNTGU3TEhPdU5vOEk2SWFvbVUxdzdZcW5sdWhQNlFSOE9uM0QzYzcweGEy?=
 =?utf-8?B?RUFmdjF0dXVoR3hGWm1SeVRMOEc1czc0ZDdGWE5rWWdVYjkyN3RabzBhM21B?=
 =?utf-8?B?Y1gycG82U3JRM01mRzJCN0hCQXcxVCt2UFJkSy84am9lT0x6L1ZUNDFualpq?=
 =?utf-8?B?QXkraHMzcDdTOXVJVHdqd3FsT1IrcXdxWFp1dWhQYjFVZm5iWTM1MXNicU0r?=
 =?utf-8?B?OEprdi9BZ1JxMk1FWitvNXZ2M2lvL3Q0cExsb3V5UzB0b2M2TEU2VlFxdGV1?=
 =?utf-8?B?dVROaEZGQUtUamVCcStIalFha2VsbndCRzdDMHZmcUtyeXZxVHBTTURQUHIz?=
 =?utf-8?B?QzE3YWY3eGc3UHFuUXNISUloT3hOUklGNnZ3VkJERk8zWXNHV2lldVRQYVNU?=
 =?utf-8?B?bzJsekp5MWpydDZsVDJLV0NnbzBpNkxWYmZWR2x1bzRsVE5iUFNOV0Z3UUx0?=
 =?utf-8?B?YndjUmIwamllbE1QRkRBSTdMaWJ6Nmh2cEVGc2xiYTYvaklFcnF1b09tc25L?=
 =?utf-8?B?U2hnVzNnSjRhZTR6STl6OTFwbUljU2pHN2JGaCtlSFAwV0xYNDdtM1hmREo4?=
 =?utf-8?B?STdaL0ZQTFNLS0hBd01UT3BnS3N2aE1OVUI2OXZiQzhlU0dxc1FrUDNJdHJi?=
 =?utf-8?B?WGloM1RtbUkrTldkL1p3K3BPUUU5MUVZMjhuWWd5WTE0RDBMc1Jqak5tTXZG?=
 =?utf-8?B?cHAzR216TXNkTUE2Z0IrTGFOcjUzZ3R4Nld5dzQ1VjVyc0tJTWZPVkZBejVU?=
 =?utf-8?B?TTRHMy9hLzBmNEtyT1RYWmVPOGF0QlpodGtCTUorZ3FuU1haYTI3YW9HUVhl?=
 =?utf-8?B?VSsyeGpNR0FNWHZtaG5qZmQzcHNSblQ3bTVraXVzbmZCWnZsbi9hRnBsSUlK?=
 =?utf-8?B?ckFHMWQ5cUU0ZnR6Tm40Y0dIRzVBbUZNUVpod0g4Y2VaVDBpT0hxS3pKVEQr?=
 =?utf-8?B?WkJ5cWMzeHZMeER1aC95MDh4em43dEZVbFEvVGFReUNwY3BHRFR1L1FGYmlo?=
 =?utf-8?Q?XM5STrQ+1Ozf0E7qyNLCu4tmxBI?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QU5SUWdlNGx3TDJRZy83RGNNWmgyVjVPdGNYNnFnOW9WcHByb0gvMGVMYWI1?=
 =?utf-8?B?VzM3bFNSOC84dGVnNk9nNm10UXlXOVA3UFlPMWdqNjlCU3hIOTVReUtJTm1P?=
 =?utf-8?B?S2ptNlA2cTFmcjhFZ0VmS2ppcHRiS3AwMmY4US9GOWQ0c1FwYWx3RzlpR05a?=
 =?utf-8?B?cDV2QVphaVpZaHhyNW1Dakp0VkREZHNnNlh4a3VWblRPb1pMY2N4NWVmTWxV?=
 =?utf-8?B?WW42NStYanBOS2RBaEFJRDQyWFBBSXZpVVVNRmZNTXJHRjZiR0paUlJhWWZV?=
 =?utf-8?B?ZEN1NzVYWFRJb3BqazR4aE8yTkRXaXFsU3RBVVBpd2NQVDBiVnFsd1JBNk1B?=
 =?utf-8?B?MkdXNjcweks2SVo4MVJMR2ZvRGJLUFI5bHpVYzJ1TzlOQWdCN0hSNEdPeHJ1?=
 =?utf-8?B?cExxVnc1YTZOZ0tXNTRod0tCandwVVpwZUx6L0VMb3BTU0xaeituMTg2S0V0?=
 =?utf-8?B?R2g5VXFoYktPempRN0JLSFlYcnIzVWxJQ1owQmltNWdQRHNFQmR4VDhkYlJy?=
 =?utf-8?B?WXhycE5wb2Q4SzYzd1QvcWY4a0owNVJ3RzlEeFhCYWs1UmRVM2MxdW5iNkd4?=
 =?utf-8?B?L3BhU2xiUzg4ZzJBaDIvSE1hZTZ4KzlpT0kvVXUrQldLK2E3U0M5VGJRaEs3?=
 =?utf-8?B?M3R1MEorYU5Sbno0VGxRRG5pdEpiZmp3QnB1SmllWFFpUWl0ZVdJVXY0Z253?=
 =?utf-8?B?YUcrMGVqSWI5U255Rm51TnREeXJMcnl3OEljV1BSeTdEUHNNci9remNMV1Fa?=
 =?utf-8?B?cGlrMWpIZ3FkRXRTSlJudGdoR0FFaTVpeHBTeldHMHlNb25WTHQ5eHJxWm93?=
 =?utf-8?B?VE0wVzRzc3h2cjFpQlZOTUM1N2VraFVzdzl5WlMyVTRzUnd2a3M5blZWQU0v?=
 =?utf-8?B?aUxSdHhFbFhxSlNiZm92Rk9aZEkwdE13Sisrd2xwa00yR3pJRWRZdlozNkZH?=
 =?utf-8?B?S0F2UG5TWDU5VUZyUGJPT0VYR1NVVlFoVnNteEsySmJoTTQ0R0Z4b1JOelJF?=
 =?utf-8?B?QmJkUERjSXBMdEZtQlZ4V054YlloZUVZNEFWUDBBdWVjR3JNWkRHQ2JibW0v?=
 =?utf-8?B?S2p2UlVHL1NJam15T0RPeFBzUXhpdkUwNDZoSEhUS216WXBQcVkrNDFONity?=
 =?utf-8?B?Yzd3WUJ1SUJKRUtEbVlMYk9xM3JsMW9LUVhtMTdBTUxMK0NnVzZ3MDFGU1NE?=
 =?utf-8?B?S1ZmdGtKL1UrbC9DUGxjZk0relllMnYxOHRzbS85MktxdE1GMFQvSWNCRWxo?=
 =?utf-8?B?V0NRbGtwNFNDNElHdWw0ZTlBcFZQeTFnNWtXcmViMnhyRmQ3ZlR4LzZ1U2h5?=
 =?utf-8?B?TFd2bjg5QWl2SW40Z3RzOFZxZVhGKzZBOHE0U3FWVlROUTRoUGRQcmpsNmlT?=
 =?utf-8?B?MkFsN3g5K0dGVVQvaHRtR2MxUjk5MVhESEY1Sm5WbStLUEt3VlNXdWxITURZ?=
 =?utf-8?B?Sk5lQjhaRVkrYjJCZm4rSU9WN1Ftd0U2a1JtdDVDanRoSkUxMytoZGdJVitz?=
 =?utf-8?B?MkJmUFlld0xNWUlOYlNNa2dxTDlSVEV6c1l1c1NWcERVU1NGa0U2N3psK2hE?=
 =?utf-8?B?VDlMTmdTZ3VsVXA3OXZ5NjRPRk81OE5Zbllvc093cUJHVStUNjNMZjByREI4?=
 =?utf-8?B?djRLVWZidDRvWnhacXJackRoSkJBVDZSS1hzYWJ5VFNNczlPbVRybVpGOUVv?=
 =?utf-8?B?eWQ0WVJPSUlaaDBzaFVlclVmZHMxaDFGd0tmbndrVXhPdXd4ajlzS0NjR0x6?=
 =?utf-8?B?aEh3YkdLb3I3YllIWFhzd0lCeFB0OVdOaVlYQmY4clFuUUFJdlRXWXcxazll?=
 =?utf-8?Q?PqhuhC+Onms5iK1jHSo/5egt831xM6Bkdhw9k=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 50265aba-0267-4dd4-92d6-08de8569163c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2026 03:39:12.4252
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR02MB8914
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9537-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[linutronix.de,outlook.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.945];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[outlook.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[11];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C42232C59D8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

RnJvbTogU2ViYXN0aWFuIEFuZHJ6ZWogU2lld2lvciA8YmlnZWFzeUBsaW51dHJvbml4LmRlPiBT
ZW50OiBXZWRuZXNkYXksIE1hcmNoIDE4LCAyMDI2IDM6MTEgQU0NCj4gDQo+IE9uIDIwMjYtMDMt
MTcgMTc6MjY6MzkgWyswMDAwXSwgTWljaGFlbCBLZWxsZXkgd3JvdGU6DQo+ID4gPiA+IFdobyBp
cyBvdGhlciBvbmUgYW5kIGRvZXMgaXQgaGF2ZSBpdHMgYWRkX2ludGVycnVwdF9yYW5kb21uZXNz
KCkgdGhlcmUNCj4gPiA+ID4gYWxyZWFkeT8NCj4gPiA+DQo+ID4gPiBJdCdzIHRoZSBhcm02NCBw
YXRoIG9mIHRoZSBodiBzdXBwb3J0LiBSZWdhcmRpbmcgdGhlIHZtYnVzIElSUSwgaXQgc2VlbXMN
Cj4gPiA+IHRvIGJlIGZ1bGx5IGhhbmRsZWQgaGVyZSwgd2l0aG91dCBhbiBlcXVpdmFsZW50IG9m
DQo+ID4gPiBhcmNoL3g4Ni9rZXJuZWwvY3B1L21zaHlwZXJ2LmMuDQo+ID4NCj4gPiBUaGUgYXJt
NjQgcGF0aCBpcyB0aGUgY2FsbCB0byByZXF1ZXN0X3BlcmNwdV9pcnEoKSBpbiB2bWJ1c19idXNf
aW5pdCgpLg0KPiA+IFRoYXQgY2FsbCBpcyBvbmx5IG1hZGUgd2hlbiBydW5uaW5nIG9uIGFybTY0
LiBTZWUgdGhlIGNvZGUgY29tbWVudCBpbg0KPiA+IHZtYnVzX2J1c19pbml0KCkuDQo+ID4NCj4g
PiBUaGUgc3BlY2lmaWVkIGludGVycnVwdCBoYW5kbGVyIGlzIHZtYnVzX3BlcmNwdV9pc3IoKSwg
d2hpY2ggYWdhaW4gcnVucw0KPiA+IG9ubHkgb24gYXJtNjQuIEl0IGNhbGxzIHZtYnVzX2lzcigp
LCB3aGljaCBzdGFydHMgdGhlIGNvbW1vbiBwYXRoIGZvciBib3RoDQo+ID4geDg2L3g2NCBhbmQg
YXJtNjQuDQo+ID4NCj4gPiBUaGVuIHRoZSBzbGlnaHQgd2VpcmRuZXNzIGlzIHRoYXQgdGhlIHN0
YW5kYXJkIExpbnV4IElSUSBoYW5kbGluZyBmb3INCj4gPiBwZXItQ1BVIElSUXMgb24gYXJtNjQg
d2l0aCBhIEdJQ3YzICh3aGljaCBpcyB3aGF0IEh5cGVyLVYgZW11bGF0ZXMpDQo+ID4gZG9lcyAq
bm90KiBjYWxsIGFkZF9pbnRlcnJ1cHRfcmFuZG9tbmVzcygpLiAgVGhlIGZ1bmN0aW9uDQo+ID4g
Z2ljX2lycV9kb21haW5fbWFwKCkgc2V0cyB0aGUgSVJRIGhhbmRsZXIgZm9yIFBQSSByYW5nZSB0
bw0KPiA+IGhhbmRsZV9wZXJjcHVfZGV2aWRfaXJxKCksIGFuZCB0aGF0IGZ1bmN0aW9uIGRvZXMg
bm90IGRvDQo+ID4gYWRkX2ludGVycnVwdF9yYW5kb21uZXNzKCkuICBUaGUgb3RoZXIgdmFyaWFu
dCwgaGFuZGxlX3BlcmNwdV9pcnEoKSwNCj4gPiBjYWxscyBoYW5kbGVfaXJxX2V2ZW50X3BlcmNw
dSgpLCB3aGljaCAqZG9lcyogZG8gdGhlDQo+ID4gYWRkX2ludGVycnVwdF9yYW5kb21uZXNzKCku
DQo+IA0KPiBTbyBkZXNwaXRlIGFsbCB0aGUgZ2VuZXJpYyBjb2RlIG9uIGFybTY0IGRvZXMgbm90
IGRvIGl0PyBUaGVuIGRvbid0DQo+IHdvcmthcm91bmQgdGhpcyBpbiB5b3VyIGRyaXZlci4gRWl0
aGVyIHRhbGsgdG8gdGhlIElSUSBtYWludGFpbmVyIGFuZA0KPiBzdWdnZXN0IGFkZGluZyBpdCB0
aGVyZSBzbyBldmVyeW9uZSBiZW5lZml0cyBmcm9tIG9yIGRvbid0IGJlY2F1c2UgdGhlcmUNCj4g
bWlnaHQgYmUgYSByZWFzb24gdG8gYXZvaWQgaXQuIEhhdmluZyBpdCBpbiBkcml2ZXIgY29kZSBp
cyB3cm9uZy4NCg0KRldJVywgSSd2ZSByZXNlYXJjaGVkIHRoZSBoaXN0b3J5IG9mIGhhbmRsZV9w
ZXJjcHVfZGV2aWRfaXJxKCkuIEl0IGRhdGVzDQpiYWNrIHRvIDIwMTEsIHdoaWNoIGlzIHByb2Jh
Ymx5IHdoZW4gdGhlIEFSTSBhcmNoaXRlY3R1cmUgZmlyc3QgaW50cm9kdWNlZA0KcGVyLUNQVSBp
bnRlcnJ1cHRzLiBBdCB0aGF0IHRpbWUsIGl0IGRpZCBub3QgZG8gYWRkX2ludGVycnVwdF9yYW5k
b21uZXNzKCkuDQpBbiBSRkMgcGF0Y2ggc2V0IFsxXSBpbiAyMDE3IHByb3Bvc2VkIGFkZGluZyB0
aGUgaW50ZXJydXB0IHJhbmRvbW5lc3MNCmFzIGEgc2lkZSBlZmZlY3Qgb2Ygb3RoZXIgY2hhbmdl
cywgYnV0IHRoYXQgcGF0Y2ggc2V0IGV2aWRlbnRseSBkaWQgbm90DQptb3ZlIGZvcndhcmQuIFRo
ZXJlIHdhcyBubyBtYWlsaW5nIGxpc3QgZGlzY3Vzc2lvbiBvZiB0aGUgaW50ZXJydXB0DQpyYW5k
b21uZXNzIGFzcGVjdCBvZiB0aGUgcGF0Y2ggc2V0Lg0KDQpJJ2xsIHJhaXNlIHRoZSB0b3BpYyB3
aXRoIEFSTSBtYWludGFpbmVycyBhbmQgSVJRIHN1YnN5c3RlbSBtYWludGFpbmVycw0KdG8gc2Vl
IGlmIHRoZXJlJ3MgYW55IHJlYXNvbiBvbmUgd2F5IG9yIHRoZSBvdGhlci4gSSB3b3VsZCBub3Qg
YmUgc3VycHJpc2VkDQppZiBhZGRpbmcgaW50ZXJydXB0IHJhbmRvbW5lc3MgaXMgaW50ZW50aW9u
YWxseSBleGNsdWRlZCBiZWNhdXNlIHRoZXNlDQpwZXItQ1BVIGludGVycnVwdHMgd2VyZSBoaXN0
b3JpY2FsbHkgdXNlZCBmb3IgSVBJcyBhbmQgdGltZXJzIG9ubHkuIFdoYXQncw0KY2hhbmdlZCBp
cyB0aGF0IEFSTTY0IGlzIG5vdyB1c2VkIHNpZ25pZmljYW50bHkgaW4gZGF0YSBjZW50ZXJzLCBh
bmQNCnN1cHBvcnQgZm9yIFZNcyBpcyBzdXBlciBpbXBvcnRhbnQuIFRoZSBwZXItQ1BVIGludGVy
cnVwdHMgYXJlIG5vdyB1c2VkDQpmb3IgbW9yZSB0aGF0IElQSXMgYW5kIHRpbWVycywgc3VjaCBh
cyBpbiB0aGUgSHlwZXItViBjYXNlLCBhbmQNCmhhbmRsZV9wZXJjcHVfZGV2aWRfaXJxKCkgd2Fz
IG5ldmVyIHJlY29uc2lkZXJlZCBpbiB0aGF0IGxpZ2h0LiBJIHdvdWxkDQpleHBlY3QgYSByZWx1
Y3RhbmNlIHRvIGJ1cmRlbiB0aGUgSVBJIGFuZCB0aW1lciBpbnRlcnJ1cHQgcGF0aHMgd2l0aCB0
aGUNCm92ZXJoZWFkIG9mIGFkZF9pbnRlcnJ1cHRfcmFuZG9tbmVzcygpLiBCdXQgdGhlIEh5cGVy
LVYgVk1CdXMgY2FzZQ0Kc3RpbGwgbmVlZHMgaXQgYmVjYXVzZSB0aGF0J3MgdGhlIHByaW1hcnkg
c291cmNlIG9mIGludGVycnVwdCBlbnRyb3B5IGluIHRoZQ0KVk0uIFRoZXJlIGFyZW4ndCBuZWNl
c3NhcmlseSBvdGhlciBkZXZpY2VzIGdlbmVyYXRpbmcgbm9uLXBlci1DUFUgaW50ZXJydXB0cw0K
bGlrZSBpbiBhIHBoeXNpY2FsIG1hY2hpbmUuIFRvIG1lLCBpdCBpcyBwZXJmZWN0bHkgdmFsaWQg
Zm9yIHRoZSBJUEkgJiB0aW1lcg0KaW50ZXJydXB0IHBhdGhzIHRvIHdhbnQgdG8gc2tpcCBpbnRl
cnJ1cHQgcmFuZG9tbmVzcywgd2hpbGUgdGhlDQpIeXBlci1WIFZNQnVzIGludGVycnVwdCBwYXRo
IG5lZWRzIGl0LCBhbmQgd2Ugd2lsbCBiZSBiYWNrIHdoZXJlIHdlDQphcmUgbm93Lg0KDQpSZWxh
dGVkLCAqbm90KiBkb2luZyBhZGRfaW50ZXJydXB0X3JhbmRvbW5lc3MoKSBvbiB0aGUgQVJNNjQg
SHlwZXItVg0Kc3ludGhldGljIHRpbWVyIHBhdGggaXMgY29uc2lzdGVudCB3aXRoIHRoZSBBUk02
NCBhcmNoaXRlY3R1cmFsIHRpbWVyLCBzaW5jZQ0KaXQgYWxzbyB1c2VzIGhhbmRsZV9wZXJjcHVf
ZGV2aWRfaXJxKCkuIEkgZGlkIHRoZSBvcmlnaW5hbCB3b3JrIHRvIGdldCB0aGUNCkh5cGVyLVYg
c3ludGhldGljIHRpbWVycyB3b3JraW5nIG9uIEFSTTY0IGJhY2sgaW4gMjAxOSAoPyksIGJ1dCBJ
IGRvbid0DQpyZWNhbGwgaWYgdGhhdCBjb25zaXN0ZW5jeSB3aXRoIHRoZSBBUk02NCBhcmNoaXRl
Y3R1cmFsIHRpbWVyIHdhcw0KaW50ZW50aW9uYWwgb3IgYWNjaWRlbnRhbC4NCg0KQWdhaW4sIEkn
bGwgcmFpc2UgdGhpcyB3aXRoIHRoZSBhcHByb3ByaWF0ZSBtYWludGFpbmVycyBhbmQgc2VlIHdo
YXQgdGhlDQpmZWVkYmFjayBpcy4NCg0KTWljaGFlbA0KDQpbMV0gaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvbGttbC8yMDE3MDkwNzIzMjU0Mi4yMDU4OS0zLXBhdWwuYnVydG9uQGltZ3RlYy5jb20v
DQoNCg0KPiANCj4gPiBTbyBhdCB0aGlzIHBvaW50LCBwdXR0aW5nIHRoZSBhZGRfaW50ZXJydXB0
X3JhbmRvbW5lc3MoKSBpbg0KPiA+IHZtYnVzX2lzcigpIGlzIG5lZWRlZCB0byBjYXRjaCBib3Ro
IGFyY2hpdGVjdHVyZXMuIElmIHRoZSBsYWNrIG9mDQo+ID4gYWRkX2ludGVycnVwdF9yYW5kb21u
ZXNzKCkgaW4gaGFuZGxlX3BlcmNwdV9kZXZpZF9pcnEoKSBpcyBhIGJ1ZywNCj4gPiB0aGVuIHRo
YXQgd291bGQgYmUgYSBjbGVhbmVyIHdheSB0byBoYW5kbGUgdGhpcy4gQnV0IG1heWJlIHRoZXJl
J3MNCj4gPiBhIHJlYXNvbiBiZWhpbmQgdGhlIGN1cnJlbnQgYmVoYXZpb3Igb2YgaGFuZGxlX3Bl
cmNwdV9kZXZpZF9pcnEoKQ0KPiA+IHRoYXQgSSdtIHVuYXdhcmUgb2YuDQo+ID4NCj4gPiBNaWNo
YWVsDQo+IA0KPiBTZWJhc3RpYW4NCg0K

