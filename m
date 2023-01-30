Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EEE7681787
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Jan 2023 18:25:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236266AbjA3RZE (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 30 Jan 2023 12:25:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236200AbjA3RZD (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 30 Jan 2023 12:25:03 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 11C0C35258;
        Mon, 30 Jan 2023 09:25:03 -0800 (PST)
Received: by linux.microsoft.com (Postfix, from userid 1112)
        id C675C20E9F9B; Mon, 30 Jan 2023 09:25:02 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C675C20E9F9B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1675099502;
        bh=U3zmQVd/dV9CbqtTiwKT+tUVvaEDxb3+DucgApEqQBQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G7YKSdqWlnYUSasIO1a7qkmzrFRPDsxDhkovl/M6v27qJtKu4E54BiqHUoYe/lYes
         4AZFFqhzINAyGLs8R5bqYazuYqBo7QqP5wnF9o3ecz8UhwmvkSGH+dJ5rVYtOcKpUU
         kvgQD1gfeBJepNyq+T3Vg00f5FDClval7hQakqU8=
Date:   Mon, 30 Jan 2023 09:25:02 -0800
From:   Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jeremi Piotrowski <jpiotrowski@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Michael Roth <michael.roth@amd.com>,
        Ashish Kalra <ashish.kalra@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [RFC PATCH v1 4/6] x86/amd: Configure necessary MSRs for SNP
 during CPU init when running as a guest
Message-ID: <20230130172502.GD27645@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20230123165128.28185-1-jpiotrowski@linux.microsoft.com>
 <20230123165128.28185-5-jpiotrowski@linux.microsoft.com>
 <BYAPR21MB1688094AE8B2D0EA02A17335D7D29@BYAPR21MB1688.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR21MB1688094AE8B2D0EA02A17335D7D29@BYAPR21MB1688.namprd21.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Sun, Jan 29, 2023 at 04:44:05AM +0000, Michael Kelley (LINUX) wrote:
> From: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com> Sent: Monday, January 23, 2023 8:51 AM
> > 
> > Hyper-V may expose the SEV/SEV-SNP CPU features to the guest, but it is
> > up to the guest to use them. early_detect_mem_encrypt() checks
> > SYSCFG[MEM_ENCRYPT] and HWCR[SMMLOCK] and if these are not set the
> > SEV-SNP features are cleared.  Check if we are running under a
> > hypervisor and if so - update SYSCFG and skip the HWCR check.
> > 
> > It would be great to make this check more specific (checking for
> > Hyper-V) but this code runs before hypervisor detection on the boot cpu.
> 
> Could you elaborate on why we would want this check to be Hyper-V
> specific?   Per my comments on Patch 3 of this series, I would think the
> opposite.  If possible, we want code like this to work on any hypervisor,
> and not have Hyper-V specific behavior in code outside of the Hyper-V
> modules.  But I don't know this code well at all, so maybe there's an
> aspect I'm missing.
> 
> Michael
> 

This patch would work for any hypervisor, but I'm not sure every hypervisor
would chose to do things this way. Take the MSR_AMD64_SYSCFG_MEM_ENCRYPT
setting. It could be done like on baremetal with VM BIOS settings, which
wouldn't work well for Hyper-V. The VMM could also simply always return
MSR_AMD64_SYSCFG_MEM_ENCRYPT when it exposes SEV/-ES/-SNP flags to a non-SNP
guest (KVM always returns 0 in SYSCFG right now, and doesn't allow it to be
set).

But ultimately all this function does is mask off SEV/-ES/-SNP CPU flags based
on an assumption that no longer holds, so I think this approach to fixing it is
acceptable. The only thing I would check is whether it's possible to check the
coco attr here as well so that this definitely doesn't run for SNP guests
(provided this information is available at this point).

> > 
> > Signed-off-by: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
> > ---
> >  arch/x86/kernel/cpu/amd.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
> > index c7884198ad5b..17d91ac62937 100644
> > --- a/arch/x86/kernel/cpu/amd.c
> > +++ b/arch/x86/kernel/cpu/amd.c
> > @@ -565,6 +565,12 @@ static void early_detect_mem_encrypt(struct cpuinfo_x86 *c)
> >  	 *   don't advertise the feature under CONFIG_X86_32.
> >  	 */
> >  	if (cpu_has(c, X86_FEATURE_SME) || cpu_has(c, X86_FEATURE_SEV)) {
> > +		if (cpu_has(c, X86_FEATURE_HYPERVISOR)) {
> > +			rdmsrl(MSR_AMD64_SYSCFG, msr);
> > +			msr |= MSR_AMD64_SYSCFG_MEM_ENCRYPT;
> > +			wrmsrl(MSR_AMD64_SYSCFG, msr);
> > +		}
> > +
> >  		/* Check if memory encryption is enabled */
> >  		rdmsrl(MSR_AMD64_SYSCFG, msr);
> >  		if (!(msr & MSR_AMD64_SYSCFG_MEM_ENCRYPT))
> > @@ -584,7 +590,7 @@ static void early_detect_mem_encrypt(struct cpuinfo_x86 *c)
> >  			setup_clear_cpu_cap(X86_FEATURE_SME);
> > 
> >  		rdmsrl(MSR_K7_HWCR, msr);
> > -		if (!(msr & MSR_K7_HWCR_SMMLOCK))
> > +		if (!(msr & MSR_K7_HWCR_SMMLOCK) && !cpu_has(c, X86_FEATURE_HYPERVISOR))
> >  			goto clear_sev;
> > 
> >  		return;
> > --
> > 2.25.1
