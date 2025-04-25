Return-Path: <linux-hyperv+bounces-5154-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F4EA9CF65
	for <lists+linux-hyperv@lfdr.de>; Fri, 25 Apr 2025 19:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D0DB1BA0526
	for <lists+linux-hyperv@lfdr.de>; Fri, 25 Apr 2025 17:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 260331F3B96;
	Fri, 25 Apr 2025 17:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="jU+QCkAX"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2137.outbound.protection.outlook.com [40.107.117.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6233519F11F;
	Fri, 25 Apr 2025 17:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745601537; cv=fail; b=hUUCjTqjkKW3d2Yr2oz1OJUVnHhjoh5NjbCXn1V4tHqTOOv1vavufrzYMeASMOEx4flPhhSCTFwPtU2Ro+gD4kJ2kpJFuSFWtoHOVRKyQGFcDrqT+SHU3Q+IcOgLmAxejVVhDwFwbsQ9fPby+VX5aJhByKyL3kXsN7rikTn+9SY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745601537; c=relaxed/simple;
	bh=iExCI0UW/ItiJx+H0TRH2m0ycCJfTT/+E3eJp605X6E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=u5TXTOlIdLjm5w8NnVkJT6ujbAGWsxjUDnEEgOepwzQ3k6LBfvXWkex6SRWnBxny+lYxMAYUCSWcbo6MowhRqB2UpAUVWOC0knqyR7Jzm03xS0boGTpMohJg6dfN6GqQPhAcijbiGpklt3mRje6ik9NoL1Tt3cicwTk9YZpMjLc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=jU+QCkAX; arc=fail smtp.client-ip=40.107.117.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bT0ZU2cFt14z02Z/3ATEwo5tHsY5tedNke1Hv0/LHadRf6EXsUsqvvMKtF5+Hj/AgfavfK7Vu5viP67I/IEumSrVYfJsxg9e3v9a8VNJR7WBDlLgi9kOb56nQQK9e4e1vOkL9hFsfM3UUvM82e+X/blKWQu9TMOmEW1PLjA46Dyrm1Sc+gwy+uPR4Ol9lVlja6qYP6AuS6yaSYssZK9JYuYmrKKr7zL2LNRfZi2C/f3d5ZvMNsU2B7ZEytSbnYGSXcSEhBD1Nxw7kAzOnfdbl3kdYFMaQOD2kZzT+gdMMeJhe8Msob2hFJ/+hsdxtFyeWF1zTNSA+w6zEhCp/NTSew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iExCI0UW/ItiJx+H0TRH2m0ycCJfTT/+E3eJp605X6E=;
 b=pAYdie+UjX5WGM5ax/7uzvh0P0g3ZaDO0bcZwn/ohEh8GwwJBnQJGtxXO9Uwr6LjeYkO1QI2QLzEdcd4e4meo8s0YaPmZRcaC91EKzpYuGmMxg12CWt5IX1LlM7CJN8qI/X0DwmEw43IoI6kTshOmK44x2FiVojZRNyV6O2PCZVUtbSwNeLkx5Sp72v9ZNCMkkul2cI7OcWvnf5fJmKDzguxQY2zESdym7E2n5z6rPeDtrbxSSFH0efPTfN1x9mzLISjj8iZ7PMAN/y9DMJXemgG3mP4BEL0zloO9+5+716pziXR/uxCGUCiqJ9TkhpQM6Gty4XPuFav3l06DVZEEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iExCI0UW/ItiJx+H0TRH2m0ycCJfTT/+E3eJp605X6E=;
 b=jU+QCkAXCGnUyloSPyKuzpPrL3ZN9XXJL4mDQYSiwVrRC3WvanWduQzVYNeZbKIE1gPMz+8lWtj/losdJc7roAT2IA1PVA5Vx1QOlf3LTCFN9bMXISIxfKhV+mUjZocOQbF3zeCy/CsTE7aaqmiZt3XDLKsP9SMXO5PQNlke8GQ=
Received: from KUZP153MB1444.APCP153.PROD.OUTLOOK.COM (2603:1096:d10:36::22)
 by PUZP153MB0712.APCP153.PROD.OUTLOOK.COM (2603:1096:301:e4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.10; Fri, 25 Apr
 2025 17:18:47 +0000
Received: from KUZP153MB1444.APCP153.PROD.OUTLOOK.COM
 ([fe80::1d66:c349:800b:f365]) by KUZP153MB1444.APCP153.PROD.OUTLOOK.COM
 ([fe80::1d66:c349:800b:f365%4]) with mapi id 15.20.8699.010; Fri, 25 Apr 2025
 17:18:40 +0000
From: Saurabh Singh Sengar <ssengar@microsoft.com>
To: Roman Kisel <romank@linux.microsoft.com>, Wei Liu <wei.liu@kernel.org>
CC: "bp@alien8.de" <bp@alien8.de>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, Dexuan Cui <decui@microsoft.com>, Haiyang
 Zhang <haiyangz@microsoft.com>, "hpa@zytor.com" <hpa@zytor.com>, KY
 Srinivasan <kys@microsoft.com>, "mikelley@microsoft.com"
	<mikelley@microsoft.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, Tianyu Lan
	<Tianyu.Lan@microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, Allen Pais
	<apais@microsoft.com>, Ben Hillis <Ben.Hillis@microsoft.com>, Brian Perkins
	<Brian.Perkins@microsoft.com>, Sunil Muthuswamy <sunilmut@microsoft.com>
Subject: RE: [EXTERNAL] Re: [PATCH hyperv-next] x86/hyperv: Fix APIC ID and VP
 ID confusion in hv_snp_boot_ap()
Thread-Topic: [EXTERNAL] Re: [PATCH hyperv-next] x86/hyperv: Fix APIC ID and
 VP ID confusion in hv_snp_boot_ap()
Thread-Index: AQHbtamOlIwzG2IG/UqbRMBi4sMoobO0DOYwgACKFgCAAAXywA==
Date: Fri, 25 Apr 2025 17:18:40 +0000
Message-ID:
 <KUZP153MB14448BEFA81251661433CE33BE842@KUZP153MB1444.APCP153.PROD.OUTLOOK.COM>
References: <20250424215746.467281-1-romank@linux.microsoft.com>
 <aAsonR1r7esKxjNR@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
 <KUZP153MB1444118E6199CBED8C78E6D4BE842@KUZP153MB1444.APCP153.PROD.OUTLOOK.COM>
 <8fa1045a-c3e9-48e0-86fe-ab554d7475c8@linux.microsoft.com>
In-Reply-To: <8fa1045a-c3e9-48e0-86fe-ab554d7475c8@linux.microsoft.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=3d49043e-8d19-4f25-95ac-4b1745e0668f;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-04-25T17:04:38Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KUZP153MB1444:EE_|PUZP153MB0712:EE_
x-ms-office365-filtering-correlation-id: fa11f0a3-9117-4459-4089-08dd841d38f7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|10070799003|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?eGtXbE5QUXU2Y2VHQ3pJemtOL1ZvOTFMN3Mzczl3N1g1ME1qRDBZUU12V3ZQ?=
 =?utf-8?B?dlNJU2R4Q2haRm9ScXhZT3lUV3NzVlMvZEhzemQ5Z0JXYTdhNVdwZjJpUmth?=
 =?utf-8?B?czNBVWtjS1NKNjdWVitBZTFEWU83RlZoYTc5V082cTJRYWsxQXdFTnJaUUFJ?=
 =?utf-8?B?blA5NkphWkIvYm5sbmwwVzBjMSsvZmdmVTNHdkkvRUZaNmNLY1YzOWpTY3VL?=
 =?utf-8?B?eWFGK3BDbmo5eXRBS2h3S3VBV3VSOURjYU1rajUrYUdWNTJuZExocW9LNmU4?=
 =?utf-8?B?M0FKZnlyTWZKM0tLVllPbEdUU001Z3RpN1Y0N3hXaWttUGlXRVNJUXRScE9p?=
 =?utf-8?B?dW5Qd0tKYmQ3bE5COWZGR25USGRQdlRBdlNBdC9QczZzRWErd0psQWJBclhO?=
 =?utf-8?B?akd1VFFmK1pqSmVhd3gxVVdsa0tOL3grUndSSHJVRDhKWE5HcGtFNmN5UTlR?=
 =?utf-8?B?VjhXb0pRNisvNVFMYzU4RnJ1cHlpNjNJOHoxS3JJNGk1ZExmdEl6cFMxVVVD?=
 =?utf-8?B?RFBqR1Ywd1lBNjB3UjBGK0NnWCtUSHRrUTdTWGdiSXV3TnJoV3REaStJcTdD?=
 =?utf-8?B?a3ZwV2xXSUNUeUVjbnZLbXE4Z3ZaY1VVQVFtaHBRelQxdlhtbTdtNXBEMThW?=
 =?utf-8?B?dDY3d09MY3p3Nm9Na3Y1Q0tPSzNndkxrYTlmdXA1WWd2aGxVZW12dkRlano2?=
 =?utf-8?B?UzNNSDhScytxQ0JyYkVUUkxuYnJKM1J2TlJLVVRBVGFuL3N6MmVsVzVVbjVG?=
 =?utf-8?B?T0NxcThkUTJOSTQ4eGtGb0M5d0pGR2FlbzdMOFd2bmxhSk5CNXVLSnRVMHRQ?=
 =?utf-8?B?Z2E2blZjWkZWYk1ZWHpRc2h6amhuZnRqaXlrV1ZBVkdIaEIzM29Fc2RRZjBW?=
 =?utf-8?B?WGo3OHVVVk93clNGRTRrK0FhNE1ZdWRlSEhxdmpkU0tRRTlMU0pOYVM0S0tG?=
 =?utf-8?B?d08ydGxhWE5Eb3ZzWS8zYldSVTVsMVVsRExsSHc4TlNYMjhKNXN6cmFBeG5V?=
 =?utf-8?B?Q2tKUGhWc0txRFdkMTh6Q25lWXZ1dERzT2xoSWFmMmJEUUdGMm85TzRXampn?=
 =?utf-8?B?Tk5DSTRHd1RvSUNKTUdTNDg2cllPTDV0Wm5kR040UEh5Z2UrRWp6ckRtNlNy?=
 =?utf-8?B?TXFCSDVwSlEzWUZ0UlFDWEIwdXlYejVFeVhvbW5ET2QyWjA5b2REUUtaKzh4?=
 =?utf-8?B?dTZpUVRScUhHUHdOUmtyakN2WWNjSFpRZGxWSm1UcStoU2RzbHBvTnh3aVpl?=
 =?utf-8?B?clE0R0hNYUkyeEVVRmpHZ1duc2ZQVjNISUZ1RDFLWjVsTUlVQnArQUsxRDJp?=
 =?utf-8?B?Q0toTWlWcEtaRU9hTDMxUHNXOStFM0ZVMmtHUXkwU1NkRTRXeHJobmo1MWlu?=
 =?utf-8?B?aUZDQXo3aE1jeXFyNzU4UlpZOC9vb2ExRkNOeTAzTyt0WUI1bmZEaFdZRklv?=
 =?utf-8?B?WUYwWWpPeGlWUGdEaFBSUkpqUXJXVDkreWVJU1RUTVNJc0xVNENCWkpCQ3Yz?=
 =?utf-8?B?L3hXZDJteExJZGdxWGgwQ29YRlhxbU1ZT2E3aFhHRXBmYnNnWDB0U3puMlVV?=
 =?utf-8?B?RDVHZDRHTlBXY1RzUGg2bWhkZVp5U3lmRkFIdkVudS9Ub2lOUkhqR2dxMURN?=
 =?utf-8?B?a3NYSU9aRG5wT2tqME5ycVJzd3A1U3drb2tUc2k4bVR0SkltYTVVanRuMEhT?=
 =?utf-8?B?ZVEyUnZlQWtxd3pVKzhvMGdMUDRlYVhwYW1MK1A5dXZPcG9ySXUybERicFBS?=
 =?utf-8?B?UlVWN1VQajgxcXRwSTFRdXQrQ1h2VE8rVmoraGJwZXBUdU1aTVc3M2J0aldT?=
 =?utf-8?B?ZVArd0NnMllxeVRCbmtqRHppQXYrd0h0U3hQQVVhWmJKeUg1R09jQ0hxSEJV?=
 =?utf-8?B?WXU0M3dPQ0RHK3NUVzBpU3VGTTRtUGRMTFdnSFNSS0lqUm1kS1E4RXd6WnNr?=
 =?utf-8?Q?0SzlGOHpxRU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KUZP153MB1444.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?THltSE9pbHBWOWlENGNlRS9QNXVjT2dDZFJoNHU0eCt3K0FnZnpHTnZTQ1Jr?=
 =?utf-8?B?azJ1K05SR3lNSG5OYmFBTUJ1dGxkWHlHdTBEY2RHTkNBaEo4ckgzcXdmYzRB?=
 =?utf-8?B?dG91SVBQdDdRU0tCT0IxYWZJY3k2Z0FETFJ1NmVwZzdNamQ1bjRaTEJwRGNk?=
 =?utf-8?B?L2I3T1lNMHIvZUEwL25oYzBlV2tTWk4zR2ZXUkVTME9XcWxKby91MlMzZ3B6?=
 =?utf-8?B?NVZsa1VWTUNsSm5mc1pDTDJNWkhoUFVWQ0x5UGxBaVVPMmsvMGU2MUhWTW5M?=
 =?utf-8?B?cmxCY290MEdWUzVzZXdPVWc3VUoyQkV1aWNQbllDN3Z1Ym94eXFTV1pyeGxD?=
 =?utf-8?B?OEV3aUN4VGRQK2pDVDZZamdWWnpKZ0Z1NHZKcnB6VWJNQVBrTkVSYzNtYUE2?=
 =?utf-8?B?bDhUU2NObTVxZ1JlYzRVVkFMSHVNUldHU2pQeU0yeXYwaUtBU1lENmo3Sm9k?=
 =?utf-8?B?RVdUZ0g4dUFncTM1eEtEcy9wc0RjYVBNcmJ5d24wRG9kOTV3VzcxU2wvRUpL?=
 =?utf-8?B?SjhoNFFWZEVDRis5UUZMOWUya1dlaXErdkl0YVVQUWpibGhZd05GaHBnenVk?=
 =?utf-8?B?NUE3QnBvUGFZaW9Cbm1nNVVqWDU3c3dwYWJIeE84clI0SUVJRWJleFB3ZDZ2?=
 =?utf-8?B?K3Q2VWVZMGZCbWQ4cGNGRWJqT213NUNiQjFJemNvSjVscWZKRVhtbUdqR3F3?=
 =?utf-8?B?OWNPcUVsVnNJTWpzKzdMQ1lTKzRtWUNWYkNpTjNDTWhtK2VZaWZ2dXluZHFL?=
 =?utf-8?B?NTB0bHlITEZqdFlLS0hrWnFzMVlFOGVUTjF5Lzk3Y1ZzSitCSWJqSWVBRUNj?=
 =?utf-8?B?cWZYRGZxODNvWk5IRWd0Q08rVGtBUHhNQWVocjRobmI3b3AyV2tTN2VwNUZF?=
 =?utf-8?B?d3k1ZW1vL09CS3NzVjRBQ0ZNM3dvV0NlMnZNODdKRFZjVGs3MXFDVjNISHpX?=
 =?utf-8?B?czZqNnN1RUJkRFFxYS8zL0U5dUFKN0h5dGVPRXpNVm1RT0FqSHhvbWlxNDFm?=
 =?utf-8?B?ZDZsOXZuQkhSVzRvc1FTUkdhWExZMVZJazY1Y0FDUmlVdUN2SXZhYm9aeHUv?=
 =?utf-8?B?RzN2SmVsZktON3BLdndKMXdVQnJKalp2dTluT1p2U1hUSHZyMHp3ejBLdHRF?=
 =?utf-8?B?NjJUVVhKSjhLdElEcmc1U0NoLzlUVTU5aHNGVUdNUWF1YmNZbWoyQSt0amQw?=
 =?utf-8?B?UmIwczFyS0h6MHpWNGl5VHp2d1JsSEwvQ08wa1pSczBGc1NzVUZ2S0cxbS85?=
 =?utf-8?B?QUtBMUM4VU9nQ1NvTTVCRGpSZlozYjJZZ0dUVjJQV0ZvUWdRWUVCVkEvYmwx?=
 =?utf-8?B?aHZIY01HTG9KNjloejMvV3RxdTRxQWhQSnM4VWhnZlAvdnU1eWhhWTg3b2hN?=
 =?utf-8?B?TnpScjdaSVNEVGY5QUd6anNuQW5ic1JKTldyUlpidTd2SHZiVGMxOWloTnp0?=
 =?utf-8?B?N21CQVhKUXhiR2V0N1ZOUVRNOWp2Q0ZtVU5semFJUGhNMVlDVlMwbU12M0cw?=
 =?utf-8?B?SnpMVzQ5S093M2x3K2J3R0dWSXBRVS9jVENTejE0VnBVdUY3ZWpnNzl1KzdN?=
 =?utf-8?B?Sk9mQytQUTBqM1o3TUR0YjFoNmIrSEhHbThpQ2s5OElnQUxsTkRpVUFCV2hC?=
 =?utf-8?B?MWdlTVptSGlDQ3llK3JaTERnZWNIb3dIUE1ncFRRZzlkZTI2S0RkNFhwR2JR?=
 =?utf-8?B?bDhuYnpVQTMyYmNtMUd2Q0tkck5sOU15RVprL3E0L1Y3L0JBMGJSdmdNTDRZ?=
 =?utf-8?B?Wjl1cG55Q1NZZFJEM2dwN3c3UHJ1ZWFYbGNYbHIvZnFaMUVkNnVOcHFBQVo5?=
 =?utf-8?B?TjREWUdPTkN2UzBWS2d1Sk0vanc0OHpJMFBRVGFMQ1J5anR5WmxJUFJNSkFZ?=
 =?utf-8?B?L0hTc1pvL2ZuNkhRakUvVUpJQmVRNDRGNHJzSVFXNUpCTG5VdFRMMUdaTzFz?=
 =?utf-8?B?b2V0anh2RENYTjdCKzZxNHQyM3o1cm1Vb3hQczdBeDBrS2drcFVxalVYaDZq?=
 =?utf-8?B?ZnZtelZJZ1B2Mnl5UW5YTE5iay9WN202elE4NFE0OVkvRWFsYVlidzA5aWVs?=
 =?utf-8?B?NEdxUzJQOTF5dUNGOHFlbUp1ZDlqWHlFVWVHR1NqQUU3RGovNmF5R1BJUjhR?=
 =?utf-8?Q?7knTiR/21EvroWd7eWSeWMnIH?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KUZP153MB1444.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: fa11f0a3-9117-4459-4089-08dd841d38f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2025 17:18:40.0684
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HVeKv/FX4hLnmw2MCthk/Oj8wyGfnfUv1RZHtDDWdc5yzWd92yMtwAsJ7L+Ll/iVe9xoTSGiX0iaWFgKblP6wA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZP153MB0712

IA0KPiBPbiA0LzI1LzIwMjUgMjoxNCBBTSwgU2F1cmFiaCBTaW5naCBTZW5nYXIgd3JvdGU6DQo+
ID4+DQo+ID4+IE9uIFRodSwgQXByIDI0LCAyMDI1IGF0IDAyOjU3OjQ2UE0gLTA3MDAsIFJvbWFu
IEtpc2VsIHdyb3RlOg0KPiA+Pj4gVG8gc3RhcnQgYW4gYXBwbGljYXRpb24gcHJvY2Vzc29yIGlu
IFNOUC1pc29sYXRlZCBndWVzdCwgYSBoeXBlcmNhbGwNCj4gPj4+IGlzIHVzZWQgdGhhdCB0YWtl
cyBhIHZpcnR1YWwgcHJvY2Vzc29yIGluZGV4LiBUaGUgaHZfc25wX2Jvb3RfYXAoKQ0KPiA+Pj4g
ZnVuY3Rpb24gdXNlcyB0aGF0IFNUQVJUX1ZQIGh5cGVyY2FsbCBidXQgcGFzc2VzIGFzIFZQIElE
IHRvIGl0IHdoYXQNCj4gPj4+IGl0IHJlY2VpdmVzIGFzIGEgd2FrZXVwX3NlY29uZGFyeV9jcHVf
NjQgY2FsbGJhY2s6IHRoZSBBUElDIElELg0KPiA+Pj4NCj4gPj4+IEFzIHRob3NlIHR3byBhcmVu
J3QgZ2VuZXJhbGx5IGludGVyY2hhbmdlYWJsZSwgdGhhdCBtYXkgbGVhZCB0byBodW5nDQo+ID4+
PiBBUHMgaWYgVlAgSURzIGFuZCBBUElDIElEcyBkb24ndCBtYXRjaCwgZS5nLiBBUElDIElEcyBt
aWdodCBiZQ0KPiA+Pj4gc3BhcnNlIHdoZXJlYXMgVlAgSURzIG5ldmVyIGFyZS4NCj4gPj4+DQo+
ID4+PiBVcGRhdGUgdGhlIHBhcmFtZXRlciBuYW1lcyB0byBhdm9pZCBjb25mdXNpb24gYXMgdG8g
d2hhdCB0aGUNCj4gPj4+IHBhcmFtZXRlciBpcy4gVXNlIHRoZSBBUElDIElEIHRvIFZQIElEIGNv
bnZlcnNpb24gdG8gcHJvdmlkZSBjb3JyZWN0DQo+ID4+PiBpbnB1dCB0byB0aGUgaHlwZXJjYWxs
Lg0KPiA+Pj4NCj4gPj4+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+ID4+PiBGaXhlczog
NDQ2NzZiYjlkNTY2ICgieDg2L2h5cGVydjogQWRkIHNtcCBzdXBwb3J0IGZvciBTRVYtU05QDQo+
ID4+PiBndWVzdCIpDQo+ID4+PiBTaWduZWQtb2ZmLWJ5OiBSb21hbiBLaXNlbCA8cm9tYW5rQGxp
bnV4Lm1pY3Jvc29mdC5jb20+DQo+ID4+DQo+ID4+IEFwcGxpZWQgdG8gaHlwZXJ2LWZpeGVzLg0K
PiA+DQo+ID4gVGhpcyBwYXRjaCB3aWxsIGJyZWFrIHRoZSBidWlsZHMuDQo+ID4NCj4gPiBSb21h
biwNCj4gPiBIYXZlIHlvdSB0ZXN0ZWQgdGhpcyBwYXRjaCBvbiB0aGUgbGF0ZXN0IGxpbnV4LW5l
eHQgPw0KPiANCj4gVGhhbmtzIGZvciB5b3VyIGhlbHAhIE9ubHkgb24gaHlwZXJ2LW5leHQsIGxv
b2tpbmcgaG93IHRvIHJlcHJvIGFuZCBmaXggb24NCj4gbGludXgtbmV4dC4gVGhlIGtlcm5lbCBy
b2JvdCB3YXMgaGFwcHksIG9yIEkgYW0gbWlzc2luZyBzb21lIGNvbnRleHQgYWJvdXQNCj4gaG93
IHRoZSByb2JvdCB3b3Jrcy4uLg0KPiANCj4gV2hhdCB3YXMgeW91ciBrZXJuZWwgY29uZmlndXJh
dGlvbiwgb3IganVzdCBhbnl0aGluZyB0aGF0IGVuYWJsZXMgSHlwZXItVj8NCj4gDQo+IEkgdGhv
dWdodCB0aGUgdGhlIGxpbnV4LW5leHQgdHJlZSB3b3VsZCBiZSBhIHN1YnNldCBvZiBoeXBlci1u
ZXh0IHNvIHNob3VsZA0KPiB3b3JrLCByZWFsaXppbmcgdGhhdCBoYXZlIHRvIGNoZWNrLCBsaWtl
bHkgdGhlcmUgbWlnaHQgYmUgY2hhbmdlcyBmcm9tIG90aGVyDQo+IHRyZWVzLg0KPiANCg0KDQpo
eXBlcnYtZml4ZXMgaXMgYnJva2VuIHRvbywgaGVyZSdzIHRoZSBsb2cgZm9yIHlvdXIgcmVmOg0K
DQpodHRwczovL2Rhc2hib2FyZC5rZXJuZWxjaS5vcmcvbG9nLXZpZXdlcj9pdGVtSWQ9bWljcm9z
b2Z0JTNBMjAyNTA0MjUwODU4MzM5MTY3OTAmbz1taWNyb3NvZnQmdHlwZT1idWlsZCZ1cmw9aHR0
cHMlM0ElMkYlMkZsaXNhbG9nc2IxNTg1MGQzLmJsb2IuY29yZS53aW5kb3dzLm5ldCUyRmxpc2Et
bG9ncyUyRmRlZmF1bHRfZGVmYXVsdCUyRjIwMjUwNDI1JTJGMjAyNTA0MjUtMDg1MTEwLTM5MyUy
Rmtlcm5lbF9pbnN0YWxsZXIlMkZidWlsZC5sb2clM0ZzdCUzRDIwMjUtMDQtMjVUMDklMjUzQTA5
JTI1M0EzNVolMjZzZSUzRDIwMjUtMDUtMDJUMDklMjUzQTA5JTI1M0EzNVolMjZzcCUzRHIlMjZz
diUzRDIwMjQtMTEtMDQlMjZzciUzRGIlMjZza29pZCUzRDE0YjUzYjFkLWY0ZmMtNDQyZS1hNDM3
LTQ5ODkzNzZiMTc1NCUyNnNrdGlkJTNENzJmOTg4YmYtODZmMS00MWFmLTkxYWItMmQ3Y2QwMTFk
YjQ3JTI2c2t0JTNEMjAyNS0wNC0yNVQwOSUyNTNBMDklMjUzQTM1WiUyNnNrZSUzRDIwMjUtMDUt
MDJUMDklMjUzQTA5JTI1M0EzNVolMjZza3MlM0RiJTI2c2t2JTNEMjAyNC0xMS0wNCUyNnNpZyUz
RFpIZkE3JTJGQzE3NEtSNkhUOHpoY2hDYjQ3TkUxYWNlcXc4aDBBUHpLeHNJSSUyNTNEDQoNClRo
ZSBodl9zbnBfYm9vdF9hcCgpIGZ1bmN0aW9uIGluIGFyY2gveDg2L2h5cGVydi9pdm0uYyBjdXJy
ZW50bHkgZmFpbHMgdG8gY29tcGlsZS4NCkl0IGxvb2tzIGxpa2UgdGhlIGZ1bmN0aW9uJ3MgYXJn
dW1lbnQgd2FzIGNoYW5nZWQgZnJvbSAnY3B1JyB0byAnYXBpY19pZCcsIGJ1dCBpbnRlcm5hbA0K
cmVmZXJlbmNlcyB0byBjcHUgd2VyZSBub3QgdXBkYXRlZCBhY2NvcmRpbmdseS4NCg0KVGhpcyBt
aWdodCBoYXZlIGdvbmUgdW5ub3RpY2VkIGR1cmluZyB5b3VyIHRlc3RpbmcgaWYgQ09ORklHX0FN
RF9NRU1fRU5DUllQVA0Kd2FzIGRpc2FibGVkLCBpbiB3aGljaCBjYXNlIHRoaXMgZnVuY3Rpb24g
d291bGRuJ3QgaGF2ZSBiZWVuIGNvbXBpbGVkLg0KDQpSZWdhcmRzLA0KU2F1cmFiaA0K

