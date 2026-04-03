Return-Path: <linux-hyperv+bounces-9942-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 38kGHV4rz2kNtgYAu9opvQ
	(envelope-from <linux-hyperv+bounces-9942-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 03 Apr 2026 04:52:14 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D2ADC390797
	for <lists+linux-hyperv@lfdr.de>; Fri, 03 Apr 2026 04:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B9570301F301
	for <lists+linux-hyperv@lfdr.de>; Fri,  3 Apr 2026 02:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06FC7313298;
	Fri,  3 Apr 2026 02:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="aB1z8pLK"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazolkn19010002.outbound.protection.outlook.com [52.103.20.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3CB1B86C7;
	Fri,  3 Apr 2026 02:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.20.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775184729; cv=fail; b=dd4NlepWEXgOuaa69U5gRtTR4P7txYl3Ta2E/yO6+G/0dV81S+Sk6sLXpeKJAsT8GtqwEMHZrWm7gCLcGkhOVWaOpXVsrr/3gEmz4Cnth3mTrodx2TB8b1/Md/jBC4JjVYhyxXvy/qmyDbrfwYDThVCnkD46c6gCZvbBONy9TlQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775184729; c=relaxed/simple;
	bh=RCxzolLLppaoR9053HMLfhG2hODo71IlgHwW/IQvOiw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eA2L8lgyiJ/os6x/6g5s8kjj/pBV++F89n1fJXXg1yHgkoP495xHcghdM/b0yKwoCxjp1k8d0oua4P8SZ+4ZQDcq4RIdfk20ftEDtyf5W6sVv1nUXNfy3mPT13Bq6hcMrLijU+eSc23KcrfJja72KmF2dGrE/ylI7IqssQCDv8E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=aB1z8pLK; arc=fail smtp.client-ip=52.103.20.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FKyhuV1PGph3iRt9N+Zeya3w9ngNM/J4uX5npnY3ottx38V9VFvI0KV+HwUntrzrlcB4zuojASkmsgpsA+oJuecR7Ct54Iccb4bHtgMY3AzmZFWT7Y7LPI2/KMgPP5I2vCF4hy537YSL2zI71zBhEKG9Y8c0UfEidD9CQ9xwCgoD2y7bewfILG8Bwvyy1Xd96+/6eHT+tUEYL6IB9L+J5sPnpZ7f36hEHVFlUe7xL18HW1Xbu/wrUBkJ+UGwxtH4Ppj7dP6PLW65HWe4PiDS1o1NhOKEbwV8su87hKfCdg8Hx0Pb4j/fOGTJ71+9n4XOZ6FzkPpqxo7OjhD2S6msgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RCxzolLLppaoR9053HMLfhG2hODo71IlgHwW/IQvOiw=;
 b=rTDs8ub1x2xc0RxPgp4YSHSGBMSGyg830P++6fkPhGnI98UKq03iN+ZYfBRq+g6ESA8P53hgOZlF0MhqR7QcdyxwKhBlyItQv1dkyunpM907r4/Uv2ZCclo13Cr5QM9vY/V/COsSn1cJ+RlyY09D8QNszUO/PQBJ9UFmL4dmAnNx88oe8NfuLlX7HD1tPeGASr4loxl+62nOMTQ0idEzVeOS4RxisFIX7m4imLpuly5Bz6OsrCHbMLSyq9LruAZyx8GqwBdURVYnp26Mn4U2qI6Csk/TSM3sI/fsC9GMzk9zqNOvWtEdFP7MQI/h1zToLvZAvh90vvsrD3Kt8HK5rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RCxzolLLppaoR9053HMLfhG2hODo71IlgHwW/IQvOiw=;
 b=aB1z8pLKwukF/7w3vhlZOVUiG0NGaAKhYf1T1c6CGvQ28EuB9Q3Ho5UJ4WXAkSEXzRIHKE2yhbOVRrCOXhsZKoPpYZ8WJ07WkcQ5GqHtRYG7I4Rag2CHQf+L65t2qZYJMxeRULa+a78jPMlhQttXfa7A4u+Fhx+B+TDjwpryjlBFurxNFyT0n5AROZteM/cG6VFA/Lnm6nWl+rlvZiMY1AJ2gsly7AsrAyRnCVkJ7xrStxYCkYauxzBgspuFamO9YcrrRwnYeBe0BUcIrm7vl+7bLDxaqoQPnNCaPhX/izCq6O6lNY1hwpF5EvFCIO66EDyKXEBtN9uixky/m/FTpA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CO1PR02MB8521.namprd02.prod.outlook.com (2603:10b6:303:158::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Fri, 3 Apr
 2026 02:52:05 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9769.014; Fri, 3 Apr 2026
 02:52:05 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: =?utf-8?B?VGhvbWFzIFdlacOfc2NodWg=?= <linux@weissschuh.net>, "K. Y.
 Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei
 Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Long Li
	<longli@microsoft.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/4] drivers: hv: mark some sysfs attribute as const
Thread-Topic: [PATCH 0/4] drivers: hv: mark some sysfs attribute as const
Thread-Index: AQIA5n8utbFNLZq9HsGD5u2/wbCFbLWEW89w
Date: Fri, 3 Apr 2026 02:52:04 +0000
Message-ID:
 <SN6PR02MB41575BBC732C592E19642C3DD45EA@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260402-sysfs-const-hv-v1-0-a467d6f7726e@weissschuh.net>
In-Reply-To: <20260402-sysfs-const-hv-v1-0-a467d6f7726e@weissschuh.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CO1PR02MB8521:EE_
x-ms-office365-filtering-correlation-id: b5784120-c0a3-4f64-5617-08de912bfd2f
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799015|8062599012|461199028|19110799012|15080799012|31061999003|13091999003|51005399006|37011999003|440099028|3412199025|26121999003|102099032|40105399003;
x-microsoft-antispam-message-info:
 =?utf-8?B?Zk9XelJlWnBvVFdNM0k4M0ZlYXRlQW11WFV0TmlMMkprRmxzTlVIRWdLTDdo?=
 =?utf-8?B?MWl4aDZZY290OCtGSng1MU1xa3BTL0ZJa3lZWFBPcWMzT013UGVBd1k4SEcz?=
 =?utf-8?B?TyswYmNqcnBVWXpZZTZxRjQwM0pMVGNvMzVaa0FyVVpuZG5DWlVHNXFhTXQ5?=
 =?utf-8?B?Uit5VVVWQlhXbzI0Nk5wRm9xTGpsTjBkYjNwVXhJYXAxUUF4WCs4TjQ3Z1Bv?=
 =?utf-8?B?Sy90ak9hb3pUZ3NWR29HU2VnRkRXQzRTR0F5NVgrTXNZcUZSTE0vQ2dBZ2lW?=
 =?utf-8?B?MGNMSi85VGtSVXVqa0FqWHZCaExQSjFkcEs0ZGlNaFFZMTJmVDJxSHptR1J3?=
 =?utf-8?B?dXBFclZFRDlEOXZmQXovQ01OWkRJdTlLd1dta2ZUNWV2a3Rub2d6NmRyUWRN?=
 =?utf-8?B?L0ZGT1gvemN1VURxZjFURG13U1ZkWEI4S2k4bGx3WFRNdnc3d2pyU0ZZYk9a?=
 =?utf-8?B?a3BMc04wc0EwS2lsYnY2bVI2akJBY2JWRUVJK2JYWkN4ZzJwZ3F5cXRqeTBM?=
 =?utf-8?B?VkRiVlMrWGRMdkV2S2pGejZDSExYYXZEUjFQTy9QaVpKbmx4VXJ0V0hIdkpL?=
 =?utf-8?B?bzNMSm1BUFdoVm9zZ0cwZmt4aWRvOStlMGkyWDBCVWdBMStoazFPd2tSYjU2?=
 =?utf-8?B?NlpzUWtOZlByemJVNHV0dE1RSkJjd1prRmdTdnRueElxWUdGUldyYnMrTzN5?=
 =?utf-8?B?MXViajBMUU0rZVZwblFHdG9NeFd6eW5TU2R2QXVWUzA3RUdBNWo3RnJTSmNB?=
 =?utf-8?B?dlBWWFhIOElYelYyS2RDR1BHZnF2c3RTYlpIMHNtK0RranBaUUl3b2Jaa01X?=
 =?utf-8?B?VlMzOFNHTHVSTE1IRFlzZWE3TGdLdStnb3M1cjR4NnluaExKT3RHVlhOeTVB?=
 =?utf-8?B?amJOUldzVmVDci9hZGMvbVhYMU1wQ04rWGhRc0JJMGp5eklaY1VWWnVGc1Vm?=
 =?utf-8?B?MlpjWm5XN1BIVEdXcm5wMzlEZHE3RVlPeHZlQ0QvdzRpci9wZW5OT05hWFd2?=
 =?utf-8?B?ZUhzSFFzM29YT01BSHI2SzRnaXNkdk5HOEYzZ2x0eHNSZ0xhMmVIakhyVWl4?=
 =?utf-8?B?N2lJaDhQMXBuNVgzOFRnRjVsSXoxWjZvM1JNaEFYL3htNWMyM2pYcjVLUGJM?=
 =?utf-8?B?b2NOOGZBaWdoTVAzdU1RdFdoTGFhRFdwQTJHWDc2MVc4NTJqM2VJWFYwMWh3?=
 =?utf-8?B?SlcwSDZudzdYNlR6ZkIveTQzSWNLdXF6SmZud1MydnNxZVZhTWxFNFl1OGhj?=
 =?utf-8?B?RjBZZkxUMGFDaDI3QzlRU2p1TzRLbkVYNkZ1eFFjWVZtakZFTWdOMzhwa3Zz?=
 =?utf-8?Q?NvKEpkrnWPU0ghGkygXjJ1lJHk0yXJldWv?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NDF3cnY5eW96NSszU3FkRjRiSnFuWnQzclRzeEFXenFhMXdkM1lwQmZTc2Zu?=
 =?utf-8?B?aXp5Q09HS1d1WXFZaVJjbWFvVGwwQzM4QWFKellnU3VUbkNWR29tRGV5WW8v?=
 =?utf-8?B?M3kxZlpRcFZiQWRoMWVLZHdMeWhsZUhLd3pYVCt3UkZ0ZXBKb1JGbzdZa0Zn?=
 =?utf-8?B?UjFFSGhrSnZHbWppTmxlMG5yc1UrTFdrK3VVa1k2VUEvK25PV2x4SzcxYlVa?=
 =?utf-8?B?NE1SZ2dXL2ovMldXRTJUSVk5ek1GMVNhR1BxOUtBeHdDVHR2MFcyS1RzZUYx?=
 =?utf-8?B?cEdDWElobUZuV1M3SFUvSmUxWEp1ZXp3bE9qeGhSKzhaU1U2WVdrWUFoV3c4?=
 =?utf-8?B?MC9GcUFBNCtOR1VKMXBwOU9rWHcvT1FJQWNEMHJjOGVUM2JaRWJ5Y21mdHFJ?=
 =?utf-8?B?UXNVRkhFQjBaZXdUTk95RVhQUFRPaFRDUUVrVmQzM0JGWitMLzRXbERjZGNP?=
 =?utf-8?B?NGZYVkVKNlZKZjFxRWNwak1YTSswRHozd1dqanN0UE0vajU2OFRPL2F0Tk1Q?=
 =?utf-8?B?NlhDcmNlMHJ4UEJpT0d4dFlCcndkS1doYlRzMmFab1VlVllVUEk1Z3VKQTBF?=
 =?utf-8?B?SWNpbUtxNkhlbk5IN0hlbzc5d01VOHhXalc4MHN0dFhpblR3djRmeFE0Zkd2?=
 =?utf-8?B?R2ZiWDBwN3h5K0VkRXlNazlKUmxpMlNCSWt4OTJpbGVsOVFpT0ZGaWY4NUhR?=
 =?utf-8?B?eDJET3IzRFVMcHlZdTNVc0s2aE5WeDRzTVJiV0V6WHk3b1Z1NjFqVE8yR25m?=
 =?utf-8?B?ZkNZdzFYRURFTWovbzlSaWR4OVpubkQvSmp1d2l2ZVdYMnlxRWdXSm1VU0FO?=
 =?utf-8?B?ZU9weFIvZjJKWHF2d1puS1N4WkxrMzUvK2Zyc1BERlJFK3p3TmRYS2o0WXBl?=
 =?utf-8?B?SERPSHFDMzI3dFYxQlBrWDFzWElQK245dDhTMHNkRitETDlSQzE2WVRDNlVK?=
 =?utf-8?B?YkxDWGtzaWRhQXN6V3I5djVST2xKd3k0Z0pWS2llV1RWZkRlSExZZXdOSDNK?=
 =?utf-8?B?NU1xbnl3elA4K1dvODJXdHBMSWFPRHlkSk4yWldCeVk4aS9KS1hOZm9pUEJP?=
 =?utf-8?B?V1BwNFFNZDd4Mk5RSzYvUW1ldFRHdkp3SUhmZ00vQUtrNjdLcEloRXF5UGE0?=
 =?utf-8?B?SU14aThxOWRsejFXaG8vdEk2dENSMFJ3R0llSDQ5cHh0a2xZejF6d1JSdXVs?=
 =?utf-8?B?ZkRWd3gzK2o4aG5yYWJHeVR0cEd6b2VjRXkxUnBzYUxuU2l1MlRtZ25GWnEx?=
 =?utf-8?B?UWQ2WUJDeDAxbklpeTlkd2ZIZXlCOXNVdFZudlpNWlVCV1pIT0Eyc3RjbFh4?=
 =?utf-8?B?MEhhcFpDaGFlcHR1c0g1Rll4aXdYNGVpMW02bk45UWxXV0pERHRjT085bDFv?=
 =?utf-8?B?dVJPWWlsa3Jqa0RtN2I5dlBRQ1NEeDgrMEduUUJsZmlNRWhjTlhZUU1QejNT?=
 =?utf-8?B?aUlEWHpnRWdZZytSZGh2enlXQTFwc1VDTTlYUFppdTRMTGRobWh2U2EzMFhE?=
 =?utf-8?B?VnRuZFZ0a0piYjR0VWM5NHA0cWJIM0R5ZU5vbE84a2djTWJEYXZzV2RjdHlI?=
 =?utf-8?B?aVlHUUZzVkdKQmlicmlpQ21kalc0TklpZEs2RU9vZmtQbU95dXdHcEtsZHVy?=
 =?utf-8?B?RFZ1aWljdCtDTG5qM0R6T01Zc0Q0Mmx6SVhabUVlcGM5Q0JlRmdxK2FiRmJz?=
 =?utf-8?B?NzZSVFdqc3F0enVyZGxSdHVTd3cwa05LMElGK0hKSHlyMHREZXZhYThIN2FN?=
 =?utf-8?B?Qm5wM3RSVGVPMWlRNTdMNWVyemJxS28rcXo5UWVOVWRhdklUNkdtYVZ4dkw2?=
 =?utf-8?Q?69rb+DVcupCqS43rkdilCtLEBd9ptUln/aTmw=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b5784120-c0a3-4f64-5617-08de912bfd2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2026 02:52:05.0046
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR02MB8521
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-9942-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[SN6PR02MB4157.namprd02.prod.outlook.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,outlook.com:dkim,outlook.com:email,weissschuh.net:email]
X-Rspamd-Queue-Id: D2ADC390797
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

RnJvbTogVGhvbWFzIFdlacOfc2NodWggPGxpbnV4QHdlaXNzc2NodWgubmV0PiBTZW50OiBUaHVy
c2RheSwgQXByaWwgMiwgMjAyNiA4OjE4IEFNDQo+IA0KPiBUaGUgc3lzZnMgYXR0cmlidXRlIHN0
cnVjdHVyZXMgYXJlIG5ldmVyIG1vZGlmaWVkLg0KPiBNYXJrIHRoZW0gYXMgY29uc3Qgd2hlcmUg
cG9zc2libGUuDQo+IA0KPiBUaGlzIGV4Y2x1ZGVzIHRoZSBkZXZpY2UgYXR0cmlidXRlcyBmb3Ig
bm93LCBhcyB0aGVzZSB3aWxsIGhhdmUgdGhlaXINCj4gb3duIG1pZ3JhdGlvbi4NCj4gDQo+IFNp
Z25lZC1vZmYtYnk6IFRob21hcyBXZWnDn3NjaHVoIDxsaW51eEB3ZWlzc3NjaHVoLm5ldD4NCj4g
LS0tDQo+IFRob21hcyBXZWnDn3NjaHVoICg0KToNCj4gICAgICAgZHJpdmVyczogaHY6IG1hcmsg
Y2hhbl9hdHRyX3JpbmdfYnVmZmVyIGFzIGNvbnN0DQo+ICAgICAgIGRyaXZlcnM6IGh2OiB1c2Ug
QVRUUklCVVRFX0dST1VQUyBoZWxwZXINCj4gICAgICAgZHJpdmVyczogaHY6IG1hcmsgYnVzIGF0
dHJpYnV0ZXMgYXMgY29uc3QNCj4gICAgICAgZHJpdmVyczogaHY6IG1hcmsgY2hhbm5lbCBhdHRy
aWJ1dGVzIGFzIGNvbnN0DQo+IA0KPiAgZHJpdmVycy9odi92bWJ1c19kcnYuYyB8IDQzICsrKysr
KysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2Vk
LCAyMCBpbnNlcnRpb25zKCspLCAyMyBkZWxldGlvbnMoLSkNCj4gLS0tDQo+IGJhc2UtY29tbWl0
OiA2ZGUyM2Y4MWE1ZTA4YmU4ZmJmNWU4ZDdlOWZlYmM3MmE1YjVmMjdmDQo+IGNoYW5nZS1pZDog
MjAyNjAzMzEtc3lzZnMtY29uc3QtaHYtY2FkMDU3MThjNjhhDQo+IA0KPiBCZXN0IHJlZ2FyZHMs
DQo+IC0tDQo+IFRob21hcyBXZWnDn3NjaHVoIDxsaW51eEB3ZWlzc3NjaHVoLm5ldD4NCj4gDQoN
CkkgYnVpbHQgYW5kIHRlc3RlZCBhIGxpbnV4LW5leHQyMDI2MDMzMCBrZXJuZWwgd2l0aCB0aGlz
IHBhdGNoIHNldC4NClRoZSB0ZXN0aW5nIHdhcyBvbiBhIHg4Ni94NjQgVk0gcnVubmluZyBvbiBI
eXBlci1WIGxvY2FsbHkgb24gbXkNCmxhcHRvcC4gSSBhbHNvIGFwcGxpZWQgYSBmb2xsb3ctb24g
dXBkYXRlIHRvIG1hcmsgYXMgY29uc3QgdGhlIHJlbWFpbmluZw0KNCBjaGFubmVsIGF0dHJpYnV0
ZXMgdGhhdCB3ZXJlIHByZXN1bWFibHkgbWlzc2VkIGluIFBhdGNoIDQgb2YgdGhpcw0Kc2VyaWVz
IChzZWUgbXkgY29tbWVudHMgdGhlcmUpLg0KDQpFdmVyeXRoaW5nIHdvcmtlZCBmaW5lIHdpdGgg
bm8gaXNzdWVzLg0KDQpGb3IgdGhlIHNlcmllcywNClRlc3RlZC1ieTogTWljaGFlbCBLZWxsZXkg
PG1oa2xpbnV4QG91dGxvb2suY29tPg0KDQo=

