Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4724E569D5A
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 Jul 2022 10:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235058AbiGGIXJ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 7 Jul 2022 04:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234787AbiGGIXD (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 7 Jul 2022 04:23:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC09DF3;
        Thu,  7 Jul 2022 01:23:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 71399620A5;
        Thu,  7 Jul 2022 08:23:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF301C3411E;
        Thu,  7 Jul 2022 08:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657182181;
        bh=77PtLpTS/qpbww/8J/LGrQtKTBirOJTX8MN8Ui9XQsg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=C4XXSYfqBm7jhADxfzqk/6WEI/haJhe/1MyTEVUiYwb5P0Ar3A4NKXEAQujuPspPd
         s3qSefHxSM6yAycSBOEk1x5rsX41Lz5CXWMfbKx+MFmlkdtWT2//rWeC4JZmK+kuzf
         ECU/jn91qz2SjvVIYKTSlVgpyAEteSUY53CHGeOdfan/ZYOpV2RhOmIOCcQwf6MG7i
         sgmXwysrqKOA4mKnZ3tQfGEWbFUHusfDO84IAYjAhD58ooo5Ed5J2OwoavWvff5Afm
         EAomLwlKGskSsbFGf0ELGfPJoWMt9Y95OsdWqoGMlW85HJC5m/Hz4sRuAeBe6tWwp9
         HHg5eNbfeNzNA==
Received: from ip-185-104-136-29.ptr.icomera.net ([185.104.136.29] helo=wait-a-minute.misterjones.org)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1o9Mmp-005rXS-7E;
        Thu, 07 Jul 2022 09:22:59 +0100
Date:   Thu, 07 Jul 2022 09:22:26 +0100
Message-ID: <87czehmiwt.wl-maz@kernel.org>
From:   Marc Zyngier <maz@kernel.org>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Samuel Holland <samuel@sholland.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Borislav Petkov <bp@alien8.de>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Chris Zankel <chris@zankel.net>,
        Colin Ian King <colin.king@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dexuan Cui <decui@microsoft.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Guo Ren <guoren@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Helge Deller <deller@gmx.de>, Ingo Molnar <mingo@redhat.com>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Jan Beulich <jbeulich@suse.com>,
        Joerg Roedel <joro@8bytes.org>,
        Juergen Gross <jgross@suse.com>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Kees Cook <keescook@chromium.org>,
        Krzysztof =?UTF-8?B?V2lsY3p5xYRza2k=?= <kw@linux.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matt Turner <mattst88@gmail.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Maximilian Heyne <mheyne@amazon.de>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Rich Felker <dalias@libc.org>,
        Richard Henderson <rth@twiddle.net>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sven Schnelle <svens@stackframe.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Wei Liu <wei.liu@kernel.org>, Wei Xu <xuwei5@hisilicon.com>,
        Will Deacon <will@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        iommu@lists.linux-foundation.org, iommu@lists.linux.dev,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-hyperv@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        x86@kernel.org, xen-devel@lists.xenproject.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v3 1/8] irqchip/mips-gic: Only register IPI domain when SMP is enabled
In-Reply-To: <20220705135243.ydbwfo4kois64elr@mobilestation>
References: <20220701200056.46555-1-samuel@sholland.org>
        <20220701200056.46555-2-samuel@sholland.org>
        <20220705135243.ydbwfo4kois64elr@mobilestation>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/27.1
 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-SA-Exim-Connect-IP: 185.104.136.29
X-SA-Exim-Rcpt-To: fancer.lancer@gmail.com, samuel@sholland.org, tglx@linutronix.de, andy.shevchenko@gmail.com, brgl@bgdev.pl, bhelgaas@google.com, boris.ostrovsky@oracle.com, bp@alien8.de, bcm-kernel-feedback-list@broadcom.com, chris@zankel.net, colin.king@intel.com, dave.hansen@linux.intel.com, decui@microsoft.com, f.fainelli@gmail.com, guoren@kernel.org, hpa@zytor.com, haiyangz@microsoft.com, deller@gmx.de, mingo@redhat.com, ink@jurassic.park.msu.ru, James.Bottomley@HansenPartnership.com, jbeulich@suse.com, joro@8bytes.org, jgross@suse.com, Julia.Lawall@inria.fr, kys@microsoft.com, keescook@chromium.org, kw@linux.com, linus.walleij@linaro.org, lpieralisi@kernel.org, mark.rutland@arm.com, mattst88@gmail.com, jcmvbkbc@gmail.com, mheyne@amazon.de, oleksandr_tyshchenko@epam.com, dalias@libc.org, rth@twiddle.net, rikard.falkeborn@gmail.com, robh@kernel.org, linux@armlinux.org.uk, sstabellini@kernel.org, sthemmin@microsoft.com, svens@stackframe.org, tsbogend@alpha.franken.de, wei.liu@ke
 rnel.org, xuwei5@hisilicon.com, will@kernel.org, ysato@users.sourceforge.jp, iommu@lists.linux-foundation.org, iommu@lists.linux.dev, linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org, linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linux-pci@vger.kernel.org, linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org, x86@kernel.org, xen-devel@lists.xenproject.org, lkp@intel.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, 05 Jul 2022 14:52:43 +0100,
Serge Semin <fancer.lancer@gmail.com> wrote:
> 
> Hi Samuel
> 
> On Fri, Jul 01, 2022 at 03:00:49PM -0500, Samuel Holland wrote:
> > The MIPS GIC irqchip driver may be selected in a uniprocessor
> > configuration, but it unconditionally registers an IPI domain.
> > 
> > Limit the part of the driver dealing with IPIs to only be compiled when
> > GENERIC_IRQ_IPI is enabled, which corresponds to an SMP configuration.
> 
> Thanks for the patch. Some comment is below.
> 
> > 
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Samuel Holland <samuel@sholland.org>
> > ---
> > 
> > Changes in v3:
> >  - New patch to fix build errors in uniprocessor MIPS configs
> > 
> >  drivers/irqchip/Kconfig        |  3 +-
> >  drivers/irqchip/irq-mips-gic.c | 80 +++++++++++++++++++++++-----------
> >  2 files changed, 56 insertions(+), 27 deletions(-)
> > 
> > diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> > index 1f23a6be7d88..d26a4ff7c99f 100644
> > --- a/drivers/irqchip/Kconfig
> > +++ b/drivers/irqchip/Kconfig
> > @@ -322,7 +322,8 @@ config KEYSTONE_IRQ
> >  
> >  config MIPS_GIC
> >  	bool
> > -	select GENERIC_IRQ_IPI
> > +	select GENERIC_IRQ_IPI if SMP
> 
> > +	select IRQ_DOMAIN_HIERARCHY
> 
> It seems to me that the IRQ domains hierarchy is supposed to be
> created only if IPI is required. At least that's what the MIPS GIC
> driver implies. Thus we can go further and CONFIG_IRQ_DOMAIN_HIERARCHY
> ifdef-out the gic_irq_domain_alloc() and gic_irq_domain_free()
> methods definition together with the initialization:
> 
>  static const struct irq_domain_ops gic_irq_domain_ops = {
>  	.xlate = gic_irq_domain_xlate,
> +#ifdef CONFIG_IRQ_DOMAIN_HIERARCHY
>  	.alloc = gic_irq_domain_alloc,
>  	.free = gic_irq_domain_free,
> +#endif
>  	.map = gic_irq_domain_map,
> };
> 
> If the GENERIC_IRQ_IPI config is enabled, CONFIG_IRQ_DOMAIN_HIERARCHY
> will be automatically selected (see the config definition in
> kernel/irq/Kconfig). If the IRQs hierarchy is needed for some another
> functionality like GENERIC_MSI_IRQ_DOMAIN or GPIOs then they will
> explicitly enable the IRQ_DOMAIN_HIERARCHY config thus activating the
> denoted .alloc and .free methods definitions.
> 
> To sum up you can get rid of the IRQ_DOMAIN_HIERARCHY config
> force-select from this patch and make the MIPS GIC driver code a bit
> more coherent.
> 
> @Marc, please correct me if were wrong.

Either way probably works correctly, but Samuel's approach is more
readable IMO. It is far easier to reason about a high-level feature
(GENERIC_IRQ_IPI) than an implementation detail (IRQ_DOMAIN_HIERARCHY).

If you really want to save a handful of bytes, you can make the
callbacks conditional on GENERIC_IRQ_IPI, and be done with it. But
this can come as an additional patch.

Thanks,

	M.

-- 
Without deviation from the norm, progress is not possible.
