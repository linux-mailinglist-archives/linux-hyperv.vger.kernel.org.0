Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C10502F8FB5
	for <lists+linux-hyperv@lfdr.de>; Sat, 16 Jan 2021 23:33:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbhAPWc7 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 16 Jan 2021 17:32:59 -0500
Received: from mail-mw2nam12on2134.outbound.protection.outlook.com ([40.107.244.134]:34785
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726785AbhAPWc6 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 16 Jan 2021 17:32:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ik/OGk7QD1Nv7PzhO8LUdMxtd6vkcVtqT/GP2Hm6lRuhgpEPC8k1f4lc6xXnsVq31m9Z0NwFjttz0Vca66KthOI6WgXrf0BYBu89/z7rwLHTlTwDdR26wCTV0zyQ3QXryCtmT4pGKGnjbMZtRER5qP+4G7EIh39nTirVraB4o/kd9eDo4e8ntmyzGeCNULvYYCSR1gp72LqY5DaSGAJbxklFwLGVLOVovrH/zKO9lJUe9EHN8Q9yrFlWzLZUG1lKpQo9VOK3A2Rm19WgGnRYfk74lETkT7uM0S3vfVbCJZNhXXwLWnkYFit4ymSemEOGZdWJjDk1dUXHX346GmXLEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L5nLudd8pWnmqfH43ZSts45Mw2mYoPvtioTM/6mlSLw=;
 b=EgchFX81TZxmarYlSpqTiOj1DZyBmdeQI6nAI6CXoqcy1H0mDcIWVGTEiEFEqvXS3ffTFmaJZRRZyx7uEotlA2h/fhiyPGSfawJld/NYBj4sSdDDERW20VMinwa3nVTD21oT+79xh71mVexooIVGWh+Bhtf/V78bGv4y+j5C839vjhmJL9eeC/HxbHWClSp8Rh92gCmidoUoYSfhXR701IjuGKEQ5Iyk2PJeQrJbdlCelFQygWpaV36/2JhzqP7NyR2hWgCfR7NcpF9GqutHG6dzPydd5qrYLmBxuknvRjFy0I2fQ5awi38csX0mj8J+vx+6y66CYedAatFF3lCWLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L5nLudd8pWnmqfH43ZSts45Mw2mYoPvtioTM/6mlSLw=;
 b=NYj4QKSVav0allb7ClLVF/3z4612/RTotJj78nj1Xv0by3k/IXzJ5eUGd1M2Lp9QbrXgpxYdtJGXhFs2t8885FyEDzJqOp5hjiXmy8l+z3wtnsP1u3M/UYjbu/7gRPwMF8juSm0y8IridVnS6wJrG51oNRSZx2SYgKzXnGX37iY=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microsoft.com;
Received: from (2603:10b6:207:37::26) by
 BL0PR2101MB0995.namprd21.prod.outlook.com (2603:10b6:207:36::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.0; Sat, 16 Jan
 2021 22:32:10 +0000
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::adcd:42ae:1c83:369]) by BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::adcd:42ae:1c83:369%7]) with mapi id 15.20.3784.007; Sat, 16 Jan 2021
 22:32:09 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     wei.liu@kernel.org, haiyangz@microsoft.com, hpa@zytor.com,
        kys@microsoft.com, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, sthemmin@microsoft.com,
        tglx@linutronix.de, x86@kernel.org, mikelley@microsoft.com,
        vkuznets@redhat.com, bp@alien8.de
Cc:     ohering@suse.com, jwiesner@suse.com, marcelo.cerri@canonical.com,
        Dexuan Cui <decui@microsoft.com>
Subject: [PATCH] x86/hyperv: Initialize clockevents after LAPIC is initialized
Date:   Sat, 16 Jan 2021 14:31:36 -0800
Message-Id: <20210116223136.13892-1-decui@microsoft.com>
X-Mailer: git-send-email 2.17.1
Reply-To: decui@microsoft.com
Content-Type: text/plain
X-Originating-IP: [2001:4898:80e8:2:2c33:1e01:6a99:bb93]
X-ClientProxiedBy: MWHPR04CA0039.namprd04.prod.outlook.com
 (2603:10b6:300:ee::25) To BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:37::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from decui-u1804.corp.microsoft.com (2001:4898:80e8:2:2c33:1e01:6a99:bb93) by MWHPR04CA0039.namprd04.prod.outlook.com (2603:10b6:300:ee::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9 via Frontend Transport; Sat, 16 Jan 2021 22:32:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 351f06d3-b7ba-48cd-fb5b-08d8ba6e8fab
X-MS-TrafficTypeDiagnostic: BL0PR2101MB0995:
X-MS-Exchange-Transport-Forked: True
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-Microsoft-Antispam-PRVS: <BL0PR2101MB0995FBE57CE3D906E680EFB6BFA69@BL0PR2101MB0995.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AiexrpK5nj5e1aJc57OSYxhLqan2TecVT0nc7XCIVAKRLtzUHdfAk3AItHvwylf/QukKzvpUNnB6HzMFGjODBZt400zsbYqH6NezcKI1Dry2C9Xcr7MUmoDE6x4QtnEJ5Q24uKrpYZIH/cWSBxmaS4In122CMzgLHxSCIpfMl0fWucJKsZSUvwgT3Z8aUfZa2hxkgL5zmv0K/hq501HsLgXBJ1ND5CCmKwvC2DSwbDafAneYwouSY0MzJSWx7F1lJCtpPLsiJ4N+GmzabedO05roG8/gW/Wdi6OLETAICw87Af3UbWrrooduilfyIbXCGAqh6P1ilOx1T6B+aAtWzY2/ZXC8pnWba2xyObcI0gQAKWLOcI4fQ7ZJPwIB/3kbanMGsWZ4DcU8OPFImfmj82o6G3tQshdcI9mCzAjO3kYhR+tyOlVKeK1PGeyEWFWmt1QW4oj2XUP7eJcZ2pSU3wGJPtjlMmsUL6gsqpN53f/sMvxjBtgVUiTsbr8OqrrBLY8IXknDUBrO7vdoCzioYmnd+mxORSZTNV4Rm/tPBQJVdP4fGLmJAqscEhqIYSEr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR2101MB1092.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(366004)(376002)(346002)(136003)(316002)(10290500003)(4326008)(7416002)(6486002)(7696005)(52116002)(8676002)(6666004)(1076003)(83380400001)(3450700001)(16526019)(2906002)(2616005)(186003)(86362001)(82950400001)(8936002)(82960400001)(66476007)(66556008)(478600001)(66946007)(921005)(107886003)(5660300002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?hB7yOrwir5mLmYHIrh+U5DoBSX7Ac9Lw2YIdpwbJlRT1hf27vkz6uWYaPWcV?=
 =?us-ascii?Q?1gHK29AY+1nF3TBwYIGZS4blJczaWiujmzBDz97IOAZXkZcAepIh1cvIZUhj?=
 =?us-ascii?Q?kEp1TB914g68l9tvxslREMDuldpWToScPkw1UQynlHVcrk9QhMHCdVzuTcna?=
 =?us-ascii?Q?WOuMq2bf7Sv7sAjO10DH7qNYjjmm6XwXLbnesvm9fI6InBPlqcRSTl6IJRvQ?=
 =?us-ascii?Q?OW9pP4Fy6gByDjcxZuSHnHWUnBzVJUjqIoRru+jveTtNX0nJo43ccF49XPiE?=
 =?us-ascii?Q?a+WXRNz/ndXJAVHvpKFJdX7S5rFzyIU7UB45soJeOR1UMnJqKsf7LFeRjoZj?=
 =?us-ascii?Q?s2XkOZ0lfneynqcLviirdgNy7AuuobuM170+qRpIALSOqU/SsHuhvW36h4MM?=
 =?us-ascii?Q?hZ0zBHlrqyLXThfVEU1VKFbrKUbCg/SlR/0uSTBo1jxpU5iNAFxZalCnO6Gt?=
 =?us-ascii?Q?9mmCXI9cs2Ky65tSNdqdQjKrQ6x00hv6pRsEhrvO+O4AaKKAA4JcabMqMUIK?=
 =?us-ascii?Q?MfHJGjH/U1LjwKPmNJQLXAB1NCYvkKQlzOs9ErzRznRfGASNaRhuXevq8gG+?=
 =?us-ascii?Q?IasOi1mkOlCMoDW9ZTqk13QeuImWKXtOezMJSdhXfH8LyyZRAlKOOuN13VG1?=
 =?us-ascii?Q?vr73mLJC07NbINctu9YJxC9iI64x8N8dpSRZCQW3mtPkDC2q/eawXPXY9wAq?=
 =?us-ascii?Q?tc3nv1sKNCrGKONgpj+NoYP0L0se8b1CBMxnJMYx5pdxzAfruVXSLBTs0t/2?=
 =?us-ascii?Q?9i//Fno0fOVShnhfgIAooM6UvImvbNjRd7UqlQv5Cq9LbzXqZhmCKe/dx5vy?=
 =?us-ascii?Q?QaaJVdWONApSYw7tZjI1il7isAZAGrWyCpmhsAf/Lw+FRFJ8p+WG9IDP3Sk8?=
 =?us-ascii?Q?Syi1VqONSqK9o59o1Q7swKcFtxHbPsbZB+8VSKIorSxMFdn4u4kZw1hlZcfS?=
 =?us-ascii?Q?sHj78KK76S7rS3rNF6zZzGwXT49U9MNsMCFqFkVQ9Nihk5Z4SYI89ogRagnU?=
 =?us-ascii?Q?VofVY2d+r6sFRHnr9rU6nGtSayfXNIl434rCKKavloJgQHBvATzNXArZ6EfA?=
 =?us-ascii?Q?BcALYrOcHxGAQya2KT7CFR+phwYQH8k7kM1BcIL7Qg66vegJW14ibM1E+vzd?=
 =?us-ascii?Q?TT/8VWphBr10?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 351f06d3-b7ba-48cd-fb5b-08d8ba6e8fab
X-MS-Exchange-CrossTenant-AuthSource: BL0PR2101MB1092.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2021 22:32:09.7803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qq0ktcE5LvajyGgX8D8Owo7zJubgiXGtrZbK8isSN/65cZZEU1pKAje89o+CPMX7/3XUL3LprncdFjERhWJzWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0995
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

With commit 4df4cb9e99f8, the Hyper-V direct-mode STIMER is actually
initialized before LAPIC is initialized: see

  apic_intr_mode_init()

    x86_platform.apic_post_init()
      hyperv_init()
        hv_stimer_alloc()

    apic_bsp_setup()
      setup_local_APIC()

setup_local_APIC() temporarily disables LAPIC, initializes it and
re-eanble it.  The direct-mode STIMER depends on LAPIC, and when it's
registered, it can be programmed immediately and the timer can fire
very soon:

  hv_stimer_init
    clockevents_config_and_register
      clockevents_register_device
        tick_check_new_device
          tick_setup_device
            tick_setup_periodic(), tick_setup_oneshot()
              clockevents_program_event

When the timer fires in the hypervisor, if the LAPIC is in the
disabled state, new versions of Hyper-V ignore the event and don't inject
the timer interrupt into the VM, and hence the VM hangs when it boots.

Note: when the VM starts/reboots, the LAPIC is pre-enabled by the
firmware, so the window of LAPIC being temporarily disabled is pretty
small, and the issue can only happen once out of 100~200 reboots for
a 40-vCPU VM on one dev host, and on another host the issue doesn't
reproduce after 2000 reboots.

The issue is more noticeable for kdump/kexec, because the LAPIC is
disabled by the first kernel, and stays disabled until the kdump/kexec
kernel enables it. This is especially an issue to a Generation-2 VM
(for which Hyper-V doesn't emulate the PIT timer) when CONFIG_HZ=1000
(rather than CONFIG_HZ=250) is used.

Fix the issue by moving hv_stimer_alloc() to a later place where the
LAPIC timer is initialized.

Fixes: 4df4cb9e99f8 ("x86/hyperv: Initialize clockevents earlier in CPU onlining")
Signed-off-by: Dexuan Cui <decui@microsoft.com>
---
 arch/x86/hyperv/hv_init.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 4638a52d8eae..6375967a8244 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -315,6 +315,25 @@ static struct syscore_ops hv_syscore_ops = {
 	.resume		= hv_resume,
 };
 
+static void (* __initdata old_setup_percpu_clockev)(void);
+
+static void __init hv_stimer_setup_percpu_clockev(void)
+{
+	/*
+	 * Ignore any errors in setting up stimer clockevents
+	 * as we can run with the LAPIC timer as a fallback.
+	 */
+	(void)hv_stimer_alloc();
+
+	/*
+	 * Still register the LAPIC timer, because the direct-mode STIMER is
+	 * not supported by old versions of Hyper-V. This also allows users
+	 * to switch to LAPIC timer via /sys, if they want to.
+	 */
+	if (old_setup_percpu_clockev)
+		old_setup_percpu_clockev();
+}
+
 /*
  * This function is to be invoked early in the boot sequence after the
  * hypervisor has been detected.
@@ -393,10 +412,14 @@ void __init hyperv_init(void)
 	wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
 
 	/*
-	 * Ignore any errors in setting up stimer clockevents
-	 * as we can run with the LAPIC timer as a fallback.
+	 * hyperv_init() is called before LAPIC is initialized: see
+	 * apic_intr_mode_init() -> x86_platform.apic_post_init() and
+	 * apic_bsp_setup() -> setup_local_APIC(). The direct-mode STIMER
+	 * depends on LAPIC, so hv_stimer_alloc() should be called from
+	 * x86_init.timers.setup_percpu_clockev.
 	 */
-	(void)hv_stimer_alloc();
+	old_setup_percpu_clockev = x86_init.timers.setup_percpu_clockev;
+	x86_init.timers.setup_percpu_clockev = hv_stimer_setup_percpu_clockev;
 
 	hv_apic_init();
 
-- 
2.19.1

