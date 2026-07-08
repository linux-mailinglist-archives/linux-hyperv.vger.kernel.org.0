Return-Path: <linux-hyperv+bounces-11860-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xJSNEbXXTWry+wEAu9opvQ
	(envelope-from <linux-hyperv+bounces-11860-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 08 Jul 2026 06:53:09 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E5A9721A49
	for <lists+linux-hyperv@lfdr.de>; Wed, 08 Jul 2026 06:53:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=f7tCGI8h;
	dmarc=pass (policy=quarantine) header.from=amd.com;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11860-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11860-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1F525301F5FF
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Jul 2026 04:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37330377558;
	Wed,  8 Jul 2026 04:52:44 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010016.outbound.protection.outlook.com [40.93.198.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779EA23BD06;
	Wed,  8 Jul 2026 04:52:42 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783486364; cv=fail; b=rY8ygrjCFjBB9bepU/xs6xU1jcliTcB6AkJw+ikzz2IC7xBCQL7JSBYddbWj8zyYFLcjQznPekha3e6g8atw533Yru6cAGOPTLRVE/MAekCFTRXzZz6SX+WtYatsVn6k+h+NeREIJBrjZx0DHywQ9fMaZ1kQ1hCxTzPmJuJAjOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783486364; c=relaxed/simple;
	bh=Kj8zK7dp27d1KKmXvWZuN2pzWYoXNW90QVOE00DK+3U=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FgsB4SAdoJwHOYQNU43a8FmrcRWcFLhqCJzl0znXEX+IMUUVJpM15XniWDLnnnDJIoDD+NA8qv6X/1bMHHkTrVgdRSqbBlboW6H4W/VN2yrqqwUNR9Q0XOW4uDNwbsgcXOmoevSw+QP2Q1/sjZ2bCoKfLXMg3xhWrTJ8Ei5ra9E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=f7tCGI8h; arc=fail smtp.client-ip=40.93.198.16
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iH11X8l0wQaiz4mtUMOCFsKSiDn3VTh+ubRI0d+Zk4N8o2JQjR+9+NeSR7rcBqInR7kNnjA53W/Oxd24A8cKY+r6ytS7JHmQSEpR4cZuAgNlQGEwU/bRBYrq3a8TnymMxZYz3s7kmYFenptmNsWirpFUlTmXOR4yZW0lDFWmcLiBfj+onD38KuMzVThCGhIR9kA5ySEJaUYqpyUgEp8SLF9Wz24GrvF5BB8mc+U3/VSuNl+jAkgx4P8o94i1XWIkzH/Z/SA+pv42nkRYpXKv9aGSKJr8r0YCbdPXZW1HeulRkS94vIJ3gAJZbdxxt3bSIIjdeCJ/xKTFox2fb4LqgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ei0d+QTfykHeiOAHu1tWpX6WZ1Hr1ps4k7WhbCYRX0E=;
 b=Zm9Lv/JOG8wS7G60L2wgnbsLzf2abbea0DvyhBbQHk8CN/ftX4BlKaqY15bZnAdCv/xa0SEe82dX2vQ05qDvprCw2Yffk1FXWW4Yw3FpR4PkSYZ6JTnuO/5fLpzkZ2qO+teVqJNodRq3einpfy0Cuzle/oqpvXrYIqkYwYVx2JlJsCBowvCH8whCGCjJgTpeAiMgzGN0sz6gezp1gJpBECCxv0moQv1Is54xBCwq0e0vAMIxEtWWviyyzPItpAFMDLbZ3IQx0hO0CDYP+fznkdUfnc9YGmXi51kqMpw/k9qcv3b55abwNdZloAvGKmc+2PoZdBJsMLtwNe+afMOjSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ei0d+QTfykHeiOAHu1tWpX6WZ1Hr1ps4k7WhbCYRX0E=;
 b=f7tCGI8ht0nTD1k6xFTevhEwNAU/gaASJuv6Wh17c5WZGimf9SKadjXju/StHRhF0zpiyczzRsHMUQRIr1f7rZKwKxEeKpqzfbUGHtslNs/B4VTC9WmMBNF1ORoGDC5u3nAZRYZsCLOSHvE21QTZfO3A6nFjsuLqBf4LM/IBCYw=
Received: from CH0PR04CA0071.namprd04.prod.outlook.com (2603:10b6:610:74::16)
 by DS0PR12MB8528.namprd12.prod.outlook.com (2603:10b6:8:160::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Wed, 8 Jul
 2026 04:52:36 +0000
Received: from CH2PEPF00000148.namprd02.prod.outlook.com
 (2603:10b6:610:74:cafe::94) by CH0PR04CA0071.outlook.office365.com
 (2603:10b6:610:74::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.9 via Frontend Transport; Wed, 8
 Jul 2026 04:52:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000148.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 8 Jul 2026 04:52:36 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 7 Jul
 2026 23:52:35 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 7 Jul
 2026 23:52:35 -0500
Received: from [10.252.210.85] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 7 Jul 2026 23:52:23 -0500
Message-ID: <40e20edb-48f4-4f50-b5e4-d6e771235b4a@amd.com>
Date: Wed, 8 Jul 2026 10:22:17 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/51] x86/sev: Shove SNP's secure/trusted TSC
 frequency directly into "calibration"
To: Sean Christopherson <seanjc@google.com>, Jonathan Corbet <corbet@lwn.net>,
	Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, "Ingo
 Molnar" <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, Kiryl Shutsemau
	<kas@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, "K. Y.
 Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, "Wei
 Liu" <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Long Li
	<longli@microsoft.com>, Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov
	<alexey.makhalov@broadcom.com>, Jan Kiszka <jan.kiszka@siemens.com>, "Andy
 Lutomirski" <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Juergen
 Gross <jgross@suse.com>, Daniel Lezcano <daniel.lezcano@kernel.org>, John
 Stultz <jstultz@google.com>
CC: Shuah Khan <skhan@linuxfoundation.org>, "H. Peter Anvin" <hpa@zytor.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>, Broadcom internal kernel review list
	<bcm-kernel-feedback-list@broadcom.com>, Boris Ostrovsky
	<boris.ostrovsky@oracle.com>, Stephen Boyd <sboyd@kernel.org>,
	<linux-doc@vger.kernel.org>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<linux-hyperv@vger.kernel.org>, <virtualization@lists.linux.dev>,
	<xen-devel@lists.xenproject.org>, Tom Lendacky <thomas.lendacky@amd.com>,
	David Woodhouse <dwmw@amazon.co.uk>, David Woodhouse <dwmw2@infradead.org>,
	Michael Kelley <mhklinux@outlook.com>, Thomas Gleixner <tglx@linutronix.de>
References: <20260701193212.749551-1-seanjc@google.com>
 <20260701193212.749551-9-seanjc@google.com>
Content-Language: en-US
From: "Nikunj A. Dadhania" <nikunj@amd.com>
In-Reply-To: <20260701193212.749551-9-seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000148:EE_|DS0PR12MB8528:EE_
X-MS-Office365-Filtering-Correlation-Id: 354d1e25-cfa8-4149-4105-08dedcacbae7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|32650700020|23010399003|36860700016|921020|3023799007|18002099003|22082099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	zSazxnvGOuts/WNto6Qd6Wf4r/P9sqd09K5D2puyLqZ4pEyEZNoTRkTgLaZfL5QG8xxWcXJPW65egFexsW5+vb1r7g3lV6Wyv8vz2MQ++08z4dKKdErOg5fJc792NWTB8Gm5TLC0odjoP1+/rsi0+9hdAieR+SIToCobAtypB06p5oHfqwiHsNrBU1z6NyhdN7rbjtxikwsEKN4vHTEgHBkQufXwiSXxO7cWDC3UZWnv6aMc6yD7O/5MauoBpufAb9g/JxMF1tyzlqKOPQYUYxK+AZCLc8LGlL5z+ELrAqjghaBZ3xc9ldhtAMDqfgAKJIRJ6XrrZwaoXlAfeuCP6CEYmZi9KlDGk9bSa7x7shLawjE4XDmfYnYxIFlObPc+44bMEcrKDqy7GxBsrsP6xnr3P5tMGXBFkEMtfjaYDCQFAlhjE4OlD4b1yQZdQapDAwuyBCYsUs5L/2wwFb46BxF+CDXJHHeaiBtx38MOkZfdlMn96JPuZ424S4bQSgs415oDq/ou0hbKw13UlcSfLngNDcK3kzTNkHwvqLu2UkxggeC4wLf5mllYfRT/Anoh9uBiB6CDCZt+M07Be3OYJRQ9/Yxqk+66zXRQusfIwnWn5Xnu/qZIPtIVgbNxMephxjGZIzzwKBVSy0i5l7n4QsD1SQKLChEVEybcevrsUpmluDPP+p6WCoKcxpkTlAh0RZE4+DwJ71qFRopJm+HeGqsE4QxQAVkhjymn8NcxUR+/pAdFqixwvUvQDe6VYoFB
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(32650700020)(23010399003)(36860700016)(921020)(3023799007)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	8oZhG7HxMEJzegkI9/kQ+k3b+X5K44QoYv3u7161yaJazWoV9bLbwBPcUf33s6heL5gj37WDbRSZJDwc9zw/9agj5/ie69Gkg5eQc6uBV0Xosa1NryXlFnVHJON/PQ6kBZHHpepHs6Vv46bv5hJBO3xWU4ppj/qClvOiVLmc8itTDbhb1ujyZns29ZEVhtpf7u7X8bZam20vVHfj60JHWMY3IJ/KVFbe7spun+F15KtluVfP6cr2R8RbkpXkMnnzI8EFgXokkEiXWsPqGLkxYIwJUIt0mZor/5KCB8EkbOCo7mpG95HYgDereND0gk3H0F2oAL5jcZk7zEXjGYYCIrwkKM2Od1klQSWsj/4WIWfG1j+JznHwpcWApnQHNWuj24F9+sS6dIvdpz/htCndsEQgUei0zdfR6W0oUM76RhgwKbyPjVCIIU4tNd8qjPQl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 04:52:36.0842
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 354d1e25-cfa8-4149-4105-08dedcacbae7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000148.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8528
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11860-lists,linux-hyperv=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[41];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:seanjc@google.com,m:corbet@lwn.net,m:pbonzini@redhat.com,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:x86@kernel.org,m:kas@kernel.org,m:rick.p.edgecombe@intel.com,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:longli@microsoft.com,m:ajay.kaher@broadcom.com,m:alexey.makhalov@broadcom.com,m:jan.kiszka@siemens.com,m:luto@kernel.org,m:peterz@infradead.org,m:jgross@suse.com,m:daniel.lezcano@kernel.org,m:jstultz@google.com,m:skhan@linuxfoundation.org,m:hpa@zytor.com,m:vkuznets@redhat.com,m:bcm-kernel-feedback-list@broadcom.com,m:boris.ostrovsky@oracle.com,m:sboyd@kernel.org,m:linux-doc@vger.kernel.org,m:kvm@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-coco@lists.linux.dev,m:linux-hyperv@vger.kernel.org,m:virtualization@lists.linux.dev,m:xen-devel@lists.xenproject.org,m:thomas.lendacky@amd.com,m:dwmw@amazon.co.uk,m:dwmw2@infradead.org,m:mhklinux@outlook.com,m:tglx@linutroni
 x.de,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[nikunj@amd.com,linux-hyperv@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,zytor.com,redhat.com,broadcom.com,oracle.com,kernel.org,vger.kernel.org,lists.linux.dev,lists.xenproject.org,amd.com,amazon.co.uk,infradead.org,outlook.com,linutronix.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:from_mime,amd.com:email,amd.com:mid,amd.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nikunj@amd.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8E5A9721A49



On 7/2/2026 1:01 AM, Sean Christopherson wrote:
> As a first step towards dropping .calibrate_{cpu,tsc}() and explicitly
> defining precedence/priority for "calibration" routines, pass the secure
> TSC frequency obtained from SNP firmware directly to
> determine_cpu_tsc_frequencies() instead of overriding the .calibrate_tsc()
> hook.
> 
> Unlike the native calibration routines, all of the paravirtual overrides,
> including SNP and TDX, are constant in the sense that the frequency
> provided by the hypervisor or trusted firmware is fixed, known, and always
> available during early boot.  More importantly, for CoCo (SNP and TDX) VMs,
> it's imperative that the kernel uses the frequency provided by the trusted
> firmware, not by the untrusted hypervisor.  Enforcing the priority between
> sources by carefully ordering seemingly unrelated init calls, so that the
> trusted override "wins", is brittle and all but impossible to follow.
> 
> Explicitly ignore tsc_early_khz if the exact TSC frequency was obtained
> from trusted firmware, as per commit bd35c77e32e4 ("x86/tsc: Add
> tsc_early_khz command line parameter"), the goal of the param is to play
> nice with setups that provide partial frequency information in CPUID, i.e.
> is NOT intended to be a hard override.  Neither SNP's secure TSC nor TDX
> was supported when commit bd35c77e32e4 landed back in 2020, i.e. lack of
> consideration for the interaction was purely due to oversight when SNP and
> TDX support came along.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  .../admin-guide/kernel-parameters.txt         |  4 +++
>  arch/x86/coco/sev/core.c                      | 14 +++--------
>  arch/x86/include/asm/sev.h                    |  4 +--
>  arch/x86/kernel/tsc.c                         | 25 ++++++++++++++-----
>  4 files changed, 29 insertions(+), 18 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index b5493a7f8f22..181149f633c3 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -7946,6 +7946,10 @@ Kernel parameters
>  			with CPUID.16h support and partial CPUID.15h support.
>  			Format: <unsigned int>
>  
> +			Note, tsc_early_khz is ignored if the TSC frequency is
> +			provided by trusted firmware when running as an SNP
> +			guest.
> +
>  	tsx=		[X86] Control Transactional Synchronization
>  			Extensions (TSX) feature in Intel processors that
>  			support TSX control.
> diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
> index 403dcea86452..bc5ae9ef74da 100644
> --- a/arch/x86/coco/sev/core.c
> +++ b/arch/x86/coco/sev/core.c
> @@ -99,7 +99,6 @@ static const char * const sev_status_feat_names[] = {
>   */
>  static u64 snp_tsc_scale __ro_after_init;
>  static u64 snp_tsc_offset __ro_after_init;
> -static unsigned long snp_tsc_freq_khz __ro_after_init;
>  
>  DEFINE_PER_CPU(struct sev_es_runtime_data*, runtime_data);
>  DEFINE_PER_CPU(struct sev_es_save_area *, sev_vmsa);
> @@ -2014,15 +2013,10 @@ void __init snp_secure_tsc_prepare(void)
>  	pr_debug("SecureTSC enabled");
>  }
>  
> -static unsigned long securetsc_get_tsc_khz(void)
> -{
> -	return snp_tsc_freq_khz;
> -}
> -
> -void __init snp_secure_tsc_init(void)
> +unsigned int __init snp_secure_tsc_init(void)
>  {
> +	unsigned long snp_tsc_freq_khz, tsc_freq_mhz;
>  	struct snp_secrets_page *secrets;
> -	unsigned long tsc_freq_mhz;
>  	void *mem;
>  
>  	mem = early_memremap_encrypted(sev_secrets_pa, PAGE_SIZE);
> @@ -2043,7 +2037,7 @@ void __init snp_secure_tsc_init(void)
>  
>  	snp_tsc_freq_khz = SNP_SCALE_TSC_FREQ(tsc_freq_mhz * 1000, secrets->tsc_factor);
>  
> -	x86_platform.calibrate_tsc = securetsc_get_tsc_khz;
> -
>  	early_memunmap(mem, PAGE_SIZE);
> +
> +	return snp_tsc_freq_khz;
>  }
> diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
> index 594cfa19cbd4..05ebf0b73ef4 100644
> --- a/arch/x86/include/asm/sev.h
> +++ b/arch/x86/include/asm/sev.h
> @@ -530,7 +530,7 @@ int snp_send_guest_request(struct snp_msg_desc *mdesc, struct snp_guest_req *req
>  int snp_svsm_vtpm_send_command(u8 *buffer);
>  
>  void __init snp_secure_tsc_prepare(void);
> -void __init snp_secure_tsc_init(void);
> +unsigned int snp_secure_tsc_init(void);

It seems __init got dropped here accidentally?

Apart from this:

Reviewed-by: Nikunj A Dadhania <nikunj@amd.com>
Tested-by: Nikunj A Dadhania <nikunj@amd.com>

>  enum es_result savic_register_gpa(u64 gpa);
>  enum es_result savic_unregister_gpa(u64 *gpa);
>  u64 savic_ghcb_msr_read(u32 reg);
> @@ -637,7 +637,7 @@ static inline int snp_send_guest_request(struct snp_msg_desc *mdesc,
>  					 struct snp_guest_req *req) { return -ENODEV; }
>  static inline int snp_svsm_vtpm_send_command(u8 *buffer) { return -ENODEV; }
>  static inline void __init snp_secure_tsc_prepare(void) { }
> -static inline void __init snp_secure_tsc_init(void) { }
> +static inline unsigned int __init snp_secure_tsc_init(void) { return 0; }
>  static inline void sev_evict_cache(void *va, int npages) {}
>  static inline enum es_result savic_register_gpa(u64 gpa) { return ES_UNSUPPORTED; }
>  static inline enum es_result savic_unregister_gpa(u64 *gpa) { return ES_UNSUPPORTED; }
> diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> index 8f1604ffe986..f049c126e47c 100644
> --- a/arch/x86/kernel/tsc.c
> +++ b/arch/x86/kernel/tsc.c
> @@ -1440,15 +1440,16 @@ static int __init init_tsc_clocksource(void)
>   */
>  device_initcall(init_tsc_clocksource);
>  
> -static bool __init determine_cpu_tsc_frequencies(bool early)
> +static bool __init determine_cpu_tsc_frequencies(bool early,
> +						 unsigned int known_tsc_khz)
>  {
>  	/* Make sure that cpu and tsc are not already calibrated */
>  	WARN_ON(cpu_khz || tsc_khz);
>  
>  	if (early) {
>  		cpu_khz = x86_platform.calibrate_cpu();
> -		if (tsc_early_khz)
> -			tsc_khz = tsc_early_khz;
> +		if (known_tsc_khz)
> +			tsc_khz = known_tsc_khz;
>  		else
>  			tsc_khz = x86_platform.calibrate_tsc();
>  	} else {
> @@ -1503,6 +1504,8 @@ static void __init tsc_enable_sched_clock(void)
>  
>  void __init tsc_early_init(void)
>  {
> +	unsigned int known_tsc_khz = 0;
> +
>  	if (!boot_cpu_has(X86_FEATURE_TSC))
>  		return;
>  	/* Don't change UV TSC multi-chassis synchronization */
> @@ -1510,9 +1513,19 @@ void __init tsc_early_init(void)
>  		return;
>  
>  	if (cc_platform_has(CC_ATTR_GUEST_SNP_SECURE_TSC))
> -		snp_secure_tsc_init();
> +		known_tsc_khz = snp_secure_tsc_init();
>  
> -	if (!determine_cpu_tsc_frequencies(true))
> +	/*
> +	 * Ignore the user-provided TSC frequency if the exact frequency was
> +	 * obtained from trusted firmware, as the user-provided frequency is
> +	 * intended as a "starting point", not a known, guaranteed frequency.
> +	 */
> +	if (!known_tsc_khz)
> +		known_tsc_khz = tsc_early_khz;
> +	else if (tsc_early_khz)
> +		pr_err("Ignoring 'tsc_early_khz' in favor of trusted firmware.\n");
> +
> +	if (!determine_cpu_tsc_frequencies(true, known_tsc_khz))
>  		return;
>  	tsc_enable_sched_clock();
>  }
> @@ -1533,7 +1546,7 @@ void __init tsc_init(void)
>  
>  	if (!tsc_khz) {
>  		/* We failed to determine frequencies earlier, try again */
> -		if (!determine_cpu_tsc_frequencies(false)) {
> +		if (!determine_cpu_tsc_frequencies(false, 0)) {
>  			mark_tsc_unstable("could not calculate TSC khz");
>  			setup_clear_cpu_cap(X86_FEATURE_TSC_DEADLINE_TIMER);
>  			return;


