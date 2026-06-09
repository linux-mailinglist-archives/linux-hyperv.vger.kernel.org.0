Return-Path: <linux-hyperv+bounces-11542-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gm+hDGheJ2rcvAIAu9opvQ
	(envelope-from <linux-hyperv+bounces-11542-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 09 Jun 2026 02:29:28 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CCF865B559
	for <lists+linux-hyperv@lfdr.de>; Tue, 09 Jun 2026 02:29:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=DwyHuGox;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11542-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11542-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F0B230182A8
	for <lists+linux-hyperv@lfdr.de>; Tue,  9 Jun 2026 00:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1794233943;
	Tue,  9 Jun 2026 00:29:25 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F1122A1D4
	for <linux-hyperv@vger.kernel.org>; Tue,  9 Jun 2026 00:29:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780964965; cv=none; b=onrwZ0b0z+9VuTDUdtaCW3sol5dmi2F64OJIbdaQdLfLYpCaM7rzTjjqur9Bcs0Myg21Rex2+PvHM0YQQAAsKkjS4pns9CRLW2QEzwZPOCv3dKWmRCvCp2dj4Sw8Z6isD4nLHe17K7MOdVLouLFkjs4jnUVG1eMtlJqa09YIeIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780964965; c=relaxed/simple;
	bh=okCLjjcx6Ed0kcVEOGQC7olTqLps3Bv3+utUO7Z5QBk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Oy5H2m1Z+1feI6kof+qFeWb/0qAde6ur97oZfiqdVCyX/kpzTCO6WRS19wuYwAQDIDVeiOEmEodanus6gWvDWQzZ8sBevkE1dOY19/DWsnGMGA24WYA3Lj4ceagNUB7PZehUIggxhjoUiCkZ8+1raKVgrcR52eZPAOcf6L9IVGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DwyHuGox; arc=none smtp.client-ip=209.85.215.201
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c857fa2706aso2136951a12.2
        for <linux-hyperv@vger.kernel.org>; Mon, 08 Jun 2026 17:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780964964; x=1781569764; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7x3B1HPEV4Wpd1aCcBTxaYdKxkJL89lmWQlqj4XB55Y=;
        b=DwyHuGoxoP4V91Seaq3cQo9RaGlA4kh2ma+QPTeYHMJxcrNoA8bnlo6Lvnsc2f0Ly6
         rf9AYAszdcIBmXUHnEU+ac0+v7W7LzfRdKK74vEcH8uQX+7vpTpcvtVquMId47oCRIkL
         2iZgKQGivDJ/kq3gw8GPFCIK25Z0HwwXM/cZsK3xEKPtJo7gbaiBadg+Ei7VC5zOmSlw
         Qb8rNt/fMgKpTXJfMP1pscN4q41iNdusZ3ZNDSEXRlMNNF0MG1O2epH9y4UrUrNOXs06
         TJa9O3Ba0tit9HADdLVFNyFrxuINsVFjBIyafXCmOv3SZs3pTia1rXT6SfhjvGKfn640
         i+wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780964964; x=1781569764;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7x3B1HPEV4Wpd1aCcBTxaYdKxkJL89lmWQlqj4XB55Y=;
        b=QoLAHE8ftbWTipZnLuDVv3jDTVtuUXbb3ol+vZhOy8SaK5eCY1COssX5YBEq+me2vc
         wBY/Wl125GAyvAE1jkbMaVZxHkTmQ8kSuPpqldM09HLcnNdCBwF2IHAwQeYu3D7/9lWw
         tNZGWUrobbil9FxM4tP/1pC+SO1obfEVLgX3+4AXh60CpPg5QhEhM/Uv7hLdFOx21PVt
         lT87nH4GbzWR0zNU+aDlsHdxap8o9eXs+XMzUkBcFa/aISGLxM3cLIcRUTSwVopkqOAN
         LHNFZ2WsDM1weRi8/y1iZNb79phdQyknh41t/BWtLXyO/7OYLjY+Sd9Y56WXcEj+zSYy
         d+5A==
X-Forwarded-Encrypted: i=1; AFNElJ9aN8E6yB4nTzrWxV34n75sb9uilY25rJCWdzdIiL7SsCBy5Nl4Q/e850WTQgvXZpGlXLXqawjDU08SI80=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs9NKwEMP76ghqtk8NZJCRZhQbyJqNX8eOcneOyW+9fc7AJf0a
	Leo5yLeqVr4MOSJXq7gep7wz5NZh2q0qhBGG6yr3WJhYbVizpSJ5LhK9jLBVLb0mDhNn2kxh7tW
	yB6tHYQ==
X-Received: from pffy10.prod.google.com ([2002:aa7:93ca:0:b0:838:ec6d:449c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:90a7:b0:842:3aee:12c1
 with SMTP id d2e1a72fcca58-842b0e8312bmr17335107b3a.18.1780964963660; Mon, 08
 Jun 2026 17:29:23 -0700 (PDT)
Date: Mon, 8 Jun 2026 17:29:22 -0700
In-Reply-To: <20260530063531.D034A1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529144435.704127-22-seanjc@google.com> <20260530063531.D034A1F00898@smtp.kernel.org>
Message-ID: <aideYkFmpELRfcX5@google.com>
Subject: Re: [PATCH v4 21/47] x86/xen: Obtain TSC frequency from CPUID if present
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org, linux-hyperv@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11542-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sashiko-reviews@lists.linux.dev,m:kvm@vger.kernel.org,m:linux-hyperv@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[seanjc@google.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanjc@google.com,linux-hyperv@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7CCF865B559

On Sat, May 30, 2026, sashiko-bot@kernel.org wrote:
> > diff --git a/arch/x86/xen/time.c b/arch/x86/xen/time.c
> > index 487ad838c4418..36d66abf53796 100644
> > --- a/arch/x86/xen/time.c
> > +++ b/arch/x86/xen/time.c
> > @@ -42,6 +42,17 @@ static unsigned int __init xen_tsc_khz(void)
> >  {
> >  	struct pvclock_vcpu_time_info *info =
> >  		&HYPERVISOR_shared_info->vcpu_info[0].time;
> > +	u32 base = xen_cpuid_base();
> > +	u32 eax, ebx, ecx, edx;
> > +
> > +	/*
> > +	 * If Xen provides the guest TSC frequency directly in CPUID
> > +	 * (leaf 3, sub-leaf 0, ECX), use that instead of reverse-
> > +	 * calculating from the pvclock mul/shift.
> > +	 */
> > +	cpuid_count(base + 3, 0, &eax, &ebx, &ecx, &edx);
> > +	if (ecx)
> > +		return ecx;
> 
> [Severity: High]
> Is it possible for the hypervisor to support a maximum leaf of base + 2,
> resulting in an out-of-bounds CPUID query here?
> 
> Looking at xen_cpuid_base(), it calls cpuid_base_hypervisor(XEN_SIGNATURE, 2)
> which only guarantees that the hypervisor supports up to leaf base + 2.
> 
> If the hypervisor does not support base + 3, this CPUID query could be out
> of bounds. Processors handling out-of-bounds CPUID requests typically return
> data from the maximum basic leaf.

Heh, depends on the hypervisor.  This quirk is specific to Intel CPUs, and so
KVM emulates this behavior only when the advertised vCPU vendor is Intel.

Anyways, AFAICT, Sashiko is right to be skeptical, I don't see anything obvious
that guarantees +3 will be supported.

David, can you send this as a standalone patch, and either address Sashiko's
concern or add a blurb/comment explaining why it's safe?  Unlike the KVM changes,
this won't conflict with any of the other changes in this series.  So while it's
themetatically very related to this series, in practice it can go in separately,
and I'd strongly prefer to let the Xen folks handle this one.

