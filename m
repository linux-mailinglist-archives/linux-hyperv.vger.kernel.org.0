Return-Path: <linux-hyperv+bounces-7248-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 65787BEB151
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 Oct 2025 19:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 729F64E2F29
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 Oct 2025 17:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9772E4254;
	Fri, 17 Oct 2025 17:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="oIR389//"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azolkn19010019.outbound.protection.outlook.com [52.103.12.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D18306B01;
	Fri, 17 Oct 2025 17:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.12.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760722442; cv=fail; b=ipV0cOlljYg4WmsGn8dB4v4AMtlZDls6ZuPNrvuoNCNjB6NTqVf7sH6H5Z4O7qiAcLkaPp7O2UjcsT6j54YbHXW1cjdXquRwm80tyRnbS805Xnc4FA+VrmVur9ZaK2O2bnanSPbus1dDfhch5q6aP4wlxPc4xbdl0E5oh+U6pWI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760722442; c=relaxed/simple;
	bh=CCKkQmYvDxjvl9m8iEYRLoqBvdMVeTtS9aJWI1W0lkM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AYzBckKcF4Q1MQer1vsVIWTWV2JETgsYu7ZMH5YMMKOfb0ZCgLTcPsysQnxlqPxaw/CoVIPk1abNoU8jphjZ5uq0JnMRXeEeTa5KMPmp5tGuR0VHYZzVlZ9qpNHxCIRlw7uByBSjFu+0LHFspJqiYp4swmw9UMnVZ2WfAQixwe8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=oIR389//; arc=fail smtp.client-ip=52.103.12.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fuaYkx1CKoqRYsVgU62coBAQ1Ni+idhZb35lZsD8Ya8LTIimdo/t4T83P3YoXUlPYyuy4WAJKqLQCOU9fuL6OvvaAPy6UCyTXVkVxMBr9YFOR7rn892SeMjz7TW9srZ9R4DxhBgTK4cv0029AAoiBVu3NRY/IxPbzP5F7/7QbeG7KT0Yc7G3VMcA2LZUHZQmIqx1k3hGUC7K1XrCxHDd6NaPGNz/cv7GwtN6/Wrz4wL5kZ+eBuzoaIcTsePFKlpWMPwOUDZhTYFzCdP5efHOmXQYV5lUntZ67/xaxGr26UQrvTPACmtRPVcBjmxX2cOSM/iAtfs1EA7bvX5AcECfsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CCKkQmYvDxjvl9m8iEYRLoqBvdMVeTtS9aJWI1W0lkM=;
 b=q/8PdQNSsezIS1OQTGHuGXWl2kDNgYZOCp08sDVqxYLn20hrrBGUlbzqFKWIFhG2tIArf5uXW174JHCQm/A+sXOmIEPXiI/4dcVBPPZCuc9g3erkXZyS36sikRNXdUg5+/RmqOHrdRHVN0StHGMduroGcu6SpxkxGAgFAAj/M7OsoOVym4pz5fHhINCPdOjVc1ntXyp8NyE0O2mNvvL46W47zI0tUeJvwqhTNQdAQL+j+dgvrsVvfuvSTNX0u8kbjBaxY0AZSkvrQLTanbfxbb2Bxg2ClYbGSnZ0TLwLqllVs4p35zUmDIdc9f7Cl69KLnrJxT16CGVICh5kjPQoJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CCKkQmYvDxjvl9m8iEYRLoqBvdMVeTtS9aJWI1W0lkM=;
 b=oIR389//nuT71GMTRyt0Ylvwr7Mh6tMQtSzYUZsQiPxf4gmfmuQ+VIq4vtBIffFQOAjokLTfURmnUImAaIT0G/VzF5UY4TlxEhhJvoqAXDd1fDM/iszG4hhrdtoz9m99Cwva0NQ5hQl76JyBG98hVIK9H2vmOVEPBbcX0srgmgrjqlwbCfbHC1RT6ZwBJ/dQ7E/xyN7Vzd4QHEbN7lwL6WWhLPrFg+kQ4Fxsfa8mkX3VpvaIKqZWaoHgJMM/CVwBCshRtVMvJczU4r1ojVufcw3MjCWIhEt2UX8YDHW00poudRsrEahXO4wCRJWahPbLn7Mt0lZoMxRdCx0mV8/7Pg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by BN0PR02MB8029.namprd02.prod.outlook.com (2603:10b6:408:16c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 17 Oct
 2025 17:33:58 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%2]) with mapi id 15.20.9228.011; Fri, 17 Oct 2025
 17:33:58 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "arnd@arndb.de" <arnd@arndb.de>,
	"mrathor@linux.microsoft.com" <mrathor@linux.microsoft.com>,
	"skinsburskii@linux.microsoft.com" <skinsburskii@linux.microsoft.com>
Subject: RE: [PATCH] mshv: Fix deposit memory in MSHV_ROOT_HVCALL
Thread-Topic: [PATCH] mshv: Fix deposit memory in MSHV_ROOT_HVCALL
Thread-Index: AQHcPtae4hOlmQ8RLke3rh0l8QIZ4rTFhImggAET5oCAAAFWcA==
Date: Fri, 17 Oct 2025 17:33:58 +0000
Message-ID:
 <SN6PR02MB4157EE75A14F5F7EA7D6D070D4F6A@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <1760644436-19937-1-git-send-email-nunodasneves@linux.microsoft.com>
 <SN6PR02MB4157E6D02773A9D7A4B9E85BD4F6A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <a0090bbf-08b4-4b36-8cf2-18687a83ee8f@linux.microsoft.com>
In-Reply-To: <a0090bbf-08b4-4b36-8cf2-18687a83ee8f@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|BN0PR02MB8029:EE_
x-ms-office365-filtering-correlation-id: 1716e98a-13ba-4f68-4f74-08de0da35a7b
x-ms-exchange-slblob-mailprops:
 ScCmN3RHayF0bP0FcI6aESyZnZAIXMvqjFwUcQUbKcBzF0ergSxPXXcgeB4LKe+rEvRSrAt7F5e6ah7/ZySaDYRa6P1s2/VX5oEo0MeEc9ktfSW58Vxk6ji0UheAP7jFiuqkOFt8cq6t97Ts93j6S6RmsfUF2B1z3oN5D21uaQ/80xDr6nm61YuUGwacme9DlUIbdUxmeekqY4Jqb5R6Z9xFol5rnk16B2Kz2oERt6xpe93JtayCc45ZpJiTybB4qPpRyRROsG0IrxWYyoL8oOTyuw0EKDpR9WIBV9ePpOLzpy/Qnu/iZt37tP9T2Hn4gb+zzROUwPkfzvVBwpM7I3N6ttQpbBMyajb5+DCwbaxzRUXrzMTLTIOdxMuntQcZCg9kknAKK92OOqmaElfa37P8wwCBOu8fCXqEat13dG8/wv0ms7949rE29G37u1kt78uBH56V88x6gshXZWUAiq912vr8JRqKYpiGCQ8IZRLdIc2RdpVXphrOKLPo9v6tG1VT05n8cJE6l8+9A3lyhSAzesKca6X52TyEmZi2MYH5RweAms6ivElHVyrZSgp/6t6YM+PvQiMlLyBsS25f6yGgd2E5HKQkVvT04mvbM3jrSwlLvR254V8A1w1TjkT281Xyd6fcmuaGKLHhVf2yk0Nt4+me2VfcFr8X00A6csb1MAYsmW3eYlSCGDykLLcojAaMnTtsw1cYcSw9viwg0CeBtpiGvtzKxpZk2PTXwJ8=
x-microsoft-antispam:
 BCL:0;ARA:14566002|12121999013|461199028|31061999003|13091999003|8062599012|8060799015|11091999009|15080799012|19110799012|3412199025|440099028|40105399003|12091999003|102099032|56899033;
x-microsoft-antispam-message-info:
 =?utf-8?B?MWQ4TDZjVWdadC9VQW5PYWluZlZROVNVQ3MveExDRllmWC9KRzBXWFYwdnZl?=
 =?utf-8?B?RkQ0bVIweUhKdzQrNE1YYlB4d1J1T3NiVnlySWZ4OFdZT1Fib2E2QnEwaEIz?=
 =?utf-8?B?OWxSUzVlZ0hEaXZVN0VEd2hDUVNCemdwcVJIaVdYV1dEbTV5dE1EMnlRY1Ba?=
 =?utf-8?B?ZXpWSnAvQW5ZMHUyY1ErRWdjR1BQYXYzK01xVGtIUUhlUW5TY2FmZEliWkJ1?=
 =?utf-8?B?VG14UGZWNXVqTG11Yk4yUjdhMEJ4RitLblRZZE1YZnkrRmt2MWFEL3QrV2lv?=
 =?utf-8?B?MjNFS25wdjBxYkRDNUZtQXVPaDdaYi9IU1REQUlrK0djWnZjVko4MDN0L3NB?=
 =?utf-8?B?NXUvQzZOYVQvem5kZk9lSEx5emdLMnBsa0Y1WXZCaVg5cmN0WDY4Qk12bzBu?=
 =?utf-8?B?ZGNUWFFDeWxQbGVjS0RtWE5LczlFT2Iyb1Y5bW9zZDdVd3c3V3l4NlZiNDc1?=
 =?utf-8?B?cGRVSmNNQ0xhSlFSaGk5VkgyNzZRVVd2bGJOSXpmTnk0SjY1V29WN3hRdjhK?=
 =?utf-8?B?bi91VzgrMFVwQkhrNkZoTzRFUkwyUk1acGx6cFMrUnI5UUdSTVdJOTdIU2R0?=
 =?utf-8?B?OVRFMFJRUDVQRnZVUUpzVkdVdzkycVVSQi9TcCtiSnNGQy9EeXFnSHhVMUwv?=
 =?utf-8?B?aktQSWNua1cveDY2MXhiK0tBd3lFSm5ZVGkyeFRTc2E2RXorRDR0TkZlKytT?=
 =?utf-8?B?ZDBHNVBnb3RZQ1VseW5ySzA1dm5hb1h4TkxRZDdiWnhyaDNpNVBhYXYydk5p?=
 =?utf-8?B?UDZUdzJWREZhbUsrU0xoUnk4U2wxUTJPMjRidy9OWFA1VDZpT3VWeXVNY2ha?=
 =?utf-8?B?OTBjb3hFZWUvVU50L0ZQSURhSkg4aHhJNTRkYjRDbmsyWjc1UkwwNkFvVlZo?=
 =?utf-8?B?RllHcE5OVVpzbFhHRmx4SVlEMlJ0b0VrNHM4WXZtVDBNTHlVekozT2J0c1JL?=
 =?utf-8?B?TWtRMWRUV0dvMXl4SjQrMC9nV1J2dGhnVkNLRXBlVDVFVmJ6cGprMzhMZnZD?=
 =?utf-8?B?SUEyWW9JV0hldGxnYU1XUHkrVGtTV01mMFBSYTRJSUJGYWZidzd1d0EvSFdU?=
 =?utf-8?B?aGpTb1ZiaWc4KzRwOWJBd1hBcEdZa1psTDIxOWxSeWdiZjg2Si9tSWtubllY?=
 =?utf-8?B?cmlEekRKWWk0SEVMTXRob3hNaUIrWkRXNGtReTFFQjZlSzZ3Z2QxM1kwK1VI?=
 =?utf-8?B?OUhrOXZ6U1dwUFJ4RjBUSGJtQlkzZTFDN1I0WE14a3o1VDVVejExcFNYOTBK?=
 =?utf-8?B?MnRWcG82TzN6Tk1qNU9UaFlzRFNldFV1dEpqMW16eVhwM1ZTa2dxa2RTb3kx?=
 =?utf-8?B?aDhIcEJpS2d5NEY3L1JBV1BkdGhEY09RdzlHQ0o3Z3dheUFBODBrSVZYVWhv?=
 =?utf-8?B?MkxWYkR3bVRJRzVUV3VTQW82Z0VTYWRUVXVrWjN5cjhlZG0ya2hkY1FzeDJY?=
 =?utf-8?B?OCt5YXA2dTY3QTVQcUJTd0FEbFhRcGFlaTF5a1gzaHhFZWZGQXhQWXNnTmYx?=
 =?utf-8?B?MFdFdnd4K21RbWtBbktGd3orMW9zUkRkUFkzSWh0bU54bHpQL1M1ZTI0S2JB?=
 =?utf-8?B?bGMrT3hqYWNlNmIvWldTOTRMRTV1eHVubENqZXQ1QkcyTHRQaWZTRXVId3RI?=
 =?utf-8?B?QXhabW1Ob0NJYnNGMFgwUEdBTXdTazZHbk9kb2N1dlpuY1M4aEdGYUswbFkr?=
 =?utf-8?B?U01NeFdBVU9pa3V3ZWpjTVBud0lYSEt1M0tLOFVVQXo3blQ2UkZtdFJnPT0=?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?R29SNk9va3hrT3Bqa3F1TTlVVTVacUlCU3JoOGFKREN0VVRqRmhwK21qandX?=
 =?utf-8?B?bCtQRGxjS0Y2VDhWQXdQdk5YeEVzQmFZU0Z3UnYwZGE0Q3dhRlBIR2R1VWdM?=
 =?utf-8?B?R0JKQUt6MlkxTlcrMS9tNXlBem5vazE0b0JDRWZWK2JlMnRRNTBGOTJXTFlT?=
 =?utf-8?B?WWVWeEt0ek9GQXR3T0RwZ3JDTGlMaWU0andYN21pZVFTT1l2Nk9Rc2VGazZR?=
 =?utf-8?B?NE12c3J6VEErcDZyVFRlSnNtNXg0R0hYbC9xUWN6R01NU3pBNW5nZzR5Qkxp?=
 =?utf-8?B?SlpsTVY3NXVRdWJPdjJoaDRWOXAzWVRvMGJaS2oyeEhTYjZNVG1vK2RBekhL?=
 =?utf-8?B?TzBsZzluTE9qL1hzVDY0RmVZSG5iQi9TMnRkazFITzdsNStGdnU5OHJwa2Ns?=
 =?utf-8?B?NjlMeFNZYTBla1Rvd2dJWSt6a3MyUXJ1U1pmZmZ6dmp3dUZlS1lqM2YzNDBH?=
 =?utf-8?B?RFA4TUZBc3RXU1FFcVZZb3BIek5XVG5xOEZYczhMZ0c5ZjJFR1B5dTJ6N2xi?=
 =?utf-8?B?a3hjTm5McjBUZHNBdVZZMk5jNWw2R1V0T0tDYlBud1B5UStXSFhKSEowb3Fj?=
 =?utf-8?B?VmRWelE3WFI4WlNIMXdOK0c4V0R5Wmp0Z1R6bFNRU0ZMZy9SZm1xQnhDUmtt?=
 =?utf-8?B?NlRaeGpsMXlyVDBobHl5M3hHbGFqM21yL1VQS1labFgyTGxLakl0c0hSL2pX?=
 =?utf-8?B?bjRXbWd0M25QcU5EQjdaQjNnOEttb1RnSDRNakxuVE5naSt2UFVhNmlOa3l0?=
 =?utf-8?B?QzMwcllMcXE3NnJTQzZyU0hXVEVjQTVrSEkrelJOVDFzQ2ZnMDh3OVV0S0dK?=
 =?utf-8?B?MVMyVllQTGdiOXdROXFtaTNQY3ptSFZpNm5qa04xcGx0UEMzcml1ZUtGb3Bo?=
 =?utf-8?B?TnM4akRrU25IZUN5Z1lDTE8vcnpVNlREdTBqU0l3ZlZHZjVvdVdRbFFQbVYw?=
 =?utf-8?B?ZEczUmdNV252WFBrd284d2FOSC82WWZVc3ZTVUV0ZGJrN1JqZnNORDg1ZDBG?=
 =?utf-8?B?UTVJRzBLS3ZDS2YyUWNyV0QwVmJ0ckNVczRGaWNxSk1JdDFQRGpTUDVEbDRx?=
 =?utf-8?B?VGQwelI4QlpSQTBhakZnck9ENTZtY25XU29aNTFXSXNBQXZESWhUNVhRRHZq?=
 =?utf-8?B?VGxyNkJNbjdkSkdvVG9Qa2hHenpWbTRYSjlGNDRVaUpQeGYxSHB4ejV4WTd0?=
 =?utf-8?B?cVcra3Y2WGgyVTRDeTQ4S3NWeGtVdllxakV3L3V3QzdjSis1b3ppV0J1WkFj?=
 =?utf-8?B?VE85SmFXL1RXYlRxeWppa1JkcjN6b1NyNXNDV25hQ09ZNFY3S0RqeGhIM054?=
 =?utf-8?B?Rmk0U3lxNHpISU5vNG5KTm56RWIycFI4N0prOWljd21jeitlOUN5OVRuQ1hM?=
 =?utf-8?B?Ny93cWcyM25PSVVSVi8wc1JSMXRTL05HTjc1cTlQaDNNYzU4MnRuZHhTaEtJ?=
 =?utf-8?B?RmExUU1BYlZSZmlqK2t6NC9PWGcxaEhlTmNwNjAyTnd3VUUwek5xdGowdEhn?=
 =?utf-8?B?bEpOV21nbnhzcUUyNU03NjNvREZKU1hMcC8vbFFUV0p1SDVIRG02NnFUdzUr?=
 =?utf-8?B?MmZVWVVRU1VWM01LeGVCNFpLNGlKdk5XSGhOQkhLT0p5TGZCM1Y5QmhMMGg2?=
 =?utf-8?Q?IwbP1jrvmE1wKVwbQh9vSZTKR0WArDOZ7jHyTyQ1CgAY=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1716e98a-13ba-4f68-4f74-08de0da35a7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2025 17:33:58.1732
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB8029

RnJvbTogTnVubyBEYXMgTmV2ZXMgPG51bm9kYXNuZXZlc0BsaW51eC5taWNyb3NvZnQuY29tPiBT
ZW50OiBGcmlkYXksIE9jdG9iZXIgMTcsIDIwMjUgMTA6MjYgQU0NCj4gDQo+IE9uIDEwLzE2LzIw
MjUgNjoxMiBQTSwgTWljaGFlbCBLZWxsZXkgd3JvdGU6DQo+ID4gRnJvbTogTnVubyBEYXMgTmV2
ZXMgPG51bm9kYXNuZXZlc0BsaW51eC5taWNyb3NvZnQuY29tPiBTZW50OiBUaHVyc2RheSwgT2N0
b2JlciAxNiwgMjAyNSAxMjo1NCBQTQ0KPiA+Pg0KPiA+PiBXaGVuIHRoZSBNU0hWX1JPT1RfSFZD
QUxMIGlvY3RsIGlzIGV4ZWN1dGluZyBhIGh5cGVyY2FsbCwgYW5kIGdldHMNCj4gPj4gSFZfU1RB
VFVTX0lOU1VGRklDSUVOVF9NRU1PUlksIGl0IGRlcG9zaXRzIG1lbW9yeSBhbmQgdGhlbiByZXR1
cm5zDQo+ID4+IC1FQUdBSU4gdG8gdXNlcnNwYWNlLg0KPiA+Pg0KPiA+PiBIb3dldmVyLCBpdCdz
IG11Y2ggZWFzaWVyIGFuZCBlZmZpY2llbnQgaWYgdGhlIGRyaXZlciBzaW1wbHkgZGVwb3NpdHMN
Cj4gPj4gbWVtb3J5IG9uIGRlbWFuZCBhbmQgaW1tZWRpYXRlbHkgcmV0cmllcyB0aGUgaHlwZXJj
YWxsIGFzIGlzIGRvbmUgd2l0aA0KPiA+PiBhbGwgdGhlIG90aGVyIGh5cGVyY2FsbCBoZWxwZXIg
ZnVuY3Rpb25zLg0KPiA+Pg0KPiA+PiBCdXQgdW5saWtlIHRob3NlLCBpbiBNU0hWX1JPT1RfSFZD
QUxMIHRoZSBpbnB1dCBpcyBvcGFxdWUgdG8gdGhlDQo+ID4+IGtlcm5lbC4gVGhpcyBpcyBwcm9i
bGVtYXRpYyBmb3IgcmVwIGh5cGVyY2FsbHMsIGJlY2F1c2UgdGhlIG5leHQgcGFydA0KPiA+PiBv
ZiB0aGUgaW5wdXQgbGlzdCBjYW4ndCBiZSBjb3BpZWQgb24gZWFjaCBsb29wIGFmdGVyIGRlcG9z
aXRpbmcgcGFnZXMNCj4gPj4gKHRoaXMgd2FzIHRoZSBvcmlnaW5hbCByZWFzb24gZm9yIHJldHVy
bmluZyAtRUFHQUlOIGluIHRoaXMgY2FzZSkuDQo+ID4+DQo+ID4+IEludHJvZHVjZSBodl9kb19y
ZXBfaHlwZXJjYWxsX2V4KCksIHdoaWNoIGFkZHMgYSAncmVwX3N0YXJ0Jw0KPiA+PiBwYXJhbWV0
ZXIuIFRoaXMgc29sdmVzIHRoZSBpc3N1ZSwgYWxsb3dpbmcgdGhlIGRlcG9zaXQgbG9vcCBpbg0K
PiA+PiBNU0hWX1JPT1RfSFZDQUxMIHRvIHJlc3RhcnQgYSByZXAgaHlwZXJjYWxsIGFmdGVyIGRl
cG9zaXRpbmcgcGFnZXMNCj4gPj4gcGFydHdheSB0aHJvdWdoLg0KPiA+DQo+ID4+RnJvbSByZWFk
aW5nIHRoZSBhYm92ZSwgSSdtIHByZXR0eSBzdXJlIHRoaXMgY29kZSBjaGFuZ2UgaXMgYW4NCj4g
PiBvcHRpbWl6YXRpb24gdGhhdCBsZXRzIHVzZXIgc3BhY2UgYXZvaWQgaGF2aW5nIHRvIGRlYWwg
d2l0aCB0aGUNCj4gPiAtRUFHQUlOIHJlc3VsdCBieSByZXN1Ym1pdHRpbmcgdGhlIGlvY3RsIHdp
dGggYSBkaWZmZXJlbnQNCj4gPiBzdGFydGluZyBwb2ludCBmb3IgYSByZXAgaHlwZXJjYWxsLiBB
cyBzdWNoLCBJJ2Qgc3VnZ2VzdCB0aGUgcGF0Y2gNCj4gPiB0aXRsZSBzaG91bGQgYmUgIkltcHJv
dmUgZGVwb3NpdCBtZW1vcnkgLi4uLiIgKG9yIHNvbWV0aGluZyBzaW1pbGFyKS4NCj4gPiBUaGUg
d29yZCAiRml4IiBtYWtlcyBpdCBzb3VuZCBsaWtlIGEgYnVnIGZpeC4NCj4gPg0KPiA+IE9yIGlz
IHVzZXIgc3BhY2UgY29kZSBjdXJyZW50bHkgZmF1bHR5IGluIGl0cyBoYW5kbGluZyBvZiAtRUFH
QUlOLCBhbmQNCj4gPiB0aGlzIHJlYWxseSBpcyBhbiBpbmRpcmVjdCBidWcgZml4IHRvIG1ha2Ug
dGhpbmdzIHdvcms/IElmIHNvLCBkbyB5b3UNCj4gPiB3YW50IGEgRml4ZXM6IHRhZyBzbyB0aGUg
Y2hhbmdlIGlzIGJhY2twb3J0ZWQ/DQo+ID4NCj4gDQo+IEl0J3MgdGhlIGxhdHRlciBjYXNlLCB1
c2Vyc3BhY2UgZG9lc24ndCBoYW5kbGUgaXQgY29ycmVjdGx5LCBzbyBJDQo+IGNvbnNpZGVyIGl0
IGEgZml4IG1vcmUgdGhhbiBqdXN0IGFuIGltcHJvdmVtZW50Lg0KDQpPSywgdGhhbmtzLiBZb3Ug
bWlnaHQgd2FudCB0byB0d2VhayB0aGUgY29tbWl0IG1lc3NhZ2UgYSBiaXQNCnRvIGNsYXJpZnkg
dGhhdCB0aGlzIHJlYWxseSBpcyBhIGJ1ZyBmaXggYW5kIHdoeS4gSSB3YXMgbGVhbmluZw0KdG93
YXJkIHRoZSB3cm9uZyBjb25jbHVzaW9uIGJhc2VkIG9uIHRoZSBjdXJyZW50IGNvbW1pdA0KbWVz
c2FnZS4NCg0KTWljaGFlbA0KDQo+IA0KPiBJJ2xsIGFkZCBhIEZpeGVzOiB0YWcgcG9pbnRpbmcg
YmFjayB0byB0aGUgb3JpZ2luYWwgL2Rldi9tc2h2IHBhdGNoLg0KPiANCg==

