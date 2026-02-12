Return-Path: <linux-hyperv+bounces-8794-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OL4nGSYAjmm0+AAAu9opvQ
	(envelope-from <linux-hyperv+bounces-8794-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Feb 2026 17:30:30 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A4812F718
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Feb 2026 17:30:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9C3863012862
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Feb 2026 16:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4164035D60F;
	Thu, 12 Feb 2026 16:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="JjAMwi0c"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazolkn19013066.outbound.protection.outlook.com [52.103.20.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE2834F462;
	Thu, 12 Feb 2026 16:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.20.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770913823; cv=fail; b=Ughnmc7qOsiOh8aBk+67kmebN0kQqdE2gkP0anqKfgODGT4fQTXR/1kXOg3y32lc0pD8otjz7UIRJCjuapOL+m8Ez1WbKObcBjwm37GkGmoP1O8sd8HKOwHGkElGb1oEer9fNGhMAtDLtXFu+fw77llg3Lq+RWXf978QsZKW6ME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770913823; c=relaxed/simple;
	bh=0Vy2AfwLHZ9yEPUVKl27TbKmqpGjdKy2oMcdQQzPBz8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LUZ+7gSnuGgy4kCbF7sCF6xAUw/Ey0hPKqsJVrPDae0AwsGyUgL0qtRww4CggygJMEKO5yHrlX47uxvJ8dk/sCzC0f8/sP5iVg9eUn6eWlZ2F/cAE6/ecLVC1aM9ilMRZODMtPiUiPUIbjjhwEGCAN8+qApOLiXXlS7mJ1CFCQ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=JjAMwi0c; arc=fail smtp.client-ip=52.103.20.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ReyMJ+w9QYPhjwfsic7/CsCvZO+jM/wm8ybO1bttJxONa3cukLnflbbpYO/cAu5vAvJgHwY/MSDz1l4lTO9nqp+BtOCt3+xeT1f4d2DPv5rsMZnSrma8+ncqxaAlxCyBnfAoIm2oNVLVl395nxrmTwAMgCa3ZW7emBpK8swEEkVvNUAEKSgI7WcKNvWX2TLurZcSApAGlNLEdiTWOkScRNMWtNSGlQoxDifnuRg5XazY7EfXmzuvB4EMAT9TM7eke9E8BCaXGAeo4iabgOE14pYebe3SYZWuF9J+F0DJ2hnR7iuJ/5fWvIxgYXIl1DxdoRR680oS6geaQ0fBnQ/WRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Vy2AfwLHZ9yEPUVKl27TbKmqpGjdKy2oMcdQQzPBz8=;
 b=K1pvRgJkI4j0Wy9ueAMmVCku7G34hhH1J5FTd/R6Yto3k2nfaKBpJ+j60s9GzQozZ+0L7eYyVdEGhO0H+/EfyneYvuJny9qDWtSUj1bgM+PUz5wsN3aBm5fEgmK3EGH39x/brPUWhul4N5x0YUeKEu9fzWffBwz0SBVAlV3zl/PdVI8judsK3KxQlZjB+OQeQelnbzTIqTlLgfgW3wCsSek6FBUmJ9cQTfWdgCN5tALfV1txnqtu6Eb1+wetBgVdGBlMpIbbv4/rb/naqdlsazhA2mhxFYiIWkSJQaF2Cfg75AIfyc+2F1EfRNKoBdI8/HtcI/pIV4FbXxXAyPeGoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Vy2AfwLHZ9yEPUVKl27TbKmqpGjdKy2oMcdQQzPBz8=;
 b=JjAMwi0c7pknLbGapdU5evCLRtHdfa4VA1d6/7gq6idQlQNrk6OWrfabmyHcFDmY5dgPyElrYT6Bytd2NCNZUR4Wsk9N9yQkANBgyDUB6vcHqI74Ft1m3otRQj9PaTkyXxi4VX5/gBKOayHRrQcBFEogi78rxNQrUscZl1vUXw9mLQ2eK8qfvFGuTZI11u46cgU6AnxGL5l0968Y74ZgxW3KwUWlXI2Dy88r3bo4WpKs8ZKAEhY3rWNDYe3rU6meXiKT/fDE7eszjoWpA7fTRbMYO4XMjnRk5mn99LACTQP2FixS+GNdR39V8hvYazwAYOULZgoBhcCXA9iwCSPIxg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by BN0PR02MB8061.namprd02.prod.outlook.com (2603:10b6:408:16e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Thu, 12 Feb
 2026 16:30:17 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9611.008; Thu, 12 Feb 2026
 16:30:16 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Jocelyn Falempe <jfalempe@redhat.com>, "drawat.floss@gmail.com"
	<drawat.floss@gmail.com>, "maarten.lankhorst@linux.intel.com"
	<maarten.lankhorst@linux.intel.com>, "mripard@kernel.org"
	<mripard@kernel.org>, "tzimmermann@suse.de" <tzimmermann@suse.de>,
	"airlied@gmail.com" <airlied@gmail.com>, "simona@ffwll.ch" <simona@ffwll.ch>,
	"kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "longli@microsoft.com"
	<longli@microsoft.com>, "ryasuoka@redhat.com" <ryasuoka@redhat.com>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH 2/2] drm/hyperv: During panic do VMBus unload after frame
 buffer is flushed
Thread-Topic: [PATCH 2/2] drm/hyperv: During panic do VMBus unload after frame
 buffer is flushed
Thread-Index: AQHcmZIv/g41NkTRdUyLV+0r+HCaO7V+DsSAgAAStoCAALVCAIAABaAAgABqLEA=
Date: Thu, 12 Feb 2026 16:30:16 +0000
Message-ID:
 <SN6PR02MB415778D138C500A3C15EE730D460A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260209070201.1492-1-mhklinux@outlook.com>
 <20260209070201.1492-2-mhklinux@outlook.com>
 <a5372b72-8dc0-4f2d-ad5c-086f3e75ee81@redhat.com>
 <002601dc9baa$517d8b40$f478a1c0$@zohomail.com>
 <e9d35c78-1c4b-4a9c-8cf0-9531e972279f@redhat.com>
 <7c6933fc-663d-4bf6-8594-c14c4be83c98@redhat.com>
In-Reply-To: <7c6933fc-663d-4bf6-8594-c14c4be83c98@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|BN0PR02MB8061:EE_
x-ms-office365-filtering-correlation-id: 59693bb3-c50f-4fed-7314-08de6a54018d
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799015|13091999003|12121999013|15080799012|19110799012|8062599012|31061999003|461199028|1602099012|52005399003|40105399003|4302099013|440099028|3412199025|10035399007|102099032;
x-microsoft-antispam-message-info:
 =?utf-8?B?NXhhMmpBTEcxQmtBai93M0RkbVA4aWdTNmZyQlFmNVcwM1RFaFV1U1BheTZF?=
 =?utf-8?B?TUZaK3VMVU1oUFFjdnFVS0VYVzY2bGlYRDdwMkFSWjhCd3VpcHM5UDJTOUdT?=
 =?utf-8?B?cENORG5Fa0VZZlNPSklmUVhZVlFYMkZ0WkI0dlRSMHYxdk9TN0Y0VFpVNU83?=
 =?utf-8?B?VXNjZU13ait0NEl4UFQ2UjBjSUZsTVUvOXlLQWJEZGZVREVzVjVWR0t0UCtK?=
 =?utf-8?B?bXVDWUdKaDFrUjJDcjJSZnZhUmlRMXpHYktSQTVyUFFCQ3JvS1VnQmdGcmJ1?=
 =?utf-8?B?S1lWb01lRjEzK1p5UEsvdy9rc0E0T3FMbGt4QjBzRE9ySUx5aUpBb0M2TDV3?=
 =?utf-8?B?MEFtb21FTFp0YlcrOVg0R09aQU4welFyQWpTUWFvOG82ZkFoVERreG5IMitm?=
 =?utf-8?B?alN3dldULzEwSnF6alUvbENsemtDdHpzQTRtYTRIeTkrZDN0eXhVY1dTcXZ1?=
 =?utf-8?B?VnZ2akRDcGNwaElGWnpXTTg1U29EenAwOWhBSS9pUk5qcTZ4M29NcC9JbHVo?=
 =?utf-8?B?L3IxMEVBdWp3V3VzV3VxSHJ5a0VORkRLYkNHS3FwTDdSVjkrZUxJWFVsMzFW?=
 =?utf-8?B?U1F0RWEyQVQzck1aNERzNVJTTWJ2dDFvcTkzajRzM2tTamNmWXNJT1B4Znlp?=
 =?utf-8?B?dHh0azd6OVF2aExHUzUzQUJab1daOUpLazNpUTNqTTBUMVhBU1lIOXR2WUZp?=
 =?utf-8?B?UWM4UTR5aEhURkl6NHQyK29xOTJaaVhpMXQrbmExT2d3dTc4VHFTQmFvUFUz?=
 =?utf-8?B?dVdwbGN0UG05VWxPNGV2ZWNQV216SmhTMFVTdU5zaVBHdmwvUFh6ZzJtQU5a?=
 =?utf-8?B?SThlcVlQT0F2R29IRFdBZkZEbkhDK2ZzSzZ6MWhhK21pTEh5R1gzazNERjkv?=
 =?utf-8?B?WXgrbzU5enBJNUxBeDhtL1FBbm1SMW5tNnhMeWZMOXhobWFqSEhPVHJRdVZx?=
 =?utf-8?B?TUFEV2ZWRmFkcUwwS24xUjEyNlpobzlHblE3TVlOQU56RTRiN1F2WTlubEM1?=
 =?utf-8?B?WFY2WjJjQ2x2bHVhbjIwVjlOZjhKNjdydVgyZ3YrbjBkRXY5UmFsZGxGWDhW?=
 =?utf-8?B?VmhMOU1qeG9XLzAvWXN2MGdMek9oYWoySjdqVnJ5OUc5Q3BxRHk4VVdTbUpx?=
 =?utf-8?B?ZU5sQWdEdFlrMGM2QnZkd2Z2ZEZLK3NQWmpYbFNIK3pDb2FUZlAvUnlDV3BK?=
 =?utf-8?B?bVowZk9PMkg2cEFtdHRHUFlsZnlKSE5zZVQ3NXhLTjVqNkJHRnBWcDVzYVJ5?=
 =?utf-8?B?UzBSR0kxRXBNU3RlZmtzd0UvNFhyMVI0ZW5GMTdGK2c0aUM5K0ZFbzAxSm1q?=
 =?utf-8?B?VGdYSUJWTThxNlJYbzVyRTJZSjBaQ3ZaZHl2a2FuVGQvamYvK2JGempWQVpT?=
 =?utf-8?B?Z2RteUE3SmpUWlhDZ1RYSGZxUHVwZ2ZrKzdHRG9qQ01ZRnRmSWYwbU9XVXJU?=
 =?utf-8?B?Y21VT250NWN6dlh0VHdXTjJvVlpvMy9RV0NaWGVNcDNpTDdmZStvV215TXg3?=
 =?utf-8?B?LytGUk43WTRoVFhJRXdXNnM5NzhkYnhCYkNReTJPRG9oN1ZzYVRHRmsyNS9u?=
 =?utf-8?B?dUFVWFdZSjJmRHFWNjY3aHA0eDB3MFh5RmFJblo2ZnI3VDFQbWVjNGkwaDdp?=
 =?utf-8?B?YWtNRVoraEUxN1RxOG00aFBJZnlIY1VTOEo0NUd1UUtJSG13VEJHOGNIVEdB?=
 =?utf-8?B?NFYvYWJueTkvNjZTSGlUWVVXLzgrNHZ5VG9kYktYK0pqT3NxSTNqd095RmVB?=
 =?utf-8?Q?xR248LqYfyiVQpIryr7eFO1YAi2tuJSaOgX9+0+?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NVBkMy84Q042VTExRGUrRnNic2ttdytUaVZXMnphNmV1Ym5BTGxzK1R3aW85?=
 =?utf-8?B?NWlML2lobEFxMnVKckVWRHpiVjBhWXVPRE1NcUJCRk1ZRC9QTU5CWURoYVJC?=
 =?utf-8?B?WUpiSzFucWxVWWNZR1MzbnE1UVRvUm1lWFlsc21mcDF0czY0M0hpYitzUjJm?=
 =?utf-8?B?dHJzZXlZT3BjOG5tdjdiK3l4ZWpzUzQ1RlRGejUwbEFwVjFmWXR1RVJ2Szhm?=
 =?utf-8?B?aUhFQS9Kc3ZOMWxrRFF5UUdsL1R4SmxsY2owZC9HM2tvT3ZjSTE5OEs2aDQ1?=
 =?utf-8?B?RXdYTnRQTHpHa01OalZaMG5LeXM4M1pGSkN3VGxHYzVaemhsNGloYjJkY1lz?=
 =?utf-8?B?ZXRzbDAzUEpHcUlBSW5XYTZBOWdRdEVWc0FGdytXdU1zUTdnL2hUT0pmNGp6?=
 =?utf-8?B?RUVWT2NwNDRTU0ZvUGw3VmZUUW1CVW8wdUNEQWNkVTFWUkYwOEhpSlR6MUxW?=
 =?utf-8?B?ZXRXdVptZVpQUGNTZkJGei8wSUZ5SUhpL0puUVNSWWphOXpJblBGRGQ1QjBL?=
 =?utf-8?B?d1RHcGgvUDNsN2dVTEpDdlY3SFo1MjhQTmR4VVBieElhaGg4UWJuVENyUVFT?=
 =?utf-8?B?MlFDdVFrd3MzVG9QVUNtTFhKWk9FUExqQnN5Q211ZVh3RGNRWENiQnllUmlZ?=
 =?utf-8?B?ci9HQ0w0bmhmRk1iQ0hwb0ppWHBGMDhxcUpIU0RKeTVDL2FaaDFQRmczRUZT?=
 =?utf-8?B?a0dUWDZSK1lKZjA2SmRIWW1JSDRCamxFVnhvQXUwL1RwREVRRWtnMU1XM2I4?=
 =?utf-8?B?NE9TcUxHeE5xL2lNc1VDazlicG1ianFzVHNFaXpKaW9EanN5V1JKK3BJK3Yz?=
 =?utf-8?B?MkZqanBSQjc3dWt3aU41aGRjYkE5TE1jU25sM1Z3ZEVib3RUSnZPa2dXQUZn?=
 =?utf-8?B?cU9NUUlvTEdpeXcyTnhtNXNwcTlyVkRkVU5LSWE1VzNDOWtSRWdEYms2UmZm?=
 =?utf-8?B?bDdHYVZKQ0dqandhS0pRVmpQeGpKU2FOamFZVnNsV2dpOHNtMzZBeUxoUmhz?=
 =?utf-8?B?NFNVcDNDRHlzVWNHdjUwOXlFUEo2Vi9TZExUcmRBSHhSM3lFT2JIVmxZc3lq?=
 =?utf-8?B?MWQ1bFhrWUJiTVB2L0NIeUZPd0JCTjVMbU9QV3BIRG9iZE9nbWlwejBRTnFS?=
 =?utf-8?B?dE5HdnhTTmZ5WktMWWtIOHdkS09PRW1KREV1Ylh1em05NTJiNDVrbjBDMUNZ?=
 =?utf-8?B?b1VrVXNTZmJ3azFta2tLVzIrR21xOUJQejBncFFYMlFXbitpejJFTXNBV2tq?=
 =?utf-8?B?WkNSNjdsa2VHS0I3MVpaeVUyQ2V4TVNvNE1vUmllNjJZNDlCZUJML1pxM283?=
 =?utf-8?B?YlBPTVk4S0p4OVoyNUtNeGNraVowMnFjRXdidW1BNm4yQkQxcE9KWENkK29x?=
 =?utf-8?B?YkxqQ0VSNGVyWHViNFA1OXNHM3pJTGNkdkVxSjM3eVdSWUNwNmNTK3gvamRL?=
 =?utf-8?B?VHBHSXk0dGljNVJTVU5hTm9PYm0wMmRaZjJJb1ZMM2FtY3l4akE5bXExQyt1?=
 =?utf-8?B?VExId1E4MUZrSElubzZZdTBLWGovdHh2NVUvWUQrZUUzWXJ6MERQcXc4Nmla?=
 =?utf-8?B?eGtXQXZUVldVTzlXTUp6dmROaG00dDFYVHJSSUkrdGQ2bkpEbWs4QVZNSTV0?=
 =?utf-8?B?VDRMNEtOSUZ4SVpqeWMrYXg0dE1MbWlUb28yUUI0anNXR3pmcFVWSWQ3N1Rq?=
 =?utf-8?B?alczS0EvSnpDV2ZPa3Fxc0FNSVk1TnByalRxKzVUMjY5QU5lcTM0T3hSWXdk?=
 =?utf-8?B?S2hvSTdlSVAvL2xGSTRJUGYvQ0t2enhkdnhqRjgvM1FNUlRwWGRWWnRsQ3hG?=
 =?utf-8?B?eHNlSU9WczdObTJKQTI1bE1Oa0VSbENscTVtTklhaHhPOFdwQ25PdTBUeU5u?=
 =?utf-8?B?RVRId1VzNU5SeFZIWUtPNEdBZkwwNXR3Y0FPKzZ3RG10b1FGNURaWUZZYlFV?=
 =?utf-8?Q?De5Fn+SjeOYhGlX4L7swB/5omsIU3zDm?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 59693bb3-c50f-4fed-7314-08de6a54018d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2026 16:30:16.7638
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB8061
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8794-lists,linux-hyperv=lfdr.de];
	FREEMAIL_TO(0.00)[redhat.com,gmail.com,linux.intel.com,kernel.org,suse.de,ffwll.ch,microsoft.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[outlook.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 06A4812F718
X-Rspamd-Action: no action

RnJvbTogSm9jZWx5biBGYWxlbXBlIDxqZmFsZW1wZUByZWRoYXQuY29tPiBTZW50OiBUaHVyc2Rh
eSwgRmVicnVhcnkgMTIsIDIwMjYgMjoxMCBBTQ0KPiANCj4gT24gMTIvMDIvMjAyNiAxMDo0OSwg
Sm9jZWx5biBGYWxlbXBlIHdyb3RlOg0KPiA+IE9uIDEyLzAyLzIwMjYgMDA6MDEsIG1oa2xrbWxA
em9ob21haWwuY29tIHdyb3RlOg0KPiA+PiBGcm9tOiBKb2NlbHluIEZhbGVtcGUgPGpmYWxlbXBl
QHJlZGhhdC5jb20+IFNlbnQ6IFdlZG5lc2RheSwgRmVicnVhcnkNCj4gPj4gMTEsIDIwMjYgMTo1
NCBQTQ0KPiA+Pg0KPiA+PiBCdXQgZm9yIHRoaXMgcGF0Y2gsIHRoZSBpc3N1ZSBpcyB0aGF0IGRy
bV9wYW5pYygpIG5ldmVyIGdldHMgY2FsbGVkIGlmIENPTkZJR19QUklOVEsNCj4gPj4gaXNuJ3Qg
c2V0LiBJbiB0aGF0IGNhc2UsIGttc2dfZHVtcF9yZWdpc3RlcigpIGlzIGEgc3R1YiB0aGF0IHJl
dHVybnMgYW4gZXJyb3IuwqAgU28NCj4gPj4gZHJtX3BhbmljX3JlZ2lzdGVyKCkgbmV2ZXIgcmVn
aXN0ZXJzIHRoZSBjYWxsYmFjayB0byBkcm1fcGFuaWMoKS4gQW5kIGlmDQo+ID4+IGRybV9wYW5p
YygpIGlzbid0IGdvaW5nIHRvIHJ1biwgcmVzcG9uc2liaWxpdHkgZm9yIGRvaW5nIHRoZSBWTUJ1
cyB1bmxvYWQNCj4gPj4gbXVzdCByZW1haW4gd2l0aCB0aGUgVk1CdXMgY29kZS4gSXQncyBoYXJk
IHRvIGFjdHVhbGx5IHRlc3QgdGhpcyBjYXNlIGJlY2F1c2UNCj4gPj4gb2YgZGVwZW5kaW5nIG9u
IHByaW50aygpIGZvciBkZWJ1Z2dpbmcgb3V0cHV0LCBzbyBkb3VibGUtY2hlY2sgbXkgdGhpbmtp
bmcuDQo+ID4NCj4gPiBPayB5b3UncmUgcmlnaHQuIEkgY2hhbmdlZCBmcm9tDQo+ID4gYXRvbWlj
X25vdGlmaWVyX2NoYWluX3JlZ2lzdGVyKCZwYW5pY19ub3RpZmllcl9saXN0LCAuLi4pIHRvDQo+
ID4ga21zZ19kdW1wX3JlZ2lzdGVyKCkgaW4gdGhlIHYxMCBvZiBkcm1fcGFuaWMuDQo+ID4NCj4g
PiBTbyBJIHNob3VsZCBlaXRoZXIgbWFrZSBEUk1fUEFOSUMgZGVwZW5kcyBvbiBQUklOVEssIG9y
IGNhbGwNCj4gPiBhdG9taWNfbm90aWZpZXJfY2hhaW5fcmVnaXN0ZXIoKSBpZiBQUklOVEsgaXMg
bm90IGRlZmluZWQuDQo+ID4NCj4gPiBBcyBJIHRoaW5rIGtlcm5lbCB3aXRob3V0IFBSSU5USyBh
cmUgdW5jb21tb24sIEknbGwgcHJvYmFibHkgZG8gdGhlDQo+ID4gZmlyc3Qgc29sdXRpb24uDQo+
ID4NCj4gDQo+IEZZSSwgSSBqdXN0IHNlbnQgdGhlIGNvcnJlc3BvbmRpbmcgY2hhbmdlOg0KPiAN
Cj4gaHR0cHM6Ly9wYXRjaHdvcmsuZnJlZWRlc2t0b3Aub3JnL3Nlcmllcy8xNjE1NDQvDQo+IA0K
DQpXb3JrcyBmb3IgbWUuIFRoYXQgbWVhbnMgSSBjYW4gZHJvcCB0aGUgQ09ORklHX1BSSU5USyBj
b25kaXRpb24NCmZyb20gbXkgcGF0Y2gsIHdoaWNoIHdvdWxkIGJlIGdvb2QuIFRoZSBjdXJyZW50
IHZlcnNpb24gaXMgcmF0aGVyDQpzdHJhbmdlIGluIHRoYXQgcmVnYXJkLiBJJ20gcHJldHR5IHRp
ZWQgdXAgdGhlIHJlc3Qgb2YgdGhpcyB3ZWVrLA0Kc28gaXQgbWF5IGJlIG5leHQgd2VlayBiZWZv
cmUgSSByZXN1Ym1pdCBteSBwYXRjaGVzLg0KDQpNaWNoYWVsDQo=

