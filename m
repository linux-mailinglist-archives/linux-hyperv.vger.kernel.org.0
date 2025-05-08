Return-Path: <linux-hyperv+bounces-5425-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2DFAAAF158
	for <lists+linux-hyperv@lfdr.de>; Thu,  8 May 2025 05:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFD131C22982
	for <lists+linux-hyperv@lfdr.de>; Thu,  8 May 2025 03:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C77AFD530;
	Thu,  8 May 2025 03:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="KlL5QHkW"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sg2apc01on2134.outbound.protection.outlook.com [40.107.215.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A14B667;
	Thu,  8 May 2025 03:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746673239; cv=fail; b=RGPHt8CAIfypm7BYA6Phf8luE0COrMtVqVIel116MsqtruWOjI/XCX/m8c07Rhlx/zStPUZDgMIhw7EaYidoGUiXKXjJKLPd2ebAo8Fz1uZxSFhfQ9/kam8goBhZyfwrHoi9MRye3gl3IZv32fq5pdZrI4wH+1mSxci0h9gyVL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746673239; c=relaxed/simple;
	bh=kuRiopYPGMzqv0hmkvZIPuoWHrwECLltV4x+ByCz53E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lSzGEAecbd822Mn9J/EjnlO4cmvUrCpUzISfSfJwDKIMclThcx2vC/L11zV9WfRDGl25jwrc3+TEi3hmhNIfsW5mvgtXkGAKjVeYsyLougalUsIuqAehrOc8CYEXFkOl4nJIR4kLYLIxWAG4VXSekieTRMVC3VS0pZfCGZQh3us=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=KlL5QHkW; arc=fail smtp.client-ip=40.107.215.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VmU1nk62zQ0jTXz8O8uPIvmowk5ch8WaHEsBqinLyCs8suQgXUrP8iozSMzPkpmlKBVNhqhCCi9+CG8xBnVcNBwI2CORF9JpuD68ddwS94Lc8Wlu82a/xDI+0pchs4jFZdWIjRTwZ1Y9okCnOR5YB31aQRDydPM68UQUqxb8fFh3nd8kswM8qOYt5aT1QPzVTH1oGWN1AndLrumipEBwJP7JPqQ62AU1CN73AbMGyGg4DQXW12e8b3t6DNcvwuNIbM0kcB8kLtc1BTGXlWAfFhJSkpGITYUKUVjg5knjkWUu4tsGnWXLrYM+WyMKsYqQmi3E5t56WgU/SweoA+QC/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kuRiopYPGMzqv0hmkvZIPuoWHrwECLltV4x+ByCz53E=;
 b=hbdhE4FO4/aS8z1snrqJ06ifTm/lw29iciJNvpLvaI3WjBW+F9CNXDhK9iMP1WVBWeBKDpZPKTB30tw6PPbwmVDHVQKYwBGyqQ8A4tnFo0123awIGrV3D4XnOFf5aQnsLubpttlIEdSl/CwnAH04bbThPOeellKJPhXT0hgTupr7Bw0XJScjjpmnWwOMmYQQ46MrwR9r3Rv2iA86Uk1Fu5vXWdfE5k0jMi+34mp9milWs98b2m1JMvj5uXpcFLjT9zWqcszs1k+BFj4gys5k8IQNTOzX5llTNfosnayAvREIwWiwJ0Nijm6CS5Mo1m13ivTD/NiODjILH8r02ik5tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kuRiopYPGMzqv0hmkvZIPuoWHrwECLltV4x+ByCz53E=;
 b=KlL5QHkWhomisd6u6+YL7NaxwV25H3z8UpNhmcv3vosnJXP6WY6vqJUIrGlXmX4Pxe/IrIQbc45/SxGUFKUc2csSl+8gq72+5IGZkCALjoKo7VsL51ekjhcdy/nG4JF91xJCZ7BOXSqaZH4IcZDlMVyEZxMgK+j62IjUfhMk4BA=
Received: from KUZP153MB1444.APCP153.PROD.OUTLOOK.COM (2603:1096:d10:36::22)
 by SEYP153MB1123.APCP153.PROD.OUTLOOK.COM (2603:1096:101:2b7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.12; Thu, 8 May
 2025 03:00:33 +0000
Received: from KUZP153MB1444.APCP153.PROD.OUTLOOK.COM
 ([fe80::1d66:c349:800b:f365]) by KUZP153MB1444.APCP153.PROD.OUTLOOK.COM
 ([fe80::1d66:c349:800b:f365%5]) with mapi id 15.20.8746.002; Thu, 8 May 2025
 03:00:33 +0000
From: Saurabh Singh Sengar <ssengar@microsoft.com>
To: Roman Kisel <romank@linux.microsoft.com>, Naman Jain
	<namjain@linux.microsoft.com>, KY Srinivasan <kys@microsoft.com>, Haiyang
 Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
	<decui@microsoft.com>
CC: Anirudh Rayabharam <anrayabh@linux.microsoft.com>, Saurabh Sengar
	<ssengar@linux.microsoft.com>, Stanislav Kinsburskii
	<skinsburskii@linux.microsoft.com>, Nuno Das Neves
	<nunodasneves@linux.microsoft.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH] Drivers: hv: Introduce mshv_vtl driver
Thread-Topic: [PATCH] Drivers: hv: Introduce mshv_vtl driver
Thread-Index: AQHbvmPWwq1NkNsYtEq9b/XTYQeJpbPG7DDggAAbfACAAJmaAIAAbIKA
Date: Thu, 8 May 2025 03:00:33 +0000
Message-ID:
 <KUZP153MB14448028621F8148D5129D9FBE8BA@KUZP153MB1444.APCP153.PROD.OUTLOOK.COM>
References: <20250506084937.624680-1-namjain@linux.microsoft.com>
 <KUZP153MB1444BE7FD66EA9CA9B4B9A97BE88A@KUZP153MB1444.APCP153.PROD.OUTLOOK.COM>
 <be04a26f-866d-43e6-9a0b-15b91405503e@linux.microsoft.com>
 <29edc00e-9797-4f4a-83b3-0b4158c94a16@linux.microsoft.com>
In-Reply-To: <29edc00e-9797-4f4a-83b3-0b4158c94a16@linux.microsoft.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=6b1e7487-215f-4e0c-9013-b86fa2427564;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-05-08T02:59:57Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KUZP153MB1444:EE_|SEYP153MB1123:EE_
x-ms-office365-filtering-correlation-id: 4e2ebb54-d47f-40e9-2a2d-08dd8ddc800b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?aHF3T0JUUlB4S0k3SDdiTUo1YlFrL3NsOSsySTVQY1Z4TFNRWWN1Q3V1MGpN?=
 =?utf-8?B?ZjluOFNJWWs1alduM21QeUViSXpML3dZRHJOcUlMbVhzTW56QnpPRS8waWJu?=
 =?utf-8?B?cmcwNlVtTmMxbmpuL3AxYkxQVERKWkV0OVVCbkZIZUNuL3NaODFLNTJETDBo?=
 =?utf-8?B?Y2hXYUJwdmJKdFFjYkhhRUFTTFhiZnNqTnd4czVJMzlVdlEvaFM3K0lMbTlj?=
 =?utf-8?B?RmVxa2kvd1ZKZzZOZHR5THBkTGdvd016ZVdldm5LMTRvb21ROVVYYUErZmJs?=
 =?utf-8?B?VXZRd1A5QXMyZCtHczJBUXBReHFHdWdjQkdmMnZzVjdGVlVHTnA4dDFVRWVz?=
 =?utf-8?B?VVFoNFNKZW54Rk9mYWd6TUpxMWVQSlpwMjlrUEtzWGcxaHpNaUczQUJBaHZp?=
 =?utf-8?B?cnU1Qjk4MDVPenJVVXJTaXFQMTBXSEM2ZzNvN3V4dU9idjhIakV2OGlyNG9P?=
 =?utf-8?B?ZnJubVl6RzVFWFBGZjBENEZ3VmE4NDN4N1dlSUc3SFNUbEdHSEVEbnFobEhz?=
 =?utf-8?B?T0F3bnFTaWhyZjVCVHdsWFppbys4bDRzUHBsU0hpbEphWXRQdnhhNndtYmVY?=
 =?utf-8?B?ZHRxU1FlQWphaXRnd0djcTF2NDlxUjVaZnNnOEVZYzNxR21ERGhqekttcWY3?=
 =?utf-8?B?dk1rZ1E4WE92OURQQ3VPNEQxTm4zOHZ3UkpPWVR5WWw2dXhiR2c2R2lsci9a?=
 =?utf-8?B?WEVCVDVSZW5vRlpLdUdXWGh5b0RDU3RYcSttUUpSWjd0cU4rZGYveEY2eEhj?=
 =?utf-8?B?RTV5V0d5bTlYd3ljWFJ1WUtNVWJ6UkpyVXZHbncvZGFkQzJWRFJFMW9ZZWY0?=
 =?utf-8?B?aHlVaVhUejc2a3VJcGdVL0tiZlFGbGpiQlUweHdPL3VmME9IWE5rN0ROWVRx?=
 =?utf-8?B?eWVWcCtEWFVyS25NVTRQY3ZtQTNqbUR0ZVJSRnFSL082eTFwdWtySkY4MDcx?=
 =?utf-8?B?UWZDblZ2OXFXa0FmMVBncW5abGJWV0RzM2hmOVRtVlFTUDk3T2FaSlRWWXJT?=
 =?utf-8?B?YWJsamhISm1QdmtxWlVBNHREQTM2andMUE9rMUxCSVpmbFRkZGU3YlhoYnpB?=
 =?utf-8?B?U0lNMEgwc3BOVm5lU1lFTHk0K3pZY1VaQS9FQTI3OWtoVXg5RzRSNmZpNy9r?=
 =?utf-8?B?MzA1M0FNR0xBQTlyeHpjcVBNVVU1S1p3Wm9oRDFSdVhHVDJ6ZVBWRUFaVFdE?=
 =?utf-8?B?Y05JOWdKNU9qVUNVR2w1VnhQZ1RWYnRNT0FFTXlMMmx6SS83OXQyT05GZzk1?=
 =?utf-8?B?MStvL2hML0VIbWx1eXFSWkROVkVpVUhSVGZnMGJzY2VUUXlac0FWdFcyaVN1?=
 =?utf-8?B?K1VjUm5HUFd5TTFqcStPREU2STUzb1IyYUlsQjhNRGJqdUtUWkJsOEhqU2Fz?=
 =?utf-8?B?R1N4czBreHFvU2kwRkpkMStuMDNsczdsaWRhTWg2OHdRdDQ4elRRdS9KK2FL?=
 =?utf-8?B?WG9CK29NSmdqK0dCYk9vMVM1U2xiUENmbWRSR3VYWUhieWtuSjFHTDQvM28x?=
 =?utf-8?B?NVZ4cVZyWFIrNUY1bVFqcWxmNXlLNXRtM0lKUGp5T2w5VWhuZWZOeE1BVlVv?=
 =?utf-8?B?TWdrbktvV24rSHJ0L0tIR3FJSVV2V2RubDhGVnZidnpOV05wb25YNXlOdWxD?=
 =?utf-8?B?RFh4V2t1czFtQVZnODVUeDJMWHUvTmhDUnVXWC92bDFEcWVRMVBzb1dncnhU?=
 =?utf-8?B?S2lPRG5PZUJ5ZlJPT2RpNnQreU5tc0pMdmlqbnhZbVNMdUNlWUFEdzBhTFlJ?=
 =?utf-8?B?eWU2RE1WL3puSHVLSmpqVTdiUm9rYjRuZG1iU2RESitlYzQ3SmJrZDNTLzZl?=
 =?utf-8?B?MlJhZjl4M0ZER0tjZVZJYVlDNHA3dGhOcW5iRFVSd2tzMVVjYm1uS2l1UXQv?=
 =?utf-8?B?K2NJNGQ4NXhpQ3h0RWx0c29kaFFYWmhGUEMyZlV3bW52aDdJcmkydUpway9U?=
 =?utf-8?B?SDg2b3FhM3FJL3RLVGN3K2FybVAxZGh5eURPaEV0NnJrb0kwWHhFakRMQTBW?=
 =?utf-8?B?SDJBT212YlhBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KUZP153MB1444.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(10070799003)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UzBnLzFkTnNBUXBHdDlTUjhZU1QyUEord1RmcElFUEdEL2Q0Qmo4SFFDRUxK?=
 =?utf-8?B?S1BvZXNYMkFCb1BQUDJpY21lZTVKaGpsUWgrVnBCRHVlWENXaHduVnpNZHBK?=
 =?utf-8?B?b2tsQ2RQdWRSRVBBZk9vZkhsc2tTRFBWSDBxUlA4VFlHY3hlOTBsbWJiam9M?=
 =?utf-8?B?WkMrNnlKWk1ialBDdFlYN1BZVDE4SUwyMnFoWUpBUEJOUExNM2FVbFpFUTcz?=
 =?utf-8?B?MnRBTXdBNXdJM01TRXcwbkwrdTVMUEwxRGtObWFIYkp5SDVnMWpGUmtzcW9z?=
 =?utf-8?B?a2M0UFAycUxwZWErUjVRMWpsWFZDVk1oQldraXNLa3Vmc1FhekExYk1jVThn?=
 =?utf-8?B?eXFTWGVVNzN3NDNsN0hDVU8zSnBMcnhHRmNJZUYyRkMvZkhMZlQzRE44L25H?=
 =?utf-8?B?bHkvZnFUTkdGeUl4MmVsZzJHN1pHY1BBRDRRWkFnemNSTlZ1V3BrSkNOQlk4?=
 =?utf-8?B?WW1RYkFYNlJ2NTJXYzVWZXpkS1h6UFAvbHcxR2FoMCtMNEVmSnFyT2VuVG1O?=
 =?utf-8?B?bHNwcWhlUFVaSGFWRDJRYjBybGFpZ2FMMkVsREU1WVp4d1RDb20rMVNlcklQ?=
 =?utf-8?B?QXpyU0s1VVEraklUNVBIaiszRkMwUWI1TzJVeHdGRVFCcThUMXNiZndWM0NO?=
 =?utf-8?B?ZnpLa3F0a3RSQVdxam5icHBqVUpqMFlEU0xQUW1QZ05SMTVSZVlYQ1d2Wklj?=
 =?utf-8?B?OHZ0UW54R1N0b0tPVWE1SUt0OGlhRHIzZG9hUE9mRkI1dFArY2FxamowdVdL?=
 =?utf-8?B?MnhrUlV1SndyNG1GS0FZL3B3RUdyWjBpbXZiR1FhdGxyME56Mk4wbnJ6d1hW?=
 =?utf-8?B?TUZ6a013dnBYU1k0c3VCczBJNDRBdTBvWXFpYUxVR3lmY0NMWEFyeS96cEJj?=
 =?utf-8?B?Y2lqcDNDUGVVcTUwWWFMV2ZlWGsrWFFRUEtTczFwSzI2NHF2SnVBN0ZxclZ4?=
 =?utf-8?B?ODREYTdNRkpnZTFoSEpGZHovZ3p0NTNoVE11bHhrSFMwdTFTdmJFUGJyQVp2?=
 =?utf-8?B?enRoSDVIa0NENDhLdlV0bXdQU29uRThrZlFTbW1ISEpKNnQ0MUF2TWE2U3lE?=
 =?utf-8?B?emJjcjZVbHNrVWRFa0pBRyt1ZE9LK1hCdEs3aTd6VmNLMlRINjZTOVN3N1Vw?=
 =?utf-8?B?aTFOQ21rYWExRjVnbEhFempyY1BoZDZuYXNLREl4TUxyVXovUFVXdmlDNllI?=
 =?utf-8?B?WnM5QnNSejduVldZT21LS0t5NnF5anRPeXIyMDFKSW1oZXpSNEhXdVdnNVd0?=
 =?utf-8?B?V21ITS9BMXU4MzRjVHdBbWoxckxSUVdpdnMxaUdjRDZpWWI3MjRmYzdDRFls?=
 =?utf-8?B?ZktuWGhOVVNMTVhHSEFVZnJZWmRkaEV0cXJ0MHIrQTFZcDZyUXBxSmtqa3FU?=
 =?utf-8?B?bDV4UjNjYjN3VHBqLzc0TXVNYWgwcnU5KzdyK3FBNjk5SWdWL1hwY2Y4SnpK?=
 =?utf-8?B?R3RRUlhzNk53TmppWGZwVm1jeTJVVkpwUnVmWStPR1dpYWdvWkdhS0R6ekxk?=
 =?utf-8?B?NldHdzY5Z3QrN0VlNHF2U0FEMFRpSTdGZ2QwdHhMdUVZNG93NVBiTDFkNWFz?=
 =?utf-8?B?L0t6dFM2NzVYVWVSYmlkS1IwTE1aVVR6L3VVa3NtV1VBNWVKbDNWWWlDSVFC?=
 =?utf-8?B?Y3NId2FoL2JrbWU1ei9JZGtiVlJrSFpNSW5Jbi9sMFlkYm9yNlF1aHREaVRY?=
 =?utf-8?B?N1paYWJ3ZkFwckZsbEgwOUFBYUR3cG1ZenpXdnVDWXp3SlNGeWFva1lrVnc3?=
 =?utf-8?B?c2xETlY0TGdLU2UvQkVHcHVKT1FmaWp6Zlcxd1hZUWxLcFFaaEg4NG5nck5u?=
 =?utf-8?B?Q3VvOWNzNDZzdk1aeXRzdGl4Vm1xN1J0MXY4eGlQZDZNVlhnaHpXNWpNYzFL?=
 =?utf-8?B?VGg5ekpxUW85ZjQwN20xUGhUTThiZFlpdHMvSlVLZFlhUnMrMXhaR2tuNFBU?=
 =?utf-8?B?YTlOYlp3aStVeDRLd1FKcjJzZmNjY2NnMnROQUZZK0VYWk1hY1EyRHpJczRF?=
 =?utf-8?B?Y1ozdWQ0UWsxSDlZcGR6cGc3Z3lkQjBGQjFwcTVKcWxWN091bERHY1c5T3g2?=
 =?utf-8?B?RGs3alR2bEk3d25VV1RqcDJBNFlId0FGb1ltQjhJNVlTeSt1SWtpeFU3MFE2?=
 =?utf-8?Q?+aLurIVzBe2daLSniJPk4GNcp?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e2ebb54-d47f-40e9-2a2d-08dd8ddc800b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2025 03:00:33.6747
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 92K102a9jY0uFpxCM3B7We+wHhHsHTRMR742v4J/r4mqUim4T/6yZ7jYYk1X8QDK/sM84xbhabF9Gd9FkSulVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYP153MB1123

PiANCj4gT24gNS83LzIwMjUgNDoyMSBBTSwgTmFtYW4gSmFpbiB3cm90ZToNCj4gPg0KPiA+DQo+
IA0KPiBbLi4uXQ0KPiANCj4gPiA8c25pcD4NCj4gPg0KPiA+Pj4gK8KgwqDCoMKgwqDCoMKgIHJl
dHVybiAtRUlOVkFMOw0KPiA+Pj4gK8KgwqDCoCBpZiAoY29weV9mcm9tX3VzZXIocGF5bG9hZCwg
KHZvaWQgX191c2VyICopbWVzc2FnZS5wYXlsb2FkX3B0ciwNCj4gPj4+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIG1lc3NhZ2UucGF5bG9hZF9zaXplKSkNCj4gPj4+ICvCoMKgwqDCoMKg
wqDCoCByZXR1cm4gLUVGQVVMVDsNCj4gPj4+ICsNCj4gPj4+ICvCoMKgwqAgcmV0dXJuIGh2X3Bv
c3RfbWVzc2FnZSgodW5pb24NCj4gPj4NCj4gPj4gVGhpcyBmdW5jdGlvbiBkZWZpbml0aW9uIGlz
IGluIHNlcGFyYXRlIGZpbGUgd2hpY2ggY2FuIGJlIGJ1aWxkIGFzDQo+ID4+IGluZGVwZW5kZW50
IG1vZHVsZSwgdGhpcyB3aWxsIGNhdXNlIHByb2JsZW0gd2hpbGUgbGlua2luZyAuIFRyeQ0KPiA+
PiBidWlsZGluZyB3aXRoIENPTkZJR19IWVBFUlY9bSBhbmQgY2hlY2suDQo+ID4+DQo+ID4+IC0g
U2F1cmFiaA0KPiA+DQo+ID4gVGhhbmtzIGZvciByZXZpZXdpbmcgU2F1cmFiaC4gQXMgQ09ORklH
X0hZUEVSViBjYW4gYmUgc2V0IHRvICdtJw0KPiA+IGFuZCBDT05GSUdfTVNIVl9WVEwgZGVwZW5k
cyBvbiBpdCwgY2hhbmdpbmcgQ09ORklHX01TSFZfVlRMIHRvDQo+ID4gdHJpc3RhdGUgYW5kIGEg
ZmV3IHR3ZWFrcyBpbiBNYWtlZmlsZSB3aWxsIGZpeCB0aGlzIGlzc3VlLiBUaGlzIHdpbGwNCj4g
PiBlbnN1cmUgdGhhdCBtc2h2X3Z0bCBpcyBhbHNvIGJ1aWx0IGFzIGEgbW9kdWxlIHdoZW4gaHlw
ZXJ2IGlzIGJ1aWx0IGFzIGENCj4gbW9kdWxlLg0KPiA+DQo+ID4gSSdsbCB0YWtlIGNhcmUgb2Yg
dGhpcyBpbiBuZXh0IHZlcnNpb24uDQo+IA0KPiBMZXQgbWUgYXNrIGZvciBhIGNsYXJpZmljYXRp
b24uIEhvdyB3b3VsZCB0aGUgc3lzdGVtIGJvb3QgaWYgQ09ORklHX0hZUEVSVg0KPiBpcyBzZXQg
dG8gbT8gVGhlIGFyY2ggcGFydHMgYXJlIGdvaW5nIHRvIGJlIHN0aWxsIGNvbXBpbGVkLWluLCBj
b3JyZWN0Pw0KPiBPdGhlcndpc2UgSSBkb24ndCBzZWUgaG93IHRoYXQgd291bGQgaW5pdGlhbGl6
ZS4NCj4gDQo+IEkgYW0gdGhpbmtpbmcgd2hvIHdvdWxkIGxvYWQgSHlwZXItViBtb2R1bGVzIG9u
IHRoZSBzeXN0ZW0gdGhhdCByZXF1aXJlcw0KPiBIeXBlci1WIGhlcmUuIEl0IGlzIHVuZGVyc3Rh
bmRhYmxlIHRoYXQgZGlzdHJvJ3MgYnVpbGQgSHlwZXItViBhcyBhIG1vZHVsZS4NCj4gVGhhdCB3
YXksIHRoZXkgZG9uJ3QgaGF2ZSB0byBsb2FkIGFueXRoaW5nIHdoZW4gdGhlcmUgaXMgbm8gSHlw
ZXItVi4gSGVyZSwgaXQNCj4gaXMgSHlwZXItViBpbiBhbmQgb3V0LCB3aGF0IGRvIHdlIG5lZWQg
dG8gZml4Pw0KDQpXZSBuZWVkIHRvIGZpeCBjb21waWxhdGlvbiAtIGZvciBldmVyeW9uZS4NCg0K
LSBTYXVyYWJoDQoNCj4gDQo+ID4NCj4gPiBoZXJlIGlzIHRoZSBkaWZmIGZvciByZWZlcmVuY2U6
DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaHYvS2NvbmZpZyBiL2RyaXZlcnMvaHYvS2NvbmZp
ZyBpbmRleA0KPiA+IDU3ZGNmY2I2OWI4OC4uYzdmMjFiNDgzMzc3IDEwMDY0NA0KPiA+IC0tLSBh
L2RyaXZlcnMvaHYvS2NvbmZpZw0KPiA+ICsrKyBiL2RyaXZlcnMvaHYvS2NvbmZpZw0KPiA+IEBA
IC03Myw3ICs3Myw3IEBAIGNvbmZpZyBNU0hWX1JPT1QNCj4gPiAgwqDCoMKgwqDCoMKgwqDCoMKg
IElmIHVuc3VyZSwgc2F5IE4uDQo+ID4NCj4gPiAgwqBjb25maWcgTVNIVl9WVEwNCj4gPiAtwqDC
oMKgwqDCoMKgIGJvb2wgIk1pY3Jvc29mdCBIeXBlci1WIFZUTCBkcml2ZXIiDQo+ID4gK8KgwqDC
oMKgwqDCoCB0cmlzdGF0ZSAiTWljcm9zb2Z0IEh5cGVyLVYgVlRMIGRyaXZlciINCj4gPiAgwqDC
oMKgwqDCoMKgwqAgZGVwZW5kcyBvbiBIWVBFUlYgJiYgWDg2XzY0DQo+ID4gIMKgwqDCoMKgwqDC
oMKgIGRlcGVuZHMgb24gVFJBTlNQQVJFTlRfSFVHRVBBR0UNCj4gPiAgwqDCoMKgwqDCoMKgwqAg
ZGVwZW5kcyBvbiBPRg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2h2L01ha2VmaWxlIGIvZHJp
dmVycy9odi9NYWtlZmlsZSBpbmRleA0KPiA+IDVlNzg1ZGFlMDhjYy4uYzUzYTBkZjc0NmI3IDEw
MDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvaHYvTWFrZWZpbGUNCj4gPiArKysgYi9kcml2ZXJzL2h2
L01ha2VmaWxlDQo+ID4gQEAgLTE1LDkgKzE1LDExIEBAIGh2X3ZtYnVzLSQoQ09ORklHX0hZUEVS
Vl9URVNUSU5HKcKgwqDCoCArPQ0KPiA+IGh2X2RlYnVnZnMubw0KPiA+ICDCoGh2X3V0aWxzLXkg
Oj0gaHZfdXRpbC5vIGh2X2t2cC5vIGh2X3NuYXBzaG90Lm8gaHZfdXRpbHNfdHJhbnNwb3J0Lm8N
Cj4gPiAgwqBtc2h2X3Jvb3QteSA6PSBtc2h2X3Jvb3RfbWFpbi5vIG1zaHZfc3luaWMubyBtc2h2
X2V2ZW50ZmQubw0KPiA+IG1zaHZfaXJxLm8gXA0KPiA+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIG1zaHZfcm9vdF9odl9jYWxsLm8gbXNodl9wb3J0aWRfdGFibGUubw0KPiA+ICttc2h2
X3Z0bC15IDo9IG1zaHZfdnRsX21haW4ubw0KPiA+DQo+ID4gIMKgIyBDb2RlIHRoYXQgbXVzdCBi
ZSBidWlsdC1pbg0KPiA+ICDCoG9iai0kKHN1YnN0IG0seSwkKENPTkZJR19IWVBFUlYpKSArPSBo
dl9jb21tb24ubyAtb2JqLSQoc3Vic3QNCj4gPiBtLHksJChDT05GSUdfTVNIVl9ST09UKSkgKz0g
aHZfcHJvYy5vIG1zaHZfY29tbW9uLm8NCj4gPiAtDQo+ID4gLW1zaHZfdnRsLXkgOj0gbXNodl92
dGxfbWFpbi5vIG1zaHZfY29tbW9uLm8NCj4gPiArb2JqLSQoc3Vic3QgbSx5LCQoQ09ORklHX01T
SFZfUk9PVCkpICs9IGh2X3Byb2MubyBpZm5lcQ0KPiA+ICsoJChDT05GSUdfTVNIVl9ST09UKSAk
KENPTkZJR19NU0hWX1ZUTCksKQ0KPiA+ICvCoMKgwqAgb2JqLXkgKz0gbXNodl9jb21tb24ubw0K
PiA+ICtlbmRpZg0KPiA+DQo+ID4gUmVnYXJkcywNCj4gPiBOYW1hbg0KPiANCj4gLS0NCj4gVGhh
bmsgeW91LA0KPiBSb21hbg0KDQo=

