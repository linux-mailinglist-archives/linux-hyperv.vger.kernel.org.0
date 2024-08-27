Return-Path: <linux-hyperv+bounces-2878-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C9196040B
	for <lists+linux-hyperv@lfdr.de>; Tue, 27 Aug 2024 10:09:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BF8A1C2284D
	for <lists+linux-hyperv@lfdr.de>; Tue, 27 Aug 2024 08:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED3819CD08;
	Tue, 27 Aug 2024 08:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="SYKbZR39"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE72194136;
	Tue, 27 Aug 2024 08:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724746123; cv=pass; b=XorO425WzeCwWqNYZSHwN93YVDOSCdMmBOhNH5n0X1+rkrRVTHHueVt4HRT1CoBbeHn0YCktX4NRsRs+WEXw3x+34oiXUN1CgaOCQO/McWpPgI7+iBQOl6tGrcl/iKiX5iMTLk0kL+SQnIywdFyrgOVjOeyaSVVebxFHTd0CcX8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724746123; c=relaxed/simple;
	bh=0HsOksNJT9R9KbeUb6IVcPk2ehrn0odcjcGVeX1aFnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NgFl8MkN2NA0KNV+XFPgLrCowZ6Vq4/ol45QtZIHrD8j3Ck8rzfezgGKyEZPbChW8VawwcIGE67KyNZ1ZFB0/tsnB1ZCj+nweIDNjLj2d2klhoTXj69DkE1O2SbanCQwTf4aW4mjAF8f/GEmzVsbEHG885nwEwQEuY73H3v7ZbY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=fail (0-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=SYKbZR39 reason="key not found in DNS"; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
ARC-Seal: i=1; a=rsa-sha256; t=1724746097; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=cgxVTTMHZzvapGuM7vngv+DBMxw2qlQ1gNHPRVrZnmoezXjNbF+/MkZc+RVEk6VXt9DTRGAnd6/mDlbIyGDbC/EKktcimUdilEyUbEl4IRQRF4DRn2LodLGXlzBJWrWCAPg312IG0CDCHqEbTtUhOn7377rJkqTPmJYL6VbaQi4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1724746097; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Yhda3ZaakIRr5Jfh9tLkpGI4s2ObP0t0lO8nd/HrFCI=; 
	b=aUx0I7HHauNRq3i045wRmuB0ePWWSxjR9eh5uH3WVnmNmL33NXHei/lpn1KB2tePG/rhwtXFGakJLB57LG1h+sWN7hhC5yc/Yc3+VsJ8a2DFH9niiPYWQHC2lwX12gabnbiLYWo4meMqL4asU4FAzZeiQ2pB/wrQWlTAHr9h1cY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1724746097;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=Yhda3ZaakIRr5Jfh9tLkpGI4s2ObP0t0lO8nd/HrFCI=;
	b=SYKbZR39/CIGEAZT0wX9xS9l/bTRgeUH5SIxC6ymVgqCSBa2WL/qxLHrnTyInQy9
	65GmWv+EdpPs/ps8fY3K6MTUnBgDhM90hLo3P5hpKVGsgYuFr6ryp/f/bB//8+GhpMS
	/awoMc3XVbvNkdIM36SWvk4sAAMwZyJCfItCCQ5E=
Received: by mx.zohomail.com with SMTPS id 1724746096946252.20843917403852;
	Tue, 27 Aug 2024 01:08:16 -0700 (PDT)
Date: Tue, 27 Aug 2024 08:08:10 +0000
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: stable@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Michael Kelley <mikelley@microsoft.com>
Subject: Re: [PATCH] x86/hyperv: fix kexec crash due to VP assist page
 corruption
Message-ID: <Zs2JamdDJs07WCS5@anirudh-surface.>
References: <20240826105029.3173782-1-anirudh@anirudhrb.com>
 <87zfozxxyb.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zfozxxyb.fsf@redhat.com>
X-ZohoMailClient: External

On Mon, Aug 26, 2024 at 02:36:44PM +0200, Vitaly Kuznetsov wrote:
> Anirudh Rayabharam <anirudh@anirudhrb.com> writes:
> 
> > From: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
> >
> > 9636be85cc5b ("x86/hyperv: Fix hyperv_pcpu_input_arg handling when CPUs go
> > online/offline") introduces a new cpuhp state for hyperv initialization.
> >
> > cpuhp_setup_state() returns the state number if state is CPUHP_AP_ONLINE_DYN
> > or CPUHP_BP_PREPARE_DYN and 0 for all other states. For the hyperv case,
> > since a new cpuhp state was introduced it would return 0. However,
> > in hv_machine_shutdown(), the cpuhp_remove_state() call is conditioned upon
> > "hyperv_init_cpuhp > 0". This will never be true and so hv_cpu_die() won't be
> > called on all CPUs. This means the VP assist page won't be reset. When the
> > kexec kernel tries to setup the VP assist page again, the hypervisor corrupts
> > the memory region of the old VP assist page causing a panic in case the kexec
> > kernel is using that memory elsewhere. This was originally fixed in dfe94d4086e4
> > ("x86/hyperv: Fix kexec panic/hang issues").
> >
> > Set hyperv_init_cpuhp to CPUHP_AP_HYPERV_ONLINE upon successful setup so that
> > the hyperv cpuhp state is removed correctly on kexec and the necessary cleanup
> > takes place.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 9636be85cc5b ("x86/hyperv: Fix hyperv_pcpu_input_arg handling when CPUs go online/offline")
> > Signed-off-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
> > ---
> >  arch/x86/hyperv/hv_init.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> > index 17a71e92a343..81d1981a75d1 100644
> > --- a/arch/x86/hyperv/hv_init.c
> > +++ b/arch/x86/hyperv/hv_init.c
> > @@ -607,7 +607,7 @@ void __init hyperv_init(void)
> >  
> >  	register_syscore_ops(&hv_syscore_ops);
> >  
> > -	hyperv_init_cpuhp = cpuhp;
> > +	hyperv_init_cpuhp = CPUHP_AP_HYPERV_ONLINE;
> 
> Do we really need 'hyperv_init_cpuhp' at all? I.e. post-change (which
> LGTM btw), I can only see one usage in hv_machine_shutdown():
> 
>    if (kexec_in_progress && hyperv_init_cpuhp > 0)
>            cpuhp_remove_state(hyperv_init_cpuhp);
> 
> and I'm wondering if the 'hyperv_init_cpuhp' check is really
> needed. This only case where this check would fail is if we're crashing
> in between ms_hyperv_init_platform() and hyperv_init() afaiu. Does it

Or if we fail to setup the cpuhp state for some reason but don't
actually crash and then later do a kexec?

I guess I was just trying to be extra safe and make sure we have
actually setup the cpuhp state before calling cpuhp_remove_state()
for it. However, looking elsewhere in the kernel code I don't
see anybody doing this for custom states...

> hurt if we try cpuhp_remove_state() anyway?

cpuhp_invoke_callback() would trigger a WARNING if we try to remove a
cpuhp state that was never setup.

184         if (cpuhp_step_empty(bringup, step)) {
185                 WARN_ON_ONCE(1);
186                 return 0;
187         }

Thanks,
Anirudh

> 
> >  
> >  	if (cpuid_ebx(HYPERV_CPUID_FEATURES) & HV_ACCESS_PARTITION_ID)
> >  		hv_get_partition_id();
> > @@ -637,7 +637,7 @@ void __init hyperv_init(void)
> >  clean_guest_os_id:
> >  	wrmsrl(HV_X64_MSR_GUEST_OS_ID, 0);
> >  	hv_ivm_msr_write(HV_X64_MSR_GUEST_OS_ID, 0);
> > -	cpuhp_remove_state(cpuhp);
> > +	cpuhp_remove_state(CPUHP_AP_HYPERV_ONLINE);
> >  free_ghcb_page:
> >  	free_percpu(hv_ghcb_pg);
> >  free_vp_assist_page:
> 
> -- 
> Vitaly
> 

