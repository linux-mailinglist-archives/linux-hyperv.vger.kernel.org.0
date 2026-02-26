Return-Path: <linux-hyperv+bounces-9010-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MKPGODJUoGlLiQQAu9opvQ
	(envelope-from <linux-hyperv+bounces-9010-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Feb 2026 15:09:54 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8854C1A73E1
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Feb 2026 15:09:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 01E4430E5B92
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Feb 2026 13:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3C63B5306;
	Thu, 26 Feb 2026 13:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="JWWxyMnw"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011051.outbound.protection.outlook.com [40.93.194.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00F03B5303;
	Thu, 26 Feb 2026 13:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772113987; cv=fail; b=j8qHisbtQEMomm75yApEB2jktcB0hehJ4VNrecNHcqXdsPvQDDHSUVcPw2aTVSMHajaLpX/dytqFW1BOFA8uxZwmO6CHiiQjyhqO3FcbnfMLrpXRr0Px1VyTq2kmSeEGg1l+pfOp0hbbi4kRvjHP70+OZgt0OBZ4IkZpZcw0uSM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772113987; c=relaxed/simple;
	bh=oK3uwR/d/g0do9scFu60uNZvCVpTArfZcA6yvtYC4yE=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=URSiHgh4ditIu5f/xhaDEb32c9jZsJXvT2ab0y9/DYaJhM/Vvj2HTbdNRf8+SMzP3waKB54FFEWgUMB+wC9B5roJANWk4fNChrzAf+5tf4Bp9WWxeJwwB08UzJ74+axDe6BrpFBTijiztsLUiPCbfv2E2Ko4R/+CFGotA/KR2po=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=citrix.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=JWWxyMnw; arc=fail smtp.client-ip=40.93.194.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=citrix.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UsmvJd6PUqbwMzRjCuMh1PNY06Ckb056wb9sYuowjKJjysOeHTP6GvaRipKVTei5OJdqY+We77k/n97fWUbaG4oc4TksbzuJoX4OMFIwJCmpAwM4Ftu7QSXDHulILfCM74X5eA4OXwe9bss8+N9AEpX4GLDCuFHf3kwYGu9bBoIxoX9yEMCFDVWZ/EBKdAzwnTVZwwsDNuBeZQMWkcnlfQikBN2NPV/gorRr9jU5ud6d2MrLx8J7hM7/ggMyeUgeZEiMk2dUbee8cTyLb2Gv7LRS/IKzw0H8DKFzvhuBV7wx11kCfpbGgA/m/58qGEjaYxiLT8enObPvQy4PAJU2IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q0/C4XtYb4DK2X5zjAQlfqgyJMj7dmr/Y+cW7ZJwADI=;
 b=tRxfSRGaBCNwyT7imLhoBTcMTA69jNyREvedpmwtLtato8nvYELlDxw7Rh0DT9fQfObDdcjAb2Wgg+sFyySQSyn3Tv8qnHTOCaEh5/TwOLxLIMzVidab5XvyHh9U5wI6p6vR5OmWnYbVLrUIXrM7jB1hEPWNKBPvoln4yAWbucScav3F8bnf+N3baTR4CFil8aHrPd5Xl+83hWs6/0qSAGFubLJN2aNCt7+YaiDnEFJvRBfgVIFh5fJrqt3ymjr9GLid27I9vR0bFGDuS+GdH3KuparVHjbQx/do1nUsH8UIowc037KwHvl8R45fT2Z65OatoU58a5mWNLdqv6Bm4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=citrix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q0/C4XtYb4DK2X5zjAQlfqgyJMj7dmr/Y+cW7ZJwADI=;
 b=JWWxyMnwCZ4UOSvCQfAeTQpaS+nYTNdhBOTnEn6mqZutTxHe5NXO7S9AMMSN98EA3feDglCrsjQWfCTdVnjhekJBYuMJQK/jadoWN0hfahiz5n1piNBQYsZKLX3YmlAmBLnruG0wsbGz73HXNg3mC+ftP+SHdXHonThIzAEWMjA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from CH8PR03MB8275.namprd03.prod.outlook.com (2603:10b6:610:2b9::7)
 by CH2PR03MB8059.namprd03.prod.outlook.com (2603:10b6:610:27d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Thu, 26 Feb
 2026 13:53:03 +0000
Received: from CH8PR03MB8275.namprd03.prod.outlook.com
 ([fe80::a70d:dc32:bba8:ce37]) by CH8PR03MB8275.namprd03.prod.outlook.com
 ([fe80::a70d:dc32:bba8:ce37%6]) with mapi id 15.20.9632.017; Thu, 26 Feb 2026
 13:53:02 +0000
Message-ID: <aad6d8f5-67e7-4ced-b4b3-ecea24a44acb@citrix.com>
Date: Thu, 26 Feb 2026 13:52:58 +0000
User-Agent: Mozilla Thunderbird
Cc: Andrew Cooper <andrew.cooper3@citrix.com>, Borislav Petkov
 <bp@alien8.de>, dave.hansen@linux.intel.com, decui@microsoft.com,
 haiyangz@microsoft.com, "H . Peter Anvin" <hpa@zytor.com>,
 kys@microsoft.com, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, Long Li <longli@microsoft.com>,
 Ingo Molnar <mingo@redhat.com>, Mukesh Rathor <mrathor@linux.microsoft.com>,
 Thomas Gleixner <tglx@kernel.org>, Uros Bizjak <ubizjak@gmail.com>,
 wei.liu@kernel.org
Subject: Re: [RFT PATCH] x86/hyperv: Use __naked attribute to fix stackless C
 function
To: Ard Biesheuvel <ardb@kernel.org>
References: <20260226095056.46410-2-ardb+git@google.com>
 <5a2f3ffd-1692-4c32-b6f7-b94e5066dd95@citrix.com>
 <a7e1b5c1-f933-44e5-99ec-a83b27fcf81e@app.fastmail.com>
 <ccc4f915-3623-406e-8df6-f468427264f4@citrix.com>
 <2ee05c7f-60cb-445b-b761-562385c4e6ba@app.fastmail.com>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
In-Reply-To: <2ee05c7f-60cb-445b-b761-562385c4e6ba@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0318.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a4::18) To CH8PR03MB8275.namprd03.prod.outlook.com
 (2603:10b6:610:2b9::7)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR03MB8275:EE_|CH2PR03MB8059:EE_
X-MS-Office365-Filtering-Correlation-Id: 38493ecd-7302-4594-9c7d-08de753e5c23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	6btiD94EN9ILmCLHQraYbfOp2YwLps4cW2k3ARBgodNSr1GSBZ5Lq7x5INIx4l+Jutv0NdrLVgP3p6m2a4BoE1bvCJBodBR+0fOrW7WcNg7QRYSyyEUkBq4j7oT+fNV3vKUeHC1LQzMJVpGQWRgY0rdNufTjENk0Aw7B35Sn6ZVO1xubNm4bXSL2EPoQEqPaFpw20TRAPsrq8K7LLSGUbvh9DQG97D2fBDCH944iKjgfWFQLo8ijr0uHH0RjkAUH+qUnsIUdH5MfqzmipGnhWu3mnHiEuVh4+T4LnSisSzQiihKHMjbhBjL0qXWTER4X9nggaXOuSlhUZMHVf0CPS/Merwy8gJTFHCv7jSYKXXsgNxWkkSeoOCZTV3mBIrJ1RwKykPxXVfOuxBrJZx9n180i09Mz9oITSa1J5crQrVAdvnqxXNdHrUe/IgK3qosOH8vb7PFtD4A2KNEgohUyUwTq7Gfl7cZjlcEzCFEBm3QFRnCXS9JcrMy+28UhJ3GE08GV7JMoj6mIIIZg+20pxfI63h7apYKUFuBrfPeXzRdlQH3zYpeDU+BkYLzsGUVN+pttXfra3cdLQtlJHd4BF3CAlU91yFSZlWkUTnKoE/hnhh0iET1BRMRJWCqr9XeRGzRsRCEIV5rq8tvgMky4+KVD/8QHSa5tB+vXp3qWXo3dDbfsNxZVynz0G0KROX5v6rM8ifRbET1NhRsSYUslYWrG857XevsIFFlUzGSt27w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR03MB8275.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dk5vRVZnVXk5dStxYitZY2R5Q1hYRDlpVEVyM0N3SHlsMGw2TWduaFVUTTFO?=
 =?utf-8?B?dFQ4N0s1Vm5sUms1WEVMTkR1L3d0cHZFZURhQkpVL3lPRlZFRzhPWkZiOUhU?=
 =?utf-8?B?eks1TmZDQ0VPeG1CQWlWNFVuS25WcjFQN0JIcGdaZFRDSHhubCtXSm41K2xm?=
 =?utf-8?B?dnI2VnpUazdRU1hzeDZhME1aYThQN1Q0SW5YOVI3K09taUlNWEdaRmUvR2Jo?=
 =?utf-8?B?Y0MyWTVlV28yMFo4MmhyRWMzSExoVmdQTW43SzBWc2hPS3hIZERWcWh0Riti?=
 =?utf-8?B?dVBCL2srUFZTWlBoT0czcUNyS3hhcDUyZGJIYkRvS1F5UW5YQk9DNmhXUk9N?=
 =?utf-8?B?dnZZa0lsNTF0Mkw3RUt2NktJSjRpMENNclJPLzIwM0lOYUhNdlVrTEo3L0dP?=
 =?utf-8?B?ZlVMRmRpekd6aW5ldHFpa21wK2ZVU2VQMWllcThJZzhEMnZqSTVCYWlBdlBh?=
 =?utf-8?B?aEVvODh6amFabUE5RitNTzNuTFlnVXFLKzhycVkydWNuQlhEbXg0MHl5QStW?=
 =?utf-8?B?TUplN2FHNkZveWR2bnhmaTlpM001cExHVVI2bUdiMDVlOSt4S1ZKckNCcm1p?=
 =?utf-8?B?MFg1azBpM2d6R25abERvdFpMd2g3RENaTHlHajI5a1R2bUc5ZlJoMUVSd1Zi?=
 =?utf-8?B?U21ncUQrM0pJZXVEdUgwenRtN1VmS0tSTVdaejVPd0FvUzJhZ25RNFk0MXEv?=
 =?utf-8?B?L2hSQUpoc3Buc3poQ1p3MXcwajkrSjdKN2dSUjFnUEdXblRkMnJjc0xkVTNL?=
 =?utf-8?B?WFo0V1ppUnRmUXFSZndVRjBYcThDY2N0bGZ6bUJUcE05YlROc1JGRWdseW90?=
 =?utf-8?B?MmJvUk1jMWxPTER3R1dMUGxIVzdXdmg4QlR1SUhqQ2hmMFJXamRhM2lVSW9n?=
 =?utf-8?B?cU1vZnpKVGgrWUxmekxYYXY0SFRETWc1eTlyR0NiUmMvdTg1cXplZ0Q5K0lK?=
 =?utf-8?B?NHBtMUNnRGNNdDcwYU94RXBYa2JLbGlpNjZ5WGh4eFFaQmFsbXF3dkc4eUFj?=
 =?utf-8?B?aTRrbk8ybVZ2QjdNUm9vdjdIdWIrSVAzTVJzWWVJWmhkd3NwUGtnTTQwZ2p1?=
 =?utf-8?B?Q3lWTFFlTTAxOWNaeWhSd2ZyVW1PeUs2ZW5lNlVEWWdlV2MzRHZUZ2RSUHBM?=
 =?utf-8?B?MFZicUVJb3lHbFJjU2pyZUVDV0dZaXl1UFdkclF5U1U1cWcrQ0JycldCV2wz?=
 =?utf-8?B?U3R4ZlIxTStCNlRzN1E0TndibXZlRkdyODM4bEtTSHJFTE9wUWhsN1IyVmlO?=
 =?utf-8?B?RUp6N2ZiK3FjTjQ3OWxiYjdTcSt2R243Y2prcnZqekgzdGNtZ3FJaGljVWlI?=
 =?utf-8?B?dmR3cFVJNUtYMlNSaVpia1RnSnB3MHhHWmdwZERCMytDV0E5bFZ2dG9aVFBY?=
 =?utf-8?B?RUxxQjc2OVFtaFhoWWdSdnNzenh0ZDNYQU5QTThmaFFGZkF0a0t4ZHZGd2xj?=
 =?utf-8?B?ckM1ZVZGSlVoWUE2NzRDMlhEZU1ETXdGWFpucnB4MjFXRVg1SmQyWGpZZDMx?=
 =?utf-8?B?V3ZVejBpME5UdHpiR1pma0JuK1k1UktzMkIwNEhyaDc5TzczN0RzMmluZnRx?=
 =?utf-8?B?YnNYM09IMDUvMG8vekNIMmJaUTZIT1NKdGhHRFBUbmZJdGhreG9NMkNvQm5F?=
 =?utf-8?B?cDdJK2V5OFdUQ3VudHQxQ09kWlVCZ2NwMEZwOVM0SC9zTjJTckd5YXFxeWc1?=
 =?utf-8?B?cVVtOGVnQ3hZQTFaeGlRYW1uL3BPUlpUWnVpemhaWG5jNWVDeXd1eFVZZzZl?=
 =?utf-8?B?QVlvc3BCcUg2SWtKQ3VsMms2MWxXblo3ZUs1UTVUYlZ1d0pEWnNoaHZLVjlO?=
 =?utf-8?B?a29yS3BaQnQyNkNrcTJZV3lCT2s0SkwvRC9haEJVUVgrMnR6bHJzMVlJTlVZ?=
 =?utf-8?B?OGpBbXczYUdGemZBWC9SWWQ5VEdlaWRGWHlWc05abUd0Q2FQaGZpZ21ZbzZO?=
 =?utf-8?B?RlV6eE1kcnNNMC8vYkxzdWpKK1VBQkdiejlDaGY0aFVIRmIwdkVpTDVZU1Rs?=
 =?utf-8?B?Z0pHdXovMFMzK21XRVVGd1RxbmNxNXhJbzlQUVVJcjdHVFdvbmNUV2F1dU5p?=
 =?utf-8?B?cktnbzJyZjdSdVE1VnFjTkxSMHVXeEtCTncvRDU1eGRRK1I4cStZQ21kVWMy?=
 =?utf-8?B?b0RGeTdDcHR5Vm5LQjdlRTJmemE4amRqbHl3c2Vrd2FMbEdiakRrRHRkZFRU?=
 =?utf-8?B?TkFGU3VzcmFWWXBZUXp0dyszZ1FtRXlvb1BuQ2p5ZEh1WXUrTDV3MTdJVzVU?=
 =?utf-8?B?c3Y2czEzNGtnbWJKblpxYTE5ejAybktPTmVrRy9RRzhWUDFsWTJ6N2VSbU9B?=
 =?utf-8?B?RVVwTnFtZktBMTEydWNrdVk3VFlBNmhMRk4zcC9sd1MrUkswcUhVVkxwSEZP?=
 =?utf-8?Q?ujLFLh9oZ7AfQDfU=3D?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38493ecd-7302-4594-9c7d-08de753e5c23
X-MS-Exchange-CrossTenant-AuthSource: CH8PR03MB8275.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 13:53:02.9060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QoDndxlAJIc3r1TBRU3UL42NcY71v8iajE4G8Dfxao+mgX3MUEwAjZoMsCt2DlFnLRYTpRyNgy4x9sw9lMvDVud+YsUX8PDUTcxvawNeK1I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB8059
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[citrix.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[citrix.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-9010-lists,linux-hyperv=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	URIBL_MULTI_FAIL(0.00)[citrix.com:server fail,sto.lore.kernel.org:server fail,hv_crash_ctxt.ss:server fail,godbolt.org:server fail];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[citrix.com,alien8.de,linux.intel.com,microsoft.com,zytor.com,vger.kernel.org,redhat.com,linux.microsoft.com,kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew.cooper3@citrix.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[citrix.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,godbolt.org:url,hv_crash_ctxt.ss:url]
X-Rspamd-Queue-Id: 8854C1A73E1
X-Rspamd-Action: no action

On 26/02/2026 1:29 pm, Ard Biesheuvel wrote:
>
> On Thu, 26 Feb 2026, at 14:24, Andrew Cooper wrote:
>> On 26/02/2026 1:07 pm, Ard Biesheuvel wrote:
>>> On Thu, 26 Feb 2026, at 13:01, Andrew Cooper wrote:
>>>>> @@ -133,49 +150,36 @@ static noinline void hv_crash_clear_kernpt(void)   * available. We restore kernel GDT, and rest of the context, and continue
>>>>>   * to kexec.
>>>>>   */
>>>>> -static asmlinkage void __noreturn hv_crash_c_entry(void) +static void
>>>>> __naked hv_crash_c_entry(void)  {
>>>>> - struct hv_crash_ctxt *ctxt = &hv_crash_ctxt; -  	/* first thing, restore kernel gdt */
>>>>> - native_load_gdt(&ctxt->gdtr); + asm volatile("lgdt %0" : : "m"
>>>>> (hv_crash_ctxt.gdtr));  
>>>>> - asm volatile("movw %%ax, %%ss" : : "a"(ctxt->ss)); - asm
>>>>> volatile("movq %0, %%rsp" : : "m"(ctxt->rsp)); + asm volatile("movw
>>>>> %%ax, %%ss" : : "a"(hv_crash_ctxt.ss)); + asm volatile("movq %0,
>>>>> %%rsp" : : "m"(hv_crash_ctxt.rsp));
>>>> I know this is pre-existing, but the asm here is poor.
>>>>
>>>> All segment registers loads can have a memory operand, rather than
>>>> forcing through %eax, which in turn reduces the setup logic the compiler
>>>> needs to emit.
>>>>
>>>> Something like this:
>>>>
>>>>     "movl %0, %%ss" : : "m"(hv_crash_ctxt.ss)
>>>>
>>>> ought to do.
>>>>
>>> 'movw' seems to work, yes.
>> movw works, but is sub-optimal.
>>
> Can you give an asm example where movl with a segment register is accepted by the assembler? I only managed that with movw, hence my comment.

Oh lovely, that looks like a binutils bug, but I bet it comes from not
realising that `mov sreg` is different to the more general mov forms.

Using no suffix will emit the optimal instruction without a warning.

https://godbolt.org/z/GYKs31Gqn

~Andrew

