Return-Path: <linux-hyperv+bounces-5487-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58676AB5898
	for <lists+linux-hyperv@lfdr.de>; Tue, 13 May 2025 17:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D21C31899088
	for <lists+linux-hyperv@lfdr.de>; Tue, 13 May 2025 15:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA80A28366;
	Tue, 13 May 2025 15:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="LBFQoPmG"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2081.outbound.protection.outlook.com [40.92.21.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C591383;
	Tue, 13 May 2025 15:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.21.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747150235; cv=fail; b=RuGnHphKUT9mYhtOGdAZ6YxOBd0gCdMGC1gLwckiXKeBBuoaMqy/6vkIaadtlxFbum73XaHTttDv6FJUP63BGd3aR3c4ruNQ0wBWJsk+gZ3+dex14RDhJ65PixsXzPvrY9quSb2t84Ecxa5eo5vwzxD0RziZhJfy8uCewMJG8Fg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747150235; c=relaxed/simple;
	bh=NqeJIIPYFCMWHEyLwA92F55jMomQ8VV2fOwdFjbQ0vI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gOwGC/xOla0Vdvesu/VbqTjjmARhjn56oetUe6aVbCS4KTMAm5x52qdAO8Bm6TvhjZ7hYEjIC3m2s3GljpRre3L3PZsbQ49oexwVHHuO3fvQzA108ikuHyMtK++i28bnxsZeBo5pMafoz5Sl0oI07sI1a7fvWtmb1WjwfGsup2o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=LBFQoPmG; arc=fail smtp.client-ip=40.92.21.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tddLg1KB0xJI6LNxPTBL+humNUg4bkKGl7FtZc/d61Xl/c049OVU4OjuNhqFJd0drJpfH1G8xnlYE+u3jsjEk17AJmplR+W6y49mk95Md8tTt5bo0degDPp9hsTLVCC2x0um7hijwOYgTzuz3c7zDRcu+J2W9q32P0tQvS9MF4Z+YvPC/z/H509BVC8DN5uJx2unVs1retboNVsFoQFFfBjuXb4saEjvzd1+MaEVL0ujYw896vnFUwQcVSw8EdAOALJF6SFsWJM1e6nfxzL9MqddDd/YzVQzX8ZkhTZL9VOoMw37fA1Sa2tRuMEejMlS+jfa8jbg4dcHyYvdRYCqcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NqeJIIPYFCMWHEyLwA92F55jMomQ8VV2fOwdFjbQ0vI=;
 b=Hfxvz9AZhT8wiHCO7SxWeepVEtLEjI/gijc73LpFoiNrJ7dfdMe7JQRTRqrhcwHA0XjIi/vPDDwbA6XZ+iDHh4FcvkIxoWGTnjINcDoEMUmwtSLJGT1AZoyotomfDQTu5RqaEEE0Sy/wrxFkNoGi4xy5I2Z6hBTFtFmfKRrhojz3pOgh1X2ozimS1SS5CEwdNfY7foGOZl1ACnFxiU3zhLqgCDBp2zR9zVhg4c/pP1bom2GpOd8CZSBMb8N30MWdSdEZpQ0G8Y5hAzk5TXII5xJUV8dQ98oWVX9Nk5ol6YtRKjpwoXhVQfG43iSdob4vw/cOsAJoUa045zBriFg42A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NqeJIIPYFCMWHEyLwA92F55jMomQ8VV2fOwdFjbQ0vI=;
 b=LBFQoPmGya/1WTA3ooLt5efddgZdrpCCcsGtjvzKAY8mHIAbCsnHVHgKuoUkyfK9G9+wSQWv4ubMUWjZOP4fMtZzooSgFrhvP9MwFnQJr97rtc0quip+A/rbewDSF/l5xHNT7/xGIwE+t9qcbcUYqzASux+AIaF2FNOIuW9+g00k9KqPJS0Z2ZERE1hRy1gL32gMrVQDo+5ab5AdAb/phtYZYWqQi8WCKH+siBVUweip+AC9yKCTG0zC2eQhaLICfFfzwPE6x55USCn7596wZsA57oS9UkFZjw7uVGocz7QYFGKDhY8H8QsjHparO3IrMMiUehsDVocyxaewp9opzg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SJ0PR02MB7231.namprd02.prod.outlook.com (2603:10b6:a03:299::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.14; Tue, 13 May
 2025 15:30:28 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 15:30:28 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Roman Kisel <romank@linux.microsoft.com>, Saurabh Singh Sengar
	<ssengar@microsoft.com>, Wei Liu <wei.liu@kernel.org>
CC: Naman Jain <namjain@linux.microsoft.com>, KY Srinivasan
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Dexuan Cui
	<decui@microsoft.com>, Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>, Stanislav Kinsburskii
	<skinsburskii@linux.microsoft.com>, Nuno Das Neves
	<nunodasneves@linux.microsoft.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH] Drivers: hv: Introduce mshv_vtl driver
Thread-Topic: [EXTERNAL] Re: [PATCH] Drivers: hv: Introduce mshv_vtl driver
Thread-Index:
 AQHbvmPo2K73dQwbLkKS9L76qOPuv7PHI72AgABpswCAAXzIAIABkjCAgAAAngCABht5AA==
Date: Tue, 13 May 2025 15:30:28 +0000
Message-ID:
 <SN6PR02MB4157D8770347E8C2EC49EBBBD496A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250506084937.624680-1-namjain@linux.microsoft.com>
 <KUZP153MB1444858108BDF4B42B81C2A0BE88A@KUZP153MB1444.APCP153.PROD.OUTLOOK.COM>
 <8f83fbdb-0aee-4602-ad8a-58bbd22dbdc9@linux.microsoft.com>
 <aBzx8HDwKakGG1tR@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
 <KUZP153MB14447CC188576D3A7376CEAABE8AA@KUZP153MB1444.APCP153.PROD.OUTLOOK.COM>
 <30fdc85f-5afc-4591-ab43-1c46c435025c@linux.microsoft.com>
In-Reply-To: <30fdc85f-5afc-4591-ab43-1c46c435025c@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SJ0PR02MB7231:EE_
x-ms-office365-filtering-correlation-id: e19b0890-029e-41dd-4212-08dd92331752
x-ms-exchange-slblob-mailprops:
 LVbdfIC7uFBFP9cp9EJQtdWcvQFEeLlksww/IBea1MGm30TV/FU9EJr3i0cjOFM0X0N3jV3TWvAUHxZRUy+E0gnlWWOc++vQVOdPa11+0oSTLqum0zJYcKKIaSioZwwMYUbPPy/rXhjN3H8dVSY+Cj64OiLWg/SLGVEA3J+J1LK5woC+z+5YKD1Ss2z8JRYCEScPFG0kvMj03RF3CppmGnhIvYCLarAz3XyKNwY3GtlDsESMZOQMKBHapwXrNC89xHE1aGPvxfnMUF0sDR6VcR61wijQOmSZQ8slFCA0Im3b+w8nqsB0DkWuwplp1dB5/iVvPbK/Cv6XrKZ6Cjp/66PzKtLNbAF8G5y29BthRUNYAAfpU/3Q+fM+Hnje/rO73dCDf0HVeKFsN7N9L8ou4wHAbsGkJPdu/3w2rbCrZvO6dmwOzjxNOyNf1HaYKKP+JKcB0VsdEVyJPQz/EaGi2p2tHBEaht2E4t730yF4CRgOle43FuZ1k7H2ZnH+2stpZ1SaYuVV+GQVV/CzNmpDaqvCeeeqWXyCqwqlakZGMTg1Rvq82hwM0m01JTtoozYnwzG7UcSPmLRmOYF2p3Gdl51cu9ijNr7y1UCn/C80sqkuIGY0JRCvpKx/HPITMqdaiAo2yNRJkx2e0rAzq/QXJeQJnNxPTO54rBXDM6IOP/ca8pH+TnZDrLrdl3BIkSOGLC8SsDPLaWszRQK/qA8iQ6c3Db/7UhwgrH1l6UrVeoBhM88Icqpi8g==
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599006|15080799009|12121999007|8060799009|19110799006|461199028|3412199025|440099028|102099032|12091999003;
x-microsoft-antispam-message-info:
 =?utf-8?B?MDFQcmh5dU55R3BlTEJDdDJxeGVOT29vOE1nOGFMdVdjd2xGSGRWQVE0M3Ez?=
 =?utf-8?B?RmpGM2tIS0xxSkVqQkpDYjh0dE1OcWJodVNjajJtejkyOGpGV2cxRFFuS2Nm?=
 =?utf-8?B?QWQvSjdjcWtMUk9JOXlQb0E4MXkvV3AxK2Fka291MitiMUFJcmNZUm44aG5N?=
 =?utf-8?B?Nk52S0g5c3lsL0tPc05BZXBzYkVzbmdQK0w5M1k0bEV1c1dYN0lhdXZQSzQ0?=
 =?utf-8?B?VnBuV1ExbUlpSm10NWxtN3oyR3hpdmhyMUE0Tm5tRmNQeVlsYmlWV01uWVJU?=
 =?utf-8?B?NDhKcG9Bc2tGRTRhdk4vM1VXenBtaklUWVREbm1FSGtYTUhOalRXVi9KSlVl?=
 =?utf-8?B?a2hVTzNoeCt2aEFMRlMyekZZYzJCc01TbDZoU241S09ETXJvZUxkZDluQnhE?=
 =?utf-8?B?UWlvNWpVOHRnYlBiTG1PLzRRY0JVNFM4K3NWaTVUbGR2Y1hUaGRjcTk3QmNO?=
 =?utf-8?B?UzdOWVNvRnJCU3lvbHBFOGc2RG5hR2hTVTdnL3l0QWxjaTY0UlZiT0Z6cUdH?=
 =?utf-8?B?VGkybUkwcElLMFJyZHRKbTZuY0FFaVdhbElGVnlxQ3VZM1JqdXhJb2RaZXYw?=
 =?utf-8?B?blRLYU9LRkh3Z2dZTFp0WFI0c0tvU1R6dU14L3F0bUFuclJWamtmWkVYRWd3?=
 =?utf-8?B?VGR5cUQvNVhLb3pKYmYxQ0J1NVlRQm5weW51WTk1UDExeVNOMkI4aEhadHF0?=
 =?utf-8?B?b29xMk1WWm1DcG5sU0tTOG5tcE4wblc2eldDTDJIN2lrVnhwdjNQbHVrV2xR?=
 =?utf-8?B?ZzFjWDJNeTByTWdCajVscm1CclFQanVscTY3cHVyNUdzNDZ2TDdSQnhhZzFv?=
 =?utf-8?B?Um5DeHVuR0dpaGJ5RXdqZklYcE92VjBLeDAwK2hnZ3ppWG4yd2owNDR6Tm1C?=
 =?utf-8?B?b01mUzBBYTlNNWpIdnJrMExyUEVYTVk1OXBQN3dmVWliTytrczZob3A0bTFu?=
 =?utf-8?B?ODhTaThDMkJwcFJHQ1ZPeTViZlIvZmNaZjBuNlJCQnljNVRFS2kwdVRSSUhl?=
 =?utf-8?B?K2hoT2VjemU1ZU9tT2l0cDhKeko2L3hmWDJFakc0MlZqbTM1SnVLM0RpbDlD?=
 =?utf-8?B?bU5wYlV4MkloTW9SRFpMQWhCUjI3VEJqNDJFaWdibTZzTmZ2aVJFWDZrcU5F?=
 =?utf-8?B?WEUvTHRIaUtiNVZ5MUVkbzkvMWgvZFR1MWlhcGZWclNqQW1uSmlXM1NkTHRD?=
 =?utf-8?B?UnhvdWFISklWWm8yZHBnaXBiYjlNSkJBS3FwTDdDWEVBSzBHajR1MlhsWFNR?=
 =?utf-8?B?V3lCUTdzaXo5N1hKY3NWSXE2MzA5TUNueXpKRUxTMzdTQkxOeEc1c3BLUUI5?=
 =?utf-8?B?amRpTU9xMEVHRldLclNDUEZEWUxJWmVoc29sNlFjMWYzRXE0Yk55STFkdXRY?=
 =?utf-8?B?bytQUlUyWW9La21uVVpjTVV2TXZBaHFjU2lKTjJqMEFXRDZ3Q0JPUDNnYUJT?=
 =?utf-8?B?ZXVZZjFvOTJKdzk1TFg4Y2d3QWo0eTFJaFk0ZEFMOHdBby9ibEZCM25aQkRr?=
 =?utf-8?B?YXpGTzVVUnN0K0llMmltdXFHeFFnakhJVnV1RGFQRjhHS1ZYKzNIb1dMR3Jy?=
 =?utf-8?B?MHZ5QT09?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UkxUTHNEbnRuVGRTM2l2b1dVSktycDh3dDExUDZuS0NGdjJHSndlWGE4aGRD?=
 =?utf-8?B?SlJZb2VBS0I1UDZ0ZnRvVWV2WXBJMHAzQ285ODZmaWF2RitNaWVBK1F1VUo5?=
 =?utf-8?B?RDdhMFJpWktQc2MzS1dDWmRPalQ4UXRGalJkWFZybWdCZk02ZDlBcU9xSzl0?=
 =?utf-8?B?dWV4S0xwendLdHJsRFJpL1FKbDhGRFlhMGwyOUNFMXMxZVVnaVJZcXNTN0to?=
 =?utf-8?B?S1dubThkdGhjYnVzNCtCeXcvd2J2UHF0OG02V2VON3lBYkh3eVlmcFE5SW1o?=
 =?utf-8?B?eExtTlJSRnEwaUp6YysrSjdtM1IydUFpcFh6OERkaHFSL2ZDWVZYWlJ5ZWFK?=
 =?utf-8?B?OFBLVUgvNVFseldjY1htakF1cVNUeXdRNXhodTJORmtOZnVIQzR6RXpLdXdk?=
 =?utf-8?B?VTdIMklwOFp5cVNhcEtKNHZGUXhGUDJBK3RCR1ltQ21SZnUzOW9pVFpxVlhW?=
 =?utf-8?B?cC83WEhTZXNpN3dNZUdNVTF6M2w0aHN6UXlIU1RYdzdZL3N5WEdjUmVtcUc0?=
 =?utf-8?B?R0d2ZVFrT0Exak5JcGhpMmIycWF4QzByV2FKQ25Ndi9USHEvZXJmWjF3LzA3?=
 =?utf-8?B?RWJlbS8zTmxGMlBtdGhkaGkvTlEyUDhqMGVwMFNwclhGbkxzdVRGQ2hLbHRy?=
 =?utf-8?B?VHFSaFVBSmJGUFlrc1hTajJ6dzdqYWtpa1RVaXlNbGVYZ0c5OGsvMVVtMzZE?=
 =?utf-8?B?UjZMMytqZWUrelAwQXh6ekRzRXptUzNreUFJZU1HS0NmT0NLNTJVbnBzMk1l?=
 =?utf-8?B?V0IzWVVMMEdWUkhVYndUZUVLR2FkV0FZQVRYaTFpRDRVd0pNZnU5SFBtK3g2?=
 =?utf-8?B?RjgxUkcyNEdMZk5Zazl6UEJyQzF2R1hTNHBlek9VSkNrSlMvTitvRmRGWTZL?=
 =?utf-8?B?ZDFSb2wrcGdyZUI4T1NqRStpcjdDZzhVWEJPdk11eXl6Y1VxOThLVjEvcExi?=
 =?utf-8?B?ZlQ5dzlwcFIxWllzamlrTWNvRldUNUlFTnh2NWdhQkZWTzJONTZnZ1pBbmJs?=
 =?utf-8?B?RkJiY2QwOXFOMDN6YitvVEJRV2hJY1BSZUJlNlZ0K1d6WGx2anhpNmRHeFpR?=
 =?utf-8?B?K2UxWFF5L2xGTUxObmxPY0FSV1U2ZTVGRU1sTmdadUNnN2ZiU25id1lDdmpV?=
 =?utf-8?B?dlVkbFhCbjgvYU5HK2lFV1l2d1hxMy8xeGkwdmVraU1MMVZaUTg5STd1aFBt?=
 =?utf-8?B?bHBVektPdlBRblJBQVpHV0tmZzhoSW82SnZIWWcwOU5sSFlOMmJKcHU0Nzhz?=
 =?utf-8?B?Q0hmeXU0QTBMYmNMWEprNEQwbGVXTkpDTTg2bG12YzZlRnlITm9RV0ExUVRB?=
 =?utf-8?B?c3hkamZ0SEl0elI2S1QwSTcvbmxhOXg3ZTF0bUVRajdENW9weGNML1RHa2tr?=
 =?utf-8?B?UjBUaFRQcWJnZmdKYk93MkYwelBHMlBnREozZzdFNkQ3ZkhyZU5ldjBzeHFL?=
 =?utf-8?B?b2tkNTI2cWRSSWdnVllNS2h6SnhXZFNzYnhMaEVHUXFCRFJ1bVJCa2N3R1l2?=
 =?utf-8?B?WUpYMlNDUmtTYWhQS1I3dzc1MW9vazMzaHJ1YTZpVUhvR2ZzZ0R0bU1FQzhQ?=
 =?utf-8?B?MlltRDNBYWJ4VFlWVi8wOG53UzNXdjdlb2VYWU8wcmlmbGk0bTBmOEtrT3ZC?=
 =?utf-8?Q?O3iloaUi2e9k1uI2kIWyiLr0Hk/kX/7tMCYEIM6W//xE=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e19b0890-029e-41dd-4212-08dd92331752
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2025 15:30:28.8277
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7231

RnJvbTogUm9tYW4gS2lzZWwgPHJvbWFua0BsaW51eC5taWNyb3NvZnQuY29tPiBTZW50OiBGcmlk
YXksIE1heSA5LCAyMDI1IDExOjA1IEFNDQo+IA0KPiBPbiA1LzkvMjAyNSAxMTowMiBBTSwgU2F1
cmFiaCBTaW5naCBTZW5nYXIgd3JvdGU6DQo+ID4NCj4gPg0KPiANCj4gWy4uLl0NCj4gDQo+ID4+
IFllcC4gV2UgZG9uJ3QgcmVseSBvbiB1c2VyIGxhbmQgc29mdHdhcmUgZG9pbmcgc2FuZSB0aGlu
Z3MgdG8gbWFpbnRhaW4NCj4gPj4gY29ycmVjdG5lc3MgaW4ga2VybmVsLCBzbyB0aGlzIG5lZWRz
IHRvIGJlIGZpeGVkLg0KPiA+Pg0KPiA+PiBUaGFua3MsDQo+ID4+IFdlaS4NCj4gPg0KPiA+DQo+
ID4gSG93IGFib3V0IGZpeGluZyB0aGlzIGZvciBub3JtYWwgeDg2IGZvciBub3cgYW5kIHB1dCBh
IFRPRE8gZm9yIENWTSB0byBiZSBmaXhlZA0KPiBsYXRlciwgd2hlbiB3ZSBicmluZyBpbiBDVk0g
c3VwcG9ydCA/DQo+IA0KPiBUaGF0IHNlZW1zIHRvIHN0cmlrZSB0aGUgcmlnaHQgYmFsYW5jZSBp
aG1vIDopDQo+IFRoYW5rcyBmb3IgY29taW5nIHVwIHdpdGggdGhlIHN1Z2dlc3Rpb24hDQo+IA0K
DQpGV0lXLCBpdCBzZWVtcyBsaWtlIGl0IHdvdWxkIGJlIHByZXR0eSBlYXN5IHRvIGZpeCB0aGUg
Q1ZNIGNhc2UgYXMgd2VsbC4gIERvDQp0aGUgZm9sbG93aW5nOg0KDQoxLiBBbGxvY2F0ZSBtZW1v
cnkgYXQgcnVudGltZSB1c2luZyB0aGUgbm9ybWFsIGttYWxsb2MoKQ0KMi4gQ29weSBmcm9tIHVz
ZXIgc3BhY2UgdG8gdGhhdCBhbGxvY2F0ZWQgbWVtb3J5DQozLiBEaXNhYmxlIGludGVycnVwdHMg
YXMgdXN1YWwgZm9yIHVzaW5nIHRoZSBwZXItY3B1IGh5cGVyY2FsbCBhcmcgcGFnZXMNCjQuIENv
cHkgZnJvbSB0aGUgYWxsb2NhdGVkIG1lbW9yeSB0byB0aGUgcGVyLWNwdSBoeXBlcmNhbGwgYXJn
IHBhZ2VzLg0KICAgSW4gYSBDVk0gdGhpcyB3aWxsIGRvIHRoZSBjb252ZXJzaW9uIGZyb20gZW5j
cnlwdGVkIG1lbW9yeSB0bw0KICAgZGVjcnlwdGVkIG1lbW9yeS4NCjUuIE1ha2UgdGhlIGh5cGVy
Y2FsbA0KNi4gQ29weSBvdXQgYW55IHJlc3VsdHMgdG8gdGhlIGFsbG9jYXRlZCBtZW1vcnkuIEFn
YWluLCB0aGlzIHdpbGwgZG8NCiAgIHRoZSBjb252ZXJzaW9uIGZyb20gZGVjcnlwdGVkIHRvIGVu
Y3J5cHRlZC4NCjcuIEVuYWJsZSBpbnRlcnJ1cHRzDQo4LiBDb3B5IHJlc3VsdHMgZnJvbSB0aGUg
YWxsb2NhdGVkIG1lbW9yeSB0byB1c2VyIHNwYWNlDQo5LiBGcmVlIHRoZSBhbGxvY2F0ZWQgbWVt
b3J5DQoNCihBbmQgbWF5YmUgU3RlcHMgNiBhbmQgOCBkb24ndCBhcHBseSBpZiB0aGVyZSdzIG5v
IG91dHB1dCBkYXRhIHRvIGNvcHkNCmJhY2sgdG8gdXNlciBzcGFjZS4pDQoNClRoZSBwZXJmb3Jt
YW5jZSBwZW5hbHR5IGlzIHRoZSBtZW1vcnkgYWxsb2NhdGlvbi9mcmVlLCBwbHVzIHRoZSBleHRy
YQ0KY29weWluZyBvZiB0aGUgaW5wdXQvb3V0cHV0IGh5cGVyY2FsbCBhcmd1bWVudHMuIEJ1dCBJ
J20gZ3Vlc3NpbmcgdGhlDQphcmd1bWVudHMgYXJlIHVzdWFsbHkgb24gdGhlIHNtYWxsIHNpZGUs
IHNvIHRoZSBleHRyYSBjb3B5IGlzbid0IGEgYmlnIGlzc3VlLg0KDQpNaWNoYWVsDQo=

