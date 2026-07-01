Return-Path: <linux-hyperv+bounces-11789-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tw5NGJZzRWoCAgsAu9opvQ
	(envelope-from <linux-hyperv+bounces-11789-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 01 Jul 2026 22:07:50 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2DED6F146E
	for <lists+linux-hyperv@lfdr.de>; Wed, 01 Jul 2026 22:07:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=c5REi2am;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11789-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11789-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 64AA43008285
	for <lists+linux-hyperv@lfdr.de>; Wed,  1 Jul 2026 20:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81AB73B0AD8;
	Wed,  1 Jul 2026 20:05:29 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7D0380FC5
	for <linux-hyperv@vger.kernel.org>; Wed,  1 Jul 2026 20:05:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782936329; cv=none; b=UxrSYpmeGS90DTNCDz2dnFQgcUqLEqdGXZkmIEnI80e3cD0Q8q7w7XxoOpt+Wn9TgQLPpTyVrfzpTleZD9bd1W3c8W0B8cN7aSAHjtmULMVI5dvUlfTPt70tZW4JQy8+E/LSEBGfzQ/h5r7z5RBwe6VuRZekqCoPWSuUd2rfxy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782936329; c=relaxed/simple;
	bh=PcSEF2MK/cHXB+Kv/gJgOEiv9hBkttCriZtxCNKAB2Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MoVokAgkyVXLyo+ubunW1tzaaWJnbCtxriLZLWzBTHUqrjFMnThgqibAZIqTQyopcvfjSab6jkNpQlofl8XvC8jS72EkXU8sVDWCckVhC+5BRyPa5FvBYk+dUFV0g/C/z+cSyYgAw/OaY4vxkeHAEmK9Ub0mXmTGTZqES1abx4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c5REi2am; arc=none smtp.client-ip=209.85.210.202
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-847b8d76e3dso1545596b3a.1
        for <linux-hyperv@vger.kernel.org>; Wed, 01 Jul 2026 13:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782936327; x=1783541127; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1ULfZXJnLyQ1iTfhcSHKWEGPX6blmvdMahynjzwdjn4=;
        b=c5REi2amcx4O47eXfCZ6wCVQyPvjZ611Xf98Ib8CUo2gw6pupVbGO2ky8ls4A8nz4N
         U7yBQoog8R7YuiwGWojTktf8o7p00J1KuA4aHB7cQV1q3i9cRKqU5MC79B6AcM6K9bhG
         xcopJl7khCvY3vrHZG883oXhVPE1Vm5wmSapLgURFatjevIQ6JiZhBEW6pGgraSmAf5E
         sWL2mDqS2x03cu1hZfUAtIRdhgqzu/U/oFgriLR/XBARZ6uXSOx1BJgafDq3zxtP+0qs
         co8JR+WpR/o0ZbEMck2TVNoRy9fKnNMNQinuQwtbFOVod4VvF39xX78uVw8RytkTuTJn
         1ctg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782936327; x=1783541127;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1ULfZXJnLyQ1iTfhcSHKWEGPX6blmvdMahynjzwdjn4=;
        b=HV9dJHI5/Z9xvnhpalNELJgYWpVnhRFfEVPq8IM6EvnDI/ije2kgGCIZKN9VD4LhRJ
         O7N+jW36pBE/q6+6P/aKyaCOM7TPk7jIPnEIoBO6/aKk4tTwJwibcwUEOdhpx2GLajPV
         5sGVG3eOxHC+VFWJQm1JxVggGffjmC1Rg1xleIqnzgZgtyz4ngPhqtLgkTvdfB05tbvE
         rFU0JXxb+oDg8g2texVa6yLQQYh92Cy7vEbyVBtoGfIos6eQkAfBIUK1nmxonIsSjLYI
         CsSV+vvH6xh1kfqQpDVHZvePQ1OW/u5XVV9mEUXO+WbLI26wKTMXzgn+hW+MuVVun0Jo
         rklQ==
X-Forwarded-Encrypted: i=1; AHgh+RqAUfWIsFqQjrc4yFR0zfucBm3onInEAflcnjm56g+SkN1KSmUN8KUIOyiS1UZQDi9Ydb6NWT2t+56MbU0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz14es1Q+O3nA0/yoV11mae8cNDWaCT+D3ZauK3yMlSThSPsCM2
	5xNBX/P04ZLv6mHIvJb2AtxJxtYnsGjuVLW4k/OzF2T4rwaCR/H7ckdXAjocrMWjVnCEi1LHUv6
	0zk0mZw==
X-Received: from pfbfv4.prod.google.com ([2002:a05:6a00:6184:b0:847:9651:d996])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4516:b0:842:5a8d:303a
 with SMTP id d2e1a72fcca58-847c0950567mr3079095b3a.37.1782936327311; Wed, 01
 Jul 2026 13:05:27 -0700 (PDT)
Date: Wed, 1 Jul 2026 13:05:26 -0700
In-Reply-To: <20260701194621.4BD691F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260701193212.749551-1-seanjc@google.com> <20260701193212.749551-2-seanjc@google.com>
 <20260701194621.4BD691F000E9@smtp.kernel.org>
Message-ID: <akVzBqcJt-H8XCZQ@google.com>
Subject: Re: [PATCH v5 01/51] x86/apic: Provide helpers to set local APIC
 timer period in hz and khz
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org, linux-hyperv@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11789-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sashiko-reviews@lists.linux.dev,m:kvm@vger.kernel.org,m:linux-hyperv@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[seanjc@google.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C2DED6F146E

On Wed, Jul 01, 2026, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
> > index aa1e19979aa8e..8d3d930576fd7 100644
> > --- a/arch/x86/kernel/apic/apic.c
> > +++ b/arch/x86/kernel/apic/apic.c
> 
> [ ... ]
> 
> > @@ -796,6 +796,16 @@ bool __init apic_needs_pit(void)
> >  	return lapic_timer_period == 0;
> >  }
> >  
> > +void apic_set_timer_period_khz(u64 period_khz, const char *source)
> > +{
> > +	lapic_timer_period = mul_u64_u32_div(period_khz, 1000, HZ);
> > +}
> > +
> > +void apic_set_timer_period_hz(u64 period_hz, const char *source)
> > +{
> > +	lapic_timer_period = div_u64(period_hz, HZ);
> > +}
> 
> [Severity: Medium]
> It looks like the source parameter is accepted by apic_set_timer_period_khz()
> and apic_set_timer_period_hz() in arch/x86/kernel/apic/apic.c but is never
> used. Was it intended to log the frequency using this source string?

/facepalm, yes.

