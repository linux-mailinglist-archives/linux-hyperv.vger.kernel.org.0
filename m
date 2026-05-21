Return-Path: <linux-hyperv+bounces-11127-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8EakLkMQD2qSEgYAu9opvQ
	(envelope-from <linux-hyperv+bounces-11127-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 May 2026 16:01:39 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA2E5A6B49
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 May 2026 16:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB876317E867
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 May 2026 13:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B923C3D9024;
	Thu, 21 May 2026 13:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="q6twZ/qu"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7E33CBE84;
	Thu, 21 May 2026 13:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779369033; cv=none; b=hmeDweIhTcoN8eaqEgNIMbZXoon3OZLCnJGNtFs2vc/8soFWxLHqhecg6BTvFNt7k5dc9Y3EuWTCDbCJfJeGUqzc4SvJiHJLxOPbGBNfsIwzBBkts3CeEPEEd108XsVdbOPnonDAR3R+zdhW4ci/UNeBSQyndmMs4k1Lu/yrHvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779369033; c=relaxed/simple;
	bh=VT9dzTfGcaF6essHmn4pepZHGWKSIQvf7qlg9gzNMqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j1OZA7elhPr9TDvZirTLks49Lv2wUJx98eYCFsIq89RPs+DzkI6tWp/1gyJ3Cr/ytvhpNR6AcPmymfvv2IO3phIjnezl4RT6VBWSdX92iESlS5sREjToUWQYtd/l+/ujzR5KUwn8NGKvThukTpSJK3t0i2gqFo/h/k0IZl4H1Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=q6twZ/qu; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=DA7DVimM8Ck0kNzDR7awZketijLzqktg5UcM679ki4g=; b=q6twZ/quiaPkS7JYDLfYP4oxQR
	kwL3xkWZBEpV2j7C1uN45f/dlF1ZLXrwx+jWqL7SQEvjHcy7/MS8yAxgKbQMJOBppFTgAyijrmCw+
	qsUedKzMdKPt0VHol7Hg5iM2yiOqZHQAzBNQpo0ETgquMSq330OAMMUOL5XazrqdRvIuwmq8fCzvJ
	8w7PV454mMuz+QtTx/4yGia1zkhOm9E43cVzP05eFWXg6UOcrEZyigPUrzrWk0OV5q9ekYN/vFQ9r
	H8UIXCIrcHRZ6j+ZCex3x14hX/FPAOr2uRFQk4MepXZ9vQBQZkKMP2xQUakHd/KfGdD8DmUEqPEFb
	l12Q18Ng==;
Received: from 2001-1c00-8d85-4b00-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:4b00:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQ3AK-00000008VrU-2GqZ;
	Thu, 21 May 2026 13:10:20 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 111F6300446; Thu, 21 May 2026 15:10:19 +0200 (CEST)
Date: Thu, 21 May 2026 15:10:19 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Sean Christopherson <seanjc@google.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Kiryl Shutsemau <kas@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>, Juergen Gross <jgross@suse.com>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, John Stultz <jstultz@google.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Stephen Boyd <sboyd@kernel.org>, x86@kernel.org,
	linux-coco@lists.linux.dev, kvm@vger.kernel.org,
	linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
	Michael Kelley <mhklinux@outlook.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3 27/41] x86/kvmclock: Enable kvmclock on APs during
 onlining if kvmclock isn't sched_clock
Message-ID: <20260521131019.GI3126523@noisy.programming.kicks-ass.net>
References: <20260515191942.1892718-1-seanjc@google.com>
 <20260515191942.1892718-28-seanjc@google.com>
 <423b37f056f0d4d596d5f4cc73802fb1079ecf63.camel@infradead.org>
 <ag8Bpc_uVNrNWqfX@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ag8Bpc_uVNrNWqfX@google.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11127-lists,linux-hyperv=lfdr.de];
	FREEMAIL_CC(0.00)[infradead.org,kernel.org,redhat.com,microsoft.com,broadcom.com,siemens.com,linux.intel.com,suse.com,google.com,intel.com,oracle.com,lists.linux.dev,vger.kernel.org,lists.xenproject.org,outlook.com,amd.com,linutronix.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[infradead.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peterz@infradead.org,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,infradead.org:dkim,noisy.programming.kicks-ass.net:mid]
X-Rspamd-Queue-Id: 2CA2E5A6B49
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026 at 05:59:17AM -0700, Sean Christopherson wrote:
> On Thu, May 21, 2026, David Woodhouse wrote:
> > On Fri, 2026-05-15 at 12:19 -0700, Sean Christopherson wrote:
> > > In anticipation of making x86_cpuinit.early_percpu_clock_init(), i.e.
> > > kvm_setup_secondary_clock(), a dedicated sched_clock hook that will be
> > > invoked if and only if kvmclock is set as sched_clock, ensure APs enable
> > > their kvmclock during CPU online.  While a redundant write to the MSR is
> > > technically ok, skip the registration when kvmclock is sched_clock so that
> > > it's somewhat obvious that kvmclock *needs* to be enabled during early
> > > bringup when it's being used as sched_clock.
> > > 
> > > Plumb in the BSP's resume path purely for documentation purposes.  Both
> > > KVM (as-a-guest) and timekeeping/clocksource hook syscore_ops, and it's
> > > not super obvious that using KVM's hooks would be flawed.  E.g. it would
> > > work today, because KVM's hooks happen to run after/before timekeeping's
> > > hooks during suspend/resume, but that's sheer dumb luck as the order in
> > > which syscore_ops are invoked depends entirely on when a subsystem is
> > > initialized and thus registers its hooks.
> > > 
> > > Opportunsitically make the registration messages more precise to help
> > > debug issues where kvmclock is enabled too late.
> > 
> > That's a hard word to type, isn't it?
> 
> Heh, you have no idea.  I've been "this" close to creating a VIM binding for a
> while, it is time...

'z=' not good enough?


