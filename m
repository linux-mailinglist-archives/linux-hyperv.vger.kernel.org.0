Return-Path: <linux-hyperv+bounces-5515-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E79AB72C0
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 May 2025 19:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C75B88C0B69
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 May 2025 17:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77CE4280316;
	Wed, 14 May 2025 17:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="o1r+8qcK"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02olkn2067.outbound.protection.outlook.com [40.92.43.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75378280304;
	Wed, 14 May 2025 17:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.43.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747243610; cv=fail; b=W9Q+wp9HVsQq2RMfHA3bH0sJkRpmto8iLOnnTs0Yz/TIiVIiqTTRQIURGfT63laxfEwAIC3ccRKNGHkMtVNROUGVyZ8i86+l+Y3gl2rYM7IZswEYjNR3K1ODOCYZF8kV5NDsOGuwcVurJk8smVqVYKTzO2J4hHWeq8ZVYi2wYEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747243610; c=relaxed/simple;
	bh=x/nkeFit78BBcSS1Fx876aNG9IrX1Km4Sl31uibmJWc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Po8mn4/id+OGtXoqbfeWf8kQhfu9xj35o3eWZlJm9Zx2rAbh/gVCuW8+PxRl26D0L64n8eaudB0nuTMuDtRmjDbcuvy9Sddvr/Wbm9W4OFpHd5J8txwNxmS55zU8NNddY77A1N0vzo6PwXPEoe1F1doLnyMQZR1/WcOGMxQRHL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=o1r+8qcK; arc=fail smtp.client-ip=40.92.43.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lNlnaQ7wOjEavn6KnQ8tV1hLOx3/mz8Rom3tg5/NwAtHPCjHVFymwmb8l3HZsFlgG/85EP2BMAwIcy0UtG7nhvZP16pEWo+D6ijzQ3RtsM6FpvujBevjXT/HowTb+KSFx3Uk7RDZuyKtoDxbCAPfhYQF2q/2vdted/wBOwb1PC6wYFcCf7rFhg58eQ79meS5UaL356rTzveAVfGne8/CXBpeiWfgZhV36ci4Ci/BeDgAmJ70IQ/vAG65OJYZ+bUNtOb2v8NmCAxiK3CRg67YT4vCpSX7HPtUPhNMkjxfP84b6PhZ/sK3fJjSiCjOVBjw8P67JC8Szkzl2hZGINR6qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x/nkeFit78BBcSS1Fx876aNG9IrX1Km4Sl31uibmJWc=;
 b=F16L9v6dnp3qD2K3pMi3It5+wc/iy/ASmrbuxDDooq4x8l5Y8/zB7NUE9U4mDzH9ex4j45GwIdwjdhWBjmVVZB9Sh2dsbh+F+XnJ+Ilc8OBmLR1JX/TddpwD2YNo1WOrMi026Gg6QBikm3nldZk1y9GJiI/pmkh7lFKrWo1ojQKpBxS4RL92OPLaD19g1lcovosDibJ2mwu2NUV626S/JA5fvFCAVo6nv8qsq+huP78BWToSUd8YK21uUiT/qxqY7AIejZTMGeJHfqtwJqyW0Tzcsc6K8IeNX83zKO7wh1WEEzHxWpofBgTQIHqgKU4KV0y/00I605RADxewIQ6CfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x/nkeFit78BBcSS1Fx876aNG9IrX1Km4Sl31uibmJWc=;
 b=o1r+8qcKcxN/ZkV25X15bFICXpcHe0H6Ja3wk7WZqliNOMGpX/YLqOTLR/s457ubJWICgpmM9dIJmX72gnKP7/2Sd95MqPEYMgfzQ1hIWcO2ZC4YPTgxRURgwHB8M3i8mYTnvuOv7511InCDfPzHlteSmFEC4BIHAmnz82wHsYe6H+E0gVnLkiwWZ44ww3ieGWEW+68bUUZelJDlYhaIjdv6ZJMOw9jOHwbv/z1iTmPe/VwD2FCgniVqN3OoFhLZk4ZXNxbK7XzFHaSM/lLEyowqEEIoOra3XV35A47j7+pupk2JOXVODouojMptu1vZ5Jy5k7URJjO76/wzdkN3Bw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by DS0PR02MB9150.namprd02.prod.outlook.com (2603:10b6:8:13c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.23; Wed, 14 May
 2025 17:26:45 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.8722.027; Wed, 14 May 2025
 17:26:45 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Yury Norov <yury.norov@gmail.com>
CC: Shradha Gupta <shradhagupta@linux.microsoft.com>, Dexuan Cui
	<decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Haiyang Zhang
	<haiyangz@microsoft.com>, "K. Y. Srinivasan" <kys@microsoft.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Konstantin Taranov <kotaranov@microsoft.com>, Simon
 Horman <horms@kernel.org>, Leon Romanovsky <leon@kernel.org>, Maxim Levitsky
	<mlevitsk@redhat.com>, Erni Sri Satya Vennela <ernis@linux.microsoft.com>,
	Peter Zijlstra <peterz@infradead.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Nipun Gupta <nipun.gupta@amd.com>, Jason
 Gunthorpe <jgg@ziepe.ca>, Jonathan Cameron <Jonathan.Cameron@huwei.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>, Kevin Tian
	<kevin.tian@intel.com>, Long Li <longli@microsoft.com>, Thomas Gleixner
	<tglx@linutronix.de>, Bjorn Helgaas <bhelgaas@google.com>, Rob Herring
	<robh@kernel.org>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	=?utf-8?B?S3J6eXN6dG9mIFdpbGN6ee+/vX5Ec2tp?= <kw@linux.com>, Lorenzo
 Pieralisi <lpieralisi@kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, Paul Rosswurm <paulros@microsoft.com>, Shradha
 Gupta <shradhagupta@microsoft.com>
Subject: RE: [PATCH v3 3/4] net: mana: Allow irq_setup() to skip cpus for
 affinity
Thread-Topic: [PATCH v3 3/4] net: mana: Allow irq_setup() to skip cpus for
 affinity
Thread-Index: AQHbwMtMGWa1o0c+K0aOc8evtmVPbbPP9fjQgAJqTQCAAAZhQA==
Date: Wed, 14 May 2025 17:26:45 +0000
Message-ID:
 <SN6PR02MB4157AA971E41FE92B1878F9DD491A@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <1746785566-4337-1-git-send-email-shradhagupta@linux.microsoft.com>
 <1746785625-4753-1-git-send-email-shradhagupta@linux.microsoft.com>
 <SN6PR02MB41577E2FAA79E2803C3384B0D491A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <aCTK5PjV1n1EYOpi@yury>
In-Reply-To: <aCTK5PjV1n1EYOpi@yury>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|DS0PR02MB9150:EE_
x-ms-office365-filtering-correlation-id: 1606014e-c46a-49bf-2c06-08dd930c8053
x-ms-exchange-slblob-mailprops:
 AZnQBsB9XmoaApi1aWVt9ILKZbGoHsd6XyBD9r9qnydxytkKF17opejd+LAjeif8+7I21JFtjN/w+q+VlkRmrf2Yz2p9zt9LAf05rmHyxD1XDviVt/v1zB5DctxHWrv55hY3J3IviTiMTJbfyb6dxiK2v6yyOPzLYQ3BRUkuR8cq9jIuBegqATZTtf5UxmAJ5xJ8f4/zFGOF2xz9CQ669P2//G6OI/Zpncz1hKLZkXnI0b/HVpBsY16jfEzZTtokmWhFK/pL53oC2veo6Fsa/1DuPent3ZXFK3/jsZ25Vt61ZZHs9dGl7aErs2BU1jSm/9RsjRot01fnVA1E5F8pHRlNaFCKayu6tfyVoQoIS9X8MJqvOqyZoeq1gWwvNfiY1AfDSprM8K2lgTbJAtffawiq4NyUahoGfYEnbTRwbBUcCKxGprK5/DvAUgqrYBcMlZgkPRfMLsdYMf7Wxake5DGBNQRoysxW+IKBpZOrMwsYuSkQV0/91/0Mvz6A9Og6hQSCnw1bwazXCSlWa9OHFVOSRsvKb3bav7dpekUAcv/Kv+TuT6Tq689+lnitdkcf9Iex//T9LHEwtoo7do4+/m1EpdNccNPmYSfNXnzVpU+vEXWhPnYMCRkciaOo7677G8xXyClkooirZX/EJip+kH2dtAwndWyE9RtK/PlrKqMWBe2ZVfqNAOoISYmQpeTO9vSNLMFW8ue8pj2V2Ky5k9aijTgjlstrvbo0GRi03gr++otCk9ZoSRZ9bwOSaA9jHbsnWW82seE=
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|41001999006|19110799006|15080799009|8062599006|12121999007|8060799009|440099028|3412199025|12091999003|18061999006|102099032;
x-microsoft-antispam-message-info:
 =?utf-8?B?a2pOckRXZVpPU2ZodDhGd3R4UFNXN2tBK21YMXp1aXAwUXFTay9LdHIydDJz?=
 =?utf-8?B?YnNWUnUvYnVsdERLV0MwVVV4YzRFb0xLcnVxdEk3d1pGOWY4UnQwU0E3VmFr?=
 =?utf-8?B?aVAxbHNHRXlnUjBVdWJocFVTaEZTT3RVSWd5Qlp1bVdwdG0yY0xKajl5WTJo?=
 =?utf-8?B?RGdnYVNFNTVNUmcvWTdBcDh6eW5Qa2dPRFpvbmFMWUJlMDd4dks3NEEyZ3hx?=
 =?utf-8?B?eXkwcERhL0NEZStVZEhuUHdOWXBUT2JLOWNOSFhHelkwR0tkR2Q2Uk1FVUpY?=
 =?utf-8?B?OGpGUEM5UzVFQmxjR3FOL0tvY1NJRGpRYkZsaHNYV2VXMER3RmdBQnJFL3hF?=
 =?utf-8?B?L2o0VCtFS04xVFhGczR6TUtNSXZCNnBnamhpWlNuTUgybkF3UG5hRDdjK1Fk?=
 =?utf-8?B?eGJINGhUS2Zlc2piTjhOVk1rNmpaQ2YralJnbGxrSkRudDZnWmIxS2xWR0lP?=
 =?utf-8?B?dUkyVFl0ck1Cc1JoZWN4cEc1TEdtSFFEaGs5UDM3azV2aHdMSko1WitZWmRB?=
 =?utf-8?B?Q2hKbnZJMTB5dDZpdTYyL2p2eUFxZm5yUTF6RWhVOGFoQUs0MFVFeXJBbFdp?=
 =?utf-8?B?SUdiQk1ZWTdoclN3WTBSNWJMWFlTdGw3MUdYN0svYUg5VnNYcnAxV0NRaEN0?=
 =?utf-8?B?Qmw5L3VzY3VoaVI4OXBabUhFY1dQN0tzSDg1eWdMM1RyT25RTUZKbW16N2hi?=
 =?utf-8?B?aDdhNmFrNmdGTFNmUHU5QnB1TjRMbXVpMGszTHpwaW5FZmR3QVcwajF1Uy8y?=
 =?utf-8?B?NmE3UHJUWE8rc2RKL1YxQ08yQ1V5K3c1UmJQeUVTSmZTSmhKSU8zc0ZRa2ta?=
 =?utf-8?B?SEx4d09QektVNjd2MDdNMHo1Rm9NN0dZdHRlaDZYbnR3UGJ1bk1BaDg4elAx?=
 =?utf-8?B?VnhWRTB5UW43N2JUNXRMU0dLRGxWSTZMbFVER3V0QzN5UmlXeGNFTUhWbWJN?=
 =?utf-8?B?ZFdRWnpRU0VveTYrRUkwZnVRdXY5QTBkaENvOHVDZGZveVBHRmVsVHFqNUt2?=
 =?utf-8?B?RDJSblEraFI3UXZ0Um5xVHp1dDM3cEpJOUJNQTZwUytiOGxNNGJQNktCMlhP?=
 =?utf-8?B?VUFGdEN4dllXd21UM1BYVUptVXdPM0lCdU9tcDN6U3AzS0Z3S0ljWjEzeUhM?=
 =?utf-8?B?c28xd2lROWIvMDVUUDBkV0JlOVZsdVBQK2daUlZLay9VaTFJeWRiN0xwNGRt?=
 =?utf-8?B?bytYMTdkdE9seGpzSjRJUVljRFB3dmEwNmt2dUMwcjVYSjUxTzVXMHhYZk5H?=
 =?utf-8?B?bTF3cW12bjlNYlNjSE1NQk9qbk82WjJDWi9DR2w1M0poSGlQK1RjeWdRWjZX?=
 =?utf-8?B?S1FPbUllVlp2eDFwcFJXRWk0dVM0SlF4OU9scXhrQlpXVzRxNWcrZnl5YVVX?=
 =?utf-8?B?dXBndlNYQ3hXc0pRbkN6bklKVVBISnRINEVFRSs1SytZVXQ3cEhFY1dLUEE2?=
 =?utf-8?B?cE9pYVBpVldkb1I1a1Z0QndvOVd3cVp1NWJORk9OYlhrMllmazBDSUlFcnYr?=
 =?utf-8?B?R1R3YnhMbFh1L3N4TmlkUDFtckkxdEd0UmpWa29lUXpVU3pPaWgyMm9uQnlM?=
 =?utf-8?B?UXZXNkl1Z1kvTllmWEhCdVBmUWF5dDUyTi8wK2Z2Tmp1Y3V3UDdqWTlBTGpM?=
 =?utf-8?B?Q0RiM0dpUWJpSlhZYlFuemtwNFlEOGc9PQ==?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TXR4WWREd0RQSTlTZ0Ywd0RGQXptU0did0RrdFlYVkxZRFhCTzdNQ3UzcTh2?=
 =?utf-8?B?SHh5UXo3WHRIT21jbEVCV05oUlFXMVRCTFkzbDcrRTk3dkZmZjI3eGFDNDNs?=
 =?utf-8?B?KzdVeXkzQXpqTENDTG5XVVNncVhremRGTXl4WkxDOTEwbTZScVRvK2JGY2VK?=
 =?utf-8?B?OWZRdW1VSnV4K1o0b0l5REp3SHYyd0NoNlhiT1NBaHdXdzZGNTNVMDdiWFNL?=
 =?utf-8?B?YjJiOWN2YWFBUnBQVER2MG4rVXEyZXZXajVQVGNJMnQrVFhzeVhwL255ZjZ0?=
 =?utf-8?B?NzZXY0pTUS81TXBJYVd6QURwUUpMT1h2a1Eza2FVcnJZeURmMWp6cnZ3aHhY?=
 =?utf-8?B?cjVFUzJHaXk1emFZKy9MT3JCZEx3dkdhUXZRWDBFZ21LK21PRUlmcTgwUEtY?=
 =?utf-8?B?bHpVM3BGV0cySlM1Ukk2dWROYWlOVWYwVUdCZDZwdG9BajhZY1lVOVlyRnlL?=
 =?utf-8?B?L3VleG1OTDh5dWRsaXc0QVVkRTVmakNvNXpsM0w4NmlraFEwb25tZVZCY2Er?=
 =?utf-8?B?ODVWZDEwbGVRQUlJSW1MclZzNURqYk0yWE9pUnBuV3haTWlOVTU0Q3RIMUpS?=
 =?utf-8?B?TW9LbEw5d3R6bmMxVmR2c0ladk5QRTY1MWRyKzRMTW9aSEYzM0R1QTFPZnJ6?=
 =?utf-8?B?cUptSjBaWUY0YVYrUlNMQWphU0lqRXYrVit5M002b2djbzNPYldrTU9jTzB3?=
 =?utf-8?B?bU1aTGY3Y2NzZVhZdkhvN0s3TmdKOUg2RHh1Ynk0WVNVWklGR3NPYnVhM29r?=
 =?utf-8?B?NkhOOEtpTnRnelUwOVFWdUpGWXFIeDFFcFQ5QWxsR3ZVZk40b2RDTG1neUxD?=
 =?utf-8?B?STAyeGRjNStLVzNWdTNicmV4aUlZemJRbUJMZStvT1FTc3hpWTl3dDYyUm1h?=
 =?utf-8?B?Tnh4SzRBQnUyNGt3d3J0elYyT3VJOXBkVU5JRU1xTzNqS2EydWdvemMrYUl0?=
 =?utf-8?B?RWJscTVnZ3MzSE1lamZFazBxTDRSNy8vamtENVEzc0ErOEF3d1BtRyt5WmZD?=
 =?utf-8?B?a1dQaWlGOUZ0aWtMdkhyNTFxRDZLbFR5ZTRRV3BMcVF3RzlUYkdldmZiYWls?=
 =?utf-8?B?TVd6STBnNXhNejB6eDVNMkRyUDNLaWhxZHl4N05vcXFUc0gvWmsya2tXd0g0?=
 =?utf-8?B?VS9TemUrUDMyTG9YQ3FiRDZHQTNaNTNFZTA4eXU3aEptWk05eGlQZ1dCelZF?=
 =?utf-8?B?eEd6aUlKY00yTkNBT2RnOVlzMUltaGM2d1ovZGoweUxOZyt2V01KbVVKcms0?=
 =?utf-8?B?ZXdvOXNGSHdtVXFYRWJXQzBxVzQvdFBMT053aHRFc0lPOTZkNlBxcUVnWkJs?=
 =?utf-8?B?TWlDajBRWG1FQnlvKzQzN2lwZ1M4NHFxN0Vid0NUai9qcmEvRU9HNWR1VEZQ?=
 =?utf-8?B?bjIvblhxMWxTeHU0cVVJVU1oRC9weUpzaTV4NVBSbTlFek0xVVlRa0hjdS9q?=
 =?utf-8?B?Vjcvd3NRVWZjRDUxbWVtSGU2OWpJK1FGdVlDV0Jka1N1NjFrWFFFcXVkQmIv?=
 =?utf-8?B?eHVrUWltYTB5KzVYQzFqNzdaR28zdWMwdHl5NGhmM29SK0RMUlpSYzU3c1oz?=
 =?utf-8?B?WFF0a1NBTzF0YU9GTGN0Sk40WXR6TkI4bVpMUDFsN2ZXc3YwRnZpbWhUQUFH?=
 =?utf-8?Q?/aInEm+BFS15dW+0zQqDch/o3pUh7XXi7vKW8U1cszvw=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1606014e-c46a-49bf-2c06-08dd930c8053
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2025 17:26:45.8175
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB9150

RnJvbTogWXVyeSBOb3JvdiA8eXVyeS5ub3JvdkBnbWFpbC5jb20+IFNlbnQ6IFdlZG5lc2RheSwg
TWF5IDE0LCAyMDI1IDk6NTUgQU0NCj4gDQo+IE9uIFdlZCwgTWF5IDE0LCAyMDI1IGF0IDA0OjUz
OjM0QU0gKzAwMDAsIE1pY2hhZWwgS2VsbGV5IHdyb3RlOg0KPiA+ID4gLXN0YXRpYyBpbnQgaXJx
X3NldHVwKHVuc2lnbmVkIGludCAqaXJxcywgdW5zaWduZWQgaW50IGxlbiwgaW50IG5vZGUpDQo+
ID4gPiArc3RhdGljIGludCBpcnFfc2V0dXAodW5zaWduZWQgaW50ICppcnFzLCB1bnNpZ25lZCBp
bnQgbGVuLCBpbnQgbm9kZSwNCj4gPiA+ICsJCSAgICAgYm9vbCBza2lwX2ZpcnN0X2NwdSkNCj4g
PiA+ICB7DQo+ID4gPiAgCWNvbnN0IHN0cnVjdCBjcHVtYXNrICpuZXh0LCAqcHJldiA9IGNwdV9u
b25lX21hc2s7DQo+ID4gPiAgCWNwdW1hc2tfdmFyX3QgY3B1cyBfX2ZyZWUoZnJlZV9jcHVtYXNr
X3Zhcik7DQo+ID4gPiBAQCAtMTMwMyw5ICsxMzA0LDIwIEBAIHN0YXRpYyBpbnQgaXJxX3NldHVw
KHVuc2lnbmVkIGludCAqaXJxcywgdW5zaWduZWQgaW50IGxlbiwgaW50IG5vZGUpDQo+ID4gPiAg
CQl3aGlsZSAod2VpZ2h0ID4gMCkgew0KPiA+ID4gIAkJCWNwdW1hc2tfYW5kbm90KGNwdXMsIG5l
eHQsIHByZXYpOw0KPiA+ID4gIAkJCWZvcl9lYWNoX2NwdShjcHUsIGNwdXMpIHsNCj4gPiA+ICsJ
CQkJLyoNCj4gPiA+ICsJCQkJICogaWYgdGhlIENQVSBzaWJsaW5nIHNldCBpcyB0byBiZSBza2lw
cGVkIHdlDQo+ID4gPiArCQkJCSAqIGp1c3QgbW92ZSBvbiB0byB0aGUgbmV4dCBDUFVzIHdpdGhv
dXQgbGVuLS0NCj4gPiA+ICsJCQkJICovDQo+ID4gPiArCQkJCWlmICh1bmxpa2VseShza2lwX2Zp
cnN0X2NwdSkpIHsNCj4gPiA+ICsJCQkJCXNraXBfZmlyc3RfY3B1ID0gZmFsc2U7DQo+ID4gPiAr
CQkJCQlnb3RvIG5leHRfY3B1bWFzazsNCj4gPiA+ICsJCQkJfQ0KPiA+ID4gKw0KPiA+ID4gIAkJ
CQlpZiAobGVuLS0gPT0gMCkNCj4gPiA+ICAJCQkJCWdvdG8gZG9uZTsNCj4gPiA+ICsNCj4gPiA+
ICAJCQkJaXJxX3NldF9hZmZpbml0eV9hbmRfaGludCgqaXJxcysrLCB0b3BvbG9neV9zaWJsaW5n
X2NwdW1hc2soY3B1KSk7DQo+ID4gPiArbmV4dF9jcHVtYXNrOg0KPiA+ID4gIAkJCQljcHVtYXNr
X2FuZG5vdChjcHVzLCBjcHVzLCB0b3BvbG9neV9zaWJsaW5nX2NwdW1hc2soY3B1KSk7DQo+ID4g
PiAgCQkJCS0td2VpZ2h0Ow0KPiA+ID4gIAkJCX0NCj4gPg0KPiA+IFdpdGggYSBsaXR0bGUgYml0
IG9mIHJlb3JkZXJpbmcgb2YgdGhlIGNvZGUsIHlvdSBjb3VsZCBhdm9pZCB0aGUgbmVlZCBmb3Ig
dGhlICJuZXh0X2NwdW1hc2siDQo+ID4gbGFiZWwgYW5kIGdvdG8gc3RhdGVtZW50LiAgImNvbnRp
bnVlIiBpcyB1c3VhbGx5IGNsZWFuZXIgdGhhbiBhICJnb3RvIi4gSGVyZSdzIHdoYXQgSSdtIHRo
aW5raW5nOg0KPiA+DQo+ID4gCQlmb3JfZWFjaF9jcHUoY3B1LCBjcHVzKSB7DQo+ID4gCQkJY3B1
bWFza19hbmRub3QoY3B1cywgY3B1cywgdG9wb2xvZ3lfc2libGluZ19jcHVtYXNrKGNwdSkpOw0K
PiA+IAkJCS0td2VpZ2h0Ow0KPiANCj4gY3B1bWFza19hbmRub3QoKSBpcyBPKE4pLCBhbmQgYmVm
b3JlIGl0IHdhcyBjb25kaXRpb25hbCBvbiAnbGVuID09IDAnLA0KPiBzbyB3ZSBkaWRuJ3QgZG8g
dGhhdCBvbiB0aGUgdmVyeSBsYXN0IHN0ZXAuIFlvdXIgdmVyc2lvbiBoYXMgdG8gZG8gdGhhdC4N
Cj4gRG9uJ3Qga25vdyBob3cgaW1wb3J0YW50IHRoYXQgaXMgZm9yIHJlYWwgd29ya2xvYWRzLiBT
aHJhZGhhIG1heWJlIGNhbg0KPiBtZWFzdXJlIGl0Li4uDQoNClllcywgdGhlcmUncyBvbmUgZXh0
cmEgaW52b2NhdGlvbiBvZiBjcHVtYXNrX2FuZG5vdCgpLiBCdXQgaWYgdGhlDQpWTSBoYXMgYSBz
bWFsbCBudW1iZXIgb2YgQ1BVcywgdGhhdCBleHRyYSBpbnZvY2F0aW9uIGlzIG5lZ2xpZ2libGUu
DQpJZiB0aGUgVk0gaGFzIGEgbGFyZ2UgbnVtYmVyIG9mIENQVXMsIHdlJ3JlIGFscmVhZHkgZXhl
Y3V0aW5nDQpjcHVtYXNrX2FuZG5vdCgpIG1hbnkgdGltZXMsIHNvIG9uZSBleHRyYSB0aW1lIGlz
IGFsc28gbmVnbGlnaWJsZS4NCkFuZCB0aGlzIHdob2xlIHRoaW5nIGlzIGRvbmUgb25seSBhdCBk
ZXZpY2UgaW5pdGlhbGl6YXRpb24gdGltZSwgc28NCml0J3Mgbm90IGEgaG90IHBhdGguDQoNCj4g
DQo+ID4NCj4gPiAJCQlJZiAodW5saWtlbHkoc2tpcF9maXJzdF9jcHUpKSB7DQo+ID4gCQkJCXNr
aXBfZmlyc3RfY3B1ID0gZmFsc2U7DQo+ID4gCQkJCWNvbnRpbnVlOw0KPiA+IAkJCX0NCj4gPg0K
PiA+IAkJCUlmIChsZW4tLSA9PSAwKQ0KPiA+IAkJCQlnb3RvIGRvbmU7DQo+ID4NCj4gPiAJCQlp
cnFfc2V0X2FmZmluaXR5X2FuZF9oaW50KCppcnFzKyssIHRvcG9sb2d5X3NpYmxpbmdfY3B1bWFz
ayhjcHUpKTsNCj4gPiAJCX0NCj4gPg0KPiA+IEkgd2lzaCB0aGVyZSB3ZXJlIHNvbWUgY29tbWVu
dHMgaW4gaXJxX3NldHVwKCkgZXhwbGFpbmluZyB0aGUgb3ZlcmFsbCBpbnRlbnRpb24gb2YNCj4g
PiB0aGUgYWxnb3JpdGhtLiBJIGNhbiBzZWUgaG93IHRoZSBnb2FsIGlzIHRvIGZpcnN0IGFzc2ln
biBDUFVzIHRoYXQgYXJlIGxvY2FsIHRvIHRoZSBjdXJyZW50DQo+ID4gTlVNQSBub2RlLCBhbmQg
dGhlbiBleHBhbmQgb3V0d2FyZCB0byBDUFVzIHRoYXQgYXJlIGZ1cnRoZXIgYXdheS4gQW5kIHlv
dSB3YW50DQo+ID4gdG8gKm5vdCogYXNzaWduIGJvdGggc2libGluZ3MgaW4gYSBoeXBlci10aHJl
YWRlZCBjb3JlLg0KPiANCj4gSSB3cm90ZSB0aGlzIGZ1bmN0aW9uLCBzbyBsZXQgbWUgc3RlcCBp
bi4NCj4gDQo+IFRoZSBpbnRlbnRpb24gaXMgZGVzY3JpYmVkIGluIHRoZSBjb3JyZXNwb25kaW5n
IGNvbW1pdCBtZXNzYWdlOg0KPiANCj4gICBTb3VyYWRlZXAgaW52ZXN0aWdhdGVkIHRoYXQgdGhl
IGRyaXZlciBwZXJmb3JtcyBmYXN0ZXIgaWYgSVJRcyBhcmUNCj4gICBzcHJlYWQgb24gQ1BVcyB3
aXRoIHRoZSBmb2xsb3dpbmcgaGV1cmlzdGljczoNCj4gDQo+ICAgMS4gTm8gbW9yZSB0aGFuIG9u
ZSBJUlEgcGVyIENQVSwgaWYgcG9zc2libGU7DQo+ICAgMi4gTlVNQSBsb2NhbGl0eSBpcyB0aGUg
c2Vjb25kIHByaW9yaXR5Ow0KPiAgIDMuIFNpYmxpbmcgZGlzbG9jYWxpdHkgaXMgdGhlIGxhc3Qg
cHJpb3JpdHkuDQo+IA0KPiAgIExldCdzIGNvbnNpZGVyIHRoaXMgdG9wb2xvZ3k6DQo+IA0KPiAg
IE5vZGUgICAgICAgICAgICAwICAgICAgICAgICAgICAgMQ0KPiAgIENvcmUgICAgICAgIDAgICAg
ICAgMSAgICAgICAyICAgICAgIDMNCj4gICBDUFUgICAgICAgMCAgIDEgICAyICAgMyAgIDQgICA1
ICAgNiAgIDcNCj4gDQo+ICAgVGhlIG1vc3QgcGVyZm9ybWFudCBJUlEgZGlzdHJpYnV0aW9uIGJh
c2VkIG9uIHRoZSBhYm92ZSB0b3BvbG9neQ0KPiAgIGFuZCBoZXVyaXN0aWNzIG1heSBsb29rIGxp
a2UgdGhpczoNCj4gDQo+ICAgSVJRICAgICBOb2RlcyAgIENvcmVzICAgQ1BVcw0KPiAgIDAgICAg
ICAgMSAgICAgICAwICAgICAgIDAtMQ0KPiAgIDEgICAgICAgMSAgICAgICAxICAgICAgIDItMw0K
PiAgIDIgICAgICAgMSAgICAgICAwICAgICAgIDAtMQ0KPiAgIDMgICAgICAgMSAgICAgICAxICAg
ICAgIDItMw0KPiAgIDQgICAgICAgMiAgICAgICAyICAgICAgIDQtNQ0KPiAgIDUgICAgICAgMiAg
ICAgICAzICAgICAgIDYtNw0KPiAgIDYgICAgICAgMiAgICAgICAyICAgICAgIDQtNQ0KPiAgIDcg
ICAgICAgMiAgICAgICAzICAgICAgIDYtNw0KPiANCj4gPiBCdXQgSSBjYW4ndCBmaWd1cmUgb3V0
IHdoYXQNCj4gPiAid2VpZ2h0IiBpcyB0cnlpbmcgdG8gYWNjb21wbGlzaC4gTWF5YmUgdGhpcyB3
YXMgZGlzY3Vzc2VkIHdoZW4gdGhlIGNvZGUgZmlyc3QNCj4gPiB3ZW50IGluLCBidXQgSSBjYW4n
dCByZW1lbWJlciBub3cuIDotKA0KPiANCj4gVGhlIHdlaWdodCBoZXJlIGlzIHRvIGltcGxlbWVu
dCB0aGUgaGV1cmlzdGljIGRpc2NvdmVyZWQgYnkgU291cmFkZWVwOg0KPiBOVU1BIGxvY2FsaXR5
IGlzIHByZWZlcnJlZCBvdmVyIHNpYmxpbmcgZGlzbG9jYWxpdHkuDQo+IA0KPiBUaGUgb3V0ZXIg
Zm9yX2VhY2goKSBsb29wIHJlc2V0cyB0aGUgd2VpZ2h0IHRvIHRoZSBhY3R1YWwgbnVtYmVyIG9m
DQo+IENQVXMgaW4gdGhlIGhvcC4gVGhlbiBpbm5lciBmb3JfZWFjaCgpIGxvb3AgZGVjcmVtZW50
cyBpdCBieSB0aGUNCj4gbnVtYmVyIG9mIHNpYmxpbmcgZ3JvdXBzIChjb3Jlcykgd2hpbGUgYXNz
aWduaW5nIGZpcnN0IElSUSB0byBlYWNoDQo+IGdyb3VwLg0KPiANCj4gTm93LCBiZWNhdXNlIE5V
TUEgbG9jYWxpdHkgaXMgbW9yZSBpbXBvcnRhbnQsIHdlIHNob3VsZCB3YWxrIHRoZQ0KPiBzYW1l
IHNldCBvZiBzaWJsaW5ncyBhbmQgYXNzaWduIDJuZCBJUlEsIGFuZCBpdCdzIGltcGxlbWVudGVk
IGJ5IHRoZQ0KPiBtZWRpdW0gd2hpbGUoKSBsb29wLiBTbywgd2UgZG8gbGlrZSB0aGlzIHVubGVz
cyB0aGUgbnVtYmVyIG9mIElSUXMNCj4gYXNzaWduZWQgb24gdGhpcyBob3Agd2lsbCBub3QgYmVj
b21lIGVxdWFsIHRvIG51bWJlciBvZiBDUFVzIGluIHRoZQ0KPiBob3AgKHdlaWdodCA9PSAwKS4g
VGhlbiB3ZSBzd2l0Y2ggdG8gdGhlIG5leHQgaG9wIGFuZCBkbyB0aGUgc2FtZQ0KPiB0aGluZy4N
Cj4gDQo+IEhvcGUgdGhhdCBoZWxwcy4NCg0KWWVzLCB0aGF0IGhlbHBzISBTbyB0aGUga2V5IHRv
IHVuZGVyc3RhbmRpbmcgIndlaWdodCIgaXMgdGhhdA0KTlVNQSBsb2NhbGl0eSBpcyBwcmVmZXJy
ZWQgb3ZlciBzaWJsaW5nIGRpc2xvY2FsaXR5Lg0KDQpUaGlzIGlzIGEgZ3JlYXQgc3VtbWFyeSEg
IEFsbCBvciBtb3N0IG9mIGl0IHNob3VsZCBnbyBhcyBhDQpjb21tZW50IGRlc2NyaWJpbmcgdGhl
IGZ1bmN0aW9uIGFuZCB3aGF0IGl0IGlzIHRyeWluZyB0byBkby4NCg0KTWljaGFlbA0K

