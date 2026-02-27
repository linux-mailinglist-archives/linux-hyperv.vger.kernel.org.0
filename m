Return-Path: <linux-hyperv+bounces-9033-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFNHB2fBoWkVwQQAu9opvQ
	(envelope-from <linux-hyperv+bounces-9033-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Feb 2026 17:08:07 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F5F1BA8DB
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Feb 2026 17:08:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 83E96301AAA9
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Feb 2026 15:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F434418F3;
	Fri, 27 Feb 2026 15:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="iBk2IQvf"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010017.outbound.protection.outlook.com [52.101.69.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1DC329361;
	Fri, 27 Feb 2026 15:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772207716; cv=fail; b=tQrI1IlKftzA/t0kGiJgTWd5o0Dxa6YFcdY83bscOdhW+vSFspX+z/B6lrPq2cOEgUSwBxeM3KaWbW8PgbnYvBpqDrosB38S+o6HlbS+egxVQMv83GhIv2PuYCWNNLMEKTjtju+7O2GmaaGkvzr0VaKEcAXWgV/TrYZev4ZuCac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772207716; c=relaxed/simple;
	bh=WSWspxpiATjtsMq6XrJLl7U8/+wo0wUp4wcsfVTcCeU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gOhfzJaxngre6LeQzubvyuSUy8bzqu2tUJV5hJ6JrEy1yww282C9ux4m+Z6Jtxym2eUP8wP5+Nl7e7knuNpSIhpxJyaLZN5bP3lLUl9wO+JgYSDP6I/QD73Bb9drwEUiqd/FGQxQGUEIuRMZ9HLwhoZe1pnEIQpIF0UyqFjJI+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=iBk2IQvf; arc=fail smtp.client-ip=52.101.69.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l586jTPL7EDf5LcCvixuG8GOZvDGMVIy65ZdCXuWrUg2L9JlqKgZdqtXYNp47eaoAM+4oG3fsc5JS8800KkaaqFc3CuAgg4bSqTHVOF86AyHbml/DVqgg7XEiI9l2n8zHSE1u8p7koX5D/t6vDeK1WuOnRsLApk1QnVM20uH7guD5ht3bdaapPSS8a71YE2rt5S0kv9nAP+kxeedkH8plYjAMf8F4KkZSlqey65dul1buXuC9/eHX/0wybTrcuA5hNFlHzwoBDDLVayDjfsRRbWHL/zVQ+0Po9Dp8x4nNbVKx09DWYiRL+XhmeHwGv/cf4M/t57DbKPVYyZpoOrp6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0+QoHePhVG9iRkUUrw+HLJD+o8XSMIfKoL4DPSYyAw4=;
 b=GsYlaJGOvmXaesPLFxSSK4VlriHBXwYpzZvD83arzCtBQ6peBMgduV0S5rT4D6TE7xG/7EW58jp/EEg6pUNHMCGWAL4DCvpwkh2Z0yzhC1Z8ACwSpl2R3Sr/mgv+B1SVOwOnHWhxxudk4Wf5WitBw++fYHrcUexipORaCAfHPR24apz15xjXPE7hA3SndWCsg6eO8Z+n2MPL//IUI13dIrkdsS/w1uDGb5JDxjON9XRHYKF24zFeo0dBHuXSeZ4wNvJ9LttdVL8BlgeQCFlAV4DgfNCMRbQXZ2HcLSQpLcIwnh7/FSxKdTECGDeXC5B6TEfwLqg/XkPo2HXSbDicOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0+QoHePhVG9iRkUUrw+HLJD+o8XSMIfKoL4DPSYyAw4=;
 b=iBk2IQvfOJayYs4WMfSlq3AqPP/IQjc5pfbcJZdWx39DeKIAJX2LUCEEKG8I5RZ1InBkDye2Vy4TvqMtMFOD13ymTrUSwEhw0QMLhIzUvNSeOIvWjaQFDSVVXr9ystLFnxLVnJHNqEAjEUOPcXk4U3h2prDi7n69RUxoKPSLRQuNaH+Ux7IJSl6Tl9ojR1K6W1EarM2fvZ1drY+dj0Jv8phJC0kXGTszWwFDWdOvVmirzqiUXi9n1HFK1q30k0YRA9mIUHD6gnVPz4Rt9ai8mQfisur/a5UsD0+84tq0bK3H4KDgrI1FiyBXp/qhKFfNm0WlJt9E4G/cwF3yF/qoxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by GV1PR10MB8318.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1ca::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Fri, 27 Feb
 2026 15:55:09 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::63bc:6561:54d3:94b9]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::63bc:6561:54d3:94b9%5]) with mapi id 15.20.9654.013; Fri, 27 Feb 2026
 15:55:09 +0000
Message-ID: <898e9467-0c05-46b4-a3ed-518797b829c5@siemens.com>
Date: Fri, 27 Feb 2026 16:55:07 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scsi: storvsc: Fix scheduling while atomic on PREEMPT_RT
To: "Martin K. Petersen" <martin.petersen@oracle.com>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 linux-hyperv@vger.kernel.org
Cc: linux-scsi@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Florian Bezdeka <florian.bezdeka@siemens.com>,
 RT <linux-rt-users@vger.kernel.org>, Mitchell Levy <levymitchell0@gmail.com>
References: <0c7fb5cd-fb21-4760-8593-e04bade84744@siemens.com>
 <177195161164.1154639.10246495163151300179.b4-ty@oracle.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <177195161164.1154639.10246495163151300179.b4-ty@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0081.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::11) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|GV1PR10MB8318:EE_
X-MS-Office365-Filtering-Correlation-Id: 074f56bb-7caa-4333-be78-08de76189569
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	16kkxlA5TghtKJMyII3Wk2h7symU0w3CRx+QSZ6DnFuYqf/W997vzjq7NglPXTAOxg/tis0P9adYQBqS/5GX77ZSRfXz3Y6nys+pLWAWgifh8juW85oztWhI+nK7lGfzTp9KLF8II/l1o3g0k7GKsH4MB+1p8tkylGYWVYqpoepUU6L7zTrOrW+HMMJfq52rfaMNdR6gLYJKlUUTToHHvqdGrVmtzmWANSG2zi+oclbLN4Y1A6m6jmzH0R/eFfaGPSSC2nL6tKQn5nmchurGiOWuJT9VEcgbKD6pFycd5ySYtWtyGeyNnIQkjenuPDud/IgUsGgEz/HkToVcKOVnNnF/Vicw12n3JZ3C1PwqVYTz7FjdijqlIwY/PNKUi05thT6JAtJ0uhnR1wzkhacICnOq/vDQslf3NAr/vCnuZ8RpbHeP8D2HS2m30QcSjbCwskm0j1mKf+jLEly+gfnc9+Bxn+e5R7prAwnlKgwgYev6gfvgGAii6brFEesQ42gnpv7UvFwbP9K0+gCLZ3ELOGYpzYByJZFxP6uk+XMN89qMvQSswq6o6nE9vrGNoAlfFamksr4DtrYwrN7PFycAm8F6vgTDQnpFpcSAB+0fAwH1uMWxcyXCC6ycx+2t11Qq160/W39CDvks+tme9g8K7prdtiELZRPnbqu15xS5owEn9yrrvPGsWUV9jS0ZdDJF
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YWc3TXNOL0UzL2IrVXVFNjRhUVpxakp2TlNraXZLZkxkeTRBZ1l3blNsSFov?=
 =?utf-8?B?MlpyMmptSk1XdDI3ZjdTV3R3akg1dHlJdmVjTHBxVDRsNUExNGw0TnlNY0Nj?=
 =?utf-8?B?KzNKSDFJNkpIWXhxVkh0K2UvTVRyRzhVVGhRc09hNEtxUXZaUTd4SlJlWTBW?=
 =?utf-8?B?V01jdkxTRWpQeWNDM0VUeFdFcmZJTEgvcWJVL2ZMc29GMkJwOHBhalhnTWFG?=
 =?utf-8?B?UW5uQkVoNE8zS0M2dHErWDVzV2hJeU1CTVlDVCtmSVZVZUhkcTJoYWhISkl0?=
 =?utf-8?B?bk5ZQXViVGk0TjBDRzNvUmVCSFFIeHJUSXhIdGVJNVZRZnRXOHk5ZHVnWXdu?=
 =?utf-8?B?MkpScVU4OEwwVzl5KzJCNXVlZWdPb1hDL014d2Z5UDRkNDNQVTZpYncxRVdP?=
 =?utf-8?B?TS8yZC92QzRtdjMwMmQ1R09xWTVQcXJNc0dIV0JHTXRGdG83TldhYWlqcDFR?=
 =?utf-8?B?a0w1emE2QWJzSUZyY1pKa25qdnByT2RkdHJLVnlRcG85OFUxZlZ2VFJQcURu?=
 =?utf-8?B?cTBtcWQvWWRzbXpsd2JITnFmeENZSDNTa2NaNVo2UG9HME1mY0FMVTBUN1M1?=
 =?utf-8?B?alovYUFPMVdrVXZXZ2p1dTEwWmFNY2x5c21ST3ZUVFJmc1pac0Jxa0xZTkdM?=
 =?utf-8?B?UENlMXkxS2dTY3N2dzdaTjZmdUpMNEhIRWZjRzNXQWNIMjhvdkl2bmNSOHNO?=
 =?utf-8?B?aG9jYUlvWDJEbkVOb0dhc0xFQmwzbUVYbjJJYWwwczgyN085SWhQQlp5WFZR?=
 =?utf-8?B?R0tTQWt1WnhaUXZkdFllODMrdVFUNE41NzNXVnAvc1ZubjVXTDZKd1F2V29M?=
 =?utf-8?B?Y1VrQ05yYTFxSmFrbSszWEFrR3BYempvUXVuemUrOWkrclpPNjh1UTRDUnRi?=
 =?utf-8?B?RkVSMEwwT2xLKzZpaXZ0VmtUY2lIbXY1bGZaZ1hxd0pPMzN4VFlYekhmVFJz?=
 =?utf-8?B?cloyNkJsQTlSREJraldvVjh1UGZKdXREV3dBRjQ4WFBUQ1Z4eUlUbjlmQWRB?=
 =?utf-8?B?TTB6anozUDA0UVZWZWo0WTFFOVVYblJrMTVWNlBQZUFuMmt1cHVnT3ZrbFNL?=
 =?utf-8?B?bGNVejNmTnNwVEJRTndCVHJjbnFmQ29sT09NREQ4RXZ0blF4UmRRWisybUFO?=
 =?utf-8?B?QmF5REVKZkcwRHpHL1FDVUZPZ0JiVS9PV2x5UW5RcnFoa3dBMkZHeVpPMVl2?=
 =?utf-8?B?WkJtbG9ObHFYam9keHlETjEwYnl2MWxIM1lMTi8rL24zbGtwdXZQRzlDano2?=
 =?utf-8?B?REVuWklONTdZdnllUkVZSkFHOW5XTTJvYVphcll5WHpUUVd1ZVZyeVpWeUJI?=
 =?utf-8?B?aUpXYTVhZWpqOUFGb0pKUnlKd0Z3Q09mR2FVZWNscUV1Qld4QTdnaTRkTHNa?=
 =?utf-8?B?VDRUL1VCNVVjZWFrL3VrTmV6Sm5CYlJQUHBPcGhzczZ1TmpoRTFwR3MxNzdO?=
 =?utf-8?B?N1dDZjJIaUdNS2pTZ0IwVW11YUVTcVJFYmFnTUZFb1cwUi80YzZzcm82WVV1?=
 =?utf-8?B?UXJGOExwWHFtanhrYXVjSVZmcitrSGVMZ3pETysrUU93YTZ5MmRXUnBHbm13?=
 =?utf-8?B?OHZLd1dNN1BUazNzL3BDSHBHd0svNFhiS3J2UlhlRnNybXZJR3JOU2cySHRh?=
 =?utf-8?B?RFBnOGcwUW12VklZU0RwOCt6WGIrSVBqem41elVEZWVmRHA1Ums4WStRbk1h?=
 =?utf-8?B?emdNQ2E0Z3pqZ0JLa0JiS0Jzc0UzbHF6M1ZQM1ViRUkreWFoQ3QrT2Myb3VQ?=
 =?utf-8?B?dkZaNy9JZm91WGtPTjYycm1sL3hROVJMUVFyQlAwV3lnSU5BMFVxVk5TdTY5?=
 =?utf-8?B?bUlhdzRzbDk5eDZwNk5WZnFDVjdMM3dSYXVjVUdoWXpoMXk1RDUzMlIxVVZY?=
 =?utf-8?B?d0hnQmwyWVFOTW5La3h4ekhDZmdoTG5wQ0lMcjI0aUtKeE56TThUN3F1WGQr?=
 =?utf-8?B?UGNKc3ZNYVhhR2JVNDJROWliWWFTSnVCb2txZXJrVHc5bDE3ZzNzamI3Wkx5?=
 =?utf-8?B?WGNoMlhoYUdLazgrVmpLazFXK3R0b0ZuQjNKVldJVTU5Uy9TcTVxMk42aDln?=
 =?utf-8?B?QWFEakloZ250NFVHeG0rMmhuNng3NlFnRXNXQ0RtOXFkUm1ieXdzUFUzZitq?=
 =?utf-8?B?NUI4ZTNhaFR2UHhiZ2Ura004Q1lEdjJSTGJROE13VHpWZWZBTTEvYVZGKzQv?=
 =?utf-8?B?YUF6K2phMEJ2dVYweHAwek1BNjFsSmhyTTdJWDkraWtscTZUbTY1alg4aFMz?=
 =?utf-8?B?ZXdsOSt0UGJJL2NrbGpLM1J4cmxwNzk3aUF2dHByOXNjU1Y0YmV4WEh0NExv?=
 =?utf-8?B?Yi9RNm1GdjFrR1UxM1dkdVVLQkEvdkd1OE1KWXVJazI1NGIrM1d5UT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 074f56bb-7caa-4333-be78-08de76189569
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 15:55:09.4014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: at6sJNgV9ECjTBUwq+PYkFX56AzK/pBTBWRn3JQLLsR5pmNFLXHnSEN4ci+Ftx2wXdcLPRnNsAyx25ZqowniLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8318
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[siemens.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[siemens.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-9033-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,siemens.com,gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jan.kiszka@siemens.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[siemens.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[siemens.com:mid,siemens.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 37F5F1BA8DB
X-Rspamd-Action: no action

On 24.02.26 17:47, Martin K. Petersen wrote:
> On Thu, 29 Jan 2026 15:30:39 +0100, Jan Kiszka wrote:
> 
>> This resolves the follow splat and lock-up when running with PREEMPT_RT
>> enabled on Hyper-V:
>>
>> [  415.140818] BUG: scheduling while atomic: stress-ng-iomix/1048/0x00000002
>> [  415.140822] INFO: lockdep is turned off.
>> [  415.140823] Modules linked in: intel_rapl_msr intel_rapl_common intel_uncore_frequency_common intel_pmc_core pmt_telemetry pmt_discovery pmt_class intel_pmc_ssram_telemetry intel_vsec ghash_clmulni_intel aesni_intel rapl binfmt_misc nls_ascii nls_cp437 vfat fat snd_pcm hyperv_drm snd_timer drm_client_lib drm_shmem_helper snd sg soundcore drm_kms_helper pcspkr hv_balloon hv_utils evdev joydev drm configfs efi_pstore nfnetlink vsock_loopback vmw_vsock_virtio_transport_common hv_sock vmw_vsock_vmci_transport vsock vmw_vmci efivarfs autofs4 ext4 crc16 mbcache jbd2 sr_mod sd_mod cdrom hv_storvsc serio_raw hid_generic scsi_transport_fc hid_hyperv scsi_mod hid hv_netvsc hyperv_keyboard scsi_common
>> [  415.140846] Preemption disabled at:
>> [  415.140847] [<ffffffffc0656171>] storvsc_queuecommand+0x2e1/0xbe0 [hv_storvsc]
>> [  415.140854] CPU: 8 UID: 0 PID: 1048 Comm: stress-ng-iomix Not tainted 6.19.0-rc7 #30 PREEMPT_{RT,(full)}
>> [  415.140856] Hardware name: Microsoft Corporation Virtual Machine/Virtual Machine, BIOS Hyper-V UEFI Release v4.1 09/04/2024
>> [  415.140857] Call Trace:
>> [  415.140861]  <TASK>
>> [  415.140861]  ? storvsc_queuecommand+0x2e1/0xbe0 [hv_storvsc]
>> [  415.140863]  dump_stack_lvl+0x91/0xb0
>> [  415.140870]  __schedule_bug+0x9c/0xc0
>> [  415.140875]  __schedule+0xdf6/0x1300
>> [  415.140877]  ? rtlock_slowlock_locked+0x56c/0x1980
>> [  415.140879]  ? rcu_is_watching+0x12/0x60
>> [  415.140883]  schedule_rtlock+0x21/0x40
>> [  415.140885]  rtlock_slowlock_locked+0x502/0x1980
>> [  415.140891]  rt_spin_lock+0x89/0x1e0
>> [  415.140893]  hv_ringbuffer_write+0x87/0x2a0
>> [  415.140899]  vmbus_sendpacket_mpb_desc+0xb6/0xe0
>> [  415.140900]  ? rcu_is_watching+0x12/0x60
>> [  415.140902]  storvsc_queuecommand+0x669/0xbe0 [hv_storvsc]
>> [  415.140904]  ? HARDIRQ_verbose+0x10/0x10
>> [  415.140908]  ? __rq_qos_issue+0x28/0x40
>> [  415.140911]  scsi_queue_rq+0x760/0xd80 [scsi_mod]
>> [  415.140926]  __blk_mq_issue_directly+0x4a/0xc0
>> [  415.140928]  blk_mq_issue_direct+0x87/0x2b0
>> [  415.140931]  blk_mq_dispatch_queue_requests+0x120/0x440
>> [  415.140933]  blk_mq_flush_plug_list+0x7a/0x1a0
>> [  415.140935]  __blk_flush_plug+0xf4/0x150
>> [  415.140940]  __submit_bio+0x2b2/0x5c0
>> [  415.140944]  ? submit_bio_noacct_nocheck+0x272/0x360
>> [  415.140946]  submit_bio_noacct_nocheck+0x272/0x360
>> [  415.140951]  ext4_read_bh_lock+0x3e/0x60 [ext4]
>> [  415.140995]  ext4_block_write_begin+0x396/0x650 [ext4]
>> [  415.141018]  ? __pfx_ext4_da_get_block_prep+0x10/0x10 [ext4]
>> [  415.141038]  ext4_da_write_begin+0x1c4/0x350 [ext4]
>> [  415.141060]  generic_perform_write+0x14e/0x2c0
>> [  415.141065]  ext4_buffered_write_iter+0x6b/0x120 [ext4]
>> [  415.141083]  vfs_write+0x2ca/0x570
>> [  415.141087]  ksys_write+0x76/0xf0
>> [  415.141089]  do_syscall_64+0x99/0x1490
>> [  415.141093]  ? rcu_is_watching+0x12/0x60
>> [  415.141095]  ? finish_task_switch.isra.0+0xdf/0x3d0
>> [  415.141097]  ? rcu_is_watching+0x12/0x60
>> [  415.141098]  ? lock_release+0x1f0/0x2a0
>> [  415.141100]  ? rcu_is_watching+0x12/0x60
>> [  415.141101]  ? finish_task_switch.isra.0+0xe4/0x3d0
>> [  415.141103]  ? rcu_is_watching+0x12/0x60
>> [  415.141104]  ? __schedule+0xb34/0x1300
>> [  415.141106]  ? hrtimer_try_to_cancel+0x1d/0x170
>> [  415.141109]  ? do_nanosleep+0x8b/0x160
>> [  415.141111]  ? hrtimer_nanosleep+0x89/0x100
>> [  415.141114]  ? __pfx_hrtimer_wakeup+0x10/0x10
>> [  415.141116]  ? xfd_validate_state+0x26/0x90
>> [  415.141118]  ? rcu_is_watching+0x12/0x60
>> [  415.141120]  ? do_syscall_64+0x1e0/0x1490
>> [  415.141121]  ? do_syscall_64+0x1e0/0x1490
>> [  415.141123]  ? rcu_is_watching+0x12/0x60
>> [  415.141124]  ? do_syscall_64+0x1e0/0x1490
>> [  415.141125]  ? do_syscall_64+0x1e0/0x1490
>> [  415.141127]  ? irqentry_exit+0x140/0x7e0
>> [  415.141129]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>
>> [...]
> 
> Applied to 7.0/scsi-fixes, thanks!
> 
> [1/1] scsi: storvsc: Fix scheduling while atomic on PREEMPT_RT
>       https://git.kernel.org/mkp/scsi/c/57297736c082
> 

Should it be here then already?

https://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git/log/?h=7.0/scsi-fixes

Sorry, just trying to understand the process.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

