Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6B797247F2
	for <lists+linux-hyperv@lfdr.de>; Tue,  6 Jun 2023 17:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237805AbjFFPin (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 6 Jun 2023 11:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237218AbjFFPim (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 6 Jun 2023 11:38:42 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C6D10D4
        for <linux-hyperv@vger.kernel.org>; Tue,  6 Jun 2023 08:38:40 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-2562cc85d3dso5149960a91.1
        for <linux-hyperv@vger.kernel.org>; Tue, 06 Jun 2023 08:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686065920; x=1688657920;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6bWuVJmc/DDTWwmKbsA5m3bywn8QX7vtTpTGlwIsZWc=;
        b=n3ghXJBoPJVEMVO9coCXv6XYsMaird2JoIEEqmUrZn+0RFR9a097uyckNnXs/m9oGx
         idThQayhKYhIhz9pLzqsivul0grOITwK34RjKl77LLXKD41TP34RWKTZp/BAld5QkdCZ
         WodnV4RpgfPgpJscqgVbGm9W1qTj7057uB43SJMAM4MdIcn8Kxb2/pnTt2/P8VNAlQRP
         IT5LV7t42jjburRPxC0gTp114juAGD2q29L8pt35yZxS+h3w+QcTHBKfaCrvTtZCu68I
         7EkDT23A1EKlXvQqckC53IZWSdjugnvFI3V1rCQgPZk2x7gMw2lLi3VcgcpYzF+HZPS2
         qpYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686065920; x=1688657920;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6bWuVJmc/DDTWwmKbsA5m3bywn8QX7vtTpTGlwIsZWc=;
        b=krE0cdg1H42At39/dIfSea+oeZx3zstJe+YXR665vqbFKXd1ihVkKKHM81RcJr/Mhz
         uPf0GsoUuja6lxRFAZe5klsjE/l28Ltr+wySkAWYCaricDasRmV3uD2jztMFr7qnDDES
         r3RwhK7BeM2QkSWzAsZrCWjFC2rqb2RaYyCFLfRgU1nQRxFr+dHlm9pwgDHjz6WswSnN
         EpwQqPEkf85ibRS+j/EXzEcnu1nUF0rZa897SM79YkWa80IRI6A82okrSLC2/+L2Rkj3
         88SqhrYqh+ybNcwT4BY32Ls1uQXsDISxn5v9VQ2VTWsiT4RzQmzgpeeE9EagcrBCyqUt
         gH7w==
X-Gm-Message-State: AC+VfDzoJNE1HW1KcmacHShwuFcO5CFGUap7K2cL77aA2usaZpFh9giI
        6yYtGoe7WwQXJhCpoa84DBvKycYQGheEeMzlmHZpmw==
X-Google-Smtp-Source: ACHHUZ4jvSnGrPzzqquAcSuWHMnvfA2MdBe+y4cMuexCzq1/Usp85QxdpptqqIg/ST2kaj6FX8BzggofeM1Dfuwuoy8=
X-Received: by 2002:a17:90a:181:b0:255:d86c:baec with SMTP id
 1-20020a17090a018100b00255d86cbaecmr2215109pjc.46.1686065919875; Tue, 06 Jun
 2023 08:38:39 -0700 (PDT)
MIME-Version: 1.0
References: <1685555673-2363-1-git-send-email-mikelley@microsoft.com>
 <CAKfTPtAyFqG4W0OAc6pejKdEQ4yTRaoC+qiOZN8sRrwCENmVKA@mail.gmail.com> <BYAPR21MB1688C7D7309FEC2B01529C0FD752A@BYAPR21MB1688.namprd21.prod.outlook.com>
In-Reply-To: <BYAPR21MB1688C7D7309FEC2B01529C0FD752A@BYAPR21MB1688.namprd21.prod.outlook.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 6 Jun 2023 17:38:28 +0200
Message-ID: <CAKfTPtAeA1SxLD7VQ0sVc2G0AAKrNs9ZxoZPj2uR8x5DZQiomQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] sched/fair: Fix SMT balance dependency on CPU numbering
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc:     "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "bsegall@google.com" <bsegall@google.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "bristot@redhat.com" <bristot@redhat.com>,
        "vschneid@redhat.com" <vschneid@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, 6 Jun 2023 at 16:08, Michael Kelley (LINUX)
<mikelley@microsoft.com> wrote:
>
> From: Vincent Guittot <vincent.guittot@linaro.org> Sent: Monday, June 5, 2023 2:31 AM
> >
> > Hi Michael,
> >
> > On Wed, 31 May 2023 at 19:55, Michael Kelley <mikelley@microsoft.com> wrote:
> > >
> > > With some CPU numbering schemes, the function select_idle_cpu() currently
> > > has a subtle bias to return the first hyper-thread in a core. As a result
> > > work is not evenly balanced across hyper-threads in a core. The difference
> > > is often as much as 15 to 20 percentage points -- i.e., the first
> > > hyper-thread might run at 45% load while the second hyper-thread runs at
> > > only 30% load or less.
> > >
> > > Two likely CPU numbering schemes make sense with today's typical case
> > > of two hyper-threads per core:
> > >
> > > A. Enumerate all the first hyper-theads in a core, then all the second
> > >    hyper-threads in a core.  If a system has 8 cores with 16 hyper-threads,
> > >    CPUs #0 and #8 are in the same core, as are CPUs #1 and #9, etc.
> > >
> > > B. Enumerate all hyper-threads in a core, then all hyper-threads in the
> > >    next core, etc.  Again with 8 cores and 16 hyper-threads, CPUs #0 and
> > >    #1 are in the same core, as are CPUs #2 and #3, etc.
> > >
> > > Scheme A is used in most ACPI bare metal systems and in VMs running on
> > > KVM.  The enumeration order is determined by the order of the processor
> > > entries in the ACPI MADT, and the ACPI spec *recommends* that the MADT
> > > be set up for scheme A.
> > >
> > > However, for reasons that pre-date the ACPI recommendation, Hyper-V
> > > guests have an ACPI MADT that is set up for scheme B.  When using scheme B,
> > > the subtle bias is evident in select_idle_cpu().  While having Hyper-V
> > > conform to the ACPI spec recommendation would solve the Hyper-V problem,
> > > it is also desirable for the fair scheduler code to be independent of the
> > > CPU numbering scheme.  ACPI is not always the firmware configuration
> > > mechanism, and CPU numbering schemes might vary more in architectures
> > > other than x86/x64.
> > >
> > > The bias occurs with scheme B when "has_idle_cpu" is true and
> >
> > I assume that you mean has_idle_core as I can't find has_idle_cpu in the code
>
> Yes.  You are right.
>
> >
> > > select_idle_core() is called in the for_each_cpu_wrap() loop. Regardless
> > > of where the loop starts, it will almost immediately encountered a CPU
> > > that is the first hyper-thread in a core. If that core is idle, the CPU
> > > number of that first hyper-thread is returned. If that core is not idle,
> > > both hyper-threads are removed from the cpus mask, and the loop iterates
> > > to choose another CPU that is the first hyper-thread in a core.  As a
> > > result, select_idle_core() almost always returns the first hyper-thread
> > > in a core.
> > >
> > > The bias does not occur with scheme A because half of the CPU numbering
> > > space is a series of CPUs that are the second hyper-thread in all the
> > > cores. Assuming that the "target" CPU is evenly distributed throughout
> > > the CPU numbering space, there's a 50/50 chance of starting in the portion
> > > of the CPU numbering space that is all second hyper-threads.  If
> > > select_idle_core() finds a idle core, it will likely return a CPU that
> > > is the second hyper-thread in the core.  On average over the time,
> > > both the first and second hyper-thread are equally likely to be
> > > returned.
> > >
> > > Fix this bias by determining which hyper-thread in a core the "target"
> > > CPU is -- i.e., the "smt index" of that CPU.  Then when select_idle_core()
> > > finds an idle core, it returns the CPU in the core that has the same
> > > smt index. If that CPU is not valid to be chosen, just return the CPU
> > > that was passed into select_idle_core() and don't worry about bias.
> > >
> > > With scheme B, this fix solves the bias problem by making the chosen
> > > CPU be roughly equally likely to either hyper-thread.  With scheme A
> > > there's no real effect as the chosen CPU was already equally likely
> > > to be either hyper-thread, and still is.
> > >
> > > The imbalance in hyper-thread loading was originally observed in a
> > > customer workload, and then reproduced with a synthetic workload.
> > > The change has been tested with the synthetic workload in a Hyper-V VM
> > > running the normal scheme B CPU numbering, and then with the MADT
> > > replaced with a scheme A version using Linux's ability to override
> > > ACPI tables. The testing showed no change hyper-thread loading
> > > balance with the scheme A CPU numbering, but the imbalance is
> > > corrected if the CPU numbering is scheme B.
> >
> > You failed to explain why it's important to evenly select 1st or 2nd
> > hyper-threads on the system.  I don't see any performance figures.
> > What would be the benefit ?
>
> As I noted below, it's not completely clear to me whether this is a
> problem.  I don't have a specific workload where overall runtime is
> longer due to the SMT level imbalance.  I'm not a scheduler expert,
> and wanted input from those who are.  Linux generally does a good
> job of balancing load, and given the code in fair.c that is devoted to
> balancing, I inferred at least some importance.  But maybe balancing
> is more important for the higher-level domains, and less so for the
> SMT domain.

As long as the hyper-threads on a core are the same, I don't see any
need to add more code and complexity to evenly balance the number of
time that we select each CPU of the same core when the whole core is
idle.

>
> From a slightly different perspective, sysadmins are accustomed
> to 'htop' or whatever tools showing balanced load.  This is a case
> where the load is persistently unbalanced, and as such it drew
> attention.  And at a slightly theoretical level, it *is* interesting that
> the CPU numbering scheme affects the outcome of scheduler
> decisions in a noticeable way.
>
> But if the sense is that an SMT-level imbalance really doesn't affect
> anything, we'll live with CPU numbering scheme B being a bit of an
> anomaly.  When necessary, we can explain that it doesn't have any
> negative effects.
>
> Michael
>
> >
> > >
> > > Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> > > ---
> > >
> > > I haven't previously worked in Linux scheduler code, so I'm posting this
> > > as an RFC to point out the observed problem, and to suggest a solution.
> > > There may well be considerations in the design of a solution that I'm not
> > > aware of, so please educate me or suggest an alternative.
> > >
> > > It's also not completely clear whether an imbalance in hyper-thread
> > > loading is actually a problem. It looks weird, and causes customer
> > > concern when it is observed consistently across all cores in some
> > > production workload. The fair scheduler strives to balance load evenly, so
> > > I'm treating it as a problem that should be fixed, if for no other reason
> > > than general goodness. But again, I'm sure reviewers will feel free to
> > > tell me otherwise. :-) The fix takes relatively few CPU cycles, but it's
> > > still a non-zero cost.
> > >
> > > FWIW, the same imbalance has been observed with kernels as far back as
> > > 5.4, and the root cause in the code is essentially the same. So it's not
> > > a recently introduced issue. I haven't tried anything earlier than 5.4.
> > >
> > >  kernel/sched/fair.c | 36 ++++++++++++++++++++++++++++++------
> > >  1 file changed, 30 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index 373ff5f..8b56e9d 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -6832,6 +6832,19 @@ static inline bool test_idle_cores(int cpu)
> > >         return false;
> > >  }
> > >
> > > +static inline int get_smt_index(int core)
> > > +{
> > > +       int cpu, n = 0;
> > > +
> > > +       for_each_cpu(cpu, cpu_smt_mask(core)) {
> > > +               if (cpu == core)
> > > +                       return n;
> > > +               n++;
> > > +       }
> > > +       /* If get here, cpu_smt_mask is set up incorrectly */
> > > +       return 0;
> > > +}
> > > +
> > >  /*
> > >   * Scans the local SMT mask to see if the entire core is idle, and records this
> > >   * information in sd_llc_shared->has_idle_cores.
> > > @@ -6866,10 +6879,11 @@ void __update_idle_core(struct rq *rq)
> > >   * there are no idle cores left in the system; tracked through
> > >   * sd_llc->shared->has_idle_cores and enabled through update_idle_core() above.
> > >   */
> > > -static int select_idle_core(struct task_struct *p, int core, struct cpumask *cpus, int
> > *idle_cpu)
> > > +static int select_idle_core(struct task_struct *p, int core, int smt_index,
> > > +                           struct cpumask *cpus, int *idle_cpu)
> > >  {
> > >         bool idle = true;
> > > -       int cpu;
> > > +       int cpu, index_cpu, n = 0;
> > >
> > >         for_each_cpu(cpu, cpu_smt_mask(core)) {
> > >                 if (!available_idle_cpu(cpu)) {
> > > @@ -6885,10 +6899,13 @@ static int select_idle_core(struct task_struct *p, int core,
> > struct cpumask *cpu
> > >                 }
> > >                 if (*idle_cpu == -1 && cpumask_test_cpu(cpu, p->cpus_ptr))
> > >                         *idle_cpu = cpu;
> > > +
> > > +               if (n++ == smt_index)
> > > +                       index_cpu = cpu;
> > >         }
> > >
> > >         if (idle)
> > > -               return core;
> > > +               return cpumask_test_cpu(index_cpu, p->cpus_ptr) ? index_cpu : core;
> > >
> > >         cpumask_andnot(cpus, cpus, cpu_smt_mask(core));
> > >         return -1;
> > > @@ -6922,7 +6939,13 @@ static inline bool test_idle_cores(int cpu)
> > >         return false;
> > >  }
> > >
> > > -static inline int select_idle_core(struct task_struct *p, int core, struct cpumask *cpus,
> > int *idle_cpu)
> > > +static inline int get_smt_index(int core)
> > > +{
> > > +       return 0;
> > > +}
> > > +
> > > +static inline int select_idle_core(struct task_struct *p, int core, int smt_index,
> > > +                                  struct cpumask *cpus, int *idle_cpu)
> > >  {
> > >         return __select_idle_cpu(core, p);
> > >  }
> > > @@ -6942,7 +6965,7 @@ static inline int select_idle_smt(struct task_struct *p, int
> > target)
> > >  static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
> > has_idle_core, int target)
> > >  {
> > >         struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_rq_mask);
> > > -       int i, cpu, idle_cpu = -1, nr = INT_MAX;
> > > +       int i, cpu, smt_index, idle_cpu = -1, nr = INT_MAX;
> > >         struct sched_domain_shared *sd_share;
> > >         struct rq *this_rq = this_rq();
> > >         int this = smp_processor_id();
> > > @@ -6994,9 +7017,10 @@ static int select_idle_cpu(struct task_struct *p, struct
> > sched_domain *sd, bool
> > >                 }
> > >         }
> > >
> > > +       smt_index = get_smt_index(target);
> > >         for_each_cpu_wrap(cpu, cpus, target + 1) {
> > >                 if (has_idle_core) {
> > > -                       i = select_idle_core(p, cpu, cpus, &idle_cpu);
> > > +                       i = select_idle_core(p, cpu, smt_index, cpus, &idle_cpu);
> > >                         if ((unsigned int)i < nr_cpumask_bits)
> > >                                 return i;
> > >
> > > --
> > > 1.8.3.1
> > >
