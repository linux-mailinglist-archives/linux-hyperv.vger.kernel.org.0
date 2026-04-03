Return-Path: <linux-hyperv+bounces-9944-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wAFOO/4sz2k3tgYAu9opvQ
	(envelope-from <linux-hyperv+bounces-9944-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 03 Apr 2026 04:59:10 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FDC9390864
	for <lists+linux-hyperv@lfdr.de>; Fri, 03 Apr 2026 04:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 996A23033254
	for <lists+linux-hyperv@lfdr.de>; Fri,  3 Apr 2026 02:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FCAB3491C9;
	Fri,  3 Apr 2026 02:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="rbRuSGLk"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azolkn19010005.outbound.protection.outlook.com [52.103.12.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88643502A5;
	Fri,  3 Apr 2026 02:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.12.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775185038; cv=fail; b=jagzDvK561VYtp61sd1tlIYa9TNOKW/kKxDcljKO9nk8Zm7Doe2HOcbz2sZ0iKofP8buWYC8uZDAjRxm486MrOw105nKDSGphzIL0Nv0IqgMcxHEeaClBt1TBGklN8f3KFJ++WaHD2MvMwpBM5fQV2pvp0fgs1JQ6+lrpCjHPgA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775185038; c=relaxed/simple;
	bh=8gxIkBYjw6zw+Jl9p6nIlWSyQ3+uFIgHfubaLIEow3M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KXyG/uJDiqVGd4gJhaXxdt5zE9rbCm6ZVEeeJRqxEhqSBrRmj76bltv8nfSAQI3SYMY8pXg5BNAfCW2bZPJeb6NKP0FQ/fufIqI1k1+ThsIcZ2MOjKbDt5euIYjWzIqeXkeLIGkO593AiP+nmqL8kz1EfYJYSs8HYI48XI4O3Yw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=rbRuSGLk; arc=fail smtp.client-ip=52.103.12.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OPjLfnzJd2L36ZV719rWpGXt1rEBAGtK/4UeDt9nWwrnUfh7Z9+H0RuSUgNDgBNm8gN9Zxvzq8VSljAyRT0lKYLEAL5aaxo/RLKzYEGZZtX5HJwSWw+4wojSycdTE6W4ATKE0D8n3kSv0RPsXoolbIUKjPSjMLfbQLMIoQcRSHCZd4xGn3Cp6jta3qhMMsFOpLe5tMjeHkGx+HpUkC6L7uyTRxMbR2F/scpT1F21KygL1rJhhgReXFZVp/Ocx6iREGdjrc2cApYtuBPnNb0fm+EK1VJWCiqGAeP76UpUXxUt9BIMGi3gaUvggzKnc7UAp/iSijcLLnD7r83lzhDc4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8gxIkBYjw6zw+Jl9p6nIlWSyQ3+uFIgHfubaLIEow3M=;
 b=dfLMm8QO7wARegGG/bAPA904VMl1AsK1e9Rd31yoZdRzwcsVTPs8WLBGp2r07X+2FtSXtmbVGuTRI5Zutm1kjpK2W5xcB0sFAZtwc+/NYYwD9EcB7zy6cE7iLJucBHIwFlhIWTpb3J/qXbGLrJGCOZUc25NueFgA6rkXlItUW2H1A4WvwMgQf2770VplKHkUCDdXRptf5+ac3KcHRfx8sO9gB3mB3xcHrNyLS1FwzxLbuNXt5N4sikFM2z9a71J7Y6LJ42U7xKG94xwUDoxVh33DnlFtrWChpSENNLqbKs3PyxFa2dnDoj05gcRLnSKDDgYaAxZSqs2hZlV7JakXsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8gxIkBYjw6zw+Jl9p6nIlWSyQ3+uFIgHfubaLIEow3M=;
 b=rbRuSGLkKbofI9+8MUbNGeQv/fixH/ZPRpNj4ZYFxV4HywJsdOJNW5LBJY/bvrEmP98INXtFBkkL5SX8BhNFmRAxdr4mx/QB2/wImgZPVXYINw34PMpAmBjua/Sw+5UVa1jrZ3ZBAVoUUWTVNoqqR/gYxzLpeosR8uGbBX0AojdVpIm/6vAsNeKpipPIXYvWV9HnZZuYV+ipSn39xgEZaQsVJrpBIvDyKa/S/LZyVgsJMmYEO6/99i+tnT2c+P/Mp7Vn1A/CEVHsn7jREw3sddafHSWnYco5cJ20oYKYadThq0qe2e8TagRaNP7Qy2a30OsCnqlNGblyF8XX0MXQ5w==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CH3PR02MB9906.namprd02.prod.outlook.com (2603:10b6:610:167::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Fri, 3 Apr
 2026 02:57:14 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9769.014; Fri, 3 Apr 2026
 02:57:14 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: =?utf-8?B?VGhvbWFzIFdlacOfc2NodWg=?= <linux@weissschuh.net>, "K. Y.
 Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei
 Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Long Li
	<longli@microsoft.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/4] drivers: hv: use ATTRIBUTE_GROUPS helper
Thread-Topic: [PATCH 2/4] drivers: hv: use ATTRIBUTE_GROUPS helper
Thread-Index: AQIA5n8utbFNLZq9HsGD5u2/wbCFbAJlxfhBtXEvnyA=
Date: Fri, 3 Apr 2026 02:57:13 +0000
Message-ID:
 <SN6PR02MB4157E082320168FE597C9652D45EA@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260402-sysfs-const-hv-v1-0-a467d6f7726e@weissschuh.net>
 <20260402-sysfs-const-hv-v1-2-a467d6f7726e@weissschuh.net>
In-Reply-To: <20260402-sysfs-const-hv-v1-2-a467d6f7726e@weissschuh.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CH3PR02MB9906:EE_
x-ms-office365-filtering-correlation-id: 8bd9cb1c-dfec-4393-5e94-08de912cb556
x-microsoft-antispam:
 BCL:0;ARA:14566002|51005399006|37011999003|19110799012|8062599012|15080799012|8060799015|461199028|31061999003|13091999003|3412199025|440099028|26121999003|102099032|13041999003|40105399003;
x-microsoft-antispam-message-info:
 =?utf-8?B?OWFiZGErSWZIckp6eWtuUmFDaU5EU1lsTHplNmVqVVF0dE5QdHN1M3RpSjZG?=
 =?utf-8?B?eGMvWXpFSXNOTTZ2R25RdEs3TVYxM24yeXZmOW5FblFHSWxrNXA4VFJrK3ZC?=
 =?utf-8?B?ZzFWdmJBT0VvczB3dVlZVEdVMnIzUmlEcWpyZjF0N1padGh3OFBhNjNMZ3Z5?=
 =?utf-8?B?cnNnZ0c3akRDaVFYYXBSQzZCQU40Mm9iNGxDaDA3UE1oSXdOY2hqaVcrU3VG?=
 =?utf-8?B?ejZpTmxtckxxOXpTeDU5SS9LZmQxaGdCblBneHVQS1p0RXdCbFhqWTVZc2Nt?=
 =?utf-8?B?cVhBUU13d2R1MzY4dGozM0hlUVZsVHNTRWtyakZwWFdFdFhpQ25WLy9KS3Fo?=
 =?utf-8?B?bXNyMVRGeEUrSU01NFozZHVRcXVmZytleEEweXhQUnVYREdLeUtWT2Z4anQv?=
 =?utf-8?B?cXlwejU4UDlOakNEV1VsK25pVUxhZUdIczRqTG0zRlhXZGllQW1MVE1mbndm?=
 =?utf-8?B?Ulk5VWp1YmNIanh3K0NKVHpSdDdFcjdqSHBOa0pxYlBCajBUUGxDdE1JcVFG?=
 =?utf-8?B?N1p6Q3h4dmFUQ05rK2Z1TGw4Nk5JWUZsRDJTSUxjbVdSclIwcmFTbFlRQUdr?=
 =?utf-8?B?cThPTHpUVnFtRk5jOHdxNFV6Z1RiVGxFb3dDVmd3eEVrZG50QW80WkJ5RXQw?=
 =?utf-8?B?cUlnaVEvVTVPQmJBQUdDYk1xeGZIYTZvS1dnNXhac29GaFBVeEEweHZpUU5r?=
 =?utf-8?B?WHNKajZlS01aNmJOejVVd1F4Zk5pVDhvOGNrZFJ3WDZPNkEyL21oSlF1alJx?=
 =?utf-8?B?dDBQdVV0UFRqY1dmRSt6Ti85Y2JMclVDVlVCOGNnZ2dWYVBXK2JaYWJBS3hU?=
 =?utf-8?B?WS9EeXZHRUxMVmRNZS9SNjJraWdKeXhaMWs2bnNYNUJmeFN3b2JMZW5RRENP?=
 =?utf-8?B?L3VJQVN1Zy82KzlJQkM3RHFHMUtvbWN2SHduZEpRSGxva3NtMVRURm5LbU9X?=
 =?utf-8?B?TjA2MFJOOE5JOEw4Y1ZpdVo5b3RTSWN1YmZkaDVWNitlYllRSFU2QVFEM0Z6?=
 =?utf-8?B?ejlURnNIM3RWd2FNQUlDUnZpZXJlNDJ6Z0libUh2NWlML20xWTVLSHl3cEhu?=
 =?utf-8?B?NXIwMGhtNWhJRWNHQWtyRjVTSmkvMi8xQnI3VXMzRFJrZHVFMk9IajRJYW5E?=
 =?utf-8?B?aW1wb0lNSjZSNVFZYTVPK1U3Snc4K3R1VWVwQktrcUdsK3BUU3lCOWwzN2R4?=
 =?utf-8?B?ZEswV2JKTG1UU1E2ZE5aeS9ZVzhmcVZsb080ZkF0YXlBc1RRUktwcURSd2lj?=
 =?utf-8?B?eEZySUoxdWF3ckU4YUswZmd1RU1icW81TjhwbnM5d2VPVkVhNHQrL3FIVDh0?=
 =?utf-8?B?cVdUTXZ1aDJ5Qmd3WjZ1eHdnK1dIL1poUkpVaC8wTTJWc0JkV1IzRFZ5R1VI?=
 =?utf-8?Q?+86hzRF1i2PhxiajpNnpKIdVtwOSYoUg=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bVFEeE1SaUxqekYxb2FhUWJKWXowNWFTTVZHTW54Q3gyM2JXRTBpRWh3djVR?=
 =?utf-8?B?M3k4ZUhlTE1tVVN4aUQwZ1kwd3pUMkoyOEpFdndLZ1JOY0xCUGZRc21zZGNx?=
 =?utf-8?B?NGFIZHMvcnZkSkhTVU0wMDdnSlArUHkrYjQwdGVaNDNoSURITS9pZ0F6Nld0?=
 =?utf-8?B?dGhYdzhCWUhFTDBZRUtHVHlmN2p4K0txVlcvbWI3YVNpUVkxZHd4VlR5azJ3?=
 =?utf-8?B?MUNJMGZyRGM1SWZ5bnprVVhVYkVDL3NlSFN1UEw2WUxqNUdoVjh4aFFZYkdz?=
 =?utf-8?B?ZW1kZWdQM0hublZodGlYWnZXSVk2amFYSGdRa3VaaEtQY2M2dlYvM1h3VnF5?=
 =?utf-8?B?dVYvY3hmTU55T2FPLzNqcDFSYUY3QkpGSnFqMnhtczg5OW9QQUNjaUhjK2x4?=
 =?utf-8?B?TnROOXdzRm5EaU9tdmxtWHcrdmE1M3BaekEvTFZ4YzQwOXdqNExEUEpyYTY0?=
 =?utf-8?B?NExJaERJcUo5M0gwS3daSHhNa2lLd25VQis5eEpuS0c2Ymp4dUVGdllMbldO?=
 =?utf-8?B?YVgzQnZ0a3NWaG1kNDBGUExJbGVMRVZ4NkYvS3lyQzdiK1diU3IrTy9tbjhV?=
 =?utf-8?B?dytMRjE5aDJpTGhnY3dGSmllY0RMTFh3N0c4S0o3MEVFMlVZeVQ5NXJXK0pW?=
 =?utf-8?B?RjF1UXphbnlmUWx2Y21kOHJhOHVuK1UxWVNzOGlMVEY3SDZ3MVgrTjh4c1dv?=
 =?utf-8?B?UHBwaTFXdFRnUWVuTzYxU2t6UWU4Ny83UThXUklhTnhaeE1aZjNMRXplR3lH?=
 =?utf-8?B?WDAxYUZpYys5d2ZPbjI5NiswQU1URXZmT0xZOTA5aXR0ZHRWTXgyK1RrWS9U?=
 =?utf-8?B?WWtXNlhVNXc0VEJHVGlnTWVUQUJmVitSRUV1VHpDejNqczJtSklWdGxacDAz?=
 =?utf-8?B?akVteEhsdWd5ZDdtUjdUNlkwOVFsMFN6Y3o3TExCaW91L09rSVYrNVRLL1E1?=
 =?utf-8?B?RGxjQXovYWppaGJUQjlkSGlOdlJ4ckJYQXRQQnR3aTlzZXpxc1NsRFQ1eVIv?=
 =?utf-8?B?RTg3a2NjL0pqSGJHWG1paUhISytsN21IK2JBUHNEbUEvaG9saGIrL1NxV3N1?=
 =?utf-8?B?MzFmOUNaUmN3N3FQcGIrNW5USzlvUVBieTl4THRXVEJGL3BXUkdrYmQ2SjAx?=
 =?utf-8?B?WFd0V2hpVytLVjd5R2I0R2wwbFFQK25nR2NzRVY0NU5MUUcwLzN6bi9sdFo4?=
 =?utf-8?B?aXJJUDRZd3d1Ky9WcVFFbWgwU2d2d1hZZTRaZGt2cVhKMHJIdDlxYWR1YzVP?=
 =?utf-8?B?dVNnclEyaksyVU9rV3FXOFJMdzBvYnVTYnpHUk55anFVdERqdmk3dDkwR1Fo?=
 =?utf-8?B?ZkhzYVZ0R3dhc3VDcUZRNVZocWhKS29qOEczK05Od2JZbGxzczdBVWRSRm9R?=
 =?utf-8?B?cndxSnBLYWFzZ1NOQ1JhbEY1REVhZUlpUkFIa2p5MzlWTzhrYzF1cVk1bzhV?=
 =?utf-8?B?Y0JGN0l1UFpCMFdWZklQWW90eUhHMHdUSHZKcVRJZXc5cEpGSW5RdDZlWnNw?=
 =?utf-8?B?M0RFLzBNMlRYVlVJZFp2bEUvWVZBeHExVGhleCtMck9neG12UU9SMW9sMjVD?=
 =?utf-8?B?a3dZRHlWT1ZDLzROYkhlZmpTbURDSWZNU05RZER1Z1JqdHF6M1EyVDBlSncr?=
 =?utf-8?B?ZUROVWZvbmR3cjE2cWw3cUt4NVRZMkVZNnVmWk9XbTVjT3RmQVcrQ1dnZHJI?=
 =?utf-8?B?L1NJY3doeWtPNVdzd0x0aDFSd0I2RElyV0crdjNHWkpXWkgyaWI2eWtwWDl6?=
 =?utf-8?B?UWlJdTRqdU5SLzVWWHRraHlmNyt3bWxkR2hDSmlGcVJYd3dsTUFmTHAvNmp3?=
 =?utf-8?Q?pP7MoyVDhTbOqy5rlEWtQFAP9IhkQLaBKwktM=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bd9cb1c-dfec-4393-5e94-08de912cb556
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2026 02:57:13.9837
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB9906
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-9944-lists,linux-hyperv=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[weissschuh.net:email,SN6PR02MB4157.namprd02.prod.outlook.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,outlook.com:dkim,outlook.com:email]
X-Rspamd-Queue-Id: 5FDC9390864
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

RnJvbTogVGhvbWFzIFdlacOfc2NodWggPGxpbnV4QHdlaXNzc2NodWgubmV0PiBTZW50OiBUaHVy
c2RheSwgQXByaWwgMiwgMjAyNiA4OjE4IEFNDQo+IA0KPiBUaGUgY3VycmVudCBsb2dpYyBpcyBl
cXVpdmFsZW50IHRvIHRoZSBoZWxwZXIuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBUaG9tYXMgV2Vp
w59zY2h1aCA8bGludXhAd2Vpc3NzY2h1aC5uZXQ+DQo+IC0tLQ0KPiAgZHJpdmVycy9odi92bWJ1
c19kcnYuYyB8IDUgKy0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgNCBk
ZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2h2L3ZtYnVzX2Rydi5jIGIv
ZHJpdmVycy9odi92bWJ1c19kcnYuYw0KPiBpbmRleCA1ZjliN2NjOTA4MGMuLmQ0MWIzOWFiNjI4
ZCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9odi92bWJ1c19kcnYuYw0KPiArKysgYi9kcml2ZXJz
L2h2L3ZtYnVzX2Rydi5jDQo+IEBAIC02NDUsMTAgKzY0NSw3IEBAIHN0YXRpYyBzdHJ1Y3QgYXR0
cmlidXRlICp2bWJ1c19idXNfYXR0cnNbXSA9IHsNCj4gIAkmYnVzX2F0dHJfaGliZXJuYXRpb24u
YXR0ciwNCj4gIAlOVUxMLA0KPiAgfTsNCj4gLXN0YXRpYyBjb25zdCBzdHJ1Y3QgYXR0cmlidXRl
X2dyb3VwIHZtYnVzX2J1c19ncm91cCA9IHsNCj4gLQkuYXR0cnMgPSB2bWJ1c19idXNfYXR0cnMs
DQo+IC19Ow0KPiAtX19BVFRSSUJVVEVfR1JPVVBTKHZtYnVzX2J1cyk7DQo+ICtBVFRSSUJVVEVf
R1JPVVBTKHZtYnVzX2J1cyk7DQo+IA0KPiAgLyoNCj4gICAqIHZtYnVzX3VldmVudCAtIGFkZCB1
ZXZlbnQgZm9yIG91ciBkZXZpY2UNCj4gDQo+IC0tDQo+IDIuNTMuMA0KPiANCg0KUmV2aWV3ZWQt
Ynk6IE1pY2hhZWwgS2VsbGV5IDxtaGtsaW51eEBvdXRsb29rLmNvbT4NCg0K

