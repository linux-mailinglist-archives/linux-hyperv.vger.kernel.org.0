Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA4887188E6
	for <lists+linux-hyperv@lfdr.de>; Wed, 31 May 2023 19:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbjEaRz2 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 31 May 2023 13:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjEaRz1 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 31 May 2023 13:55:27 -0400
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-centralusazon11020027.outbound.protection.outlook.com [52.101.61.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB7A9128;
        Wed, 31 May 2023 10:55:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XJesK18A6eXaxlm0GDIDIRcCt2nUa7TTcZo07wH4tZaGmiBy8H0H2Y+GdO5Poz/3TVURDKKtlko6FvR4SdV7uc1eJxFpL0rNoipmgoqM8RrcnGRdqdmpHFBsv+eRl9BK1ohnsen6UeszKYJazMFmTCQvqHMhUrDN+FyiGn4A4A2F71gUIj+36MVUUc4AA4K9kA9vOaj7CAERqq2fQfoO6bTqfWHDe3pLAu83rpYMjIPvwTmzMsGAX8HJ47H86Z5MaI6DclkZzaCFaUGxDSndbp26x8HGZLtkZD7VkRMS4o8ViZU16Nsn6jthBDK32+layYUC6vTzyFgIlFUUVkGhNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FiagjFXRe4zMeEQkWrjMVJxTxThPiFQ2dQSw1nzcC8c=;
 b=E9qqR9sa1Scl9uqgzIvVya6TqxTxGwtB9poCw+HjzIsVgN6Iwa/BvmyoT8F7NkNpT8RMq4AcR3jaCRGmqXUe3r0gUY3gYM0Mqn/3Eng+IXrFgsa1/3cYv9bDd2x2sS0zPv7XWkVYVH8aIGoytp3Add8o/WKsYhIeRVMem+n5mBJLIWsv2hc3FF0o5oJCbwIZY7k66cq2LIvfE99rdhWMRoAysW79EYLvmMEHGr3vh8Wd0qvNbXpa7N+fdYS8bwkqUVaTslH4ufrD91yZMfJPz6Z3D2xFeiQnuYd1akuEtk73H2KUndYqCj0w6LfsDS3rn1HWcegGn1kCRoLSPq406A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FiagjFXRe4zMeEQkWrjMVJxTxThPiFQ2dQSw1nzcC8c=;
 b=Ayfe4uu7zBaTQqiRFCExyAZN/Qh5sR+TCxrUWUAmWDGAPHcRG6cI0F38erkzDe4C/BClM6wJVUnZDKFrY/niSPyU4oUP5aUobeGTwTWWmEkW+xCQscQlvHOdFfk121HmevNHQLgIyiughu9xrzLgu9sYBGiNqJAx7SlboORP8ss=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1370.namprd21.prod.outlook.com (2603:10b6:5:16b::28)
 by DM6PR21MB1530.namprd21.prod.outlook.com (2603:10b6:5:256::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.6; Wed, 31 May
 2023 17:55:23 +0000
Received: from DM6PR21MB1370.namprd21.prod.outlook.com
 ([fe80::b7e9:4da1:3c23:35f]) by DM6PR21MB1370.namprd21.prod.outlook.com
 ([fe80::b7e9:4da1:3c23:35f%6]) with mapi id 15.20.6477.004; Wed, 31 May 2023
 17:55:23 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Cc:     mikelley@microsoft.com
Subject: [RFC PATCH 1/1] sched/fair: Fix SMT balance dependency on CPU numbering
Date:   Wed, 31 May 2023 10:54:33 -0700
Message-Id: <1685555673-2363-1-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: CYXPR03CA0088.namprd03.prod.outlook.com
 (2603:10b6:930:d3::9) To DM6PR21MB1370.namprd21.prod.outlook.com
 (2603:10b6:5:16b::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR21MB1370:EE_|DM6PR21MB1530:EE_
X-MS-Office365-Filtering-Correlation-Id: 5548914f-e83d-4c45-752d-08db620034e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U+C7jpdQ7pWkYWMVgyrva1SMSFU+FErbm5wbsvD94DbD9XceIkaUMWom8BojOAUZdyWcLt6jBUFZpyRrOBkXsghZUVTNNDcMCmccc/ViArFzC9suP20zr7+riLlyqyo6LvB5GBmw6hUxAyb0SJuRZ7hFZ8VrNaWaYgZvw+PgkJjP16TyHSBts3R9RwKo5nLxMA1FRULwy8T9/jZ+jkTMrH9nwAxJEFbXvuST29UtcC7nhoJbuXdxCbAK4k85lt3Fs4nDfeJjrPtCYCMXul/nSmpKt37g3CbyepPurZv6q7Lo/khwpWDUfzD7cxkXAlO3H5ma9Zw0MMVHPs2brMMYdBSOQKWuG6YctXTX0ZouifqbKg7OQlRk7729+DDiz3Oj0m++VR6znhdnZB1iMoiti8DGLGXOIGIDmvgY3A4c95aN3GKUuq/89K5+vW9H+3fc5frfGu98oxrdhRb6WKDDSc7oDb/Xb++aagwLVDWDzQBXpPUXUjZTXAKS8Sy8JQAGiFXAzah57cZq4TnWe9B2trqJOlC89AHVf+QPips2PISFfgW1g1ICeaaYj1OLl+C6nKVc7n3jB0NOUwNqzBNKcTa7jrXPGiFBWmj2GM12u8gzGNuk/h2hGXtDjLSfclEDaT5/+13KrSWNMLLwW2K5/A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1370.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(346002)(376002)(396003)(366004)(451199021)(8936002)(38350700002)(8676002)(82960400001)(6512007)(26005)(38100700002)(6506007)(921005)(2616005)(2906002)(83380400001)(5660300002)(82950400001)(186003)(7416002)(107886003)(6666004)(6486002)(52116002)(86362001)(41300700001)(66476007)(66556008)(36756003)(66946007)(4326008)(786003)(10290500003)(478600001)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?weJHgV+H2AMapW7C/SY9JufUPbFzgKrhK4/QwNyAq041NEdQPoBEMLMPELuH?=
 =?us-ascii?Q?m5e0WzaGTX+oTTuQRsupx7KMZQO0f33HcZnElrg6Z+UpyCwuKWNCyZZAIfMM?=
 =?us-ascii?Q?N63GV8AuL9fp8rr5ywE3/SvD84kPEIOxYskZYjdyOmwqFheOaJ3PnR7swkYy?=
 =?us-ascii?Q?lxqD5jdWvFEkk3PR0cbTW780rP3I07sLRIVvfneOk/9Ewtho0SVgxrq+sOhO?=
 =?us-ascii?Q?jiJys2qwY/JkErANGEEt9F1U3tdT0t4vQ6JzBTWCRRTGzVo4RnMAOsjFO2N4?=
 =?us-ascii?Q?O4qyylx4GPH9hulULSqQlsEvbTvKU/De1LwO+1WpDT1ZIpJrcPJphbuTN7wy?=
 =?us-ascii?Q?WHMmBjztH3JhXdISbQwp2p2k/qY3/Xp3pkOx/CbBzpKON5/m52ToAJe13VgI?=
 =?us-ascii?Q?+MMyngVVNc8vGL6qoBPO8BAYvkCu7ffmLjk4MvzbuqCQDbbYbaUwZYzb9HQv?=
 =?us-ascii?Q?IbRjFltctjSmdvslAlMKCYq2J8DjIJp3ryJSBXnrh/Fux/T8FeLjHfg2T0ss?=
 =?us-ascii?Q?r/gHzOrFyVmRrqPNwM+vBNfBvQ+X/10/hzhTkPD5F2RKZrkDSbeRRQG2nQSE?=
 =?us-ascii?Q?OQE1yO6I+BAkKFTxOIg77h4KIqnNxcVAPX81gZgBXCVW+ta0o5QUOuy+itrh?=
 =?us-ascii?Q?k5hKnVzfqrNqojZHsMlmpdFQsukSreB8kMn4u67ZtMeXrn3zyV6YQ0+GBliW?=
 =?us-ascii?Q?em+GzG/FMPsBsNA14xJC7pUCzwR0vkVLl/lkwpUuPxZ2ojYbOX0QE6SZTQa+?=
 =?us-ascii?Q?5SIZroGtqzZ/cyHNcPcNpY3vuHL/OV2O6j1338aXHEJiM7BCpJil6ngab87/?=
 =?us-ascii?Q?zRLkIh2JT3ArgnYFssA44EF+P6YqvPUevox8aofQZbiv+YNv/D7CIePhYq8Z?=
 =?us-ascii?Q?MHiYSb8CbQp4l4gD30NyQHIlsYZqlbMTROIt/0geV+6RjmDpZMO2R5GkX1t3?=
 =?us-ascii?Q?hWDkIanlEZKdlf3Y0mnr3Iql1YcSoVze9UNUB4YPPEeicpi8A7IqUAstsD/k?=
 =?us-ascii?Q?ZvbgO/RywUBTx5WeuG3NzV0/x2o3Gyp4dyjfOoYl0XeWimK9Xy3Sb8NVcbLW?=
 =?us-ascii?Q?eZtqwdpVz5ou1YxcFJ0r78+vkWcpPO7dbeU5WOvkWfN+Er3m2UMXRewGw9Fn?=
 =?us-ascii?Q?zY1x//dfl9+AmQFXxaHOsiqSkwykJmcoiI5lhQ/Vlwofz4Y68tUSy6sMUnMr?=
 =?us-ascii?Q?7Vm2Gx4Lb2AerKPzdV92aEmfiotFd/od9uLaWd51T2xoxJ7T/BqtIbHTogC5?=
 =?us-ascii?Q?XT4FtC2DetTdd2sVKSdoTk/CCx4eJqVAm2DE4F+1aWoOa4S9UIHS45WORN3e?=
 =?us-ascii?Q?IF6lC3fpabjTh0u6eMVbnGGjUxq3mwE/5XkbqAvcl1gb9ZGzODIHYn6vDM0A?=
 =?us-ascii?Q?vHKetHxNgpw5nX9xUgvTu/hGx6MxuMFJdI8DkLPZYNQe18MG44TwACDpOtkm?=
 =?us-ascii?Q?9krHjgLb8Oqi6+TSBtXAPwjykFQT4/njGgwQCBqvnOkSl+YI+wD38Zy2ya5K?=
 =?us-ascii?Q?n7XFt8s2sxOctPWyqam33dhIz1REdtBH+9tkqNUHeRl9GcoIYsU1bgjihi48?=
 =?us-ascii?Q?7KhKm5QSBwZpktaJPZcrSVgG9qdNbelk+BkMlieE?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5548914f-e83d-4c45-752d-08db620034e2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 17:55:23.0627
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mkw5TEBSKKSpMS00pWoc+rxCOV+u0Gh6TrD7j5Cyms3A8H8fejPc0nUg16ZpOpqD0DVg65UQI14eK5fhjtugQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR21MB1530
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

With some CPU numbering schemes, the function select_idle_cpu() currently
has a subtle bias to return the first hyper-thread in a core. As a result
work is not evenly balanced across hyper-threads in a core. The difference
is often as much as 15 to 20 percentage points -- i.e., the first
hyper-thread might run at 45% load while the second hyper-thread runs at
only 30% load or less.

Two likely CPU numbering schemes make sense with today's typical case
of two hyper-threads per core:

A. Enumerate all the first hyper-theads in a core, then all the second
   hyper-threads in a core.  If a system has 8 cores with 16 hyper-threads,
   CPUs #0 and #8 are in the same core, as are CPUs #1 and #9, etc.

B. Enumerate all hyper-threads in a core, then all hyper-threads in the
   next core, etc.  Again with 8 cores and 16 hyper-threads, CPUs #0 and
   #1 are in the same core, as are CPUs #2 and #3, etc.

Scheme A is used in most ACPI bare metal systems and in VMs running on
KVM.  The enumeration order is determined by the order of the processor
entries in the ACPI MADT, and the ACPI spec *recommends* that the MADT
be set up for scheme A.

However, for reasons that pre-date the ACPI recommendation, Hyper-V
guests have an ACPI MADT that is set up for scheme B.  When using scheme B,
the subtle bias is evident in select_idle_cpu().  While having Hyper-V
conform to the ACPI spec recommendation would solve the Hyper-V problem,
it is also desirable for the fair scheduler code to be independent of the
CPU numbering scheme.  ACPI is not always the firmware configuration
mechanism, and CPU numbering schemes might vary more in architectures
other than x86/x64.

The bias occurs with scheme B when "has_idle_cpu" is true and
select_idle_core() is called in the for_each_cpu_wrap() loop. Regardless
of where the loop starts, it will almost immediately encountered a CPU
that is the first hyper-thread in a core. If that core is idle, the CPU
number of that first hyper-thread is returned. If that core is not idle,
both hyper-threads are removed from the cpus mask, and the loop iterates
to choose another CPU that is the first hyper-thread in a core.  As a
result, select_idle_core() almost always returns the first hyper-thread
in a core.

The bias does not occur with scheme A because half of the CPU numbering
space is a series of CPUs that are the second hyper-thread in all the
cores. Assuming that the "target" CPU is evenly distributed throughout
the CPU numbering space, there's a 50/50 chance of starting in the portion
of the CPU numbering space that is all second hyper-threads.  If
select_idle_core() finds a idle core, it will likely return a CPU that
is the second hyper-thread in the core.  On average over the time,
both the first and second hyper-thread are equally likely to be
returned.

Fix this bias by determining which hyper-thread in a core the "target"
CPU is -- i.e., the "smt index" of that CPU.  Then when select_idle_core()
finds an idle core, it returns the CPU in the core that has the same
smt index. If that CPU is not valid to be chosen, just return the CPU
that was passed into select_idle_core() and don't worry about bias.

With scheme B, this fix solves the bias problem by making the chosen
CPU be roughly equally likely to either hyper-thread.  With scheme A
there's no real effect as the chosen CPU was already equally likely
to be either hyper-thread, and still is.

The imbalance in hyper-thread loading was originally observed in a
customer workload, and then reproduced with a synthetic workload.
The change has been tested with the synthetic workload in a Hyper-V VM
running the normal scheme B CPU numbering, and then with the MADT
replaced with a scheme A version using Linux's ability to override
ACPI tables. The testing showed no change hyper-thread loading
balance with the scheme A CPU numbering, but the imbalance is
corrected if the CPU numbering is scheme B.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---

I haven't previously worked in Linux scheduler code, so I'm posting this
as an RFC to point out the observed problem, and to suggest a solution.
There may well be considerations in the design of a solution that I'm not
aware of, so please educate me or suggest an alternative.

It's also not completely clear whether an imbalance in hyper-thread
loading is actually a problem. It looks weird, and causes customer
concern when it is observed consistently across all cores in some
production workload. The fair scheduler strives to balance load evenly, so
I'm treating it as a problem that should be fixed, if for no other reason
than general goodness. But again, I'm sure reviewers will feel free to
tell me otherwise. :-) The fix takes relatively few CPU cycles, but it's
still a non-zero cost.

FWIW, the same imbalance has been observed with kernels as far back as
5.4, and the root cause in the code is essentially the same. So it's not
a recently introduced issue. I haven't tried anything earlier than 5.4.

 kernel/sched/fair.c | 36 ++++++++++++++++++++++++++++++------
 1 file changed, 30 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 373ff5f..8b56e9d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6832,6 +6832,19 @@ static inline bool test_idle_cores(int cpu)
 	return false;
 }
 
+static inline int get_smt_index(int core)
+{
+	int cpu, n = 0;
+
+	for_each_cpu(cpu, cpu_smt_mask(core)) {
+		if (cpu == core)
+			return n;
+		n++;
+	}
+	/* If get here, cpu_smt_mask is set up incorrectly */
+	return 0;
+}
+
 /*
  * Scans the local SMT mask to see if the entire core is idle, and records this
  * information in sd_llc_shared->has_idle_cores.
@@ -6866,10 +6879,11 @@ void __update_idle_core(struct rq *rq)
  * there are no idle cores left in the system; tracked through
  * sd_llc->shared->has_idle_cores and enabled through update_idle_core() above.
  */
-static int select_idle_core(struct task_struct *p, int core, struct cpumask *cpus, int *idle_cpu)
+static int select_idle_core(struct task_struct *p, int core, int smt_index,
+			    struct cpumask *cpus, int *idle_cpu)
 {
 	bool idle = true;
-	int cpu;
+	int cpu, index_cpu, n = 0;
 
 	for_each_cpu(cpu, cpu_smt_mask(core)) {
 		if (!available_idle_cpu(cpu)) {
@@ -6885,10 +6899,13 @@ static int select_idle_core(struct task_struct *p, int core, struct cpumask *cpu
 		}
 		if (*idle_cpu == -1 && cpumask_test_cpu(cpu, p->cpus_ptr))
 			*idle_cpu = cpu;
+
+		if (n++ == smt_index)
+			index_cpu = cpu;
 	}
 
 	if (idle)
-		return core;
+		return cpumask_test_cpu(index_cpu, p->cpus_ptr) ? index_cpu : core;
 
 	cpumask_andnot(cpus, cpus, cpu_smt_mask(core));
 	return -1;
@@ -6922,7 +6939,13 @@ static inline bool test_idle_cores(int cpu)
 	return false;
 }
 
-static inline int select_idle_core(struct task_struct *p, int core, struct cpumask *cpus, int *idle_cpu)
+static inline int get_smt_index(int core)
+{
+	return 0;
+}
+
+static inline int select_idle_core(struct task_struct *p, int core, int smt_index,
+				   struct cpumask *cpus, int *idle_cpu)
 {
 	return __select_idle_cpu(core, p);
 }
@@ -6942,7 +6965,7 @@ static inline int select_idle_smt(struct task_struct *p, int target)
 static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool has_idle_core, int target)
 {
 	struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_rq_mask);
-	int i, cpu, idle_cpu = -1, nr = INT_MAX;
+	int i, cpu, smt_index, idle_cpu = -1, nr = INT_MAX;
 	struct sched_domain_shared *sd_share;
 	struct rq *this_rq = this_rq();
 	int this = smp_processor_id();
@@ -6994,9 +7017,10 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
 		}
 	}
 
+	smt_index = get_smt_index(target);
 	for_each_cpu_wrap(cpu, cpus, target + 1) {
 		if (has_idle_core) {
-			i = select_idle_core(p, cpu, cpus, &idle_cpu);
+			i = select_idle_core(p, cpu, smt_index, cpus, &idle_cpu);
 			if ((unsigned int)i < nr_cpumask_bits)
 				return i;
 
-- 
1.8.3.1

