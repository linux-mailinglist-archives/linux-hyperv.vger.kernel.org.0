Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5BE1AD611
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 Apr 2020 08:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbgDQGab (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 17 Apr 2020 02:30:31 -0400
Received: from mail-dm6nam12on2134.outbound.protection.outlook.com ([40.107.243.134]:56527
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726065AbgDQGab (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 17 Apr 2020 02:30:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G39wRhnknX+6ZMiWEWEbG9MegKc2bJ3ohNA59TIM0a8K5mBJi+7AHVvUzPr4Z9AaY5WFqHGzX31JTWM/1A+xQN5/l2TUenBG/tXoEaozi3Lpft1qV7b0sltcgU1VpU7slWH2WbJRYNb4RDFigHAcQH4fb9Q5JwMoFHKxyulR8wjlWNFxSPi1PVsQWm6rRmM+MU7mtbyLHOzko2ZW4K1LSncFT0AICj92xIqd5+2DrsJNwroMXChG3nHfoI/+9Gh+fvc0xHbAmRWMRPMI3pho9pzLUQRhqjtg0EysbUo0zFGLJeohzj2q2PEq/UTP1Eep2Gike+AgckE47LIQb8VmUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9R1Z8nqH4kq1M+rxVH6cQ5q5VTgX6JyjlL1W81jaQNQ=;
 b=MmMxCXd1Zsrpme/MKlgkGm50pa3vFE9eK1Ktk+fpYLGGduoWbmGwf9arCp6Ks86UGcQ9C3EimFM7zwMRvkVmc/FDK0Bh3TvVKY4AWs/QR/XkVgq1mS9AVd4mz3ETxgi8wVWJQzqvvmxJEnMaghQN947JlQDD6+K6pokRliYdf7bJLrfaSXRQTXkawryOvfS2pO8Y0PAHw/oEHQlaeLQmb75Xo7hJ9PBvIAR3Bx69yIHGs20Zp+t1vW5B9bAOD7rijyfRG6nsT6TZoqeKboxslAKEvUxaZfZE/KqIOiQizHFmWq75xR1nwxk2mfGMUXNF5layuEMgNsE5FVX0ZtRCOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9R1Z8nqH4kq1M+rxVH6cQ5q5VTgX6JyjlL1W81jaQNQ=;
 b=dozAzYcuHPr7lntZzYgitICNrsbDV28tM1eDt5fNIODFK2F2ewVBZNabOzMMLKl+mR1SgMC1D+ZMfaRrUtoYPgdWBzl0CnWt5gsVQfpdlGuHe5Ko79fG78qSwHKMVDqvJrQDJ+qjup37zrZRK7EArqraSO+km4+vi+Iowx7IqKc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
Received: from BN8PR21MB1139.namprd21.prod.outlook.com (2603:10b6:408:72::10)
 by BN8PR21MB1201.namprd21.prod.outlook.com (2603:10b6:408:76::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.5; Fri, 17 Apr
 2020 06:30:28 +0000
Received: from BN8PR21MB1139.namprd21.prod.outlook.com
 ([fe80::b01b:e85:784d:4581]) by BN8PR21MB1139.namprd21.prod.outlook.com
 ([fe80::b01b:e85:784d:4581%8]) with mapi id 15.20.2937.000; Fri, 17 Apr 2020
 06:30:28 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     bp@alien8.de, haiyangz@microsoft.com, hpa@zytor.com,
        kys@microsoft.com, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        sthemmin@microsoft.com, tglx@linutronix.de, x86@kernel.org,
        mikelley@microsoft.com, vkuznets@redhat.com, wei.liu@kernel.org
Cc:     Dexuan Cui <decui@microsoft.com>
Subject: [PATCH] x86/hyperv: Suspend/resume the VP assist page for hibernation
Date:   Thu, 16 Apr 2020 23:29:59 -0700
Message-Id: <1587104999-28927-1-git-send-email-decui@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Reply-To: decui@microsoft.com
Content-Type: text/plain
X-ClientProxiedBy: CO2PR04CA0157.namprd04.prod.outlook.com
 (2603:10b6:104:4::11) To BN8PR21MB1139.namprd21.prod.outlook.com
 (2603:10b6:408:72::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (13.77.154.182) by CO2PR04CA0157.namprd04.prod.outlook.com (2603:10b6:104:4::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25 via Frontend Transport; Fri, 17 Apr 2020 06:30:26 +0000
X-Mailer: git-send-email 1.8.3.1
X-Originating-IP: [13.77.154.182]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fbef1cfa-99f1-4a82-a30d-08d7e298d1c2
X-MS-TrafficTypeDiagnostic: BN8PR21MB1201:|BN8PR21MB1201:|BN8PR21MB1201:
X-MS-Exchange-Transport-Forked: True
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-Microsoft-Antispam-PRVS: <BN8PR21MB1201C3293B1CC8EF87655284BFD90@BN8PR21MB1201.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0376ECF4DD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR21MB1139.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(396003)(366004)(39860400002)(376002)(346002)(66946007)(15650500001)(86362001)(26005)(8936002)(478600001)(5660300002)(4326008)(107886003)(66556008)(186003)(66476007)(6512007)(6666004)(316002)(82950400001)(82960400001)(52116002)(36756003)(3450700001)(6486002)(81156014)(6506007)(2616005)(2906002)(10290500003)(8676002)(956004)(16526019)(921003)(1121003);DIR:OUT;SFP:1102;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2sKRKA4kB+AYdCbyeKzMFXcH/mJJ5UIiZadV/O03X+79VTEL5giEM5IFcqCMtFZnWhIHzT56hZSO1ET4cWHQ9hKZ4qivDpD+O4N7nuyIDS2PTEzUeA+zcAui/NNhuHASBdVmPPwODZu3Y7Ywetz+HB4/Qi9kw29eUNLyo0asVqWdQa+eW2AUe6hUQCN4dCPu/2dOLR7LxlrHGiycBt3dDTwLbK4qh9N5mokD89CtfkTYIKBAyELd80pBYBRdyelPbDy4g85bFUVDCTFP6pVxkJHUQGld8yrBS/P08I7hXShWRhnm/2KYNnIyZF3nh50MdQpi18jk2Lb6aAAlf9T+D4Bub0IHt0hcQqJOGeqfofRFzhlsHV58o1G2heaeB8gd3K1+CL/zYzE9aJ6+uYi4npz872yDoURDaK1R7bQcPO4WPOZDZuQoKrjdw/HDImgEqK1o4toqZjdij89P8GZy+SmbDUUf0RhGDXwJPzo1T17Vg4wqyn6JGa8shFm+Zeof
X-MS-Exchange-AntiSpam-MessageData: i+zoom0Wy5X1yQUDObrtRa1mJsCmHD9GRJSgxH/RdGldqakMXjSn7BzJV8eqJMCAc8xUqQ4JnYQYrtndRbkoi2WACRCu+Owp3VRqzmInBZLF+o4GlxrsoJSkmAHeB9SICaaOX9eF9CK6mwn7qt/bGCz6/a6z/GHclDQ74bD5KhXl/MwGpEcO67pdFjCOJ1GNsFWXE8CWLN0+TI2PihUJzcCY9O1MB3VXKzaLmN91tiNnV3N++DiXB9rHP1e4Muutw5j2E6xpaUxFYhPvtLOH76+NaEoKaBWTpetOgHi1+McFMnkNANvEIZCmu1LvPPzJBv0ROOjx6IJS0eNoTmNLmsnr/6rDbkZptOOUDcplo7wAU/jyJEKmnHtp51/BjzbtyNpJGhB1BDPVmEnW77NXsvwWr8YD2Fj1yrF0+cMXYygQgF5iKq4z/WHd2hp3+L22n+5kqfgNKuiPCZwAw7NO6PEdoidZL2ZaieZZnB6wN3rBeQO4sGZ7zTsl/obvGg9zRDAGtEpxcPFBdiksFRMD/103SbwdEasr1GR/A15YC+PcqeN4JeO2CleRKbm5tcnPCu7KQTx90zDQAuxZ/cye8aYOEC9xhwIRnqWMwG0wCvla9HYVtFfnoyzUbMuSYgEzKQXxQY0FYuzMrwSqZcI9Dl7c7PWr2xcYyZR8rZKrFz8eUamkjrcmq4TSebRACOrT4mIYnAB6vs4bWEswgVDVX/+jIaEl4nezxBBcJtKNnSA+PNOKqSs24w55Dj/h3HTHcwH2Jbmp14X6TRCZ0xurhIl+wnDx/MkYrAYBO3y6ieE=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbef1cfa-99f1-4a82-a30d-08d7e298d1c2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2020 06:30:28.2372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rBKbqfSODGh96uCGIog15HQu/Ztvllig/EhdDKHo237htMCNxReGtmCAH74a7k9p023v7/gL06qkUYG5JFzkgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR21MB1201
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Unlike the other CPUs, CPU0 is never offlined during hibernation. So in the
resume path, the "new" kernel's VP assist page is not suspended (i.e.
disabled), and later when we jump to the "old" kernel, the page is not
properly re-enabled for CPU0 with the allocated page from the old kernel.

So far, the VP assist page is only used by hv_apic_eoi_write(). When the
page is not properly re-enabled, hvp->apic_assist is always 0, so the
HV_X64_MSR_EOI MSR is always written. This is not ideal with respect to
performance, but Hyper-V can still correctly handle this.

The issue is: the hypervisor can corrupt the old kernel memory, and hence
sometimes cause unexpected behaviors, e.g. when the old kernel's non-boot
CPUs are being onlined in the resume path, the VM can hang or be killed
due to virtual triple fault.

Fix the issue by calling hv_cpu_die()/hv_cpu_init() in the syscore ops.

Without the fix, hibernation can fail at a rate of 1/300 ~ 1/500.
With the fix, hibernation can pass a long-haul test of 2000 rounds.

Fixes: 05bd330a7fd8 ("x86/hyperv: Suspend/resume the hypercall page for hibernation")
Cc: stable@vger.kernel.org
Signed-off-by: Dexuan Cui <decui@microsoft.com>
---
 arch/x86/hyperv/hv_init.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index b0da5320bcff..4d3ce86331a3 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -72,7 +72,8 @@ static int hv_cpu_init(unsigned int cpu)
 	struct page *pg;
 
 	input_arg = (void **)this_cpu_ptr(hyperv_pcpu_input_arg);
-	pg = alloc_page(GFP_KERNEL);
+	/* hv_cpu_init() can be called with IRQs disabled from hv_resume() */
+	pg = alloc_page(GFP_ATOMIC);
 	if (unlikely(!pg))
 		return -ENOMEM;
 	*input_arg = page_address(pg);
@@ -253,6 +254,7 @@ static int __init hv_pci_init(void)
 static int hv_suspend(void)
 {
 	union hv_x64_msr_hypercall_contents hypercall_msr;
+	int ret;
 
 	/*
 	 * Reset the hypercall page as it is going to be invalidated
@@ -269,12 +271,17 @@ static int hv_suspend(void)
 	hypercall_msr.enable = 0;
 	wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
 
-	return 0;
+	ret = hv_cpu_die(0);
+	return ret;
 }
 
 static void hv_resume(void)
 {
 	union hv_x64_msr_hypercall_contents hypercall_msr;
+	int ret;
+
+	ret = hv_cpu_init(0);
+	WARN_ON(ret);
 
 	/* Re-enable the hypercall page */
 	rdmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
@@ -287,6 +294,7 @@ static void hv_resume(void)
 	hv_hypercall_pg_saved = NULL;
 }
 
+/* Note: when the ops are called, only CPU0 is online and IRQs are disabled. */
 static struct syscore_ops hv_syscore_ops = {
 	.suspend	= hv_suspend,
 	.resume		= hv_resume,
-- 
2.19.1

