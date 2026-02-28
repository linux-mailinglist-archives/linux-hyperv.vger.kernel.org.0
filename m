Return-Path: <linux-hyperv+bounces-9068-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SNdIBqA2o2nP+QQAu9opvQ
	(envelope-from <linux-hyperv+bounces-9068-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 28 Feb 2026 19:40:32 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A80B51C6197
	for <lists+linux-hyperv@lfdr.de>; Sat, 28 Feb 2026 19:40:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F3DF8310DFBB
	for <lists+linux-hyperv@lfdr.de>; Sat, 28 Feb 2026 18:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811D33B6410;
	Sat, 28 Feb 2026 17:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="NGczFVlq"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011051.outbound.protection.outlook.com [40.93.194.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F8F3B63E6;
	Sat, 28 Feb 2026 17:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300331; cv=fail; b=mQA9HSOu1RLp1DcPlybUTmHOx4ZZqXv0uTlUaSZrA5nKOQcd0YUXjCV445XErXHQVMq+QY8E02+U3eRYr0YCqJLt1u0Okg2g25atUUzI0lPHieG3JEyEKYZtrllG2UHzt5xlz67ocy0Y66tOgQP88i3iwIIOCBr0zS0ivzPkPrQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300331; c=relaxed/simple;
	bh=oDPQkA/nT4f88W8ddU+qqR+g6QqgertSVwqTmGF1FLA=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Os5jLmbdNzVeffExOHlrMgSkzkQEPC9BGa/AdOwLPS1KNa0v2mPR02inKcm0xuvdiv/4l9xy3B9mpu6kbY8Y5mnYQu/F/5NbVkKmNqbhojRuWHnhUkD9zGIVSOInQggtHooYBk88JXUY0oKdEGj6UaTmDeY+BePFO7F455IcuNA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=citrix.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=NGczFVlq; arc=fail smtp.client-ip=40.93.194.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=citrix.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MapnCsw90EkXmwDVmDOkj0K0gcmuJQR+4BcNpecQPIMAu0Puk5naPU5PZPlDrfyW4Fya4zr9H51xpa60fGBpy8jDexec3NpjwBQLQvXbLdH6yS6jJg4aofqOb4H3Zgkp7o21LRRdX4+VAiDhLDlf1Nl0cn/IMdszZ+sapdf3pAUBA0cGw47Wo6kKgpAdpv/o4pxzUSV2ILAYo1PNgt3MhAucQ1i+pyMUuX6KqCOyE1qsT4muGcPhLK6k9FLtBx/SerXNCuMI/zeT+UblwSlsvjnATpAVHOsaiYpswi3UxekfiuklUX86ScDYJ19ir+cjDOcGrj46HYSxBQDUlMalWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oDPQkA/nT4f88W8ddU+qqR+g6QqgertSVwqTmGF1FLA=;
 b=TK6QIWBARRBFp+jdKZ4yJBRhpUkPEU/6ftsuzUamhzmRN4NyEaBb1/jPou7cJO09acU20KzzvSDO53KPcn0GnOsGSd5QpjiMPiMBi+hDOKigLld5EtSzAd3zSPp1w+MHFUmPW/79zx+6F/bW8fFVpoPEMmc3ZahC93ZWEg9KGU4mxQLyckGQBQDMgCeF5FHiYN4frVjhU39Q1wj0MXKHYOv+jWdxO4xdA38kPmUDJriGJ+0pgYhEV678lVsC6zdvnrmnDd4BS2RvuEoVszM1oGmYvD5+Xv0mO+S2Awq/bfZMneoRTyLEHMzlO3Zn9kLxfBWQz+pD0inYTzqi3awVfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=citrix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oDPQkA/nT4f88W8ddU+qqR+g6QqgertSVwqTmGF1FLA=;
 b=NGczFVlq7VoQub6B9EzvoHrlEH7l0uwsE++0d+7kS3H5R7gEv6Ku622tjjPctyHSOpqrTqxbFY9FkzLDT6SzOzByCVeKVUFv8ztyuJkzli977V4KBY9f8VFJ0MwJn8OpKZ8ZiR51bCvR4G8KJeSWpvNjx2J02xOhNkPCzg5ZfQg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from CH8PR03MB8275.namprd03.prod.outlook.com (2603:10b6:610:2b9::7)
 by MN2PR03MB5104.namprd03.prod.outlook.com (2603:10b6:208:1a9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.18; Sat, 28 Feb
 2026 17:38:47 +0000
Received: from CH8PR03MB8275.namprd03.prod.outlook.com
 ([fe80::a70d:dc32:bba8:ce37]) by CH8PR03MB8275.namprd03.prod.outlook.com
 ([fe80::a70d:dc32:bba8:ce37%6]) with mapi id 15.20.9654.015; Sat, 28 Feb 2026
 17:38:47 +0000
Message-ID: <2dea5b92-cb21-4c04-b49b-3b5f1d0ec97b@citrix.com>
Date: Sat, 28 Feb 2026 17:38:43 +0000
User-Agent: Mozilla Thunderbird
Cc: Andrew Cooper <andrew.cooper3@citrix.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, Mukesh Rathor <mrathor@linux.microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH v2] x86/hyperv: Use __naked attribute to fix stackless C
 function
To: Uros Bizjak <ubizjak@gmail.com>, Ard Biesheuvel <ardb@kernel.org>
References: <20260227224030.299993-2-ardb@kernel.org>
 <CAFULd4YM=D9+akehA5h_sC-97otYyv1Nxr2neE8bD1AoW-8ocQ@mail.gmail.com>
 <7c7cd72e-fd46-4f77-8bf7-8d538fec0a52@app.fastmail.com>
 <CAFULd4YTkLLdvjTtGXtHgsZCiEMXAYXcjSwciwdsE-RGvnVrdg@mail.gmail.com>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
In-Reply-To: <CAFULd4YTkLLdvjTtGXtHgsZCiEMXAYXcjSwciwdsE-RGvnVrdg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0318.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:390::17) To CH8PR03MB8275.namprd03.prod.outlook.com
 (2603:10b6:610:2b9::7)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR03MB8275:EE_|MN2PR03MB5104:EE_
X-MS-Office365-Filtering-Correlation-Id: 93a0fd43-f588-44bd-c991-08de76f03a2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	oh1LoqNOlVGFQKJIgXTCvAMti45lZmcN+O/AVRdC5835eXsaTUMI6l7kkLDt19z9sZZOF3KfNObUBJ5k9v6C1nVGhl5utOw+K3YlyjJNglU4GyIkI+6+74cORny2/TcHbokvoOLx8fibIzAFTgcJeo78FiFDW2xwopFcc4GN9LLNikIcN8Q7HR1Y6VwDnpQjTBY8+yIVU6BN36dK15a5JhJXuO1qXMEaBbHNyTWE80SfuJItrFy5Ij5Xv5wdXsWdzjnrlMAsYO+36a9mRsdFvFr9nk18rXKQI2oTvGrb5hJ0ecF6WKW4txJbwxFwpAjfX9B0u7f1Hz98m4mKRWVaDjMKGt8DubzhvS4g9qDxN3iie2qeyO8GuzAQbpKfQ1UI/OjSI/gCBG7JVdfXZZIu6QrdYbx0cOQktmj881Kcz85Hidh83s085yFgTwnFyVq5OmvmA7z57JbMska0fdudHPfBH5S2a18sPdDdwKIuK0Z40QxcmXi8GzPBbaacHRxQVG2JcGun6fQPKgULhMwiB/dVPWH2daRPWNwTxF/KW+GX2BW9ffl7To8Fgur22gRzUAgTDPTEtgAjjx7QFV5BC6TF/Larl7QlBCXI31i1WZWIDBfG7E1QCN9Rb8wRb0dxv0HwMp7MGtL6yK/0goI14qRJV6tRgf+qDc0uF+tmYnijeLFLYYxhEjriG9AfG9hbqtR6Hq+LvD+lYH4k858OvHE7pv1sF8Hk8900/ox5txc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR03MB8275.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OUFTTmpsWVZHa0ZUeGFBWW4vQXVsdWtiYUxEK3llclJZT2s4eEFWaWVtWDhU?=
 =?utf-8?B?UkNPUU5LUzl0Um1WNHBtOHlUR1J4WXJtUFZEcUEvbklIdTFLRDBnaGRMN3Mx?=
 =?utf-8?B?aWtZYW9VTHM5V1NiRWpYTG1ubUkzMkt5VFlKblhSZ1VxcU5mbUw5TW1FNnp5?=
 =?utf-8?B?OXd6WjB5azdyQ3RuVjMwUHA1b2EvNmExdjdoNlZxaXM1SEJOV05QOWdVK3lM?=
 =?utf-8?B?anlkWEVLQTFxL1Bpd0p4MXlJQ1h0aUhKNmxjNERoaWgxUW14YUx5UUxIUVd3?=
 =?utf-8?B?VG80Uys2anlZb3orWlkray8wKy9LWE85clJIcm85b3JxZWMyM3Nzd09xS2Qw?=
 =?utf-8?B?dzFiekM5dFcwZmtpcFRCU1oxWVdLN3lZSzhIQWwxUkorNXNucGdPTW1qQnBW?=
 =?utf-8?B?K0MxYStCdEkyM0I1UWtlZ1FiNDl5R3pycGxVU1RBd0gycjRUc2tqSGpkVUJK?=
 =?utf-8?B?SkUwTHpkdkxzMnUrSE9WMzdBRWFTazdrVE5GRDVFdnlHaExocjFhbnpCMG1U?=
 =?utf-8?B?UCt1ZEE1ejZKMWVDbUJWM3VQSXJaZTNCUFFpSDhleVpTRG1qRVJnSU0yeVRh?=
 =?utf-8?B?NUNRKzNzNXJFampqbU9IcFdmaXdQZVg3Rjl1RFpLcnNLYndzS0NNVStralZq?=
 =?utf-8?B?TVFxRURjaWU4SHhLVTVZSTl5RXFxN25LTWplVzByOWJkR3pwN0FjWC8rUFJO?=
 =?utf-8?B?Vk95MG9oVkhpKzRSaVZBSzFKbjFqZ09wSHlCejIydWJTQW0wd0lvTGV4LzE3?=
 =?utf-8?B?MG5nOU4yUjB6bFE2cUJUTkpBV3dkN1lwcGswam5LaldnVHJVcFliQ2ZOK1RI?=
 =?utf-8?B?Nnp6QVFZdkxnQzZpTDF2YkV1T2ZtWVY5RTYxOW45RXY5S3BTb1RrK0tPU2No?=
 =?utf-8?B?cHVFT0k5VzVFVHFkVlBtRm9tbXVVNWZzWkFmak9hU2ovVmszQkJyS3ROSmdJ?=
 =?utf-8?B?RDlGZzduVktWN1MyZzN6UGs3c2d1Yzc4YlpjNlY4c2E0YWlYaWU3QkNJYXFu?=
 =?utf-8?B?Nnc1ZWZDSEg4VjlyZUk0OUgwa2xDUzZ3V1RtRW5mNWVkcUlPKzZYb29vcU5N?=
 =?utf-8?B?VWg2c0l1bGlqWk1LTG9zY0RocUpIT3prbTlCQ2NMYmY1RGtnRXNGMjd1bU01?=
 =?utf-8?B?ZDRnVkg5WDdLbzNUN1RPSVNNSU13RTlBSDk0K005NGxnbjdYakNkMHg4Mzgy?=
 =?utf-8?B?eDZhV1RGM0h4ZnB1TFpjRDVEUE1xNVdTS0pxOVdxSTZxb285bUxOYm93em5C?=
 =?utf-8?B?ZlFiVG5YVEZDUGxma1ZZMDVTeWVkNkgwUDVQa3FCVG1Vd0ptUFdWNlhieEVo?=
 =?utf-8?B?VEZaTVp3S1lDUlAzVEFyVWhDRldpZlU3U0E0bWJSZnRPN3pVOU9UNzdsdFl2?=
 =?utf-8?B?TlFFVExGQk1DSG1YRThocnNabVNCajltQkw2c0xJVXhNaW5VYmN0UkVqZTJu?=
 =?utf-8?B?aWlDRkRZU0lEOXI1MUE5djEzTXFKVDBWK3ExK3ducUFCRjVXZG9NeUVkYUlF?=
 =?utf-8?B?QmtGR3QyTmdwWVorZDBrclIya2JHNVh4ZitEZ2pZcWJhQVk1RFNldEFUSlc0?=
 =?utf-8?B?WW5ZK25HN1dwdzRLRUtLVk1BWmRlNExtRXZlYnNrOFhrQkdVVU9hVVVqNjBU?=
 =?utf-8?B?TG5jZGtNOTdGWkpReWc4QWhsT2JOeFlEZEFJZ2JnMFRGVFdJbWcvdHVGWGFJ?=
 =?utf-8?B?Tnl0RXpLRDFjdGdEeHR6ejFXOVc0cHc0S3VwdGpzanJESWVranhiYzFpS1A3?=
 =?utf-8?B?WGtZS3JncEJZN3ExS3JLblZGUUY1YUs1RC92V3JYVEJXcmZOTUsvcjVHWW45?=
 =?utf-8?B?a2o4elBjMXowODFKbjcvT0ZxbHFlRjlCS3ROdDFOdVZ1d21SUXFkbldLN3R2?=
 =?utf-8?B?ckVKd3BFR1RMeXdyS2NCWUhBQzBaU2pHUHY3M2VKdTZSUGpGTWkvaDRrMnMv?=
 =?utf-8?B?Z205SkdtQThjcW1MNHRXeUNScCtkakplYldiZmhpY2UrbE5IMFJJaWRvV2Nw?=
 =?utf-8?B?dTBuOVMrRFNjckh1OUpZK3ByT3JGa0F2dytCcFZlNnJvMVZaREhlM0w3bDJK?=
 =?utf-8?B?RzZIK3BMZ2g0OXpWT1hlY0U2TFNtOVhhanFVd1I0SEROMkJWaXZtcTBwZlNI?=
 =?utf-8?B?K1E0OUI0TW9QdllyeWRQV2lJUGprQzIwZHZBbEN5YmVUbVpYeGZUd0xXQ3Vt?=
 =?utf-8?B?a0VzZ25OYXNxNEVWZHh6TWFaYXkyb3VSVTRiVlI2R1hHbmIvV1JJNEFuR3Mx?=
 =?utf-8?B?QXowZHg5Y3NkQ1RiZERrcnBSUUtPTkRYNTBHVjMwR0lNang0Q2dnVjB5R0FQ?=
 =?utf-8?B?YTEyTHV6Y0N2N3hqUVRobExwcUEyai96THFGL1BURElkR1E2U2kzQT09?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93a0fd43-f588-44bd-c991-08de76f03a2a
X-MS-Exchange-CrossTenant-AuthSource: CH8PR03MB8275.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2026 17:38:47.4770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XllSjlqx7fS+cLr2Q5EY8b+2x86Ks32V+UIndAM6GwVYBYrBeo2DdW3ccTam5tqGISb6S21JGgAJgnM7BxxQdkzX/h1hxJpbd2EyjE6WeU8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5104
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[citrix.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[citrix.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9068-lists,linux-hyperv=lfdr.de];
	DKIM_TRACE(0.00)[citrix.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew.cooper3@citrix.com,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: A80B51C6197
X-Rspamd-Action: no action

On 28/02/2026 5:34 pm, Uros Bizjak wrote:
> On Sat, Feb 28, 2026 at 5:41 PM Ard Biesheuvel <ardb@kernel.org> wrote:
>> So I don't see any reason for volatile on hv_msr(). However, I do see a potential issue with the compiler assuming that code after the final asm() block is reachable, and calling unreachable() is not permitted [by Clang] due to the __naked attribute.
> As far as the compiler is concerned, there is "nothing" after the last
> asm() block. It can be marked with noreturn attribute, but I don't
> know how it interacts with the naked attribute.

You can't use __builtin_unreachable() in a naked function.  I was going
to suggest it against v1, but alas.

~Andrew

