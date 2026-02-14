Return-Path: <linux-hyperv+bounces-8854-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id nGuKIRz4j2nAUgEAu9opvQ
	(envelope-from <linux-hyperv+bounces-8854-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 14 Feb 2026 05:20:44 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8F813AFC8
	for <lists+linux-hyperv@lfdr.de>; Sat, 14 Feb 2026 05:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6A7DC300F18A
	for <lists+linux-hyperv@lfdr.de>; Sat, 14 Feb 2026 04:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B981A9F83;
	Sat, 14 Feb 2026 04:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="pwtLpla6"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E8B7404E;
	Sat, 14 Feb 2026 04:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771042839; cv=none; b=LBjXKyR2S/vZ4sY6ho+D9QNnI8M7X5wVfACg4rHCMXzOW15R+ts29wfEqAp3Lwoyy+lIy3Jpti7gFzM4CyNd32Bvy/6z1vwlEuwVRQu/2WEqtHQkSpYMkr9QiuIPq6cPLPmKGJrhJMxgb5UEf4El0aY8S2PmAzz6q7GaNPurSAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771042839; c=relaxed/simple;
	bh=vbZPXHEIbaeYf+uNDqTHtOtanbVLITH9uqI//cTf8g4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Da1IyrfiKCfWHymiaJ7n9IZC9w34c8kLjf/hgXspUcXARyFlcAxuMIY8pULfXbH5m9Yt2fZLAgfQvlaTrXm3ak1DA5gqc3x30/5z3wmHPDetoXEgblTJnIqOIHpDnrdL5wIyw2J+V3txN90nwOY9JYAvvW4DDRGOwmyclYGvmNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=pwtLpla6; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id D428E20B7165; Fri, 13 Feb 2026 20:20:31 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D428E20B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1771042831;
	bh=RaW2vb+rgvWwAfyCr/kgXU+67UJKyz/Fo0LKfWqOF+w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pwtLpla6BwucSYYOOhsHz4Eiduh1ASYRzdCBTX2ItAiAW02/0vq+Tr4MpbA3WWDQL
	 gtwF7du70QGmZbcvx+ub0XkhHAmRmAR6K1DgsI21ZI8kyOV0aciD7PCyIuohahIawq
	 H/TnJdBbsQN4m2NefgIjk8aq7Lezum0ykP1D6WNE=
Date: Fri, 13 Feb 2026 20:20:31 -0800
From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	Florian Bezdeka <florian.bezdeka@siemens.com>,
	RT <linux-rt-users@vger.kernel.org>,
	Mitchell Levy <levymitchell0@gmail.com>,
	Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v2] x86: mshyperv: Use kthread for vmbus interrupts on
 PREEMPT_RT
Message-ID: <aY/4D/JVu7TjNOku@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <514e068c-1b85-4e39-8388-c1d2b106b4e9@siemens.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <514e068c-1b85-4e39-8388-c1d2b106b4e9@siemens.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8854-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,redhat.com,alien8.de,linux.intel.com,vger.kernel.org,siemens.com,gmail.com,outlook.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ssengar@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,siemens.com:email,linux.microsoft.com:dkim,linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net:mid]
X-Rspamd-Queue-Id: DD8F813AFC8
X-Rspamd-Action: no action

On Fri, Feb 06, 2026 at 07:47:54AM +0100, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Resolves the following lockdep report when booting PREEMPT_RT on Hyper-V
> with related guest support enabled:
> 
> [    1.127941] hv_vmbus: registering driver hyperv_drm
> 
> [    1.132518] =============================
> [    1.132519] [ BUG: Invalid wait context ]
> [    1.132521] 6.19.0-rc8+ #9 Not tainted
> [    1.132524] -----------------------------
> [    1.132525] swapper/0/0 is trying to lock:
> [    1.132526] ffff8b9381bb3c90 (&channel->sched_lock){....}-{3:3}, at: vmbus_chan_sched+0xc4/0x2b0
> [    1.132543] other info that might help us debug this:
> [    1.132544] context-{2:2}
> [    1.132545] 1 lock held by swapper/0/0:
> [    1.132547]  #0: ffffffffa010c4c0 (rcu_read_lock){....}-{1:3}, at: vmbus_chan_sched+0x31/0x2b0
> [    1.132557] stack backtrace:
> [    1.132560] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.19.0-rc8+ #9 PREEMPT_{RT,(lazy)}
> [    1.132565] Hardware name: Microsoft Corporation Virtual Machine/Virtual Machine, BIOS Hyper-V UEFI Release v4.1 09/25/2025
> [    1.132567] Call Trace:
> [    1.132570]  <IRQ>
> [    1.132573]  dump_stack_lvl+0x6e/0xa0
> [    1.132581]  __lock_acquire+0xee0/0x21b0
> [    1.132592]  lock_acquire+0xd5/0x2d0
> [    1.132598]  ? vmbus_chan_sched+0xc4/0x2b0
> [    1.132606]  ? lock_acquire+0xd5/0x2d0
> [    1.132613]  ? vmbus_chan_sched+0x31/0x2b0
> [    1.132619]  rt_spin_lock+0x3f/0x1f0
> [    1.132623]  ? vmbus_chan_sched+0xc4/0x2b0
> [    1.132629]  ? vmbus_chan_sched+0x31/0x2b0
> [    1.132634]  vmbus_chan_sched+0xc4/0x2b0
> [    1.132641]  vmbus_isr+0x2c/0x150
> [    1.132648]  __sysvec_hyperv_callback+0x5f/0xa0
> [    1.132654]  sysvec_hyperv_callback+0x88/0xb0
> [    1.132658]  </IRQ>
> [    1.132659]  <TASK>
> [    1.132660]  asm_sysvec_hyperv_callback+0x1a/0x20
> 
> As code paths that handle vmbus IRQs use sleepy locks under PREEMPT_RT,
> the complete vmbus_handler execution needs to be moved into thread
> context. Open-coding this allows to skip the IPI that irq_work would
> additionally bring and which we do not need, being an IRQ, never an NMI.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>

First I would like to share my opinion that, although support for the
RT kernel is not on the near-term roadmap, we should welcome RT Linux
patches.

Coming back to this patch I can reproduce the stack trace referenced
in the commit when running with PREEMPT_RT enabled, and I have verified
that this patch resolves the issue. Next, I observed the storage-related
stack trace mentioned in Jan’s other patch; applying the storvsc patch
fixed that as well.

However, when testing without PREEMPT_RT enabled, I see a another lockdep
warning below (both with and without Jan’s patches). IWanted to check if
is it possible to address this issue as part of the same fix ?
Doing so would make the change more useful beyond PREEMPT_RT.


> ---
> 
> Changes in v2:
>  - reorder vmbus_irq_pending clearing to fix a race condition
> 
>  arch/x86/kernel/cpu/mshyperv.c | 52 ++++++++++++++++++++++++++++++++--
>  1 file changed, 50 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> index 579fb2c64cfd..b39cb983326a 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -17,6 +17,7 @@
>  #include <linux/irq.h>
>  #include <linux/kexec.h>
>  #include <linux/random.h>
> +#include <linux/smpboot.h>
>  #include <asm/processor.h>
>  #include <asm/hypervisor.h>
>  #include <hyperv/hvhdk.h>
> @@ -150,6 +151,43 @@ static void (*hv_stimer0_handler)(void);
>  static void (*hv_kexec_handler)(void);
>  static void (*hv_crash_handler)(struct pt_regs *regs);
>  
> +static DEFINE_PER_CPU(bool, vmbus_irq_pending);
> +static DEFINE_PER_CPU(struct task_struct *, vmbus_irqd);
> +
> +static void vmbus_irqd_wake(void)
> +{
> +	struct task_struct *tsk = __this_cpu_read(vmbus_irqd);
> +
> +	__this_cpu_write(vmbus_irq_pending, true);
> +	wake_up_process(tsk);
> +}
> +
> +static void vmbus_irqd_setup(unsigned int cpu)
> +{
> +	sched_set_fifo(current);
> +}
> +
> +static int vmbus_irqd_should_run(unsigned int cpu)
> +{
> +	return __this_cpu_read(vmbus_irq_pending);
> +}
> +
> +static void run_vmbus_irqd(unsigned int cpu)
> +{
> +	__this_cpu_write(vmbus_irq_pending, false);
> +	vmbus_handler();
> +}
> +
> +static bool vmbus_irq_initialized;
> +
> +static struct smp_hotplug_thread vmbus_irq_threads = {
> +	.store                  = &vmbus_irqd,
> +	.setup			= vmbus_irqd_setup,
> +	.thread_should_run      = vmbus_irqd_should_run,
> +	.thread_fn              = run_vmbus_irqd,
> +	.thread_comm            = "vmbus_irq/%u",
> +};
> +
>  DEFINE_IDTENTRY_SYSVEC(sysvec_hyperv_callback)
>  {
>  	struct pt_regs *old_regs = set_irq_regs(regs);
> @@ -158,8 +196,12 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_hyperv_callback)
>  	if (mshv_handler)
>  		mshv_handler();
>  
> -	if (vmbus_handler)
> -		vmbus_handler();
> +	if (vmbus_handler) {
> +		if (IS_ENABLED(CONFIG_PREEMPT_RT))
> +			vmbus_irqd_wake();
> +		else
> +			vmbus_handler();
> +	}
>  
>  	if (ms_hyperv.hints & HV_DEPRECATING_AEOI_RECOMMENDED)
>  		apic_eoi();
> @@ -174,6 +216,10 @@ void hv_setup_mshv_handler(void (*handler)(void))
>  
>  void hv_setup_vmbus_handler(void (*handler)(void))
>  {
> +	if (IS_ENABLED(CONFIG_PREEMPT_RT) && !vmbus_irq_initialized) {
> +		BUG_ON(smpboot_register_percpu_thread(&vmbus_irq_threads));
> +		vmbus_irq_initialized = true;
> +	}
>  	vmbus_handler = handler;
>  }
>  
> @@ -181,6 +227,8 @@ void hv_remove_vmbus_handler(void)
>  {
>  	/* We have no way to deallocate the interrupt gate */
>  	vmbus_handler = NULL;
> +	smpboot_unregister_percpu_thread(&vmbus_irq_threads);

Do we want to safeguard this call only when vmbus_irq_initialized=true ?

- Saurabh

> +	vmbus_irq_initialized = false;
>  }
>  
>  /*
> -- 
> 2.51.0

