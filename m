Return-Path: <linux-hyperv+bounces-10140-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kKXWIPhb3WmadAkAu9opvQ
	(envelope-from <linux-hyperv+bounces-10140-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Apr 2026 23:11:20 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DEB93F36F1
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Apr 2026 23:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2C49E30172CE
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Apr 2026 21:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F8F30E831;
	Mon, 13 Apr 2026 21:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="uyH25iFv"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazolkn19010046.outbound.protection.outlook.com [52.103.7.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5FD40DFA7;
	Mon, 13 Apr 2026 21:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.7.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776114485; cv=fail; b=RZekvb1HZLTKquMk/9Zn2mAmphmxCc73ijAyD/ne3NsL/PeIeA+Of3aa2TR911bgdlhnuobJ6CS1CKJltaNYKiWtUMrfw9D3WDI3p4rTG6cxAUJ2BSvl33YEYuJqo0DCJ4dtua/QlNd8wJZtTaGUTxuGvQVNmjUYYcoamCuAjJo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776114485; c=relaxed/simple;
	bh=JBrLGyfWtpyYiKL+S70m27Hf+oBqYOKq74iP6WfIaCI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=umGkIbzDOlanJ1tV0qrc/PljN5De8Wylsl2pd2eQYcEZcdlvAiXxqkT0EakPjnLC6IoYu0T7bMUqgaQ82nHnOTb/9m55YevaRldLSRdQ6Mh8u7QaGrqlCh9ijtdIHB/ODDNz4l972U8OXGzR2WLtgJbVqZ3L5kvOUoPptS9AexE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=uyH25iFv; arc=fail smtp.client-ip=52.103.7.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JEA2BUuL9II80B3ZAVmlxD1I7IdhkRS+Jf154Zk44Z8Bo6u/xX/37srvbGET7l7710J0bkbjXHsAnho0lAfVt3cmpn5nK7c8/2AlG94XpB1bKwSXAS7qFZsuNov03FJuZeHP8RNI6YXnQt1Fo+WQ0O4Pbg2D9YJJIwzsXu4LWSckmBTmWWAUT9Wh9TEP11dfdC/CXgayz4lxOnHTcWqhWbyYk4RVWx/0Tx8J7Ziga85oFfa31wcGULq/DbLOpsCvyZjSYfgBox73aAEwR7nu9G5P5ANVdbXeMhTj9CzWxs0XuXgAtL3TFnwEvNhF4eXmXIohvXT/x8Tgj33qS4CmNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JBrLGyfWtpyYiKL+S70m27Hf+oBqYOKq74iP6WfIaCI=;
 b=jfmpEBLUSBkflchZj5/W8pf1cQ/Qv9gKhzfWsO+H3HyJpSlzQW3cwR1Wg9O+xn2yy5MFVKwu8pAQGRdzzMuO/8Srnjm3ic8ivzVG4bNao8lX7YR+r3k48J9o91XuTNQdFNUUpVzuPlZjhYD2A0dFUGWwlRHrG2+4F14uWi9VB+XvvzW+0o8uvM9PVjgCPDeIWZLq0W+/CS4FUN7nCStagXNcw/1QnvnzyQOcYWxkT1mKKvHVyPEHKahcL0EI3xDdezT2wsb4iTeaAYVWfgt8d6Mqm/YLMGR1UyPUZU+yEt4vhDp5X07yxRy4F9HwVapwqDVkxPOOIhOlyJZweKfmIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JBrLGyfWtpyYiKL+S70m27Hf+oBqYOKq74iP6WfIaCI=;
 b=uyH25iFvlTgE1wSFgaV3fXCAAfHazLyY0r2k9txK8Dpwlme/GhgaqFBdiz1oflgUXem9FHvTpNgCN/PYxNjq0408/PAj+deCcBlgGbblMkFQNbWg+NDpncQXG0hSVRjT7NeIrz5yLvdk+lknDUo2odZVXYqXKWP4AotQv9Vkku8gxWsNzCG9AZxfAMbyF1r+hMdGO72JqQY0LKTA8gAeapp45YS4my21WV+bD5AjyCBQndmn/MEoxzBGlunjBrkc9hM1EvK6D8Qp9d+2x0Azx0V7x0wV/saqfhWOs3kpBMSCoOARL9JlO3orelaKlvUGEmZ03c6D+p1qY9sOvGn6tQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CY5PR02MB8943.namprd02.prod.outlook.com (2603:10b6:930:38::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Mon, 13 Apr
 2026 21:08:01 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9769.046; Mon, 13 Apr 2026
 21:08:00 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	"kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "longli@microsoft.com"
	<longli@microsoft.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/7] mshv: Refactor memory region management and map pages
 at creation
Thread-Topic: [PATCH 0/7] mshv: Refactor memory region management and map
 pages at creation
Thread-Index: AQIU4Z+TtrNiAr8jNsFOwdDCIL2bZLVtTnQA
Date: Mon, 13 Apr 2026 21:07:59 +0000
Message-ID:
 <SN6PR02MB4157920DE623A9B2C613D282D4242@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <177490099488.81669.3758562641675983608.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To:
 <177490099488.81669.3758562641675983608.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CY5PR02MB8943:EE_
x-ms-office365-filtering-correlation-id: ec1edfbf-cdae-4bae-8600-08de99a0be53
x-microsoft-antispam:
 BCL:0;ARA:14566002|37011999003|15080799012|461199028|13091999003|8060799015|51005399006|31061999003|8062599012|19110799012|3412199025|440099028|26121999003|102099032|40105399003;
x-microsoft-antispam-message-info:
 =?utf-8?B?dURpdDd2WVljTHBEL1djMVQyUHc3N2l2aFcyRGhPbUdrL1JDckVtRCtKdkpk?=
 =?utf-8?B?dXFhb0U4dmdrUzBDUy8raHVpNGhJTmtNbkl5QVdxQ0tUQkZjQSs2UkQvSW1r?=
 =?utf-8?B?NmcrZWxrWFBhS1NTZElWdTNqVFhwY3Y3NjlIenVZNUdsTlhCYmY2Sm1LWVFt?=
 =?utf-8?B?bFgwRjNhNVJKcUFVZkNhRWVhbUdaZ2ZWVXR6R3MwcFdOTEtCUVNMWXRJYUNU?=
 =?utf-8?B?VUdTTGhHdm0zYkNvZFoxdFRZVHJ2VEh6YU5YRkYrYTJRcE9RZ3RQOE9NMXBK?=
 =?utf-8?B?ZXBrcTM2T3l5SXBjcXRSbDQ0SnlOUDJKL3FQK0FDYk44ZXkyWEFjRE5aQzBY?=
 =?utf-8?B?Z2pMM2JGUmtqS1pXSHhxa2xkdkpldk9va0JKZVM4Q3FWOG1EcFBHdzI5NWE1?=
 =?utf-8?B?WExxNUxRUjM4emJaQTNWNER2ckVmRnJaZ01yTXlpZ3ZnOEplUkFnNlRlcmFY?=
 =?utf-8?B?MW81M0dQOFI0S1kydDQ1cUV5aFZnNWZpYTN0M1d5UGxJTG1pemdTMk1NdEw0?=
 =?utf-8?B?WWhoUENTVktYUDhBVVowK280SldNNlZZYWx5VWs4eCs2WjJlazV1ZW5Gd3pr?=
 =?utf-8?B?UXEzZXV2TlNUcmNFUlNwQXJPSERsWUliN0FDTG4zcjdCMm5uRkhnNGlSb3p0?=
 =?utf-8?B?aTVxMWEySFliU2xXTHg3QkdXWmxRNkFLeTZ4Z3N0dnF2bU1oVEFWT1V2NHZJ?=
 =?utf-8?B?MlRyNlByRmNwbXA0MWVyN3AzRXBhUGc3TWNXeDkyZncwYS9qTXljTENDUDl1?=
 =?utf-8?B?T3U2WE1ZcDUxWlltM1NoQjNFOE1YT1U5OFlVTlVGaC9iMmUxYk1DOEE4UjFj?=
 =?utf-8?B?NFNBaE5mbUswMWR3UTIwUVdEYWFhakJQcVFuaHoyRDcyODBBWTEzUjlkQlN0?=
 =?utf-8?B?WXRWKzJOeGpCSCswKzIwdStldHNhQWc0dkhZU1RIUjc3QmhXOXdvQjExMHF0?=
 =?utf-8?B?S25WOXhyanNqRmp5TmdXSjJGWmQyMHUxQkdmVVRvS3lXOXdUenkvdVRyN3I5?=
 =?utf-8?B?eFRXTnc3aWJsRFo4OGxsNWtybE5DbjVsUGF3c3pGY2NzZ1FNb2NBSkdaQzFh?=
 =?utf-8?B?MzB5RS9BRUhwMzRmZ0owMEpjTmpLeE5zMjVZNmJRb3lEclozOS9uV2luM0Y5?=
 =?utf-8?B?U0xCS0Fqc3BJZVJIWnZwa2ZOWnFic3NjKzlNQ240Y0NtS3B6azQvSS80UlBY?=
 =?utf-8?B?cDJPc0doTEkrbEJOTVBtYmNCbDRuOTNhVkNQY09Pem0wcWlSR0grelhqSnBF?=
 =?utf-8?B?cE8rcmxxbFJnUjRiVWZrVFdYZ1c3bm5XWERkVHU1Q1FPQjJWb2RSNWZ3NUNB?=
 =?utf-8?Q?/K/xn7BPEZHlaW1HGlSrH558Rvemos5Rqd?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?V0krVGtHaG80QXBsZEppU2d5dXRUYzU1aDZBa3Zqc2tDai9DbkFSL3pRS2E0?=
 =?utf-8?B?S245MXU5Mm9kNFpzRVdJK1ZYbVErTmMyTXhqWjhsMEpqM3ZuRnRXQzUwYVZI?=
 =?utf-8?B?M0VUNnNwR0Y0RkpVb09nL21kUmIvU1Rmck1sdFN0aThVUmh3eG1CdU9nMCtM?=
 =?utf-8?B?NnNwLzdJNXZnUlJVZTUySEdJKytsWkFURmV6TE95WmNwa09LbktqMjQ0TlRC?=
 =?utf-8?B?cHNnQzFEUVYyMzRvbkxONjZYR1MvelIwMHBkWEJpM1FnT3BWNk53R21uUXVU?=
 =?utf-8?B?dWFZb20yTi9lbWp0dTFUM1VBNm5kMGxPenNELzM2UnowNm1tSGhFMGpjR0hP?=
 =?utf-8?B?cExZMi9JbEs5TGg1czVrYWxDcFhmbzdzclFSTHBabzVKU1dSTGxtTlhXbXln?=
 =?utf-8?B?REZXeG9yMGZuNURIOUU0TmwrRmFHWDQvRHFnT1VQTm1QS3laL0FXWFAyTnJl?=
 =?utf-8?B?K1FVNktxVmZndzM0N2tod2tsY3plTE9lZ2VsOXg3NVBvcEVWcTZSOENseFNM?=
 =?utf-8?B?RjZJT1E2TmNlcGlMSVF3QTArVzZEZlZRaGR3L2tLTmhyTEREY0ZScHlwdkF2?=
 =?utf-8?B?aU9XUnI0N1huMWwwM0R1WWJ5NEtXeHF1NCtFNEJzOEdSNm9qQlV1V2dhTFJY?=
 =?utf-8?B?UXo1aUY1VldHdURLK21lQXcvR0dySUNCeXgvamVpdy94azIrYTVkSGRuV3M4?=
 =?utf-8?B?VTVnVkFvQTNqd3NkKytyeE54cWY2RzgwSTdTbFFqNGoyR244UEwvbGc2V2lp?=
 =?utf-8?B?ZWZsZHJsMTZ0dlhncGtGYU83SUUvVFQyTXVmYUNrU2kyS0VYbDU3MnE1N0x0?=
 =?utf-8?B?Q3FSVUsxLzFoZE9lUEY3WitBb2pNSFAvbFIzeE83d1plZituQ3p2Sk5HWVV6?=
 =?utf-8?B?M3MzN1RhOWtRb1ZwSlpqTkd4SXVPSFZvaDNBTFk3NncwSG5tcUR1OGdtbi85?=
 =?utf-8?B?dFFTanNaTHJBSGRBRkpXQXZMcXFLcjZldEpSa2E1RWNkZE1NdklTQ1pNRjJm?=
 =?utf-8?B?SURKU0ovTytJZzlqOGNhaEh3Wjh6a2tLbXRNTzdmMFpBcWJnNFhEbDY1KzRz?=
 =?utf-8?B?dEtiemFTemRJeUt3Vk9sK0VONWJnd0RxZHR3dW1DSldMVnNzZWtDcDMyRkxr?=
 =?utf-8?B?ODNSUHN5M2IyNFdDZ0t4RUtoSXFGWUk2RkVEcXJFbmU3K0hvWGdEbGQzdzhw?=
 =?utf-8?B?Ulc1VmFNNm9SaDhQTlN4a3RYZStxUmFvWG1pNVUyRzRNWGJnQ3FCTHFTN2RZ?=
 =?utf-8?B?VXZlU1RJOVBMbHk1R2Q1OGJRUlNoUjM5Yk5OMm1FZ1BBMTlEaUU5VmtoZVd1?=
 =?utf-8?B?clhXNlBvWDZtYitxNFVlSFA2R2NOaTc0VWxNdE0raFpsVndNb3Y0Yyt1Ump3?=
 =?utf-8?B?blN6dmNxMWpORjh2dnlqTVAxalRrS2ZNcGpZUXY0SEdxWTlIYVhhK3I4dEpw?=
 =?utf-8?B?cGNZaXRiQldPTDZEZFp0Vnk2Tkx0NlJEcHBUTUovYytXb3ZZYWdWZlhmazlK?=
 =?utf-8?B?SGR1OUxEcTkvejZ3WUQrcU1ucENCK241THlzTlpJV0ZSZWFsYnF0WVVGaXNH?=
 =?utf-8?B?Q2ZLR0xrREMyUk9oalFJUlJlL2VwT1ovOVRjTnBDVWg5S29LazNaMXRFUUNy?=
 =?utf-8?B?SElUclRFdGJ1UE9paG02RkNKSWtTN1MxL1FqVnkzUUE2dWpNTlBYREE2Y1lp?=
 =?utf-8?B?VVRtL0hGeVZIVzFhV1Q1NkJ4Z080Vk5GNVE1OFRPTHdJUzVnZ05nQkxsOHBi?=
 =?utf-8?B?WEhOQmRHVHdIS1RyMG5Dek9ZQWtKT0R1WTFmdEc4TnlBUVF4ekJOUWorYjJ5?=
 =?utf-8?Q?rM/xxHDLYJ7ZMu4ygVtMCG6+Aj/0yN+xlYR0g=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ec1edfbf-cdae-4bae-8600-08de99a0be53
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2026 21:07:59.9630
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR02MB8943
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10140-lists,linux-hyperv=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,SN6PR02MB4157.namprd02.prod.outlook.com:mid]
X-Rspamd-Queue-Id: 8DEB93F36F1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

RnJvbTogU3RhbmlzbGF2IEtpbnNidXJza2lpIDxza2luc2J1cnNraWlAbGludXgubWljcm9zb2Z0
LmNvbT4gU2VudDogTW9uZGF5LCBNYXJjaCAzMCwgMjAyNiAxOjA0IFBNDQo+IA0KPiBUaGlzIHNl
cmllcyByZWZhY3RvcnMgdGhlIG1zaHYgbWVtb3J5IHJlZ2lvbiBzdWJzeXN0ZW0gaW4gcHJlcGFy
YXRpb24NCj4gZm9yIG1hcHBpbmcgcG9wdWxhdGVkIHBhZ2VzIGludG8gdGhlIGh5cGVydmlzb3Ig
YXQgbW92YWJsZSByZWdpb24NCj4gY3JlYXRpb24gdGltZSwgcmF0aGVyIHRoYW4gcmVseWluZyBz
b2xlbHkgb24gZGVtYW5kIGZhdWx0aW5nLg0KPiANCj4gVGhlIHByaW1hcnkgbW90aXZhdGlvbiBp
cyB0byBlbnN1cmUgdGhhdCB3aGVuIHVzZXJzcGFjZSBwYXNzZXMgYQ0KPiBwcmUtcG9wdWxhdGVk
IG1hcHBpbmcgZm9yIGEgbW92YWJsZSBtZW1vcnkgcmVnaW9uLCB0aG9zZSBwYWdlcyBhcmUNCj4g
aW1tZWRpYXRlbHkgdmlzaWJsZSB0byB0aGUgaHlwZXJ2aXNvci4gUHJldmlvdXNseSwgYWxsIG1v
dmFibGUgcmVnaW9ucw0KPiB3ZXJlIGNyZWF0ZWQgd2l0aCBIVl9NQVBfR1BBX05PX0FDQ0VTUyBv
biBldmVyeSBwYWdlIHJlZ2FyZGxlc3Mgb2YNCj4gd2hldGhlciB0aGUgYmFja2luZyBwYWdlcyB3
ZXJlIGFscmVhZHkgcHJlc2VudCwgZGVmZXJyaW5nIGFsbCBtYXBwaW5nDQo+IHRvIHRoZSBmYXVs
dCBoYW5kbGVyLiBUaGlzIGFkZGVkIHVubmVjZXNzYXJ5IGZhdWx0IG92ZXJoZWFkIGFuZA0KPiBj
b21wbGljYXRlZCB0aGUgaW5pdGlhbCBzZXR1cCBvZiBjaGlsZCBwYXJ0aXRpb25zIHdpdGggcHJl
LXBvcHVsYXRlZA0KPiBtZW1vcnkuDQo+IA0KDQpUaGlzIGlzIGEgbmljZSBzZXQgb2YgY2hhbmdl
cy4gSW5kZXBlbmRlbnQgb2YgdGhlIG5ldyBmdW5jdGlvbmFsaXR5DQpmb3IgcHJlLXBvcHVsYXRp
bmcsIGl0IGltcHJvdmVzIHRoZSBjb2RlIG9yZ2FuaXphdGlvbiBhbmQgbWFrZXMNCml0IG1vcmUg
cmVndWxhci4NCg0KU2VlIGEgZmV3IGNvbW1lbnRzIG9uIGluZGl2aWR1YWwgcGF0Y2hlcy4gSSBu
b3RpY2VkIHRoYXQgU2FzaGlrbw0Kd2Fzbid0IGFibGUgdG8gcmV2aWV3IHRoZSBzZXJpZXMgYmVj
YXVzZSBpdCB3b3VsZG4ndCBhcHBseS4gSG9wZWZ1bGx5DQp5b3VyIHYyIHdpbGwgYXBwbHkuIEZy
b20gd2hhdCBJJ3ZlIHNlZW4gc28gZmFyIG9mIFNhc2hpa28sIGl0IGZpbmRzIHNvbWUNCmdvb2Qg
aXNzdWVzLiBJIGRpZCBydW4gdGhlIHBhdGNoIHNldCB0aHJvdWdoIENvLVBpbG90LCBidXQgdGhh
dCBkaWRuJ3QNCmhhdmUgdGhlIGJlbmVmaXQgb2YgdGhlIEFJIHByb21wdHMgdGhhdCBTYXNoaWtv
IHByb3ZpZGVzLg0KDQpNaWNoYWVsDQo=

