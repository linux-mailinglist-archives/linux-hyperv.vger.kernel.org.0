Return-Path: <linux-hyperv+bounces-11260-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gE7SIg51F2ruFggAu9opvQ
	(envelope-from <linux-hyperv+bounces-11260-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 May 2026 00:49:50 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 22EA15EAC14
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 May 2026 00:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DB8EA3033CCC
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 May 2026 22:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 081AA3C278A;
	Wed, 27 May 2026 22:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MqqBbfkJ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE54635F17D;
	Wed, 27 May 2026 22:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779922187; cv=none; b=ITCuYQvPXjMozKN+idRfCl9+Kuls7oW/6ACryDiPP52OpdwYjBCH+rFTDLfWaJQnGID8Xz2fG0ZDssX7MAiy59YBwItTe1+Rn3bwNArRY1q+XIIpqMJaltnS4IUjpyykUUgmR9frvAAZkIwhN2wJnZyakCBp9a6AdM/KeDLGTAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779922187; c=relaxed/simple;
	bh=KtFelpS9nbEgkSq4qXDM+PrUibfrIeX6yvcd9MkIPl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jUTmCVdEnjSFvQ/tqXhLVSn0fq3p2iSRozcDr0JLRaQ+2BqChpqHVzwAkLpYE15QCVjBXQyGWdMLF2W4NT3npondLbdQZfzIfn9srlGm4gKcUR/4bUKDc+zu93TyWvuIpL8n+FZdGYzlQCGYgXrYhK1RovpT9vG1nkyKn8ok3BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MqqBbfkJ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 180FC1F000E9;
	Wed, 27 May 2026 22:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779922186;
	bh=PY5zeAH8y8I+c7aveQ6/4ps0vQuGZRIQexgIvS04kLE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MqqBbfkJx/shQqdeO9/KsHJy4We2GaKKrTHbovtoy7c0zosO/jO0tGRiPceiIG5+s
	 a1JYeWFhAby4DWgTTEXuqbDyCOkxMwUhAxfGM5PCaqjRt9r7QOhVzAGfFnRoDKXg6L
	 ssoMdsyAY1euJRcKfqd209ZkXJvcvSEb79oqwuXw5oIf+Nr8Pq3wf4a5e80L7dZWKQ
	 Cfb/8lo79/THtKbxFZ6vLBwwoBWbMuiXrMeywVycKsxsDSk67yPsJE4dhqW5s4PZje
	 4Fh++pIU91lkpV8gh+LMBLPMBTritQSSL5e/Q1NZaGgaAq0m6tfH9LkDG1y/GGUMx5
	 4afVkea7mmrzg==
Date: Wed, 27 May 2026 15:49:44 -0700
From: Wei Liu <wei.liu@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Kiryl Shutsemau <kas@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Juergen Gross <jgross@suse.com>,
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
	Thomas Gleixner <tglx@linutronix.de>,
	David Woodhouse <dwmw@amazon.co.uk>
Subject: Re: [PATCH v3 07/41] clocksource: hyper-v: Register sched_clock
 save/restore iff it's necessary
Message-ID: <20260527224944.GE3518940@liuwe-devbox-debian-v2.local>
References: <20260515191942.1892718-1-seanjc@google.com>
 <20260515191942.1892718-8-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260515191942.1892718-8-seanjc@google.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11260-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,microsoft.com,broadcom.com,siemens.com,linux.intel.com,infradead.org,suse.com,google.com,intel.com,oracle.com,lists.linux.dev,vger.kernel.org,lists.xenproject.org,outlook.com,amd.com,linutronix.de,amazon.co.uk];
	RCPT_COUNT_TWELVE(0.00)[35];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.liu@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,outlook.com:email,liuwe-devbox-debian-v2.local:mid]
X-Rspamd-Queue-Id: 22EA15EAC14
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 15, 2026 at 12:19:08PM -0700, Sean Christopherson wrote:
> Register the Hyper-V reference counter (refcounter) callbacks for saving
> and restoring its PV sched_clock, if and only if the refcounter is
> actually being used for sched_clock.  Currently, Hyper-V overrides the
> save/restore hooks if the reference TSC available, whereas the Hyper-V
> refcounter code only overrides sched_clock if the reference TSC is
> available *and* it's not invariant.  The flaw is effectively papered over
> by invoking the "old" save/restore callbacks as part of save/restore, but
> that's unnecessary and fragile.
> 
> To avoid introducing more complexity, and to allow for additional cleanups
> of the PV sched_clock code, move the save/restore hooks and logic into
> hyperv_timer.c and simply wire up the hooks when overriding sched_clock
> itself.
> 
> Note, while the Hyper-V refcounter code is intended to be architecture
> neutral, CONFIG_PARAVIRT is firmly x86-only, i.e. adding a small amount of
> x86 specific code (which will be reduced in future cleanups) doesn't
> meaningfully pollute generic code.
> 
> Reviewed-by: Michael Kelley <mhklinux@outlook.com>
> Tested-by: Michael Kelley <mhklinux@outlook.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Acked-by: Wei Liu <wei.liu@kernel.org>

