Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF03E59CBF1
	for <lists+linux-hyperv@lfdr.de>; Tue, 23 Aug 2022 01:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238162AbiHVXLo (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 22 Aug 2022 19:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237810AbiHVXLi (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 22 Aug 2022 19:11:38 -0400
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B511C474C4
        for <linux-hyperv@vger.kernel.org>; Mon, 22 Aug 2022 16:11:28 -0700 (PDT)
Received: by mail-vk1-xa2e.google.com with SMTP id i67so6337419vkb.2
        for <linux-hyperv@vger.kernel.org>; Mon, 22 Aug 2022 16:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=hWS/GSisPthoWfjN1J+yXX8Vd1RQGFpsvO+i5OwvdPk=;
        b=fO/5xg9/qFikE2CEc4Qw+qi89zcgIdtSQUEMacivgBNETGe0IgvIVmZm/Z2TL8Fkay
         3ig1YCs2oRKA9LyiXddIzV0ex6QGN1M+vE+9o5NgPGChWWiTkrRqKrCFWkL6ByVerQg9
         8FzlAjt6k1tLTMwXCjJJpqdzCSfwlc8IOi7v0NBZiNPEC0ueNRdde7uTWtvQWu1d1omh
         DBD2HATB5x3XSEyBjH2NloA+U8JRq4XMkTJFwQab7YuQbQZYA27mztQWdLJRnwN0x0SA
         3gr45iQKQ5MLJXb3MQ30DEb/MmaBWlHTDtA6XK8K8VW0csWndqoysPU9VaHDuAzo5vVy
         V+Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=hWS/GSisPthoWfjN1J+yXX8Vd1RQGFpsvO+i5OwvdPk=;
        b=hSlS5GeYxn56VYtu1dr157OH775K9wDEeOhB92jCSwwQsWbs7PzhGJ4dIb3ihiWBNj
         MbPJJOz812Mu7sbbhmIKBtDxCtUXt79JkcO0jljosT70SWR8WoNjVR4LawZPgIZ3e+ZE
         ilHMqvGSJdI+UyYAuy8u+pfDN/LixDJ5mnvAPEYIzwJa3UXDENbTnroGkfFcvhRaE+u3
         v6fHz3YvyHax+Bp0lQh7nBcz8HZ1bJ6DpiAZrXqyauC1yk+QXPWp2J5cvY6So41vIg4+
         VpcrK2oe0gdnCT2Gnkrv4/LWaKNnjhzcreiBNDalp/55q4HQw12gBvtZA0CnkzSgBuHc
         D1Rw==
X-Gm-Message-State: ACgBeo33EomzcVJ6aivtpjuKsWOsZ26gjK6PUrwL36yPJGCV3/8kcmmH
        6ZreJZnvGOYJ8LnmoAFX44toyyIrIbaopqUER2D+PA==
X-Google-Smtp-Source: AA6agR5vaV7dmRWO744hPUOmEIl1lCRgqokFnczTqelob3+66g0ohUnC59EbfGrTSKTYMbpvaPQ6TIoYRo1FuPwZzsU=
X-Received: by 2002:a1f:5fca:0:b0:386:381f:3dc4 with SMTP id
 t193-20020a1f5fca000000b00386381f3dc4mr8147333vkb.11.1661209887688; Mon, 22
 Aug 2022 16:11:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220611082514.37112-5-dongli.zhang@oracle.com>
 <20220820012031.1285979-1-yuzhao@google.com> <f8c743d8-fcbe-4ef7-5f86-d63086552ffd@arm.com>
 <YwNn92WP3rP4ylZu@infradead.org> <d5016c1e-55d9-4224-278a-50377d4c6454@arm.com>
 <82d5b78d-e027-316a-87de-f76f4383d736@oracle.com>
In-Reply-To: <82d5b78d-e027-316a-87de-f76f4383d736@oracle.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Mon, 22 Aug 2022 17:10:51 -0600
Message-ID: <CAOUHufYnFCqfZES1XF=nCbxTevGMVMqhNY-XOqR2xo_WWTwQbw@mail.gmail.com>
Subject: Re: [PATCH v1 4/4] swiotlb: panic if nslabs is too small
To:     Dongli Zhang <dongli.zhang@oracle.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andi Kleen <ak@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        alexander.sverdlin@nokia.com, andi.kleen@intel.com,
        Borislav Petkov <bp@alien8.de>, bp@suse.de,
        cminyard@mvista.com, Jonathan Corbet <corbet@lwn.net>,
        damien.lemoal@opensource.wdc.com,
        Dave Hansen <dave.hansen@linux.intel.com>,
        iommu@lists.linux-foundation.org, joe.jin@oracle.com,
        joe@perches.com, Kees Cook <keescook@chromium.org>,
        "Shutemov, Kirill" <kirill.shutemov@intel.com>, kys@microsoft.com,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-hyperv@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mips@vger.kernel.org, ltykernel@gmail.com,
        michael.h.kelley@microsoft.com, Ingo Molnar <mingo@redhat.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        parri.andrea@gmail.com, "Paul E . McKenney" <paulmck@kernel.org>,
        pmladek@suse.com, Randy Dunlap <rdunlap@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, thomas.lendacky@amd.com,
        Tianyu.Lan@microsoft.com, tsbogend@alpha.franken.de,
        vkuznets@redhat.com, wei.liu@kernel.org,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Aug 22, 2022 at 4:28 PM Dongli Zhang <dongli.zhang@oracle.com> wrote:
>
> Hi Yu, Robin and Christoph,
>
> The mips kernel panic because the SWIOTLB buffer is adjusted to a very small
> value (< 1MB, or < 512-slot), so that the swiotlb panic on purpose.
>
> software IO TLB: SWIOTLB bounce buffer size adjusted to 0MB
> software IO TLB: area num 1.
> Kernel panic - not syncing: swiotlb_init_remap: nslabs = 128 too small
>
>
> From mips code, the 'swiotlbsize' is set to PAGE_SIZE initially. It is always
> PAGE_SIZE unless it is used by CONFIG_PCI or CONFIG_USB_OHCI_HCD_PLATFORM.
>
> Finally, the swiotlb panic on purpose.
>
> 189 void __init plat_swiotlb_setup(void)
> 190 {
> ... ...
> 211         swiotlbsize = PAGE_SIZE;
> 212
> 213 #ifdef CONFIG_PCI
> 214         /*
> 215          * For OCTEON_DMA_BAR_TYPE_SMALL, size the iotlb at 1/4 memory
> 216          * size to a maximum of 64MB
> 217          */
> 218         if (OCTEON_IS_MODEL(OCTEON_CN31XX)
> 219             || OCTEON_IS_MODEL(OCTEON_CN38XX_PASS2)) {
> 220                 swiotlbsize = addr_size / 4;
> 221                 if (swiotlbsize > 64 * (1<<20))
> 222                         swiotlbsize = 64 * (1<<20);
> 223         } else if (max_addr > 0xf0000000ul) {
> 224                 /*
> 225                  * Otherwise only allocate a big iotlb if there is
> 226                  * memory past the BAR1 hole.
> 227                  */
> 228                 swiotlbsize = 64 * (1<<20);
> 229         }
> 230 #endif
> 231 #ifdef CONFIG_USB_OHCI_HCD_PLATFORM
> 232         /* OCTEON II ohci is only 32-bit. */
> 233         if (OCTEON_IS_OCTEON2() && max_addr >= 0x100000000ul)
> 234                 swiotlbsize = 64 * (1<<20);
> 235 #endif
> 236
> 237         swiotlb_adjust_size(swiotlbsize);
> 238         swiotlb_init(true, SWIOTLB_VERBOSE);
> 239 }
>
>
> Here are some thoughts. Would you mind suggesting which is the right way to go?
>
> 1. Will the PAGE_SIZE swiotlb be used by mips when it is only PAGE_SIZE? If it
> is not used, why not disable swiotlb completely in the code?
>
> 2. The swiotlb panic on purpose when it is less then 1MB. Should we remove that
> limitation?
>
> 3. ... or explicitly declare the limitation that: "swiotlb should be at least
> 1MB, otherwise please do not use it"?
>
>
> The reason I add the panic on purpose is for below case:
>
> The user's kernel is configured with very small swiotlb buffer. As a result, the
> device driver may work abnormally.

Which driver? This sounds like that driver is broken, and we should
fix that driver.

> As a result, the issue is reported to a
> specific driver's developers, who spend some time to confirm it is swiotlb
> issue.

Is this a fact or a hypothetical proposition?

> Suppose those developers are not familiar with IOMMU/swiotlb, it takes
> times until the root cause is identified.

Sorry but you are making quite a few assumptions in a series claimed
to be "swiotlb: some cleanup" -- I personally expect cleanup patches
not to have any runtime side effects.

> If we panic earlier, the issue will be reported to IOMMU/swiotlb developer.

Ok, I think we should at least revert this patch, if not the entire series.

> This
> is also to sync with the remap failure logic in swiotlb (used by xen).

We can have it back in after we have better understood how it
interacts with different archs/drivers, or better yet when the needs
arise, if they arise at all.

Thanks.
