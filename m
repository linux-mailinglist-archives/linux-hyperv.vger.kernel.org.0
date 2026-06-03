Return-Path: <linux-hyperv+bounces-11463-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NDpICx79H2qatgAAu9opvQ
	(envelope-from <linux-hyperv+bounces-11463-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 03 Jun 2026 12:08:30 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8084F6366AA
	for <lists+linux-hyperv@lfdr.de>; Wed, 03 Jun 2026 12:08:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=beFWDJ7B;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11463-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11463-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3EF1230AFABE
	for <lists+linux-hyperv@lfdr.de>; Wed,  3 Jun 2026 10:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66EFF41B346;
	Wed,  3 Jun 2026 10:02:31 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC353812CD;
	Wed,  3 Jun 2026 10:02:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780480951; cv=none; b=RhX9bLhzA8fz24YqGNwBEe06M0ZT5UCmlsyxKELwkoK8IJPyrL8b+SFq/cBCQlDpMISyWOuc00wbBybtkjUuQ7QqtcsiY5P0HMJW+NGrF+BRrJoVUxwEAWOgKQpeEOUAXdR24FwhKqjwtrDlcL6h/TXjtokB9sbwPQ5pddvOjMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780480951; c=relaxed/simple;
	bh=yXx+rqfeV3LVpiDnFV5kG5jvMFi7X+jyX4MxnENzlnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KJUivPvlFFD2zgt0zSolWniTPgUtRPjNg3Zd7RmMNlPJ1R9sgh55PSWQGrQ0+wNzTIpBjPrqBNp/9MV2ajpmRzh3GUREKQ9RmqY3xJYknSmxQkFA/oMt1hn5BkJYYGrMnEj/Soqn49L72M2UYhIXs/Q4AWJdKB0PvryYhzit3tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=beFWDJ7B; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAF831F00899;
	Wed,  3 Jun 2026 10:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780480950;
	bh=V8fVwdI7wxnksQVE14DY2HWli3Oy9+kR4dG/B9JF5Y8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=beFWDJ7B2Z8xQPvn9v3oqwDDTjYwjPDD45LX8Fy0GRXVmLBpMDP36jy5S40R1f28q
	 +2gsQydDi3fwWtbnyLAkHZ5PPW0v7mM7WsjPx5NRYHlGtERz9nAPfYyqtDLGmr7dO0
	 rTXWbiAYPOd+Cq/w2hk9zXWPbyVL+jvll3FT1tEi4Sj/8C5W8EKs/Vbb6WPWuslBZT
	 BPuTsFmws1TTdsA501ufsflwFE0lG9INBbZGL7xT/82fDc4ezk41axPsGSR6hYx5Lw
	 j4aTVtJYRRHyKNQX5jjw3kqWwXidASZjB1Lv/LyS5NLWnrWN4MRtQRh6tRNnBwwHIo
	 TZVDaRVef7e5Q==
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id 1B503F4007E;
	Wed,  3 Jun 2026 06:02:28 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 03 Jun 2026 06:02:28 -0400
X-ME-Sender: <xms:tPsfauhaxGVEUgsvlHEIwecFN-9ZEF71setn4TDGW-FCZRyQ0LUDyA>
    <xme:tPsfamdy_fjRoYDOeR8cmy-cPfUgoaO8mBFumrmZMVa1jqXBPwZUvuLW59ggNGPh6
    y6Fg25GDh1rZ4Nor5r3OQmW7R6jePR7YEy-XB3OaBYhUGAYnBP5RIw>
X-ME-Received: <xmr:tPsfajmUqQ7cLJ253fvAZjjjhxIAhgwirNcqfwrQkow3MYEGcKhn-5N2p_izhw>
X-ME-Proxy-Cause: dmFkZTGuwFznDiQhelvFQOBp2/9r9H4fxoNNaEmxB6iOaHyiMwffQUPfC1FAZMpbzqIqkk
    CN9TCgwxMINXJSdtTnBkzIXOc6K717wq9QjeaoGXRWKTpKm0u+QpWfmKKW9HN3pL/A1+6p
    92lcvawl98fM5nvrzMFAJ0zCHVpCTPUX+0fcWGBVn0sUJNaILiDyF6WAR5GTLaYBf9LtF9
    HeIJf/jM6FJN5c4MVjb/Nm52s7djeDzHoqhhvyRfCScg4aR0UhUORBt/S3XR36+WsGhT7P
    bVueHPke7HzKjPxs+Lmcr4uF/2Rif/nWiVWI2Sn/X2KEDbfEm3ZjS1qdm+5tHCszTtFFts
    /VzzRZabQfVduEReAlUgkBJ79Z4LSt1cBS+rSnnFi9jDTiczC1H87ZS7qLCKADqoqzrmR4
    mGIz8sa4eqINRsLod/oLKxieYbrnEsfQXN/59nPX9ObnVXbRESfnOCNA6fc+BZp0oeNprP
    PvGGkzDmtovVRJkI3ywAfrhFpNJvUXD0fDzsSJPA0RLCqMYGu9iLwI5MlFSpJg7a/5udeS
    lJZWm/zw2dGecCf6mp/nhd1OdYPK7oDQIXbomfj0Bb9MYjyFb44nJOTTHxAkkFlEu1IJB4
    mvQH42vq4f+lwAhvj17/Vsi6xt4tXviwqxjQO+AmX3bH/ZlUDX8iOWPxS9lA
X-ME-Proxy: <xmx:tPsfaixl8twHiScZRF0l3aPUkADDTTORVWaND_noCCfDud9HhsTR5Q>
    <xmx:tPsfalcLZ32BWK_NdqC_-FR1DBldNJTO6IRNGnlVk2pTTVI454R5Rg>
    <xmx:tPsfajhekMHXMQ6qYg0RgZ4pegrE87GtuiN4Aa5Q13qUrGdoLAXSdw>
    <xmx:tPsfap-OinTX938zNS5LgCJfS2x6J85u1U-3v3h3dj98T7oCnvJ1vg>
    <xmx:tPsfapa94FWneQTrYxrkNAOdSEUGyY-WiNNfJ2K6qxxwDuEUGbG_4uoT>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Jun 2026 06:02:25 -0400 (EDT)
Date: Wed, 3 Jun 2026 11:02:19 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>,
 	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, 	Long Li <longli@microsoft.com>,
 Ajay Kaher <ajay.kaher@broadcom.com>,
 	Alexey Makhalov <alexey.makhalov@broadcom.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, 	Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, 	Juergen Gross <jgross@suse.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>,
 	John Stultz <jstultz@google.com>, "H. Peter Anvin" <hpa@zytor.com>,
 	Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>,
 	Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 	Stephen Boyd <sboyd@kernel.org>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, 	linux-coco@lists.linux.dev,
 linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev,
 	xen-devel@lists.xenproject.org, David Woodhouse <dwmw@amazon.co.uk>,
 	Tom Lendacky <thomas.lendacky@amd.com>,
 Nikunj A Dadhania <nikunj@amd.com>,
 	David Woodhouse <dwmw2@infradead.org>,
 Michael Kelley <mhklinux@outlook.com>,
 	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v4 07/47] x86/tdx: Force TSC frequency with CPUID-based
 info provided by the TDX-Module
Message-ID: <ah_7jEMnqs80gXLG@thinkstation>
References: <20260529144435.704127-1-seanjc@google.com>
 <20260529144435.704127-8-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260529144435.704127-8-seanjc@google.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-11463-lists,linux-hyperv=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[38];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:seanjc@google.com,m:pbonzini@redhat.com,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:x86@kernel.org,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:longli@microsoft.com,m:ajay.kaher@broadcom.com,m:alexey.makhalov@broadcom.com,m:jan.kiszka@siemens.com,m:luto@kernel.org,m:peterz@infradead.org,m:jgross@suse.com,m:daniel.lezcano@kernel.org,m:jstultz@google.com,m:hpa@zytor.com,m:rick.p.edgecombe@intel.com,m:vkuznets@redhat.com,m:bcm-kernel-feedback-list@broadcom.com,m:boris.ostrovsky@oracle.com,m:sboyd@kernel.org,m:kvm@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-coco@lists.linux.dev,m:linux-hyperv@vger.kernel.org,m:virtualization@lists.linux.dev,m:xen-devel@lists.xenproject.org,m:dwmw@amazon.co.uk,m:thomas.lendacky@amd.com,m:nikunj@amd.com,m:dwmw2@infradead.org,m:mhklinux@outlook.com,m:tglx@linutronix.de,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kas@kernel.org,linux-hyperv@vger.kernel.org];
	FREEMAIL_CC(0.00)[redhat.com,kernel.org,alien8.de,linux.intel.com,microsoft.com,broadcom.com,siemens.com,infradead.org,suse.com,google.com,zytor.com,intel.com,oracle.com,vger.kernel.org,lists.linux.dev,lists.xenproject.org,amazon.co.uk,amd.com,outlook.com,linutronix.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,thinkstation:mid];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kas@kernel.org,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8084F6366AA

On Fri, May 29, 2026 at 07:43:54AM -0700, Sean Christopherson wrote:
> When running as a TDX guest, explicitly set the TSC frequency to a known
> value, using CPUID-based information, instead of potentially relying on a
> hypervisor-controlled PV routine.  For TDX guests, CPUID.0x15 is always
> emulated by the TDX-Module, i.e. the information from CPUID is more
> trustworthy than the information provided by the hypervisor.

Right. EBX is configurable by TD_PARAMS.TSC_FREQUENCY at TD build. The
rest is fixed.

> To maintain backwards compatibility with TDX guest kernels that use native
> calibration, and because it's the least awful option, retain
> native_calibrate_tsc()'s stuffing of the local APIC bus period using the
> core crystal frequency.  While it's entirely possible for the hypervisor
> to emulate the APIC timer at a different frequency than the core crystal
> frequency, the commonly accepted interpretation of Intel's SDM is that APIC
> timer runs at the core crystal frequency when that latter is enumerated via
> CPUID:
> 
>   The APIC timer frequency will be the processor’s bus clock or core
>   crystal clock frequency (when TSC/core crystal clock ratio is enumerated
>   in CPUID leaf 0x15).
> 
> If the hypervisor is malicious and deliberately runs the APIC timer at the
> wrong frequency, nothing would stop the hypervisor from modifying the
> frequency at any time, i.e. attempting to manually calibrate the frequency
> out of paranoia would be futile.

Agreed.

> Deliberately leave CPU frequency calibration as is, since the TDX-Module
> doesn't provide any guarantees with respect to CPUID.0x16.

It is fixed to zeros. Sounds like a guarantee to me :P

> Signed-off-by: Sean Christopherson <seanjc@google.com>

Looks sane to me. Including your reasoning about tsc_early_khz= in reply
to Sashiko.

Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

