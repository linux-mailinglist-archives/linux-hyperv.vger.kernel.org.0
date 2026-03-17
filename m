Return-Path: <linux-hyperv+bounces-9499-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aD38JnmPuWk5KQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-9499-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Mar 2026 18:29:29 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC7E2AFAE8
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Mar 2026 18:29:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BA606304B0C2
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Mar 2026 17:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B6F2D73B8;
	Tue, 17 Mar 2026 17:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="pjxukKtT"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazolkn19010003.outbound.protection.outlook.com [52.103.13.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193EE2D739D;
	Tue, 17 Mar 2026 17:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.13.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773768403; cv=fail; b=dT459CT+FdV1HLwW+I6nVWWfnLk5LCYCwBMyMbkFapWbr0rKETl04spsUMkQTx0FSrpXV2sCXHj0b9RmPUFyVVnu49eCt700BrHt8TXCKGL9OS6Qr5N5UeIAK0TPEXFNqvGBSM3vcSHJ2C+d9Gj0X94bHaJAdzTgkd7Ctvju//Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773768403; c=relaxed/simple;
	bh=zzPF0JnKqowTcWzlPFuMLHJSTHKk/vu48DaQACCfKTw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pjLKqqqGzYpKHvbKJmehZCsGhKwq7OW7veSgpXhZWNCXudFYXPSK8AMePKVgnN4wGEtzsRyCm8f3VGGMJxdc1GT5/yXTnUkIEp3EllXWuPLd6EQJ1bdTCuWB7jMki/kyCEYMSmxMpHSLD7D4/gJxSPGZ2L39GwZJH4MlAQi9bmQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=pjxukKtT; arc=fail smtp.client-ip=52.103.13.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kpMFKwDWCDriiOZZHSU8VTFU1h+YtjTjMsE2px12uMajKcSr/tZb5iVTWow0xabWGOn1BrP2Z0Rt9y1XEJ9azlHghqvTz4EfttvrYMROaKDv375L+0fDH7zOuGLLvJdln656hL1c7PunrtqSyhD7l9ttd0/Ks+u/daYyL7vKFvWLCFSc4aMhZv18wooRKGS/5dBR4ufYqB6PGSrq39yM0gJFBrs2LR69E//wgC8zcJ8YKdjQvUbF+4MDriGVUHFk9RU13yt9F9YFUzblWqhkfIJA59Xe5kXNhiWE5kT9QLCaECCcA7Z5BCTQnTsN/UwZ6nObpIFZ4b7NjpKk5WzstA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zzPF0JnKqowTcWzlPFuMLHJSTHKk/vu48DaQACCfKTw=;
 b=bMmZ3p8UKiBuW6vFkUQBpUiNQELN+06l2tuoRWNfXDlMdrLCA5ePIgLeXCfMGjcNtP0LiOJNGB1GsL+qT0i8/frKMqHMQ/i3aGTX8k7mHfhfwaTTu890/zn/SM6i61Ea9lKWK+WsoTo77vfcyUdhIWfbAJ6GgTRj5fGQK3xfGFCRrnJGd4lBw8xvUVvaqN4wLIr1PIV4h7YcbUTU0tVSxT+3ySgsX7zAk1p5zwOg9QokGns/v5aJGb8VgGes4A2tpdZBKs3pAHZhFLQgc+sohP+pFacUkJ1T1ITauMoKNyGERL1OAjCzXK/0tBqQZhqFfGkpwOmrsWktqhV7Fr/i4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zzPF0JnKqowTcWzlPFuMLHJSTHKk/vu48DaQACCfKTw=;
 b=pjxukKtTA1BIt52lkMr0MhE55HFnStzxOAEVWOg6sWzaodZqCAIOTGEBErZwN/FHpOTQRPtRVLXGfK7Cq1WLOTFtZBThOGsXMzFiDxl+WTE5aqBlK4MtgSHAfK5i6M6+sVblwGSFgSOqc8kYZu8IVw+LI3y0/X6Upa4Qc/+Axc9XStfGT8c5hHnb6XDVMnKJPid/1ut/6nxPUxdceALhdqOxdtvUP7vfS9Rn+G0kYzvVq4fRBVFnQcYwiK9tDXprCzNX/KeA8Px8kVHooFHpERLOASfYWL9bV8dOul5m/DfyRJMiOzFKVwRFlQhNGYWYSjB/SJ8W74u7uGXZxR8+Pw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SN4PR0201MB8840.namprd02.prod.outlook.com (2603:10b6:806:207::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 17 Mar
 2026 17:26:40 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9700.024; Tue, 17 Mar 2026
 17:26:40 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>
CC: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang
	<haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
	<decui@microsoft.com>, Long Li <longli@microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>, Florian Bezdeka
	<florian.bezdeka@siemens.com>
Subject: RE: [PATCH] Drivers: hv: vmbus: Move add_interrupt_randomness back to
 real interrupt
Thread-Topic: [PATCH] Drivers: hv: vmbus: Move add_interrupt_randomness back
 to real interrupt
Thread-Index: AQKoHsdWm1sf+zqRuZikYGt2JgzA3AGnYzL4AVfxRpG0A+1pNoAAQNBg
Date: Tue, 17 Mar 2026 17:26:39 +0000
Message-ID:
 <SN6PR02MB41573332BF202DAE0AF79ED1D441A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <1b53653a-98a5-402a-a224-996b26edaa97@siemens.com>
 <20260317110535.Smn9viQ7@linutronix.de>
 <f718a22c-bbf2-4206-ba7d-391243c84f60@siemens.com>
 <20260317132252.AJlwEyMh@linutronix.de>
 <5262eafa-7f94-41c8-85d7-a2b8d7f27c5a@siemens.com>
In-Reply-To: <5262eafa-7f94-41c8-85d7-a2b8d7f27c5a@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SN4PR0201MB8840:EE_
x-ms-office365-filtering-correlation-id: 93a6b30c-a196-4cd9-4e94-08de844a59ae
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799012|51005399006|8062599012|8060799015|13091999003|461199028|15080799012|31061999003|37011999003|40105399003|3412199025|440099028|102099032;
x-microsoft-antispam-message-info:
 =?utf-8?B?dzBCT3pBbyttWDdkbjdIeWRDa0tBRFRXQStocS96VmlJbkM2M2FXUENncjk5?=
 =?utf-8?B?d0YwVXF0WjgxYTNkcEtNZ0xKYXNtYWRlNkpJK0kyT2FNODFRMWltZHpUOEE5?=
 =?utf-8?B?bXNRSlZINkRud0FHeEd2dDhGeXJQeWMvRytQaVhiZ0EzTS9MNWloVmJ2a3JE?=
 =?utf-8?B?b1VmOFlEYTdlTnM3UWtRaHpOZHNPR2NQZklobllSN1JEdzVRaDhPb092RjVW?=
 =?utf-8?B?OEJhT2ppdjRHYnR3WjY0bDZZb2hoS2kzclB0UGIybUtPQ2tHZXA4SXZxdzhX?=
 =?utf-8?B?QXp3UmxnYmNialgrVkN4ancrb3k4clJSSWxZc2tOcE5uWE5ZQnIxU0hNUjVh?=
 =?utf-8?B?c09USStmQlJBVVVSQXNoMXlYaXdTU2JLUGpndmdhL0NKWUwxZGlLMGpIOC9M?=
 =?utf-8?B?b3dQZFNFZWtiY1RXS01WT0dITGFPdlZ3ZlRjUnZNR3N5ZGVWS2x0bnRtaHF3?=
 =?utf-8?B?SS9WcGkrZE84QTgreG4rUlJvcEFaOGtzTHNrMnpFczI3aHN0ZG9Ba1FJTVgz?=
 =?utf-8?B?bmtBM3N2WkVBdVBlZUVkRVBVLy84KzJ6anA2TjBCMzJmN0syOHlyQXU2TzY2?=
 =?utf-8?B?S0pjTlBqNEZzaWsxWkJNSGlDL1I5ZGdJUmN6N1lpemR0UVU1QlpmV0p2MXly?=
 =?utf-8?B?VzFYUEJIbFpmRjZkcjZJS2EyMVU0QXpqUFRqTUNVUHROVzJicmNnWkxaODRa?=
 =?utf-8?B?WHpzejliZnFhWXphSlhib2NqaEp6YTZLOWRZUHNQUzNkdmZObkhuSWtpaVZP?=
 =?utf-8?B?TjZIM0hiajBPR0w1TlZkNEErV1BFOWxUUXk2andlYk95aGkwODRVN084TTQz?=
 =?utf-8?B?dzQySklRbVpLdnJxMndvRnpjTytkWExpa1hlMTlmcU1rU2lTWG1CSHJZR3J5?=
 =?utf-8?B?Z2dtMkl0RVhOakxUZFM5TXg5dlhSSGtvZDM1dVRoTzRwYmpoaEJibVBDWGFR?=
 =?utf-8?B?N2hRa0JWdG1GZHlmaW1vR2xTMGsxekpJWG9HN1ZINGlmV2c0RmtQWnFlUVM0?=
 =?utf-8?B?L2xUWWt4dmhJZkpzeTY3UjRsUWo2Um5IamlKOUkyclVBbWNVSDdoak90ZVkz?=
 =?utf-8?B?c2NXUXcyL24vMVAycHZxbnJEK2RiVWdEcGlKN1pJYldJWHM0NUZCdlZuTW9m?=
 =?utf-8?B?NWM4SkNmK2RFaklERnNGc3NGSnZEdk9yY2dpUzJDbnpvWDhYeTNRNVpMMnBK?=
 =?utf-8?B?cnlnNXJWZU14cTlKUzdMN2RUWmVIcm5ZVEVZV28zTjJmZVk4cmZEREpaQ0o2?=
 =?utf-8?B?NmM3SnhwdW11dlF1WkdHMHFPUHhHNWtNTEJWWlNSVmNDeGdPNDNYcGE0RDdo?=
 =?utf-8?Q?g15/jniJ5uODM=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Y0VVdGRPNWd4eUZoTGxFUkFVN3BTYkFUSFAvWGtYSXhOM3RNVE1TNkJOVFR6?=
 =?utf-8?B?bTd5b1VrcE5adTRzUEU0eSthZUEzOEt0cmZxMHhsb1krUk9qUEdqc08xQjBw?=
 =?utf-8?B?RXl6bkFOQUhmdmtyQXorWm10WlNoc0hvbnV4NHlCeGEycUVwRjRVcDFFbndX?=
 =?utf-8?B?akQ5ZEV3ZXZDNDFIVUxrRXpHM2c5NStQYzF3amdaV0xLbUpablFEK1VNVEdj?=
 =?utf-8?B?QmlFSklMU1R6QWJhS2Fnbk8wOCs5M3lUWFFuZ2pOMGlidCtvQUNZc3hwb2Zq?=
 =?utf-8?B?N01oNTJwUUJvQlV1ZmNmQTJqbkY5S3l2Mmh2NytsQkpKbzNrZk9qajYrL21B?=
 =?utf-8?B?T1RrN2gxblRwdm9rcTRjeUsvVFMreTYvWnRwaWRvUkI2YmxyQjJKcWcyMms0?=
 =?utf-8?B?bXVwWXZLQjhlL0lhVm9ZTElkTkdoeHZoZk1oR21MRldCYWVvSmhFTTlTejIx?=
 =?utf-8?B?YWJhdjAyTmdkN2Q4YnJJVW91N1JMdC9KYmg4dEVCcFNuMEY3ZERIS09rZ0ZC?=
 =?utf-8?B?SERYQ2E3cjF3aW16aTJBYkV5WHVKMkxJYmticFQ1QXlkTStuS0J2bkR0YUNQ?=
 =?utf-8?B?QXZDYXVKTFhHNjJFa1UwczdlbmJSelhLTFdIaExGSXNvdnVQRkllZWV0bHI0?=
 =?utf-8?B?OSs5QXNyVlVVY2o5SFFFUVJMYlFRbE9RMkFRWmpTN09Bemx4MU9jNnN3WlBP?=
 =?utf-8?B?UTZhUkdkTmY0dHdOVGV6ZXl2cDl2WXRad2tuamVNTjhjSVpFd0x1S0hpcVRj?=
 =?utf-8?B?RjFweU1IVFF5OUJ6cEp5Mk95dUdyM2kzN3lLcWd0WnN0QktRbWxKdHZwM3BI?=
 =?utf-8?B?Y1NIUUYvSlRickxCL21zY2dZdEZrN2lLaEszQ214OFRCazBMT0F3WTVLKzFz?=
 =?utf-8?B?RUcvOUNicEpFRTM5UUVFMHhUQWxVUmRsU1lmcFhUckNTalBnL1JhS2Y2SEVt?=
 =?utf-8?B?TGh3T3NwMjdxT2ZCaGduMmxNMnJzdURMY2Y4a2Ywam4rQTVNakl5RlhKekFW?=
 =?utf-8?B?Z0RMTEh3ZFB6MGdDWllEU2ZwMGlwbkJNWFd0ZWhiUWhRekwxOVprTFBDcldB?=
 =?utf-8?B?T1ZUTXIzeURQVTR4RUpUWm9EVkNGTnNITlU2Y0xMOURYempIZ3Q5UlA0djJB?=
 =?utf-8?B?V0ovMHlza1R5MXAxNG52YWZWbk1xejRhcDRqZVZuaDMyUXhiYW84eUZTcm5R?=
 =?utf-8?B?Yk5vVUFjOTUra2J0a2dkd0FaWXNEZzRMVVZ0QnBrblhoSE1xbTVQRk91dzVJ?=
 =?utf-8?B?cSsvU3RKbDAyZW41ejcrcFAvODJROFM4bGg1eFNIaWNTeWIvcVlqa3pXKzA4?=
 =?utf-8?B?ZzNaTmtrMHFhRmpzN0NuUEZTNUtSM01PbFBIVThOelVHT1JHTjF1MXFZWWRB?=
 =?utf-8?B?TGp2KzBkQ0c0SGVFUktGZDA4WnRRUWduTTR6VjUzcG0yUGR6bjJnTW5jdHpH?=
 =?utf-8?B?Y3JtN0lGRW9jR3d6VDQ1OHhKNFNsN2JFOUNxNVNIMFB1bm5PeEowZ3JydlpW?=
 =?utf-8?B?c1V2ZkpHQ1ZNaWdVVkE4eEcvVy9HOWtxeXF2cEg2VHA3Si8rUnRUZU5oUUdN?=
 =?utf-8?B?Q0g0ZStQa1JNdS9zUjJidXJMWDg2UzMvUWRPbkZ0bURQTHVvTm5ieGFtK2dM?=
 =?utf-8?B?QWNnT3VmdnUwK1lPajJJNW0wQlFQb1FzempVTDdDekZUTFhSTWEwdTB3Z0Ja?=
 =?utf-8?B?WGxob2d3Y2dOa2orL2d2aC8yWURnRFV5MEFsVlZhcjZiTlJPTE42Tkt4TWlq?=
 =?utf-8?B?SnRvQjMyN1ZzU3pGdEc5ckhFT3dKSDc5RUxOVmo0R0IyVjZteFIxSFhTbjRs?=
 =?utf-8?Q?xJntZrONw3HLGbK1eLZjP4ZZSSM0eqGbB0X+E=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 93a6b30c-a196-4cd9-4e94-08de844a59ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2026 17:26:39.9630
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0201MB8840
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9499-lists,linux-hyperv=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[10];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,SN6PR02MB4157.namprd02.prod.outlook.com:mid,outlook.com:dkim,siemens.com:email]
X-Rspamd-Queue-Id: 3FC7E2AFAE8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

RnJvbTogSmFuIEtpc3prYSA8amFuLmtpc3prYUBzaWVtZW5zLmNvbT4gU2VudDogVHVlc2RheSwg
TWFyY2ggMTcsIDIwMjYgNjozNCBBTQ0KPiANCj4gT24gMTcuMDMuMjYgMTQ6MjIsIFNlYmFzdGlh
biBBbmRyemVqIFNpZXdpb3Igd3JvdGU6DQo+ID4gT24gMjAyNi0wMy0xNyAxMjo1NjowMiBbKzAx
MDBdLCBKYW4gS2lzemthIHdyb3RlOg0KPiA+Pj4+IEBAIC0xNDEwLDYgKzE0MDgsOCBAQCB2b2lk
IHZtYnVzX2lzcih2b2lkKQ0KPiA+Pj4+ICAJCWxvY2tkZXBfaGFyZGlycV90aHJlYWRlZCgpOw0K
PiA+Pj4+ICAJCV9fdm1idXNfaXNyKCk7DQo+ID4+Pj4gIAl9DQo+ID4+Pj4gKw0KPiA+Pj4+ICsJ
YWRkX2ludGVycnVwdF9yYW5kb21uZXNzKHZtYnVzX2ludGVycnVwdCk7DQo+ID4+Pj4gIH0NCj4g
Pj4+PiAgRVhQT1JUX1NZTUJPTF9GT1JfTU9EVUxFUyh2bWJ1c19pc3IsICJtc2h2X3Z0bCIpOw0K
PiA+Pj4NCj4gPj4+IFdoeSBub3Qgc3lzdmVjX2h5cGVydl9jYWxsYmFjaygpPw0KPiA+Pg0KPiA+
PiBCZWNhdXNlIHdlIGRvIG5vdCB3YW50IHRvIGJlIHg4Ni1vbmx5Lg0KPiA+DQo+ID4gV2hvIGlz
IG90aGVyIG9uZSBhbmQgZG9lcyBpdCBoYXZlIGl0cyBhZGRfaW50ZXJydXB0X3JhbmRvbW5lc3Mo
KSB0aGVyZQ0KPiA+IGFscmVhZHk/DQo+IA0KPiBJdCdzIHRoZSBhcm02NCBwYXRoIG9mIHRoZSBo
diBzdXBwb3J0LiBSZWdhcmRpbmcgdGhlIHZtYnVzIElSUSwgaXQgc2VlbXMNCj4gdG8gYmUgZnVs
bHkgaGFuZGxlZCBoZXJlLCB3aXRob3V0IGFuIGVxdWl2YWxlbnQgb2YNCj4gYXJjaC94ODYva2Vy
bmVsL2NwdS9tc2h5cGVydi5jLg0KDQpUaGUgYXJtNjQgcGF0aCBpcyB0aGUgY2FsbCB0byByZXF1
ZXN0X3BlcmNwdV9pcnEoKSBpbiB2bWJ1c19idXNfaW5pdCgpLg0KVGhhdCBjYWxsIGlzIG9ubHkg
bWFkZSB3aGVuIHJ1bm5pbmcgb24gYXJtNjQuIFNlZSB0aGUgY29kZSBjb21tZW50IGluDQp2bWJ1
c19idXNfaW5pdCgpLg0KDQpUaGUgc3BlY2lmaWVkIGludGVycnVwdCBoYW5kbGVyIGlzIHZtYnVz
X3BlcmNwdV9pc3IoKSwgd2hpY2ggYWdhaW4gcnVucw0Kb25seSBvbiBhcm02NC4gSXQgY2FsbHMg
dm1idXNfaXNyKCksIHdoaWNoIHN0YXJ0cyB0aGUgY29tbW9uIHBhdGggZm9yIGJvdGgNCng4Ni94
NjQgYW5kIGFybTY0Lg0KDQpUaGVuIHRoZSBzbGlnaHQgd2VpcmRuZXNzIGlzIHRoYXQgdGhlIHN0
YW5kYXJkIExpbnV4IElSUSBoYW5kbGluZyBmb3INCnBlci1DUFUgSVJRcyBvbiBhcm02NCB3aXRo
IGEgR0lDdjMgKHdoaWNoIGlzIHdoYXQgSHlwZXItViBlbXVsYXRlcykgDQpkb2VzICpub3QqIGNh
bGwgYWRkX2ludGVycnVwdF9yYW5kb21uZXNzKCkuICBUaGUgZnVuY3Rpb24NCmdpY19pcnFfZG9t
YWluX21hcCgpIHNldHMgdGhlIElSUSBoYW5kbGVyIGZvciBQUEkgcmFuZ2UgdG8NCmhhbmRsZV9w
ZXJjcHVfZGV2aWRfaXJxKCksIGFuZCB0aGF0IGZ1bmN0aW9uIGRvZXMgbm90IGRvDQphZGRfaW50
ZXJydXB0X3JhbmRvbW5lc3MoKS4gIFRoZSBvdGhlciB2YXJpYW50LCBoYW5kbGVfcGVyY3B1X2ly
cSgpLA0KY2FsbHMgaGFuZGxlX2lycV9ldmVudF9wZXJjcHUoKSwgd2hpY2ggKmRvZXMqIGRvIHRo
ZQ0KYWRkX2ludGVycnVwdF9yYW5kb21uZXNzKCkuDQoNClNvIGF0IHRoaXMgcG9pbnQsIHB1dHRp
bmcgdGhlIGFkZF9pbnRlcnJ1cHRfcmFuZG9tbmVzcygpIGluDQp2bWJ1c19pc3IoKSBpcyBuZWVk
ZWQgdG8gY2F0Y2ggYm90aCBhcmNoaXRlY3R1cmVzLiBJZiB0aGUgbGFjayBvZg0KYWRkX2ludGVy
cnVwdF9yYW5kb21uZXNzKCkgaW4gaGFuZGxlX3BlcmNwdV9kZXZpZF9pcnEoKSBpcyBhIGJ1ZywN
CnRoZW4gdGhhdCB3b3VsZCBiZSBhIGNsZWFuZXIgd2F5IHRvIGhhbmRsZSB0aGlzLiBCdXQgbWF5
YmUgdGhlcmUncw0KYSByZWFzb24gYmVoaW5kIHRoZSBjdXJyZW50IGJlaGF2aW9yIG9mIGhhbmRs
ZV9wZXJjcHVfZGV2aWRfaXJxKCkNCnRoYXQgSSdtIHVuYXdhcmUgb2YuDQoNCk1pY2hhZWwNCg0K
PiANCj4gPiBUaGlzIGlzIGEgZHJpdmVyLCB0aGlzIGRvZXMgbm90IGJlbG9uZyBoZXJlLg0KPiAN
Cj4gRG9uJ3QgYXJndWUgd2l0aCBtZSwgSSBkaWRuJ3QgcHV0IGl0IGhlcmUgaW4gdGhlIGJlZ2lu
bmluZy4gTWF5YmUNCj4gTWljaGFlbCBjYW4gc2hlZCBtb3JlIGxpZ2h0IG9uIHRoaXMgKGFuZCBz
b3JyeSBmb3IgaGF2aW5nIGZvcmdvdHRlbiB0bw0KPiBDQyB5b3Ugb24gdGhpcyBwYXRjaCkuDQo+
IA0KPiBKYW4NCj4gDQo+IC0tDQo+IFNpZW1lbnMgQUcsIEZvdW5kYXRpb25hbCBUZWNobm9sb2dp
ZXMNCj4gTGludXggRXhwZXJ0IENlbnRlcg0KDQo=

