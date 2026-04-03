Return-Path: <linux-hyperv+bounces-9941-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cHakJJMqz2mmtQYAu9opvQ
	(envelope-from <linux-hyperv+bounces-9941-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 03 Apr 2026 04:48:51 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E66BB390785
	for <lists+linux-hyperv@lfdr.de>; Fri, 03 Apr 2026 04:48:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A4ADD3003300
	for <lists+linux-hyperv@lfdr.de>; Fri,  3 Apr 2026 02:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A25F296BB6;
	Fri,  3 Apr 2026 02:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="iAhbGAAJ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azolkn19011070.outbound.protection.outlook.com [52.103.23.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B291624C0;
	Fri,  3 Apr 2026 02:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.23.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775184529; cv=fail; b=W2I2kSyAs5IxIBZYivBoa6pyC+hGwGRSDHFQkRMQdheWK56n3rIzrItYH11pD2pivehiDRmSW6G4VUSxX+pTo0uBzXoL8RXhjLoREB90yDTUdZjfKyPHqy8gZGWomg5eE726sl9mbAfXQqlM32YY0Ox7pu3KH8NkMqULyihml7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775184529; c=relaxed/simple;
	bh=kuBW6cDTwEzgTo1X4gsyvVzCEo9pXL+lEW5l/vFT8i0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jWO0mWsIhXxrKwX530vgSvhYQXzPwrio+hfWYYL2TugjywOtaP6zG1pI9dTJkOKxx9QiKPKH/FEnQDGkmtjKGorAunMBr2ClhvrXgM3R+iD9+g7Yks7gDAIXBwNwwflarK2/7tI+m8DUEvEGjyRwpG1k29O0SCqqBv5HTspVuqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=iAhbGAAJ; arc=fail smtp.client-ip=52.103.23.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uQYezw/FRbKLo4uDmCYhgjRst9AT2+Gxd764vrylRen0t8poxGDUSlF1s+78bQZ1g7+MVR/rHbWH8VYdFAzWhWOswW2E1Z9bqO4LJr8sQubfYWPfU71llmZH+u7v37+3tppIgmv1R58VhEm25lkvWBVe40vOiiGcWYZD2RQnq3xQUJz1mohxCXcMdAkJYYTeC/Jj59r0Z82vsDXfyR70ELFiljmx8y/Z09SeolE2fzpYtupIRWDr1lnwAlREoar3a+JX9K+gc4nmc8k34SExdEGPMv7aI4dkB1B1+pJjLQNIBy6eMllYJM/YDnC6TFUPvn3H2c3nck/EKKy3tVTJ/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kuBW6cDTwEzgTo1X4gsyvVzCEo9pXL+lEW5l/vFT8i0=;
 b=OzQWcZjD59nMORMIMK7BZotyP9SEAmkoMWghUooapkhxMdRjaCWEqIh5XS5/uarrcnRjhjr+BlkoS5Q+bCg7qS+ySoSUKBplx6U9Z1c2/x9d36UHqgizmlF+Ay/MBwQdUF68/Y8kAiIsjXuLCahrmrMBxn3spgTDBNKtENkv8OQJglPSIKFE8IntqUvf0Q1NFjcM0CYMcdUBzbwRUQKRqGdi1xreRBXs7wzqrYvr5Z+dqLoYY7KjZQ30LMBPNkZSZVWv5uqH8IqAzOebxjslGNzG+ILm7GRQzN/yKGAeMHPT9nv+k5O+JLEGBuylrXYL76G7r+AAfdlW4B530WDzcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kuBW6cDTwEzgTo1X4gsyvVzCEo9pXL+lEW5l/vFT8i0=;
 b=iAhbGAAJl+XtneZliyCd1ukUyJ2sCc4b+9BVZZ2yEkQNZdujnp32GOArddwS0lpfflHvgjEdhQu8qcIMpUKUeJuPamCPK0qm/04PcNU/0vh/UrDxQACebJkp+AAB1J54EpPtylB2EyruaRqicO8fSVoKPRKPDAoH8VF2knwos6yzsjgi6DV6XNjPjrQLtlnlpLBQa026I3Br/jmVy1AdEXUHDV9sKOLeiEjLh0Q9YM+12n+/rjWFAh71QmdrabSTHaCtF8D6dkuBv0uVCIMTg0uKuphx9aKILz1Y5JGAVVpEvk4Ph8YJ0SuAiV9/+p2xSMF7AfrR+kRIIZ8pcFQg3w==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CO1PR02MB8521.namprd02.prod.outlook.com (2603:10b6:303:158::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Fri, 3 Apr
 2026 02:48:45 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9769.014; Fri, 3 Apr 2026
 02:48:45 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: =?utf-8?B?VGhvbWFzIFdlacOfc2NodWg=?= <linux@weissschuh.net>, "K. Y.
 Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei
 Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Long Li
	<longli@microsoft.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 4/4] drivers: hv: mark channel attributes as const
Thread-Topic: [PATCH 4/4] drivers: hv: mark channel attributes as const
Thread-Index: AQIA5n8utbFNLZq9HsGD5u2/wbCFbAJW609qtXGifXA=
Date: Fri, 3 Apr 2026 02:48:44 +0000
Message-ID:
 <SN6PR02MB4157DBB4619BDB6688F78848D45EA@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260402-sysfs-const-hv-v1-0-a467d6f7726e@weissschuh.net>
 <20260402-sysfs-const-hv-v1-4-a467d6f7726e@weissschuh.net>
In-Reply-To: <20260402-sysfs-const-hv-v1-4-a467d6f7726e@weissschuh.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CO1PR02MB8521:EE_
x-ms-office365-filtering-correlation-id: 6a7907b9-e83b-424b-268b-08de912b85e5
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799015|8062599012|41001999006|461199028|19110799012|15080799012|31061999003|13091999003|51005399006|37011999003|440099028|3412199025|4302099013|12091999003|26121999003|102099032|10035399007|56899033|1602099012|40105399003;
x-microsoft-antispam-message-info:
 =?utf-8?B?aFRldXl2cktyazVCbllnTmUrcWR4eDlxMU1LL0F2LzBGSzNxY1JYOTJqUDNK?=
 =?utf-8?B?QzkyL0pTV1lHSU5iWVVFWWFCMzkrNEhMaTZ3cFl0QjFjQkcySVNZTWhyeEcy?=
 =?utf-8?B?Rm4zbC9DcjRyYzlDREV3U2JXMno5eDNCblNkVGthemZJWDJORUJyUlB2T3JR?=
 =?utf-8?B?a05pR1RBbzZla1NENlRMUlgxWHBiRWNLWGtkRlVKTnZpdWlKeUt4VGFEbjE1?=
 =?utf-8?B?ZUVOY0txSnBobHFWL0RkKzFBVUFPUjlzdHozYlBUOGVtT0pvMnQwSnNEbXdR?=
 =?utf-8?B?UlppSjBCOGxwKzMxaEJTSXZHNThvTWZiYVVEbnJwZElXTHQ0TjJJc29qbXhi?=
 =?utf-8?B?dlAyb1orWXRQN2ZsZEJiTFByWGtQNS9xSVg3UXNHMzNhUG5hM3o1SWRSa055?=
 =?utf-8?B?YUZ0Q0E4TGhUT0ZTQllIcm9HSnc3UFozSTB3dFZIOUlUU0RVSGZMeHdLVkJ3?=
 =?utf-8?B?Nzd4TzJYa0NvRUFremdtVVN3cnJnelUvS2RRNlRaSjdPQVNnTzVMUmVBKyta?=
 =?utf-8?B?VnlTcVVLQlZQR2tYbjBHYUZybE5VQmsvMkxKRGJvTi9hYVJKbVdrQ1hibElP?=
 =?utf-8?B?cE5abEhSL3pLUnVGYmpmRytoUjlEUkJzVWh6dGIzS016UHZ3dEJZcFJBNzFY?=
 =?utf-8?B?OGVweTdnUlFKOTU3K2ZZMkp4U3BUME5uV1dpZmZ4dno1R2tkdUU5dFVJSm1i?=
 =?utf-8?B?b3lUUGNrdnJEMU1BQnlSUGFSOVdzK3pCVHc5VG11MGJrQ0VoZzU1WUxrQkZs?=
 =?utf-8?B?L1RIMFRaZWxzMk8weVFvU2gwTlRxTmFjcnlKdmYwbGIweG14cGkyVHhvUzh4?=
 =?utf-8?B?RnlzdDFhZ3IybE82UFQ4VGczU2hYT2ljTHFSM25aNTRCNzZvTTE4aXEyOFRN?=
 =?utf-8?B?ZlhBVlVqeitrbEJVQWlhUTNTMHBJZTNGT1ZGOW5kaEowZElFUG5zbTRvMW04?=
 =?utf-8?B?VG5MTVR0NHd2SlVzTzFaSHlzSGRRUC9XNzBUaXE2UFZ4THBGcEt6VDMxNXhI?=
 =?utf-8?B?Zmx5Wms1NG1QWDJLZ0ZEeVVQdkVKSzhEaTdrK2k3T3NrM052dm9XTlY4Q24x?=
 =?utf-8?B?N2FPa25vWHZiSXl4VXRWdkQ1LzMvUkhXKzl4MitleXlxRXNPSGo3Zmh4SWs1?=
 =?utf-8?B?VUJHMHkvRW15dVEwempWSHJZT2RtOTdDNWU0SWt4NU5mbmdwMWh2dGlKRnFE?=
 =?utf-8?B?SkFEQmxaRFdBQmtkeFBmRmEvMDdPWTBGZExCb0R5NUVpSENsUlBmM01sNFEw?=
 =?utf-8?B?R3pUSHhXclJSZ05jOHVJc2R2bnlLQ2ZhN29mUEJCSmxMSWJjeDJmYjdWYjBL?=
 =?utf-8?B?eDNhOEZOMEZwMmhTQWIvMlFWUlRjQUppU3ZqQ3NLazNhT3cvMSswK0dnek85?=
 =?utf-8?B?VnprWnF6VEVlTUxwcXkwUTQ4UTl6dGhDWXBFRk1QSzM4Tnl5M0VwZ1RHMmVn?=
 =?utf-8?B?S2lRTmN4Z2hreDQ4ekdQSmtETVRjeit1YmlIMHo4U2NseS9xSGljV09tdFJH?=
 =?utf-8?Q?XscGgXY8ya99QYRSiu18yuGrNXG?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WURtTU9MZ3NiVzNQVXpocjhQUnFDSWhsdUMxeGlBakI2ZVFvRVR4N3cwK21r?=
 =?utf-8?B?ZDkyME5OT3llYkYvQmNvNG1QQnlPTWxtb3NPdWl2VlExQzlGMUFjVVJnRDhJ?=
 =?utf-8?B?Y1d3R2F3QXZDbjUyRC8wdGFFN1ZueUZnQi9UYnNJamcxOWp2ZE9wbTlNc0RP?=
 =?utf-8?B?TDd4NHBGbU10Q1R2UlNidWE2NlVFM0RqNFNTc0Mzd1pwakxDZVJvaDZpaXNY?=
 =?utf-8?B?MXI2WDM4Ni9xNklzTWptb3Zla1VoWmFOUHpDZ0xkTnlvdGtDWXlyRmxaYmxr?=
 =?utf-8?B?UFpIRlptbmh0UHJYeGhEZHJYMGNHc295TitzK0IwMk9Sdi9aVmFFRHQ4dWJo?=
 =?utf-8?B?V0k3YjUrNkpNSXVjekRxVTlwa2lYcnlnaDlQQWt5dG83c3lIbDFCa09HZ1BX?=
 =?utf-8?B?a01BVkRnL244dUtOdnNwbnBSSS9SZGN2ejVFZlVMNEtvYXFCVUlHRzRUMHRh?=
 =?utf-8?B?dGNWenJTdDFPVkJsR3VybVg3N0xYZ3lkVTVDWXJuNThSV3BvT0FvNjl0OGdV?=
 =?utf-8?B?OVlnSkZENldyVlFlR05BSTVBdi9WeTcyM2pwUHRreW1Wa0ZQTStOMFp3N3hE?=
 =?utf-8?B?eXZBOFhZV1hHWFVMdjcya1poeURzR0VoUisybUZ3NXBZN3ZOZTFFWkNVQnNt?=
 =?utf-8?B?NnZZZU5pZ3ZGeEJLZ0tjTzlUUnllWnZzZHpsNk5PMFIrZDFuVk9xWUpjd2lO?=
 =?utf-8?B?OGthOVJvaUh2Tm5wQWJKOXlucFhlOTFEeUd1TStGZnZtLzhab3Z3b2k2Ulor?=
 =?utf-8?B?NTJUa2Vsd3J5YTl5LytGS0t5MXorcDlnOWhUNDl2U0hHQVFCK045SGhNNXNZ?=
 =?utf-8?B?aHA0YWhEcHVXR3pVVEJxVTNuaVNTUnNLTG44aDhEMTJ0YkJtZldvNWJQRTcv?=
 =?utf-8?B?dUJIcmhHblcxWHVXM1FTa3ZEUmFHM0wwRk1vRE15bitYb3QxVEl6SEJKb1BS?=
 =?utf-8?B?ZDBlSkxwaThlMXR6b3FlOWpGQjB1eHA2cTc1SkFEc0wwdFdVN005VjRuSEhs?=
 =?utf-8?B?YTdmc3YyWXBEaldHenI3eEpaZWRLOC9xWkgzVmEyaXpKS1VTWHE3ODl0MjVP?=
 =?utf-8?B?d1o2S3dIazRIMEw3V25panlXNk5WZDNLTHNwdWhieVZFbnFGcitZMmZtUllq?=
 =?utf-8?B?cmZCWTFEeFAwa1BlWXFwb1dHR3VPdjRpdjF1djE3UXVIWjZ4MTNGRlhsVnd0?=
 =?utf-8?B?eWxaMk1XS3p3Z1lBaGdpaTMza3pveXhoWHFoUHFCV0p4NUtkcVU4ZkpXVEc5?=
 =?utf-8?B?OENuYWw4bnFpYjZWWUplOTQrQ2tBejZlaXpEeExnTVFWZEw5NDNWZEZHenlq?=
 =?utf-8?B?RTFudGJRTzQveldDd3Q0Umk5eE81cGpIZzBuMlZmVVBrVFlRaHE3enlXTUYw?=
 =?utf-8?B?NWcwZmZhZitpZmIrZ0Z1SmZVWmZoZTlOY3ZxRDZIN3JCc3VPTStjOUZYNzFX?=
 =?utf-8?B?MDQwa0dvMWdMRVRMN0Z2YXVCbGRjZUZZZ3dtem5JMDRWRS9waVlmMFpRNUVQ?=
 =?utf-8?B?bmttR2EwSkMxSlJBdlRjSlR3cWZDWlN6TWJwQW15V3I0d3MyQm4yeUNxQ3Na?=
 =?utf-8?B?c0xMNjhheHUwaUNmRThYWTVWZXVsNG5DOWYxVmxwaStndHIvN1o0YjAvRjAy?=
 =?utf-8?B?MzBtWmUzc0IxamZGQkV4TE5VNWFYWDNrb2htS043U0Irc1kra0tPQ0U1VnAy?=
 =?utf-8?B?VWVLRW1nWGZmb3ZBTU5GM2xlaWp2NzkrVmdyRmpXbUZERGtEaVB0THVUL1Zi?=
 =?utf-8?B?ZjFSY0E3dzE1bEJQYWlSd21LWmcyMkFyRkFQWWFGcmtXcnY2RHIrMFFZQ2h0?=
 =?utf-8?Q?r9eh39Sm9G+/UKQvq7xQrruimmLv1Mx5j2EXQ=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a7907b9-e83b-424b-268b-08de912b85e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2026 02:48:44.9182
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR02MB8521
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-9941-lists,linux-hyperv=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.989];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,outlook.com:dkim,sashiko.dev:url,SN6PR02MB4157.namprd02.prod.outlook.com:mid]
X-Rspamd-Queue-Id: E66BB390785
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

RnJvbTogVGhvbWFzIFdlacOfc2NodWggPGxpbnV4QHdlaXNzc2NodWgubmV0PiBTZW50OiBUaHVy
c2RheSwgQXByaWwgMiwgMjAyNiA4OjE4IEFNDQo+IA0KPiBUaGVzZSBhdHRyaWJ1dGVzIGFyZSBu
ZXZlciBtb2RpZmllZCwgbWFyayB0aGVtIGFzIGNvbnN0Lg0KDQpBcyBTYXNoaWtvIEFJIG5vdGVk
IGhlcmUgWzFdLCB0aGVyZSBhcmUgNCBjaGFubmVsIGF0dHJpYnV0ZXMgdGhhdCB5b3UgZGlkIG5v
dA0KbWFyayBhcyAiY29uc3QiLiAgSXMgdGhlcmUgYSByZWFzb24sIG9yIGlzIHRoYXQganVzdCBh
biBvdmVyc2lnaHQ/ICBUaGVyZSBhcmUgYSB0b3RhbA0Kb2YgMTUgY2hhbm5lbCBhdHRyaWJ1dGVz
LCBhbmQgdGhpcyBwYXRjaCBtYXJrcyBvbmx5IDExIG9mIHRoZW0gYXMgY29uc3QuDQoNClsxXSBo
dHRwczovL3Nhc2hpa28uZGV2LyMvcGF0Y2hzZXQvMjAyNjA0MDItc3lzZnMtY29uc3QtaHYtdjEt
MC1hNDY3ZDZmNzcyNmUlNDB3ZWlzc3NjaHVoLm5ldA0KDQpNaWNoYWVsDQoNCj4gDQo+IFNpZ25l
ZC1vZmYtYnk6IFRob21hcyBXZWnDn3NjaHVoIDxsaW51eEB3ZWlzc3NjaHVoLm5ldD4NCj4gLS0t
DQo+ICBkcml2ZXJzL2h2L3ZtYnVzX2Rydi5jIHwgMzAgKysrKysrKysrKysrKysrLS0tLS0tLS0t
LS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMTUgaW5zZXJ0aW9ucygrKSwgMTUgZGVsZXRpb25z
KC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9odi92bWJ1c19kcnYuYyBiL2RyaXZlcnMv
aHYvdm1idXNfZHJ2LmMNCj4gaW5kZXggZWNjZTZiNzJhMmEyLi43Y2EwMzhjMWU1YWEgMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvaHYvdm1idXNfZHJ2LmMNCj4gKysrIGIvZHJpdmVycy9odi92bWJ1
c19kcnYuYw0KPiBAQCAtMTg2NCw3ICsxODY0LDcgQEAgc3RhdGljIHNzaXplX3QgdGFyZ2V0X2Nw
dV9zdG9yZShzdHJ1Y3Qgdm1idXNfY2hhbm5lbCAqY2hhbm5lbCwNCj4gDQo+ICAJcmV0dXJuIHJl
dCA/OiBjb3VudDsNCj4gIH0NCj4gLXN0YXRpYyBWTUJVU19DSEFOX0FUVFIoY3B1LCAwNjQ0LCB0
YXJnZXRfY3B1X3Nob3csIHRhcmdldF9jcHVfc3RvcmUpOw0KPiArc3RhdGljIGNvbnN0IFZNQlVT
X0NIQU5fQVRUUihjcHUsIDA2NDQsIHRhcmdldF9jcHVfc2hvdywgdGFyZ2V0X2NwdV9zdG9yZSk7
DQo+IA0KPiAgc3RhdGljIHNzaXplX3QgY2hhbm5lbF9wZW5kaW5nX3Nob3coc3RydWN0IHZtYnVz
X2NoYW5uZWwgKmNoYW5uZWwsDQo+ICAJCQkJICAgIGNoYXIgKmJ1ZikNCj4gQEAgLTE4NzMsNyAr
MTg3Myw3IEBAIHN0YXRpYyBzc2l6ZV90IGNoYW5uZWxfcGVuZGluZ19zaG93KHN0cnVjdCB2bWJ1
c19jaGFubmVsICpjaGFubmVsLA0KPiAgCQkgICAgICAgY2hhbm5lbF9wZW5kaW5nKGNoYW5uZWws
DQo+ICAJCQkJICAgICAgIHZtYnVzX2Nvbm5lY3Rpb24ubW9uaXRvcl9wYWdlc1sxXSkpOw0KPiAg
fQ0KPiAtc3RhdGljIFZNQlVTX0NIQU5fQVRUUihwZW5kaW5nLCAwNDQ0LCBjaGFubmVsX3BlbmRp
bmdfc2hvdywgTlVMTCk7DQo+ICtzdGF0aWMgY29uc3QgVk1CVVNfQ0hBTl9BVFRSKHBlbmRpbmcs
IDA0NDQsIGNoYW5uZWxfcGVuZGluZ19zaG93LCBOVUxMKTsNCj4gDQo+ICBzdGF0aWMgc3NpemVf
dCBjaGFubmVsX2xhdGVuY3lfc2hvdyhzdHJ1Y3Qgdm1idXNfY2hhbm5lbCAqY2hhbm5lbCwNCj4g
IAkJCQkgICAgY2hhciAqYnVmKQ0KPiBAQCAtMTg4MiwxOSArMTg4MiwxOSBAQCBzdGF0aWMgc3Np
emVfdCBjaGFubmVsX2xhdGVuY3lfc2hvdyhzdHJ1Y3Qgdm1idXNfY2hhbm5lbCAqY2hhbm5lbCwN
Cj4gIAkJICAgICAgIGNoYW5uZWxfbGF0ZW5jeShjaGFubmVsLA0KPiAgCQkJCSAgICAgICB2bWJ1
c19jb25uZWN0aW9uLm1vbml0b3JfcGFnZXNbMV0pKTsNCj4gIH0NCj4gLXN0YXRpYyBWTUJVU19D
SEFOX0FUVFIobGF0ZW5jeSwgMDQ0NCwgY2hhbm5lbF9sYXRlbmN5X3Nob3csIE5VTEwpOw0KPiAr
c3RhdGljIGNvbnN0IFZNQlVTX0NIQU5fQVRUUihsYXRlbmN5LCAwNDQ0LCBjaGFubmVsX2xhdGVu
Y3lfc2hvdywgTlVMTCk7DQo+IA0KPiAgc3RhdGljIHNzaXplX3QgY2hhbm5lbF9pbnRlcnJ1cHRz
X3Nob3coc3RydWN0IHZtYnVzX2NoYW5uZWwgKmNoYW5uZWwsIGNoYXIgKmJ1ZikNCj4gIHsNCj4g
IAlyZXR1cm4gc3ByaW50ZihidWYsICIlbGx1XG4iLCBjaGFubmVsLT5pbnRlcnJ1cHRzKTsNCj4g
IH0NCj4gLXN0YXRpYyBWTUJVU19DSEFOX0FUVFIoaW50ZXJydXB0cywgMDQ0NCwgY2hhbm5lbF9p
bnRlcnJ1cHRzX3Nob3csIE5VTEwpOw0KPiArc3RhdGljIGNvbnN0IFZNQlVTX0NIQU5fQVRUUihp
bnRlcnJ1cHRzLCAwNDQ0LCBjaGFubmVsX2ludGVycnVwdHNfc2hvdywgTlVMTCk7DQo+IA0KPiAg
c3RhdGljIHNzaXplX3QgY2hhbm5lbF9ldmVudHNfc2hvdyhzdHJ1Y3Qgdm1idXNfY2hhbm5lbCAq
Y2hhbm5lbCwgY2hhciAqYnVmKQ0KPiAgew0KPiAgCXJldHVybiBzcHJpbnRmKGJ1ZiwgIiVsbHVc
biIsIGNoYW5uZWwtPnNpZ19ldmVudHMpOw0KPiAgfQ0KPiAtc3RhdGljIFZNQlVTX0NIQU5fQVRU
UihldmVudHMsIDA0NDQsIGNoYW5uZWxfZXZlbnRzX3Nob3csIE5VTEwpOw0KPiArc3RhdGljIGNv
bnN0IFZNQlVTX0NIQU5fQVRUUihldmVudHMsIDA0NDQsIGNoYW5uZWxfZXZlbnRzX3Nob3csIE5V
TEwpOw0KPiANCj4gIHN0YXRpYyBzc2l6ZV90IGNoYW5uZWxfaW50cl9pbl9mdWxsX3Nob3coc3Ry
dWN0IHZtYnVzX2NoYW5uZWwgKmNoYW5uZWwsDQo+ICAJCQkJCSBjaGFyICpidWYpDQo+IEBAIC0x
OTAyLDcgKzE5MDIsNyBAQCBzdGF0aWMgc3NpemVfdCBjaGFubmVsX2ludHJfaW5fZnVsbF9zaG93
KHN0cnVjdCB2bWJ1c19jaGFubmVsICpjaGFubmVsLA0KPiAgCXJldHVybiBzcHJpbnRmKGJ1Ziwg
IiVsbHVcbiIsDQo+ICAJCSAgICAgICAodW5zaWduZWQgbG9uZyBsb25nKWNoYW5uZWwtPmludHJf
aW5fZnVsbCk7DQo+ICB9DQo+IC1zdGF0aWMgVk1CVVNfQ0hBTl9BVFRSKGludHJfaW5fZnVsbCwg
MDQ0NCwgY2hhbm5lbF9pbnRyX2luX2Z1bGxfc2hvdywgTlVMTCk7DQo+ICtzdGF0aWMgY29uc3Qg
Vk1CVVNfQ0hBTl9BVFRSKGludHJfaW5fZnVsbCwgMDQ0NCwgY2hhbm5lbF9pbnRyX2luX2Z1bGxf
c2hvdywgTlVMTCk7DQo+IA0KPiAgc3RhdGljIHNzaXplX3QgY2hhbm5lbF9pbnRyX291dF9lbXB0
eV9zaG93KHN0cnVjdCB2bWJ1c19jaGFubmVsICpjaGFubmVsLA0KPiAgCQkJCQkgICBjaGFyICpi
dWYpDQo+IEBAIC0xOTEwLDcgKzE5MTAsNyBAQCBzdGF0aWMgc3NpemVfdCBjaGFubmVsX2ludHJf
b3V0X2VtcHR5X3Nob3coc3RydWN0IHZtYnVzX2NoYW5uZWwgKmNoYW5uZWwsDQo+ICAJcmV0dXJu
IHNwcmludGYoYnVmLCAiJWxsdVxuIiwNCj4gIAkJICAgICAgICh1bnNpZ25lZCBsb25nIGxvbmcp
Y2hhbm5lbC0+aW50cl9vdXRfZW1wdHkpOw0KPiAgfQ0KPiAtc3RhdGljIFZNQlVTX0NIQU5fQVRU
UihpbnRyX291dF9lbXB0eSwgMDQ0NCwgY2hhbm5lbF9pbnRyX291dF9lbXB0eV9zaG93LCBOVUxM
KTsNCj4gK3N0YXRpYyBjb25zdCBWTUJVU19DSEFOX0FUVFIoaW50cl9vdXRfZW1wdHksIDA0NDQs
IGNoYW5uZWxfaW50cl9vdXRfZW1wdHlfc2hvdywgTlVMTCk7DQo+IA0KPiAgc3RhdGljIHNzaXpl
X3QgY2hhbm5lbF9vdXRfZnVsbF9maXJzdF9zaG93KHN0cnVjdCB2bWJ1c19jaGFubmVsICpjaGFu
bmVsLA0KPiAgCQkJCQkgICBjaGFyICpidWYpDQo+IEBAIC0xOTE4LDcgKzE5MTgsNyBAQCBzdGF0
aWMgc3NpemVfdCBjaGFubmVsX291dF9mdWxsX2ZpcnN0X3Nob3coc3RydWN0IHZtYnVzX2NoYW5u
ZWwgKmNoYW5uZWwsDQo+ICAJcmV0dXJuIHNwcmludGYoYnVmLCAiJWxsdVxuIiwNCj4gIAkJICAg
ICAgICh1bnNpZ25lZCBsb25nIGxvbmcpY2hhbm5lbC0+b3V0X2Z1bGxfZmlyc3QpOw0KPiAgfQ0K
PiAtc3RhdGljIFZNQlVTX0NIQU5fQVRUUihvdXRfZnVsbF9maXJzdCwgMDQ0NCwgY2hhbm5lbF9v
dXRfZnVsbF9maXJzdF9zaG93LCBOVUxMKTsNCj4gK3N0YXRpYyBjb25zdCBWTUJVU19DSEFOX0FU
VFIob3V0X2Z1bGxfZmlyc3QsIDA0NDQsIGNoYW5uZWxfb3V0X2Z1bGxfZmlyc3Rfc2hvdywgTlVM
TCk7DQo+IA0KPiAgc3RhdGljIHNzaXplX3QgY2hhbm5lbF9vdXRfZnVsbF90b3RhbF9zaG93KHN0
cnVjdCB2bWJ1c19jaGFubmVsICpjaGFubmVsLA0KPiAgCQkJCQkgICBjaGFyICpidWYpDQo+IEBA
IC0xOTI2LDE0ICsxOTI2LDE0IEBAIHN0YXRpYyBzc2l6ZV90IGNoYW5uZWxfb3V0X2Z1bGxfdG90
YWxfc2hvdyhzdHJ1Y3Qgdm1idXNfY2hhbm5lbCAqY2hhbm5lbCwNCj4gIAlyZXR1cm4gc3ByaW50
ZihidWYsICIlbGx1XG4iLA0KPiAgCQkgICAgICAgKHVuc2lnbmVkIGxvbmcgbG9uZyljaGFubmVs
LT5vdXRfZnVsbF90b3RhbCk7DQo+ICB9DQo+IC1zdGF0aWMgVk1CVVNfQ0hBTl9BVFRSKG91dF9m
dWxsX3RvdGFsLCAwNDQ0LCBjaGFubmVsX291dF9mdWxsX3RvdGFsX3Nob3csIE5VTEwpOw0KPiAr
c3RhdGljIGNvbnN0IFZNQlVTX0NIQU5fQVRUUihvdXRfZnVsbF90b3RhbCwgMDQ0NCwgY2hhbm5l
bF9vdXRfZnVsbF90b3RhbF9zaG93LCBOVUxMKTsNCj4gDQo+ICBzdGF0aWMgc3NpemVfdCBzdWJj
aGFubmVsX21vbml0b3JfaWRfc2hvdyhzdHJ1Y3Qgdm1idXNfY2hhbm5lbCAqY2hhbm5lbCwNCj4g
IAkJCQkJICBjaGFyICpidWYpDQo+ICB7DQo+ICAJcmV0dXJuIHNwcmludGYoYnVmLCAiJXVcbiIs
IGNoYW5uZWwtPm9mZmVybXNnLm1vbml0b3JpZCk7DQo+ICB9DQo+IC1zdGF0aWMgVk1CVVNfQ0hB
Tl9BVFRSKG1vbml0b3JfaWQsIDA0NDQsIHN1YmNoYW5uZWxfbW9uaXRvcl9pZF9zaG93LCBOVUxM
KTsNCj4gK3N0YXRpYyBjb25zdCBWTUJVU19DSEFOX0FUVFIobW9uaXRvcl9pZCwgMDQ0NCwgc3Vi
Y2hhbm5lbF9tb25pdG9yX2lkX3Nob3csIE5VTEwpOw0KPiANCj4gIHN0YXRpYyBzc2l6ZV90IHN1
YmNoYW5uZWxfaWRfc2hvdyhzdHJ1Y3Qgdm1idXNfY2hhbm5lbCAqY2hhbm5lbCwNCj4gIAkJCQkg
IGNoYXIgKmJ1ZikNCj4gQEAgLTE5NDEsNyArMTk0MSw3IEBAIHN0YXRpYyBzc2l6ZV90IHN1YmNo
YW5uZWxfaWRfc2hvdyhzdHJ1Y3Qgdm1idXNfY2hhbm5lbCAqY2hhbm5lbCwNCj4gIAlyZXR1cm4g
c3ByaW50ZihidWYsICIldVxuIiwNCj4gIAkJICAgICAgIGNoYW5uZWwtPm9mZmVybXNnLm9mZmVy
LnN1Yl9jaGFubmVsX2luZGV4KTsNCj4gIH0NCj4gLXN0YXRpYyBWTUJVU19DSEFOX0FUVFJfUk8o
c3ViY2hhbm5lbF9pZCk7DQo+ICtzdGF0aWMgY29uc3QgVk1CVVNfQ0hBTl9BVFRSX1JPKHN1YmNo
YW5uZWxfaWQpOw0KPiANCj4gIHN0YXRpYyBpbnQgaHZfbW1hcF9yaW5nX2J1ZmZlcl93cmFwcGVy
KHN0cnVjdCBmaWxlICpmaWxwLCBzdHJ1Y3Qga29iamVjdCAqa29iaiwNCj4gIAkJCQkgICAgICAg
Y29uc3Qgc3RydWN0IGJpbl9hdHRyaWJ1dGUgKmF0dHIsDQo+IEBAIC0xOTYzLDcgKzE5NjMsNyBA
QCBzdGF0aWMgY29uc3Qgc3RydWN0IGJpbl9hdHRyaWJ1dGUgY2hhbl9hdHRyX3JpbmdfYnVmZmVy
ID0gew0KPiAgCX0sDQo+ICAJLm1tYXAgPSBodl9tbWFwX3JpbmdfYnVmZmVyX3dyYXBwZXIsDQo+
ICB9Ow0KPiAtc3RhdGljIHN0cnVjdCBhdHRyaWJ1dGUgKnZtYnVzX2NoYW5fYXR0cnNbXSA9IHsN
Cj4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgYXR0cmlidXRlICpjb25zdCB2bWJ1c19jaGFuX2F0dHJz
W10gPSB7DQo+ICAJJmNoYW5fYXR0cl9vdXRfbWFzay5hdHRyLA0KPiAgCSZjaGFuX2F0dHJfaW5f
bWFzay5hdHRyLA0KPiAgCSZjaGFuX2F0dHJfcmVhZF9hdmFpbC5hdHRyLA0KPiBAQCAtMTk5Miw3
ICsxOTkyLDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBiaW5fYXR0cmlidXRlICpjb25zdCB2bWJ1
c19jaGFuX2Jpbl9hdHRyc1tdID0gew0KPiAgICogZWFjaCBhdHRyaWJ1dGUsIGFuZCByZXR1cm5z
IDAgaWYgYW4gYXR0cmlidXRlIGlzIG5vdCB2aXNpYmxlLg0KPiAgICovDQo+ICBzdGF0aWMgdW1v
ZGVfdCB2bWJ1c19jaGFuX2F0dHJfaXNfdmlzaWJsZShzdHJ1Y3Qga29iamVjdCAqa29iaiwNCj4g
LQkJCQkJICBzdHJ1Y3QgYXR0cmlidXRlICphdHRyLCBpbnQgaWR4KQ0KPiArCQkJCQkgIGNvbnN0
IHN0cnVjdCBhdHRyaWJ1dGUgKmF0dHIsIGludCBpZHgpDQo+ICB7DQo+ICAJY29uc3Qgc3RydWN0
IHZtYnVzX2NoYW5uZWwgKmNoYW5uZWwgPQ0KPiAgCQljb250YWluZXJfb2Yoa29iaiwgc3RydWN0
IHZtYnVzX2NoYW5uZWwsIGtvYmopOw0KPiBAQCAtMjAzMCw5ICsyMDMwLDkgQEAgc3RhdGljIHNp
emVfdCB2bWJ1c19jaGFuX2Jpbl9zaXplKHN0cnVjdCBrb2JqZWN0ICprb2JqLA0KPiAgfQ0KPiAN
Cj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgYXR0cmlidXRlX2dyb3VwIHZtYnVzX2NoYW5fZ3JvdXAg
PSB7DQo+IC0JLmF0dHJzID0gdm1idXNfY2hhbl9hdHRycywNCj4gKwkuYXR0cnNfY29uc3QgPSB2
bWJ1c19jaGFuX2F0dHJzLA0KPiAgCS5iaW5fYXR0cnMgPSB2bWJ1c19jaGFuX2Jpbl9hdHRycywN
Cj4gLQkuaXNfdmlzaWJsZSA9IHZtYnVzX2NoYW5fYXR0cl9pc192aXNpYmxlLA0KPiArCS5pc192
aXNpYmxlX2NvbnN0ID0gdm1idXNfY2hhbl9hdHRyX2lzX3Zpc2libGUsDQo+ICAJLmlzX2Jpbl92
aXNpYmxlID0gdm1idXNfY2hhbl9iaW5fYXR0cl9pc192aXNpYmxlLA0KPiAgCS5iaW5fc2l6ZSA9
IHZtYnVzX2NoYW5fYmluX3NpemUsDQo+ICB9Ow0KPiANCj4gLS0NCj4gMi41My4wDQo+IA0KDQo=

