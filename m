Return-Path: <linux-hyperv+bounces-8594-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4MapLH0JfGn1KAIAu9opvQ
	(envelope-from <linux-hyperv+bounces-8594-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 30 Jan 2026 02:29:33 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA2AB628E
	for <lists+linux-hyperv@lfdr.de>; Fri, 30 Jan 2026 02:29:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA94B300EA98
	for <lists+linux-hyperv@lfdr.de>; Fri, 30 Jan 2026 01:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A15732F762;
	Fri, 30 Jan 2026 01:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="l1idAjL6"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazolkn19010019.outbound.protection.outlook.com [52.103.20.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49C6215F42;
	Fri, 30 Jan 2026 01:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.20.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769736571; cv=fail; b=tB/7lNl/SqD/Xe7R7Umx0AZ5a+n+VAUIgH3AEwXLoIh8Hn/iM1Fj7rzmfvBq70tJ0kQCZZ7QLjMMeL4DJBL3GwivMlNOIczxlBTE1BzGfIbZEdM+jV3lgnyT2AZHrbOtxLTdOS6eQPo0rxz7I9iVYixpwQGMqzPHwabdqsEm3As=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769736571; c=relaxed/simple;
	bh=iuMn0AGFNOywgOyRyiT8OTmnSvGngWHaQPgyh+a2FGc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bAJwiO4el50k5FOXgpnmaF1VlJRQ99sNmZRco6D0iTjawcdO0Cakibe941pUtBwtKyickrF5D7aB+F0ew4B3ZNW4lUsglU0qspFjpCbsOy5HEl8QN1Ri1M/6MHEZGe28GOM47xbiQZzAjERhyp624vfpD1RapXrZaAPozTGDQNE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=l1idAjL6; arc=fail smtp.client-ip=52.103.20.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U9rWTBaR9F21qRvWhYcCyqrxHWz/gsMBujRas8XU/JmXJzjPkBPWrJtV8lyAsDq7NfMsklhH+XVVN6bJL8Vm1+kdpgbU7lctC1+OtWDzVAJcLkR7o8zpvsH//0V5+0Un9LexuT08ACAyT05P4QIClGRvEa/dX5nZjabdsW8l5m08tZcBEFamECAZrYA1iefHS/GsC3oPzeOZXLhylJKEFZXKhSw3OywJ8w5BWJzY4MeK17XXYHKE6/RdxbeXyuGRxmfTmkVpbmeC+RxtEYMaO9sVWLSUuLeZys0bftlkyovd96BNT4DLoU2TyBoY5rAQhZgFt7nQIn7KXqld6OtSdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iuMn0AGFNOywgOyRyiT8OTmnSvGngWHaQPgyh+a2FGc=;
 b=qXQ0c1U3DR0N2BuPt0H4QwgpSWneCTDT2ZIQZNmgcKUHybrwWM07MLIjI3q/cj6wu/VZIlZZCwKwHNYc5UHDmTPpjFAtJmoOAop1D73NxhB0LUzTobBKMoA8SeF50m6kYctfRrOO8JJnrf3GQuu2Y9V1Gg/hSv9iyBcV0xMSlXqnJ4RUp8339/iem04hertabyKwBhkUedKCcuKSOGj99+IcgXENJU+HIxefXaSFHF8z4gUm+e1DLRzFnMEo+wBjjssjbeSotI94Bs/CdY9oKwPgRA30GIaFp+rWJfohh1+3+rF0X24Ehr1FmDyIGZlP1ymDZhuTTOiB1v+uUkaOuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iuMn0AGFNOywgOyRyiT8OTmnSvGngWHaQPgyh+a2FGc=;
 b=l1idAjL6CWrGmFf4BRve2wrD3ULeXt25HPFZ6Eyhy0k6E71avxDXj7ca2YflChUsU+XxBQsGe+4BKqEz82GoTeP42o452/AZnzIeeySuNlkQVSDigLwOr5Ftuj4jpYqoyQtrEyuzvE777kjpRmjd8uIdoxJ1aaEMyBrUc5UQZclLNA3RhGq+1XewC7YwEPo0gZjPmQOI7rm7mj9KJMmUBYo63x4j5W0fXiIHQGtfo6su9d43TLgr5R6JSOUK5SMLqCI9964kpyQlY6ybxw7H22WJaNL3/GEWZ/TXePX/RDwC2fXiHmwSFIUB5vnzQcYt+qzr71ir148KId11/Z3Z/g==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by DM6PR02MB7065.namprd02.prod.outlook.com (2603:10b6:5:25a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.11; Fri, 30 Jan
 2026 01:29:28 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9564.006; Fri, 30 Jan 2026
 01:29:28 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	"kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "longli@microsoft.com"
	<longli@microsoft.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] mshv: Add support for integrated scheduler
Thread-Topic: [PATCH v2] mshv: Add support for integrated scheduler
Thread-Index: AQHckVsMuD6UN2xRB02jUgX+1AWVZrVp7H0w
Date: Fri, 30 Jan 2026 01:29:27 +0000
Message-ID:
 <SN6PR02MB41571179407BBD9F18267622D49FA@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <176971725312.67225.3938191771112866951.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To:
 <176971725312.67225.3938191771112866951.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|DM6PR02MB7065:EE_
x-ms-office365-filtering-correlation-id: bd397d67-fa10-41e7-8fd6-08de5f9f0274
x-ms-exchange-slblob-mailprops:
 igNrEvV8uhEvpyeJ/Jdph30uiRXy5wZP8BnkkNTekwAc++RP/ORi61fXLkC78SbDNWDZEgxYpiz5rNPoiV2lPM50cXAxumTyJaAFZCVUDayFWRYym0ma/EUBgDv3nIa47rjvWcWbVCILLEzuKAfmKp40dPj82tdAu0EIavVPsOyBmiLA6FIYZdOQwuCempvQn2Gmsd5RHBBeA4tai2+kll1eXpiY/FNlXiOtI/9pHsRjUy2fsciQu/Md+j4RGEEFMGNXg2izq0IEXBLsl3kIZ9S4hFYnHZHeuhbfEqAWfZQaBuKtplZWbFBXfxjmH2fPtS+3Bv/qG8lbgU/zcS0/SJkattUe6aei9V3r+FVexoRFFrSTgqeKiUbGBaPAUE/JqMgw03l3o1tI+Fnfkv8hTxQoHidTswUwhOQZiVfUuZu8Cdi/N0fJj6uHDoQ/sc4uJYljwscCaTG6BuuZj9X9AUXKJTMSmS5a/JRpZrLp6YxxmWNWg3Zi9xsZ293Er/dca5h91+SuujKh/ec08K0gvl8LmlPvJR7HuLKihE39zPw9smlX69Npo2xdFufzS4JbjKDkQvWtPrSVxdB2MME9ieoKo+/arx/8TMVO+NvqlPAHBrY15L7bZYwsmJZEsPLLp+JrPIwkBH6YwbeLeH6NOCEfYW4FfLDb7LgklzmH0F/bMrJM72Z/iK2R1/zCBRRW5aI6OQ5QodA=
x-microsoft-antispam:
 BCL:0;ARA:14566002|41001999006|461199028|15080799012|51005399006|13091999003|31061999003|19110799012|12121999013|8062599012|8060799015|3412199025|440099028|102099032|40105399003;
x-microsoft-antispam-message-info:
 =?utf-8?B?dk9TMk5xSjZ6eGlHZDB1RUNWRzB0VXRRSVVrL1R6Z084MUpkL1F0MngvVWYr?=
 =?utf-8?B?ZkFXWS9WUFFKYTQ3V1BvRHdCanBReGlyK3VkL1JjK2d3NjQ3VGJxNVpMREdh?=
 =?utf-8?B?UHB1bkxlVnk2UmF4VmQvVnQ1cUxxc1duWE8wUkJObytOSy9PL01UNDcva0gx?=
 =?utf-8?B?QytodnRKQ05iOWxVaW1jVGZac29sLzVJbEtINkNkSm01cm1PNGMxdW9SNDRt?=
 =?utf-8?B?TDU4THRnREl4ZzZSUnU5bS9vbVBsZ0NMVU5zckFYbmkrcDNpODhScVNyQURZ?=
 =?utf-8?B?c213WDdXTFY5TDR1YkJjeWpSclNZaElvSHlOeHRxSmRWWFFTa1RGb2RYSmlQ?=
 =?utf-8?B?dHpDZE1HQS9GUmxDaENpWUQzcktvOVFRYVN3WTJtT21neERCeGxJM05yRmxL?=
 =?utf-8?B?cGxxOTFGeUtnekJYRWM5SnZSUWFKN08zQW1aWWhqR0l0ZWtWaXRRNmhGVFF2?=
 =?utf-8?B?cFZVcjA1eTUzazNVZlhrdGwxSUEzVjFyTWVZRDJheXBYNjYwZHd3VGJXSDFZ?=
 =?utf-8?B?WHhiaGhnT2hqRDBRNmFXN0ZKbWFXQVg0Vkp4U0ZuMTFUcm4rQm1TSnJVOHJG?=
 =?utf-8?B?NVo5K2N5UGNHblgrY2lDcUFKMDhhbTExWm96Q00vcWRNMkpkWEx0WUppZlA1?=
 =?utf-8?B?eTBpK1RGSkNrVGhXbDQxRWlkWjVLMmplM01TREErRUh0VVVTMXFibVpYQjlH?=
 =?utf-8?B?MUwrOWcrSkVOdkYxSHlFOGozdnRybWY1bFY2ZWt6TFJZa1AwY3VQS1RxRTVy?=
 =?utf-8?B?WENMcHB6SmREQTBIWU11dWhaZGlLcTRpcEhoNlFjeTUra2pjb2p0RnJTSm9J?=
 =?utf-8?B?blhRbVFwTUFFckRmTUxLSktJYXhLQ2VhV21ISGh6V2c1QjN0QjlvN2pFN3Fl?=
 =?utf-8?B?aEtzeXJmQUlJTEtKVjFEOUgyZFkwd3RWM203U2djR01aZm9Zb1RnYzI1WVJ4?=
 =?utf-8?B?Y012QW14UHBCUnVpeG02UklqSUhqTmpNTU9qTnI5V2MzTXY2VExaai96RVBU?=
 =?utf-8?B?bkNVYzQwTHBOZDZ5Q29wbFNndEk3R0w5N1FQZXlBcVdLN2p6TCtMdXRRNnhD?=
 =?utf-8?B?SkRGekJ2aUEzSFNHRkx5NHkxRDBzOXRLdEtDVFhud1R0MC90NUNHdzd1dFhk?=
 =?utf-8?B?V3dRQ3lWajV6T0JoMlBVNUNLbjVCTU1icVZZL2FmVWFNQ3V1WWJaZG5LaGp0?=
 =?utf-8?B?M1IzeW9hRkJqWDh0UktGV0RuVDU1dkpWSjBNQW5DZEN3MDJwS2FvelduVXhm?=
 =?utf-8?B?ZFZqNnA0a1RnOHNMYkw4V0ttVkJROWp6aDgzcjF2c1hacVZIdHUzeGZQVzJ1?=
 =?utf-8?B?ZmRKRDBqRjVhQ0JSNXZiOEw1QXBDdm85ZkdHWHVYVVM2Zis1ektUYjFhOTBR?=
 =?utf-8?B?azhmeVM1QUt4VmtCeGVBcXdXNm9KUXExZnA0QmZESWppOTJGcHp6Mm01Z0gv?=
 =?utf-8?B?MXMvMVk5SE5oemFGcFlwWktBUGszdDlndzJqNXBMR1JLcjJVNUVKWGVYdi9i?=
 =?utf-8?B?ZTE4T28raHlTZngzaG5uOStmZDB5ejh5NVZ0TWFEZC9QbjNEZCs1WlBOcFE0?=
 =?utf-8?B?bWxFR0hwRldNK3Y3WStNeHZDWXVxWXBienRtU1B5dFdaMk1sQ0ZZdGorQjhi?=
 =?utf-8?B?ZytIUFB5c0FkQ3JCU200ckRJbDZMTjZNc3hlayt3cEtFTmpYN0Zjb01JZUJU?=
 =?utf-8?B?aURqTjkxSGZtbVhCVy9aUmp1d2tRR2E3bkREOEZnMjQyQXRXWkhEckpnPT0=?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Tjk4L2NXZVJvNzRSdUxtNWFXMVV3TGFLMG9FdW04OFFCRXV5YTVPblNJTENr?=
 =?utf-8?B?UVZpczltUVd2cDZFV0pCb2g0UjQ2QTNReGp4WlRpR056TGdMdkJjQjJ0UTJy?=
 =?utf-8?B?RW9EWmRYbFplckZEUGNOZjdBWDEvSVh0OWdnWmk2ZzkwQ3B1OG0xWVdHTGFu?=
 =?utf-8?B?YnUrYzJzUTlZYllQQklHTk91TTB6U1lIanNUSnUvN2Nib0dvVi9vZy9FZXZp?=
 =?utf-8?B?Nmlucy9MTFhwdWtiaGtwUEp3bXRNQVF6VlV4aG5SL1ZMa2hLTDZaVnNSd045?=
 =?utf-8?B?UGhkL0JjTm55V0hPNmRXZ3k4TkZjMm02U1BtczZDanVjcTFEb3E3Wm45b2N2?=
 =?utf-8?B?UGQwSmlqR29zVWdtN21pMnJsWnBiWlVTc3JteGR2MXNYbjRGa3dtRE5rZ1lI?=
 =?utf-8?B?ai91amdoRkxHKzRNdjlvckNiaFJWNWx0QWxXSUJlL3FncURMNXMybXpzblJw?=
 =?utf-8?B?MG9nT0NzT2VOQzNHZGRXbmExOXBkVEszQXlYWHFGN0VUdkNLUHF6VExOL3Q2?=
 =?utf-8?B?TEJRcWVXQWE1bnh3dVY0NGVBNFF5cFlVZnZGelpTdzlpbFVaSnVxMVZkcVhj?=
 =?utf-8?B?UHo2eDI0VjFwbmVsU2toUUQ2TnByT0lXMDY0aUNna0pYRkxrMzNRTTF4a3ZK?=
 =?utf-8?B?Sng2UDM2aENYYkk4TlRCTzQxTlliRlNiSEJWM3RtelhINlk2YXp1aTRFNjlY?=
 =?utf-8?B?N3RtKzExMWVYaktML0podTU0OTVveFNOOVk4VlBRNmhGaUg2emdkMjZ0QlRB?=
 =?utf-8?B?bVhNcktQQzlMVm4weWJVb0tRdHo5TWpEZU8vT1pCWFJETHhJVmNVR1FBRGNw?=
 =?utf-8?B?aCtMR3lHU3BzRzdmeDdKU1FLUTY1ZEE2NmhjTWlXUGl1dGdZeWFiSGprSWJ0?=
 =?utf-8?B?MUJWSHVKMzB4eE50VlpIZlUvYTFxQUtxM2pwbndGbHhrVXgxRlg2ZDIvUkZi?=
 =?utf-8?B?eFdjVk9DRHg2RTBMWWNWMFRHRHZUY0J3ei93UWpaMmwzN2FwZDkzVFdseS9r?=
 =?utf-8?B?MTRWV2NTcU9kYjdVRUcvcFZwZmU2Q2hFcGw5RUlUZXc0Y3RBN0pRL3ZsK0sx?=
 =?utf-8?B?YzIxa3NyN3FDYjY3TDY0Tk1MeXRyMVF1ckRDaEFzaVpPc2xjZVpRbU85NFhX?=
 =?utf-8?B?dzNVMW02Skd6MzVHbnZUdzZPbStLTkM4L1RrUGpPbE9Pa0dCK2U0WFR2L3oz?=
 =?utf-8?B?VE5GalJFNEo2NVNsNFBtdWhzN1YyWmI1SHBkNnRnWnJvY1JKaFplN1FmeDBQ?=
 =?utf-8?B?YTE5ZUVFTWVLKzlUUjZQT2FYSUV4U1pHZ2pSNU8zdjdIZkVoWXNXUXBlWk9w?=
 =?utf-8?B?ZC94M1VqM0pzUDFxS2hsbU9CSzlvdFM4UmhSS01CQ00zZWE2ODRKdEVaQUNF?=
 =?utf-8?B?NXlHNzlKVTlTRGZSc1lBZFFkWDF6MU1zQWNoL3RYWm5OTzBISTluSDNxbkNP?=
 =?utf-8?B?VVZqc2wyM2dLYzUzeGJ6MUwzelVjS29WWCsyYmpaeWdVWThTWElDc3huL3J1?=
 =?utf-8?B?OTB1MTF1T08xbXVSWTlodmd6TmMyRnFpU3gwRnM5V05JYWloT05aS3h6ck1K?=
 =?utf-8?B?TVVkaklhSGM3NEhweWg3cE1XMUNaUm1lSTBFR09IL0c0eUp2NzV1K0FZenl1?=
 =?utf-8?B?bDZ5QndoTHdTSzFsb2JmQmI4MytZTkI3RGZ1b056SktkVFphTmtLT1c4YXNK?=
 =?utf-8?B?cGxvM1U5bmxsL2tFSndEbWhpN2tkQnRpcGlPZStGWVM0MC8yYU9saEE4TWJw?=
 =?utf-8?B?Z1B2TVhxWEtHOEVNNEo3eHZlVFhFdnFvYkdjeFo4K2xMZzNPNTVtRmtkMWxR?=
 =?utf-8?Q?2W0PNno0YhnSLoWGOI2YsToDILY9He0haFUjk=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bd397d67-fa10-41e7-8fd6-08de5f9f0274
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2026 01:29:27.8460
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB7065
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-8594-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[outlook.com];
	DKIM_TRACE(0.00)[outlook.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[100.90.174.1:received];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:email,outlook.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1CA2AB628E
X-Rspamd-Action: no action

RnJvbTogU3RhbmlzbGF2IEtpbnNidXJza2lpIDxza2luc2J1cnNraWlAbGludXgubWljcm9zb2Z0
LmNvbT4gU2VudDogVGh1cnNkYXksIEphbnVhcnkgMjksIDIwMjYgMTI6MDggUE0NCj4gDQo+IE1p
Y3Jvc29mdCBIeXBlcnZpc29yIG9yaWdpbmFsbHkgcHJvdmlkZWQgdHdvIHNjaGVkdWxlcnM6IHJv
b3QgYW5kIGNvcmUuIFRoZQ0KPiByb290IHNjaGVkdWxlciBhbGxvd3MgdGhlIHJvb3QgcGFydGl0
aW9uIHRvIHNjaGVkdWxlIGd1ZXN0IHZDUFVzIGFjcm9zcw0KPiBwaHlzaWNhbCBjb3Jlcywgc3Vw
cG9ydGluZyBib3RoIHRpbWUgc2xpY2luZyBhbmQgQ1BVIGFmZmluaXR5IChlLmcuLCB2aWENCj4g
Y2dyb3VwcykuIEluIGNvbnRyYXN0LCB0aGUgY29yZSBzY2hlZHVsZXIgZGVsZWdhdGVzIHZDUFUt
dG8tcGh5c2ljYWwtY29yZQ0KPiBzY2hlZHVsaW5nIGVudGlyZWx5IHRvIHRoZSBoeXBlcnZpc29y
Lg0KPiANCj4gRGlyZWN0IHZpcnR1YWxpemF0aW9uIGludHJvZHVjZXMgYSBuZXcgcHJpdmlsZWdl
ZCBndWVzdCBwYXJ0aXRpb24gdHlwZSAtIEwxDQo+IFZpcnR1YWwgSG9zdCAoTDFWSCkg4oCUIHdo
aWNoIGNhbiBjcmVhdGUgY2hpbGQgcGFydGl0aW9ucyBmcm9tIGl0cyBvd24NCj4gcmVzb3VyY2Vz
LiBUaGVzZSBjaGlsZCBwYXJ0aXRpb25zIGFyZSBlZmZlY3RpdmVseSBzaWJsaW5ncywgc2NoZWR1
bGVkIGJ5DQo+IHRoZSBoeXBlcnZpc29yJ3MgY29yZSBzY2hlZHVsZXIuIFRoaXMgcHJldmVudHMg
dGhlIEwxVkggcGFyZW50IGZyb20gc2V0dGluZw0KPiBhZmZpbml0eSBvciB0aW1lIHNsaWNpbmcg
Zm9yIGl0cyBvd24gcHJvY2Vzc2VzIG9yIGd1ZXN0IFZQcy4gV2hpbGUgY2dyb3VwcywNCj4gQ0ZT
LCBhbmQgY3B1c2V0IGNvbnRyb2xsZXJzIGNhbiBzdGlsbCBiZSB1c2VkLCB0aGVpciBlZmZlY3Rp
dmVuZXNzIGlzDQo+IHVucHJlZGljdGFibGUsIGFzIHRoZSBjb3JlIHNjaGVkdWxlciBzd2FwcyB2
Q1BVcyBhY2NvcmRpbmcgdG8gaXRzIG93biBsb2dpYw0KPiAodHlwaWNhbGx5IHJvdW5kLXJvYmlu
IGFjcm9zcyBhbGwgYWxsb2NhdGVkIHBoeXNpY2FsIENQVXMpLiBBcyBhIHJlc3VsdCwNCj4gdGhl
IHN5c3RlbSBtYXkgYXBwZWFyIHRvICJzdGVhbCIgdGltZSBmcm9tIHRoZSBMMVZIIGFuZCBpdHMg
Y2hpbGRyZW4uDQo+IA0KPiBUbyBhZGRyZXNzIHRoaXMsIE1pY3Jvc29mdCBIeXBlcnZpc29yIGlu
dHJvZHVjZXMgdGhlIGludGVncmF0ZWQgc2NoZWR1bGVyLg0KPiBUaGlzIGFsbG93cyBhbiBMMVZI
IHBhcnRpdGlvbiB0byBzY2hlZHVsZSBpdHMgb3duIHZDUFVzIGFuZCB0aG9zZSBvZiBpdHMNCj4g
Z3Vlc3RzIGFjcm9zcyBpdHMgInBoeXNpY2FsIiBjb3JlcywgZWZmZWN0aXZlbHkgZW11bGF0aW5n
IHJvb3Qgc2NoZWR1bGVyDQo+IGJlaGF2aW9yIHdpdGhpbiB0aGUgTDFWSCwgd2hpbGUgcmV0YWlu
aW5nIGNvcmUgc2NoZWR1bGVyIGJlaGF2aW9yIGZvciB0aGUNCj4gcmVzdCBvZiB0aGUgc3lzdGVt
Lg0KPiANCj4gVGhlIGludGVncmF0ZWQgc2NoZWR1bGVyIGlzIGNvbnRyb2xsZWQgYnkgdGhlIHJv
b3QgcGFydGl0aW9uIGFuZCBnYXRlZCBieQ0KPiB0aGUgdm1tX2VuYWJsZV9pbnRlZ3JhdGVkX3Nj
aGVkdWxlciBjYXBhYmlsaXR5IGJpdC4gSWYgc2V0LCB0aGUgaHlwZXJ2aXNvcg0KPiBzdXBwb3J0
cyB0aGUgaW50ZWdyYXRlZCBzY2hlZHVsZXIuIFRoZSBMMVZIIHBhcnRpdGlvbiBtdXN0IHRoZW4g
Y2hlY2sgaWYgaXQNCj4gaXMgZW5hYmxlZCBieSBxdWVyeWluZyB0aGUgY29ycmVzcG9uZGluZyBl
eHRlbmRlZCBwYXJ0aXRpb24gcHJvcGVydHkuIElmDQo+IHRoaXMgcHJvcGVydHkgaXMgdHJ1ZSwg
dGhlIEwxVkggcGFydGl0aW9uIG11c3QgdXNlIHRoZSByb290IHNjaGVkdWxlcg0KPiBsb2dpYzsg
b3RoZXJ3aXNlLCBpdCBtdXN0IHVzZSB0aGUgY29yZSBzY2hlZHVsZXIuIFRoaXMgcmVxdWlyZW1l
bnQgbWFrZXMNCj4gcmVhZGluZyBWTU0gY2FwYWJpbGl0aWVzIGluIEwxVkggcGFydGl0aW9uIGEg
cmVxdWlyZW1lbnQgdG9vLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQW5kcmVlYSBQaW50aWxpZSA8
YW5waW50aWxAbWljcm9zb2Z0LmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogU3RhbmlzbGF2IEtpbnNi
dXJza2lpIDxza2luc2J1cnNraWlAbGludXgubWljcm9zb2Z0LmNvbT4NCj4gLS0tDQo+ICBkcml2
ZXJzL2h2L21zaHZfcm9vdF9tYWluLmMgfCAgIDg1ICsrKysrKysrKysrKysrKysrKysrKysrKysr
Ky0tLS0tLS0tLS0tLS0tLS0NCj4gIGluY2x1ZGUvaHlwZXJ2L2h2aGRrX21pbmkuaCB8ICAgIDcg
KysrLQ0KPiAgMiBmaWxlcyBjaGFuZ2VkLCA1OSBpbnNlcnRpb25zKCspLCAzMyBkZWxldGlvbnMo
LSkNCj4gDQoNCkxvb2tzIGdvb2QuDQoNClJldmlld2VkLWJ5OiBNaWNoYWVsIEtlbGxleSA8bWhr
bGludXhAb3V0bG9vay5jb20+DQo=

