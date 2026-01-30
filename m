Return-Path: <linux-hyperv+bounces-8621-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IHdOH3cYfWkhQQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-8621-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 30 Jan 2026 21:45:43 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EC7D5BE807
	for <lists+linux-hyperv@lfdr.de>; Fri, 30 Jan 2026 21:45:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A59CE300A760
	for <lists+linux-hyperv@lfdr.de>; Fri, 30 Jan 2026 20:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A2921CC62;
	Fri, 30 Jan 2026 20:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="Xwo6qo5+"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com [136.143.188.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F791BD9D0;
	Fri, 30 Jan 2026 20:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769805941; cv=pass; b=KhbeShgzSZ7hbvvapeFGvqSFA3n4ax0tMkw+GFl+rpNpA4xLvo3aszH8b1WyiphRDMN+aYlWNPkJ+4307h7MCS3VFcJfeHSZn7MxQrbqIFiZubpZjNZbrO+PMwiXyMWB470dqTrkWkBxCkRVx+2B0X9gXc2RQjFKSSQrl/98MXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769805941; c=relaxed/simple;
	bh=KYUur5uGqmzNFMZWO8sG3tlFXh+LNiF2o1NuPKYEjso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hxoVI7pedzs50idOv2Xvkv0svTzU1d+QscSYO98FT1VYJPeV2KLhVUnUKqpyI7eiqtgH2Cni21sRuVgYJneYEMqiQi1oM1MHSVOrdjbct/9HVoCzap/+ITYcoE+732+swR9zqRvHWXFo3XTpUY4mjDhIrixQyOlVR1rFWweZ0/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=Xwo6qo5+; arc=pass smtp.client-ip=136.143.188.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
ARC-Seal: i=1; a=rsa-sha256; t=1769805929; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=KkFhzeObjS6/YIDPTnQ71GFoxI7UfOkPgJ6DdIb9p7PWxA1e51xM7YYqGI+UKkN4tpm4TrRjxEEUpQLDj9x8QcGdCuneRL8pwHmBUa/EjgkmAv/HLv7AhU01LcTUQo2aYKXVHmASgBiB6dVObk85emVaT8fjMAG3vUSZPW/+tm0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1769805929; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=bGt4zhXr42seRngYYa1JHjHJitpQ4VYXTgd5hJPSx4c=; 
	b=RLsF/9/44VROcUMRYxEQgafUJmiDf68dt8cOVNpjMK7XqlVRNKqFwjke0GUfSKL7MwZfeSUt4p8EVpCta+JIfCc8DzAa45O5CKVUwd0uUiT2O7vxpcgN7QvEWsTIVCdD6lE3fKtYIvE+mby34ZReWTXwj93FjxrN6sc1M7MUzFs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1769805929;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
	bh=bGt4zhXr42seRngYYa1JHjHJitpQ4VYXTgd5hJPSx4c=;
	b=Xwo6qo5+KQfDqGE7eEdQX7qRz4bBZc5mFuZKYZHjW8VnynvDgtMUrKSdDJk7cLsf
	vaAjFRg5tAnZP/GaKVAjHPN5jCnRiJ3wmHhjYouyQwQEhtAkGUcFf3v3QveeGecSSVU
	Y45Zf8yW70dlhJUjheIV9STvOZSq2TNciAdoDhVY=
Received: by mx.zohomail.com with SMTPS id 1769805927062739.4595340093834;
	Fri, 30 Jan 2026 12:45:27 -0800 (PST)
Date: Fri, 30 Jan 2026 20:45:21 +0000
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mshv: add arm64 support for doorbell & intercept
 SINTs
Message-ID: <aX0YYbynhbiSnw_o@anirudh-surface.localdomain>
References: <20260128160437.3342167-1-anirudh@anirudhrb.com>
 <20260128160437.3342167-3-anirudh@anirudhrb.com>
 <aXqV127NzazbDkau@skinsburskii.localdomain>
 <aXrj4-KAxYfuK7k0@anirudh-surface.localdomain>
 <aXuS-ogiBX2Z3Gnf@skinsburskii.localdomain>
 <aXzltmZVDhYIDiaw@anirudh-surface.localdomain>
 <aXz_4yWC6Jofqygj@skinsburskii.localdomain>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aXz_4yWC6Jofqygj@skinsburskii.localdomain>
X-ZohoMailClient: External
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[anirudhrb.com:s=zoho];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[anirudhrb.com];
	TAGGED_FROM(0.00)[bounces-8621-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[anirudhrb.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anirudh@anirudhrb.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[anirudh-surface.localdomain:mid,anirudhrb.com:email,anirudhrb.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EC7D5BE807
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 11:00:51AM -0800, Stanislav Kinsburskii wrote:
> On Fri, Jan 30, 2026 at 05:09:10PM +0000, Anirudh Rayabharam wrote:
> > On Thu, Jan 29, 2026 at 09:03:54AM -0800, Stanislav Kinsburskii wrote:
> > > On Thu, Jan 29, 2026 at 04:36:51AM +0000, Anirudh Rayabharam wrote:
> > > > On Wed, Jan 28, 2026 at 03:03:51PM -0800, Stanislav Kinsburskii wrote:
> > > > > On Wed, Jan 28, 2026 at 04:04:37PM +0000, Anirudh Rayabharam wrote:
> > > > > > From: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
> > > 
> > > <snip>
> > > 
> > > > > 
> > > > > > +static int mshv_irq = -1;
> > > > > > +
> > > > > 
> > > > > Should this be a path of mshv_root structure?
> > > > 
> > > > This doesn't need to be globally accessible. It is only used in this file.
> > > > So I guess it doesn't need to be in mshv_root. What do you think?
> > > > 
> > > 
> > > Please, see below.
> > 
> > The below part doesn't make a case for this variable being part of the
> > mshv_root structure. Did you miss this part in your reply?
> > 
> 
> No, I didn't miss it. I just don't see the point of introducing there
> variables unless the goal is to weave more logic into the existent flow.

I introduced the variables in this file because they're only used in
this file. How would moving the variables to the mshv_root structure
help with the code weaving problem?

> 
> > > 
> > > <snip>
> > > 
> > > > > >  int mshv_synic_cpu_init(unsigned int cpu)
> > > > > >  {
> > > > > >  	union hv_synic_simp simp;
> > > > > >  	union hv_synic_siefp siefp;
> > > > > >  	union hv_synic_sirbp sirbp;
> > > > > > -#ifdef HYPERVISOR_CALLBACK_VECTOR
> > > > > >  	union hv_synic_sint sint;
> > > > > > -#endif
> > > > > >  	union hv_synic_scontrol sctrl;
> > > > > >  	struct hv_synic_pages *spages = this_cpu_ptr(mshv_root.synic_pages);
> > > > > >  	struct hv_message_page **msg_page = &spages->hyp_synic_message_page;
> > > > > > @@ -496,10 +632,12 @@ int mshv_synic_cpu_init(unsigned int cpu)
> > > > > >  
> > > > > >  	hv_set_non_nested_msr(HV_MSR_SIRBP, sirbp.as_uint64);
> > > > > >  
> > > > > > -#ifdef HYPERVISOR_CALLBACK_VECTOR
> > > > > > +	if (mshv_irq != -1)
> > > > > > +		enable_percpu_irq(mshv_irq, 0);
> > > > > > +
> > > > > 
> > > > > It's better to explicitly separate x86 and arm64 paths with #ifdefs.
> > > > > For example:
> > > > > 
> > > > > #ifdef CONFIG_X86_64
> > > > > int setup_cpu_sint() {
> > > > >   	/* Enable intercepts */
> > > > >   	sint.as_uint64 = 0;
> > > > > 	sint.vector = HYPERVISOR_CALLBACK_VECTOR;
> > > > > 	....
> > > > > }
> > > > > #endif
> > > > > #ifdef CONFIG_ARM64
> > > > > int setup_cpu_sint() {
> > > > > 	enable_percpu_irq(mshv_irq, 0);
> > > > > 
> > > > >   	/* Enable intercepts */
> > > > >   	sint.as_uint64 = 0;
> > > > > 	sint.vector = mshv_interrupt;
> > > > > 	....
> > > > > }
> > > > > #endif
> > > > 
> > > > This seems unnecessary. We've made the paths that determine
> > > > mshv_interrupt separate. Now we can just use that here.
> > > > 
> > > > There is no need to write two copies of 
> > > > 
> > > > 	...
> > > >    	sint.as_uint64 = 0;
> > > >  	sint.vector = <whatever>;
> > > > 	...
> > > > 
> > > > I could do the enable_percpu_irq() inside an ifdef. But do we gain
> > > > anything from it? Won't the compiler optimize the current code as well
> > > > since mshv_irq will always be -1 whenever HYPERVISOR_CALLBACK_VECTOR is
> > > > defined?
> > > > 
> > > 
> > > AFAIU this patc, x86 doesn’t need these variables at all. So it’s better
> > > to separate them completely and explicitly.
> > > 
> > > Also, this isn’t the only place where ARM-specific logic is added. This
> > > patch adds ARM-specific logic and tries to weave it into the existing
> > > x86 flow.
> > > 
> > > If it were only one place, that might be OK. But here it happens in
> > > several places. That makes the code harder to read and maintain. It also
> > > makes future extensions more risky (and they will likely follow). The
> > > dependencies are also not obvious. For example, on ARM the interrupt
> > > vector comes from ACPI (at least that’s what the comments say). So it’s
> > > not right to mix this into the common x86 path even if
> > > HYPERVISOR_CALLBACK_VECTOR is a x86-specific define.
> > 
> > We shouldn't think of this code in terms of X86 & ARM64. It's not about
> > arch at all. It's about whether or not we have a pre-defined vector
> > (a.k.a HYPERVISOR_CALLBACK_VECTOR). I feel that the current code cleanly
> > separates the two cases. The main difference in the two cases is in how
> > the vector is determined which is well seperated in the code paths. Once
> > the vector is determined, how we program it in the synic is the same for
> > both cases.
> > 
> 
> The major question is whether HYPERVISOR_CALLBACK_VECTOR can be
> defined on ARM. If it can’t, then it’s effectively an x86-only feature.

It cannot be defined for ARM. Just not possible with the way interrupts
are allocated on ARM.

> 
> The current code separates two cases. You are adding a third one: ARM,

The current code only really handles one case: where
HYPERVISOR_CALLBACK_VECTOR is defined. The other case is not handled at
all.

There is no case called ARM. The only two cases are:

  - HYPERVISOR_CALLBACK_VECTOR is defined
  - HYPERVISOR_CALLBACK_VECTOR is not defined

> with its own logic. But this is not stated explicitly in the code. As a
> result, we now have three cases mixed together, and the flow becomes
> spaghetti-like.
> 
> If we ever need to support DT on ARM (and we should expect that, because
> ACPI on ARM looks odd), we will need to add yet another case to this
> mix.

Nope there won't be another case. DT on ARM would fall under the
"HYPERVISOR_CALLBACK_VECTOR is not defined" case. Under that case, we
would check if we're using ACPI or DT and take the appropriate action.

Please see vmbus_drv.c, a similar approach is used there.

> 
> I hope you see the problem. The original code wasn't designed to be
> extensible. Since you are adding a new case, this is a good opportunity
> to redesign the flow and make it more extensible, instead of adding more
> logic on top.

I'll be sending a v2 soon where I believe I've cleaned this up
a little bit more. Let's see...

Thanks,
Anirudh.

> 
> > > 
> > > It would be much better to keep this ARM-specific logic in separate,
> > > conditionally compiled code. I suggest changing the flow to make this
> > > per-arch logic explicit. It will pay off later.
> > 
> > Most of the code introduced in this patch is conditionally compiled.
> > Building code from this patch on x86 will conditionally compile out a
> > large majority of it.
> > 
> > Are you by any chance suggesting we put it in a separate file?
> > 
> 
> No, I’m not suggesting to move it into a separate file yet.
> But making the arch-specific code clearly separated would be a good first step.
> 
> Thanks,
> Stanislav.
> 
> > Thanks,
> > Anirudh.
> > 
> > > 
> > > Thanks,
> > > Stanislav
> > > 
> > > > Thanks,
> > > > Anirudh.
> > > > 
> > > > > 
> > > > > Thanks,
> > > > > Stanislav
> > > > > 
> > > > > >  	/* Enable intercepts */
> > > > > >  	sint.as_uint64 = 0;
> > > > > > -	sint.vector = HYPERVISOR_CALLBACK_VECTOR;
> > > > > > +	sint.vector = mshv_interrupt;
> > > > > >  	sint.masked = false;
> > > > > >  	sint.auto_eoi = hv_recommend_using_aeoi();
> > > > > >  	hv_set_non_nested_msr(HV_MSR_SINT0 + HV_SYNIC_INTERCEPTION_SINT_INDEX,
> > > > > > @@ -507,13 +645,12 @@ int mshv_synic_cpu_init(unsigned int cpu)
> > > > > >  
> > > > > >  	/* Doorbell SINT */
> > > > > >  	sint.as_uint64 = 0;
> > > > > > -	sint.vector = HYPERVISOR_CALLBACK_VECTOR;
> > > > > > +	sint.vector = mshv_interrupt;
> > > > > >  	sint.masked = false;
> > > > > >  	sint.as_intercept = 1;
> > > > > >  	sint.auto_eoi = hv_recommend_using_aeoi();
> > > > > >  	hv_set_non_nested_msr(HV_MSR_SINT0 + HV_SYNIC_DOORBELL_SINT_INDEX,
> > > > > >  			      sint.as_uint64);
> > > > > > -#endif
> > > > > >  
> > > > > >  	/* Enable global synic bit */
> > > > > >  	sctrl.as_uint64 = hv_get_non_nested_msr(HV_MSR_SCONTROL);
> > > > > > @@ -568,6 +705,9 @@ int mshv_synic_cpu_exit(unsigned int cpu)
> > > > > >  	hv_set_non_nested_msr(HV_MSR_SINT0 + HV_SYNIC_DOORBELL_SINT_INDEX,
> > > > > >  			      sint.as_uint64);
> > > > > >  
> > > > > > +	if (mshv_irq != -1)
> > > > > > +		disable_percpu_irq(mshv_irq);
> > > > > > +
> > > > > >  	/* Disable Synic's event ring page */
> > > > > >  	sirbp.as_uint64 = hv_get_non_nested_msr(HV_MSR_SIRBP);
> > > > > >  	sirbp.sirbp_enabled = false;
> > > > > > -- 
> > > > > > 2.34.1
> > > > > > 

