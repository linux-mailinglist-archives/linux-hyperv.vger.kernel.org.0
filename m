Return-Path: <linux-hyperv+bounces-11146-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id VpNSH+tyD2r4MQYAu9opvQ
	(envelope-from <linux-hyperv+bounces-11146-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 May 2026 23:02:35 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EF9E75ABFB7
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 May 2026 23:02:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5F185303517C
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 May 2026 21:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4412F0C7E;
	Thu, 21 May 2026 21:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wfVAlRkM"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB3927FD4B
	for <linux-hyperv@vger.kernel.org>; Thu, 21 May 2026 21:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779397299; cv=none; b=O6eI+BskG0dCWEQqqFSuYYnK1Pb6PwaVR+J7kKhYk3l6w3fpc+wlwcWOJrHG7QiZTFYUYoKMeuGvcKDHV8ev3RJU8haAmPaec2ot+1euA6dclCibJDHW43hxQeINHo5tzesrhhRhdaZ4Qc3QRqUxZ7wnT7CN8pkS1K5XKanv0dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779397299; c=relaxed/simple;
	bh=UTNkbHY7Wjr/dyzbQ6GvUNv1NaEz32luLYEXfy53m6g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lCtrfSV2MfEI5inZbwmpDRcqlSQtBSKDUDAXyo5jijwgsf9qPJqsXQdj2tR2W/TEn7CGD3giWDQTzJaB2rjSL//7LBA1m9j3GBKXHSzONybU6fPahPCBOlxfjOF+Z866mUtDzgXEsP+JCf+hKClLzTxC98LxBbP/C+ehBrgmx00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wfVAlRkM; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2bd04e4fe3dso117368145ad.3
        for <linux-hyperv@vger.kernel.org>; Thu, 21 May 2026 14:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779397297; x=1780002097; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iN4mR6FXbVUwqAWLl+PlqYFyvLBNkg9d4d7Akdf1bJQ=;
        b=wfVAlRkMMi++w6FbMd9oQljMwwaCBGt5owpEcCpEAV12tm/S4r2s2ncFxE458a//lw
         DRQNaNbiUAQNoPxk4gjcsj016JT+E+YH+PSye3fkZiwXwnrPoThhO9qym2JJ/C/5i46q
         xWWgSB1APUG6v0nZC/n09TLf87WbTDNxdPw+icitr6KyD1NXRTaNVdeE3BjTBl4vMmDo
         OW+khRn9a6iSxok1m6hbqBiU1WcDxtv73H1ma4qMpcYJ5OQSajIbGIGXWTbYjs3EXl8E
         Ql3SIKQTnTe4mZS7aemLCXkUK6klGNz8bn0f2vq+FpMmuwC5Ly2n4ipfAc8KCaIr5E2G
         to4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779397297; x=1780002097;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iN4mR6FXbVUwqAWLl+PlqYFyvLBNkg9d4d7Akdf1bJQ=;
        b=P/ktS0Ejqrg4RHrg82vb0mcNjX47R1hfscdpDRB05yHHnSG2TFpPpnYuY4hLEUmVdV
         022gEh49zpgRqQvQrxzd6bJBc+DItkVa6XhR0g6jNlpSGlkng6/wSCvbdpgEiIv52N/e
         EagQycvvHMeGiQPXpOCO519w8aMDcgX3Y6NbvCRRsI9FepQmz3dF2CdTzZclkLZgTWIh
         uwsnyK+1245HkEF9CRVMOKo5uJfbohAFNPcQmGH0m3pWxTu+5DkXNXM3DKjLP8CQ1MnC
         sUzeXs5+dpagmhX+U0zkTJuYHAAVgsFgGt0/b5YCYV6/C4H2pmjwo0z0jJz1IHBBTjsW
         +sOA==
X-Forwarded-Encrypted: i=1; AFNElJ8ASLoZkO0rPl4ppXsjCOS9r7ant+INhp07CQQx2/f6qi41G3bPDF/7WhCPPrMNb7KV0mGoLrmzYzscKQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcrhDBcoKipphAv7uTTZOz55P03ENfjn4EB0TnhubniSK7l21T
	Ok/hJZkiehrMFvDLaU81ZRdHDMyx4BYPk6wcubMBjtXtCW6WMxwQfZ5XkpF5kDhEFpeiPsTafyE
	pPjv55A==
X-Received: from plge10.prod.google.com ([2002:a17:902:cf4a:b0:2bd:40d4:e407])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e84c:b0:2ba:4ad9:70f6
 with SMTP id d9443c01a7336-2beb06aa272mr6036375ad.31.1779397296608; Thu, 21
 May 2026 14:01:36 -0700 (PDT)
Date: Thu, 21 May 2026 14:01:35 -0700
In-Reply-To: <c54fd01b-fe22-4c9c-8d5f-5b317de07a40@oracle.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260515191942.1892718-1-seanjc@google.com> <20260515191942.1892718-38-seanjc@google.com>
 <c54fd01b-fe22-4c9c-8d5f-5b317de07a40@oracle.com>
Message-ID: <ag9yryEe0A7_AZCT@google.com>
Subject: Re: [PATCH v3 37/41] x86/kvmclock: Use TSC for sched_clock if it's
 constant and non-stop
From: Sean Christopherson <seanjc@google.com>
To: Dongli Zhang <dongli.zhang@oracle.com>
Cc: kvm@vger.kernel.org, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stephen Boyd <sboyd@kernel.org>, x86@kernel.org, 
	linux-coco@lists.linux.dev, linux-hyperv@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	xen-devel@lists.xenproject.org, Kiryl Shutsemau <kas@kernel.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	John Stultz <jstultz@google.com>, Michael Kelley <mhklinux@outlook.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>, 
	Thomas Gleixner <tglx@linutronix.de>, David Woodhouse <dwmw@amazon.co.uk>
Content-Type: text/plain; charset="us-ascii"
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11146-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,redhat.com,broadcom.com,oracle.com,kernel.org,lists.linux.dev,lists.xenproject.org,microsoft.com,siemens.com,linux.intel.com,infradead.org,suse.com,google.com,outlook.com,amd.com,linutronix.de,amazon.co.uk];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[35];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanjc@google.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: EF9E75ABFB7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026, Dongli Zhang wrote:
> On 2026-05-15 12:19 PM, Sean Christopherson wrote:
> > Prefer the TSC over kvmclock for sched_clock if the TSC is constant,
> > nonstop, and not marked unstable via command line.  I.e. use the same
> > criteria as tweaking the clocksource rating so that TSC is preferred over
> > kvmclock.  Per the below comment from native_sched_clock(), sched_clock
> > is more tolerant of slop than clocksource; using TSC for clocksource but
> > not sched_clock makes little to no sense, especially now that KVM CoCo
> > guests with a trusted TSC use TSC, not kvmclock.
> > 
> >         /*
> >          * Fall back to jiffies if there's no TSC available:
> >          * ( But note that we still use it if the TSC is marked
> >          *   unstable. We do this because unlike Time Of Day,
> >          *   the scheduler clock tolerates small errors and it's
> >          *   very important for it to be as fast as the platform
> >          *   can achieve it. )
> >          */
> > 
> > The only advantage of using kvmclock is that doing so allows for early
> > and common detection of PVCLOCK_GUEST_STOPPED, but that code has been
> > broken for over two years with nary a complaint, i.e. it can't be
> > _that_ valuable.  And as above, certain types of KVM guests are losing
> > the functionality regardless, i.e. acknowledging PVCLOCK_GUEST_STOPPED
> > needs to be decoupled from sched_clock() no matter what.
> 
> Has it been broken for two years because of pvclock_clocksource_read_nowd()?

Yep.  Because pvclock_clocksource_read_nowd() ignores PVCLOCK_GUEST_STOPPED, the
flag only ever gets recognized when the kernel reads WALL_CLOCK, which AFAICT
only happens at initial boot, and during suspend and resume.

