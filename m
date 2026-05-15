Return-Path: <linux-hyperv+bounces-10984-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eEIfMKehB2rP/QIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10984-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 16 May 2026 00:43:51 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD96558FF7
	for <lists+linux-hyperv@lfdr.de>; Sat, 16 May 2026 00:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A8E3F300E3C3
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 22:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D2C318EEE;
	Fri, 15 May 2026 22:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PK3fk0yT"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574C9390C9E
	for <linux-hyperv@vger.kernel.org>; Fri, 15 May 2026 22:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778885028; cv=none; b=Zxjdt/FYgSAYzGaHlBjZtrcZKaoETq40s2SZR1XbKk3AG/+Hoy8VbH4DU+qjBVaXotdkIW6TV3tgKXvGjPGB6e9lgfThY1LQzgoQr0McujrTaAt2U+p3POLPhrRLoNqoUdgylCNhKY/C2A+N09DVA4804IcwZ/r12mqkYHl1Re4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778885028; c=relaxed/simple;
	bh=QiBbUKhvE7WnBe23cJ9tSwIwO99nU6YwAlMSO3Yo/oo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EJqn4xTxDkII1pIcpBfPMMsbBuvVtozLUzCPKltPBPJFHFKYmQfN8k4v5etT5Usg0czvVW05h02XBitLkWV53HEIujjpBpXw2ulszpe2ZJUpaEcBH8n9nkA37A3z3FOLB0L3OCToVsqk7TQgf+oCoTkEWjj85e1cCkFjLL4CcH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PK3fk0yT; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82f9429f49cso514411b3a.3
        for <linux-hyperv@vger.kernel.org>; Fri, 15 May 2026 15:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778885025; x=1779489825; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=R2Qo4C0wZvSfbRBCVUm7E3jAs9zIx+Oehl/wA7M+yCc=;
        b=PK3fk0yT94krEHq+RI3aoyMJbbTYdeKulZYUQOoc/VsIzZgkmnYyI11s9UE+0Luln7
         ZtjD1egw9w8TIK5QIyy7o33HOhp0cjO9Z8gqwuL/1WRAuWi0H5UWamcjGMjO9L2mBmpY
         oHdHScKs/df3BIGVr3zWsB+Gwm1mvAHf+V+On3R0L3QgFpXz1nsHP8m//RFkpSBIu9lr
         nWdRiQ+EILuE55/sGr0gSStdJ4wJhSnCW7N4K9wn5T/RuuDzVoWSFTV9IH1ZemaURS4q
         jLjw+AajKbM9vn+5xqktazcH0ltMTYICzj7lWv1BWr5SQYxk0uH+5YPuS3Kcho+hERAO
         wntQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778885025; x=1779489825;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R2Qo4C0wZvSfbRBCVUm7E3jAs9zIx+Oehl/wA7M+yCc=;
        b=jSVA8UALS0n+PgMNc/U9iyeMlYW4eSA+w5AgjuHFYqNtcL/980nMlkJtbhzW3UqtP8
         X7jvDf+zggmOV8c5qfl/dysE/5u+CpixeAyLJdkYyHX+gAEo3RyyJO5gCnhWfEmJGU/x
         iGGCpZcwVMHXUxaSbtpw6qvEWyTKQuBFKcsGVef0d+2ipTIQ0yOLM6tfl1B8TCEAMazR
         4viEYpUMgLJ78V3jzZWouGSoFA1M2CfUkv18FbdO++PfTZOdaLwDb2JhMn+Hhx1QjfoR
         iRcmeMP2Km1rTjFgYmsgSenLxs45tmGgJWBbglF1aPfKjJC9JWqc3xeTWyH0kPw+Ro0t
         jjhA==
X-Gm-Message-State: AOJu0YxgoRMgodLiXzn0WNIFRIELmx7tlE49h5cpmJJ2rjiquNfNZydQ
	FwPmPQIaTuqRMdTJTy1KX0i9QdK8VBcTqeiSwEI1nIhT2RU3vZmhhu53mxyYhsqMkHxfR90pmsb
	HAhZG8Q==
X-Received: from pfbgs18.prod.google.com ([2002:a05:6a00:4d92:b0:82f:8956:e620])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:a586:b0:837:e9cc:d474
 with SMTP id d2e1a72fcca58-83f33c31a31mr7229268b3a.2.1778885025341; Fri, 15
 May 2026 15:43:45 -0700 (PDT)
Date: Fri, 15 May 2026 15:43:44 -0700
In-Reply-To: <20260515194803.1D898C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260515191942.1892718-16-seanjc@google.com> <20260515194803.1D898C2BCB0@smtp.kernel.org>
Message-ID: <agehoBgq8hX3hCIF@google.com>
Subject: Re: [PATCH v3 15/41] x86/xen/time: Nullify x86_platform's sched_clock
 save/restore hooks
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-hyperv@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Rspamd-Queue-Id: 3FD96558FF7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10984-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanjc@google.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Fri, May 15, 2026, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > diff --git a/arch/x86/xen/time.c b/arch/x86/xen/time.c
> > index 3d3165eef8214..21d366d01985e 100644
> > --- a/arch/x86/xen/time.c
> > +++ b/arch/x86/xen/time.c
> > @@ -568,6 +568,12 @@ static void __init xen_init_time_common(void)
> >  	xen_sched_clock_offset = xen_clocksource_read();
> >  	static_call_update(pv_steal_clock, xen_steal_clock);
> >  	paravirt_set_sched_clock(xen_sched_clock);
> > +	/*
> > +	 * Xen has paravirtualized suspend/resume and so doesn't use the common
> > +	 * x86 sched_clock save/restore hooks.
> > +	 */
> > +	x86_platform.save_sched_clock_state = NULL;
> > +	x86_platform.restore_sched_clock_state = NULL;
> 
> Does setting these hooks to NULL lead to an unconditional pointer dereference
> regression during suspend, hibernation, or kexec operations in Xen guests?
> 
> Looking at save_processor_state() and __restore_processor_state() in
> arch/x86/power/cpu.c, the hooks are called directly without being checked
> for NULL first:
> 
> arch/x86/power/cpu.c:save_processor_state() {
> 	__save_processor_state(&saved_context);
> 	x86_platform.save_sched_clock_state();
> }
> 
> arch/x86/power/cpu.c:__restore_processor_state() {
> 	...
> 	do_fpu_end();
> 	tsc_verify_tsc_adjust(true);
> 	x86_platform.restore_sched_clock_state();
> 	...
> }
> 
> Will operations that trigger a generic CPU state save or restore on a Xen
> guest execute a call on these NULL pointers, causing a kernel panic
> regression? Should these instead be assigned to an empty stub function to
> safely bypass them?

/facepalm

Yes.  I suspect past me carried over the Xen changes before I understood why
it's safe on Xen (Xen uses a unique PV suspend/resume flow).

Playing nice with NULL x86_platform.{save,restore}_sched_clock_state pointers
is the obvious fix.  The other option would be to wire up nop callbacks, but I
don't see any value in doing so.  I really don't want to leave the callbacks
wired up to tsc_{save,restore}_sched_clock_state() (unless it turns out VMware
actually needs them).

Regardless, this definitely highlights that VMware guests need to be tested. :-/

