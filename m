Return-Path: <linux-hyperv+bounces-11572-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id c+ivERVrKGrCDwMAu9opvQ
	(envelope-from <linux-hyperv+bounces-11572-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 09 Jun 2026 21:35:49 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DEA94663C8C
	for <lists+linux-hyperv@lfdr.de>; Tue, 09 Jun 2026 21:35:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=oStFu7N1;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11572-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11572-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 82F7B3167E14
	for <lists+linux-hyperv@lfdr.de>; Tue,  9 Jun 2026 19:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE9B40D565;
	Tue,  9 Jun 2026 19:27:21 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A28E40D563;
	Tue,  9 Jun 2026 19:27:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781033241; cv=none; b=ZvJesJiFIUXFlLDampdEzu+7GP/D17kTBcL1fsK2IMMTvKLIxJsO3ovVRKOiIrWJwk3kcT8pRVrPWTRl2eaYkoytpjpQ4O3p56bzQcT7VK91i9vcXGI+ORUy2BB7sLpRkR67TBbkIb8R7+GB4UPZlpqweG3o3X0lNgHDFYWkwcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781033241; c=relaxed/simple;
	bh=t+WvsS2QinBoSI2OXuMQMgk8edo+7KuSw0OLqOxN6Rg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IVgU5P6rmoZciOVsOTN3IRAWS55dc6O39hgR80XPKrGSni9c4h4+dRonQasdjLJXZB9rWtC8EjQt8XAc3HphLtbfjAKw5fDioc5TrRgHk/tRD16oBtsuwyrR/CpWmTKyE4CfDElbAbEnA4WUbXyP5WYsXFiYVQSwZzWpxprIbGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oStFu7N1; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D2361F0089A;
	Tue,  9 Jun 2026 19:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781033239;
	bh=NlG5HlDElQCbuP6bN10xR/q116+/zHdLSEjJOyQFwVw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=oStFu7N1msk7hGRxaIGxcPhSkCbArM8aV/psZO+WarZaxilvwF2cpbMRAt4n7Fpb8
	 jdoLMC/Us2am6UlMm/XjVRtHxd9CKSOXzbAPqtoDlCiOpZbpOFQ+SdLvuk0GQ7AACZ
	 3CmrygZjXjo8BSZ2RdYoEHPzauVhH2OoyWisV2Oubk42MoerR11HkIf28Ex0JbwmFs
	 FQo5z4rMOOXRCRjhYFFjZN0UvGaCt0DcbGJcLs9foFY3WZlZjLxuhnEKgDEnd+uRNU
	 itpIBzoF6ZpH4lsa9xtkX9k8gZsXaOt9VgUNb/27eAHzLLvBE62W766RQhGapY7M0m
	 b9tzm1j9ME+sA==
From: Thomas Gleixner <tglx@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, Kiryl Shutsemau <kas@kernel.org>, "K. Y. Srinivasan"
 <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
 <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Long Li
 <longli@microsoft.com>, Ajay Kaher <ajay.kaher@broadcom.com>, Alexey
 Makhalov <alexey.makhalov@broadcom.com>, Jan Kiszka
 <jan.kiszka@siemens.com>, Andy Lutomirski <luto@kernel.org>, Peter
 Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>, Daniel
 Lezcano <daniel.lezcano@kernel.org>, John Stultz <jstultz@google.com>, "H.
 Peter Anvin" <hpa@zytor.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, Broadcom internal kernel review
 list <bcm-kernel-feedback-list@broadcom.com>, Boris Ostrovsky
 <boris.ostrovsky@oracle.com>, Stephen Boyd <sboyd@kernel.org>,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-coco@lists.linux.dev, linux-hyperv@vger.kernel.org,
 virtualization@lists.linux.dev, xen-devel@lists.xenproject.org, David
 Woodhouse <dwmw@amazon.co.uk>, Tom Lendacky <thomas.lendacky@amd.com>,
 Nikunj A Dadhania <nikunj@amd.com>, David Woodhouse <dwmw2@infradead.org>,
 Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v4 01/47] x86/tsc: Never re-calibrate TSC frequency if
 its exact timing is known
In-Reply-To: <aihKj-0nP7bUbNHH@google.com>
References: <20260529144435.704127-1-seanjc@google.com>
 <20260529144435.704127-2-seanjc@google.com> <87fr315fq9.ffs@fw13>
 <aiMPxl5vkvJDldi9@google.com> <87a4t86a0l.ffs@fw13>
 <aihKj-0nP7bUbNHH@google.com>
Date: Tue, 09 Jun 2026 21:27:17 +0200
Message-ID: <87pl1z346i.ffs@fw13>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[37];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11572-lists,linux-hyperv=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:seanjc@google.com,m:pbonzini@redhat.com,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:x86@kernel.org,m:kas@kernel.org,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:longli@microsoft.com,m:ajay.kaher@broadcom.com,m:alexey.makhalov@broadcom.com,m:jan.kiszka@siemens.com,m:luto@kernel.org,m:peterz@infradead.org,m:jgross@suse.com,m:daniel.lezcano@kernel.org,m:jstultz@google.com,m:hpa@zytor.com,m:rick.p.edgecombe@intel.com,m:vkuznets@redhat.com,m:bcm-kernel-feedback-list@broadcom.com,m:boris.ostrovsky@oracle.com,m:sboyd@kernel.org,m:kvm@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-coco@lists.linux.dev,m:linux-hyperv@vger.kernel.org,m:virtualization@lists.linux.dev,m:xen-devel@lists.xenproject.org,m:dwmw@amazon.co.uk,m:thomas.lendacky@amd.com,m:nikunj@amd.com,m:dwmw2@infradead.org,m:mhklinux@outlook.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[tglx@kernel.org,linux-hyperv@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[redhat.com,alien8.de,linux.intel.com,kernel.org,microsoft.com,broadcom.com,siemens.com,infradead.org,suse.com,google.com,zytor.com,intel.com,oracle.com,vger.kernel.org,lists.linux.dev,lists.xenproject.org,amazon.co.uk,amd.com,outlook.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tglx@kernel.org,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fw13:mid,vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DEA94663C8C

On Tue, Jun 09 2026 at 10:17, Sean Christopherson wrote:

> On Fri, Jun 05, 2026, Thomas Gleixner wrote:
>> On Fri, Jun 05 2026 at 11:04, Sean Christopherson wrote:
>> But we also should have a check in the TSC init code somewhere which
>> validates that X86_FEATURE_CONSTANT_TSC is set when
>> X86_FEATURE_TSC_KNOWN_FREQ is set. X86_FEATURE_TSC_KNOWN_FREQ is useless
>> w/o X86_FEATURE_CONSTANT_TSC.
>
> Ugh, any objection to punting on this for now?  KVM and Xen guests will trigger
> TSC_KNOWN_FREQ without CONSTANT_TSC, thanks to commits:
>
>   e10f78050323 ("kvmclock: fix TSC calibration for nested guests")
>   898ec52d2ba0 ("x86/xen/time: Set the X86_FEATURE_TSC_KNOWN_FREQ flag in xen_tsc_khz()")
>
> Hyper-V guests might as well?  Hyper-V's handling of TSC is weird, even for a
> hypervisor.

Hypervisors are ranked by weirdness? I ranked them by insanity so far.

> Even when the frequency is provided in CPUID by the hypervisor, QEMU at least
> requires a fairly explicit opt-in to advertise CONSTANT_TSC, presumably to try
> to prevent users from shooting themselves in the foot.

Bah. We really should have enforced the dependency when we introduced
KNOWN_FREQ. But that ship has sailed.

Though for correctness sake this should be fixed at some point in the
foreseeable future.

Thanks,

        tglx

