Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7527317F9
	for <lists+linux-hyperv@lfdr.de>; Thu, 15 Jun 2023 13:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344547AbjFOL6a (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 15 Jun 2023 07:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344558AbjFOL6Q (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 15 Jun 2023 07:58:16 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A5C235BE;
        Thu, 15 Jun 2023 04:52:55 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0BAD61EC0333;
        Thu, 15 Jun 2023 13:41:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1686829288;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=HQreAE5FD8a00YrqD8+l45HYtXgjFui3rC2AxDga2Ws=;
        b=kL1lHgT7J8EiHzfTzYkw9unajaRk3iCd0d1AWh6AWDDPkKKU19y0Z9kM67rvuhsWQiLuv7
        I+hdDRTRbkMBLn/Le1R89vcv3NynYVtZe3FjAfku0Y4GJbloQOU/FGQoBx6e451ShdEVYl
        bfJjyIq8EP+kmcjq/oJOaFoC3ij4J3U=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 2_-29Ukg8aC5; Thu, 15 Jun 2023 11:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1686829283; bh=HQreAE5FD8a00YrqD8+l45HYtXgjFui3rC2AxDga2Ws=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AkRrVxbNZLqY2lihECyRACD++O6LW4RXNpiGBICAOzlWRg+S8/5vWJza6VQp/Tbv1
         ULccC2uBwlsQvZeegtoG4wgOkmlH+ALY3ugrKRQoBYa3jC5ZXWpAoSOZudeTbbhlrL
         ZXPh/37xY8ye8ytAg3hfLXji4rBO8J2GmoHP/cfEkC5CTyl4jtWRs4zaItmxmFn5um
         7lN5MVZ4ubrRGlOrPJ2YTFe5osjLDQ1/9J6cT3gF7VAj6md0RzZByakXYoqpiYipap
         A300eTBudlbn1dzZ5RP6zMX47GZ8bcjQdYfMajNsPzNV8bOHgQJVPzem+lH4XM5kG/
         LlU6iCPbMOyb5Shzw7X1tn+hPlRulve1y0WKirFlzH5EB1krHdYbv0/k5Lzvhd5dm6
         vsVVG7ElkmlnWNEnEja34B2ZCWXEIyx488nlvtd+Y7fJ7bQj2xeqzqP7+eYf3OdP/X
         Ohx+GW4FiPPaBNjnwXhNgqAQAw3oDUCn8PvaFjmfMuybkjIKGRnQ8/5h1QYT4VYqLA
         N7QPNJngpT+dOVjqLUyeiMKVJ+6rwqJ/8WnmkLIzeJRUm3S0wCbBI0BKiMDrDYyJxN
         IL8Gszc2VMh24X7AD8eRftBNVMfIg5E/vJXVeb4uP79w/Jnv+xT2rOl39cX6ZYpFv7
         1fAyhAkDyAfXkqiOT+X5DgZ8=
Received: from zn.tnic (p200300eA971DC522329C23FFFEa6A903.dip0.t-ipconnect.de [IPv6:2003:ea:971d:c522:329c:23ff:fea6:a903])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 46EBB40E018C;
        Thu, 15 Jun 2023 11:41:08 +0000 (UTC)
Date:   Thu, 15 Jun 2023 13:40:57 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, catalin.marinas@arm.com, will@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        hpa@zytor.com, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        x86@kernel.org
Subject: Re: [PATCH v2 1/2] x86/hyperv: Fix hyperv_pcpu_input_arg handling
 when CPUs go online/offline
Message-ID: <20230615114057.GAZIr4ybsxzQcTkqNh@fat_crate.local>
References: <1684862062-51576-1-git-send-email-mikelley@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1684862062-51576-1-git-send-email-mikelley@microsoft.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, May 23, 2023 at 10:14:21AM -0700, Michael Kelley wrote:
> These commits
> 
> a494aef23dfc ("PCI: hv: Replace retarget_msi_interrupt_params with hyperv_pcpu_input_arg")
> 2c6ba4216844 ("PCI: hv: Enable PCI pass-thru devices in Confidential VMs")
> 
> update the Hyper-V virtual PCI driver to use the hyperv_pcpu_input_arg
> because that memory will be correctly marked as decrypted or encrypted
> for all VM types (CoCo or normal). But problems ensue when CPUs in the
> VM go online or offline after virtual PCI devices have been configured.
> 
> When a CPU is brought online, the hyperv_pcpu_input_arg for that CPU is
> initialized by hv_cpu_init() running under state CPUHP_AP_ONLINE_DYN.
> But this state occurs after state CPUHP_AP_IRQ_AFFINITY_ONLINE, which
> may call the virtual PCI driver and fault trying to use the as yet
> uninitialized hyperv_pcpu_input_arg. A similar problem occurs in a CoCo
> VM if the MMIO read and write hypercalls are used from state
> CPUHP_AP_IRQ_AFFINITY_ONLINE.
> 
> When a CPU is taken offline, IRQs may be reassigned in state
> CPUHP_TEARDOWN_CPU. Again, the virtual PCI driver may fault trying to
> use the hyperv_pcpu_input_arg that has already been freed by a
> higher state.
> 
> Fix the onlining problem by adding state CPUHP_AP_HYPERV_ONLINE
> immediately after CPUHP_AP_ONLINE_IDLE (similar to CPUHP_AP_KVM_ONLINE)
> and before CPUHP_AP_IRQ_AFFINITY_ONLINE. Use this new state for
> Hyper-V initialization so that hyperv_pcpu_input_arg is allocated
> early enough.
> 
> Fix the offlining problem by not freeing hyperv_pcpu_input_arg when
> a CPU goes offline. Retain the allocated memory, and reuse it if
> the CPU comes back online later.
> 
> Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> ---
> 
> Changes in v2:
> * Put CPUHP_AP_HYPERV_ONLINE before CPUHP_AP_KVM_ONLINE [Vitaly
>   Kuznetsov]
> 
>  arch/x86/hyperv/hv_init.c  |  2 +-
>  drivers/hv/hv_common.c     | 48 +++++++++++++++++++++++-----------------------
>  include/linux/cpuhotplug.h |  1 +
>  3 files changed, 26 insertions(+), 25 deletions(-)

Acked-by: Borislav Petkov (AMD) <bp@alien8.de>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
