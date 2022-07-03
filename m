Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 997C9564840
	for <lists+linux-hyperv@lfdr.de>; Sun,  3 Jul 2022 17:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbiGCPFj (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 3 Jul 2022 11:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231528AbiGCPFh (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 3 Jul 2022 11:05:37 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A355F67;
        Sun,  3 Jul 2022 08:05:36 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id g4so12589247ybg.9;
        Sun, 03 Jul 2022 08:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4QgHhJo99e7BP4qELBN4r2lriKbWdLtk6/DKUxmzOGg=;
        b=Vh7pwmFrp/ki5XJ76jyI5hNuUV1PKQWxt+H19V/GLJ3etny3Ed4qf9e0QV9OMyCnks
         +V7tZtdw1VniQ6BdZSdBWajNOZDP/9WVdUA9+J37kLhzlbC4xMvQ7twWstXyRhygrgEk
         OySwdBIMfbZujBrURcg8GdeODfqyyz4SIitS0W7F6ysxNT0VLPBddMx3/a/GvGvQdxvo
         iMowCy/4ZchQtcTLw19pWaXjlYPd52toUo7sie8xXqMfjy5oNYUEW0ViDYOw6PUrk0C5
         G34+Zs4D16S3OjNGlDvG+54xupVbs4o/Tt1NVLksn8dVuCTj0pxBkrj4yh/fdGcgDAoR
         8k/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4QgHhJo99e7BP4qELBN4r2lriKbWdLtk6/DKUxmzOGg=;
        b=f7gj4nxyJRN8rpuvGLlRL5Fd604BNTO/M2NfLNvgAAVWW7tpKVrtzSXgvnGfAMjwkf
         jMl1qdOteDnK041H99yNuoLvR8+BWgJ+KVhLsbg77YgbI+KhEiLFh3ooNG8/9UbIyF/F
         PaWg0sVPN+08Gbd6u+hOU2K9rJQ83IA2Jg/E0SzO2Ou3lTUBZiYsnK+dEB8J5P+x//fV
         JII/yB2h4gR8xm027ySBpVy+RGcwLfB1WD2lbYufjFR9R9kMdhgzGFtBxx6B1/isONiK
         Mse3+G2s+LcC9BPDldDKN8vSVvt1r2KGZwZnbindVYDepGw5jFNnGvRPiBnibp5P1sgk
         PMkQ==
X-Gm-Message-State: AJIora8FzhZOrikatcgazKy39ReDeqKyOwPMqQIYGehcsUhBUs+vUPZ2
        GAyc9gai2tp/wd1YYQJ30R6icvyP93jPkAWtkpY=
X-Google-Smtp-Source: AGRyM1uAuVW9IWphg5kSjbYsSYjb/TM871XbOL+Xts9oBKQbm/sejVIg7QWw6bS/e6Nkvrm3x1W/9pxqPUjTrwcE74M=
X-Received: by 2002:a25:858e:0:b0:66e:4898:63e2 with SMTP id
 x14-20020a25858e000000b0066e489863e2mr673140ybk.296.1656860735358; Sun, 03
 Jul 2022 08:05:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220701200056.46555-1-samuel@sholland.org> <20220701200056.46555-8-samuel@sholland.org>
In-Reply-To: <20220701200056.46555-8-samuel@sholland.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 3 Jul 2022 17:04:58 +0200
Message-ID: <CAHp75VccKxO+Gtw46GvxSiPo4ShfpaZPOBehAp6gCoq3gT_9Cw@mail.gmail.com>
Subject: Re: [PATCH v3 7/8] genirq: Return a const cpumask from irq_data_get_affinity_mask
To:     Samuel Holland <samuel@sholland.org>
Cc:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
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
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Jan Beulich <jbeulich@suse.com>,
        Joerg Roedel <joro@8bytes.org>,
        Juergen Gross <jgross@suse.com>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Kees Cook <keescook@chromium.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
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
        Serge Semin <fancer.lancer@gmail.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sven Schnelle <svens@stackframe.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Wei Liu <wei.liu@kernel.org>, Wei Xu <xuwei5@hisilicon.com>,
        Will Deacon <will@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        iommu@lists.linux.dev, linux-alpha@vger.kernel.org,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        linux-ia64@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        linux-parisc@vger.kernel.org,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux-SH <linux-sh@vger.kernel.org>,
        linux-xtensa@linux-xtensa.org,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Jul 1, 2022 at 10:01 PM Samuel Holland <samuel@sholland.org> wrote:
>
> Now that the irq_data_update_affinity helper exists, enforce its use
> by returning a a const cpumask from irq_data_get_affinity_mask.
>
> Since the previous commit already updated places that needed to call
> irq_data_update_affinity, this commit updates the remaining code that
> either did not modify the cpumask or immediately passed the modified
> mask to irq_set_affinity.

When we refer to functions, we use parentheses, e.g. func().

-- 
With Best Regards,
Andy Shevchenko
