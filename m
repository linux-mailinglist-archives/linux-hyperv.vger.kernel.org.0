Return-Path: <linux-hyperv+bounces-11511-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id l7HUCdQPI2rThQEAu9opvQ
	(envelope-from <linux-hyperv+bounces-11511-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 05 Jun 2026 20:05:08 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DCA764A6E1
	for <lists+linux-hyperv@lfdr.de>; Fri, 05 Jun 2026 20:05:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=dhhmGlYp;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11511-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11511-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8820A30205DD
	for <lists+linux-hyperv@lfdr.de>; Fri,  5 Jun 2026 18:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B4CF386552;
	Fri,  5 Jun 2026 18:04:59 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABA8390987
	for <linux-hyperv@vger.kernel.org>; Fri,  5 Jun 2026 18:04:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780682699; cv=none; b=kR/MON4/HFYUa74zXQqnLeCl9FX8UDGO1CvBA2Q8YbKohMJLi/e4uwkHcR4R7jlSTaVF3Zg2vCy9+OTTZDlXVfe4sHxoIiDZuu6s3/z7Vc9zaPK++bKhOBCqPP6iL9BbBqLq0UvYk5tCZv8xK7RyyITbfxMO/BOu01BVwVQ860s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780682699; c=relaxed/simple;
	bh=fCJzrdCYp/X/mAcNv+qBAxRieEPHzWXupi+xn0HxO88=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Rmrzr4Ov4TMnOWRZovXXFXW4cIMhRErcxhtb9Yyhs7kjX8qIK5tVxErMBJTJg6oyErZtvfCG9Nf6CkznUGNnlhl+EDsOII/WEv1yHkwCxwBmcuM7OWGFG27PgyRfyfTBmlD+yh3FyTGHsHw7CND43IVOxwT4BBTbQJN6Pf4tdvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dhhmGlYp; arc=none smtp.client-ip=209.85.210.201
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-84256bee9a9so1391181b3a.1
        for <linux-hyperv@vger.kernel.org>; Fri, 05 Jun 2026 11:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780682696; x=1781287496; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zOxp1hSLKBpPLL80bFuxK8SsL52R5IjTb2Bqqq35EAY=;
        b=dhhmGlYpvip0/a7ryW+v3le1CZoR0owUaFdjeKTxxdAmZ6EFzJSIQltQYjUpzQSzbW
         YT+6bcnMtwnoOtjT6Nj67UVZj/zSng3g9YmVQOaa/XzhnC3aI+SL4tksqrG9IyNxebnh
         nztPy6A+YKb9ZUkWM+59tEve5m+Q8SNPZHRWEKbkJRG0LvZ/MTBBDc+jHEFwEa1EZ8pa
         1aVC7dD2CIR6KjG+TUil7dNC1vKDi30MGufegGgT4n92YbDMTEA+LDVKtBSinLbWoOoH
         1FLQUzQw1mMaJrVHw7WlpIpMxJupjiIRp0m4lZ7ihHlyVBfm9A4uaQ9sc77w1xJ9TyBt
         H95g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780682696; x=1781287496;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zOxp1hSLKBpPLL80bFuxK8SsL52R5IjTb2Bqqq35EAY=;
        b=qIaHakl0wwXsF3TPmUyCbZ1BvysAHgzDg4Zyb1lI5p0EbaRlenMAnY/YM+Ow9WsUDS
         FlUwJ0jHJ7PvSHigA3Qm9qTlaUnQ2/pO0JPRF1M8uEB7DXUiWWavN+Ey8oy6M+eU/uNY
         NPUYHPpmn+pVvYJ6Sh/4NqIzdANfQXfQQ+Cz9GjgsrqKODAT69rpw0lv0uTXggxNbEgw
         DjxZ7rbbMuHT6WYz2l4XBZNHJg5Uhu+rZzvShAGm4whY9hSo1kLOKDqq6bYNOYdulDln
         ZeSa1kBuf7sU6X0Dxymkv9YzDIhIF3o+VPb8WrhI+vUzkQ9OFxbhKOYVv6YP8fpaN5bU
         wHFw==
X-Forwarded-Encrypted: i=1; AFNElJ+zLGDXb+0USv/dByENt4JAjexn2Q3agqU7nDGmqgw0leq3lCROPsrOInJcVMNs2WYdDJH0JKECwU5lpPw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy7C13NSkJtzsGuc31Hwp60iCxpfw3hkCbcZUI64ZrKQDYHsxi
	K9hpjDDlzp5C1j1q1E2RakJCmj63CyPmKT/hqei+M0c7EmXQ2EQKDuHXFk8M/CIBTACtYTS7VS1
	VO1dO/g==
X-Received: from pfjq2.prod.google.com ([2002:a05:6a00:882:b0:842:1f0e:d24c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:218e:b0:842:4e43:6f6c
 with SMTP id d2e1a72fcca58-842b0fb60bfmr4509683b3a.39.1780682695567; Fri, 05
 Jun 2026 11:04:55 -0700 (PDT)
Date: Fri, 5 Jun 2026 11:04:54 -0700
In-Reply-To: <87fr315fq9.ffs@fw13>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529144435.704127-1-seanjc@google.com> <20260529144435.704127-2-seanjc@google.com>
 <87fr315fq9.ffs@fw13>
Message-ID: <aiMPxl5vkvJDldi9@google.com>
Subject: Re: [PATCH v4 01/47] x86/tsc: Never re-calibrate TSC frequency if its
 exact timing is known
From: Sean Christopherson <seanjc@google.com>
To: Thomas Gleixner <tglx@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Kiryl Shutsemau <kas@kernel.org>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, John Stultz <jstultz@google.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stephen Boyd <sboyd@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, 
	xen-devel@lists.xenproject.org, David Woodhouse <dwmw@amazon.co.uk>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>, 
	David Woodhouse <dwmw2@infradead.org>, Michael Kelley <mhklinux@outlook.com>
Content-Type: text/plain; charset="us-ascii"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11511-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:tglx@kernel.org,m:pbonzini@redhat.com,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:x86@kernel.org,m:kas@kernel.org,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:longli@microsoft.com,m:ajay.kaher@broadcom.com,m:alexey.makhalov@broadcom.com,m:jan.kiszka@siemens.com,m:luto@kernel.org,m:peterz@infradead.org,m:jgross@suse.com,m:daniel.lezcano@kernel.org,m:jstultz@google.com,m:hpa@zytor.com,m:rick.p.edgecombe@intel.com,m:vkuznets@redhat.com,m:bcm-kernel-feedback-list@broadcom.com,m:boris.ostrovsky@oracle.com,m:sboyd@kernel.org,m:kvm@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-coco@lists.linux.dev,m:linux-hyperv@vger.kernel.org,m:virtualization@lists.linux.dev,m:xen-devel@lists.xenproject.org,m:dwmw@amazon.co.uk,m:thomas.lendacky@amd.com,m:nikunj@amd.com,m:dwmw2@infradead.org,m:mhklinux@outlook.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[seanjc@google.com,linux-hyperv@vger.kernel.org];
	FREEMAIL_CC(0.00)[redhat.com,alien8.de,linux.intel.com,kernel.org,microsoft.com,broadcom.com,siemens.com,infradead.org,suse.com,google.com,zytor.com,intel.com,oracle.com,vger.kernel.org,lists.linux.dev,lists.xenproject.org,amazon.co.uk,amd.com,outlook.com];
	RCPT_COUNT_TWELVE(0.00)[37];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanjc@google.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8DCA764A6E1

On Fri, Jun 05, 2026, Thomas Gleixner wrote:
> On Fri, May 29 2026 at 07:43, Sean Christopherson wrote:
> > Don't re-calibrate the TSC frequency if the TSC is known to run at a fixed
> > frequency.
> 
> That's misleading because fixed frequency means that the frequency does
> not change, i.e. X86_FEATURE_CONSTANT_TSC is set. But
> X86_FEATURE_CONSTANT_TSC does not imply that the frequency can be read
> from CPUID/MSRs.

Sorry, "if the TSC runs at a known, fixed frequency" would be a better way to
phrase this.

> > In practice, this is likely one big nop, as re-calibration is
> > used only for SMP=n kernels, and only for hardware that is 20+ years old,
> > i.e. is extremely unlikely to collide with TSC_KNOWN_FREQ.
> 
> recalibrate_cpu_khz() is only invoked from Intel P4 and AMD K7 CPU
> frequency drivers, which means that's absolutely not interesting and
> neither X86_FEATURE_CONSTANT_TSC nor X86_FEATURE_TSC_KNOWN_FREQ can be
> set on those systems.

It _shouldn't_ be set on those systems, but in the world of virtualization it's
not completely impossible.

> IOW, this patch is pointless voodoo ware.

Would y'all be opposed to adding a WARN?  I don't actually care about P4 or K7
CPUs, but without any reference to X86_FEATURE_TSC_KNOWN_FREQ in
recalibrate_cpu_khz(), the code _looks_ wrong, and so is very confusing for
readers that don't already know that in practice, it's limited to ancient CPUs.

In other words, the point is to document expectations and mutual exclusion, not
to "fix" anything.

