Return-Path: <linux-hyperv+bounces-10293-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Kw2Bacn6GmVGAIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10293-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 Apr 2026 03:43:03 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 972D74411FB
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 Apr 2026 03:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8D6DB300ACAC
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 Apr 2026 01:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D99F29A31C;
	Wed, 22 Apr 2026 01:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="fNT9Ek7r"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazolkn19012051.outbound.protection.outlook.com [52.103.2.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA881FC7;
	Wed, 22 Apr 2026 01:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.2.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776822179; cv=fail; b=LMKd3+msMDA+kX5kuZZGleAl+YnRsV4sEfkK7yK2fZYuN17WG7RPxPiJJWlfzCKBRXJULJNKIv7bwOsl26Me5TqfXCJ7OswizQNB/1DUmmA/p5AWb/yUwj7eWulE506RlCHKxwktJaBREvSoRlsdgXKAFc59KWeOohZhLuK07Hc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776822179; c=relaxed/simple;
	bh=gdo/wJlzvjaHmUg56Nkijpo12qFFwo2rMxyyoPXZEEU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eksJcwTmaEXguJ5KRGWxHv4OPr4JMwRJRm1K9ZfwNX4JAjybMi1kTg4+EV6nQ97LobQtTiUjetP+rQhk9280x4gjSWXlhdPNP3PLKbk5pOF6e7jxTG8qcrvLJHzBPPFY14guWHPz7yM2N7C4uVC4xLGsa5lzgWRyw50JInOz5lk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=fNT9Ek7r; arc=fail smtp.client-ip=52.103.2.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lziFO8sjXrfz48ZUylSn4ThRdyLCgJjwa15I40STujG8CIjc3YhqkybIMfYSQyqwfmRimBGnW2QaxO1liptU0YLx/1bibIsrNKSdiJzkLJ6+z4m2+EGeMrskKohqzWsMGPpa98oEnptaXbb5WI9wJSTg7MzQ4cjIuzT3mhX9Z4LG3mlhxnzbDeMR/V2RbXGmU+rl/G/R5mOhxl+Yh9EN+NwUglHvjAuL2mw9gG+no0cmNgljudaQsD+zIJUg1LWZ1CDoyF22we5NTZNfH0k90YzJkZHcRbzDYfSzW9nx/m8mtqQijajcGevv6bN3Cq+M3RPVqZhUVbiHRGCXMkxhzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gdo/wJlzvjaHmUg56Nkijpo12qFFwo2rMxyyoPXZEEU=;
 b=vj/qLNuBpR/jT1bqv5cSkNkim/uLRD7WH21ohgJ4x+jGH/I5NORdW4mOMP9D8ysafYJjL7M3BvtQMznUqHzVYw5muSu1Yp3rjQ61DKqAOljaxhN3nVML6FFyx2xmFAc72bbUiLe44yFDaHMZeCW7gHRcE09lAgaj2BSqM73T7VNMVGJkAD/UJ2pbsJnwbhpPK9XYnB7HHnjtVC0tKmuZEt33+nUdeDArdeuIV54mXIxp2x5nImWmfDoUxGS5f7QFCi8/Lk3qnTxj00nCMD/1EhtJVUjklliZ0zjlJ7ujXIWwnaYys6e0JnBrvIb/sCW/G1AwH+OYjo5cFE9ZA01DHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gdo/wJlzvjaHmUg56Nkijpo12qFFwo2rMxyyoPXZEEU=;
 b=fNT9Ek7rgTwjJfBdKb+E/Xc+0pDNVQ240HIMnFF0eyGjvfgO7DfDeiS9lBRQg64JvaHcHVSszyPuPZugccih+ZeAckwqNmUAsSNrk3a9VIREzo1iL64/DuwjsyXraetDm4lGco4suDbqp/hQr7Mcl8D5f1qBysqp2y9/8t4RafiN4dsck6JFQYh7qRo0cMOg6FPmUHojCb0iBbEN02a82FJB9h4MKgXHo9Tx+IXeeBSkQh1qd3clwNhRePyJoblxvBMhQH0EZaOgG4OqjXS+V5mjFFlXvOUzPxVfpfFNNk1hV7cPNVEmE20FUB/Trsr5bG+8dI4qKxNkOtta4F76uQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by BL3PR02MB7875.namprd02.prod.outlook.com (2603:10b6:208:33e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Wed, 22 Apr
 2026 01:42:56 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9846.016; Wed, 22 Apr 2026
 01:42:55 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	"kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "longli@microsoft.com"
	<longli@microsoft.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 0/7] mshv: Refactor memory region management and map
 pages at creation
Thread-Topic: [PATCH v2 0/7] mshv: Refactor memory region management and map
 pages at creation
Thread-Index: AQHu8nw7AeTw22BwqaGNWhTpY9BXWrXGC25Q
Date: Wed, 22 Apr 2026 01:42:54 +0000
Message-ID:
 <SN6PR02MB415768E025155E296A5DE681D42D2@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <177678175995.13344.10130389779290396174.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To:
 <177678175995.13344.10130389779290396174.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|BL3PR02MB7875:EE_
x-ms-office365-filtering-correlation-id: 220de749-55d0-4cc2-3be2-08dea0107967
x-microsoft-antispam:
 BCL:0;ARA:14566002|41001999006|19110799012|31061999003|13091999003|51005399006|15080799012|8060799015|12121999013|8062599012|55001999006|37011999003|461199028|40105399003|440099028|3412199025|102099032;
x-microsoft-antispam-message-info:
 =?utf-8?B?dzl5YUkxNXBmQkhsZFgxenpYd2k3K1ZJMldqRFRxT2hEQ1BmTWpoSElacFR5?=
 =?utf-8?B?ZldkRDMzS2dSVk85enE1TGNqYUJ3UGJVUUxXODlFM1pyRHNGSFRZUTNOTW13?=
 =?utf-8?B?bXRnRy9WbGF0T29ueEhiM2ljRC9Ra1lvTmNsUGZmWjBCUHhhbGJhdDFSd3lK?=
 =?utf-8?B?cGZXU0s5L1FXdkduMHJ6Z0lOZTg3S0o4eERpVTNGSlY4SVYvdm1mQ3pQTEVj?=
 =?utf-8?B?ek9aMHBDM3hUVW9TTEJoM2xUMzNlQVFiT28zeDBSK05VaFc0amVhamZhN0Y0?=
 =?utf-8?B?RHR1bWN1LzhCYmI0U3dqNnNNUDY2TFdudVhrOVJPemdOZFhRZHpROElnQmdn?=
 =?utf-8?B?WmljNjAzZjZ2M01td2hwbjBwR3Qra0FmQkwzMTRtZU04WGJSRktnVFNiZHY2?=
 =?utf-8?B?Yk54dW82RGNoM3ZESzRVeGxzLzhTZ05JU1BwbmNHQ04xQmJjNmVJek9xdTBr?=
 =?utf-8?B?dUVId1BBUVR5UEw1UURMOXZ0ckYyWFV5c3JnVUlzT1pYU1hNTkNEY3hWakZX?=
 =?utf-8?B?bzkzYzIyVTdUcjRtTm1meXgwQVhDeTlZaWI0WDQrQ0JvL3dkZlBJbFpFRVgr?=
 =?utf-8?B?TTQvazIvWjgwcmFJWXJwYzZjTzF5QkR0VmhFWnF3MlZEdXYwMXYxL0hteit4?=
 =?utf-8?B?ZGNmTmVNaEtsUXNTUHhBV0hGaC93ZnVrd1gydXltUkhDZHM5TGlEczVtbHpM?=
 =?utf-8?B?QTJzQWdqSkJuZURVUlBhVHRRRWh5WUs4bDRtWmk5YUZXY0FTb3o4cDQ4K3RO?=
 =?utf-8?B?T1pKREplU0NLdW05OFQraVF0L2VOcjh5STlWMCtlckd2YS9EVHRKTGhEdjFT?=
 =?utf-8?B?MlY2SHJqUGFWblpxZXYyd0xMenlQeHBkQW5OeEVjUG1EdXJKQlltdmNXZTJk?=
 =?utf-8?B?R3R2WmpCWm0xRC9weWprQm5acWd6RjJ5aWJyV1ZnK1MwVkdWNlM3eFZCQXB4?=
 =?utf-8?B?em1oZUphV0paUlA5SGlIaWc2ZzE0S3ZhZEM5UXY3QmRnMUdaQWtqdTg0Ykw0?=
 =?utf-8?B?RWEyaWhjekxsb3BzNTJKSXc1eGdvM3A5K0dMeGdqZ1pHRGQyNkE1cXdjazlS?=
 =?utf-8?B?RzJrSUJ4U2JtdmNvVzE3RzZ1MmlvUjc0TjRUb1lMYkhqM1kyem8rM2YwUmlv?=
 =?utf-8?B?ci84WG1NdmFRckp5UEpSYXJPRFhNdE9hdHRqMkozMXY0eEpEanNXcG10Nmsy?=
 =?utf-8?B?dGtUMURBdEdRSzFUTUJKelExcXEzS043NVF2L1QrUHVPc1RPQkN1blhTWFpW?=
 =?utf-8?B?TGtmMVlpVGt3TkFVajdJdWR0UWlUOW1YcndWckdvc3ZNOW1qWVZIT1B5VlpC?=
 =?utf-8?B?NGhqenNHbzBjUmJneW1oUmlMdGdyaVVXWHlnanlNWFRncWUrQTRheVVoUGhn?=
 =?utf-8?B?bXl4bzllaG1PcWFTVlhJTjZCMVZUN0RsT2ZCUkdSRVJEM1RiclMrQkJySnhF?=
 =?utf-8?Q?w0gLdwe8?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cEppQnVEdTlMZFNIL3BMczN1cnFhbWUvMUhneldFQS9RME45YWhRMUVuaitC?=
 =?utf-8?B?RmJ0N2lpYmpPQ2Zlelk4azBVSjhFWHBGaklwdW1aUVhXUUVzT0p2cmJwTXFC?=
 =?utf-8?B?YjZBWnNsNmNQTEtNNWc2ZDlKTXVpSktWdDJBaG1vb1FkenRVc1Y4azJIMER0?=
 =?utf-8?B?b2R4WUk3SWJlWE4zbDB4d2FrQnF4OVBVRlBRRkIyTG9qZXJsSjVsSStiNzk2?=
 =?utf-8?B?RGVXM0ljdi9tNmpwUndMaGU2YlRyMmM3bFdUVUFwR0llWDR0SE1LN2NQRW1z?=
 =?utf-8?B?VVdqQkNzZ0k0T0JLaGNvWGh5eW5DQUh1Tlc1c21NZjI3ZlNOSWJOMnp3TFlq?=
 =?utf-8?B?WksyQk94Nk1KVDdoNWxvZHhiV2RXVE80bHNBeE1iOGVKUFVsT04rY0NjWERk?=
 =?utf-8?B?YkdwVXdkVHE0SDNLRUFKVHBTS0FhSi9lWkxPUUE2N3FpNjlmSHZic1lOaU84?=
 =?utf-8?B?bmJjYXJ6QTBxYUFRdHJEVkE0a04xSFdVRDdlTDJ0SjR5dlNPSUsveElrTTMw?=
 =?utf-8?B?ZHJSZmZkN3BkRnRzMFlWeVVJODVxbDdQQzFXQTZYUEM4QS9xMVlhNUUwczVl?=
 =?utf-8?B?K1NsRm93THRKWU01YlEwQ2dtaDBLSDRKek14UmlnWFBOeCtGNVJURUViSnQ2?=
 =?utf-8?B?ZG94elQ4YVJuRHk4K3ZEZjdGY2x2TktsQTcySFBPRVBhQ0xkdW5XRVhFVWt3?=
 =?utf-8?B?UzVqbXRsaU4xTXZ6T3ZpYjAvazFobjhsWWNhcWg1OXJMa21HK3E4OUVIbXNk?=
 =?utf-8?B?NVVUNDExQjI4Sm9hMVVXZGZXcy9Zakszbk9mUjhUSUFadS9TeTRDdnpIaGFm?=
 =?utf-8?B?d2s4Y1FCS0MwU0tHNUxOZWJIVlN5NnFiRk1rbU1ZZ3B2TkxFTTRYTTFXZ0JU?=
 =?utf-8?B?MzJoemVEZTIvRlA0ckhTOXJTdStWVHY5TWxsWDA2RFpocEUxSlZtb3R5L0tR?=
 =?utf-8?B?Q0VLTmNOeEZEREVPd2QwRFVweVZNVFlCT0Ezejg4eitCVkR2UFhIRlBWMTNH?=
 =?utf-8?B?WkpDQVhhSGJzTjN3bnV6NWNSdGNCTzRYaVo3cU9RdXRwWjFmSVVqQ3J3TXp1?=
 =?utf-8?B?V01zRFVhL2xpRXlxdGJNb044d2ZUTXNONG4xKzc5M2k4RFlUQ2VBMFpLb3B3?=
 =?utf-8?B?Z0NjRE1oOGk2eXhoR1pUQVFqc2Rrc3Y4RnlCaG5zV0tRSkVyUDNva00yOThs?=
 =?utf-8?B?N2UzcVh0R09PenNRMzdNRkl2aThjWWFwb1Bmci9yd0gwVVlMay9mRmpPcmF3?=
 =?utf-8?B?WkhrWDYybFdOYTJmWGxiTVZYZ0NkeVdlZ2hwTGZlOURoZnhNVEl6L0R0d1dG?=
 =?utf-8?B?RWo1S3NSNmNRV0IwYUtWMDNFaW1hSWs2WWk5TTUxekh5c2owSDdUNjVWdFkr?=
 =?utf-8?B?WTNpSUc4SzI4dVFub3RNMUovbnMzbXJ2K0VYbVBVczgwa1d6UlZBVmFGUFB2?=
 =?utf-8?B?TjlVZDBnZWoxRUdqNFl0TitvZ2dWS2RLSDdnQm5Sa29EU3hSOFUyYk1UWHdF?=
 =?utf-8?B?L3YrclpMR3RaL1Z4OW9pZDZGUnNUalYva0d2UGlrWk1uUmNVVXlrYUlpMXcy?=
 =?utf-8?B?dnFwU3MzYXA0bTdxSGMrZjRuL0V4WVdES01WK3lEQWZNcUdteGlKazVXelZr?=
 =?utf-8?B?TWcrcDVUeU5BSFFkZysrZWVxbEtsaDAvOFBPc2ltSzUxRGlRNUt1Y0tid0lY?=
 =?utf-8?B?UlZ6QWg2OTFHS25pUzlqdVNiUmFhMVNkYWZGTzlBaVZlcDczWWZ2emRmQTZ4?=
 =?utf-8?B?ZktXQlVRQm5JUkdUOEtXclZTOFlZL2l2ZkZZTVdtUzdaMitCKzF6bUZKVmFw?=
 =?utf-8?Q?cTIXWvPUqycL5Ws6aaW+c9QCzaX3ZWkVFTcIg=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 220de749-55d0-4cc2-3be2-08dea0107967
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2026 01:42:54.9339
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR02MB7875
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10293-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[outlook.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 972D74411FB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

RnJvbTogU3RhbmlzbGF2IEtpbnNidXJza2lpIDxza2luc2J1cnNraWlAbGludXgubWljcm9zb2Z0
LmNvbT4gU2VudDogVHVlc2RheSwgQXByaWwgMjEsIDIwMjYgNzozNSBBTQ0KPiANCj4gVGhpcyBz
ZXJpZXMgcmVmYWN0b3JzIHRoZSBtc2h2IG1lbW9yeSByZWdpb24gc3Vic3lzdGVtIGluIHByZXBh
cmF0aW9uDQo+IGZvciBtYXBwaW5nIHBvcHVsYXRlZCBwYWdlcyBpbnRvIHRoZSBoeXBlcnZpc29y
IGF0IG1vdmFibGUgcmVnaW9uDQo+IGNyZWF0aW9uIHRpbWUsIHJhdGhlciB0aGFuIHJlbHlpbmcg
c29sZWx5IG9uIGRlbWFuZCBmYXVsdGluZy4NCj4gDQo+IFRoZSBwcmltYXJ5IG1vdGl2YXRpb24g
aXMgdG8gZW5zdXJlIHRoYXQgd2hlbiB1c2Vyc3BhY2UgcGFzc2VzIGENCj4gcHJlLXBvcHVsYXRl
ZCBtYXBwaW5nIGZvciBhIG1vdmFibGUgbWVtb3J5IHJlZ2lvbiwgdGhvc2UgcGFnZXMgYXJlDQo+
IGltbWVkaWF0ZWx5IHZpc2libGUgdG8gdGhlIGh5cGVydmlzb3IuIFByZXZpb3VzbHksIGFsbCBt
b3ZhYmxlIHJlZ2lvbnMNCj4gd2VyZSBjcmVhdGVkIHdpdGggSFZfTUFQX0dQQV9OT19BQ0NFU1Mg
b24gZXZlcnkgcGFnZSByZWdhcmRsZXNzIG9mDQo+IHdoZXRoZXIgdGhlIGJhY2tpbmcgcGFnZXMg
d2VyZSBhbHJlYWR5IHByZXNlbnQsIGRlZmVycmluZyBhbGwgbWFwcGluZw0KPiB0byB0aGUgZmF1
bHQgaGFuZGxlci4gVGhpcyBhZGRlZCB1bm5lY2Vzc2FyeSBmYXVsdCBvdmVyaGVhZCBhbmQNCj4g
Y29tcGxpY2F0ZWQgdGhlIGluaXRpYWwgc2V0dXAgb2YgY2hpbGQgcGFydGl0aW9ucyB3aXRoIHBy
ZS1wb3B1bGF0ZWQNCj4gbWVtb3J5Lg0KDQpbc25pcF0NCg0KPiANCj4gdjI6DQo+ICAtIFJlYmFz
ZWQgb24gdG9wIG9mIGxhdGVzdCBtYWlubGluZSwgc2ltcGxpZmllZCB0aGUgY2hlY2sgZm9yIHZh
bGlkIFBGTnMsDQo+ICAgIGFkZGVkIG90aGVyIG1pbm9yIGNsZWFudXBzIGFuZCBpbXByb3ZlbWVu
dHMuDQoNCkknbSBjb25mdXNlZCBhYm91dCAic2ltcGxpZmllZCB0aGUgY2hlY2sgZm9yIHZhbGlk
IFBGTnMiLg0KSSBzZWUgb25lIHBsYWNlIGluIG1zaHZfcmVnaW9uX3Byb2Nlc3NfcGZucygpIHdo
ZXJlIGEgUEZODQpmcm9tIHRoZSBtcmVnX3BmbnNbXSBhcnJheSBpcyBjaGVja2VkIGFnYWluc3QN
Ck1TSFZfSU5WQUxJRF9QRk4gaW5zdGVhZCBvZiBkb2luZyBwZm5fdmFsaWQoKS4gQnV0IHRoZXJl
DQphcmUgMTEgb3RoZXIgcGxhY2VzIGluIHRoZSBwYXRjaCBzZXQgd2hlcmUgcGZuX3ZhbGlkKCkg
aXMgc3RpbGwNCnVzZWQsIGluY2x1ZGluZyBpbiBtc2h2X3JlZ2lvbl9wcm9jZXNzX3BmbnMoKS4N
Cg0KTWljaGFlbA0KDQo+IA0KPiAtLS0NCj4gDQo+IFN0YW5pc2xhdiBLaW5zYnVyc2tpaSAoNyk6
DQo+ICAgICAgIG1zaHY6IENvbnZlcnQgZnJvbSBwYWdlIHBvaW50ZXJzIHRvIFBGTnMNCj4gICAg
ICAgbXNodjogQWRkIHN1cHBvcnQgdG8gYWRkcmVzcyByYW5nZSBob2xlcyByZW1hcHBpbmcNCj4g
ICAgICAgbXNodjogU3VwcG9ydCByZWdpb25zIHdpdGggZGlmZmVyZW50IFZNQXMNCj4gICAgICAg
bXNodjogTW92ZSBwaW5uZWQgcmVnaW9uIHNldHVwIHRvIG1zaHZfcmVnaW9ucy5jDQo+ICAgICAg
IG1zaHY6IE1hcCBwb3B1bGF0ZWQgcGFnZXMgb24gbW92YWJsZSByZWdpb24gY3JlYXRpb24NCj4g
ICAgICAgbXNodjogRXh0cmFjdCBNTUlPIHJlZ2lvbiBtYXBwaW5nIGludG8gc2VwYXJhdGUgZnVu
Y3Rpb24NCj4gICAgICAgbXNodjogQWRkIHRyYWNlcG9pbnQgZm9yIG1hcCBHUEEgaHlwZXJjYWxs
DQo+IA0KPiANCj4gIGRyaXZlcnMvaHYvbXNodl9yZWdpb25zLmMgICAgICB8ICA1ODkgKysrKysr
KysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLQ0KPiAgZHJpdmVycy9odi9tc2h2X3Jv
b3QuaCAgICAgICAgIHwgICAyOSArLQ0KPiAgZHJpdmVycy9odi9tc2h2X3Jvb3RfaHZfY2FsbC5j
IHwgICA1MyArKy0tDQo+ICBkcml2ZXJzL2h2L21zaHZfcm9vdF9tYWluLmMgICAgfCAgIDk5ICst
LS0tLS0NCj4gIGRyaXZlcnMvaHYvbXNodl90cmFjZS5oICAgICAgICB8ICAgMzYgKysNCj4gIDUg
ZmlsZXMgY2hhbmdlZCwgNTA4IGluc2VydGlvbnMoKyksIDI5OCBkZWxldGlvbnMoLSkNCj4gDQoN
Cg==

