Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0388D722236
	for <lists+linux-hyperv@lfdr.de>; Mon,  5 Jun 2023 11:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbjFEJax (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 5 Jun 2023 05:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbjFEJav (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 5 Jun 2023 05:30:51 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3AF1DC
        for <linux-hyperv@vger.kernel.org>; Mon,  5 Jun 2023 02:30:49 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 46e09a7af769-6b160f3f384so797843a34.3
        for <linux-hyperv@vger.kernel.org>; Mon, 05 Jun 2023 02:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685957449; x=1688549449;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=F1xYeX0RVc8vO+l58JvAUmFd3/t+1YPaoz3NQ/n0ZWU=;
        b=YulOkGFkRYmJ/HSHGGboVujcltfcHikpcPDb3JF3Q3bjrt98Tjd/WLIBnUkxWGkF0Z
         hnNafX0MbK2k6TySgOJ46LCfO9xXM6F0XRn3ErGNEbFR5WiB09vCQTHJ8di0v6OS/e0Z
         elSTwP833hfzD2TYSwBWdQ5T67DZhjF7ll/C9naKrLve+hk9imwMSkG9eq+yYaKPUgWc
         6HQYacdre4ImAo7sxbG4NV9XvBJ/1a4iKtusZnBbJ4qzekIy/6ZZGWTiPuo29sGzkAIv
         uZ6tBh3vU23eFdcyIUwoFQWNHS9BOVau6bqtjdN/cTOS26RfOlnVS1ZZwgPDVWagoFe7
         xRDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685957449; x=1688549449;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F1xYeX0RVc8vO+l58JvAUmFd3/t+1YPaoz3NQ/n0ZWU=;
        b=RwoFDNGex/7RyHTQwBGJnS+8BkGl9PjdP7Xt6nRzTYRbNRc1N6w52zPC7+uWfkpWG3
         lw82oArQb/XtJeJ2u5kfw5JHi7iQgbDXfJE8CGBmQDxmOgvKQ1oUqup+6NaIUm9sxR8/
         dS5hMI0E53wghgI22R7m8uuXvbbsxgEJty+NG+sG+aAuZtV6kOsWD71ZFkcR5okARmbI
         S8jZGDBpeOLKycH6BC7aD6s48YR6Zl6LdoZTEKNntxkhUkYAgbCg29bI2W3DbTBZn36I
         MiXjBMS0h03steE6FNWyIn9aPEDCGhR6r9oJkyi2JuMjVH9N+eOETeDu5cada1b/sZmy
         F7iA==
X-Gm-Message-State: AC+VfDxMKcAdXJ2ve8l52n/1nlcueZ9y0cOIPGzWWg6fwshOOmX9zZn7
        VZJEGX+4ekkwf/aA6GlVnD2nT6iVagaL5hIHmN/h0g==
X-Google-Smtp-Source: ACHHUZ6OnLbvwCQqecf6Di5raeE+E5NLuAYPsLLnNXmLIlReOBC6MAdwVOZYqTKthaZn0HDQ5UjjhKvNCevSOT7CmCI=
X-Received: by 2002:a05:6358:4fa6:b0:129:c0c5:da9d with SMTP id
 cg38-20020a0563584fa600b00129c0c5da9dmr617329rwb.29.1685957448895; Mon, 05
 Jun 2023 02:30:48 -0700 (PDT)
MIME-Version: 1.0
References: <1685555673-2363-1-git-send-email-mikelley@microsoft.com>
In-Reply-To: <1685555673-2363-1-git-send-email-mikelley@microsoft.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 5 Jun 2023 11:30:37 +0200
Message-ID: <CAKfTPtAyFqG4W0OAc6pejKdEQ4yTRaoC+qiOZN8sRrwCENmVKA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] sched/fair: Fix SMT balance dependency on CPU numbering
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Michael,

On Wed, 31 May 2023 at 19:55, Michael Kelley <mikelley@microsoft.com> wrote:
>
> With some CPU numbering schemes, the function select_idle_cpu() currently
> has a subtle bias to return the first hyper-thread in a core. As a result
> work is not evenly balanced across hyper-threads in a core. The difference
> is often as much as 15 to 20 percentage points -- i.e., the first
> hyper-thread might run at 45% load while the second hyper-thread runs at
> only 30% load or less.
>
> Two likely CPU numbering schemes make sense with today's typical case
> of two hyper-threads per core:
>
> A. Enumerate all the first hyper-theads in a core, then all the second
>    hyper-threads in a core.  If a system has 8 cores with 16 hyper-threads,
>    CPUs #0 and #8 are in the same core, as are CPUs #1 and #9, etc.
>
> B. Enumerate all hyper-threads in a core, then all hyper-threads in the
>    next core, etc.  Again with 8 cores and 16 hyper-threads, CPUs #0 and
>    #1 are in the same core, as are CPUs #2 and #3, etc.
>
> Scheme A is used in most ACPI bare metal systems and in VMs running on
> KVM.  The enumeration order is determined by the order of the processor
> entries in the ACPI MADT, and the ACPI spec *recommends* that the MADT
> be set up for scheme A.
>
> However, for reasons that pre-date the ACPI recommendation, Hyper-V
> guests have an ACPI MADT that is set up for scheme B.  When using scheme B,
> the subtle bias is evident in select_idle_cpu().  While having Hyper-V
> conform to the ACPI spec recommendation would solve the Hyper-V problem,
> it is also desirable for the fair scheduler code to be independent of the
> CPU numbering scheme.  ACPI is not always the firmware configuration
> mechanism, and CPU numbering schemes might vary more in architectures
> other than x86/x64.
>
> The bias occurs with scheme B when "has_idle_cpu" is true and

I assume that you mean has_idle_core as I can't find has_idle_cpu in the code

> select_idle_core() is called in the for_each_cpu_wrap() loop. Regardless
> of where the loop starts, it will almost immediately encountered a CPU
> that is the first hyper-thread in a core. If that core is idle, the CPU
> number of that first hyper-thread is returned. If that core is not idle,
> both hyper-threads are removed from the cpus mask, and the loop iterates
> to choose another CPU that is the first hyper-thread in a core.  As a
> result, select_idle_core() almost always returns the first hyper-thread
> in a core.
>
> The bias does not occur with scheme A because half of the CPU numbering
> space is a series of CPUs that are the second hyper-thread in all the
> cores. Assuming that the "target" CPU is evenly distributed throughout
> the CPU numbering space, there's a 50/50 chance of starting in the portion
> of the CPU numbering space that is all second hyper-threads.  If
> select_idle_core() finds a idle core, it will likely return a CPU that
> is the second hyper-thread in the core.  On average over the time,
> both the first and second hyper-thread are equally likely to be
> returned.
>
> Fix this bias by determining which hyper-thread in a core the "target"
> CPU is -- i.e., the "smt index" of that CPU.  Then when select_idle_core()
> finds an idle core, it returns the CPU in the core that has the same
> smt index. If that CPU is not valid to be chosen, just return the CPU
> that was passed into select_idle_core() and don't worry about bias.
>
> With scheme B, this fix solves the bias problem by making the chosen
> CPU be roughly equally likely to either hyper-thread.  With scheme A
> there's no real effect as the chosen CPU was already equally likely
> to be either hyper-thread, and still is.
>
> The imbalance in hyper-thread loading was originally observed in a
> customer workload, and then reproduced with a synthetic workload.
> The change has been tested with the synthetic workload in a Hyper-V VM
> running the normal scheme B CPU numbering, and then with the MADT
> replaced with a scheme A version using Linux's ability to override
> ACPI tables. The testing showed no change hyper-thread loading
> balance with the scheme A CPU numbering, but the imbalance is
> corrected if the CPU numbering is scheme B.

You failed to explain why it's important to evenly select 1st or 2nd
hyper-threads on the system.  I don't see any performance figures.
What would be the benefit ?

>
> Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> ---
>
> I haven't previously worked in Linux scheduler code, so I'm posting this
> as an RFC to point out the observed problem, and to suggest a solution.
> There may well be considerations in the design of a solution that I'm not
> aware of, so please educate me or suggest an alternative.
>
> It's also not completely clear whether an imbalance in hyper-thread
> loading is actually a problem. It looks weird, and causes customer
> concern when it is observed consistently across all cores in some
> production workload. The fair scheduler strives to balance load evenly, so
> I'm treating it as a problem that should be fixed, if for no other reason
> than general goodness. But again, I'm sure reviewers will feel free to
> tell me otherwise. :-) The fix takes relatively few CPU cycles, but it's
> still a non-zero cost.
>
> FWIW, the same imbalance has been observed with kernels as far back as
> 5.4, and the root cause in the code is essentially the same. So it's not
> a recently introduced issue. I haven't tried anything earlier than 5.4.
>
>  kernel/sched/fair.c | 36 ++++++++++++++++++++++++++++++------
>  1 file changed, 30 insertions(+), 6 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 373ff5f..8b56e9d 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6832,6 +6832,19 @@ static inline bool test_idle_cores(int cpu)
>         return false;
>  }
>
> +static inline int get_smt_index(int core)
> +{
> +       int cpu, n = 0;
> +
> +       for_each_cpu(cpu, cpu_smt_mask(core)) {
> +               if (cpu == core)
> +                       return n;
> +               n++;
> +       }
> +       /* If get here, cpu_smt_mask is set up incorrectly */
> +       return 0;
> +}
> +
>  /*
>   * Scans the local SMT mask to see if the entire core is idle, and records this
>   * information in sd_llc_shared->has_idle_cores.
> @@ -6866,10 +6879,11 @@ void __update_idle_core(struct rq *rq)
>   * there are no idle cores left in the system; tracked through
>   * sd_llc->shared->has_idle_cores and enabled through update_idle_core() above.
>   */
> -static int select_idle_core(struct task_struct *p, int core, struct cpumask *cpus, int *idle_cpu)
> +static int select_idle_core(struct task_struct *p, int core, int smt_index,
> +                           struct cpumask *cpus, int *idle_cpu)
>  {
>         bool idle = true;
> -       int cpu;
> +       int cpu, index_cpu, n = 0;
>
>         for_each_cpu(cpu, cpu_smt_mask(core)) {
>                 if (!available_idle_cpu(cpu)) {
> @@ -6885,10 +6899,13 @@ static int select_idle_core(struct task_struct *p, int core, struct cpumask *cpu
>                 }
>                 if (*idle_cpu == -1 && cpumask_test_cpu(cpu, p->cpus_ptr))
>                         *idle_cpu = cpu;
> +
> +               if (n++ == smt_index)
> +                       index_cpu = cpu;
>         }
>
>         if (idle)
> -               return core;
> +               return cpumask_test_cpu(index_cpu, p->cpus_ptr) ? index_cpu : core;
>
>         cpumask_andnot(cpus, cpus, cpu_smt_mask(core));
>         return -1;
> @@ -6922,7 +6939,13 @@ static inline bool test_idle_cores(int cpu)
>         return false;
>  }
>
> -static inline int select_idle_core(struct task_struct *p, int core, struct cpumask *cpus, int *idle_cpu)
> +static inline int get_smt_index(int core)
> +{
> +       return 0;
> +}
> +
> +static inline int select_idle_core(struct task_struct *p, int core, int smt_index,
> +                                  struct cpumask *cpus, int *idle_cpu)
>  {
>         return __select_idle_cpu(core, p);
>  }
> @@ -6942,7 +6965,7 @@ static inline int select_idle_smt(struct task_struct *p, int target)
>  static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool has_idle_core, int target)
>  {
>         struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_rq_mask);
> -       int i, cpu, idle_cpu = -1, nr = INT_MAX;
> +       int i, cpu, smt_index, idle_cpu = -1, nr = INT_MAX;
>         struct sched_domain_shared *sd_share;
>         struct rq *this_rq = this_rq();
>         int this = smp_processor_id();
> @@ -6994,9 +7017,10 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
>                 }
>         }
>
> +       smt_index = get_smt_index(target);
>         for_each_cpu_wrap(cpu, cpus, target + 1) {
>                 if (has_idle_core) {
> -                       i = select_idle_core(p, cpu, cpus, &idle_cpu);
> +                       i = select_idle_core(p, cpu, smt_index, cpus, &idle_cpu);
>                         if ((unsigned int)i < nr_cpumask_bits)
>                                 return i;
>
> --
> 1.8.3.1
>
