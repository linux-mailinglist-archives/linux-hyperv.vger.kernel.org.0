Return-Path: <linux-hyperv+bounces-9363-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6P78EfXysmmLRAAAu9opvQ
	(envelope-from <linux-hyperv+bounces-9363-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Mar 2026 18:08:05 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C0127661E
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Mar 2026 18:08:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6C1D23024BF6
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Mar 2026 17:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD363F880D;
	Thu, 12 Mar 2026 17:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xmgE/dq5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DwCajENJ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3983E5ED3;
	Thu, 12 Mar 2026 17:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773335249; cv=none; b=arSsc8poOr0B/rGNrNDHEE6TgJFyyWjB7x+XzyOK/bGTkA0PZ7Ki+0y/5wTO7YF0inwRZrihAsEX1cUfjzM4irR5/zuwaD2zR94le5xtVXB6IbIydQJxegqa9t24OlVzqhZ6mVCcgHh4uXqwo/ZSJrMIUoD1emcJAXlplL3BKc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773335249; c=relaxed/simple;
	bh=eZazRVC6d4oK6n6COPCIcrTG4yO6IkhYKg7U9Zroku4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XOtmL4rHh10nBO6aMYjQWHwHxOC5jJGWcnQEtVXoVFMDptuguiEE7QA46xvBJIiY15M0AijpAWk1/hFa+7sapJ5LfvDZgwxhg5zIgRrwZYnrFWmv31QqHGp40hf2KNkx0CXcjdGwbU9NfC1chcYdfIS5x3BiO5A0DvikTIqVRsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xmgE/dq5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DwCajENJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 12 Mar 2026 18:07:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1773335237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bBxTNXIXuY6/KegSzNP2na1HchD8Mkr04ufxqrO9lIM=;
	b=xmgE/dq5gz1N5u22a/IZId/uaaFPPVTl1acjdd2j5SCqg9jelXlYe/f56GTQe5AyslM8UG
	759rC6SYIJOcmgnVm3u9Sacaoo4zAP0zQBanwWagI7fRSJhnk0wTIinFZVtyXa48j4Ein2
	mqjf/ljexh8Pym8X8jssVFQkxcbQqCRs5AbyKwSsau2EJLPwhi2HYuOHtThAcpidiONXN+
	4ObJ/bE5VYR73wUJ/vpX5tueArbtYVtkOYBVuJh7l/woifUcA8Gf8q9ye53/SICi05tctb
	WIC1zZqB5MezylHH5aCvilbuX/bH2pLIeLnLjRu+vJqHQYjh5oQqqmVWGxfgCw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1773335237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bBxTNXIXuY6/KegSzNP2na1HchD8Mkr04ufxqrO9lIM=;
	b=DwCajENJ2uoSdVO7yQZJZp7+ZbGw+P2UU4O7laCHPkBD+Pno4rb9FnG5DMsrSP4uoQE6o1
	ciFLtWyldeiBXHCA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
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
	Michael Kelley <mhklinux@outlook.com>,
	Saurabh Singh Sengar <ssengar@linux.microsoft.com>,
	Naman Jain <namjain@linux.microsoft.com>
Subject: Re: [PATCH v3] drivers: hv: vmbus: Use kthread for vmbus interrupts
 on PREEMPT_RT
Message-ID: <20260312170715.HA08BHiO@linutronix.de>
References: <289d8e52-40f8-4b22-8aa9-d0bd3bd15aae@siemens.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <289d8e52-40f8-4b22-8aa9-d0bd3bd15aae@siemens.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9363-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,redhat.com,alien8.de,linux.intel.com,vger.kernel.org,siemens.com,gmail.com,outlook.com,linux.microsoft.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 49C0127661E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-02-16 17:24:56 [+0100], Jan Kiszka wrote:
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -25,6 +25,7 @@
>  #include <linux/cpu.h>
>  #include <linux/sched/isolation.h>
>  #include <linux/sched/task_stack.h>
> +#include <linux/smpboot.h>
> =20
>  #include <linux/delay.h>
>  #include <linux/panic_notifier.h>
> @@ -1350,7 +1351,7 @@ static void vmbus_message_sched(struct hv_per_cpu_c=
ontext *hv_cpu, void *message
>  	}
>  }
> =20
> -void vmbus_isr(void)
> +static void __vmbus_isr(void)
>  {
>  	struct hv_per_cpu_context *hv_cpu
>  		=3D this_cpu_ptr(hv_context.cpu_context);
> @@ -1363,6 +1364,53 @@ void vmbus_isr(void)
> =20
>  	add_interrupt_randomness(vmbus_interrupt);

This is feeding entropy and would like to see interrupt registers. But
since this is invoked from a thread it won't.

>  }
> +
=E2=80=A6
> +void vmbus_isr(void)
> +{
> +	if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
> +		vmbus_irqd_wake();
> +	} else {
> +		lockdep_hardirq_threaded();

What clears this? This is wrongly placed. This should go to
sysvec_hyperv_callback() instead with its matching canceling part. The
add_interrupt_randomness() should also be there and not here.
sysvec_hyperv_stimer0() managed to do so.

Different question: What guarantees that there won't be another
interrupt before this one is done? The handshake appears to be
deprecated. The interrupt itself returns ACKing (or not) but the actual
handler is delayed to this thread. Depending on the userland it could
take some time and I don't know how impatient the host is.

> +		__vmbus_isr();
Moving on. This (trying very hard here) even schedules tasklets. Why?
You need to disable BH before doing so. Otherwise it ends in ksoftirqd.
You don't want that.

Couldn't the whole logic be integrated into the IRQ code? Then we could
have mask/ unmask if supported/ provided and threaded interrupts. Then
sysvec_hyperv_reenlightenment() could use a proper threaded interrupt
instead apic_eoi() + schedule_delayed_work().=20

> +	}
> +}
>  EXPORT_SYMBOL_FOR_MODULES(vmbus_isr, "mshv_vtl");
> =20
>  static irqreturn_t vmbus_percpu_isr(int irq, void *dev_id)

Sebastian

