Return-Path: <linux-hyperv+bounces-8617-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SGu3Nej/fGnLPgIAu9opvQ
	(envelope-from <linux-hyperv+bounces-8617-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 30 Jan 2026 20:00:56 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 780E2BE097
	for <lists+linux-hyperv@lfdr.de>; Fri, 30 Jan 2026 20:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C62883008C2A
	for <lists+linux-hyperv@lfdr.de>; Fri, 30 Jan 2026 19:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C839D2737F2;
	Fri, 30 Jan 2026 19:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="hfd3C1mr"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602EA25C809;
	Fri, 30 Jan 2026 19:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769799654; cv=none; b=WR2I0XnVb/Z1Dcb0lOKqEQJ8OedFkfO7BfBkNa/ypoo5OZUdcqCF6zfLesIAXdvXntu2MM57TyOMfGBdD0Z3gq35I+wBoKoe/7L4Vx3ex4R34X7WgS3gZ39PSWyn//72DrnK9IWOeI98jxMUadHMhwcxaP8fylnIdcr5PNyMxXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769799654; c=relaxed/simple;
	bh=hP0a0oTmN4ARa1gblC0ebkuQ7c2vkZq6ntSJHw3jwbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qG/WTy2zKSn+ScLzVAjbnrYG4V/2B4rOSg29qhxS5WBDrNo3OxUaQK2hnnHX8lBT0YfIf+vvKIRFCQt+IRT9x3zEPUapK5VNWjSJNorupUSD0+T9NKXiWDxwS78N1Z8OtTsKk++XPVDxlZsXvSgQx8c0M906OpTKauHsKL+w4R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=hfd3C1mr; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (unknown [20.236.11.69])
	by linux.microsoft.com (Postfix) with ESMTPSA id BADAA20B7167;
	Fri, 30 Jan 2026 11:00:52 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BADAA20B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1769799652;
	bh=pm+3t3TXUqsXjhxksRDqyCfq2BohBadSWbHMKpeJcYw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hfd3C1mr+oxvm3qig9wrf3jIOO2FrdBq8KEEw/KwyAHMk7IgWUzEhPgxzfo5EgMX1
	 SPMk694GK6dQ2Rqj/nD7MlwqFrVzasEQERcbJXyLVRcbCJNTpysqIxVHUcJdNECIs5
	 O4Lm1HAik7T0afv/qGE+DVWPWMGNqwExoGd5t4XI=
Date: Fri, 30 Jan 2026 11:00:51 -0800
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Anirudh Rayabharam <anirudh@anirudhrb.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mshv: add arm64 support for doorbell & intercept
 SINTs
Message-ID: <aXz_4yWC6Jofqygj@skinsburskii.localdomain>
References: <20260128160437.3342167-1-anirudh@anirudhrb.com>
 <20260128160437.3342167-3-anirudh@anirudhrb.com>
 <aXqV127NzazbDkau@skinsburskii.localdomain>
 <aXrj4-KAxYfuK7k0@anirudh-surface.localdomain>
 <aXuS-ogiBX2Z3Gnf@skinsburskii.localdomain>
 <aXzltmZVDhYIDiaw@anirudh-surface.localdomain>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aXzltmZVDhYIDiaw@anirudh-surface.localdomain>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8617-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,anirudhrb.com:email,linux.microsoft.com:dkim]
X-Rspamd-Queue-Id: 780E2BE097
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 05:09:10PM +0000, Anirudh Rayabharam wrote:
> On Thu, Jan 29, 2026 at 09:03:54AM -0800, Stanislav Kinsburskii wrote:
> > On Thu, Jan 29, 2026 at 04:36:51AM +0000, Anirudh Rayabharam wrote:
> > > On Wed, Jan 28, 2026 at 03:03:51PM -0800, Stanislav Kinsburskii wrote:
> > > > On Wed, Jan 28, 2026 at 04:04:37PM +0000, Anirudh Rayabharam wrote:
> > > > > From: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
> > 
> > <snip>
> > 
> > > > 
> > > > > +static int mshv_irq = -1;
> > > > > +
> > > > 
> > > > Should this be a path of mshv_root structure?
> > > 
> > > This doesn't need to be globally accessible. It is only used in this file.
> > > So I guess it doesn't need to be in mshv_root. What do you think?
> > > 
> > 
> > Please, see below.
> 
> The below part doesn't make a case for this variable being part of the
> mshv_root structure. Did you miss this part in your reply?
> 

No, I didn't miss it. I just don't see the point of introducing there
variables unless the goal is to weave more logic into the existent flow.

> > 
> > <snip>
> > 
> > > > >  int mshv_synic_cpu_init(unsigned int cpu)
> > > > >  {
> > > > >  	union hv_synic_simp simp;
> > > > >  	union hv_synic_siefp siefp;
> > > > >  	union hv_synic_sirbp sirbp;
> > > > > -#ifdef HYPERVISOR_CALLBACK_VECTOR
> > > > >  	union hv_synic_sint sint;
> > > > > -#endif
> > > > >  	union hv_synic_scontrol sctrl;
> > > > >  	struct hv_synic_pages *spages = this_cpu_ptr(mshv_root.synic_pages);
> > > > >  	struct hv_message_page **msg_page = &spages->hyp_synic_message_page;
> > > > > @@ -496,10 +632,12 @@ int mshv_synic_cpu_init(unsigned int cpu)
> > > > >  
> > > > >  	hv_set_non_nested_msr(HV_MSR_SIRBP, sirbp.as_uint64);
> > > > >  
> > > > > -#ifdef HYPERVISOR_CALLBACK_VECTOR
> > > > > +	if (mshv_irq != -1)
> > > > > +		enable_percpu_irq(mshv_irq, 0);
> > > > > +
> > > > 
> > > > It's better to explicitly separate x86 and arm64 paths with #ifdefs.
> > > > For example:
> > > > 
> > > > #ifdef CONFIG_X86_64
> > > > int setup_cpu_sint() {
> > > >   	/* Enable intercepts */
> > > >   	sint.as_uint64 = 0;
> > > > 	sint.vector = HYPERVISOR_CALLBACK_VECTOR;
> > > > 	....
> > > > }
> > > > #endif
> > > > #ifdef CONFIG_ARM64
> > > > int setup_cpu_sint() {
> > > > 	enable_percpu_irq(mshv_irq, 0);
> > > > 
> > > >   	/* Enable intercepts */
> > > >   	sint.as_uint64 = 0;
> > > > 	sint.vector = mshv_interrupt;
> > > > 	....
> > > > }
> > > > #endif
> > > 
> > > This seems unnecessary. We've made the paths that determine
> > > mshv_interrupt separate. Now we can just use that here.
> > > 
> > > There is no need to write two copies of 
> > > 
> > > 	...
> > >    	sint.as_uint64 = 0;
> > >  	sint.vector = <whatever>;
> > > 	...
> > > 
> > > I could do the enable_percpu_irq() inside an ifdef. But do we gain
> > > anything from it? Won't the compiler optimize the current code as well
> > > since mshv_irq will always be -1 whenever HYPERVISOR_CALLBACK_VECTOR is
> > > defined?
> > > 
> > 
> > AFAIU this patc, x86 doesn’t need these variables at all. So it’s better
> > to separate them completely and explicitly.
> > 
> > Also, this isn’t the only place where ARM-specific logic is added. This
> > patch adds ARM-specific logic and tries to weave it into the existing
> > x86 flow.
> > 
> > If it were only one place, that might be OK. But here it happens in
> > several places. That makes the code harder to read and maintain. It also
> > makes future extensions more risky (and they will likely follow). The
> > dependencies are also not obvious. For example, on ARM the interrupt
> > vector comes from ACPI (at least that’s what the comments say). So it’s
> > not right to mix this into the common x86 path even if
> > HYPERVISOR_CALLBACK_VECTOR is a x86-specific define.
> 
> We shouldn't think of this code in terms of X86 & ARM64. It's not about
> arch at all. It's about whether or not we have a pre-defined vector
> (a.k.a HYPERVISOR_CALLBACK_VECTOR). I feel that the current code cleanly
> separates the two cases. The main difference in the two cases is in how
> the vector is determined which is well seperated in the code paths. Once
> the vector is determined, how we program it in the synic is the same for
> both cases.
> 

The major question is whether HYPERVISOR_CALLBACK_VECTOR can be
defined on ARM. If it can’t, then it’s effectively an x86-only feature.

The current code separates two cases. You are adding a third one: ARM,
with its own logic. But this is not stated explicitly in the code. As a
result, we now have three cases mixed together, and the flow becomes
spaghetti-like.

If we ever need to support DT on ARM (and we should expect that, because
ACPI on ARM looks odd), we will need to add yet another case to this
mix.

I hope you see the problem. The original code wasn't designed to be
extensible. Since you are adding a new case, this is a good opportunity
to redesign the flow and make it more extensible, instead of adding more
logic on top.

> > 
> > It would be much better to keep this ARM-specific logic in separate,
> > conditionally compiled code. I suggest changing the flow to make this
> > per-arch logic explicit. It will pay off later.
> 
> Most of the code introduced in this patch is conditionally compiled.
> Building code from this patch on x86 will conditionally compile out a
> large majority of it.
> 
> Are you by any chance suggesting we put it in a separate file?
> 

No, I’m not suggesting to move it into a separate file yet.
But making the arch-specific code clearly separated would be a good first step.

Thanks,
Stanislav.

> Thanks,
> Anirudh.
> 
> > 
> > Thanks,
> > Stanislav
> > 
> > > Thanks,
> > > Anirudh.
> > > 
> > > > 
> > > > Thanks,
> > > > Stanislav
> > > > 
> > > > >  	/* Enable intercepts */
> > > > >  	sint.as_uint64 = 0;
> > > > > -	sint.vector = HYPERVISOR_CALLBACK_VECTOR;
> > > > > +	sint.vector = mshv_interrupt;
> > > > >  	sint.masked = false;
> > > > >  	sint.auto_eoi = hv_recommend_using_aeoi();
> > > > >  	hv_set_non_nested_msr(HV_MSR_SINT0 + HV_SYNIC_INTERCEPTION_SINT_INDEX,
> > > > > @@ -507,13 +645,12 @@ int mshv_synic_cpu_init(unsigned int cpu)
> > > > >  
> > > > >  	/* Doorbell SINT */
> > > > >  	sint.as_uint64 = 0;
> > > > > -	sint.vector = HYPERVISOR_CALLBACK_VECTOR;
> > > > > +	sint.vector = mshv_interrupt;
> > > > >  	sint.masked = false;
> > > > >  	sint.as_intercept = 1;
> > > > >  	sint.auto_eoi = hv_recommend_using_aeoi();
> > > > >  	hv_set_non_nested_msr(HV_MSR_SINT0 + HV_SYNIC_DOORBELL_SINT_INDEX,
> > > > >  			      sint.as_uint64);
> > > > > -#endif
> > > > >  
> > > > >  	/* Enable global synic bit */
> > > > >  	sctrl.as_uint64 = hv_get_non_nested_msr(HV_MSR_SCONTROL);
> > > > > @@ -568,6 +705,9 @@ int mshv_synic_cpu_exit(unsigned int cpu)
> > > > >  	hv_set_non_nested_msr(HV_MSR_SINT0 + HV_SYNIC_DOORBELL_SINT_INDEX,
> > > > >  			      sint.as_uint64);
> > > > >  
> > > > > +	if (mshv_irq != -1)
> > > > > +		disable_percpu_irq(mshv_irq);
> > > > > +
> > > > >  	/* Disable Synic's event ring page */
> > > > >  	sirbp.as_uint64 = hv_get_non_nested_msr(HV_MSR_SIRBP);
> > > > >  	sirbp.sirbp_enabled = false;
> > > > > -- 
> > > > > 2.34.1
> > > > > 

