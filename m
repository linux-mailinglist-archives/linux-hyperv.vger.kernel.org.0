Return-Path: <linux-hyperv+bounces-8695-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yDmhIM/jgmnXeAMAu9opvQ
	(envelope-from <linux-hyperv+bounces-8695-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 04 Feb 2026 07:14:39 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B1FE23CC
	for <lists+linux-hyperv@lfdr.de>; Wed, 04 Feb 2026 07:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3CEFD3089788
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Feb 2026 06:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06FD1377565;
	Wed,  4 Feb 2026 06:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rAzh7Hds"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8804376BFF;
	Wed,  4 Feb 2026 06:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770185561; cv=none; b=QLBsiV5TOd2D8DWRAQ56KDRUzZbEWIFzN3UVppWfMHjjX/UfSp8eQvTYjxKYPrMiYPmm+FqSNSH61EoWwt/C611WUDySZTMa2Tdu1Mmy4qryBAm4KUZqaheYs2mHKyG01DdsYBI1ezEaolBiM5txgKfn/SgMLL0akMwili8pO8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770185561; c=relaxed/simple;
	bh=zy4nfCuhN4eGfgmXckc4pBqMHnZk7q1IzMU6mE6VI5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J68RssqCGFmUZNulgDZyjAdftM/ZyhMuu17WLYmd73osP0K6aJsBy56FSozGUAA2RkpTDH7ovxI3Jyo7nWEe2IHB2IXcHJmiDEt/zEhyOOgTTKQqNSmDWvoS56KXvxnmmlEUnsrC4rd05mqCYm45bF8eK/EIGe0d/AptvJwlGrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rAzh7Hds; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D316C2BC86;
	Wed,  4 Feb 2026 06:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770185561;
	bh=zy4nfCuhN4eGfgmXckc4pBqMHnZk7q1IzMU6mE6VI5w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rAzh7Hds8Qo3l9o81c+fEPp3/XALbWFQ+miKMcS+Incg/T01zwgzZn33WoO0gATTu
	 6CbaEv48C/bFhJxyUuvkmdaz8OTNWdcDop/MeFNQMgmgX9BO9qeGBv2Z39K9EdTJ2e
	 uD+dHUhobajt5SL0UCGzzLbFaknNuDaA3r2l3fLbTJZYfxbmgMb8CKsB3cbYmWhW76
	 JA3ZBBIApN20juOvkQCcyFGjLzxFCVWAdXepkBYrba3ehIFI4bj+xWBFWcsxY0H7wx
	 fxiAZUuhRmVjsAH4+9rnx2in1vSWyNATfi83uahlew1BnqzIgzy+oMj+hG16+t6KRt
	 w631letzyGNOw==
Date: Wed, 4 Feb 2026 06:12:40 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Michael Kelley <mhklinux@outlook.com>
Cc: Mukesh R <mrathor@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>
Subject: Re: [PATCH V0] x86/hyperv: Fix compiler warnings in hv_crash.c
Message-ID: <20260204061240.GD79272@liuwe-devbox-debian-v2.local>
References: <20260121024045.3834787-1-mrathor@linux.microsoft.com>
 <SN6PR02MB4157F7458CA9AE3F84B9B95BD49EA@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB4157F7458CA9AE3F84B9B95BD49EA@SN6PR02MB4157.namprd02.prod.outlook.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[outlook.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-8695-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.liu@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,outlook.com:email,liuwe-devbox-debian-v2.local:mid]
X-Rspamd-Queue-Id: F2B1FE23CC
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 04:21:56AM +0000, Michael Kelley wrote:
> From: Mukesh R <mrathor@linux.microsoft.com> Sent: Tuesday, January 20, 2026 6:41 PM
> > 
> > Fix two compiler warnings:
> >   o smp_ops is only defined if CONFIG_SMP
> >   o status is set but not explicitly used.
> > 
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202512301641.FC6OAbGM-lkp@intel.com/
> > Signed-off-by: Mukesh R <mrathor@linux.microsoft.com>
> > ---
> >  arch/x86/hyperv/hv_crash.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/x86/hyperv/hv_crash.c b/arch/x86/hyperv/hv_crash.c
> > index c0e22921ace1..82915b22ceae 100644
> > --- a/arch/x86/hyperv/hv_crash.c
> > +++ b/arch/x86/hyperv/hv_crash.c
> > @@ -279,7 +279,6 @@ static void hv_notify_prepare_hyp(void)
> >  static noinline __noclone void crash_nmi_callback(struct pt_regs *regs)
> >  {
> >  	struct hv_input_disable_hyp_ex *input;
> > -	u64 status;
> >  	int msecs = 1000, ccpu = smp_processor_id();
> > 
> >  	if (ccpu == 0) {
> > @@ -313,7 +312,7 @@ static noinline __noclone void crash_nmi_callback(struct
> > pt_regs *regs)
> >  	input->rip = trampoline_pa;
> >  	input->arg = devirt_arg;
> > 
> > -	status = hv_do_hypercall(HVCALL_DISABLE_HYP_EX, input, NULL);
> > +	hv_do_hypercall(HVCALL_DISABLE_HYP_EX, input, NULL);
> > 
> >  	hv_panic_timeout_reboot();
> >  }
> > @@ -628,8 +627,9 @@ void hv_root_crash_init(void)
> >  	if (rc)
> >  		goto err_out;
> > 
> > +#ifdef CONFIG_SMP
> >  	smp_ops.crash_stop_other_cpus = hv_crash_stop_other_cpus;
> > -
> > +#endif
> >  	crash_kexec_post_notifiers = true;
> >  	hv_crash_enabled = true;
> >  	pr_info("Hyper-V: both linux and hypervisor kdump support enabled\n");
> > --
> > 2.51.2.vfs.0.1
> > 
> 
> Ingo Molnar has separately fixed the smp_ops problem in [1]. Removing
> the unused "status" value looks good to me, though it's probably slightly
> better to add (void) to hv_do_hypercall() as an explicit acknowledgement
> that there's a return value that's not relevant and is being ignored; i.e.,
> 
> 	(void)hv_do_hypercall(HVCALL_DISABLE_HYP_EX, input, NULL);
> 
> Regardless, for the unused "status" part of this patch,
> 
> Reviewed-by: Michael Kelley <mhklinux@outlook.com>
> 
> [1] https://lore.kernel.org/all/176959812223.510.4055929851272785854.tip-bot2@tip-bot2/

It's my fault. I didn't get to this earlier.

I have applied the other fix to my tree.

Thanks,
Wei

