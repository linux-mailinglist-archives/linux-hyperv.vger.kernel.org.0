Return-Path: <linux-hyperv+bounces-2892-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6BAD962520
	for <lists+linux-hyperv@lfdr.de>; Wed, 28 Aug 2024 12:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBF981C2108D
	for <lists+linux-hyperv@lfdr.de>; Wed, 28 Aug 2024 10:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 350D616BE35;
	Wed, 28 Aug 2024 10:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="FMvQFvBx"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8EE16728E;
	Wed, 28 Aug 2024 10:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724841768; cv=pass; b=dzlNGPoN6QLQnzXWAoURqvefkuWR64h3VQN/1zOb4Pkwvlw4rgbuCuxmKNLf0uzehB8FheIKQF4cdP+gcaRZBzbZPlAL+cWsyUyN5A9PV7RsR6wlESPZZ9B6Pw44Rt/87aqQ7/UlE1jjfXPo0B8xVdBrSzc3bU9aJbXn+olOKWs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724841768; c=relaxed/simple;
	bh=C6vaZMyYgUq3Hq0HRDu9+nC3D+CRSI85ZL8YzSsVgXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JgTZxaylFjtYYBoLhjUNnn+mIJKt4Z3yO2vERASouRlTlghyqbn+vwIwG2TmbaRzKsFlAekTmVrPQUUXpAIoS22RvFz3Katqj/tuNyTXbiwwE9nXjtVBzQeSMbmH0t2FzDAfR6GFMemjLWknjTzVOGk07uASQg5pv1lx52f6GDE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=fail (0-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=FMvQFvBx reason="key not found in DNS"; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
ARC-Seal: i=1; a=rsa-sha256; t=1724841736; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=TdN7iG6+dIK/giLjvPr6wX7sJcUPeOUVMOiCoxQP4zu5tSbRqv9BrEM7bbsxm6ZbauwfACHsDcq57rjh1NKdmS0QKJ7760kb1II+OXxRgp0YPu3Lu7DBW5PiRUz2OCpo5yJ0WUtV+QjXO1pNBL8K9/I3gLymsDW98eilNuV676Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1724841736; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=vhu7PMenldtGc4EJ3ADgu0+2nrKYHVlo/OOjuED2QC0=; 
	b=nC876uFHYlCowBF9yKXAnLl0VyHZ7G7d4Jos8GtldDYKd156Ydb/8JuIN1kedZsY7O6z2Dywij0K7r7QmWQS4xUSyBSmFSAAEM6N4pbnwhdkumY3Yk1C4LcKBSLkccLXTK6f92qAFze6P1AW1oGNomAQchw03aNKmnmv2dXFXzM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1724841736;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=vhu7PMenldtGc4EJ3ADgu0+2nrKYHVlo/OOjuED2QC0=;
	b=FMvQFvBxv0ZT1szDigia7+8AhQN4BkrHUHWzq32RiQpcU0QsHnAE+TGBT2bFKzVR
	wkpLuODCWaGuzGby3YyzOHRA65O0AFF5FCWGnyjZUfPVLcvs2kcgnNyqhUbRr6fuJAj
	LqFyqxsdeLTcSUauq+vb7IwaBSyvUuXB3OBap6OU=
Received: by mx.zohomail.com with SMTPS id 1724841734481628.7087928648201;
	Wed, 28 Aug 2024 03:42:14 -0700 (PDT)
Date: Wed, 28 Aug 2024 10:42:10 +0000
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
Message-ID: <Zs7_AnxFMexKsiPy@anirudh-surface.>
References: <20240826105029.3173782-1-anirudh@anirudhrb.com>
 <87zfozxxyb.fsf@redhat.com>
 <11001.124082704082000271@us-mta-164.us.mimecast.lan>
 <87wmk2xt5i.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wmk2xt5i.fsf@redhat.com>
X-ZohoMailClient: External

On Tue, Aug 27, 2024 at 10:32:41AM +0200, Vitaly Kuznetsov wrote:
> Anirudh Rayabharam <anirudh@anirudhrb.com> writes:
> 
> > On Mon, Aug 26, 2024 at 02:36:44PM +0200, Vitaly Kuznetsov wrote:
> >> Anirudh Rayabharam <anirudh@anirudhrb.com> writes:
> >> 
> >> > From: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
> >> >
> >> > 9636be85cc5b ("x86/hyperv: Fix hyperv_pcpu_input_arg handling when CPUs go
> >> > online/offline") introduces a new cpuhp state for hyperv initialization.
> >> >
> >> > cpuhp_setup_state() returns the state number if state is CPUHP_AP_ONLINE_DYN
> >> > or CPUHP_BP_PREPARE_DYN and 0 for all other states. For the hyperv case,
> >> > since a new cpuhp state was introduced it would return 0. However,
> >> > in hv_machine_shutdown(), the cpuhp_remove_state() call is conditioned upon
> >> > "hyperv_init_cpuhp > 0". This will never be true and so hv_cpu_die() won't be
> >> > called on all CPUs. This means the VP assist page won't be reset. When the
> >> > kexec kernel tries to setup the VP assist page again, the hypervisor corrupts
> >> > the memory region of the old VP assist page causing a panic in case the kexec
> >> > kernel is using that memory elsewhere. This was originally fixed in dfe94d4086e4
> >> > ("x86/hyperv: Fix kexec panic/hang issues").
> >> >
> >> > Set hyperv_init_cpuhp to CPUHP_AP_HYPERV_ONLINE upon successful setup so that
> >> > the hyperv cpuhp state is removed correctly on kexec and the necessary cleanup
> >> > takes place.
> >> >
> >> > Cc: stable@vger.kernel.org
> >> > Fixes: 9636be85cc5b ("x86/hyperv: Fix hyperv_pcpu_input_arg handling when CPUs go online/offline")
> >> > Signed-off-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
> >> > ---
> >> >  arch/x86/hyperv/hv_init.c | 4 ++--
> >> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >> >
> >> > diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> >> > index 17a71e92a343..81d1981a75d1 100644
> >> > --- a/arch/x86/hyperv/hv_init.c
> >> > +++ b/arch/x86/hyperv/hv_init.c
> >> > @@ -607,7 +607,7 @@ void __init hyperv_init(void)
> >> >  
> >> >  	register_syscore_ops(&hv_syscore_ops);
> >> >  
> >> > -	hyperv_init_cpuhp = cpuhp;
> >> > +	hyperv_init_cpuhp = CPUHP_AP_HYPERV_ONLINE;
> >> 
> >> Do we really need 'hyperv_init_cpuhp' at all? I.e. post-change (which
> >> LGTM btw), I can only see one usage in hv_machine_shutdown():
> >> 
> >>    if (kexec_in_progress && hyperv_init_cpuhp > 0)
> >>            cpuhp_remove_state(hyperv_init_cpuhp);
> >> 
> >> and I'm wondering if the 'hyperv_init_cpuhp' check is really
> >> needed. This only case where this check would fail is if we're crashing
> >> in between ms_hyperv_init_platform() and hyperv_init() afaiu. Does it
> >
> > Or if we fail to setup the cpuhp state for some reason but don't
> > actually crash and then later do a kexec?
> 
> I see this can happen for CPUHP_AP_ONLINE_DYN/CPUHP_BP_PREPARE_DYN
> because we run out of free slots (40/20), but here we have our own
> dedicated CPUHP_AP_HYPERV_ONLINE and other failure paths seem to be
> exotic...
> 
> >
> > I guess I was just trying to be extra safe and make sure we have
> > actually setup the cpuhp state before calling cpuhp_remove_state()
> > for it. However, looking elsewhere in the kernel code I don't
> > see anybody doing this for custom states...
> >
> >> hurt if we try cpuhp_remove_state() anyway?
> >
> > cpuhp_invoke_callback() would trigger a WARNING if we try to remove a
> > cpuhp state that was never setup.
> >
> > 184         if (cpuhp_step_empty(bringup, step)) {
> > 185                 WARN_ON_ONCE(1);
> > 186                 return 0;
> > 187         }
> >
> 
> Personally, I'd say that getting an extra WARN for such a corner case
> (failing to setup cpuhp state or crashing in between
> ms_hyperv_init_platform() and hyperv_init()) is OK. 

I'll send a v2 with hyperv_init_cpuhp removed entirely.

Thanks,
Anirudh.

> 
> Alternatively, we can convert hyperv_init_cpuhp to a boolean to make it
> a bit more staitforward but as it's uncomon to do it for other states,
> it's likely an overkill.
> 
> -- 
> Vitaly
> 

