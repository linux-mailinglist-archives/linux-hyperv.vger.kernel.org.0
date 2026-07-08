Return-Path: <linux-hyperv+bounces-11861-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Zu77AS7YTWoZ/AEAu9opvQ
	(envelope-from <linux-hyperv+bounces-11861-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 08 Jul 2026 06:55:10 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 57217721A66
	for <lists+linux-hyperv@lfdr.de>; Wed, 08 Jul 2026 06:55:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=Byzqzadf;
	dmarc=pass (policy=quarantine) header.from=amd.com;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11861-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11861-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF8D8301C172
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Jul 2026 04:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9F1375F96;
	Wed,  8 Jul 2026 04:55:07 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010066.outbound.protection.outlook.com [40.93.198.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51F423BD06;
	Wed,  8 Jul 2026 04:55:05 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783486507; cv=fail; b=KqILABOEUbM7joYF09oWrff7C5QhuLJBP8T4+dI2+srLxGFpl0uLyx/qgMaY3tNq/uoX0+S9nM8+VR81rwgyCvlsR0llSa7T+qDnUBMQLs4EnNc0+ftgyhZybYtBgWA+ngBVeq6POT+12x+hC4CKSPZjYQV3aAhcyjxA0kp0rLo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783486507; c=relaxed/simple;
	bh=wYGztEHur/+UC83iouitqslsFqtesyuE4dG4V3n5VPI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DrFXlwQWKX4Ddfh36BmU0Nr5xvJonC9ovQUxTf8QLG7r1V72JimPQLQJS0DZPVtGxtwuD2ZPIbhvh0Meezqkyz3d592Y3ZBZEckPdCDhp11lw3J1exGSsdmzf5I4PshqylN8z7gWOMX169HGa+E3lroSJy3gG21uO6i6xrkVnRs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Byzqzadf; arc=fail smtp.client-ip=40.93.198.66
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=muck2zV8SaUyK1PkyvdQ2Ely+k1o8peyyDSIPc0ZqhGLEKWZZ8/L48dCtIrZQpKgoKYVtQcQn3L7zD9yiU2PDsmLrJ4CF+35nTsz55ferSyHq9z3PsDZCwjZovjkUJ8vUZ+yDJ6LVygsrvVw5avkQ7uO3iQmFLYTUg0Y+5XlNIOBxTYRewa9qN+U7j5DTtEnqJ1L4hkXLv/d1LSnNSO2pPWQG1hWll7t67f1mFTaIm+Q50BCjtl3xMpLLqWOSHgFcfq+1lVBqnCNiOjvmSvAGsnnpb+980Iy6X7W50KKqbZ4HtH/MSISyOCoMQU6IWdWsn7aQPo8wGTj4c1re7JuJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SZ5GDmkLZWd8J5P94VDAI93X1gZGJarzQBk2DH3fIMM=;
 b=X1iU6hK27j3SotgDmlGq5tHaQ8cESXQ3tO5dx3gf51fPmhTKH1dP2VjVTdkJ56kHQrxtIxxgIsKV3m4pB/lveXu8ajoSMnvVr/Va+gJN0v1z7gaYqDd+g1T/mJvK08CXKiHsk7qEUfLJeSqYjKsqZhy4IiCTxv7C/oyMkYh/KZz8YnpOQYcgl6S6tAM0cx18Ef54OxRkpb/nc2wUjgCaRY5tslm/Pmjis+7LtenZXvkAGUbSzaJYQ13zxhOiV7AToitRxrWkXt+UKjTKvNRfPR8Knh4BygLZ8UJg8510CeXoxfOw5t92/7ZN79CVAasctrSmXmwS9noU84hq156zKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SZ5GDmkLZWd8J5P94VDAI93X1gZGJarzQBk2DH3fIMM=;
 b=Byzqzadf4RqBBuyOB/9ulLcKrFNAA0r7xyTdZa92ndPqrS7AUZHodUoQN2bthMb38CjrMMfYMIZg1ZIQD4hK1okK+/bDbqENvVo4hW9ytrf+jizVmsbaU10iJYxWX8heP6MMHASHYUBNGJUpI+j+WrJTPcDUJht4jHPKtry0OvI=
Received: from MW4PR04CA0341.namprd04.prod.outlook.com (2603:10b6:303:8a::16)
 by DM4PR12MB6135.namprd12.prod.outlook.com (2603:10b6:8:ac::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.10; Wed, 8 Jul 2026 04:55:00 +0000
Received: from CO1PEPF00012E62.namprd05.prod.outlook.com
 (2603:10b6:303:8a:cafe::55) by MW4PR04CA0341.outlook.office365.com
 (2603:10b6:303:8a::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.9 via Frontend Transport; Wed, 8
 Jul 2026 04:55:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E62.mail.protection.outlook.com (10.167.249.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 8 Jul 2026 04:55:00 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 7 Jul
 2026 23:55:00 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 7 Jul
 2026 23:54:59 -0500
Received: from [10.252.210.85] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 7 Jul 2026 23:54:49 -0500
Message-ID: <42708d69-42ff-48ec-bd54-0e683c440ae8@amd.com>
Date: Wed, 8 Jul 2026 10:24:43 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 06/51] x86/sev: Don't override CPU frequency
 calibration for SNP's Secure TSC
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
 <20260701193212.749551-7-seanjc@google.com>
Content-Language: en-US
From: "Nikunj A. Dadhania" <nikunj@amd.com>
In-Reply-To: <20260701193212.749551-7-seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E62:EE_|DM4PR12MB6135:EE_
X-MS-Office365-Filtering-Correlation-Id: 162212d4-dfcb-4a25-3888-08dedcad1125
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|32650700020|23010399003|7416014|82310400026|376014|36860700016|6133799003|921020|3023799007|18002099003|22082099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	MhZdQQ5WQce4My/DtjEsGnXBCV401gswIsS7mXg6sHA+jS3dKPLv9bhlsOSW+PgXUqq24ehiXRKmCXee7KIAUZpniARNORz336IHWocle1CQNu3H5VOv/WplcTvPKuIFZQaqCKEghQwJmLsxwMpRxh4AYs0X3FsevuRJ6PhKPBIbCaBp7l03e/WQXCuMFp9bkY762K2HLPexq74B0sVq19YSoAtx6K4SWr1ObM7MzlD9cSm2FnLtD4NOgzJb5TsgtG0768blna0D4X1sUI6RJyQn92F30AuyoXsLVGJOD+aVlNE7uQRNby77xREvOEO77ferIlEezky6qOGbLXjkvXeuZriyLvfwTe67p/0LB8YGHzV8F76yXKdYBa3mP9u2FMlqTcfyR98LycSQFFKcUKYqsyTnd9uz2vUptUB83EpoD5oVGdMh14zIu3RvThkaSB1O2gxN5Yybt8E/B3h46S2R1H+TxQuIjAlj4suP/KTPOLCAO0kwoR6VuckSH6MmA+PxFbFFGXcZdrtZTcO2f7h1wGNqXMhaxob3Fp79KDflY/Lzq+gA3gHrlAN7e8koytdKxWrBfcnXgrNi5Qols+pbj/lcH3tEE5ch1o0cT0ykHcd3BRTkKdXi59MlTFa39s3qi5HCzXgmIRnNNb/xPStcPhbDbLWOhdj0KL8dJjyGc1AM8h99/dCGUYYqhd06qBKvWPzvMuonNs0MxiWuD6D/IK4DIWbr46CsbajuKUHwSsKZuYHh2SkIZkjnalRy
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(32650700020)(23010399003)(7416014)(82310400026)(376014)(36860700016)(6133799003)(921020)(3023799007)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	k/vu6e0T2XlctZLtJdyr6MexpXA2QcnV3xEzcFHJPOr/EVdlmu5jyyjU3hTpkaj5sh8Q2y3b/oi2T6yg5BS4I2gkl3iwOY4W8YI0JYQn4qaUozlGtxruJH8ND67IXFH5zEGYOYaV/0OXdww5VFZi13//IA5WtOyUwh16xmnxbaWAEukUp8EMHCFs/m2RgKsJ02i5bbFAOJLM3+63L9EcgZBkAwu92lj4C3kZfQh3fSf2EYP4LTnxGc6551h1t5bca8bJI7bILyDm8jjXR3zGD7CVA5v4AF2ZpRuiFHauy3oxqkmM2IaFsrtWN/Gkal6K/iafbEZoOVceprE2xzZiQ0ePte4wrSzkYgnG5cHDAtbS8ilBBRfKoJ6rfSUH3DkVcnHHqNZNReQnzrp4rohh+VZI4K75igXJuV9+fqIV5LaVkRY69kxkt1NWz8UA5DQz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 04:55:00.6860
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 162212d4-dfcb-4a25-3888-08dedcad1125
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E62.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6135
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11861-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 57217721A66



On 7/2/2026 1:01 AM, Sean Christopherson wrote:
> Don't override the kernel's CPU frequency calibration routine when
> registering SNP's Secure TSC calibration routine.  SNP (the architecture)
> provides zero guarantees that the CPU runs at the same frequency as the
> TSC.  The justification for clobbering the CPU routine was:
> 
>   Since the difference between CPU base and TSC frequency does not apply
>   in this case, the same callback is being used.
> 
> but that's simply not true.  E.g. if APERF/MPERF is exposed to the VM, then
> the CPU frequency absolutely does matter.
> 
> While relying on heuristics and/or the untrusted hypervisor to provide the
> CPU frequency isn't ideal, it's at least not outright wrong.
> 
> Fixes: 73bbf3b0fbba ("x86/tsc: Init the TSC for Secure TSC guests")
> Cc: Nikunj A Dadhania <nikunj@amd.com>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Nikunj A Dadhania <nikunj@amd.com>

> ---
>  arch/x86/coco/sev/core.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
> index ed0ac52a765e..665de1aea0ee 100644
> --- a/arch/x86/coco/sev/core.c
> +++ b/arch/x86/coco/sev/core.c
> @@ -2046,7 +2046,6 @@ void __init snp_secure_tsc_init(void)
>  
>  	snp_tsc_freq_khz = SNP_SCALE_TSC_FREQ(tsc_freq_mhz * 1000, secrets->tsc_factor);
>  
> -	x86_platform.calibrate_cpu = securetsc_get_tsc_khz;
>  	x86_platform.calibrate_tsc = securetsc_get_tsc_khz;
>  
>  	early_memunmap(mem, PAGE_SIZE);


