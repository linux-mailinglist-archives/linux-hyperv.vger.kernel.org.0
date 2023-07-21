Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8769975C098
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Jul 2023 09:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbjGUH7q (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 21 Jul 2023 03:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbjGUH7o (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 21 Jul 2023 03:59:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C7C2710;
        Fri, 21 Jul 2023 00:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Nlw4/Z4Qos4HKINH1+acYEbUVYzFzh3QlKFg9k7JSog=; b=r5BWTa/VoWNG6OqLSTFt06vbOM
        zqex4vbFUL/U0a3v1WWSjZ2vngYZ/e6RTM8AGHzjrl1pDRnyZhZ4IWFido2QjjCmOZAD6MNmoW7fn
        DjfdhBvxh1CI8eVrmsQ+QB4h4pH2VT6vqGVAmspMkaPrzKziBx4ghai0A1BFxPi5EY+FTiBNQMC8B
        9d8Vf6IQcjIeQJDoA+3knsl4O9S62/tKKuQQCm5VkzmZVlDCyMup+tlbtbaBMXYexoKhKD0NdHTse
        fAO/jglCqOfRE26G67TZss3Rs1dx/3KD3TJ/9SNv7bZUZDOGuX91/+Kb7EB5pspPicarAupRVPnq6
        Mg0pyz5A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qMl2H-000uO8-Ru; Fri, 21 Jul 2023 07:58:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 714B3300095;
        Fri, 21 Jul 2023 09:58:48 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 57F3E3154DF57; Fri, 21 Jul 2023 09:58:48 +0200 (CEST)
Date:   Fri, 21 Jul 2023 09:58:48 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 1/1] x86/hyperv: Disable IBT when hypercall page lacks
 ENDBR instruction
Message-ID: <20230721075848.GA3630545@hirez.programming.kicks-ass.net>
References: <1689885237-32662-1-git-send-email-mikelley@microsoft.com>
 <20230720211553.GA3615208@hirez.programming.kicks-ass.net>
 <SN6PR2101MB16933FAC4E09E15D824EB2FDD73FA@SN6PR2101MB1693.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR2101MB16933FAC4E09E15D824EB2FDD73FA@SN6PR2101MB1693.namprd21.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Jul 21, 2023 at 12:41:35AM +0000, Michael Kelley (LINUX) wrote:

> > Other than that, this seems fairly straight forward. One thing I
> > wondered about; wouldn't it be possible to re-write the indirect
> > hypercall thingies to a direct call? I mean, once we have the hypercall
> > page mapped, the address is known right?
> 
> Yes, the address is known.  It does not change across things like
> hibernation.  But the indirect call instruction is part of an inline assembly
> sequence, so the call instructions that need re-writing are scattered
> throughout the code. There's also the SEV-SNP case from the
> latest version of Tianyu Lan's patch set [1] where vmmcall may be used
> instead, based on your recent enhancement for nested ALTERNATIVE.
> Re-writing seems like that's more complexity than warranted for a
> mostly interim situation until the Hyper-V patch is available and
> users install it.

Well, we have a lot of infrastructure for this already. Specifically
this is very like the paravirt patching.

Also, direct calls are both faster and have less speculation issues, so
it might still be worth looking at.

The way to do something like this would be:


	asm volatile ("   ANNOTATE_RETPOLINE_SAFE	\n\t"
		      "1: call *hv_hypercall_page	\n\t"
		      ".pushsection .hv_call_sites	\n\t"
		      ".long 1b - .			\n\t"
		      ".popsection			\n\t");


And then (see alternative.c for many other examples):


patch_hypercalls()
{
	s32 *s;

	for (s = __hv_call_sites_begin; s < __hv_call_sites_end; s++) {
		void *addr = (void *)s + *s;
		struct insn insn;

		ret = insn_decode_kernel(&insn, addr);
		if (WARN_ON_ONCE(ret < 0))
			continue;

		/*
		 * indirect call: ff 15 disp32
		 * direct call:   2e e8 disp32
		 */
		if (insn.length == 6 &&
		    insn.opcode.bytes[0] == 0xFF &&
		    X86_MODRM_REG(insn.modrm.bytes[0]) == 2) {

			/* verify it was calling hy_hypercall_page */
			if (WARN_ON_ONCE(addr + 6 + insn.displacement.value != &hv_hypercall_page))
				continue;

			/*
			 * write a CS padded direct call -- assumes the
			 * hypercall page is in the 2G immediate range
			 * of the kernel text
			 */
			addr[0] = 0x2e; /* CS prefix */
			addr[1] = CALL_INSN_OPCODE;
			(s32 *)&Addr[2] = *hv_hypercall_page - (addr + 6);
		}
	}
}


See, easy :-)
