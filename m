Return-Path: <linux-hyperv+bounces-11519-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hjUbAdL3I2rX0gEAu9opvQ
	(envelope-from <linux-hyperv+bounces-11519-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 06 Jun 2026 12:34:58 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F88564D18C
	for <lists+linux-hyperv@lfdr.de>; Sat, 06 Jun 2026 12:34:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="IXyU/D82";
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11519-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11519-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4BD6C301A7F2
	for <lists+linux-hyperv@lfdr.de>; Sat,  6 Jun 2026 10:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B02BB37BE6D;
	Sat,  6 Jun 2026 10:34:54 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A552330BF67;
	Sat,  6 Jun 2026 10:34:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780742094; cv=none; b=nW+NAVuUxTN5tkfbtl2VsBeOOC3S/F0Zol4hRFIwI9akk07x9ToOifVG6G4eybPYTRPiGOvSNaX2zpLI5FxO421WYXY+ZXiMwwyrWflB7A0YAiwpr9gOFROQuiop5+jupy18Tc7YoYZuLPcI+A67mymFOFE/cE/7OxAB6ZMrLXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780742094; c=relaxed/simple;
	bh=HjP63eMiZ3E5RbC63Wf6TIubQrzpeHmhV/E4yWzmoPo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=D3YuNyolnDqVE55m6+VWl8Jnfi8wcIWn0uPjD9WxkuNr3W92eAgLAGBOHjqSsYjZIpaaLTOzqlRFpA5OuFJcuKO3ofIWFIFJZMsCrwB50yMhkuFeZpMvZ4CqsPGN2f30055jYJDm0nHE45WSob8xJgjLh6rifO/JzhMa/ileXsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IXyU/D82; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EDCD1F00898;
	Sat,  6 Jun 2026 10:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780742093;
	bh=NtWrycsv8R2U43lwkz14BzyHb4n6w50k0ikzyF9jV3E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=IXyU/D8264eSLC2QDbXcAcYtJaBaXZQFhc3eMNaexij+8rWkr00hLcCxbU8sE+dyX
	 mA+0vh4jhmQewxXtcNgNlHzXYQxy3xltXkTXAvckzwoIzIHRe33MgJj8Z/eoKIZg7/
	 OS3AcAdgYKZfgsMlvmrE9ixBzNG2b9ZZdmXOqeb5AoGkbbvWGXnmwwu7r9FDGH7MPJ
	 /ags4E/71IJXIaZDB2vgU6XhD0IfqTYGjQGdAaEMrOXXRxdiQY3pri70AgZucTGyCC
	 26QCAArNsLQlKTvztPntE64Lex8sfSLNWgTTXMw3c1CK7vs7qdGaoXt7ZZuAKprlo6
	 2CEQuUIqJnPEA==
From: Thomas Gleixner <tglx@kernel.org>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 Kiryl Shutsemau <kas@kernel.org>, Sean Christopherson <seanjc@google.com>,
 "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang
 <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
 <decui@microsoft.com>, Long Li <longli@microsoft.com>, Ajay Kaher
 <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, John Stultz
 <jstultz@google.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Rick Edgecombe
 <rick.p.edgecombe@intel.com>, Vitaly Kuznetsov <vkuznets@redhat.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Boris Ostrovsky
 <boris.ostrovsky@oracle.com>, Stephen Boyd <sboyd@kernel.org>,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-coco@lists.linux.dev, linux-hyperv@vger.kernel.org,
 virtualization@lists.linux.dev, xen-devel@lists.xenproject.org, David
 Woodhouse <dwmw@amazon.co.uk>, Tom Lendacky <thomas.lendacky@amd.com>,
 Nikunj A Dadhania <nikunj@amd.com>, David Woodhouse <dwmw2@infradead.org>,
 Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v4 10/47] x86/tsc: Consolidate forcing of
 X86_FEATURE_TSC_KNOWN_FREQ for PV code
In-Reply-To: <20260529144435.704127-11-seanjc@google.com>
References: <20260529144435.704127-1-seanjc@google.com>
 <20260529144435.704127-11-seanjc@google.com>
Date: Sat, 06 Jun 2026 12:34:50 +0200
Message-ID: <877boc554l.ffs@fw13>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11519-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:seanjc@google.com,m:pbonzini@redhat.com,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:x86@kernel.org,m:kas@kernel.org,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:longli@microsoft.com,m:ajay.kaher@broadcom.com,m:alexey.makhalov@broadcom.com,m:jan.kiszka@siemens.com,m:luto@kernel.org,m:peterz@infradead.org,m:jgross@suse.com,m:daniel.lezcano@kernel.org,m:jstultz@google.com,m:hpa@zytor.com,m:rick.p.edgecombe@intel.com,m:vkuznets@redhat.com,m:bcm-kernel-feedback-list@broadcom.com,m:boris.ostrovsky@oracle.com,m:sboyd@kernel.org,m:kvm@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-coco@lists.linux.dev,m:linux-hyperv@vger.kernel.org,m:virtualization@lists.linux.dev,m:xen-devel@lists.xenproject.org,m:dwmw@amazon.co.uk,m:thomas.lendacky@amd.com,m:nikunj@amd.com,m:dwmw2@infradead.org,m:mhklinux@outlook.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[tglx@kernel.org,linux-hyperv@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[38];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[zytor.com,intel.com,redhat.com,broadcom.com,oracle.com,kernel.org,vger.kernel.org,lists.linux.dev,lists.xenproject.org,amazon.co.uk,amd.com,infradead.org,outlook.com];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5F88564D18C

On Fri, May 29 2026 at 07:43, Sean Christopherson wrote:

> Now that all paravirt code that explicitly specifies the TSC frequency
> also sets X86_FEATURE_TSC_KNOWN_FREQ, replace all of the one-off code
> and simply set X86_FEATURE_TSC_KNOWN_FREQ if the TSC frequency is known.
>
> Do NOT force set TSC_KNOWN_FREQ if the "known" TSC frequency was provided
> by the user.  Per commit bd35c77e32e4 ("x86/tsc: Add tsc_early_khz command
> line parameter"), one of the goals of the param is to allow the refined
> calibration work "to do meaningful error checking".
>
> Note, preferring the user-provided TSC frequency over the frequency from
> the hypervisor or trusted firmware, while simultaneously not treating the
> user-provided frequency as gospel, is obviously incongruous.  Sweep the
> problem under the rug for now to avoid opening a big can of worms that
> likely doesn't have a great answer.

There is a good answer I think.

early_tsc_khz exists to cater for the overclocking crowd. On their
modded systems the firmware supplied TSC frequency (CPUID/MSR) is not
matching reality anymore. So they work around that by supplying a close
enough tsc_early_khz and then they let the refined calibration work
figure it out.

Arguably that's only relevant for bare metal systems and what's worse is
that in virtual environments the refined calibration work can fail,
which renders the TSC unstable.

So I'd rather say we change this logic to:

   if (!hypervisor_is_type(X86_HYPER_NATIVE)) {
      tsc_khz = x86_init.....();
      force(X86_FEATURE_TSC_KNOWN_FREQ);
   } else if (tsc_khz_early) {
      ....
   } else {
      ...
   }

Along with:

   if (!hypervisor_is_type(X86_HYPER_NATIVE)) {
      if (tsc_khz_early)
         pr_warn("Ignoring non-sensical tsc_early_khz command line argument\n");

or something daft like that.

The kernel has for various reasons always tried to cater for the needs
of users who are plagued by bonkers firmware, but we have to stop to
prioritize or treating equal ancient and modded out of spec hardware.

TBH, I consider that whole KVM clock nonsense to fall into the modded
out of spec hardware realm. Do a reality check:

   How many production systems are out there still which run VMs on CPUs
   with a broken TSC and the lack of VM TSC scaling?

I'm not saying that we should not support the few remaining systems
anymore, but our tendency to pretend that we can keep all of this
nonsense working and at the same time making progress is just a fallacy.

I rather want to have a more fine grained differentiation and
prioritization of:

  1) The actual real world relevant use cases which run on contemporary
     hardware.

  2) Still relevant use cases on slightly older hardware with less
     capabilities

  3) Broken firmware

  4) Modded out of spec nonsense

  5) Support for ancient museums pieces

Thanks,

        tglx


