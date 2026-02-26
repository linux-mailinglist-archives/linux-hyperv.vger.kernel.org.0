Return-Path: <linux-hyperv+bounces-9008-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qDhQGnBKoGkuhwQAu9opvQ
	(envelope-from <linux-hyperv+bounces-9008-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Feb 2026 14:28:16 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F271A68F2
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Feb 2026 14:28:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3C103301A7B8
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Feb 2026 13:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB86F327C0F;
	Thu, 26 Feb 2026 13:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="yg6m+0Lw"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012058.outbound.protection.outlook.com [52.101.48.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66361324B17;
	Thu, 26 Feb 2026 13:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772112296; cv=fail; b=NR0m7fYeyQbJHyMA58AzvV6rFm4s8cOIwfqq217SWFXqc8nahETG7vwDnN7BYcYshh/AF+lNPt2OPBCOh/1hRXJf+9kjihlVCoiyXl3huUb0wH6U9e+OCcEeDLzrVpkGhIyu5tt07y7L4ucnvjKeh+kFkdeSgBZsUoZOTWMRfeU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772112296; c=relaxed/simple;
	bh=FfQSL4SlVlrkbUI+j5xNfI1snVraRqbVzN616yGJ71s=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=poA1UwCLYqyOh0RMu+bEnnWxUtJ6E4xpqFFTynSq4/uSSkNdlhWZvFYSvjPpXqki3fpeNvl35KbT9uqWUx+fDGxNILtxP6JboA8M1RFIlayMN7elE0wW8f91FmhaU2gIr82OoVwB/BT6yNzTy2Nw231Kf7CO/BAr1Wyw3ulK++s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=citrix.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=yg6m+0Lw; arc=fail smtp.client-ip=52.101.48.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=citrix.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qcTFIuh9PMAMOLfL1ueFW2yJfRPo+RV4KEQKe0Xk7J94Xi0pagQO1kQD1pobCKjzEVg4fMWHFRjm2kovlqAHegmBk8O+fsjErkfn+JUy4CRVksEcrTPGIoatwvE8tL89oXodZWORPMJrJJdir3CcQWxE9lWDdnlHorE1c0url9FTTWnVm+214yYKg7wRHH1fPJ21nRcMYFItEnxtbQ/TUlFevsq4VR3C60jAcXfBI8VhhKKWUwL04XivtY6dtGaUuPuGeKJSiSx8gqmQJAjdP1UjZlfGpZBCYPZzBrYXHxEh1ohrCuQOpO7bmHvb9eDyWcTP/gzF9n1pFSsUB8h/jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+eFQ9Tjs6dylB8gm6EURKuhtRScQvKXIBxmGJxKwgy8=;
 b=dJJVI7bp6HWHekDDFlqtZ3Yylwhi7Klt82ykOvPYVGEWlkfXHfgiyNQAmn9t+hbgBUHihK+tl7YNSsof/huQ+ymn7UGSUEoZyuZcmXDDi4kas5uqrH5hFhgDuhzdJv1fSEDPTKo5BLEynVvLqINkbmuYywFx58CYmNscO8MssoEARnJ1uxpXxDw0WbBWHhz1fbw5HP3NgxO7rADdYAEBaABaN+/pum/gF+cvOkyPxuvdXsA8P5SMDxdiKyroUqI6jyCiFwDYSm9EnROuErmYpNAqvRAjV0u1Xzk3b0IsTjFKAEyQJz/El1Daf0PRt+tNyCB1hBpIB7+76AuX9yTLQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=citrix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+eFQ9Tjs6dylB8gm6EURKuhtRScQvKXIBxmGJxKwgy8=;
 b=yg6m+0LwJdwQZSkV539hagwI5SgNWfSSOu4wMcy382b2LiXTYw0t+XAkUkvEsB9N394eP/V/QfK7gK2glUEtSJ/mzcU1nSLbWiOGRGW9qxojrUHqi22weSVQsQjSm1GZZEuFw0UVD0YTd0/Lm5yCP9k7kfK77UBDT9rqvT8Z6js=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from CH8PR03MB8275.namprd03.prod.outlook.com (2603:10b6:610:2b9::7)
 by DS2PR03MB8134.namprd03.prod.outlook.com (2603:10b6:8:27d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Thu, 26 Feb
 2026 13:24:52 +0000
Received: from CH8PR03MB8275.namprd03.prod.outlook.com
 ([fe80::a70d:dc32:bba8:ce37]) by CH8PR03MB8275.namprd03.prod.outlook.com
 ([fe80::a70d:dc32:bba8:ce37%6]) with mapi id 15.20.9632.017; Thu, 26 Feb 2026
 13:24:51 +0000
Message-ID: <ccc4f915-3623-406e-8df6-f468427264f4@citrix.com>
Date: Thu, 26 Feb 2026 13:24:47 +0000
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
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
In-Reply-To: <a7e1b5c1-f933-44e5-99ec-a83b27fcf81e@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0514.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:272::21) To CH8PR03MB8275.namprd03.prod.outlook.com
 (2603:10b6:610:2b9::7)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR03MB8275:EE_|DS2PR03MB8134:EE_
X-MS-Office365-Filtering-Correlation-Id: 474f467d-6e2a-4950-01ea-08de753a6bde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	NOEw58vkIamqsmf+NnwqgSPGt/wL43bvX+XL84QT4W+ts3bgSOjGpSCl7Dg9mLUb77IAu5RkpYZrGC0t6qDaZkwcSKfBVmBL9t3WQQeBWcxip70QL+N5RJwo+g2pBDQcoKARx6Wy+K6eoCTip1rl3m7xYO4yopSxtgYC2cuNm9vRiHHR68blroXBa8HiMCFHI6Z+Ww47dei3CNdDkiAcJkg9JLOyz1X/6eVBcvB0CnbJED/NfD0eaadsJA+v2OAKbZCMWTfq8MITYIvG2mI1D+tyyWyxu+pXTjdhlcleyN1xAa+6gVWbMB6uwA2/FhZouHnvPZevuXaDLU+8iX+EcGTkLUQ+qdjHH+MBThxdOaRyCYyRzO798o9WyuD3UUGspBFE5+GtwKlMXNrq3AACvc2wOE5rPegn4RskFlHnusr7vgffPywLDkKFXhXWJFLRTy0jzluEtJJknbsh08ueOuM9n3iyDuUJfqOIT1a4z1cWWUBs8fyrK12rZBzdNXGSFL3i1Ks6DzsBOHA2KleeG4M6sZKpGPMH648zUttU91CEg9ja9tqkXgx2hxSLevFDNDj2De9bVFtMIMx+82qldcoNDFje2y0hY7oQ55ZpGnvdcRikff4OoDUnXCRjnsGiwVtEJgqXRwepuRWtTfijqIVMNyIRSiJ98Kq2Gmlm9yqcMK2tV5pNbmgWo7rNJPqY2LnMmMw29YElDQeqq5qt1pXpYDjxcI/cto3eADLarM4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR03MB8275.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MnZKT0d6ZDEydGtRWThGYTcxL0tTU3RpZUM3OGF4cG10ZFowa1VCdTJEb0JC?=
 =?utf-8?B?K3hlYkJmcDEza280bjhEU0lYOGNFc00vZXpiQkJrTkd3N0RnWTFnS2RWbXZm?=
 =?utf-8?B?bTIxa1ZwQ2g5Q1ZpTU5yN2FJbndteFNmejFOeDQ5SUlKcDNsVU9uSDNuTVQ4?=
 =?utf-8?B?Zm1wdExDamVVem5sMnA1cUc5WW1kN3gxU2NWNUplTDdYSGx6Z3N4aDQzZm0v?=
 =?utf-8?B?SzdyeEZqTVNDOVRJNEJ3NHAyNDVQSlZ1TVhpRjVldHJLOThDR1QwM0J5M3lP?=
 =?utf-8?B?UDFqMGRTUEd0dyttTExZckpLb3hwdWhhQVhoSnp1ZGgxZGw0S05FL1ltdUNo?=
 =?utf-8?B?TWxneGlXR2cxMG9ZbHBLdU4rUmRaV2Y4QlBKZy9VNVlpSFVsNHc3TE1BMUl0?=
 =?utf-8?B?M3ZrQU00bWFaL1ZwMkwzVEtDSitGSFhTS3QxSlVvSVc1REQyN29LckhUdW43?=
 =?utf-8?B?UGQvTnJtTGZBWEVzMzRDbER0K21yL2JjZWJucTg0ckVudHpOWTd0bmdQR0tI?=
 =?utf-8?B?WFR2RlRRQWdkTzVmYy8wY1FldndCbnhqWFZaVEluNUpQci8rQ1JqMTVWY0hm?=
 =?utf-8?B?WTRpOGxOYWtUOTBQaFUyZWhwUStrRkdOeGVMZm80TEpKUFgxTzFOK24xQ0dI?=
 =?utf-8?B?eGkrL2VvQjFqL0lQYmVFTmMzWGxTNXdEanl3M2tZS090N3N5aFM1UVVScU9Z?=
 =?utf-8?B?S2hacUQ5MEpwa256U0ZkZGo4Tld4a01IM01DUFJkajdWYzFESlBHbWp6cW1G?=
 =?utf-8?B?UVFVMUN4V3dvUnFoOGhLNEM3OExjaU56MGYzTDBvYTZUbnNBaU5pQlFvZ2U3?=
 =?utf-8?B?cms0VzRiV3FEd3h2RE1DMEUxWVgvbFgrM1AvT3YrVFFrWFplTk5EQ0tEbGJK?=
 =?utf-8?B?d254VVV5ZW9xRkIzSzd4ZHRlOWFDQTBnZitlSE5nRzZKMmdPY3JJa2ZZQkIx?=
 =?utf-8?B?UG1ENE5KOEhLK2V5VHR3TkdnWEdackVxVFVYOVJ6OUFTVnlXNWxDRlg2RTYv?=
 =?utf-8?B?QXRjc3YydjZ3OEJQSFRHN0R5alBqTlZPNHRwKzN5NlZEVTIvZVJWUWdyeU9W?=
 =?utf-8?B?TkxGajVrekFXK1p2M3B3d1dLZFNacVNLaEgyaFUxakpFclhWTm5lV3g0UUky?=
 =?utf-8?B?aWpOaVNQbDVNMGU3K2djcFZpcDVIZCsxbVFaaDZqZWZHTjZyM0RDZEFyUTlh?=
 =?utf-8?B?QTVPUlJaVTZXb0dFM0Y1Z2tXOWRTeTNOSUIrN2t1Syt4UXdOanhKdWIrN0VJ?=
 =?utf-8?B?WmdmVE52cGxCSW9DYmJBR1pWY2N0OVdFa05VdmEzYlpYMEplQVFjcUNwTDc3?=
 =?utf-8?B?cmhya25pakNJRWdSVEtnMlF2a2htVXFqSHJubllJaUQzVTNqY2FUR3JBN29p?=
 =?utf-8?B?Ukt1M2QwWjhnQlJiUlpmbWJCdkF0bDNKWHBiTmhTZUFtRlJLbzhCUXlQdWEr?=
 =?utf-8?B?eWpWeG5TYXVsbnc0RE52VC9oSHZUYnFzclZiTVJBZFU3aysrRkZ4Si9ma0wr?=
 =?utf-8?B?U2xaNnJ3WXdtK2J1NmlXeG1yMGpjRGRubEFWTEZjY2xsQWF6Q3MvN09BUEJJ?=
 =?utf-8?B?M0d1b20xVGU3VTRkcHpqck05L3pZVVpXNDgvblhZRlFrT25QZTgxSi9LZ0Jz?=
 =?utf-8?B?clFFdVBPYkRwbUorVDlsa0RTbUs0WW5NeVBuUWJUeFJ1a0JhT2pnY01SS0tM?=
 =?utf-8?B?K0xQcXRaMzBtT0tGaytSWEpkUExZZG9XdkJSVmNWSWgvMnJ6dHR2TGJQTTZX?=
 =?utf-8?B?aUQ2SVloQU1UTWZ4K2FvQmt3Z3AyQ2UvelN5N2RZeXQ0ZHpiYjZpY2pEY1Rl?=
 =?utf-8?B?NmdRUGMxcmhBaS9QS1RMWC9xK01JbmFNdGxTVGF4UnpMVnIxMEZPTTk4Q0ND?=
 =?utf-8?B?QmJtZ0ozaEdKMVAycG1hcCtEVFhyUnVvNG9rZzJ0L25lbEZjbVl2K2RSZk5M?=
 =?utf-8?B?SVA1WU9YZnd5ZndhM1p3UFhiemlQNTV1K2FiMXVXdUx3RUxQUURWelgzNmo2?=
 =?utf-8?B?MzFqQU5OWEo4WVc0U3FXeWRSeFlrU0grQ25KMnV4N1B0QXp1TWhrcmJNbVgv?=
 =?utf-8?B?UUtFTmRROWJCdENsMi9OcDhDMng1aVNyRE13UlcwZVdXdWQyR1orWnRRREha?=
 =?utf-8?B?Ykc1a2M5L1J5dzE5NFRlV2kwL1FFZDVXVWRidUJSWS8yYTFMR3p4U0p5RkpS?=
 =?utf-8?B?cEo3U0hFRm9OK3hjNGZ2dXNIUEhSUFhwc1J5QUtDTnA5by90bThTSEVwZ25x?=
 =?utf-8?B?OGZwYkVUU1FLSVF5ZG10OVllWWpnN0FUMmR0a3dnZ2RENytMbDJsR1JFaWhC?=
 =?utf-8?B?OHVYMVE3ck1WZmJvTnFKT1hpeGhLZWZpS1lleFFBVElGVWVmQ0J2QT09?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 474f467d-6e2a-4950-01ea-08de753a6bde
X-MS-Exchange-CrossTenant-AuthSource: CH8PR03MB8275.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 13:24:51.2222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hDIW13Qf26WaWbULrMIn/9TE867QQNJloj35Wi91FeSCym9qiWC51yo3st86iDVa1s+atsMoxq2Esbn9a+mo2jp7zGs/Baa6W4K21jZ8W2Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR03MB8134
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[citrix.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[citrix.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-9008-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[citrix.com,alien8.de,linux.intel.com,microsoft.com,zytor.com,vger.kernel.org,redhat.com,linux.microsoft.com,kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew.cooper3@citrix.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[citrix.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 08F271A68F2
X-Rspamd-Action: no action

On 26/02/2026 1:07 pm, Ard Biesheuvel wrote:
>
> On Thu, 26 Feb 2026, at 13:01, Andrew Cooper wrote:
>>> @@ -133,49 +150,36 @@ static noinline void hv_crash_clear_kernpt(void)   * available. We restore kernel GDT, and rest of the context, and continue
>>>   * to kexec.
>>>   */
>>> -static asmlinkage void __noreturn hv_crash_c_entry(void) +static void
>>> __naked hv_crash_c_entry(void)  {
>>> - struct hv_crash_ctxt *ctxt = &hv_crash_ctxt; -  	/* first thing, restore kernel gdt */
>>> - native_load_gdt(&ctxt->gdtr); + asm volatile("lgdt %0" : : "m"
>>> (hv_crash_ctxt.gdtr));  
>>> - asm volatile("movw %%ax, %%ss" : : "a"(ctxt->ss)); - asm
>>> volatile("movq %0, %%rsp" : : "m"(ctxt->rsp)); + asm volatile("movw
>>> %%ax, %%ss" : : "a"(hv_crash_ctxt.ss)); + asm volatile("movq %0,
>>> %%rsp" : : "m"(hv_crash_ctxt.rsp));
>> I know this is pre-existing, but the asm here is poor.
>>
>> All segment registers loads can have a memory operand, rather than
>> forcing through %eax, which in turn reduces the setup logic the compiler
>> needs to emit.
>>
>> Something like this:
>>
>>     "movl %0, %%ss" : : "m"(hv_crash_ctxt.ss)
>>
>> ought to do.
>>
> 'movw' seems to work, yes.

movw works, but is sub-optimal.

The segment register instructions are somewhat weird even by x86 standards.

They should always be written as 32-bit operations (movl, and %eax),
removing the operand size prefix which is not necessary for these
instructions to function correctly.

It's absolutely marginal, but it does always pain me to read asm like
this and see the myth of how to access segment selectors being repeated
time and time again.

~Andrew

