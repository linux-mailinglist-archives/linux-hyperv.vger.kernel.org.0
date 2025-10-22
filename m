Return-Path: <linux-hyperv+bounces-7310-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB887BFE4F1
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 Oct 2025 23:26:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 673883A1388
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 Oct 2025 21:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 085CF23E347;
	Wed, 22 Oct 2025 21:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="fYf8JgOc"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BAF4301027;
	Wed, 22 Oct 2025 21:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761168410; cv=none; b=Q0H8H+IVMOP6rw6FqqRrfGbb4oGKFwMWmMV87PHQIc7DutiX5jyZIdJ1viEbTuvhYWDGCXHgWK6zkzDzyf+zMyLRM4oTdSc/55QZo3DPdf7dvCEwuQ/x3X7OtHhkP7i0xe0JdJshNXqpkdUlf4h8T02mF5v0bKeh5JuXnC/lWio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761168410; c=relaxed/simple;
	bh=SIVIW/xQ/iG0XiC83GyeKshUAHOtpxIGBFFgzgykq8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QgNCGV5U3Uwqg9EP3bPiL40tpz8BdhxTMOA4/jWglfxwG7Q0xl+oicWk0ov5df4PMGo9e6QSI/o1C59u7A7rBbyuB3EK5nQTGGaZrYPSaB48StnonsMTY4PeaQ7q8GMA5KsZWhT7bqhCAZU/MJ2JWh380Gf03zonjNMggLIgzX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=fYf8JgOc; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1044)
	id E51522017251; Wed, 22 Oct 2025 14:26:48 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E51522017251
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1761168408;
	bh=Nt1/HJPB3SbmvroMGdrJtp5P/TY+266r9Db42FvhuNw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fYf8JgOcmn1KGdqaP+PDzh5Nd5nPZMlySQUCIvhdLWwpUcVJAuLr9q6P8G6zaxzHL
	 y4cr7hCcp+TfvmE/7VRf8TTvuDNNgGDwlRkwZg7zSwZ3Mdkj2amJtFrdKIYhc1FFmN
	 3IrcaFvngFgJOcSL0YSVPB5LOyMFptZHVbIkiIaU=
Date: Wed, 22 Oct 2025 14:26:48 -0700
From: Praveen Paladugu <prapal@linux.microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: "kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"arnd@arndb.de" <arnd@arndb.de>,
	"anbelski@linux.microsoft.com" <anbelski@linux.microsoft.com>,
	"easwar.hariharan@linux.microsoft.com" <easwar.hariharan@linux.microsoft.com>,
	"nunodasneves@linux.microsoft.com" <nunodasneves@linux.microsoft.com>,
	"skinsburskii@linux.microsoft.com" <skinsburskii@linux.microsoft.com>
Subject: Re: [PATCH v2 2/2] hyperv: Enable clean shutdown for root partition
 with MSHV
Message-ID: <20251022212648.GB17482@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20251014164150.6935-1-prapal@linux.microsoft.com>
 <20251014164150.6935-3-prapal@linux.microsoft.com>
 <SN6PR02MB4157FBBE5B77C65B024D3589D4E9A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20251020155939.GA17482@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <BN7PR02MB41485DB7E9B53B4CEDA596EAD4F5A@BN7PR02MB4148.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN7PR02MB41485DB7E9B53B4CEDA596EAD4F5A@BN7PR02MB4148.namprd02.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Mon, Oct 20, 2025 at 05:30:44PM +0000, Michael Kelley wrote:
> From: Praveen Paladugu <prapal@linux.microsoft.com> Sent: Monday, October 20, 2025 9:00 AM
> > 
> > On Thu, Oct 16, 2025 at 07:29:06PM +0000, Michael Kelley wrote:
> > > From: Praveen K Paladugu <prapal@linux.microsoft.com> Sent: Tuesday, October 14, 2025 9:41 AM
> > > >
> 
> [snip]
> 
> > > > +static int hv_call_enter_sleep_state(u32 sleep_state)
> > > > +{
> > > > +	u64 status;
> > > > +	int ret;
> > > > +	unsigned long flags;
> > > > +	struct hv_input_enter_sleep_state *in;
> > > > +
> > > > +	ret = hv_initialize_sleep_states();
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	local_irq_save(flags);
> > > > +	in = *this_cpu_ptr(hyperv_pcpu_input_arg);
> > > > +	in->sleep_state = sleep_state;
> > > > +
> > > > +	status = hv_do_hypercall(HVCALL_ENTER_SLEEP_STATE, in, NULL);
> > >
> > > If this hypercall succeeds, does the root partition (which is the caller) go
> > > to sleep in S5, such that the hypercall never returns? If that's not the case,
> > > what is the behavior of this hypercall?
> > >
> > This hypercall returns to the kernel when the CPU wakes up the next
> > time.
> 
> I must be missing something about the big picture, because "returns to
> the kernel when the CPU wakes up" doesn't fit my mental model of what's
> going on. I thought this function would be called, and the hypercall made,
> when Linux in the root partition is shutting down. So if a CPU makes this
> hypercall and goes to sleep, what wakes it up? And when it wakes up, is it
> still running the same Linux instance that was shutting down, or has it
> rebooted into new Linux instance? In the latter case, returning from
> the hypercall doesn't make sense.
> 
> Can you explain further how this all works?
>
Sorry for the confusion here. I mis-understood what happens while
entering the sleep state here. I will clarify below:

Sleep state S5 refers to shutdown/poweroff. Although other sleep states
are handled, they are not properly applied while running mshv on
servers. Non-S5 sleep states are only applied on non-server hosts.
This patch only handles S5 sleep state.

If a hypercall for non-S5 sleep state is invoked, the control
is returned back to the kernel. Usually non-S5 sleep state do things
like suspend to memory/hibernate etc.

If the hypecall is for S5 sleep state, then Hypervisor does poweroff the
host and the control does not return back to the kernel.


Now that is clarified, your previous comments about the order of the
reboot_notifiers is relevant now. I will investigate how to apply a
priority/order so that hv_reboot_notifier_handler will be called last.


Praveen

> Michael
> 
> > 
> > > > +	local_irq_restore(flags);
> > > > +
> > > > +	if (!hv_result_success(status)) {
> > > > +		hv_status_err(status, "\n");
> > > > +		return hv_result_to_errno(status);
> > > > +	}
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static int hv_reboot_notifier_handler(struct notifier_block *this,
> > > > +				      unsigned long code, void *another)
> > > > +{
> > > > +	int ret = 0;
> > > > +
> > > > +	if (code == SYS_HALT || code == SYS_POWER_OFF)
> > > > +		ret = hv_call_enter_sleep_state(HV_SLEEP_STATE_S5);
> > >
> > > If hv_call_enter_sleep_state() never returns, here's an issue. There may be
> > > multiple entries on the reboot notifier chain. For example,
> > > mshv_root_partition_init() puts an entry on the reboot notifier chain. At
> > > reboot time, the entries are executed in some order, with the expectation
> > > that all entries will be executed prior to the reboot actually happening. But
> > > if this hypercall never returns, some entries may never be executed.
> > >
> > > Notifier chains support a notion of priority to control the order in
> > > which they are executed, but that priority isn't set in hv_reboot_notifier
> > > below, or in mshv_reboot_nb. And most other reboot notifiers throughout
> > > Linux appear to not set it. So the ordering is unspecified, and having
> > > this notifier never return may be problematic.
> > >
> > Thanks for the detailed explanation Michael!
> > 
> > As I mentioned above, this hypercall returns to the kernel, so the rest
> > of the entries in the notifier chain should continue to execute.
> > 
> > > > +
> > > > +	return ret ? NOTIFY_DONE : NOTIFY_OK;
> > > > +}
> > > > +
> > > > +static struct notifier_block hv_reboot_notifier = {
> > > > +	.notifier_call  = hv_reboot_notifier_handler,
> > > > +};
> > > > +
> > > > +static int hv_acpi_sleep_handler(u8 sleep_state, u32 pm1a_cnt, u32 pm1b_cnt)
> > > > +{
> > > > +	int ret = 0;
> > > > +
> > > > +	if (sleep_state == ACPI_STATE_S5)
> > > > +		ret = hv_call_enter_sleep_state(HV_SLEEP_STATE_S5);
> > > > +
> > > > +	return ret == 0 ? 1 : -1;
> > > > +}
> > > > +
> > > > +static int hv_acpi_extended_sleep_handler(u8 sleep_state, u32 val_a, u32 val_b)
> > > > +{
> > > > +	return hv_acpi_sleep_handler(sleep_state, val_a, val_b);
> > > > +}
> > >
> > > Is this function needed? The function signature is identical to hv_acpi_sleep_handler().
> > > So it seems like acpi_os_set_prepare_extended_sleep() could just use
> > > hv_acpi_sleep_handler() directly.
> > >
> > Upon further investigation, I discovered that extended sleep is only
> > supported on platforms with ACPI_REDUCED_HARDWARE.
> > 
> > As these patches are targetted at X86, above does not really apply. I
> > will drop this handler in next version.
> > 
> > > > +
> > > > +int hv_sleep_notifiers_register(void)
> > > > +{
> > > > +	int ret;
> > > > +
> > > > +	acpi_os_set_prepare_sleep(&hv_acpi_sleep_handler);
> > > > +	acpi_os_set_prepare_extended_sleep(&hv_acpi_extended_sleep_handler);
> > >
> > > I'm not clear on why these handlers are set. If the hv_reboot_notifier is
> > > called, are these ACPI handlers ever called? Or are these to catch any cases
> > > where the hv_reboot_notifier is somehow bypassed? Or maybe I'm just
> > > not understanding something .... :-)
> > >
> > 
> > I am trying to trace these calls. I will keep you posted with my
> > findings.
> > 
> > > > +
> > > > +	ret = register_reboot_notifier(&hv_reboot_notifier);
> > > > +	if (ret)
> > > > +		pr_err("%s: cannot register reboot notifier %d\n",
> > > > +			__func__, ret);
> > > > +
> > > > +	return ret;
> > > > +}
> > > > +#endif
> > >
> > > I'm wondering if all this code belongs in hv_common.c, since it is only needed
> > > for Linux in the root partition. Couldn't it go in mshv_common.c? It would still
> > > be built-in code (i.e., not in a loadable module), but only if CONFIG_MSHV_ROOT
> > > is set.
> > >
> > 
> > This sounds reasonable. I will discuss this internally and get back you.
> > 
> > > Michael
> > >
> > > > --
> > > > 2.51.0
> > > >

