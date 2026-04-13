Return-Path: <linux-hyperv+bounces-10135-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AH1AH+YR3WkOZQkAu9opvQ
	(envelope-from <linux-hyperv+bounces-10135-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Apr 2026 17:55:18 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 224BD3EE384
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Apr 2026 17:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 428A8305E98A
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Apr 2026 15:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823FD3B52F8;
	Mon, 13 Apr 2026 15:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="OW90revv"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazolkn19010016.outbound.protection.outlook.com [52.103.13.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97933B0AFD;
	Mon, 13 Apr 2026 15:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.13.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776095398; cv=fail; b=BbYa3OKNeWSFKmeYnSFDaw9BPpEeZqWLChCjxEfrxrig35u++k79RWLC5ate1sy9D8fPSJFONLVtuWMpvJRVGqy88y+OjlPZqJwgBbSfrezSulkVFV/PHoZ9wEl6OnOXcqbk/bflTpPXnTvoDeeWotj2Se+MB1fsygzUs3rOfEw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776095398; c=relaxed/simple;
	bh=xiVscvhF1iEMmG6ox2JnSq98LIX5NxlsNjEwygFu2Ek=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rcueNBOOZ/18aqXqkkKZ5nWUU6XNci92XPYru+O/QjxatxypJnJMhfrZd4IRmjq4NBKR/F2aS6S8OhUo/T9OKqgxsCDG1pUSB56su+IM9lRtYM+ZNHBw2SxCrRnJdGMO+ecdxsZTeLhICldZIRw2XZVYnzzgmZKnAKGlplVpDUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=OW90revv; arc=fail smtp.client-ip=52.103.13.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MGNNPt9UElyjwDS3SSBMi3aUD9/sBrxi7rNaxprqRbHShZFsxufHigS54yzsbBtA0lcWtPSSCKwgsJCgTfhzsNroR/2pkaJWdGHbVltbCE3ShfzHtpOu3Rm7UUimNCDy7YVqZJ8sBeezmewjpA2i5ENl9BR8z/2iVYeiKUDQvWOHlqddZ4PiLKvDxbd+nbAigUvu9vsl/0+kxJJ01OVlLFodV0o5+acH8Mzl+e56PBqvSNnySPFSG3Q53+FYM2e/D3uUTNE6iUtoUCbxigh0SdJKyq3MxiEk+WOMiDFr4qOzBBHrjretcwE4lLNwLt3TAQahWCowx+Chu/hcAqzPRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xiVscvhF1iEMmG6ox2JnSq98LIX5NxlsNjEwygFu2Ek=;
 b=T13f2usn9hZSIz5cr2+zqU46uOgJGNM4supX5SYOUOIj6izPHIfYDRF1cpeRxeLYObR9CIfxGIY5KGpHvBrSqB8h7MWOpMABhMOuwVVfNS+/A6q54na/FpXtP8orvYPpcSS7ll829Mug5AWWAdQOl4sYTYVkSgM8DyJgfjvCrmPu+aG4PmNIXPdztyVQn6eUQmxrBDL3jbqcM2j9Ek/j6N+s55p2q2zX+Ai2FBNyx7LFSM0AZr4ABksAwjrpSyLfTzSmBdgcjvp/EhFl5EB96C/OhbULDEUw61QZAfy1ip0iF+9GOkFvtUMjjMiM/2asGPRInnXavn01Fu7A/B4EMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xiVscvhF1iEMmG6ox2JnSq98LIX5NxlsNjEwygFu2Ek=;
 b=OW90revvz27fJRzquG+oyeyd0yWsLWTDS0Oc6XU5cDur8A/fAY3DlC4ZQDw2gjRHvkQZ8UekMv/b/lKbFsjJwhITemkypYd/osnodhs3p+Dle3ADLZg3Tqp6JewTEgd0Lnkm3xdtxnx28LpGjVellyN4DdQFfUERl8rjqdxT/u34Rdg7hDgJofBHxvNiS6NX69VyJFwYdxnJLNsFvrTTr6Tqnj3X5/so4bvAK8bmZw7NQSV+G/VH2bLkdddOLJ0xebYQ0Lf8pZiMHoTQXS5/5Ior3Agf6Y08tx27jvi/xaH2g4XNFknVSQ3bBl2YO+HzCzGnH7azT1kUq5Qk5i+YPQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SA2PR02MB7658.namprd02.prod.outlook.com (2603:10b6:806:137::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Mon, 13 Apr
 2026 15:49:54 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9769.046; Mon, 13 Apr 2026
 15:49:54 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Naman Jain <namjain@linux.microsoft.com>, "K . Y . Srinivasan"
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Long Li
	<longli@microsoft.com>, Catalin Marinas <catalin.marinas@arm.com>, Will
 Deacon <will@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, "H . Peter
 Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, Paul Walmsley
	<pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
CC: Marc Zyngier <maz@kernel.org>, Timothy Hayes <timothy.hayes@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>, mrigendrachaubey
	<mrigendra.chaubey@gmail.com>, "ssengar@linux.microsoft.com"
	<ssengar@linux.microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>
Subject: RE: [PATCH 06/11] Drivers: hv: Make sint vector architecture neutral
 in MSHV_VTL
Thread-Topic: [PATCH 06/11] Drivers: hv: Make sint vector architecture neutral
 in MSHV_VTL
Thread-Index: AQHctT5Uo06CdizxUEmOmS2tUYF/frXKhrvAgBKFcICAAEOtMA==
Date: Mon, 13 Apr 2026 15:49:53 +0000
Message-ID:
 <SN6PR02MB4157DA00A31F0BA8585B9B69D4242@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260316121241.910764-1-namjain@linux.microsoft.com>
 <20260316121241.910764-7-namjain@linux.microsoft.com>
 <SN6PR02MB4157521DEF9EA2471B6F3359D450A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <b5125f61-173f-45d0-a6dc-d795ba0f8693@linux.microsoft.com>
In-Reply-To: <b5125f61-173f-45d0-a6dc-d795ba0f8693@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SA2PR02MB7658:EE_
x-ms-office365-filtering-correlation-id: c18dcaea-8471-443a-2930-08de99744e28
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799012|37011999003|51005399006|31061999003|8062599012|461199028|13091999003|8060799015|19110799012|40105399003|3412199025|440099028|102099032|26121999003;
x-microsoft-antispam-message-info:
 =?utf-8?B?UE5GdmtkUUlyM1dIb1hEQzZHWUwrZDRXVEwyOXhzSzdWUHRtRm41dzFNdnhF?=
 =?utf-8?B?Qnl0Z3E4UDN4eVBUeVJnUDNEaDN2ZklLTzhqL1JrQWRjaWtENlQ0VEdkWW0w?=
 =?utf-8?B?NVRQTnBkdmYrM2wyZ0doMzl1ZEIxRk9CU2VZM0swWGZaNERQQzhHMExYQjV0?=
 =?utf-8?B?TnRteVlOVzhscHFQclA1Qno0cEwrQ1Q2ck1yNERMT3h1dml1Ym1LMVMyRnpP?=
 =?utf-8?B?UksraU84SjFRUCtCeEZJeDZpNHZmQ3B6aXNoNU0xMklDQkF5bmxtVnFKV2xx?=
 =?utf-8?B?aVZoL0k4eXphSVNyMFdpWkV3amMvaEZGOUVCNVlLYXpCTlZuTnhjVTZ0RFBm?=
 =?utf-8?B?ajNYWnRiSjkvdjZ2aFBIUXJBL2QzSlNMOVNVMTJLTnNkcHIrRmQvZkpyZHJa?=
 =?utf-8?B?REdOWVYrQUlYaGFDcjNKSHhkN1lCajlMVnR3QTF2bWVjZVZ0cHY3Q2d3Q0ta?=
 =?utf-8?B?UEVxeXNibzFzUUlFVGJVL0RGOXlIRVV2VE5pbGZEbXphVkJIUmlVckRkQ0ph?=
 =?utf-8?B?N3Y1Q2FEUGhRM0dxMG4zNm9qQnBoanRsdE9SUGEwU003TGQyaGtZMHNCWWdV?=
 =?utf-8?B?WXhCZTlUM0hnZnN3UzFwNUxRUzM4WFQwRWg3MGJuRU5sLzhmR2pxOFUvbGRD?=
 =?utf-8?B?clhORHdZRUIrKzhQWGowcjJXeVhCSlo0QmFTSFoxM2g5MVpFRHhKWG5tQ2tJ?=
 =?utf-8?B?TEZQdUhYY0c2dTVnV2JyQVJFeVlwREROTUtQWTJNNzhQN3c1UHdWVTZacEhr?=
 =?utf-8?B?WFlXSjZKQ01uOG9neXc2dEJzc3p6VWxyemF0ZGRTZVMwL2RSdG9rdjRwTnd1?=
 =?utf-8?B?anpPZWVZb0tKZmx6Nm1teHdyNmQ5dlZjMWErWG9YUDV4N0xubjZWMnl4Yk9l?=
 =?utf-8?B?cFYrSXNPTG40bjdBckgycmVMQTFaWWpKdXdpWlRNeExwbEdpbWNQNm1RY3h6?=
 =?utf-8?B?NHUrNkhxUXNUR0psRm4za2xzMW5XY3g0MnR4Yms1N3Y4V3FzeG92SlZpdHp3?=
 =?utf-8?B?c0tOZVhWeHVOWlU5cHJZVjF3NGxKMjNKbzhnL2xqQmQvMzVkL0Z5NGZTUGF6?=
 =?utf-8?B?NnNFd1IxRjRIa3RqeUdFTHVrMFNMNWxPSGVYVi9YQXZFbk1MZVdraFRudHEy?=
 =?utf-8?B?cEhTcVZqNCtuQkJTRy9idVRGcldrY0QrTDBBQnBCTW1xbVhxdWZVTzdiWll3?=
 =?utf-8?B?VDlyT1FYLzV6c3o0VUFNamQxcG91MjJRZHd1THl3YnBOSXRNSDNXd1Y1Y2RW?=
 =?utf-8?B?VEtNdzRRckxyZ1RZVDQrL2NVSkc0SnJCNVczN2NBcENpT0owczVjcEdVRFkv?=
 =?utf-8?Q?qGVTNZjb4uiinTLWTjGRDOOeOfRK5td+f6?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RG9oemFrQmdySnM2c0RzVlQxQ0xWWnIvZ1pvTW02eHhnaXlvMC9TTG1WTVJG?=
 =?utf-8?B?QXFFT1NSTjB6UC9SWHgrUWFCZWliWXdOQnE3OWgwc1RvZ292OWJKb0Y4N3FK?=
 =?utf-8?B?a1BuOFJya3E1YWs4S1VxbWRWRjlNR3dwSVZ6aFBqOFhVbzVCUHlUOXc5dFJt?=
 =?utf-8?B?amx2WlcrcEQ0SnV5dnhmSmx3RkhSeHZXdFA5V2dDcDczcjlCcEVRTjFZR0pH?=
 =?utf-8?B?LzYwTGNiQTNBYytZN3hzaWUwY2RXc3BWUTlTTHN3Z1lMRGM0dk9zSm5HQjdB?=
 =?utf-8?B?R0JKS3pndmlQd0tUUlZrK2RVcE0xYmFkTE91U1k3ZkNBWVFTYlc2d0ZhYits?=
 =?utf-8?B?WHBHVGpRS2JHUFA3alIwSy9PSC8xcTRZNmNzWm5Yam9qT0JtOTFnaDlZeTlu?=
 =?utf-8?B?NlcyTnNBdENEZGx5VE9VUXd3dDRLN1A1V2Z5R21DTzh0Y052NTRpYnB1VUlS?=
 =?utf-8?B?a2xqeVRtZlc4NEZwWUY4S1ZndHdqQUR2a0ZCUjU1QUMrTTJwWjJOTmZUamEw?=
 =?utf-8?B?SlFDcXNkUk5OZUNqTVErdXJMaGQwcGtxalF0NU53Qk5FRTI5ZW5QM2w4eWFU?=
 =?utf-8?B?WlpCdzExajIvWmF4ckVFWStqMDRJWTY0RU41dllieGtSdXRuWG41RGZQNW85?=
 =?utf-8?B?elFLdSswQUY4QlZGemUxUVdRTFNmU3ZBY2oxMjBjTzlYdnNDd0ZQZmNMdEg1?=
 =?utf-8?B?U2I1Qm0rUUU0UStYNFpBeTYvQU9ZRVZidC9PYjNGREREUmlLRzhiTjJxZE9H?=
 =?utf-8?B?bEE5N2pZVmNBU01RbXpVd00rRUV3c0ZZK1orWmF2bDRTb2svZVhWMnE1S1hE?=
 =?utf-8?B?eVAxWjY1eWFyL1hLWW9HWkhleVRkbWR5WTlwcllzblBqZDBCeE1iMUt4Tjhh?=
 =?utf-8?B?VkkyU0xrNmMxYldodDM2cFFONW43SXVSYjZDZnRRdnkyZVY2ZVhCckxoYnQv?=
 =?utf-8?B?V0l1VFlCekxHRm1wdHI0UElPNElGc1YzdWpTUVdBdHBmUnhiVmtNZnR1eStl?=
 =?utf-8?B?SFlvN3gvN3N6SnYvSndWdHV2OHl3RUZUSldTNmlPcmxWdC93Z0pwTWRoUE9P?=
 =?utf-8?B?RlFPdmtqcjEzL2toOTFVTkYwVXpIZnBsN3pFV0lGVmFuUUdQNU1pMlpvUEor?=
 =?utf-8?B?MGhEbWh0ZEZ4QzFPcExvRnFTeFFIbG5HblVrVGRZOGRweFZVMXBzb2hyTlpL?=
 =?utf-8?B?TkozaERjbDFWaFByZzNnMlhQc3NqS0oxb3FCNVluLzNGZ2h2VkFBMGc2ejJz?=
 =?utf-8?B?bU85NjZNR2pnWDlSckNXMU9RMXpKK3hUMFVRR0NYN0Z4endsSlByMTBCMlQz?=
 =?utf-8?B?aUdUR2ZtK3lxaXRCdE44TkdGWHBDUVR4ZTQ2clI5YU5zK2ZDL2FHRzFqQ041?=
 =?utf-8?B?M2I3WG13MjQ5Y3FrbnhaYVhKNWJUZEhGL1YzK3NXa0h1RUhndXp5REtyV0JB?=
 =?utf-8?B?WFltelhKMXdDZXR4Z1Z4NjlMbEFITGxIenBDUDM1WEJaMStPQlVaK0dKcEZ0?=
 =?utf-8?B?eS9JTTBNM3R0eFpLWEhJSTZIdDNwcHhUamZOV3h6SGRSaDBGaDBlYyszNnVE?=
 =?utf-8?B?S3hVNS9KZWdUT2o0WEZIWE9sV09DZWsxTGF0cVRBQ3VnS3RiVVlmNkp2MVRw?=
 =?utf-8?B?OVRrRWJNYnNQRkxLSE5NOStRaFhtMVN0dEk2SEpJa3VGVlowSXBaUWI4VlNn?=
 =?utf-8?B?QWFUSHRLbEdvdmFyeDdzRXhOUGpOSkQ5UHN0NmlQUjV1M25CZGNWQ1orcFdy?=
 =?utf-8?B?c1hNRVNsY3RPdjJWcFk0TUFwWFIwcjgxZFNCYm1GY1NJaGJsN1Y1cDdrWXpi?=
 =?utf-8?Q?ZIfzNbAO06btLSzkShSLuubuZysz0+3S0c2iQ=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c18dcaea-8471-443a-2930-08de99744e28
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2026 15:49:53.9629
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR02MB7658
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10135-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	RCPT_COUNT_TWELVE(0.00)[29];
	FREEMAIL_CC(0.00)[kernel.org,arm.com,gmail.com,linux.microsoft.com,vger.kernel.org,lists.infradead.org];
	DKIM_TRACE(0.00)[outlook.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 224BD3EE384
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

RnJvbTogTmFtYW4gSmFpbiA8bmFtamFpbkBsaW51eC5taWNyb3NvZnQuY29tPiBTZW50OiBNb25k
YXksIEFwcmlsIDEzLCAyMDI2IDQ6NDggQU0NCj4gDQo+IE9uIDQvMS8yMDI2IDEwOjI3IFBNLCBN
aWNoYWVsIEtlbGxleSB3cm90ZToNCj4gPiBGcm9tOiBOYW1hbiBKYWluIDxuYW1qYWluQGxpbnV4
Lm1pY3Jvc29mdC5jb20+IFNlbnQ6IE1vbmRheSwgTWFyY2ggMTYsIDIwMjYgNToxMyBBTQ0KPiA+
Pg0KPiA+PiBHZW5lcmFsaXplIFN5bnRoZXRpYyBpbnRlcnJ1cHQgc291cmNlIHZlY3RvciAoc2lu
dCkgdG8gdXNlDQo+ID4+IHZtYnVzX2ludGVycnVwdCB2YXJpYWJsZSBpbnN0ZWFkLCB3aGljaCBh
dXRvbWF0aWNhbGx5IHRha2VzIGNhcmUgb2YNCj4gPj4gYXJjaGl0ZWN0dXJlcyB3aGVyZSBIWVBF
UlZJU09SX0NBTExCQUNLX1ZFQ1RPUiBpcyBub3QgcHJlc2VudCAoYXJtNjQpLg0KPiA+DQo+ID4g
U2FzaGlrbyBBSSByYWlzZWQgYW4gaW50ZXJlc3RpbmcgcXVlc3Rpb24gYWJvdXQgdGhlIHN0YXJ0
dXAgdGltaW5nIC0tDQo+ID4gd2hldGhlciB0aGUgdm1idXNfcGxhdGZvcm1fZHJpdmVyX3Byb2Jl
KCkgaXMgZ3VhcmFudGVlZCB0byBoYXZlDQo+ID4gc2V0IHZtYnVzX2ludGVycnVwdCBiZWZvcmUg
dGhlIFZUTCBmdW5jdGlvbnMgYmVsb3cgcnVuIGFuZCB1c2UgaXQuDQo+ID4gV2hhdCBjYXVzZXMg
dGhlIG1zaHZfdnRsLmtvIG1vZHVsZSB0byBiZSBsb2FkZWQsIGFuZCBoZW5jZSBydW4NCj4gPiBt
c2h2X3Z0bF9pbml0KCk/DQo+IA0KPiBUaGVyZSBpcyBubyByYWNlIGNvbmRpdGlvbiBoZXJlLiBU
aGUgaW5pdCBvcmRlcmluZyBndWFyYW50ZWVzIHRoYXQNCj4gdm1idXNfaW50ZXJydXB0IGlzIGFs
d2F5cyBzZXQgYmVmb3JlIG1zaHZfdnRsX3N5bmljX2VuYWJsZV9yZWdzKCkNCj4gcmVhZHMgaXQu
DQo+IA0KPiBUaGUgY2FsbCBjaGFpbiBmb3Igc2V0dGluZyB2bWJ1c19pbnRlcnJ1cHQ6DQo+IA0K
PiAgICBzdWJzeXNfaW5pdGNhbGwoaHZfYWNwaV9pbml0KSAgICAgICAgICAgICAgICAgICAgICAg
ICAgW2xldmVsIDRdDQo+ICAgICAgLT4gcGxhdGZvcm1fZHJpdmVyX3JlZ2lzdGVyKCZ2bWJ1c19w
bGF0Zm9ybV9kcml2ZXIpIGFuZCBzbyBvbi4NCj4gDQo+IA0KPiBUaGUgY2FsbCBjaGFpbiBmb3Ig
cmVhZGluZyB2bWJ1c19pbnRlcnJ1cHQ6DQo+IA0KPiAgICBtb2R1bGVfaW5pdChtc2h2X3Z0bF9p
bml0KSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgW2xldmVsIDZdDQo+ICAgICAgLT4gaHZf
dnRsX3NldHVwX3N5bmljKCkNCj4gICAgICAgIC0+IGNwdWhwX3NldHVwX3N0YXRlKENQVUhQX0FQ
X09OTElORV9EWU4sIC4uLiwgbXNodl92dGxfYWxsb2NfY29udGV4dCwgLi4uKQ0KPiAgICAgICAg
ICAtPiBtc2h2X3Z0bF9hbGxvY19jb250ZXh0KCkNCj4gICAgICAgICAgICAtPiBtc2h2X3Z0bF9z
eW5pY19lbmFibGVfcmVncygpDQo+ICAgICAgICAgICAgICAtPiBzaW50LnZlY3RvciA9IHZtYnVz
X2ludGVycnVwdA0KPiANCj4gZG9faW5pdGNhbGxzKCkgcHJvY2Vzc2VzIHNlY3Rpb25zIGluIG9y
ZGVyIDAgdGhyb3VnaCA3LCBzbw0KPiBodl9hY3BpX2luaXQoKSAobGV2ZWwgNCkgaXMgZ3VhcmFu
dGVlZCB0byBjb21wbGV0ZSBiZWZvcmUNCj4gbXNodl92dGxfaW5pdCgpIChsZXZlbCA2KSBydW5z
Lg0KPiANCg0KSSB0aGluayB0aGUgc2l0dWF0aW9uIGlzIG1vcmUgY29tcGxleCB0aGFuIHdoYXQg
eW91IGRlc2NyaWJlLCBkZXBlbmRpbmcNCm9uIHdoZXRoZXIgdGhlIFZNQnVzIGRyaXZlciBhbmQv
b3IgTVNIVl9WVEwgYXJlIGJ1aWx0IGFzIG1vZHVsZXMgdnMuDQpiZWluZyBidWlsdC1pbiB0byB0
aGUga2VybmVsIGltYWdlLiBJbiBpbmNsdWRlL2xpbnV4L21vZHVsZS5oLCBzZWUgdGhlDQpjb21t
ZW50IGZvciBtb2R1bGVfaW5pdCgpIGFuZCBob3cgc3Vic3lzX2luaXRjYWxsKCkgaXMgbWFwcGVk
DQp0byBtb2R1bGVfaW5pdCgpIHdoZW4gYnVpbHQgYXMgYSBtb2R1bGUuDQoNCklmIGJvdGggYXJl
IGJ1aWx0LWluLCB0aGVuIHdoYXQgeW91IGRlc2NyaWJlIGlzIGNvcnJlY3QuIEJ1dCBpZiBlaXRo
ZXIgb3INCmJvdGggYXJlIG1vZHVsZXMsIHRoZW4gdGhlIHJlc3BlY3RpdmUgaW5pdCBmdW5jdGlv
bnMgKGh2X2FjcGlfaW5pdA0KYW5kIG1zaHZfdnRsX2luaXQpIGdldCBjYWxsZWQgYXQgdGhlIHRp
bWUgdGhlIG1vZHVsZSBpcyBsb2FkZWQsIGFuZA0Kbm90IGJ5IGRvX2luaXRjYWxscygpLiBJIHRo
aW5rIGh2X3ZtYnVzLmtvIGdldHMgbG9hZGVkIHdoZW4gYW4gYXR0ZW1wdA0KaXMgZmlyc3QgbWFk
ZSB0byBhY2Nlc3MgYSBkaXNrLCBidXQgSSB3b3VsZCBuZWVkIHRvIGxvb2sgbW9yZSBjbG9zZWx5
IHRvDQpiZSBzdXJlLiBJIGRvbid0IGhhdmUgYW55IHVuZGVyc3RhbmRpbmcgb2Ygd2hhdCBjYXVz
ZXMgbXNodl92dGwua28NCnRvIGJlIGxvYWRlZC4gQW5kIHdoYXQgaXMgdGhlIG9yZGVyaW5nIGlm
IE1TSFZfVlRMIGlzIGJ1aWx0LWluIHdoaWxlDQpWTUJ1cyBpcyBidWlsdCBhcyBhIG1vZHVsZSwg
b3IgdmljZSB2ZXJzYT8NCg0KTWljaGFlbA0KDQoNCg0KDQo=

