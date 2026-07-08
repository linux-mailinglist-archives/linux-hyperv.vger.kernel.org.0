Return-Path: <linux-hyperv+bounces-11862-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PW8EEaXZTWpu/AEAu9opvQ
	(envelope-from <linux-hyperv+bounces-11862-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 08 Jul 2026 07:01:25 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E55721ABF
	for <lists+linux-hyperv@lfdr.de>; Wed, 08 Jul 2026 07:01:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=P6KZYBax;
	dmarc=pass (policy=quarantine) header.from=amd.com;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11862-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11862-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0E557302A1B7
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Jul 2026 05:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3DA43B7742;
	Wed,  8 Jul 2026 05:01:07 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013012.outbound.protection.outlook.com [40.93.196.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB103B52EE;
	Wed,  8 Jul 2026 05:01:06 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783486867; cv=fail; b=I/Jn9m92r1c+7WulGFzJcIXgLljYnRjCQHLNwZYdZ7PC4EKD/UIzGMNiZfPT9qagSVAZGJmcjhf2/dxkGLB1C783kFuZ0OqxG+fCYS4UwQcfu2ND3OCIINbAK7sQ+47LVVnMhCVBNjSvmA2XYq7PzO1dat1s0zi+mAJGaevlP1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783486867; c=relaxed/simple;
	bh=b1ZxIZwq91G58R1pRlEwh9Omn3Qa+HQW5Ccnh7e6crg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JJxG/0bQKwjruGext+ERTOiEnHiZSReGGrilwLyYLJ7MmOOyd3jdNQ9E2U059niBX4isLAGHD0+S//pNiRZ9c03G2aGUiAMiW+Qq6R3rpbp6ZaJ0qHgDL56fTk6Gqy37IwG8WvAl6VeVYmMQHUhp181ZSjCxytFIOsuSKDutwFM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=P6KZYBax; arc=fail smtp.client-ip=40.93.196.12
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CLDoeGeCKqsQLuGDRolc48q+PNhzUpcyOFfI7lqPhkMXhCjnc4Xtgzzr8qhA5ysKbDFT3a2UzD/WIAE6lTrMdj6DsgLUe5gYpmpIMBfWvIpeurP/TQSXwBpXpCpHOD6+2N7Erwch9BJYHKOJ08ieE6YqTAzJR/2TvLVNAa4h7oVSPuTINz9Dj4Kx1l5tpEM3GqbFZW78pWm24UYAmQ1wAljYUaQjIiooOYweknS2HJAIJuVjx06E/pKUE5U6LLX3A0iOtTs7JI7pv0qy6Wh/EW1qdfjMmatLxWk+VzFQD9GFhU3J5RUbWBVn5phHH28VwXa+rFf5+G9Q+k/U2D+9Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eqr2Nfue4Gpy3xYbMW1647pTXhjbpkE+JNpob8rQ3u0=;
 b=Gxe326BFoTjzmpHYlQmdCqOhb3tBkoTRcEXAD49cKoBOetMROgsCgfR32xioWcGfQ5RGQbnvcEP92ZzitWSAIZqU1gQ2ym6COweNkNbUePS847Kvw9FJyiYTljqqhKllMThHi8cEIXgbmwU4RfL2dDF3HbMbTdWh87vaXKP9h331ENT7uThXGxMEzX4WxLjy75ayHDdJGwZWcvuYXs+wJNbRXLDe8TX/nCg3B6Yovtu5E0EgWdaeLRPNhag1pkVtGjqWVxeggU0cfSa+aAq1IRecCHrKQpxN8gk4ad64YikHF+zdKehMOX6XOC8DoDPu27VUBdy64RAAFRknYSS//A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eqr2Nfue4Gpy3xYbMW1647pTXhjbpkE+JNpob8rQ3u0=;
 b=P6KZYBaxKc6BpjtITTmtYuftV7aYW8OZWNCrgAi4balxnXqROATjbsQtnSq1vA9G+MVYxGgBxhdazfnxKZWZFILaRUdN0VjZYgL3O0c2uP3M2fwMmSjfoH0pEcqRU4asocE9ChghIEiy31CpMbA2dpbujCJgMCyy6xmCHOQqGZU=
Received: from CY5PR15CA0138.namprd15.prod.outlook.com (2603:10b6:930:68::20)
 by DS7PR12MB6287.namprd12.prod.outlook.com (2603:10b6:8:94::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Wed, 8 Jul
 2026 05:01:01 +0000
Received: from CY4PEPF0000EE3F.namprd03.prod.outlook.com
 (2603:10b6:930:68:cafe::ab) by CY5PR15CA0138.outlook.office365.com
 (2603:10b6:930:68::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.10 via Frontend Transport; Wed, 8
 Jul 2026 05:00:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE3F.mail.protection.outlook.com (10.167.242.17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 8 Jul 2026 05:00:55 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 8 Jul
 2026 00:00:53 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 8 Jul
 2026 00:00:53 -0500
Received: from [10.252.210.85] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 8 Jul 2026 00:00:42 -0500
Message-ID: <e48ba6a5-e909-43f3-b971-17cebdffcbf4@amd.com>
Date: Wed, 8 Jul 2026 10:30:41 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 47/51] x86/paravirt: Don't use a PV sched_clock in CoCo
 guests with trusted TSC
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
 <20260701193212.749551-48-seanjc@google.com>
Content-Language: en-US
From: "Nikunj A. Dadhania" <nikunj@amd.com>
In-Reply-To: <20260701193212.749551-48-seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3F:EE_|DS7PR12MB6287:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ed22401-cf4b-4db4-f9c4-08dedcade4a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|32650700020|23010399003|376014|7416014|36860700016|11063799006|56012099006|4143699003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	hicUHZf7gSTC9rlKhsIuWxrLKyaONb75ZL6t/0wa9SiHSEMC19SVhZjHkGll0Hzfr9giscI3l+EjdJINV3wmoKOLnt+EQ0iZFBK4aJzpOdq2oX9IcTTSSTYgHJFQlXv6U/RWwaFQV8U2Z5T1bEGgxyRwWrpFudiPMnUM/ntDkjmxo7zIeT0Wg3+ZbUtHOh9F/oWAATJpkTosjpNiuxmOeCYUlv4bfeeS661U9owNO4hrFRUYCgZWVE5E++pwZ/FHQhtKYb6++cnhiMXKl3Tvovk9QX2b0zpBgJNsTG45myWHzN1VmnmKbABwtu5QKjrCh8pfgEOxeObrajkA6upMTVA5sFTfgmQiucdo0cZ9X7WGWij7H9VuNUqBV39ZThzD+9oG6OeCtcBcwu8YCb9epzQmaochipsLztx7H6rwZ/G0THAUKvTlulnmOGm9T3ynlyCETPOUxMjacOamoD1lGudjiKOp/JvRan6as2x+zDYNNCZmhaKTS4VaCVAnUvRhY7ZZtjPhYE2WUy3UBuWRBeslWBbOZPl6mDo0NYhAdutAIKNuLbt9dwzz7lSI2dwbby3txD2LTZMbixrZYdv8nR1iHIz6m7NuvFsPiisGaW9oWkBWlSymlZSeHf+r8ktdVxQMCGNzIZBNfWGGbxMnt/0KtTElHWt58jjDjIU5CPy5wZCxAcfpvIZXVRwKvfDcAOlF92Nu6nJ/0X3NjfiD6PcdIv5AU4ROSn5VYY2QmrErd3OCWrvhA+1Eb09r36NM
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(32650700020)(23010399003)(376014)(7416014)(36860700016)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	zaoEsGbRqKJtvHxF7Cp7T4h6fpbC+IQ1bcqTKUXjPqC4nToKNP1pgGG2dGwPmwBX/uwMDmU8HMTRiIY9QNanhb36RkGJh7po0Uiaf2z8+eMG8tmP9UpYZrBL1I1DjnTDzRfF7JZWMRjjx8m1O0B857aEZehV5lPOVmYQ+J8y1HmVMvacnQHSXRUzqGg2poz48mf3EQ0y6WSIgktjX0zYcnseZGoSqtznKBhM6M28pO7HjUKz8qfBQAOYtOXu2S6rx8T4zuK8hbwFEHIJ9mcyc0SbVaup1U77Syy8gzP4HbY9H2H5x27dQsqMvo66BKOHHs/zuC5vP99APeLkbuk0gIsP0OzYP5CgcwS2liH8jhsy7fa2isulNyYhT+Zb05BcHP+UzKlo4IyzmX5Bx7f1W93GIo1H0HNVW90gIFmhSzSwtf3k2dk7GTPiS3z3FEcf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 05:00:55.6041
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ed22401-cf4b-4db4-f9c4-08dedcade4a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6287
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11862-lists,linux-hyperv=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[41];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:seanjc@google.com,m:corbet@lwn.net,m:pbonzini@redhat.com,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:x86@kernel.org,m:kas@kernel.org,m:rick.p.edgecombe@intel.com,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:longli@microsoft.com,m:ajay.kaher@broadcom.com,m:alexey.makhalov@broadcom.com,m:jan.kiszka@siemens.com,m:luto@kernel.org,m:peterz@infradead.org,m:jgross@suse.com,m:daniel.lezcano@kernel.org,m:jstultz@google.com,m:skhan@linuxfoundation.org,m:hpa@zytor.com,m:vkuznets@redhat.com,m:bcm-kernel-feedback-list@broadcom.com,m:boris.ostrovsky@oracle.com,m:sboyd@kernel.org,m:linux-doc@vger.kernel.org,m:kvm@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-coco@lists.linux.dev,m:linux-hyperv@vger.kernel.org,m:virtualization@lists.linux.dev,m:xen-devel@lists.xenproject.org,m:thomas.lendacky@amd.com,m:dwmw@amazon.co.uk,m:dwmw2@infradead.org,m:mhklinux@outlook.com,m:tglx@linutroni
 x.de,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[nikunj@amd.com,linux-hyperv@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,zytor.com,redhat.com,broadcom.com,oracle.com,kernel.org,vger.kernel.org,lists.linux.dev,lists.xenproject.org,amd.com,amazon.co.uk,infradead.org,outlook.com,linutronix.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,amd.com:from_mime,amd.com:email,amd.com:mid,amd.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A2E55721ABF



On 7/2/2026 1:02 AM, Sean Christopherson wrote:
> Silently ignore attempts to switch to a paravirt sched_clock when running
> as a CoCo guest with trusted TSC.  In hand-wavy theory, a misbehaving
> hypervisor could attack the guest by manipulating the PV clock to affect
> guest scheduling in some weird and/or predictable way.  More importantly,
> reading TSC on such platforms is faster than any PV clock, and sched_clock
> is all about speed.
> 
> Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Nikunj A Dadhania <nikunj@amd.com>

> ---
>  arch/x86/kernel/tsc.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> index 012321fed5e5..a146fc7b5e74 100644
> --- a/arch/x86/kernel/tsc.c
> +++ b/arch/x86/kernel/tsc.c
> @@ -283,6 +283,15 @@ bool using_native_sched_clock(void)
>  int __init __paravirt_set_sched_clock(u64 (*func)(void), bool stable,
>  				      void (*save)(void), void (*restore)(void))
>  {
> +	/*
> +	 * Don't replace TSC with a PV clock when running as a CoCo guest and
> +	 * the TSC is secure/trusted; PV clocks are emulated by the hypervisor,
> +	 * which isn't in the guest's TCB.
> +	 */
> +	if (cc_platform_has(CC_ATTR_GUEST_SNP_SECURE_TSC) ||
> +	    boot_cpu_has(X86_FEATURE_TDX_GUEST))
> +		return -EPERM;
> +
>  	if (!stable)
>  		clear_sched_clock_stable();
>  


