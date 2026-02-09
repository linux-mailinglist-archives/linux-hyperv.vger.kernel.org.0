Return-Path: <linux-hyperv+bounces-8771-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4I5UGb8mimlKHwAAu9opvQ
	(envelope-from <linux-hyperv+bounces-8771-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 09 Feb 2026 19:26:07 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C2011383C
	for <lists+linux-hyperv@lfdr.de>; Mon, 09 Feb 2026 19:26:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A589B3016242
	for <lists+linux-hyperv@lfdr.de>; Mon,  9 Feb 2026 18:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0876C2FBE1F;
	Mon,  9 Feb 2026 18:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="rrHMocj8"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazolkn19013066.outbound.protection.outlook.com [52.103.20.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9AE12E762C;
	Mon,  9 Feb 2026 18:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.20.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770661562; cv=fail; b=p+DXHVwK03cXmaC5vuXw8mtbpkbtbOdlnbkVmfaJ2gGVGpeAOK3p44Pp/0DUEQU2mvGu/ywfMWZ2yXD0Qv6IgcYqznEQHPnW+YTYF6CcyNR2dgCUOTVg+DwAGekS+NOxRJyyy5ajqHd/1nwi25tZEyt1qUzcAVn/FYH0UhaVXUw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770661562; c=relaxed/simple;
	bh=ejZaDnwT1mhB7hakZzXWxgxqrtmiECrcZifWUHuJlTY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pEKGXYM+TLCnJn9xgKdsaLELstNDCNizVOy3gRKMEs+b/4+8TczTCeaa17nBlvCFxMem5fSMofxURxExUUGDlHR9NjkL13qrT0XRLgx8SESMn7Na9D3kyPmd0S9h5lDK55DICbrWouNTgRuwMfv5cE8DwXmSTGRqIJ53XwtKAck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=rrHMocj8; arc=fail smtp.client-ip=52.103.20.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jfUy1lOLQFCmv7BX5Wj7CteH4EA1Z+hyvjd5nFjFBkMlXfrZETpu852FB1KEqH6IyBtjxa5+15fVSUUh+Px4HPWQNFnSfMln+vFNCc/l6qiEH4V7PKOUmtbdHFMpgHPtP5c8Y6JNlMm0ldyg7jHjn98+I8KwVsG/NJuM0Icgq1ORmOKaJuXhohhyCzy39CLRLZ/6DeuTVJjVj2MpU9cBBG7alU9w+F0RYFQ4V8O/mG171fqv9ref+WjncV+QAFOFvmFUQPdJEpNJTYxjLCOoSyHGeGKbpoX5dIVq9/s19z/FWQSQ+qB8b6j/KJESheoLZmILzq3VaCvUsMa0x8bvCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ejZaDnwT1mhB7hakZzXWxgxqrtmiECrcZifWUHuJlTY=;
 b=FKfXo5g83kboBQZspvHb2RzzCX+C0hjLY4JG/VFp9hpDHA4dPVDnb+JL0AqadKqPZOU+8/JzO/9xa8ubEt15yF4Jd130N5DfRtEC2yHBO1gF+qZ4W7/FEnpsgmMQ3WV2D9BJIUq3MUqrpUsBFao5ntnxQbQWBQZv8H2hOJ1pujXRS2rq3ayHlX6ppvY3wG1UdaBxG3XpvOuvPXtwyoX6gEuwKM1XUhrbObCWetY2h9+GJ2Mr8rw9m8W/g+Cof/NSmRbcNOqxeh6xYLaQbidNUtiBxLQwClm7F27mfoFg++IGJncUMx4XzYPRivD1PLS8TxNJf4qS0GbNFXf61xntJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ejZaDnwT1mhB7hakZzXWxgxqrtmiECrcZifWUHuJlTY=;
 b=rrHMocj8VEWNU0+QAJnzNtIo+vMom/YX+b53/7QtZuNEd4vzchrwtnEqOfu9VpBq3pwjuemgqKm7OcYG7egf6IDFKCMkS8Rfg9/VSn+cAKM8Lh6QO0rmjX7kOR/3gHlFrMnMmyWXhAO+q+gAZ/09z0rLfYTz4lQNv2Ym8ELPRuOhURZ1wF5NrXjiBXtaFtb8PSWsKUPAeSdfJ9W1tLNA7F0eE8Gx1Q7qgOczxWZYJQcf5hWtXQN8I2WyOuBG+d4h3JlniXP98wJnuEIwzmIxb5tvSs15oleHsgk/5GN5ScsvQ/+5iT7eMyCh5STaO73NLs17Ed+d3bvC8UCDpSpCPQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by MN2PR02MB6624.namprd02.prod.outlook.com (2603:10b6:208:1de::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 18:25:59 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 18:25:59 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Florian Bezdeka <florian.bezdeka@siemens.com>, Jan Kiszka
	<jan.kiszka@siemens.com>, "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang
 Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
	<decui@microsoft.com>, Long Li <longli@microsoft.com>, Thomas Gleixner
	<tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, RT
	<linux-rt-users@vger.kernel.org>, Mitchell Levy <levymitchell0@gmail.com>,
	"skinsburskii@linux.microsoft.com" <skinsburskii@linux.microsoft.com>,
	"mrathor@linux.microsoft.com" <mrathor@linux.microsoft.com>,
	"anirudh@anirudhrb.com" <anirudh@anirudhrb.com>,
	"schakrabarti@linux.microsoft.com" <schakrabarti@linux.microsoft.com>,
	"ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>
Subject: RE: [PATCH] x86: mshyperv: Use kthread for vmbus interrupts on
 PREEMPT_RT
Thread-Topic: [PATCH] x86: mshyperv: Use kthread for vmbus interrupts on
 PREEMPT_RT
Thread-Index: AQHclScm1YuvygUhI0+fe3CZOPBAobVzKaaQgAITHgCAATQUcIADxGYAgACBIqA=
Date: Mon, 9 Feb 2026 18:25:59 +0000
Message-ID:
 <SN6PR02MB4157DB59F0F7BFBF56612651D465A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <133a95d9-8148-40ea-9acc-edfd8e3ceef4@siemens.com>
	 <SN6PR02MB4157B6A9C8BEFA312F0D9D68D499A@SN6PR02MB4157.namprd02.prod.outlook.com>
	 <eb5debe8-b7d6-4076-b295-9a02271c2ee6@siemens.com>
	 <SN6PR02MB41579F60E39CA2A3CA8A5A75D467A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <1b569fcf3d096066aeb011e21f9c1fe21f7df9b5.camel@siemens.com>
In-Reply-To: <1b569fcf3d096066aeb011e21f9c1fe21f7df9b5.camel@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|MN2PR02MB6624:EE_
x-ms-office365-filtering-correlation-id: efa09b73-0361-4dba-1581-08de6808ac84
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|13091999003|19110799012|51005399006|8060799015|8062599012|15080799012|31061999003|440099028|3412199025|40105399003|102099032;
x-microsoft-antispam-message-info:
 =?utf-8?B?bnRJb2V4cHlXamhkNTZrejUxMzJzU1hscU1nRXI0bXI5dmtMN3lWeUQzRkx3?=
 =?utf-8?B?V2hKcFgrcDA5V0hrS3E5R2txZW9Bc3hkdGhsWnlJV1dmZ2pXdHMzSnQ5MTli?=
 =?utf-8?B?cWFQbTFUTkZ4dGM0cVRkWXR2S1dKbjFsNXJzcHBOQndwKzBraWxaT3JlRXNT?=
 =?utf-8?B?OHR2VFUzeEtjRnZHNzZ4YWxIVmQwVXpla1hjZjE2dHdodmk5Y1pCbG9qTkhT?=
 =?utf-8?B?aFBGQUdXZ2tCUGhGK0JIZ2Jwa0JHTUdHVytFRVdoRWJMSGRTUHVRZDlTckRy?=
 =?utf-8?B?VFNGUjNTQjAyV3lFRFczTmhXZVF1Ujl0azZsQlZPVWNuM0x6K1lDWWx5cEIx?=
 =?utf-8?B?ZUlPQkdxKzU1ZDRnKzhCc1c2dXdTZUJmY2xWR1JVdXJEaGRwVm8yZmdIaUll?=
 =?utf-8?B?U3lva1lLSEpzbUtwZHFFTXFIR3dSdDdHTnk4QTVqYmsvN3ZkcnhoYzMrbzRl?=
 =?utf-8?B?QzhzS016dUlWaElyZlRtaUptd1h0SU5qT3MxLzJCWUlwdEE4MEJacjBoQThi?=
 =?utf-8?B?YVZwL3RFeWE1bUdKQXNpY1RaNlIvT01leG5mSmFObkhzNG1nYWxLOXhOZUxZ?=
 =?utf-8?B?THpLNExsKzEwY1k3cEFXS2ZEMXFIblRoZkZ5b1JHQWwzbTg1ZFIwZXorYmdo?=
 =?utf-8?B?VnQ5WXc3aXI5b3FIQVY3TUR3NW1MWjYzcHM4bHZMOWNTZ2lhcG44ZkZ0azNZ?=
 =?utf-8?B?QmF2dDZtMGQ1bWZYZkd1bEpTbnpUMEdRVW82czNjV1JPNkYwUTJ4eXVkT2pT?=
 =?utf-8?B?SFFzelB4dHBTVEtHWTRGMTc2a2J2U0NLR1pwNTltb0o2Nnk5UWg4cFpnbzZq?=
 =?utf-8?B?YWFEUUxJWUpLV0FySG9UckpKU3BHak01eTVkZ3psbkIxMk9NTkVaZlNDWWZy?=
 =?utf-8?B?WU9OL0R4eEtISWg2NVBleXRFS0lQeVQzYnlRQWpGQWxpSTRPT3R3Q1ZvVVhj?=
 =?utf-8?B?enRVUnVrMm9WcHVJaFh6Ukx3Y05oVk9BSHJ6T3Q2b2Q5cXRtaGo2cHFpRUU4?=
 =?utf-8?B?eUxSRSswTVRKeFlVaVdNSFJUMkFIVnBkS1FJNG5FZjh6ZTJETFhmbm95T1ph?=
 =?utf-8?B?QUxQRGlHV2d3alNsUDJpWVd3Qlg4YU0xU2xEb28wQzF4RlhyNXlwWFZVc0ls?=
 =?utf-8?B?T295K2wwZVhMcXozRVArZnFUalAvdEtGVW96TC9RdkRjTndmSDNXcEtqUU1y?=
 =?utf-8?B?aE9POVR5N3BvTlRXV2l2ZzBYa21yS3cxdnBkK1VGTEJueFZLMCtZblJIVmhk?=
 =?utf-8?B?R05rN0VJMmdYM1hjK0Q2bFprR3VsY1FYK01jQzUvMzhoZE81b1JlZ1BUUFBz?=
 =?utf-8?B?SUw4TlpGV2txbVFFcGZZM1FGZmVyQ0RKNHk4UGtNWlJzWG9Iblg1eFhhUGtt?=
 =?utf-8?B?T2J3emRHdVdjL00wVlpxbGVzRGRLc2h4ZHVjcGI5ZFY1b2w0Z3hGcjlxa2Y3?=
 =?utf-8?B?SWFaOU0vSUhYSFdUeFp2VWNoSW5LQ2NMeUxIR2xoTktXZitNM2ZZZXhEZUk5?=
 =?utf-8?B?NE9ieGg2T1VWcC82VGtTQ2VaZ1BuWFpHQ25EUW9MQWhBNktVNUZKZjFMNW5F?=
 =?utf-8?B?c29ldS9IQ3h5dkNDcG40WjVFa3QrTkRzbDgrT3l6cXlZdHY2WFNTTXV4VWVZ?=
 =?utf-8?B?SkQ5VFRkbjVDeldQZzdtckVmTUFGSmc9PQ==?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MGdYYTlEeWNBNkpIRnNZV2VVa3dIdEFXNFZLaUNyS0wySkhWVUpVdkQrUytX?=
 =?utf-8?B?dGhQTjZRSGJQTjc3ek8zZFhjbXoyVDJwU1YzTDUxRnFPN2YvQStKZXhLWHpZ?=
 =?utf-8?B?VExlMnlDTS9NQlNNMG90YzJGb1g1VUtDbnZMVTBLSU05cmJvNjAwMlAvUTNU?=
 =?utf-8?B?b3NYSmZhUDQ2YlBMcWxhMGhYbUNSdVZaeSthNnVCd09TSzNHTUZSMlN6dDV5?=
 =?utf-8?B?YXB5bE9qYUV1QkNaRzc3NzRBUVNNZ29MTUhhVWlnT1NYUkhZY05UUkJaK2pL?=
 =?utf-8?B?M1d4cFBOK016T01ZRUxBT3AzZEJrOG1nTG8vTjdoQkdwUXZha0owZnhtV0ln?=
 =?utf-8?B?Wi9OY1lkVGhiTmJVZ29DVXk2bTAwa29uU2lxLzVLT3VyOUVhWGpnNUJPY0N6?=
 =?utf-8?B?Mmx5ZUdpN21icDY3MVNWMTRVcVA5akEyWEdNR0FoaE9TVWkvb2x1WUJ1azV1?=
 =?utf-8?B?T1hWWFJrQUlJNnBCUVk1OTk3Tk9Qc3g0T09Ybm4zZExVSVVVTWpjenpnajBp?=
 =?utf-8?B?VFNJMDJubkZmM3hib0ZJeC9idnNJUURJZCttbGZGRTU5bktKdXhxTERvV1ZP?=
 =?utf-8?B?eUlpK3V4eTF3SnhHY091RjRHcHV3bkNIZHgzYU9kNVpRVFFPczVTK0kzOGN0?=
 =?utf-8?B?aTRmTkNmaFJ3R3I1WkJQUDY5ZFpnTUtzeFdaUkNyNVBZNW1iTExkNDhEN1NV?=
 =?utf-8?B?TE5DcjB0M3d2T2V3TUV1YkN1by8zSEJTYitONFlqL3JUSUZqWjFBYjNtNnRC?=
 =?utf-8?B?c2hiVCtIU1Nvem1zYm1FL042TlliUklWUjIvN0pJcVRicUhwU252cUw1Ym1K?=
 =?utf-8?B?QTR0dGdmRWNhN0dPV09icGlOUHpON045RGdsNlloZnFpbzBBN0ZZM0NXaXdU?=
 =?utf-8?B?TFZSZDBnNkFJK1JiNWhOZ3FGeFdOOUdYbHUxSTdldWFHOEdqQS9CckgxTFp5?=
 =?utf-8?B?blczTDFVSlU5bG1ySVhhODI4eHpGNFVRK0k5Y09tdnd2dmR4UG45OTlmOGI3?=
 =?utf-8?B?QmVmWGZwWVBlUFVuMzFKNEgydlZXblh1MEY2VzVEWHMrbUsyR1pNNXgzMVVO?=
 =?utf-8?B?ZjdxZWxsQytTdEpkK05qRlJyQjhQSkN3N0tBci93akVRLzNmUWljd0Q4NHpy?=
 =?utf-8?B?UjZXVXR4NmY3b2JrYjEzMTByY1JrR3hFMUx5YitIRXVEMU8rSFc1STJEekV4?=
 =?utf-8?B?bWVzYkVhRXMxbmJJL3ZkTWVYM1N5NzJkalZua3RBajFVdFJ3eWgwTlpYd3VQ?=
 =?utf-8?B?bklFaWhpZElheFllY1IrWlY1QjVCUW9Ea2ppL25mUHlHVEhMejlFYUJRK0VS?=
 =?utf-8?B?eTV1K09sZHpRSnlaeFcxVnBDZ3Q0RW9OYnNUQnZTNlgwT2dYTmNNMzhXQVRG?=
 =?utf-8?B?cnRFbXp5cGdxWmdjamVxTllhdDlRck94eTRMTld5Nkd2bTkrOGxKNmVlcEFp?=
 =?utf-8?B?clVmSjAxOHZnakZLOVlralo0SlRQc1BaNFZabHIvU3NxdC9OY3BzMUV2TEVX?=
 =?utf-8?B?Yml0QWMvVm9maDFqc1lJUjNzM1g4eTFPbVRLeE9MVndTbTlXTVBmK3Y4K29E?=
 =?utf-8?B?c3pXdENOMkZTR2NmQ09ObGhzQ2FIVHVzLzRPc3V4MlI0WXVYVGNPdGxkZ1J3?=
 =?utf-8?B?TFdEWW81czNkVWMwVC9ONEYwS0E3TWlkTmp6c0FJbzBtWmZJNDI4enI0OERZ?=
 =?utf-8?B?RldkYy93QnpNNm1idVk5OEJQSDFZK25NaUpWTkVUazBRYlB4b2s4aEEvelFB?=
 =?utf-8?B?ODVIOXNnWElnQkN1TXE1enJuaG9KVHBROEJSajkreHNaY0g2T0pHTHpJaytv?=
 =?utf-8?B?alFyTU5iRkt3ZitLbld4K2EyaDJCZXVKYTl1eGNnSllSNWlYalJ5ODZGbDF1?=
 =?utf-8?B?QUVKZjJUYWRzSmE1cGRobzFqRjROaWZXbjZxVm5pRkoySG1QSnBhSGQ2NDAw?=
 =?utf-8?Q?LAZRF4yah1gLKNeAac3VZHZS3mr+ivvW?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: efa09b73-0361-4dba-1581-08de6808ac84
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2026 18:25:59.5920
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6624
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8771-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,linux.microsoft.com,anirudhrb.com];
	DKIM_TRACE(0.00)[outlook.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,outlook.com:dkim]
X-Rspamd-Queue-Id: D6C2011383C
X-Rspamd-Action: no action

RnJvbTogRmxvcmlhbiBCZXpkZWthIDxmbG9yaWFuLmJlemRla2FAc2llbWVucy5jb20+IFNlbnQ6
IE1vbmRheSwgRmVicnVhcnkgOSwgMjAyNiAyOjM1IEFNDQo+IA0KPiBPbiBTYXQsIDIwMjYtMDIt
MDcgYXQgMDE6MzAgKzAwMDAsIE1pY2hhZWwgS2VsbGV5IHdyb3RlOg0KPiANCj4gW3NuaXBdDQo+
ID4NCj4gPiBJJ3ZlIHJ1biB5b3VyIHN1Z2dlc3RlZCBleHBlcmltZW50IG9uIGFuIGFybTY0IFZN
IGluIHRoZSBBenVyZSBjbG91ZC4gTXkNCj4gPiBrZXJuZWwgd2FzIGxpbnV4LW5leHQgMjAyNjAx
MjguIEkgc2V0IENPTkZJR19QUkVFTVBUX1JUPXkgYW5kDQo+ID4gQ09ORklHX1BST1ZFX0xPQ0tJ
Tkc9eSwgYnV0IGRpZCBub3QgYWRkIGVpdGhlciBvZiB5b3VyIHR3byBwYXRjaGVzDQo+ID4gKG5l
aXRoZXIgdGhlIHN0b3J2c2MgZHJpdmVyIHBhdGNoIG5vciB0aGUgeDg2IFZNQnVzIGludGVycnVw
dCBoYW5kbGluZyBwYXRjaCkuDQo+ID4gVGhlIFZNIGNvbWVzIHVwIGFuZCBydW5zLCBidXQgd2l0
aCB0aGlzIHdhcm5pbmcgZHVyaW5nIGJvb3Q6DQo+ID4NCj4gPiBbICAgIDMuMDc1NjA0XSBodl91
dGlsczogUmVnaXN0ZXJpbmcgSHlwZXJWIFV0aWxpdHkgRHJpdmVyDQo+ID4gWyAgICAzLjA3NTYz
Nl0gaHZfdm1idXM6IHJlZ2lzdGVyaW5nIGRyaXZlciBodl91dGlscw0KPiA+IFsgICAgMy4wODU5
MjBdID09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQo+ID4gWyAgICAzLjA4ODEyOF0gaHZf
dm1idXM6IHJlZ2lzdGVyaW5nIGRyaXZlciBodl9uZXR2c2MNCj4gPiBbICAgIDMuMDkxMTgwXSBb
IEJVRzogSW52YWxpZCB3YWl0IGNvbnRleHQgXQ0KPiA+IFsgICAgMy4wOTM1NDRdIDYuMTkuMC1y
YzctbmV4dC0yMDI2MDEyOCsgIzMgVGFpbnRlZDogRyAgICAgICAgICAgIEUNCj4gPiBbICAgIDMu
MDk3NTgyXSAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiA+IFsgICAgMy4wOTk4OTld
IHN5c3RlbWQtdWRldmQvMjg0IGlzIHRyeWluZyB0byBsb2NrOg0KPiA+IFsgICAgMy4xMDI1Njhd
IGZmZmYwMDAxMDBlMjQ0OTAgKCZjaGFubmVsLT5zY2hlZF9sb2NrKXsuLi4ufS17MzozfSwgYXQ6
IHZtYnVzX2NoYW5fc2NoZWQrMHgxMjgvMHgzYjggW2h2X3ZtYnVzXQ0KPiA+IFsgICAgMy4xMDgy
MDhdIG90aGVyIGluZm8gdGhhdCBtaWdodCBoZWxwIHVzIGRlYnVnIHRoaXM6DQo+ID4gWyAgICAz
LjExMTQ1NF0gY29udGV4dC17MjoyfQ0KPiA+IFsgICAgMy4xMTI5ODddIDEgbG9jayBoZWxkIGJ5
IHN5c3RlbWQtdWRldmQvMjg0Og0KPiA+IFsgICAgMy4xMTU2MjZdICAjMDogZmZmZmQ1Y2ZjMjBi
Y2M4MCAocmN1X3JlYWRfbG9jayl7Li4uLn0tezE6M30sIGF0OiB2bWJ1c19jaGFuX3NjaGVkKzB4
Y2MvMHgzYjggW2h2X3ZtYnVzXQ0KPiA+IFsgICAgMy4xMjEyMjRdIHN0YWNrIGJhY2t0cmFjZToN
Cj4gPiBbICAgIDMuMTIyODk3XSBDUFU6IDAgVUlEOiAwIFBJRDogMjg0IENvbW06IHN5c3RlbWQt
dWRldmQgVGFpbnRlZDogRyAgICAgICAgICAgIEUgIDYuMTkuMC1yYzctbmV4dC0yMDI2MDEyOCsg
IzMgUFJFRU1QVF9SVA0KPiA+IFsgICAgMy4xMjk2MzFdIFRhaW50ZWQ6IFtFXT1VTlNJR05FRF9N
T0RVTEUNCj4gPiBbICAgIDMuMTMxOTQ2XSBIYXJkd2FyZSBuYW1lOiBNaWNyb3NvZnQgQ29ycG9y
YXRpb24gVmlydHVhbCBNYWNoaW5lL1ZpcnR1YWwgTWFjaGluZSwgQklPUyBIeXBlci1WIFVFRkkg
UmVsZWFzZSB2NC4xIDA2LzEwLzIwMjUNCj4gPiBbICAgIDMuMTM4NTUzXSBDYWxsIHRyYWNlOg0K
PiA+IFsgICAgMy4xNDAwMTVdICBzaG93X3N0YWNrKzB4MjAvMHgzOCAoQykNCj4gPiBbICAgIDMu
MTQyMTM3XSAgZHVtcF9zdGFja19sdmwrMHg5Yy8weDE1OA0KPiA+IFsgICAgMy4xNDQzNDBdICBk
dW1wX3N0YWNrKzB4MTgvMHgyOA0KPiA+IFsgICAgMy4xNDYyOTBdICBfX2xvY2tfYWNxdWlyZSsw
eDQ4OC8weDFlMjANCj4gPiBbICAgIDMuMTQ4NTY5XSAgbG9ja19hY3F1aXJlKzB4MTFjLzB4Mzg4
DQo+ID4gWyAgICAzLjE1MDcwM10gIHJ0X3NwaW5fbG9jaysweDU0LzB4MjMwDQo+ID4gWyAgICAz
LjE1Mjc4NV0gIHZtYnVzX2NoYW5fc2NoZWQrMHgxMjgvMHgzYjggW2h2X3ZtYnVzXQ0KPiA+IFsg
ICAgMy4xNTU2MTFdICB2bWJ1c19pc3IrMHgzNC8weDgwIFtodl92bWJ1c10NCj4gPiBbICAgIDMu
MTU4MDkzXSAgdm1idXNfcGVyY3B1X2lzcisweDE4LzB4MzAgW2h2X3ZtYnVzXQ0KPiA+IFsgICAg
My4xNjA4NDhdICBoYW5kbGVfcGVyY3B1X2RldmlkX2lycSsweGRjLzB4MzQ4DQo+ID4gWyAgICAz
LjE2MzQ5NV0gIGhhbmRsZV9pcnFfZGVzYysweDQ4LzB4NjgNCj4gPiBbICAgIDMuMTY1ODUxXSAg
Z2VuZXJpY19oYW5kbGVfZG9tYWluX2lycSsweDIwLzB4MzgNCj4gPiBbICAgIDMuMTY4NjY0XSAg
Z2ljX2hhbmRsZV9pcnErMHgxZGMvMHg0MzANCj4gPiBbICAgIDMuMTcwODY4XSAgY2FsbF9vbl9p
cnFfc3RhY2srMHgzMC8weDcwDQo+ID4gWyAgICAzLjE3MzE2MV0gIGRvX2ludGVycnVwdF9oYW5k
bGVyKzB4ODgvMHhhMA0KPiA+IFsgICAgMy4xNzU3MjRdICBlbDFfaW50ZXJydXB0KzB4NGMvMHhi
MA0KPiA+IFsgICAgMy4xNzc4NTVdICBlbDFoXzY0X2lycV9oYW5kbGVyKzB4MTgvMHgyOA0KPiA+
IFsgICAgMy4xODAzMzJdICBlbDFoXzY0X2lycSsweDg0LzB4ODgNCj4gPiBbICAgIDMuMTgyMzc4
XSAgX3Jhd19zcGluX3VubG9ja19pcnFyZXN0b3JlKzB4NGMvMHhiMCAoUCkNCj4gPiBbICAgIDMu
MTg1NDkzXSAgcnRfbXV0ZXhfc2xvd3VubG9jaysweDQwNC8weDQ0MA0KPiA+IFsgICAgMy4xODc5
NTFdICBydF9zcGluX3VubG9jaysweGI4LzB4MTc4DQo+ID4gWyAgICAzLjE5MDM5NF0gIGttZW1f
Y2FjaGVfYWxsb2Nfbm9wcm9mKzB4ZjAvMHg0ZjgNCj4gPiBbICAgIDMuMTkzMTAwXSAgYWxsb2Nf
ZW1wdHlfZmlsZSsweDY0LzB4MTQ4DQo+ID4gWyAgICAzLjE5NTQ2MV0gIHBhdGhfb3BlbmF0KzB4
NTgvMHhhYTANCj4gPiBbICAgIDMuMTk3NjU4XSAgZG9fZmlsZV9vcGVuKzB4YTAvMHgxNDANCj4g
PiBbICAgIDMuMTk5NzUyXSAgZG9fc3lzX29wZW5hdDIrMHgxOTAvMHgyNzgNCj4gPiBbICAgIDMu
MjAyMTI0XSAgZG9fc3lzX29wZW4rMHg2MC8weGI4DQo+ID4gWyAgICAzLjIwNDA0N10gIF9fYXJt
NjRfc3lzX29wZW5hdCsweDJjLzB4NDgNCj4gPiBbICAgIDMuMjA2NDMzXSAgaW52b2tlX3N5c2Nh
bGwrMHg2Yy8weGY4DQo+ID4gWyAgICAzLjIwODUxOV0gIGVsMF9zdmNfY29tbW9uLmNvbnN0cHJv
cC4wKzB4NDgvMHhmMA0KPiA+IFsgICAgMy4yMTEwNTBdICBkb19lbDBfc3ZjKzB4MjQvMHgzOA0K
PiA+IFsgICAgMy4yMTI5OTBdICBlbDBfc3ZjKzB4MTY0LzB4M2M4DQo+ID4gWyAgICAzLjIxNDg0
Ml0gIGVsMHRfNjRfc3luY19oYW5kbGVyKzB4ZDAvMHhlOA0KPiA+IFsgICAgMy4yMTcyNTFdICBl
bDB0XzY0X3N5bmMrMHgxYjAvMHgxYjgNCj4gPiBbICAgIDMuMjE5NDUwXSBodl91dGlsczogSGVh
cnRiZWF0IElDIHZlcnNpb24gMy4wDQo+ID4gWyAgICAzLjIxOTQ3MV0gaHZfdXRpbHM6IFNodXRk
b3duIElDIHZlcnNpb24gMy4yDQo+ID4gWyAgICAzLjIxOTg0NF0gaHZfdXRpbHM6IFRpbWVTeW5j
IElDIHZlcnNpb24gNC4wDQo+IA0KPiBUaGF0IG1hdGNoZXMgd2l0aCBteSBleHBlY3RhdGlvbiB0
aGF0IHRoZSBzYW1lIHByb2JsZW0gZXhpc3RzIG9uIGFybTY0Lg0KPiBUaGUgcGF0Y2ggZnJvbSBK
YW4gYWRkcmVzc2VzIHRoYXQgaXNzdWUgZm9yIHg4NiAob25seSwgc28gZmFyKSBhcyB3ZSBkbw0K
PiBub3QgaGF2ZSBhIHdvcmtpbmcgdGVzdCBlbnZpcm9ubWVudCBmb3IgYXJtNjQgeWV0Lg0KDQpP
Sy4gSSBoYWQgdW5kZXJzdG9vZCBKYW4ncyBlYXJsaWVyIGNvbW1lbnRzIHRvIG1lYW4gdGhhdCB0
aGUgVk1CdXMNCmludGVycnVwdCBwcm9ibGVtIHdhcyBpbXBsaWNpdGx5IHNvbHZlZCBvbiBhcm02
NCBiZWNhdXNlIG9mIFZNQnVzIHVzaW5nDQphIHN0YW5kYXJkIExpbnV4IElSUSBvbiBhcm02NC4g
QnV0IGV2aWRlbnRseSB0aGF0J3Mgbm90IHRoZSBjYXNlLiBTbyBteQ0KZWFybGllciBjb21tZW50
IHN0YW5kczogVGhlIGNvZGUgY2hhbmdlcyBzaG91bGQgZ28gaW50byB0aGUgYXJjaGl0ZWN0dXJl
DQppbmRlcGVuZGVudCBwb3J0aW9uIG9mIHRoZSBWTUJ1cyBkcml2ZXIsIGFuZCBub3QgdW5kZXIg
YXJjaC94ODYuIEkNCmNhbiBwcm9iYWJseSB3b3JrIHdpdGggeW91IHRvIHRlc3Qgb24gYXJtNjQg
aWYgbmVlZCBiZS4NCg0KPiANCj4gPg0KPiA+IEkgZG9uJ3Qgc2VlIGFuIGluZGljYXRpb24gdGhh
dCB2bWJ1c19pc3IoKSBoYXMgYmVlbiBvZmZsb2FkZWQgZnJvbQ0KPiA+IGludGVycnVwdCBsZXZl
bCBvbnRvIGEgdGhyZWFkLiAgVGhlIHN0YWNrIHN0YXJ0aW5nIHdpdGggZWwxaF82NF9pcnEoKQ0K
PiA+IGFuZCBnb2luZyBmb3J3YXJkIGlzIHRoZSBzdGFjayBmb3Igbm9ybWFsIHBlci1jcHUgaW50
ZXJydXB0IGhhbmRsaW5nLg0KPiA+IE1heWJlIGFybTY0IHdpdGggUFJFRU1QVF9SVCBkb2VzIHRo
ZSBvZmZsb2FkIHRvIGEgdGhyZWFkIG9ubHkNCj4gPiBmb3IgU1BJcyBhbmQgTFBJcywgYnV0IG5v
dCBmb3IgUFBJcz8gSSBoYXZlbid0IGxvb2tlZCBhdCB0aGUgc291cmNlIGNvZGUNCj4gPiBmb3Ig
aG93IFBSRUVNUFRfUlQgYWZmZWN0cyBhcm02NCBpbnRlcnJ1cHQgaGFuZGxpbmcuDQo+ID4NCj4g
PiBBbHNvLCBJIGhhZCBleHBlY3RlZCB0byBzZWUgYSBwcm9ibGVtIHdpdGggc3RvcnZzYyBiZWNh
dXNlIEkgZGlkDQo+ID4gbm90IGFwcGx5IHlvdXIgc3RvcnZzYyBwYXRjaC4gQnV0IHRoZXJlIHdh
cyBubyBzdWNoIHByb2JsZW0sIGV2ZW4NCj4gPiB3aXRoIHNvbWUgZGlzayBJL08gbG9hZCAocmVh
ZCBvbmx5KS4gYXJtNjQgVk1zIGluIEF6dXJlIHVzZSBleGFjdGx5DQo+ID4gdGhlIHNhbWUgdmly
dHVhbCBTQ1NJIGRldmljZXMgdGhhdCBhcmUgdXNlZCB3aXRoIHg4NiBWTXMgaW4gQXp1cmUgb3IN
Cj4gPiBvbiBsb2NhbCBIeXBlci1WLiBJIGRvbid0IGhhdmUgYW4gZXhwbGFuYXRpb24uIFdpbGwg
dGhpbmsgYWJvdXQgaXQuDQo+ID4NCj4gDQo+IFJ1bm5pbmcgdGhlIC0taW9taXggc3RyZXNzb3Ig
cHJvdmlkZWQgYnkgc3RyZXNzLW5nIHdhcyBhYmxlIHRvIHRyaWdnZXINCj4gdGhlIFNDU0kgcHJv
YmxlbSB3aXRoaW4gMiBtaW51dGVzLiBUaGUgcmVzdWx0IHdhcyBhIGNvbXBsZXRlbHkgZnJvemVu
DQo+IHN5c3RlbS4gRm9yIGNvbXBsZXRlbmVzcyB0aGUgY29tcGxldGUgc3RyZXNzLW5nIGNvbW1h
bmQgbGluZToNCj4gDQo+ICMgc3RyZXNzLW5nIC0tY3B1IDIgLS1pb21peCA4IC0tdm0gMiAtLXZt
LWJ5dGVzIDEyOE0gLS1mb3JrIDQNCj4gDQoNClRoYW5rcyENCg0KWWVzLCB0aGF0IGNvbW1hbmQg
bGluZSByZXByb2R1Y2VkIHRoZSBzdG9ydnNjIHByb2JsZW0gb24gYXJtNjQuIEFuZA0KdGhlbiBh
cHBseWluZyB0aGUgc3RvcnZzYyBwYXRjaCBtYWRlIHRoZSBwcm9ibGVtIGdvIGF3YXkuIEZXSVcs
IG9uDQphcm02NCBMaW51eCByZWNvdmVyZWQgYW5kIGtlcHQgcnVubmluZyBhZnRlciBoaXR0aW5n
IHRoZSBzdG9ydnNjDQpwcm9ibGVtLg0KDQpNaWNoYWVsDQo=

