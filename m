Return-Path: <linux-hyperv+bounces-9006-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oOqbKdQ2oGkqgwQAu9opvQ
	(envelope-from <linux-hyperv+bounces-9006-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Feb 2026 13:04:36 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B8381A5893
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Feb 2026 13:04:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8C52A30F9C4D
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Feb 2026 12:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E198A3803D1;
	Thu, 26 Feb 2026 12:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="olHcI0Vo"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011024.outbound.protection.outlook.com [52.101.62.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B413803FA;
	Thu, 26 Feb 2026 12:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772107284; cv=fail; b=CJ4MMoO24ej810vxYHnpr3iBJrFpEmuzrD4lUtOjcX5t1822dKJA8SEfM3HCZmuvR0i/IWKpbdO6NydoLJFnjnLAUArjE/386eUN6IBdScvR4a4O7H6yzXNf/knmNkyIgYAXuArUEFWW72XuBlYDVyg4i05umlpnlORQatgCiAw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772107284; c=relaxed/simple;
	bh=uazgNpDz8newclhtY87ETX6vjDsLPO8v7LX3MWIM/mg=;
	h=Message-ID:Date:To:Cc:References:Subject:From:In-Reply-To:
	 Content-Type:MIME-Version; b=idW3kjw1T36b7SUbKUjIfDyB74l5mHXhOolDwAN7h1pkHtYmjpiTAHw3YqhU488qFgXDqPpOkKOPMVb0CZf6XHpuHHojb96/i39piVXUBht0cpCziiChX8owkA19op4+8MTLjP9LwJza3VCCta7GjkGtXXZ3UjLhVZQMN9JFIYs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=citrix.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=olHcI0Vo; arc=fail smtp.client-ip=52.101.62.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=citrix.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q5TUoHhzkbQEEs3CyzIyhpr+knlLlarNW9UYosOfVnjEe3nRDP20gOtmBC4mFXP2oZBuSnUzWDTZMCyEgLo3gl3As1zrU2lqm3OEjJ1xl7oOSySgc9snLsXl3u3At33HeP2TGMs1Mp60T3H7BaP7DDp3FQAdM9PGna//U/pic6WbCyI+1lWHdMaMb1CKUPtFgcK0VUWGcXOq+GKcP+FYZuDThVpjPojk2ih1mp78y5BBfiqyErvwvsNQIyaa1PGgtIzVGSDMt/bmUQZ5SkXQW3xUAs3Vb7Oy3DNAsHhpWcWiRpgeun7KWVc9b4awJaC7hkivkS4J2JJafqZjLEFNGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dVe6iG/NY/D2bYIdfzA5hWZitLTc6Sq6Qx3RLebn4dc=;
 b=i3i0OYGj8mkG4objvoH8B1sR44UuC/6ShNWtcilXtA1Hf4jVg7ZUIEH5Psq+sLfdyXRINk4Hkh0djJZZerORkdCEC3buNuDRR7PMeAJDf6O3209ZHSlNi7aUysQHRiqUFElQzuOnUHWAjDjF5mWgRsun2K/P7XwgFXnDGxDybF01O+VHtBX4OzugyRkTppu0CmhxmudkugzZxfARoHkSbOnnPx7FjASFADfGLwS15nEZsFwGZjJA+5mGPYWSpN6I4vD4+7OaFucCLHbHnY3z8KdebScRh/fBEzw4Qm7/CywIwyBh4lcHPGAIfGHxkBOzu0S8g8jZmYNISTjLETcQsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=citrix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dVe6iG/NY/D2bYIdfzA5hWZitLTc6Sq6Qx3RLebn4dc=;
 b=olHcI0VodLXva0LPmAwGITwthQ/48n9LmOyW/ZGMUAFdLGKStR4eNAQ6jjW40ZHsPz/KoUeu1vJji2WIfb2GQTASZmdstYXiaqBNWoOWAtplountjZjDi1X+AOeipVb+PF8lR0o9h9o5OTq3Wb24mIP+IVE49M6QWnWrMVAUay8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from CH8PR03MB8275.namprd03.prod.outlook.com (2603:10b6:610:2b9::7)
 by LV3PR03MB7359.namprd03.prod.outlook.com (2603:10b6:408:1a2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Thu, 26 Feb
 2026 12:01:20 +0000
Received: from CH8PR03MB8275.namprd03.prod.outlook.com
 ([fe80::a70d:dc32:bba8:ce37]) by CH8PR03MB8275.namprd03.prod.outlook.com
 ([fe80::a70d:dc32:bba8:ce37%6]) with mapi id 15.20.9632.017; Thu, 26 Feb 2026
 12:01:20 +0000
Message-ID: <5a2f3ffd-1692-4c32-b6f7-b94e5066dd95@citrix.com>
Date: Thu, 26 Feb 2026 12:01:16 +0000
User-Agent: Mozilla Thunderbird
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>, ardb@kernel.org, bp@alien8.de,
 dave.hansen@linux.intel.com, decui@microsoft.com, haiyangz@microsoft.com,
 hpa@zytor.com, kys@microsoft.com, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, longli@microsoft.com, mingo@redhat.com,
 mrathor@linux.microsoft.com, tglx@kernel.org, ubizjak@gmail.com,
 wei.liu@kernel.org
References: <20260226095056.46410-2-ardb+git@google.com>
Subject: Re: [RFT PATCH] x86/hyperv: Use __naked attribute to fix stackless C
 function
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
In-Reply-To: <20260226095056.46410-2-ardb+git@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0227.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:315::13) To CH8PR03MB8275.namprd03.prod.outlook.com
 (2603:10b6:610:2b9::7)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR03MB8275:EE_|LV3PR03MB7359:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d4e6ad2-7649-40e4-b3a5-08de752ec165
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	IOfxsxZR+en+U/CBXPsyssWHxzqEcMJXAc4Dw26ol5j1Zv7wulHcCy2ud9ByfXN2tF+k0mE9tTgCBsYF97gk+Y7KAMyVwQbg4aQSw3pl9/d/4kiWspRk3nKEXJ99DztRsCYxZneaVDaY7SuhPvF2qnUREDhWcyoE7W4Q3kiN+GC2zKob4h5K9GGV/Y+HViEtAquAksH44a4iHpjo4HPQTyHhvJWAN/TNA1TucgAQI+kACzm7wnDWVSDDP2cpn6t2G8JtN2gmsztazPfp69nYlUL7tXhIfDp0Z3sp2NcxNPPGgMBwGHr444dSqGZnNki28Hmi2TIRMHHBtQmI2V4+NgCTTvQRQP+XHdqIO+sY/Zqvl0sDA95zvzDzPf+6v6Atk6HHb8FDXWD9nb2cyI2MNyeP4ySCIADcDMr1nNy5bFt7+I6NjQ7S6hviJyi0yYkvI7nZslkJoNQcWurD5Nc7yLyHfFoCowfaz2/LQlWEahIzpxUh+BCSsp/XTJKsrA4KGSGv75VIMn8DYHWVqqof+9Fn03mRXiuZcBHxfhoVIXWnG5Jc7rqxTAy3V0E5EXcp3ltDNsX9hMFnmFrls94ILmc0JJTzWc5nrbgD8TkTocebzJm1+CNVmUGbWoRqEO73nSIJpP9mfbccLWQj0F9tCanbs4GoDCQMLUZ96ccBZ0v1ZidnC+V2ksrHVWbtVPI5P829C9yapl9V+faAR+7HMcl0U3dOLtJftPXnmDWX5XY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR03MB8275.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UGNWaGJnTENCOEcxS2N6TWFSNVUzY25tZ0FKZUthN01mMWRReTl2Z2VXeFVh?=
 =?utf-8?B?NjFvRnNPc3g3aUhBT1ZLMnhSalJhVjE4ejBwU1RwaGF6djVXUklSZEVkaE5C?=
 =?utf-8?B?cTlteFZMV1ppbzBRQStwM1B4dVBIaTM4VFJuNTZUZk1KcVd4bElTMHVKRnRU?=
 =?utf-8?B?VWk5eENDL1pwTU1vdHIzQm9KZnQ4VWFWa0FSMDhwS1M0cEVDbUw5T3llVzhp?=
 =?utf-8?B?ekVESVdIanFUMy9odVZ2ektsUjhIRU9DWjk3cy9xOWNwTXVhTTJGWEFER2Fk?=
 =?utf-8?B?dy9rQ3d2NGYvRktCSlYxdFVjTDFJS1JuQ1FJeFgwOHp5QllXR2Z3cStSK255?=
 =?utf-8?B?SDNvUlN3eE4rKzlucGRWdm9YRml4Q3NKODlTT3FUc29EenhPa1JWVFh3ZlNN?=
 =?utf-8?B?bC9xMzJKU2FLSUF2V3JUNm0zdk5ZMDFCaVdQV2UrZ25EcExjanljT3RVRmdH?=
 =?utf-8?B?aFpCdENDTmNuMUtJUHJUL3A4cFY4cDN5YmwvQzBTM2g1SE45STBEdVFrM1h2?=
 =?utf-8?B?UmdyRXgwQzRzMzFSQWU5dzBwUjZ6Q09DYjRMb1NUQWNHam85RHBFZkFHUWZN?=
 =?utf-8?B?OGZ1YmsvVXRXSkV0emV3OFF4Z1hOWEhjdU1DcnFKMVNMcThHMFhVUW50Wllk?=
 =?utf-8?B?UmVPdllEbWtDU1NMdmFjSzBEV2VxV0RwR1A3Ukk4a3MyTkdZZ1MxKzE4a1Zk?=
 =?utf-8?B?SzZqVE5ubHdqZGpKdmV4VVA3YlVnbXNBS2ZDMkZhWjVyWjl5N2hZNWdhRHBn?=
 =?utf-8?B?R0NkbnJQZjhjMUFPSld0UkpSbUxXTEJxNVJIQ3pNKytYbG9JYUZxYnZOQ056?=
 =?utf-8?B?Y1RPUXVGYTI3SElDdDlRWUZMSzYydGZzWmtkZ21hSUNTaEpVd0tWZXQyRWRM?=
 =?utf-8?B?bUxWZlAvaVU2OExKalJLKy9LTWJ3TkJlT05PSHU4VTZvVS9NRk9aY0E1b1JK?=
 =?utf-8?B?RTRsZmMzZ0ZNemZmR0Z3MHE1a09jem5iVVJZT3VRdFVZbGVBRHFBMjVtTkZy?=
 =?utf-8?B?MHRtb0xhbkdkVjVUQnFiZnVjMElkTGhEMWpiY1lwUUQwSmJuLzhiMlJWNW5v?=
 =?utf-8?B?QXlodk1ySkM4T0JLNGZ5V0VYYkdDU1BvRm1UWVJzUVQ2TkZDUnQ4dXY2TzBR?=
 =?utf-8?B?MDVRV2FEK1RuK2dmTFQ4d0NvQ2xoM3NoRUx2Qm5rT01YTFE0U0VTSnYxU0lN?=
 =?utf-8?B?b01MRmxTSm9SZ2FoSmt6L0pmeXNMOXZEUlpQdmZDYzYrQ1IwZVdZUk5qYjdD?=
 =?utf-8?B?cWZBQUdabVFKZloxc2NtTTl2U09QeWFZcmxHSkhrbHFTYTBqNlNxbnl6ZnYz?=
 =?utf-8?B?RmY4M0JOTytnNmRZcmlseCt3MkxvQVlmWk81ZU1Jb1oxQWRnZ1JRRy8vMHJ0?=
 =?utf-8?B?U0ZEM3BoanUxTzN3ZnE5dTVPSXU5UWFzeVhlQVJmZEJHb1AzMDI5Vzd2WTVI?=
 =?utf-8?B?U0dZM2o2dTFmYmtVRTJtTDlEbjg5Q1AvRCtleERERHR4d2d6UDc5T244RytL?=
 =?utf-8?B?bVNaNjBOYXM1cU1JNG5UU3U3N0JwZVc4VjJaTUdIY3ZVaWZHb3E1SHVpVEJ6?=
 =?utf-8?B?enFFQmJZWENxaWFNQTZNOTBLUEdaWE9VM3UwdDdoZGRCemJ2WUowYW15cDE2?=
 =?utf-8?B?NTBvLzUrT09wbmZESXVoblB4Y01TZkJTd3kvVzhTYzA5cTVZbGZTUkFzbG9B?=
 =?utf-8?B?YjRkU2RGdEdEZXhJWHdySGRNR1FmMTRHOXR4eFZEN1Zhd01hT0lML2haeVp3?=
 =?utf-8?B?NEpQdzd5UHhoSlQ1Z0Q5Z2t2MlpBMkxQeHBTdlZTbHZLUHV1NDVVZDFpOUZF?=
 =?utf-8?B?WHE0dmU3NnkwbzNEUVhCZFN2bjdRdmZwOS9vRFQ1dmhuZkdUTVZoeGk2VCtD?=
 =?utf-8?B?Y0xaQVNzMTZ0VlVURFpqSzA5YXQ3N1JXMy9sZkRDNVAxR0FjSlJ5dVRPajA0?=
 =?utf-8?B?bldyRUJBRzRyZHEydUM3WUEvVTRnR1BFbjc4ZXUzQ0xCQmxkeVJGbTk4anFX?=
 =?utf-8?B?M0o4UDhhZ21zVGRjQmZWamZyKzQ2dVZwbzlFRW1TZko5bTQ4YjNZdXBNSWZs?=
 =?utf-8?B?YURLNWJHNkdDc3l3Sy8zZUxORk56Q0phb1VUL29QYTc5bWtveWU3NnhUQ1NC?=
 =?utf-8?B?ZVhUNXF5ZlZIVlJ2UjdIU2hsZVlsZ2MrallJT1B6ZWZHbEhKZUsrbVEwMXcw?=
 =?utf-8?B?eEpNVlh1Ry9vZFQrUzQwZFNmTGlNWUpYRk5XQnFWN28rVDMrSWpraFNkNEli?=
 =?utf-8?B?d0JsWGIxSVJTWHVSSFAwQnNsNFhXNDY0UmxITUMyWHNEWFhETDZJM29zNjRE?=
 =?utf-8?B?dHZFTkZDMUJTSy85N2hoUDFZOEoxTHVwa3pzSTdKMU5IMFhJSjFjUT09?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d4e6ad2-7649-40e4-b3a5-08de752ec165
X-MS-Exchange-CrossTenant-AuthSource: CH8PR03MB8275.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 12:01:20.7484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lh42oiM9DegxF7BEiRJCBHZomzdnnHSRie5yaS+0jAAjAbszcODCuDZdHyXP9gXPLjyEHdBgTsyrdHj/zDtNPR9aVPPyZDDYiISWy46BbqQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR03MB7359
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[citrix.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[citrix.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9006-lists,linux-hyperv=lfdr.de];
	FREEMAIL_CC(0.00)[citrix.com,kernel.org,alien8.de,linux.intel.com,microsoft.com,zytor.com,vger.kernel.org,redhat.com,linux.microsoft.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew.cooper3@citrix.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[citrix.com:+];
	NEURAL_HAM(-0.00)[-0.983];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,hv_crash_ctxt.es:url,hv_crash_ctxt.gs:url]
X-Rspamd-Queue-Id: 1B8381A5893
X-Rspamd-Action: no action

> @@ -133,49 +150,36 @@ static noinline void hv_crash_clear_kernpt(void)   * available. We restore kernel GDT, and rest of the context, and continue
>   * to kexec.
>   */
> -static asmlinkage void __noreturn hv_crash_c_entry(void) +static void
> __naked hv_crash_c_entry(void)  {
> - struct hv_crash_ctxt *ctxt = &hv_crash_ctxt; -  	/* first thing, restore kernel gdt */
> - native_load_gdt(&ctxt->gdtr); + asm volatile("lgdt %0" : : "m"
> (hv_crash_ctxt.gdtr));  
> - asm volatile("movw %%ax, %%ss" : : "a"(ctxt->ss)); - asm
> volatile("movq %0, %%rsp" : : "m"(ctxt->rsp)); + asm volatile("movw
> %%ax, %%ss" : : "a"(hv_crash_ctxt.ss)); + asm volatile("movq %0,
> %%rsp" : : "m"(hv_crash_ctxt.rsp));

I know this is pre-existing, but the asm here is poor.

All segment registers loads can have a memory operand, rather than
forcing through %eax, which in turn reduces the setup logic the compiler
needs to emit.

Something like this:

    "movl %0, %%ss" : : "m"(hv_crash_ctxt.ss)

ought to do.

>  
> - asm volatile("movw %%ax, %%ds" : : "a"(ctxt->ds)); - asm
> volatile("movw %%ax, %%es" : : "a"(ctxt->es)); - asm volatile("movw
> %%ax, %%fs" : : "a"(ctxt->fs)); - asm volatile("movw %%ax, %%gs" : :
> "a"(ctxt->gs)); + asm volatile("movw %%ax, %%ds" : :
> "a"(hv_crash_ctxt.ds)); + asm volatile("movw %%ax, %%es" : :
> "a"(hv_crash_ctxt.es)); + asm volatile("movw %%ax, %%fs" : :
> "a"(hv_crash_ctxt.fs)); + asm volatile("movw %%ax, %%gs" : :
> "a"(hv_crash_ctxt.gs));  
> - native_wrmsrq(MSR_IA32_CR_PAT, ctxt->pat); - asm volatile("movq %0,
> %%cr0" : : "r"(ctxt->cr0)); + hv_wrmsr(MSR_IA32_CR_PAT,
> hv_crash_ctxt.pat); + asm volatile("movq %0, %%cr0" : :
> "r"(hv_crash_ctxt.cr0));  
> - asm volatile("movq %0, %%cr8" : : "r"(ctxt->cr8)); - asm
> volatile("movq %0, %%cr4" : : "r"(ctxt->cr4)); - asm volatile("movq
> %0, %%cr2" : : "r"(ctxt->cr4)); + asm volatile("movq %0, %%cr8" : :
> "r"(hv_crash_ctxt.cr8)); + asm volatile("movq %0, %%cr4" : :
> "r"(hv_crash_ctxt.cr4)); + asm volatile("movq %0, %%cr2" : :
> "r"(hv_crash_ctxt.cr4));  
> - native_load_idt(&ctxt->idtr); - native_wrmsrq(MSR_GS_BASE,
> ctxt->gsbase); - native_wrmsrq(MSR_EFER, ctxt->efer); + asm
> volatile("lidt %0" : : "m" (hv_crash_ctxt.idtr)); +
> hv_wrmsr(MSR_GS_BASE, hv_crash_ctxt.gsbase); + hv_wrmsr(MSR_EFER,
> hv_crash_ctxt.efer);  
>  	/* restore the original kernel CS now via far return */
> - asm volatile("movzwq %0, %%rax\n\t" - "pushq %%rax\n\t" - "pushq
> $1f\n\t" - "lretq\n\t" - "1:nop\n\t" : : "m"(ctxt->cs) : "rax"); - -
> /* We are in asmlinkage without stack frame, hence make C function - *
> calls which will buy stack frames. - */ - hv_crash_restore_tss(); -
> hv_crash_clear_kernpt(); - - /* we are now fully in devirtualized
> normal kernel mode */ - __crash_kexec(NULL); - -
> hv_panic_timeout_reboot(); + asm volatile("pushq %q0 \n\t" + "leaq
> %c1(%%rip), %q0 \n\t" + "pushq %q0 \n\t" + "lretq \n\t" + ::
> "a"(hv_crash_ctxt.cs), "i"(hv_crash_handle));

As Uros notes, "a" is clobbered here but the compiler is not informed. 
But, it's not necessary.

As a naked function you could even use 3x asm() statements, but you can
get the compiler to sort out the function reference automatically with:

    asm volatile ("push %q0\n\t"
                  "push %q1\n\t"
                  "lretq"
                  :: "r"(hv_crash_ctxt.cs), "r"(hv_crash_handle));


(Only tested in godbolt)

~Andrew

