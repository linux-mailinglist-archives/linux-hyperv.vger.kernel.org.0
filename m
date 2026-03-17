Return-Path: <linux-hyperv+bounces-9512-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qBIzEhPOuWn5NwIAu9opvQ
	(envelope-from <linux-hyperv+bounces-9512-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Mar 2026 22:56:35 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E3F72B2E31
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Mar 2026 22:56:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 64DBD303BCE9
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Mar 2026 21:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1446F31B131;
	Tue, 17 Mar 2026 21:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Ja7pZvtx"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azolkn19010093.outbound.protection.outlook.com [52.103.10.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9462355F42;
	Tue, 17 Mar 2026 21:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.10.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773784573; cv=fail; b=X6vktIrjdNnJ1CuJ7kf+AF1YAJ+CQz0uPe9Wd0MjbMaNBmsI7RXjHZBQ7x1Cz03EcKM+loodgCMXMqvjJu5v+JD/KZ6rHrnGW+0IrCZxQI43YdouXb6GdUAx3ynDOSYx+TQGPeV/qW6ujJka53eN4d/VlafwZc5Pzc44tLn/rbY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773784573; c=relaxed/simple;
	bh=MdkqTXaxJPuppYopQkmtY0MXbRnPM19wJBUvkEfn/k0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tvJvXk9NZ0JWihvO7/as6y7vwJRA1/7kW5CIAaxaZXZvmYkUKOIxC+q+Cw5QtyGS/PWwII5KtNXNR6LEFPxenxUP2HM/aLX85fi46HPQqWnVvIkAB8qoxPM+u/Ib9rqGugZnOVNgjmAoQgu5aSh/cbfN9bZDmQPEcMPlf7gBsjY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Ja7pZvtx; arc=fail smtp.client-ip=52.103.10.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ice0WSr9zWp93wUTtr615RC9SFvjr69A6CYpJJBPkEFTIQa4CD6hilcaB4Kod9udcOukKICcJ/W4iOhu97b1r/y1/D4fd7JI7LE+UuzAMXzhQtRGpPfEuE9X1KNDfR5eAt3luM/UEfgrz5NHWXQ6jY1fHsRN7dBDtoMrwnC/CQoPpx7vvlBwpuL9KsRIFZaHUG1aPK2JnFR4PhgPpkoWN1tAax+UIjzmRLRpMAlo7xFZH4DtecMHaJOR1OcWzHplX/monppJ8HIk7ikA7kxjLGXnFvrIlC9LmTDDAAzLltAfRZcBaRoTjdF92yGDpc90AbDjUtgSpr2qm/wcFpgTuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MdkqTXaxJPuppYopQkmtY0MXbRnPM19wJBUvkEfn/k0=;
 b=TZ0CXi7u77WiE3kL+OnnRV3Ee/Dlw+13pHRfFmsvYeFQrUL0wLdcS/ej75woRIcAmX3hwaVtUWTibwCP0/KeiC/SqVZSc1b0rO7LL/1SmuSqS0Y5f88+opy7fDbY865+iiEuXYDgrXUkDb2MzfYS3m/eCtoXN9ct3FpMxFD0msynaeqGMd5U8RT6anI0T5powvi7opGLmTasHadq2fEC+rlDW/0VfHtBf/ukD0q+APCycRmzZZ9tEp6Rq09Fxqk2kgPRpPt18OGrDdKYUKwX9BuZrbsREyZkt0KHJxGX4wMrGEHpNjAB9WX/LK6Ibl6o7ViJSeHRivvGpOai2Y2HcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MdkqTXaxJPuppYopQkmtY0MXbRnPM19wJBUvkEfn/k0=;
 b=Ja7pZvtxPZUUaYyFouR5Akg1vKUm0/772Ts7lcMBtzuTNbtO4mrVgpjimfG3UobPHxJ2aH2uVgpUCLiXMn1G28BNJ7Ef/K0UzJX6Kh0uzfkiwzxd873m9/blcxvjIP/rPN8OySiCCuoMhcvQxYQf0NTzG4RzPds0NLIWiX6Sq1uoSSf+4K/JvoCJZZwYTm2lAGk6KzZn3BrZJb4551YhoNRYjiKyc03DIAdth2qrc8czgypRhu5bki8LmkCztt5z42HGwB80up+QtFTHY74KHoZnW2uzXL7dh0hVYqYTzq1MG7t+53PBPP2+vTzXRsxCoZpZyUS5wA0VWB7XS2jbXQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by MWHPR02MB10545.namprd02.prod.outlook.com (2603:10b6:303:286::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 17 Mar
 2026 21:56:07 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9700.024; Tue, 17 Mar 2026
 21:56:07 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	"kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "longli@microsoft.com"
	<longli@microsoft.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] mshv: Fix error handling in mshv_region_populate_pages
Thread-Topic: [PATCH] mshv: Fix error handling in mshv_region_populate_pages
Thread-Index: AQDgALApYlkUd2/WEALJAJdREysOHLesrt0A
Date: Tue, 17 Mar 2026 21:56:07 +0000
Message-ID:
 <SN6PR02MB4157D2316EC9E5B0BAE656C0D441A@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <177375989324.25621.6532741522672582851.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To:
 <177375989324.25621.6532741522672582851.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|MWHPR02MB10545:EE_
x-ms-office365-filtering-correlation-id: ba7601f9-c4ea-49be-3cf1-08de846ffe50
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|15080799012|41001999006|37011999003|31061999003|13031999003|19110799012|51005399006|13091999003|8062599012|8060799015|10035399007|440099028|3412199025|4302099013|102099032|1602099012|40105399003;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZDlyb1NTN0U2U1h5d1JmZ2NuUmY0Y3RBRXRMajZKL0puM3RUWU5nTnFGcHNT?=
 =?utf-8?B?RGxzNU9Xek1vMm9NVnY4S003dU9XRzF4Q1VYbjR0bGg4YUt6V2h1V2hTZytl?=
 =?utf-8?B?blBaR0ZFWWFHL3BtemVGaWtod1lIZExwNlhQcDdxTThnUkQxZUNhZHF1NkpP?=
 =?utf-8?B?WHlJY2pORk1RZVdXQzdtUWZmNkNNSElEWlhlajdNQ081dGJKOXZoNEZzVXZi?=
 =?utf-8?B?d2k1Mi90UjcvTkV0ZGU3d280RnFMQVJ0M2thREhrL0tGcFpxSE1nSzFROS85?=
 =?utf-8?B?VG1vMlg3VWpyT0Nycnc1Q0RWK1FpbmRjc2xybHlxcU1DQlRpcWcwdG13dGx3?=
 =?utf-8?B?d3hTU0xHUmtlMUE1aUZJMkoxckQzdzVpRlcxb1Nza3BSVnlGRnlDQlU2U0Nl?=
 =?utf-8?B?bUNFdkl5ek1Rb09ldDhaZHRZQUZhOHU1V2VoVjNRa1J0c3ZqUjBVV2kzOHhk?=
 =?utf-8?B?Y2xZTGd1dSt3dFhMZXJXcmxBcElNR1loTS81MkhGMlkwbjFBQzJ0dUwxaWFy?=
 =?utf-8?B?c2RzVzFqV1FIcGJOYlUrMVNDZ3dGbFgybEdYMlNVNVczYmlrVmUzTlNrOVhw?=
 =?utf-8?B?d08yaEFJcWxnNzFRdVdXS2FXbStta0dpWk11Q2x2d2VxVEFkTmROTTFGZkc1?=
 =?utf-8?B?UFNDMmx1QW02TXZqKzBMc3ZGTTJIZk1NZnlSd3IzZjRZZWZRYmR0ejhuVDJ1?=
 =?utf-8?B?dXQ0U2l5VHZiWklWN3UwbDFJWkY2ZkxDQ3RIa2xxMkhFU2V1eGtqa3JoSm5q?=
 =?utf-8?B?ZVArUzNDNVBzU2MvaGlFNDBJQjVlK1R4NGJreHpYNGZKQW9rK2t1eHZJZFRk?=
 =?utf-8?B?SlBtWUpOTXppK2poalhrUTN2NjdvbTZpNm95b09hclkvRUJEMlZKdUNkRzNI?=
 =?utf-8?B?dU5yOXg0eTBtK0hpVUtXVUdmQXliVks0eVQzTkFBbFNCSExHakJ4dWNLOTU1?=
 =?utf-8?B?Qy8vaDVXRm5oZ2llMUpnZGx6VjR2TXBUYlJsN0Exd1FtREM2TjJMMGNqYWtx?=
 =?utf-8?B?djJiWU9IQ1UrQld2d1BURERudHdFd2lkTVB4UjBQeGxoYjB5VDJyT3BtRGto?=
 =?utf-8?B?K2k0aVZXb3QyUFF4UnU5bVovSWo2cDU2bE15K2FNT1FJV3JpWVBRNEtha1RE?=
 =?utf-8?B?SkFVM3lqOXRLVUd2b01VQzgxcXZrNWlEQ2RYU212Z21CUTBVNzQyWnpTR1F6?=
 =?utf-8?B?eHZlcDlscW1qTWUxVzVFejE2Ylk0RHVzWnE5YjIvT08zM2ZucFVocVN3N0xu?=
 =?utf-8?B?djRYVGtrRnVGYVN4WEdGZjhtK3FQTmVnOE9PdHl6YkpYYkpzZ3BlcnluOHNr?=
 =?utf-8?B?bWdjTlVFQStORmtLc2ZlQStzaWg4MXN4bEk2c2xXMUpLMlhFZ20yYUR2aWRq?=
 =?utf-8?B?aHVwMFY1SFZCR05JVU5NQnpRNzk3ODkxMXJ2b0xiMWpyTkJMNnpZUDQ5R2xT?=
 =?utf-8?B?N0xNQmMzUGxnN0pZL09pMlpsQUhYN1hEZ0ZhQUJEKy9ncW0xZm5OcE9QbXdY?=
 =?utf-8?Q?SFQG/c=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YW1xemlwa2NVQ0JvMXkzNnlwc20wZm9hYmEyL1Q4NkwzMDhMbGRRdjRJU1JK?=
 =?utf-8?B?UkQ3dDRIS2kxbXNya0xvUkllSFgwL0hINXVzZUlnc0R5TFdBN2xadmdubktS?=
 =?utf-8?B?cG82bUI3UnErcmFsYVd3dXo4M0xqb2QzNks3aFZET1dZUFhEeXExWHhlamdO?=
 =?utf-8?B?Q0dyMTIvVTZTSi9TSUQxVzUwUEFoNmhOc2M4dEFack1jZzJ3dFFmOGUrVnJl?=
 =?utf-8?B?UlUyTGN0b3dxNk9qbGxNZktIWGs0NUJOTm1JYSsraGp1N0UveUdnNEZ1Z3Rk?=
 =?utf-8?B?VkprK2ZQb2tUaHJ4Q0YxWkZJVHZYNXRIRmpRdTduTnVueVcyQ1l0N2Iwazdi?=
 =?utf-8?B?UnNWalVTSWNjQ2NOdnJSQThZaDhxcHdGdFNyeHpCUmdUcms0ZEFZMnB0KzU4?=
 =?utf-8?B?VFpJeG5tVndMWkVybUJIUWI3YlRxTk5ZdlNLUGZVSnJpNVRwMDJhbnBzY1p3?=
 =?utf-8?B?MlJpUzlWVXJpT1JuOGRKcWpXZjdiOWVmcEFtbGdsRzdxRHVCMVJnWUhUQWk4?=
 =?utf-8?B?RTkvMzFiN0FvUDRYMVFJTG9mUUlWVDNhckJBOHJ3Z1RsUzFnaFhqamVjM1ZE?=
 =?utf-8?B?SzdsQ3B2L1hXOHBBcVBwcFdaTW51MXNFVG9zZ0J0L2x4a1BZeDZPL1lTUTRQ?=
 =?utf-8?B?MVJUcHl6V0NIVzBoTE95Qno3VjArcEJnR29aakt3MnM1WVlUTjJNWWhONW90?=
 =?utf-8?B?dWd1VlhMbnZmc2twbitLMnd3UFFFY0dVOXMrQWVGNTdUSFdJcGozb1lWYk1t?=
 =?utf-8?B?V2VreVRDeW83OU9rcXFFUko1MS9tYmVYYUVGN1F3cXBLcE9vZlR4Z0lBNEVa?=
 =?utf-8?B?NWVZcnVOcnBnWGdUZDNRS2dYaS84cC8vSzI1UitKN2hBblg4ZGIvNitXNC9P?=
 =?utf-8?B?aFkxSkx1SnlNd3hRSmF4UWFxazJ3bVEzazhvakJrUVcyMHEvMTdZU3QwWE1K?=
 =?utf-8?B?ZDBLVko3R0Ziblkyc1pnUjJMQmdhTnVhN3pyMnVrR0d5Z1pxc3pLMWtVbGZX?=
 =?utf-8?B?c3kvZmhrR3IvZ3QvNHQwcTQ5bmZYVlY3RXNmdjZ2L3NUV3JGQUJZaXdQUnI0?=
 =?utf-8?B?dUtGeitGZXpBMUh3NWJWVis5OU1CNnhwakNzY1NsSHAyZ2VCa1RVd2hGS1lG?=
 =?utf-8?B?M2pyL1N2ZFBtcGd3aWhWT3M0M3kxNlpCVGZHM0FXOGp5amg3TTFFNmNiclF1?=
 =?utf-8?B?T25WcUZEWkhTeGg1RXBpQ3o3cTRoK0xlT2VnaEczeFRaUnF5dThjMUdxU3hx?=
 =?utf-8?B?QkNFSHBqUk1SRGQ2TUxJcUl3bktzRm0zRys3VnBXSC8ycnV3OUp5eVFUcUtj?=
 =?utf-8?B?eS9Qc3E1VW91czJnYWw0MGRNU1RGSngwSWFpc0syTSs4MkJ3cUZ5UG9FUjhZ?=
 =?utf-8?B?TFJyNzlTUjF1cHdzVFFGdVk0VDlFYUxrM0xQV2JrcVk1MHRQNGwzbkFTb00y?=
 =?utf-8?B?aHlkY25NaEZzWjZTQmc5NDhZM09Jc0JMcXMrbUNXeTVRcXZaWmFFSWxZL2pr?=
 =?utf-8?B?NE5Dd0RjY285MGdzTWJSWmNQcXlBNS8xNlJnbk5sb0ZwMWpocUVlc1RkTEJ6?=
 =?utf-8?B?QXpVc0hsQTluajRlNEI5WHl3UjJYNWIzWUUxMWRBUnFrTEorZzU5Q1lwVjgx?=
 =?utf-8?B?bU9qMnp4NVR2VlNjME45cU12VUNLRkk4bm9nTk83c3JYeEdnWjZuVDBpTlNx?=
 =?utf-8?B?V01oRTNtOEU3ZGhka3NmSGdOLzVBdjJKbDJnTlJZVHQ2YzJ4MFNjRjU4UG9E?=
 =?utf-8?B?a1czZ3BiNjlWb3BRL1IwN3pDTkhNNk9ScGxQRUloMlh2bEFJc3VPL3NHaTN2?=
 =?utf-8?Q?SpkWyvohjKVfLhr6kW4CegqqzkfVvgwA0aaHg=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ba7601f9-c4ea-49be-3cf1-08de846ffe50
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2026 21:56:07.5892
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB10545
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
	TAGGED_FROM(0.00)[bounces-9512-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[outlook.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[outlook.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[8];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,outlook.com:dkim,outlook.com:email]
X-Rspamd-Queue-Id: 4E3F72B2E31
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

RnJvbTogU3RhbmlzbGF2IEtpbnNidXJza2lpIDxza2luc2J1cnNraWlAbGludXgubWljcm9zb2Z0
LmNvbT4gU2VudDogVHVlc2RheSwgTWFyY2ggMTcsIDIwMjYgODowNSBBTQ0KPiANCj4gVGhlIGN1
cnJlbnQgZXJyb3IgaGFuZGxpbmcgaGFzIHR3byBpc3N1ZXM6DQo+IA0KPiBGaXJzdCwgcGluX3Vz
ZXJfcGFnZXNfZmFzdCgpIGNhbiByZXR1cm4gYSBzaG9ydCBwaW4gY291bnQgKGxlc3MgdGhhbg0K
PiByZXF1ZXN0ZWQgYnV0IGdyZWF0ZXIgdGhhbiB6ZXJvKSB3aGVuIGl0IGNhbm5vdCBwaW4gYWxs
IHJlcXVlc3RlZCBwYWdlcy4NCj4gVGhpcyBpcyB0cmVhdGVkIGFzIHN1Y2Nlc3MsIGxlYWRpbmcg
dG8gcGFydGlhbGx5IHBpbm5lZCByZWdpb25zIGJlaW5nDQo+IHVzZWQsIHdoaWNoIGNhdXNlcyBt
ZW1vcnkgY29ycnVwdGlvbi4NCj4gDQo+IFNlY29uZCwgd2hlbiBhbiBlcnJvciBvY2N1cnMgbWlk
LWxvb3AsIGFscmVhZHkgcGlubmVkIHBhZ2VzIGZyb20gdGhlDQo+IGN1cnJlbnQgYmF0Y2ggYXJl
IG5vdCByZWxlYXNlZCBiZWZvcmUgY2FsbGluZyBtc2h2X3JlZ2lvbl9ldmljdF9wYWdlcygpLA0K
PiBjYXVzaW5nIGEgcGFnZSByZWZlcmVuY2UgbGVhay4NCg0KVGhlcmUncyBub3cgYW4gb25saW5l
IExMTS1iYXNlZCB0b29sIHRoYXQgaXMgYXV0b21hdGljYWxseSByZXZpZXdpbmcNCmtlcm5lbCBw
YXRjaGVzLiAgRm9yIHRoaXMgcGF0Y2gsIHRoZSByZXN1bHRzIGFyZSBoZXJlOg0KDQpodHRwczov
L3Nhc2hpa28uZGV2LyMvcGF0Y2hzZXQvMTc3Mzc1OTg5MzI0LjI1NjIxLjY1MzI3NDE1MjI2NzI1
ODI4NTEuc3RnaXQlNDBza2luc2J1cnNraWktY2xvdWQtZGVza3RvcC5pbnRlcm5hbC5jbG91ZGFw
cC5uZXQNCg0KSXQgaGFzIGZsYWdnZWQgdGhlIGNvbW1pdCBtZXNzYWdlIGFzIGluY29ycmVjdGx5
IHJlZmVyZW5jaW5nIHRoZQ0KZnVuY3Rpb24gbXNodl9yZWdpb25fZXZpY3RfcGFnZXMoKSwgd2hp
Y2ggZG9lc24ndCBleGlzdC4NCg0KRldJVywgdGhlIGFubm91bmNlbWVudCBhYm91dCBzYXNoaWtv
LmRldiBpcyBoZXJlOg0KDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzdpYTRvNmttcGo1
cy5mc2ZAY2FzdGxlLmMuZ29vZ2xlcnMuY29tLw0KDQpPdGhlciB0aGFuIHRoZSBjb21taXQgbWVz
c2FnZSByZWZlcmVuY2UsIHRoaXMgbG9va3MgZ29vZCB0byBtZS4NCg0KUmV2aWV3ZWQtYnk6IE1p
Y2hhZWwgS2VsbGV5IDxtaGtsaW51eEBvdXRsb29rLmNvbT4NCg0KPiANCj4gRml4IGJ5IHRyZWF0
aW5nIHNob3J0IHBpbnMgYXMgZXJyb3JzIGFuZCBleHBsaWNpdGx5IHVucGlubmluZyB0aGUNCj4g
cGFydGlhbCBiYXRjaCBiZWZvcmUgY2xlYW51cC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFN0YW5p
c2xhdiBLaW5zYnVyc2tpaSA8c2tpbnNidXJza2lpQGxpbnV4Lm1pY3Jvc29mdC5jb20+DQo+IC0t
LQ0KPiAgZHJpdmVycy9odi9tc2h2X3JlZ2lvbnMuYyB8ICAgIDYgKysrKy0tDQo+ICAxIGZpbGUg
Y2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvaHYvbXNodl9yZWdpb25zLmMgYi9kcml2ZXJzL2h2L21zaHZfcmVnaW9ucy5j
DQo+IGluZGV4IGMyOGFhYzA3MjZkZS4uZmRmZmQ0ZjAwMmY2IDEwMDY0NA0KPiAtLS0gYS9kcml2
ZXJzL2h2L21zaHZfcmVnaW9ucy5jDQo+ICsrKyBiL2RyaXZlcnMvaHYvbXNodl9yZWdpb25zLmMN
Cj4gQEAgLTMxNCwxNSArMzE0LDE3IEBAIGludCBtc2h2X3JlZ2lvbl9waW4oc3RydWN0IG1zaHZf
bWVtX3JlZ2lvbiAqcmVnaW9uKQ0KPiAgCQlyZXQgPSBwaW5fdXNlcl9wYWdlc19mYXN0KHVzZXJz
cGFjZV9hZGRyLCBucl9wYWdlcywNCj4gIAkJCQkJICBGT0xMX1dSSVRFIHwgRk9MTF9MT05HVEVS
TSwNCj4gIAkJCQkJICBwYWdlcyk7DQo+IC0JCWlmIChyZXQgPCAwKQ0KPiArCQlpZiAocmV0ICE9
IG5yX3BhZ2VzKQ0KPiAgCQkJZ290byByZWxlYXNlX3BhZ2VzOw0KPiAgCX0NCj4gDQo+ICAJcmV0
dXJuIDA7DQo+IA0KPiAgcmVsZWFzZV9wYWdlczoNCj4gKwlpZiAocmV0ID4gMCkNCj4gKwkJZG9u
ZV9jb3VudCArPSByZXQ7DQo+ICAJbXNodl9yZWdpb25faW52YWxpZGF0ZV9wYWdlcyhyZWdpb24s
IDAsIGRvbmVfY291bnQpOw0KPiAtCXJldHVybiByZXQ7DQo+ICsJcmV0dXJuIHJldCA8IDAgPyBy
ZXQgOiAtRU5PTUVNOw0KPiAgfQ0KPiANCj4gIHN0YXRpYyBpbnQgbXNodl9yZWdpb25fY2h1bmtf
dW5tYXAoc3RydWN0IG1zaHZfbWVtX3JlZ2lvbiAqcmVnaW9uLA0KPiANCj4gDQoNCg==

