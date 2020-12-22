Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44C452E0AF5
	for <lists+linux-hyperv@lfdr.de>; Tue, 22 Dec 2020 14:42:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbgLVNkp (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 22 Dec 2020 08:40:45 -0500
Received: from foss.arm.com ([217.140.110.172]:36054 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726860AbgLVNkp (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 22 Dec 2020 08:40:45 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B7FFF1FB;
        Tue, 22 Dec 2020 05:39:59 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D56243F6CF;
        Tue, 22 Dec 2020 05:39:57 -0800 (PST)
References: <MW4PR21MB1857BF96E59E75EF9CE406E2BFDF9@MW4PR21MB1857.namprd21.prod.outlook.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     "mingo\@redhat.com" <mingo@redhat.com>,
        "peterz\@infradead.org" <peterz@infradead.org>,
        "juri.lelli\@redhat.com" <juri.lelli@redhat.com>,
        "vincent.guittot\@linaro.org" <vincent.guittot@linaro.org>,
        "dietmar.eggemann\@arm.com" <dietmar.eggemann@arm.com>,
        "rostedt\@goodmis.org" <rostedt@goodmis.org>,
        "bsegall\@google.com" <bsegall@google.com>,
        "mgorman\@suse.de" <mgorman@suse.de>,
        "bristot\@redhat.com" <bristot@redhat.com>,
        "x86\@kernel.org" <x86@kernel.org>,
        "linux-pm\@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv\@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
Subject: Re: v5.10: sched_cpu_dying() hits BUG_ON during hibernation: kernel BUG at kernel/sched/core.c:7596!
In-reply-to: <MW4PR21MB1857BF96E59E75EF9CE406E2BFDF9@MW4PR21MB1857.namprd21.prod.outlook.com>
Date:   Tue, 22 Dec 2020 13:39:53 +0000
Message-ID: <jhjlfdqrmc6.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org


Hi,

On 22/12/20 09:13, Dexuan Cui wrote:
> Hi,
> I'm running a Linux VM with the recent mainline (48342fc07272, 12/20/2020) on Hyper-V.
> When I test hibernation, the VM can easily hit the below BUG_ON during the resume
> procedure (I estimate this can repro about 1/5 of the time). BTW, my VM has 40 vCPUs.
>
> I can't repro the BUG_ON with v5.9.0, so I suspect something in v5.10.0 may be broken?
>
> In v5.10.0, when the BUG_ON happens, rq->nr_running==2, and rq->nr_pinned==0:
>
> 7587 int sched_cpu_dying(unsigned int cpu)
> 7588 {
> 7589         struct rq *rq = cpu_rq(cpu);
> 7590         struct rq_flags rf;
> 7591
> 7592         /* Handle pending wakeups and then migrate everything off */
> 7593         sched_tick_stop(cpu);
> 7594
> 7595         rq_lock_irqsave(rq, &rf);
> 7596         BUG_ON(rq->nr_running != 1 || rq_has_pinned_tasks(rq));
> 7597         rq_unlock_irqrestore(rq, &rf);
> 7598
> 7599         calc_load_migrate(rq);
> 7600         update_max_interval();
> 7601         nohz_balance_exit_idle(rq);
> 7602         hrtick_clear(rq);
> 7603         return 0;
> 7604 }
>
> The last commit that touches the BUG_ON line is the commit
> 3015ef4b98f5 ("sched/core: Make migrate disable and CPU hotplug cooperative")
> but the commit looks good to me.
>
> Any idea?
>

I'd wager this extra task is a kworker; could you give this series a try?

  https://lore.kernel.org/r/20201218170919.2950-1-jiangshanlai@gmail.com

> Thanks,
> -- Dexuan
