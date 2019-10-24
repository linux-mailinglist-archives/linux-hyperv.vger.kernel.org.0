Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8110EE38E4
	for <lists+linux-hyperv@lfdr.de>; Thu, 24 Oct 2019 18:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409945AbfJXQwe (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 24 Oct 2019 12:52:34 -0400
Received: from smtprelay0067.hostedemail.com ([216.40.44.67]:47548 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2409930AbfJXQwe (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 24 Oct 2019 12:52:34 -0400
X-Greylist: delayed 323 seconds by postgrey-1.27 at vger.kernel.org; Thu, 24 Oct 2019 12:52:34 EDT
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave05.hostedemail.com (Postfix) with ESMTP id B7A411817E604
        for <linux-hyperv@vger.kernel.org>; Thu, 24 Oct 2019 16:47:12 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 17510182CED28;
        Thu, 24 Oct 2019 16:47:11 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::::::::,RULES_HIT:41:355:379:599:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1543:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2736:2828:3138:3139:3140:3141:3142:3165:3355:3622:3865:3866:3867:3868:3871:3872:4250:4321:4605:5007:6742:7974:8660:10004:10400:10450:10455:11026:11232:11233:11473:11657:11658:11914:12043:12296:12297:12438:12555:12663:12740:12760:12895:13148:13230:13439:14096:14097:14659:14721:19904:19999:21080:21627:30054:30083:30091,0,RBL:47.151.135.224:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:24,LUA_SUMMARY:none
X-HE-Tag: fan08_5b81e982d0758
X-Filterd-Recvd-Size: 4755
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Thu, 24 Oct 2019 16:47:08 +0000 (UTC)
Message-ID: <4a30de3c6bc3a304ff45f671832480c548c4d8f0.camel@perches.com>
Subject: Re: [PATCH] x86/hyper-v: micro-optimize send_ipi_one case
From:   Joe Perches <joe@perches.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        linux-hyperv@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Roman Kagan <rkagan@virtuozzo.com>,
        Michael Kelley <mikelley@microsoft.com>
Date:   Thu, 24 Oct 2019 09:47:07 -0700
In-Reply-To: <20191024152152.25577-1-vkuznets@redhat.com>
References: <20191024152152.25577-1-vkuznets@redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, 2019-10-24 at 17:21 +0200, Vitaly Kuznetsov wrote:
> When sending an IPI to a single CPU there is no need to deal with cpumasks.
> With 2 CPU guest on WS2019 I'm seeing a minor (like 3%, 8043 -> 7761 CPU
> cycles) improvement with smp_call_function_single() loop benchmark. The
> optimization, however, is tiny and straitforward. Also, send_ipi_one() is
> important for PV spinlock kick.
> 
> I was also wondering if it would make sense to switch to using regular
> APIC IPI send for CPU > 64 case but no, it is twice as expesive (12650 CPU
> cycles for __send_ipi_mask_ex() call, 26000 for orig_apic.send_IPI(cpu,
> vector)).

style trivia:

> diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
[]
> @@ -194,10 +194,26 @@ static bool __send_ipi_mask(const struct cpumask *mask, int vector)
>  
>  static bool __send_ipi_one(int cpu, int vector)
>  {
> -	struct cpumask mask = CPU_MASK_NONE;
> +	int ret;
>  
> -	cpumask_set_cpu(cpu, &mask);
> -	return __send_ipi_mask(&mask, vector);
> +	trace_hyperv_send_ipi_one(cpu, vector);
> +
> +	if (unlikely(!hv_hypercall_pg))
> +		return false;
> +
> +	if (unlikely((vector < HV_IPI_LOW_VECTOR) ||
> +		     (vector > HV_IPI_HIGH_VECTOR)))
> +		return false;
> +
> +	if (cpu >= 64)
> +		goto do_ex_hypercall;

Pretty odd to have a separate single use goto
to a single return statement.  Might be better
using a direct return.

> +
> +	ret = hv_do_fast_hypercall16(HVCALL_SEND_IPI, vector,
> +				     BIT_ULL(hv_cpu_number_to_vp_number(cpu)));
> +	return ((ret == 0) ? true : false);
> +
> +do_ex_hypercall:
> +	return __send_ipi_mask_ex(cpumask_of(cpu), vector);
>  }

And the use of a automatic declaration of ret probably
isn't useful either.

Perhaps:
---
 arch/x86/hyperv/hv_apic.c           | 16 +++++++++++++---
 arch/x86/include/asm/trace/hyperv.h | 15 +++++++++++++++
 2 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
index e01078e9..16c65cd 100644
--- a/arch/x86/hyperv/hv_apic.c
+++ b/arch/x86/hyperv/hv_apic.c
@@ -194,10 +194,20 @@ static bool __send_ipi_mask(const struct cpumask *mask, int vector)
 
 static bool __send_ipi_one(int cpu, int vector)
 {
-	struct cpumask mask = CPU_MASK_NONE;
+	trace_hyperv_send_ipi_one(cpu, vector);
 
-	cpumask_set_cpu(cpu, &mask);
-	return __send_ipi_mask(&mask, vector);
+	if (unlikely(!hv_hypercall_pg))
+		return false;
+
+	if (unlikely((vector < HV_IPI_LOW_VECTOR) ||
+		     (vector > HV_IPI_HIGH_VECTOR)))
+		return false;
+
+	if (cpu >= 64)
+		return __send_ipi_mask_ex(cpumask_of(cpu), vector);
+
+	return !hv_do_fast_hypercall16(HVCALL_SEND_IPI, vector,
+				       BIT_ULL(hv_cpu_number_to_vp_number(cpu)));
 }
 
 static void hv_send_ipi(int cpu, int vector)
diff --git a/arch/x86/include/asm/trace/hyperv.h b/arch/x86/include/asm/trace/hyperv.h
index ace464f..4d705cb 100644
--- a/arch/x86/include/asm/trace/hyperv.h
+++ b/arch/x86/include/asm/trace/hyperv.h
@@ -71,6 +71,21 @@ TRACE_EVENT(hyperv_send_ipi_mask,
 		      __entry->ncpus, __entry->vector)
 	);
 
+TRACE_EVENT(hyperv_send_ipi_one,
+	    TP_PROTO(int cpu,
+		     int vector),
+	    TP_ARGS(cpu, vector),
+	    TP_STRUCT__entry(
+		    __field(int, cpu)
+		    __field(int, vector)
+		    ),
+	    TP_fast_assign(__entry->cpu = cpu;
+			   __entry->vector = vector;
+		    ),
+	    TP_printk("cpu %d vector %x",
+		      __entry->cpu, __entry->vector)
+	);
+
 #endif /* CONFIG_HYPERV */
 
 #undef TRACE_INCLUDE_PATH


