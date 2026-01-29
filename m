Return-Path: <linux-hyperv+bounces-8586-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mGsvHbGTe2nOGAIAu9opvQ
	(envelope-from <linux-hyperv+bounces-8586-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 29 Jan 2026 18:06:57 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C9872B2A2C
	for <lists+linux-hyperv@lfdr.de>; Thu, 29 Jan 2026 18:06:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF71130238EE
	for <lists+linux-hyperv@lfdr.de>; Thu, 29 Jan 2026 17:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B0B334251D;
	Thu, 29 Jan 2026 17:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="idutR0kr"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C3E2D63E8;
	Thu, 29 Jan 2026 17:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769706237; cv=none; b=ky3h6x04z9Pu51dp2ml2mgiCFtT9x4SP6ewbYzq4rLmWprLcbDn+Lbu+yrBUO/HPn/UndwG9PvzVEjf3lkGCYfzkCHDUdIPxrsGhYcL/FAbZGZ9TBc+/MkgzUr4JM6pfoubb80/9H3owgrBlbRDg7wMxXTas36Dzbyc+petT9uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769706237; c=relaxed/simple;
	bh=V4LZUI8PyAGoK/eIYJbTSx8N8HHFVW32uwqHlqMRzoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=roPU0rDnrqhOwbqIS3GwEvdIdv2+mjOB+er/DWbx3yRboIkBl3b6o+NkU1AAX53tp6daQ0Ykdqm5jKYsheF15+AC6OJjrQHwLd6i19TyZU77zwsN0rKaDA1zL8GQTuvFbCJtgR9l3mBIXIj+3pxq1dYpvgsFXG9UO35lgElKfn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=idutR0kr; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (unknown [52.148.171.5])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4BA7020B7167;
	Thu, 29 Jan 2026 09:03:55 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4BA7020B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1769706235;
	bh=MgPt4ZqNkJ1hBIBidT5pxPZiLmA1c9AtSyMY6urDaq4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=idutR0krK1D9t3IUk15EvZTejacMvM05uemwb/3JXzAm3osOvTVJuC8ovJQ6l4VGS
	 G2FT33ko7QQLOoVTatgQ1yu+jxdCDTgsBZ3SlyB3TArHPNFvlcxF5sYorL+QHVXI0S
	 xmCX3/Rnzr51FG2Y2A0pWbcqqZ+Jx9o7FmQ6Oy7s=
Date: Thu, 29 Jan 2026 09:03:54 -0800
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Anirudh Rayabharam <anirudh@anirudhrb.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mshv: add arm64 support for doorbell & intercept
 SINTs
Message-ID: <aXuS-ogiBX2Z3Gnf@skinsburskii.localdomain>
References: <20260128160437.3342167-1-anirudh@anirudhrb.com>
 <20260128160437.3342167-3-anirudh@anirudhrb.com>
 <aXqV127NzazbDkau@skinsburskii.localdomain>
 <aXrj4-KAxYfuK7k0@anirudh-surface.localdomain>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aXrj4-KAxYfuK7k0@anirudh-surface.localdomain>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-8586-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: C9872B2A2C
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 04:36:51AM +0000, Anirudh Rayabharam wrote:
> On Wed, Jan 28, 2026 at 03:03:51PM -0800, Stanislav Kinsburskii wrote:
> > On Wed, Jan 28, 2026 at 04:04:37PM +0000, Anirudh Rayabharam wrote:
> > > From: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>

<snip>

> > 
> > > +static int mshv_irq = -1;
> > > +
> > 
> > Should this be a path of mshv_root structure?
> 
> This doesn't need to be globally accessible. It is only used in this file.
> So I guess it doesn't need to be in mshv_root. What do you think?
> 

Please, see below.

<snip>

> > >  int mshv_synic_cpu_init(unsigned int cpu)
> > >  {
> > >  	union hv_synic_simp simp;
> > >  	union hv_synic_siefp siefp;
> > >  	union hv_synic_sirbp sirbp;
> > > -#ifdef HYPERVISOR_CALLBACK_VECTOR
> > >  	union hv_synic_sint sint;
> > > -#endif
> > >  	union hv_synic_scontrol sctrl;
> > >  	struct hv_synic_pages *spages = this_cpu_ptr(mshv_root.synic_pages);
> > >  	struct hv_message_page **msg_page = &spages->hyp_synic_message_page;
> > > @@ -496,10 +632,12 @@ int mshv_synic_cpu_init(unsigned int cpu)
> > >  
> > >  	hv_set_non_nested_msr(HV_MSR_SIRBP, sirbp.as_uint64);
> > >  
> > > -#ifdef HYPERVISOR_CALLBACK_VECTOR
> > > +	if (mshv_irq != -1)
> > > +		enable_percpu_irq(mshv_irq, 0);
> > > +
> > 
> > It's better to explicitly separate x86 and arm64 paths with #ifdefs.
> > For example:
> > 
> > #ifdef CONFIG_X86_64
> > int setup_cpu_sint() {
> >   	/* Enable intercepts */
> >   	sint.as_uint64 = 0;
> > 	sint.vector = HYPERVISOR_CALLBACK_VECTOR;
> > 	....
> > }
> > #endif
> > #ifdef CONFIG_ARM64
> > int setup_cpu_sint() {
> > 	enable_percpu_irq(mshv_irq, 0);
> > 
> >   	/* Enable intercepts */
> >   	sint.as_uint64 = 0;
> > 	sint.vector = mshv_interrupt;
> > 	....
> > }
> > #endif
> 
> This seems unnecessary. We've made the paths that determine
> mshv_interrupt separate. Now we can just use that here.
> 
> There is no need to write two copies of 
> 
> 	...
>    	sint.as_uint64 = 0;
>  	sint.vector = <whatever>;
> 	...
> 
> I could do the enable_percpu_irq() inside an ifdef. But do we gain
> anything from it? Won't the compiler optimize the current code as well
> since mshv_irq will always be -1 whenever HYPERVISOR_CALLBACK_VECTOR is
> defined?
> 

AFAIU this patc, x86 doesn’t need these variables at all. So it’s better
to separate them completely and explicitly.

Also, this isn’t the only place where ARM-specific logic is added. This
patch adds ARM-specific logic and tries to weave it into the existing
x86 flow.

If it were only one place, that might be OK. But here it happens in
several places. That makes the code harder to read and maintain. It also
makes future extensions more risky (and they will likely follow). The
dependencies are also not obvious. For example, on ARM the interrupt
vector comes from ACPI (at least that’s what the comments say). So it’s
not right to mix this into the common x86 path even if
HYPERVISOR_CALLBACK_VECTOR is a x86-specific define.

It would be much better to keep this ARM-specific logic in separate,
conditionally compiled code. I suggest changing the flow to make this
per-arch logic explicit. It will pay off later.

Thanks,
Stanislav

> Thanks,
> Anirudh.
> 
> > 
> > Thanks,
> > Stanislav
> > 
> > >  	/* Enable intercepts */
> > >  	sint.as_uint64 = 0;
> > > -	sint.vector = HYPERVISOR_CALLBACK_VECTOR;
> > > +	sint.vector = mshv_interrupt;
> > >  	sint.masked = false;
> > >  	sint.auto_eoi = hv_recommend_using_aeoi();
> > >  	hv_set_non_nested_msr(HV_MSR_SINT0 + HV_SYNIC_INTERCEPTION_SINT_INDEX,
> > > @@ -507,13 +645,12 @@ int mshv_synic_cpu_init(unsigned int cpu)
> > >  
> > >  	/* Doorbell SINT */
> > >  	sint.as_uint64 = 0;
> > > -	sint.vector = HYPERVISOR_CALLBACK_VECTOR;
> > > +	sint.vector = mshv_interrupt;
> > >  	sint.masked = false;
> > >  	sint.as_intercept = 1;
> > >  	sint.auto_eoi = hv_recommend_using_aeoi();
> > >  	hv_set_non_nested_msr(HV_MSR_SINT0 + HV_SYNIC_DOORBELL_SINT_INDEX,
> > >  			      sint.as_uint64);
> > > -#endif
> > >  
> > >  	/* Enable global synic bit */
> > >  	sctrl.as_uint64 = hv_get_non_nested_msr(HV_MSR_SCONTROL);
> > > @@ -568,6 +705,9 @@ int mshv_synic_cpu_exit(unsigned int cpu)
> > >  	hv_set_non_nested_msr(HV_MSR_SINT0 + HV_SYNIC_DOORBELL_SINT_INDEX,
> > >  			      sint.as_uint64);
> > >  
> > > +	if (mshv_irq != -1)
> > > +		disable_percpu_irq(mshv_irq);
> > > +
> > >  	/* Disable Synic's event ring page */
> > >  	sirbp.as_uint64 = hv_get_non_nested_msr(HV_MSR_SIRBP);
> > >  	sirbp.sirbp_enabled = false;
> > > -- 
> > > 2.34.1
> > > 

