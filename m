Return-Path: <linux-hyperv+bounces-845-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E31C47E7DE2
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Nov 2023 17:46:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64364B20B8D
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Nov 2023 16:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEB6C1C28B;
	Fri, 10 Nov 2023 16:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="ToYM090u"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6492C1BDCF
	for <linux-hyperv@vger.kernel.org>; Fri, 10 Nov 2023 16:46:32 +0000 (UTC)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F12402CA;
	Fri, 10 Nov 2023 08:46:30 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9358840E0171;
	Fri, 10 Nov 2023 16:46:28 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id TGPINipzUHj7; Fri, 10 Nov 2023 16:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1699634786; bh=JUqXfIl2aJ3yi39DSTCcAtl55Qh/0ovFMl0zKxrn3v8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ToYM090uUe+2uveT7TshG5L7aKSU7Ss1Yhuf+ojmTXE3RD50TsMw7qbabY6wxVv3c
	 ltdltMhX7t8yt/eEgX67d3/LUsBaYxVir5wKOsGVEqVl9IgNPiPXt1aRcS2b81Nbm5
	 eLp+D93DECdiR2Ta1RWT8z46Tqm6XpSWof20PEhx85K28HzsvkuJNKeOBjqDhfQ9uO
	 s9xjjmQp2I8RGYzOjaZvWEY24ULTJxTC8IEH0L1kRBJTDYSawlrwECznCK1IaArd80
	 IdRp1bsfv71QFU3Jz+HUjwd2XlBhi7U5B9ZvvwNOYvZmknIRns7x7T6Q55+AeGZB+0
	 ajHryKPuaRIakCNeCK7teOjVGCD2SZHGgKS5IPpmw+n55UfQPi91FBc/N2jie5+d6P
	 GUACcvi/SZE3NAQH+/yqUWgS+txq9A25PPcIsue2v01+fCH6u3MryDr3BR+Sk40J0E
	 FnJECWRlBsayzC0GaYQ8devtzNdbZzWhfVzDkAgSGbihK//XhamdtOnMEPeeMRKq0i
	 lNQ/3ldYWP0NIkB73KZoGPI130cuzoK+D/TLEJ2WNCjnFCdDPs+pq2wRmkcH3HG6Fj
	 0yuax/L3Nx97h26gDpwpRpvDCs/LA/t6lZwTAhce9i5IKbKhNJLjy99+mEreFbZbyG
	 xCc4RtxUSqltegTL1ScoBxlg=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EC38240E014B;
	Fri, 10 Nov 2023 16:46:03 +0000 (UTC)
Date: Fri, 10 Nov 2023 17:45:57 +0100
From: Borislav Petkov <bp@alien8.de>
To: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
Cc: Dave Hansen <dave.hansen@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
	Michael Kelley <mhklinux@outlook.com>,
	Dexuan Cui <decui@microsoft.com>, linux-hyperv@vger.kernel.org,
	stefan.bader@canonical.com, tim.gardner@canonical.com,
	roxana.nicolescu@canonical.com, cascardo@canonical.com,
	kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	kirill.shutemov@linux.intel.com, sashal@kernel.org
Subject: Re: [PATCH] x86/mm: Check cc_vendor when printing memory encryption
 info
Message-ID: <20231110164557.GBZU5eRRj9x6dOVOaH@fat_crate.local>
References: <1699546489-4606-1-git-send-email-jpiotrowski@linux.microsoft.com>
 <16ea75a9-8c94-4665-ae04-32d08aa4ebb2@intel.com>
 <58abbc79-64d4-41f9-9fd2-1de7826fbbf6@linux.microsoft.com>
 <ee9de366-6027-495a-98d9-b8b0cd866bf2@intel.com>
 <df95817a-4859-443a-9ac2-b09f102aff30@linux.microsoft.com>
 <20231110131715.GAZU4tW2cJrGoLPmKl@fat_crate.local>
 <73b51be2-cc60-4818-bdba-14b33576366d@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <73b51be2-cc60-4818-bdba-14b33576366d@linux.microsoft.com>

On Fri, Nov 10, 2023 at 04:51:43PM +0100, Jeremi Piotrowski wrote:
> What's semi-correct about checking for CC_VENDOR_INTEL and then
> printing Intel?  I can post a v2 that checks CC_ATTR_GUEST_MEM_ENCRYPT
> before printing "TDX".

How is it that you're not seeing the conflict:

Your TD partitioning guest *is* a TDX guest so X86_FEATURE_TDX_GUEST
should be set there. But it isn't. Which means, that is already wrong.
Or insufficient.

	 if (cc_vendor == CC_VENDOR_INTEL)

just *happens* to work for your case.

What the detection code should do, rather, is:

	if (guest type == TD partioning)
		set bla;
	else if (TDX_CPUID_LEAF_ID)
		"normal" TDX guest;

and those rules need to be spelled out so that everyone is on the same
page as to how a TD partitioning guest is detected, how a normal TDX
guest is detected, a SEV-ES, a SNP one, yadda yadda.

> The paravisor *is* telling the guest it is running on one - using a CPUID leaf
> (HYPERV_CPUID_ISOLATION_CONFIG). A paravisor is a hypervisor for a confidential
> guest, that's why paravisor detection shares logic with hypervisor detection.
> 
> tdx_early_init() runs extremely early, way before hypervisor(/paravisor) detection.

What?

Why can't tdx_early_init() run CPUID(HYPERV_CPUID_ISOLATION_CONFIG) if
it can't find a valid TDX_CPUID_LEAF_ID and set X86_FEATURE_TDX_GUEST
then?

> Additionally we'd need to sprinkle paravisor checks along with
> existing X86_FEATURE_TDX_GUEST checks. And any time someone adds a new
> feature that depends solely on X86_FEATURE_TDX_GUEST we'd run the
> chance of it breaking things.

Well, before anything, you'd need to define what exactly the guest kernel
needs to do when running as a TD partitioning guest and how exactly that
is going to be detected and checked using the current cc_* and
cpufeatures infra. If it doesn't work with the current scheme, then the
current scheme should be extended.

Then, that should be properly written out:

"if bit X is set, then that is a guest type Y"
"if feature foo present, then so and so are given"

If the current guest type detection is insufficient, then that should be
extended/amended.

That's the only viable way where the kernel would support properly and
reliably a given guest type. There'll be no sprinkling of checks
anywhere.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

