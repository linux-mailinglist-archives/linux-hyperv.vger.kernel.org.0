Return-Path: <linux-hyperv+bounces-8931-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SARCOuGrmGkuKwMAu9opvQ
	(envelope-from <linux-hyperv+bounces-8931-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Feb 2026 19:45:53 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6350F16A2B0
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Feb 2026 19:45:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 06285304A576
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Feb 2026 18:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C84315D35;
	Fri, 20 Feb 2026 18:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="przVzKPL"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F39A1E1DF0;
	Fri, 20 Feb 2026 18:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771613122; cv=none; b=GXdeiRLOh0UEsBrTPGJQsnHGiRNd4au+kXx6GqjxAT8kgnuUd3ZTwDFr1E+UwN3k6eBgEA+9FDxB3e9W5QxFOLzxD7HxqKP6fLveftb8wktTmz3fTAI/EkUik2CNrcHzcAULQTF8P8lV3zT8EoZsahJiNb3sMB6y/auHvC/5BbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771613122; c=relaxed/simple;
	bh=EEhOFL5oCO1RvjxKnk4k68m/uTYFRt2sJQzQHFz9qDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CEHf4HSc4GhIynUNx9z97yu84G5mjcqiqswnmtBZUPIJZiBZnfbHllLjmoHNNRPrSSxj7u8KA4kpxzbIWHLvWNIyRDbN3c40VTyqGp8cY6nAER0ZFpYijBqW6sHmQZi0p5Q+bsQSq+rfDRk5DeIWEaFZQBog7QNCz7jXgXYc0p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=przVzKPL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C74C6C116C6;
	Fri, 20 Feb 2026 18:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771613122;
	bh=EEhOFL5oCO1RvjxKnk4k68m/uTYFRt2sJQzQHFz9qDY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=przVzKPLUewHWaz/jukYf/6XkNrq6PX37XONBQaQ2WKDqwEpB6aQUDcgY7+zcuiMy
	 Dz6bzjNN7OCvJmrF/6j/gLnklM3XBsaNWqc//aFonUL7vxnaAnRktorYFO8+PKl24u
	 1VrRNq+dL8MOi7NlkjD4Ux3hs0LlYysWvxCF2AEQO/mFiZYeOzwvCH5KUM5z336OP1
	 L4Nh57242JS4bf+7WlIu9UB9xaSbxQLAMCM/6P1DxoTtjoMFNK2nVJp0VCNhSQRHmT
	 1Yvfnfjp+NmUJsmGAskQxWQavgDzdvR9+KamCI6ZNh5cGgB9jQVkJ198detspM8VIp
	 HOrsFFeYGTyvA==
Date: Fri, 20 Feb 2026 18:45:20 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Michael Kelley <mhklinux@outlook.com>
Cc: Mukesh R <mrathor@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>,
	"longli@microsoft.com" <longli@microsoft.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>
Subject: Re: [PATCH v2] x86/hyperv: Reserve 3 interrupt vectors used
 exclusively by mshv
Message-ID: <20260220184520.GB3119916@liuwe-devbox-debian-v2.local>
References: <20260217231158.1184736-1-mrathor@linux.microsoft.com>
 <SN6PR02MB41574BE5CE887CADE406BAD3D468A@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB41574BE5CE887CADE406BAD3D468A@SN6PR02MB4157.namprd02.prod.outlook.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8931-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[outlook.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.liu@kernel.org,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,liuwe-devbox-debian-v2.local:mid]
X-Rspamd-Queue-Id: 6350F16A2B0
X-Rspamd-Action: no action

On Fri, Feb 20, 2026 at 05:14:26PM +0000, Michael Kelley wrote:
> From: Mukesh R <mrathor@linux.microsoft.com> Sent: Tuesday, February 17, 2026 3:12 PM
> > 
> > MSVC compiler, used to compile the Microsoft Hyper-V hypervisor currently,
> > has an assert intrinsic that uses interrupt vector 0x29 to create an
> > exception. This will cause hypervisor to then crash and collect core. As
> > such, if this interrupt number is assigned to a device by Linux and the
> > device generates it, hypervisor will crash. There are two other such
> > vectors hard coded in the hypervisor, 0x2C and 0x2D for debug purposes.
> > Fortunately, the three vectors are part of the kernel driver space and
> > that makes it feasible to reserve them early so they are not assigned
> > later.
> > 
> > Signed-off-by: Mukesh Rathor <mrathor@linux.microsoft.com>
> > ---
> > 
> > v1: Add ifndef CONFIG_X86_FRED (thanks hpa)
> > v2: replace ifndef with cpu_feature_enabled() (thanks hpa and tglx)
> > 
> >  arch/x86/kernel/cpu/mshyperv.c | 27 +++++++++++++++++++++++++++
> >  1 file changed, 27 insertions(+)
> > 
> > diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> > index 579fb2c64cfd..88ca127dc6d4 100644
> > --- a/arch/x86/kernel/cpu/mshyperv.c
> > +++ b/arch/x86/kernel/cpu/mshyperv.c
> > @@ -478,6 +478,28 @@ int hv_get_hypervisor_version(union hv_hypervisor_version_info *info)
> >  }
> >  EXPORT_SYMBOL_GPL(hv_get_hypervisor_version);
> > 
> > +/*
> > + * Reserve vectors hard coded in the hypervisor. If used outside, the hypervisor
> > + * will either crash or hang or attempt to break into debugger.
> > + */
> > +static void hv_reserve_irq_vectors(void)
> > +{
> > +	#define HYPERV_DBG_FASTFAIL_VECTOR	0x29
> > +	#define HYPERV_DBG_ASSERT_VECTOR	0x2C
> > +	#define HYPERV_DBG_SERVICE_VECTOR	0x2D
> > +
> > +	if (cpu_feature_enabled(X86_FEATURE_FRED))
> > +		return;
> > +
> > +	if (test_and_set_bit(HYPERV_DBG_ASSERT_VECTOR, system_vectors) ||
> > +	    test_and_set_bit(HYPERV_DBG_SERVICE_VECTOR, system_vectors) ||
> > +	    test_and_set_bit(HYPERV_DBG_FASTFAIL_VECTOR, system_vectors))
> > +		BUG();
> > +
> > +	pr_info("Hyper-V:reserve vectors: %d %d %d\n", HYPERV_DBG_ASSERT_VECTOR,
> > +		HYPERV_DBG_SERVICE_VECTOR, HYPERV_DBG_FASTFAIL_VECTOR);
> 
> I'm a little late to the party here, but I've always seen Intel interrupt vectors
> displayed as 2-digit hex numbers. This info message is displaying decimal,
> which is atypical and will probably be confusing.

Noted. The pull request to Linus has been sent. We will change the
format in a follow up patch.

Wei

