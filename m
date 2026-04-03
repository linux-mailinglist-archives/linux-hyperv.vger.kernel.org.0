Return-Path: <linux-hyperv+bounces-9945-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UPd5Gwgtz2k3tgYAu9opvQ
	(envelope-from <linux-hyperv+bounces-9945-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 03 Apr 2026 04:59:20 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 03CC2390874
	for <lists+linux-hyperv@lfdr.de>; Fri, 03 Apr 2026 04:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D198230269AE
	for <lists+linux-hyperv@lfdr.de>; Fri,  3 Apr 2026 02:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 801A734EEF1;
	Fri,  3 Apr 2026 02:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="nGPEwNLy"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazolkn19013084.outbound.protection.outlook.com [52.103.7.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3657B3469F4;
	Fri,  3 Apr 2026 02:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.7.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775185112; cv=fail; b=SUb0AYNTyDcMG6y4drgKVJthLmH0Wj7BZnPa6X8spSj/xq8AEK1M/P5Ua9kawCcRBXesVw4zPKJAatl4u5Ezmt3bvLFD3iG+l0xGQRO/ElGxcz+rV/QDO323Xdtqv+QX3Ma7B0B7ou6ub7a4oBJCAGT4kWDnZM+vf+xeHnKec6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775185112; c=relaxed/simple;
	bh=lfluVBYnyW+84LmEqvbEtWjCQvAVWDhRpghmSRvdqb4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Jft0odG45D59qvf2eDe2qD0mizJW2xs+bX0AqzHFP+TPCCMA0EPQ3IX7PNq72pKiXAYG45Q9Uh2r9AFd3iwSWzYM8q9v4ZPlOV1BdSVt8KMhCHth3TK21qOazcO6nGclSKHRRoafB+DE/Y2zxXQbdhIJ5bTEvFhY11PQx7SBK0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=nGPEwNLy; arc=fail smtp.client-ip=52.103.7.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l7UHq02UD9J8RnOqMsQ8rhpn6BJs3xjPQWphWkd6OYlIjkfmLdMAd70/K15ugIiN0Cr4X8DcaBfjgLUr/7sitqxQhmEtsu5XK8jd+U2NzJUTr81Pube1wIG/pPPnjUSdUVcfqJCQd7mphYe5Vf8Ww4In3I1V3Fz/ONzrBAlrqy9z7656ml19IdFcp7ccTwAPNgS70HufeqZkIhekEGWEJD4Y+MhzJBb9nPXHVj4c4aVaY0GoWDSKJrdBzlMX+cz2Rof/HIzEkWR+iQgodHccQp1obSVZ4hvPIj4Y8CW2dJ7uAbCW/u1EryiZmVfEPuTuSgKWmnUw7Rxvi1ZpQTMRgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lfluVBYnyW+84LmEqvbEtWjCQvAVWDhRpghmSRvdqb4=;
 b=p3vs2v+q10Rw4Wbn5/qXJvMkWlcOB/Wu7lHsy+pp8YhMD1O+Wl1GqpMfUFS1BxbunnWR0k6R0789DzzD5Hk5T192fVwkk0lYrh7ha+GXfsonjABwbiGnrQtSMQ4suvgcZf5bWwOb7pEzyqSbp+53cu4mjzFoXTK2rf9niB+xjT0oxtozBqowQvZUE22MJaFo/oMjlQfVCNyRNjlUya2ZCHRAXs78Px8MZN+pZDhcHYsq5/+6xh0CxoeZIaNN8X+tab0ELX8ECSZgmALYJQOtkq90nQLiDms92c9ASWWPLe4CCGQeE8CWyY79vxJkVRWL06obCcBFgmxSrY17PgvY2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lfluVBYnyW+84LmEqvbEtWjCQvAVWDhRpghmSRvdqb4=;
 b=nGPEwNLyovGFsku56EjRlkiC7cscVka1/SveS+6pvsPAVGdpLkx1puzxHU8EcKhJx7yVTh+9kxMU0+ojrFFcrgeYuZp42qKoMoYd77O6N89OzDu9fZ2jhqByURW6mYJU4NW9EYQgjg0aDTA5OzmCOHj0j7HQMTST1ssIk1HJ4DoenXTu7xZMXdViDaTKNSHZjZgagDrIeVPN5pC93vexMYfh5xMn93IUJ2dL8k0khktgm7HW//06KGX2BM+RWyYdd/MRc0mFJri8pyaF6v4VsIlm9UYyeki1DzkgvfhviisTtvTUzAoJrxf67Q6EaBfJRBwOa2xdBipCmWJK8z2YIw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CH3PR02MB9906.namprd02.prod.outlook.com (2603:10b6:610:167::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Fri, 3 Apr
 2026 02:58:29 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9769.014; Fri, 3 Apr 2026
 02:58:29 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: =?utf-8?B?VGhvbWFzIFdlacOfc2NodWg=?= <linux@weissschuh.net>, "K. Y.
 Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei
 Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Long Li
	<longli@microsoft.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 3/4] drivers: hv: mark bus attributes as const
Thread-Topic: [PATCH 3/4] drivers: hv: mark bus attributes as const
Thread-Index: AQIA5n8utbFNLZq9HsGD5u2/wbCFbAGpjWfOtXcR4WA=
Date: Fri, 3 Apr 2026 02:58:29 +0000
Message-ID:
 <SN6PR02MB4157C42A1EAED2893467FAFCD45EA@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260402-sysfs-const-hv-v1-0-a467d6f7726e@weissschuh.net>
 <20260402-sysfs-const-hv-v1-3-a467d6f7726e@weissschuh.net>
In-Reply-To: <20260402-sysfs-const-hv-v1-3-a467d6f7726e@weissschuh.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CH3PR02MB9906:EE_
x-ms-office365-filtering-correlation-id: 75d4b4d3-2301-4c02-3860-08de912ce253
x-microsoft-antispam:
 BCL:0;ARA:14566002|51005399006|41001999006|37011999003|19110799012|8062599012|15080799012|8060799015|461199028|31061999003|13091999003|3412199025|440099028|26121999003|102099032|40105399003;
x-microsoft-antispam-message-info:
 =?utf-8?B?NUo5aGVhck9BR0g4Mk03WXRCNWZoTjR4c1Irb2tLcVlNZ2RrU3ltYWxDMjQ5?=
 =?utf-8?B?UndhTjZEOFZ6MTFMMXRvUzRCM1p1emwzK2dQNlpsNVVmYUQ2bzkwVU54REgy?=
 =?utf-8?B?U0JLK2hGKzZqZWFSVnp0eVM3ZnpqTFZEOWFmM0ljSUF1YkgyTUUyOHJFQVdT?=
 =?utf-8?B?em03VXhtaTdMb1dLcmdMendzbW5Gd1Yyb2Q1c1gvYWxJTmVrYy9jOUVOWjNh?=
 =?utf-8?B?SmRTSXlER2E3b1VVN25PNUhmYVhIN1JZYkhOWmlXZis5YnZPQ0N5a09GOU9k?=
 =?utf-8?B?YloyTDJRVkVEU0xwcndmbUlGbDJVYXBqc0c1b2hITVRKNkQ0WFZ4d3pGS1BX?=
 =?utf-8?B?QlhMREsyMS9YRzAvVzJFS0RjMTV0V2t4RGhlWVBKTitFd2pCWjJaQjYzc3gr?=
 =?utf-8?B?bXJrb2o0YzhVRHZBUlNkN05UcUhiTGhVTmU3TUUvaHh3bm94aS8ydWRxZUJh?=
 =?utf-8?B?OVZMaW02M01QKytRYjFldEUwdlhQcXR4WU1SK1RnYUErdWE2UllQUmFMekRk?=
 =?utf-8?B?eXMvb2F2NmZHZVNjNlhENER1U2s5aXR5eFhKNkIzRDYyNXNoVHFpamlPRWJT?=
 =?utf-8?B?KzhacFlrVjJ0VVB2S0JyQy93OXlWbU1VbnNibk0rM0gyKzVNdDc4L2tRblpO?=
 =?utf-8?B?bWQ2b3ViWHg0QUhHUjNxL21OUHNIRnFWWStYYUNCYjNSWjF6QS9pTHhJMEts?=
 =?utf-8?B?VS9BbERPRGFudnZKNHlCaHUxVzEweGkxdkN6eU15OUpLOUZQQW1vQmRYTE1n?=
 =?utf-8?B?MW1rNDZLaktUVmVZZ2dPV0J6d1FOWEJjWjJYVWZrUnFpK2UydnF4c2xvK2xC?=
 =?utf-8?B?bCtHOU81V1B5R1RWUUVieUNUTGtWYnkzL0xTRzR1am9GMWVkanA4cEo1TXpu?=
 =?utf-8?B?K3VETnlCMlMwZ05iSlpCdkhhMDhpdFl3OS9OMVRnVys1TWFEbEZQczUzdlRr?=
 =?utf-8?B?NWl1S0RqNHRtUlN4YkczbVk2dzg1c3dRT2svbnRaRkZ6WmFBdUZMeFBxQTI2?=
 =?utf-8?B?THNXVEJhMjNhS3hHRlpma1k2MmEvWE1OQzg3VEVoeXY1Sm5ZZ2ZuL3lDQ3RE?=
 =?utf-8?B?c0phWm9Ha0dsd2NJY3FpVWNNejNibEVFeFRpbW81UytOQnEvZTMwRHl1QnR5?=
 =?utf-8?B?MVFkSjVEMXYxMFR2amVRdVdkekhxM3hObmNuUjVHRjN4cHZMOVl1OEVpeWZm?=
 =?utf-8?B?NTVaeWg0YStBVjFFVC9jK3JuS2s4MDQ3dHViREZoUTRkaGUwNlE3OW5nMmZB?=
 =?utf-8?B?S2U0b1hzTllkYitVOTZyZzd2N2hpVW0yNjFEMUxITFhoSmF0MXJNclJldnll?=
 =?utf-8?B?ZVR0aW5WSWtGNXlHLysrUHFza05OREJETWhzUUhPY0xvMkdTaktwbkpnUDNy?=
 =?utf-8?Q?2e6XDVgklv10+ZKPkqPOTTmgAMaCzFU8=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SGd2TlBWZFlLbER6cG5sRHBCM3VUWmJHaUJlRnc2OFJ0bUhURWtPdW1sZVEv?=
 =?utf-8?B?MzQvazQ3b2NYcEM0SFd3eXFncnBTT09GVUJESW5qcCswbStEVkxYUEpUZUlP?=
 =?utf-8?B?cjdKd3ZoVDVhM0VsWmVpTm5oR3J5K0xUbUhKeTc1UnlJaXZCMnRKdnJLRXVI?=
 =?utf-8?B?UTNtSXgyellWT29xem1Zcnc0bUo2STdmYlg0SWpjVUlxUnZhUnNadG5vK0I4?=
 =?utf-8?B?aUtUTHNQYk1jQXBXQ3FMVE13QVQvUlJZcXZnaDZURkNzZElHdVkxalVieURy?=
 =?utf-8?B?RmFJWVEwV3RsWElZVHhLRzZXbHc2NjAxMWFaY21tUTg3RnhIejJIMTFveDNz?=
 =?utf-8?B?WHpxUGQ0QmRMeFBuTGkyTkt2MVkyT0ZSZE94Um9WdU9zLzZKVmQ1YWdRTHNG?=
 =?utf-8?B?UXJ5V1Q1VTJ2WUExKzh5V0x1QSs3dEdadkdQK0pIY3NmN054OVZaWVhZb2lU?=
 =?utf-8?B?bnYzTy9zYk9NMUR3cGRLTzBQYnBJZU0wMWtEVDNvejhkbFJoRVJrdW5SZ0xX?=
 =?utf-8?B?ZEd1L3FMOEJlellPN2daUUVMZXppdWxxT2E0NEtVWWkrZ3FPclN5bHJxY01x?=
 =?utf-8?B?Y0NvTlQ2V2NyQVJJQzVMdlFhaXE5dmdkdVV3Y0plSmZrZzZBODlrbldUVWhJ?=
 =?utf-8?B?UkdmeGw2TWozUGZ1NlFQNDdpZlZDQ3pjbHlGR1RPOUZlNy9tNGJURWU0VC9h?=
 =?utf-8?B?OTNENURwWmRpWTd5VHJHTnJoY2c1bDVxS0pRKzF0UVQvSU16eDNkTFNqR1Bk?=
 =?utf-8?B?VHBFd0RpbERWempKYVlLY1JmZ0tsK0Z5a2NEZmlpRWdNRTVnUUo0TTR3eU5S?=
 =?utf-8?B?R2g1SVI2YVIvSitxS2F2Q0xYQnowMVdaT2pDTXVCcWNsejdJOStIb3BTSkly?=
 =?utf-8?B?T0RKcjJBcS9rdnVvbFZ1N0RSWU0vMHN5QUhSVU9lT2N6cG05dnJqb1g5R1ZV?=
 =?utf-8?B?UWxrbnFEa1poTGFxNmpEdnB0aHpKcENwYUZmUmlzLzAzSDlRd0luaW11TExp?=
 =?utf-8?B?U0lieVpadjNadFhaZkZRNXloVjFVQ2dEaFZuK1pINUU4UW83VDNUOW5XdU1l?=
 =?utf-8?B?ZlI2L2VUajhyWDlKalh0OFM2dkxXamNKUnZQWHhPY1pUZFE5bWpQTlMyS0E1?=
 =?utf-8?B?YTlVeWw0UWtDNnQ3dWpkZHJKekpBTk1zOU9URWNQOTM5MUh3cXQrbmtSYjUz?=
 =?utf-8?B?WUE1NHdNV2lJaHpSVTVBY2daNzN4cUpUekdtQ1NyQS9Ub25QVmMyejMyRjNF?=
 =?utf-8?B?alBvaUdoZnhlNFNURTg0U21MQi92c3MwNU1ldytTcFgvekdRVHA4dGM2MWJQ?=
 =?utf-8?B?ODhyakNzeHlMQU9XRHdqN1d5SWpPNjBqMFpPT1FONFNHWmIvZGR0ZXZOZHds?=
 =?utf-8?B?UnlSNExJR2dTbkdVMFdpQmpBRTJrWEgyQWlZQ3lOcUFyaDdyaHZzMHRSUEUv?=
 =?utf-8?B?Q2pVK3VOTUFoUFJ3MWVLa010RXo3U3VUS3NxYUVYUHl1U0JUekpkYllDNGY1?=
 =?utf-8?B?NWVTNlFvdXdjc3h2WU5YOUh1aTdxL0xFVC80N2dLTDYrWHFiN212a1JHSUVX?=
 =?utf-8?B?RkdiNkhDblQxUnA4dXZReUJxRGVUN3hBS1Zta2ovTTJLZmo3Mm9Tck9naXQ5?=
 =?utf-8?B?M3Rockp0UDNyMDV6bVR2OVFZdS9PY2dpSmxwS1Rhb1NKWjQrTU51b0psRFkr?=
 =?utf-8?B?UmZya2RHMDA1Z0sxREw4d2lVdGVaYVVNaHVYUTV4UkZJU1FGNWJQZnk4YXhL?=
 =?utf-8?B?T0FEWnI4am8wMlEvNkthYVV0WEx6OGhNT0VxcUxxcGhzZExMeFpEb1pUby83?=
 =?utf-8?Q?XWvMPQQa4C3SgGLbniNMV3NRIcqYfKHoGQNHk=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 75d4b4d3-2301-4c02-3860-08de912ce253
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2026 02:58:29.4741
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB9906
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
	TAGGED_FROM(0.00)[bounces-9945-lists,linux-hyperv=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[SN6PR02MB4157.namprd02.prod.outlook.com:mid,weissschuh.net:email,outlook.com:dkim,outlook.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 03CC2390874
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

RnJvbTogVGhvbWFzIFdlacOfc2NodWggPGxpbnV4QHdlaXNzc2NodWgubmV0PiBTZW50OiBUaHVy
c2RheSwgQXByaWwgMiwgMjAyNiA4OjE4IEFNDQo+IA0KPiBUaGlzIGF0dHJpYnV0ZSBpcyBuZXZl
ciBtb2RpZmllZCwgbWFyayBpdCBhcyBjb25zdC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFRob21h
cyBXZWnDn3NjaHVoIDxsaW51eEB3ZWlzc3NjaHVoLm5ldD4NCj4gLS0tDQo+ICBkcml2ZXJzL2h2
L3ZtYnVzX2Rydi5jIHwgNCArKy0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCsp
LCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaHYvdm1idXNfZHJ2
LmMgYi9kcml2ZXJzL2h2L3ZtYnVzX2Rydi5jDQo+IGluZGV4IGQ0MWIzOWFiNjI4ZC4uZWNjZTZi
NzJhMmEyIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2h2L3ZtYnVzX2Rydi5jDQo+ICsrKyBiL2Ry
aXZlcnMvaHYvdm1idXNfZHJ2LmMNCj4gQEAgLTYzOSw5ICs2MzksOSBAQCBzdGF0aWMgc3NpemVf
dCBoaWJlcm5hdGlvbl9zaG93KGNvbnN0IHN0cnVjdCBidXNfdHlwZSAqYnVzLCBjaGFyICpidWYp
DQo+ICAJcmV0dXJuIHNwcmludGYoYnVmLCAiJWRcbiIsICEhaHZfaXNfaGliZXJuYXRpb25fc3Vw
cG9ydGVkKCkpOw0KPiAgfQ0KPiANCj4gLXN0YXRpYyBCVVNfQVRUUl9STyhoaWJlcm5hdGlvbik7
DQo+ICtzdGF0aWMgY29uc3QgQlVTX0FUVFJfUk8oaGliZXJuYXRpb24pOw0KPiANCj4gLXN0YXRp
YyBzdHJ1Y3QgYXR0cmlidXRlICp2bWJ1c19idXNfYXR0cnNbXSA9IHsNCj4gK3N0YXRpYyBjb25z
dCBzdHJ1Y3QgYXR0cmlidXRlICpjb25zdCB2bWJ1c19idXNfYXR0cnNbXSA9IHsNCj4gIAkmYnVz
X2F0dHJfaGliZXJuYXRpb24uYXR0ciwNCj4gIAlOVUxMLA0KPiAgfTsNCj4gDQo+IC0tDQo+IDIu
NTMuMA0KPiANCg0KUmV2aWV3ZWQtYnk6IE1pY2hhZWwgS2VsbGV5IDxtaGtsaW51eEBvdXRsb29r
LmNvbT4NCg0K

