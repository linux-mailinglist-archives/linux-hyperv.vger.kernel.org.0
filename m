Return-Path: <linux-hyperv+bounces-8749-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MFlFGNfqhGkj6gMAu9opvQ
	(envelope-from <linux-hyperv+bounces-8749-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 05 Feb 2026 20:09:11 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EDF3F6B8B
	for <lists+linux-hyperv@lfdr.de>; Thu, 05 Feb 2026 20:09:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A3E373020EF0
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Feb 2026 19:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0268313550;
	Thu,  5 Feb 2026 19:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="PrL+gh87"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazolkn19012013.outbound.protection.outlook.com [52.103.14.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47EFA279DB3;
	Thu,  5 Feb 2026 19:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.14.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770318544; cv=fail; b=ixp/wp93oeJB25zDI4fDsfk440f8cckNlGkUQMwcXzr0aIrPpEnE553UvBi+P0lVAlxJXgUZszRroOSqNGRVEQ6lRpoow5c/g6FGStMEMkCGe/eyzjRgS8yDui7VHxwPGSJaHrhUXwSF8BZZ2Ap4mxtwHYNnfJDQKqugxYEPfWI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770318544; c=relaxed/simple;
	bh=btmIslBHGNqdimB1KPYUz0xHFX9Yuc8rjSJjYUlB4Cw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ExIVYmAxYrED7RJQWzv4tmci9uWPiawLWZjZgJqm6GCzWjRPEKvZEqOQQOygSqSRvQsuglkcdLUfnw0WzxVLSasR2UNlqSYZ+2mklr8j7bVSLgtS7awQclbbGDYUBAPdMSyd1Rl4jACkDLSyKZT5fm8w0D0DZjrws7xkY3bh1KA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=PrL+gh87; arc=fail smtp.client-ip=52.103.14.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pKhZmcVTNu6eiX+Oqvfb9i4R+YWQCxagH8+oC09vvDWBVln29L1D75bdwpTxcpXZfIF2jkRlIpp1LyC3N7DT4WyAN2VHVfPB4SpyI4eic6vPbxxGv7+ZSptA0if2wivZ5vtysD7YQqReGiq4+hhm2U15bhx5XDDPHQ1hNMNQ3vhxadNVc4xyKjdCNo/QJN/+YazL/MsyK1FTzhbzrb6zZ7hVIW+KWoIVN07/41s3U53UPEWToULXYNV7OrsbAQ20H0YIh+bUPxy2dJSW0ngp/c5SG0aGTQLN9FyFzP1rkwWVcroocZg7zegL4SWaLo9RU9iUSVUTs3+LXYfRBpHEkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=btmIslBHGNqdimB1KPYUz0xHFX9Yuc8rjSJjYUlB4Cw=;
 b=QiASnVYMz2yamsgT++uyLcVhQ/OAj0jG0m6ZdyU+DCLd6H4RmwMnUO7JLk2AeYd6yolxwq3dbOkMpO6Z/tmPep3pvgk1YrDIPp5RBhUiA9VsMMXe/qYn8wIUnMeSbfX2CRJ8d1bda/Mu/JBpIPDJOYQ8DXDuWBp31kXlq1xtmmFrzTyJXXc2gkvnoLvnQEtk7gBk9P63/S8RKBX0Wcpqawgto4mjaZejfhwKXZLhaKVzYyVh34fSq7dXwaVAk/vt23YnF81lCTmXXqa13hUlpurqTDt4/mVNusjnOoh76jHlxk9gdyw/2bD18koNIdL9Bo7FUUg9aDj+6EhHl7NzJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=btmIslBHGNqdimB1KPYUz0xHFX9Yuc8rjSJjYUlB4Cw=;
 b=PrL+gh87iIhqh1nNvbbgX3/162TuGwU8MNQcp3EcmfBhPYi2lwDF3oLB4EHdfQiKF8lS3c3rhvqymnsDhocyVWOmVxOWSCYciOO/xqJRn/Qi+UJcw6lQXMDh2WpGNVtGpmkdker6+hth8Bhl8aiSmRRZJXAjv5aa7hp792hPnapTNONgQnxQvYkjeH8vS7ZVrVeZFfSZ7BqS3hQM4QuL76UP1hkKGAFgxjyBmHCfzECCVzPWmLRaa9sYHWJJSZloptjguZaP6SEOOlYcOo/WJ+mM9b5CHTNZg0mRQE6gr6SqA4EJFuhrWtmr4fgqZVMwdwyOwdeu5QCyqDlILbZMLA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by PH0PR02MB8390.namprd02.prod.outlook.com (2603:10b6:510:108::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Thu, 5 Feb
 2026 19:09:01 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9587.010; Thu, 5 Feb 2026
 19:09:01 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, Long Li <longli@microsoft.com>, KY
 Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei
 Liu <wei.liu@kernel.org>, Dexuan Cui <DECUI@microsoft.com>, "James E.J.
 Bottomley" <James.Bottomley@HansenPartnership.com>, "Martin K. Petersen"
	<martin.petersen@oracle.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>
CC: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>, Florian Bezdeka
	<florian.bezdeka@siemens.com>, RT <linux-rt-users@vger.kernel.org>, Mitchell
 Levy <levymitchell0@gmail.com>
Subject: RE: [EXTERNAL] [PATCH] scsi: storvsc: Fix scheduling while atomic on
 PREEMPT_RT
Thread-Topic: [EXTERNAL] [PATCH] scsi: storvsc: Fix scheduling while atomic on
 PREEMPT_RT
Thread-Index: AQHckSxbvhmgYaIv+0OErRpLCnikxbVwGj6AgABncwCAArlB4IAAdoiAgADQRgA=
Date: Thu, 5 Feb 2026 19:09:01 +0000
Message-ID:
 <SN6PR02MB4157A4E18CEDEB19796F21EFD499A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <0c7fb5cd-fb21-4760-8593-e04bade84744@siemens.com>
 <DS3PR21MB5735CBC7D843174F9CA9039CCE9AA@DS3PR21MB5735.namprd21.prod.outlook.com>
 <6b4933df-6af2-449c-922b-30ef8fd4c8b8@siemens.com>
 <SN6PR02MB41572C9E3650A6E581AA32C2D499A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <d9f9add2-27e9-4b17-a122-d14918968ea6@siemens.com>
In-Reply-To: <d9f9add2-27e9-4b17-a122-d14918968ea6@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|PH0PR02MB8390:EE_
x-ms-office365-filtering-correlation-id: 48b65ba5-cb8f-4a4b-db18-08de64ea0597
x-ms-exchange-slblob-mailprops:
 laRBL560oLS7IWERjHonlu/qsKr3Bu1Zq4myMP7EnjCVeR21uEGyc6Ar7bcOfCQ8YHxY/ny7bSXB04pcaRjRMMmU7Yjcb7izwXoV11j6jprUnNN41NgJzjPUpS02HLwXw3ehTarle/xYpZWeIFSosj3JctttS0/cryW1XBwK+zxMIV7llg36m0C63EQeqRIwtU8GjVJm4voHk/hzL/ZxgjnqGOcPx5CusYr6DRUzVOwncywRBL09ONtTIt2OAmFHKEY5PbdKe8sYpyD+YqnqT8ugVacOUuKSXAM7Ydbp5/CVXGZ2ujlBhx9JnduEiJZmijnoxgzIBf6fBsETXt6pUN2nzmPu/pc0lzvePOTuHtTVDXJWpVT1nErkeNEbslnJLfaK36LTas5w7XorKXuxugINcOvwhuF1Tal6s+Cmd84u05IBeukpIi/j0TEC9A2ZV4Bywvkm+8R2PUYMATJVh3knhS8JdPb6PmdHJrAP3NHDMhUnEgKpM//cGEQJMnwRvzmIC8bEceGFUSpVrph6t/Id2o9FLoxXn1ZHey3GMSzpC7zsw11NsQXMXV/TN017kzZAcwPBDm6DBGG5GRMV79AMBuyrhruT7yvEqiAFc0e2Z2zd8Pbg7CQ1NOx2knpGSYKDOgemJQDpxfHC53loK7c6i7NdBMQKvWVTYmbCof3FtOFIjtkTEQiK1bLv5PNZ0mZLT4b4ti0bzyoCwlFZIC8Gwkglg1O1H6oz5DQ7E2uxAPHOrM4/KQ+L0m2RG/Tjj7fvzlNQ9WxRX/jfejZTMlwbK7qyv2bC
x-microsoft-antispam:
 BCL:0;ARA:14566002|13091999003|51005399006|31061999003|461199028|8060799015|19110799012|8062599012|15080799012|440099028|3412199025|102099032|40105399003;
x-microsoft-antispam-message-info:
 =?utf-8?B?QXBOWCs3SGM3T2ZuYlo0eXZPbm1lYkFNejRPbys0M0d5UGNydFhMQmJQZms2?=
 =?utf-8?B?cVZrSzRJa3lsSWhrZTBxSDhPclFTNWU0QmdSSWZXRklZbWpPT1JOT0xoQ0FO?=
 =?utf-8?B?TW0rbU9mR1VCcXVDcVp2dm1NbHl3WWFMNm81RFJaS0N4aUdEQTFqYlE0SWRC?=
 =?utf-8?B?VzA5UjYzdzl6SXdVWnlWSW1VSXNjbjNwSUVJY1hSRHVVTGc4OEhsWDdqaUht?=
 =?utf-8?B?R1lsRVpuN21PbE9tUktBOHRQV05NbWVxQTVuU0NSY2dCMzJJNFVsR2JEVWJX?=
 =?utf-8?B?MGxRa1lIaElNR0ZROWhXUkVmZitSV3d4VlJraU1NZmRrdFZ0ZnFpeWRMZmxj?=
 =?utf-8?B?L2UyQzBqT2RJdEtmNWZQcTlMSlN6b2t4a3NoY2RtMGRyc2NUSzNlaWwxeVhp?=
 =?utf-8?B?VnB5S1NWeXA2RVErWXErMUd6ZGN1UGNnbVY0NkVGZGlBVStrd3hKdVl5Ykhk?=
 =?utf-8?B?NnBpcHRPS1ZYZW1jNUdXYkwzNkk5S3hPbGJtemJQNWVNRnFjdGJ2amhSWlZS?=
 =?utf-8?B?TE5DWENRUWJRVExYUEJhN2FWSDRpRGU3WDhIQkVxSmQxdlQvY1A0eGFsUno4?=
 =?utf-8?B?VTRDK0U4VWlNZGV3Y3V4QkRKZGJoTVErN3piRHJBKy9MNDRWcXRkV3hvNVBt?=
 =?utf-8?B?NjhkRE5XcGo4NHhCS0xaaGNEOExtbGVTdjJ1bHNHRHo5Q3V3R2o5dHQ2RkFO?=
 =?utf-8?B?akUvTmJ5T0lHdHZPUVkvZmphWWNWcHB4ZTM4cnB2M01JTEpiVXlZM0RVOU9L?=
 =?utf-8?B?M1llRTR6dVk1Sm5ySWJZTFdJeStoanlHSVE1OVltWEIzcSsvZ2x4ZDRrd2NF?=
 =?utf-8?B?VEw2UWpxWkhyRGduWlEzS0Fnc2JVQWsvdThiMWk3enlpTWw0Tm1KUWVRTGQ2?=
 =?utf-8?B?Nnp3QTF1dkZpVHkwc3RtNVE3MHFPWkE1VHUvNmtYc1oxRXdNRUNLTjBaY1Ey?=
 =?utf-8?B?M0dSTzUraStYMTlWNlZoWEF5REhMY0h6dnRQQTVGNXJWeGs2bjd6QlhtZVll?=
 =?utf-8?B?MldQVWpDTFRtcitHTytWYmNDNngwSlpycENyS2VJSyszbVNCaXEyMjRuSGdm?=
 =?utf-8?B?R2lxK0FsZERudTBhSmVZMzBiMVZHSm5uS0I3THp0Tk9ac056bTRjZlM4SFpS?=
 =?utf-8?B?MHJ4T3gxWktyV25LSVBOMjhuSzBFZW03WVlJbFp1U0FhKzNIcVV4U203Y1o4?=
 =?utf-8?B?TzhvNVArVTBmbXI0eHNRb0xjVGtMVEhKTlRpdnYwWE4rb0srMkUrUGRwY2NX?=
 =?utf-8?B?czJtaW1Za2habWh4NEJnaThnVUFqSzcvVnkwZUwyWlBDb1VPL0lTTUFOeGxl?=
 =?utf-8?B?Kys2QnB2Q3pJbWpjei9tanY5b1FiVHVCbXNpendLOG5TMGFSYmw3bjRDZ0ZD?=
 =?utf-8?B?VG16MWRmcWJUWlZZajFrSUNrRjYxdTFubzNJZlIvZFZPRU10V1NHMkVlOGta?=
 =?utf-8?B?dWZCbEJOQmpNSGQrWHViK2xwSWtoUGpqNTdGNmZNaG9CcUdsZmFLVHFhOUVz?=
 =?utf-8?B?bEp3cFpDcStXOGViVFA0WUtCTE5Kd0xOUmVGQlM0SUoreHFISmZ1eXpOa0Vx?=
 =?utf-8?B?aCt5R25uK1Q2V3ZubHVNWVA3NEFQVWdiTytodlk0L2dsWUNvbWhndlFFcW40?=
 =?utf-8?B?bG0zN2NzQzNEc2c3NXRsUFhLdzc2TGc9PQ==?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WEIrVzg0STJOMmFCVDVUZDV2d2U5RDB6Z1puOXJSU2VrOVYwOG9WbGxkK0Zn?=
 =?utf-8?B?RmhGbzZXbll0eGg0VlZCRTVRaDVzNURKTTFWLzIwdXpHMzJOYkxtTXEwek9D?=
 =?utf-8?B?QUFLR3FoT0duOWtYbFUwTEtZaHJxSUhpMTZvaHdMTU1aWjdHRnVIdjljNnYz?=
 =?utf-8?B?bUh0bExiQ1RiejBqSmlTVmJNVlo5L283azh4RVprMGtFL0VOTWZQbWMyODVO?=
 =?utf-8?B?WkxYeXpDY3lyNVFvYUhhOVVJZlNpY0psZ2I5d3h6ZzFScmhOYVA1RzFXbzha?=
 =?utf-8?B?Z3dmcEh5L2F0S29jQ3hYeGZTTitwVkRtaTV3bWg2WlB1K1ZZMytDTXpBcGFx?=
 =?utf-8?B?b3UvN1ZVOVVocytEdmlZOHgxMDA5UHNwWnpNbWNUa1B1OEJKeVAvZ21uYzlK?=
 =?utf-8?B?WXM4aFBhZ3l2OHM3N1oxaU1TMzBESzFiR1RUS2NTMHVpbTdIa1ZBYTRZaHFy?=
 =?utf-8?B?Z3pweGoyMk8vNDdSV3g5aXhjelBET3k2bVZlQ0RucDZQbmkrZmtkdkF5SkJP?=
 =?utf-8?B?eExOMUtXYnlpL0JuN0hSYmRXdjJyUjJBd1lRREZORTlPZkd4cElOdFhJNHBD?=
 =?utf-8?B?NkJaa0JDWW1wakZJY3VQdVgvUjNtdVd0NytwbG1PU0pKcGk1cHA2ck1uTTZH?=
 =?utf-8?B?cHFhNGdESEdEQWpIVVpKSlBGeVpJMmV4Y2VUZENDdEFhSWdCcER0OGlCRDlt?=
 =?utf-8?B?MGFxVzFKYzdKRWdSS1k3aW5sdCt2cWt6WkNwMTE5MjBiUUlabnZ5SHF5SWl1?=
 =?utf-8?B?VmdYQ0RqN0daZXFmYUp2aFl4bXpkZXd3TkFCc0daelRYYkxGb0NNckNjVTVQ?=
 =?utf-8?B?eXJVL01VaEpKektrRUlVWllNZHNLQ2tmZDBBQ2g4aGJTV1J3SUJBWXhLUk9T?=
 =?utf-8?B?eHgyMWtva1ZIWTI5cnVvd3ZIME1EVDIvQWplSzNDQllXWTFuNWdyMG9lN3Av?=
 =?utf-8?B?MTQ1aEoyNEFqRUdrd0ptbDVCWVlWUm01OUdDZkIyU3Z2bTgvWWpqbHphaTMw?=
 =?utf-8?B?K0VIOHloR01jM1ovNUJ5S0ZvUDMzVVJZeFN3dWZGMTJMK01WcUI2ekJFNnc1?=
 =?utf-8?B?cTF3OUtLM3JZUFIvVDRhVHB4cG5UeGxEdUVSZEl0SzRjWk94OVplK242Mnhx?=
 =?utf-8?B?bnluYmRRZi9iLzBvOThVdDVzcjQrdzNpL2d3SG9wdW5QVk9FV3RnclRtV0VU?=
 =?utf-8?B?N2I5N2pFVnF2N2NhejBOT3F3MkFsM3pER2JZRnpHRDFteVVIQjF0dkpiaTFV?=
 =?utf-8?B?RjBsdWVaeE1qclltQzFWYktLWFVucWhIYzBZdkhJUGg0RTVFMjc0UUhrczdq?=
 =?utf-8?B?MDdMQjNvK1Y5V2svNk9sZ1d1anBkcUVPcWMrc1Z4S3haS0YweHhqK3BkUlQ1?=
 =?utf-8?B?cEZWSFkyY1orL0hJTEJIM3BFcTZZK0duM3VKNWRjSjZFWHB5QnVYbHBuN3FI?=
 =?utf-8?B?SE9NUTdZMCtJSVZyUDV1S2pUYlZxcWtaZXNXNzY0SjRMckVFQzROWU00RTV5?=
 =?utf-8?B?YStFQmw0QzVQWS9JdDFBc3lMZUQ2RVpTQ3hlS0FYRXQ5RWdvRWZmeUxld013?=
 =?utf-8?B?T2lXTkxrUjRCMXRWR0lLR1dVQnkyWnJia0FNSlFnS1hJbnpqQ1o3U0xQS3dN?=
 =?utf-8?B?am5Vd1M5YUtSRjAyazE2ZVJjZjNycEZQYjdhWWxsZkplUTZwMlM1dHVWNFM5?=
 =?utf-8?B?Qm9YY2xXSllnamxOVVNwdUtKdStyZlpyNXdvZ0pEQUt3Q01hQ0g1RWMrcHVW?=
 =?utf-8?B?Wk5mTmppWityRnJVZXlUUHdEZitpdlBWaE0vUGlVZXNoZXpJWHhBbGZUQWRL?=
 =?utf-8?B?c2NEZk51ZFN1d0xoWUk5MGZScVFoNzhjbzdEaWFrVTRpMmo5QzNzeDJQUmFi?=
 =?utf-8?B?UmNVeVpQMHBjM1F5Q1pISDNtYTV6T2FIZU5rOWxkRTJWYUN6UUFORVdHaHcw?=
 =?utf-8?Q?ueXxRjX7nq9kpf68cFqanH1Zn6Aq1TvT?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 48b65ba5-cb8f-4a4b-db18-08de64ea0597
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2026 19:09:01.1738
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8390
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	TAGGED_FROM(0.00)[bounces-8749-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[vger.kernel.org,siemens.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[outlook.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[siemens.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,outlook.com:dkim,SN6PR02MB4157.namprd02.prod.outlook.com:mid]
X-Rspamd-Queue-Id: 4EDF3F6B8B
X-Rspamd-Action: no action

RnJvbTogSmFuIEtpc3prYSA8amFuLmtpc3prYUBzaWVtZW5zLmNvbT4gU2VudDogV2VkbmVzZGF5
LCBGZWJydWFyeSA0LCAyMDI2IDEwOjM4IFBNDQo+IA0KPiBPbiAwNS4wMi4yNiAwNjo0MiwgTWlj
aGFlbCBLZWxsZXkgd3JvdGU6DQo+ID4gRnJvbTogSmFuIEtpc3prYSA8amFuLmtpc3prYUBzaWVt
ZW5zLmNvbT4gU2VudDogTW9uZGF5LCBGZWJydWFyeSAyLCAyMDI2IDk6NTggUE0NCj4gPj4NCj4g
Pj4gT24gMDMuMDIuMjYgMDA6NDcsIExvbmcgTGkgd3JvdGU6DQo+ID4+Pj4gRnJvbTogSmFuIEtp
c3prYSA8amFuLmtpc3prYUBzaWVtZW5zLmNvbT4NCj4gPj4+Pg0KPiA+Pj4+IFRoaXMgcmVzb2x2
ZXMgdGhlIGZvbGxvdyBzcGxhdCBhbmQgbG9jay11cCB3aGVuIHJ1bm5pbmcgd2l0aCBQUkVFTVBU
X1JUDQo+ID4+Pj4gZW5hYmxlZCBvbiBIeXBlci1WOg0KPiA+Pj4NCj4gPj4+IEhpIEphbiwNCj4g
Pj4+DQo+ID4+PiBJdCdzIGludGVyZXN0aW5nIHRvIGtub3cgdGhlIHVzZS1jYXNlIG9mIHJ1bm5p
bmcgYSBSVCBrZXJuZWwgb3ZlciBIeXBlci1WLg0KPiA+Pj4NCj4gPj4+IENhbiB5b3UgZ2l2ZSBh
biBleGFtcGxlPw0KPiA+Pj4NCj4gPj4NCj4gPj4gLSBmdW5jdGlvbmFsIHRlc3Rpbmcgb2YgYW4g
UlQgYmFzZSBpbWFnZSBvdmVyIEh5cGVyLVYNCj4gPj4gLSByZS11c2Ugb2YgYSBjb21tb24gUlQg
YmFzZSBpbWFnZSwgd2l0aG91dCBleHBsb2l0aW5nIFJUIHByb3BlcnRpZXMNCj4gPj4NCj4gPj4+
IEFzIGZhciBhcyBJIGtub3csIEh5cGVyLVYgbWFrZXMgbm8gUlQgZ3VhcmFudGVlcyBvZiBzY2hl
ZHVsaW5nIFZQcyBmb3IgYSBWTS4NCj4gPj4NCj4gPj4gVGhpcyBpcyB3ZWxsIHVuZGVyc3Rvb2Qg
YW5kIG5vdCBvdXIgZ29hbC4gV2Ugb25seSBuZWVkIHRoZSBrZXJuZWwgdG8gcnVuDQo+ID4+IGNv
cnJlY3RseSBvdmVyIEh5cGVyLVYgd2l0aCBQUkVFTVBULVJUIGVuYWJsZWQsIGFuZCB0aGF0IGlz
IG5vdCB0aGUgY2FzZQ0KPiA+PiByaWdodCBub3cuDQo+ID4+DQo+ID4+IFRoYW5rcywNCj4gPj4g
SmFuDQo+ID4+DQo+ID4+IFBTOiBXaG8gaGFkIHRvIGlkZWEgdG8gZHJvcCBhIHZpcnR1YWwgVUFS
VCBmcm9tIEdlbiAyIFZNcz8gRWFybHkgYm9vdA0KPiA+PiBndWVzdCBkZWJ1Z2dpbmcgaXMgdHJ1
ZSBmdW4gbm93Li4uDQo+ID4+DQo+ID4NCj4gPiBIbW1tLiBJIG9mdGVuIGRvIHByaW50aygpLWJh
c2VkIGRlYnVnZ2luZyB2aWEgYSB2aXJ0dWFsIFVBUlQgaW4gYSBHZW4gMg0KPiA+IFZNLiBUaGUg
TGludXggc2VyaWFsIGNvbnNvbGUgb3V0cHV0cyB0byB0aGF0IHZpcnR1YWwgVUFSVCBhbmQgSSBz
ZWUgdGhlDQo+ID4gcHJpbnRrKCkgb3V0cHV0IGluIFB1VFRZIG9uIHRoZSBXaW5kb3dzIGhvc3Qu
IFdoYXQgc3BlY2lmaWNhbGx5IGFyZSB5b3UNCj4gPiB0cnlpbmcgdG8gZG8/ICBJJ20gdHJ5aW5n
IHRvIHJlbWVtYmVyIGlmIHRoZXJlJ3MgYW55IHVuaXF1ZSBzZXR1cCByZXF1aXJlZA0KPiA+IG9u
IGEgR2VuIDIgVk0gdnMuIGEgR2VuIDEgVk0sIGFuZCBub3RoaW5nIGltbWVkaWF0ZWx5IGNvbWVz
IHRvIG1pbmQuDQo+ID4gVGhvdWdoIG1heWJlIGl0J3MganVzdCBzbyBiYWtlZCBpbnRvIG15IHBy
b2Nlc3MgdGhhdCBJIGRvbid0IHJlbWVtYmVyIGl0IQ0KPiA+DQo+IA0KPiBJbmRlZWQ6DQo+IA0K
PiBQb3dlcnNoZWxsPiBTZXQtVk1Db21Qb3J0IC1WTU5hbWUgIkRlYmlhbiAxMyIgMSBcXC5ccGlw
ZVxjb21wb3J0DQo+IA0KPiA8U3RhcnQgVk0+DQo+IA0KPiBQb3dlcnNoZWxsPiBwdXR0eSAtc2Vy
aWFsIFxcLlxwaXBlXGNvbXBvcnQNCj4gDQo+IFdlbGwgaGlkZGVuLi4uDQoNCkkganVzdCByZWFs
aXplZCB0aGF0IHRoZSBIeXBlci1WICJTZXR0aW5ncyIgVUkgZm9yIGEgVk0gc2hvd3MgQ09NMSBh
bmQgQ09NMg0Kb25seSBmb3IgR2VuMSBWTXMuIEkgZG9uJ3Qga25vdyB3aHkgaXQncyBub3Qgc2hv
d24gZm9yIEdlbjIgVk1zLiBUaGUNClBvd2Vyc2hlbGwgY29tbWFuZCB5b3UgZm91bmQgaXMgd2hh
dCBJIGhhdmUgYWx3YXlzIHVzZWQuDQoNCk1pY2hhZWwNCg0K

