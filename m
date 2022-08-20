Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6481659AA6B
	for <lists+linux-hyperv@lfdr.de>; Sat, 20 Aug 2022 03:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245251AbiHTBUh (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 19 Aug 2022 21:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245131AbiHTBUf (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 19 Aug 2022 21:20:35 -0400
Received: from mail-il1-x14a.google.com (mail-il1-x14a.google.com [IPv6:2607:f8b0:4864:20::14a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60E76DEB48
        for <linux-hyperv@vger.kernel.org>; Fri, 19 Aug 2022 18:20:33 -0700 (PDT)
Received: by mail-il1-x14a.google.com with SMTP id q10-20020a056e020c2a00b002dedb497c7fso4261137ilg.16
        for <linux-hyperv@vger.kernel.org>; Fri, 19 Aug 2022 18:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=Hy+OWfxLn1uSpMl+3tDFv8ysfTdHK4w3mL5UmpkU+QQ=;
        b=CTGMBtvoh43gIBFSYnDgcc5aZW77kdnh3yZHlfmBhGcZG11dqsl19mRFKitMzL+xZ9
         rWu3OEir+jIpKaM4/9hFLBexiC4OM7H+JtqVZlzqpMMyN1Bni/Cw7Wx4TqyXlOXvXzNe
         eyd335dHsFOw9/uta3ly6pUIN7i/kGKh7fzolnc6c7TpZHymz0A4MEBIsRSYGSF0O8gY
         1ZhdspYJjg+BsG+3HWd3gYYtBumyjUowRvZREX8I4R3fydUg5W06EN7TBQ7gMGhKqTt/
         qmLGIgF0CYbktOUlxlqYAoeLXH9tbzvxbOOk81YBPkGMjpXjEo3b2qd59SsvIKdScU5w
         mY5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=Hy+OWfxLn1uSpMl+3tDFv8ysfTdHK4w3mL5UmpkU+QQ=;
        b=0Ua9Ni/JcTVSKublH9ULbA3Bkq6KX5crWeoc3OF9XvoncPwgMf5EYw4BOPwI7gjOUK
         wMLEQcgpxjJb/YcONL6R8y84Ro/B+jr9roNOm4CubYz9nb/42UWvifBi4PH3MoiHoqOp
         3PKT82u1OGKByQvTiE/9aehzeWsz4ghbtRoh/NSWyF82SbJNFa86YnYR7MUMuEwzi3YE
         mMYT9ciW8HNHIzzHC183KmduYHQzBPM/IduxjFxkdnRZARPfGhw4XrhHkAyXnvd6F+x6
         UE7FxysMFFqHT9kqwsWUm8lxPns3/lEJfWlT5F1XMj57JqM1N3rq5RI1Bn2rj5gT5LZ8
         xv4g==
X-Gm-Message-State: ACgBeo0VIpUgsQvSGfIOhbOevDSnSwfHk3FPi8bVn7u56ehcAEs20Uq7
        sTo/GqXRcNPSeRCcVY2M2OfHkSwCOTU=
X-Google-Smtp-Source: AA6agR4eHC/d7mAFZH7t0obrCovhw8Et3/m9OfbGJ/5CXwIS59lUyMZnJ7lU6aOLt+yLkwtEJg3Iesw9HnI=
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:be87:320b:90a3:ceed])
 (user=yuzhao job=sendgmr) by 2002:a6b:b802:0:b0:67b:de15:c1fb with SMTP id
 i2-20020a6bb802000000b0067bde15c1fbmr4507430iof.215.1660958432754; Fri, 19
 Aug 2022 18:20:32 -0700 (PDT)
Date:   Fri, 19 Aug 2022 19:20:31 -0600
In-Reply-To: <20220611082514.37112-5-dongli.zhang@oracle.com>
Message-Id: <20220820012031.1285979-1-yuzhao@google.com>
Mime-Version: 1.0
References: <20220611082514.37112-5-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: Re: [PATCH v1 4/4] swiotlb: panic if nslabs is too small
From:   Yu Zhao <yuzhao@google.com>
To:     dongli.zhang@oracle.com
Cc:     ak@linux.intel.com, akpm@linux-foundation.org,
        alexander.sverdlin@nokia.com, andi.kleen@intel.com, bp@alien8.de,
        bp@suse.de, cminyard@mvista.com, corbet@lwn.net,
        damien.lemoal@opensource.wdc.com, dave.hansen@linux.intel.com,
        hch@infradead.org, iommu@lists.linux-foundation.org,
        joe.jin@oracle.com, joe@perches.com, keescook@chromium.org,
        kirill.shutemov@intel.com, kys@microsoft.com,
        linux-doc@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        ltykernel@gmail.com, michael.h.kelley@microsoft.com,
        mingo@redhat.com, m.szyprowski@samsung.com, parri.andrea@gmail.com,
        paulmck@kernel.org, pmladek@suse.com, rdunlap@infradead.org,
        robin.murphy@arm.com, tglx@linutronix.de, thomas.lendacky@amd.com,
        Tianyu.Lan@microsoft.com, tsbogend@alpha.franken.de,
        vkuznets@redhat.com, wei.liu@kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> Panic on purpose if nslabs is too small, in order to sync with the remap
> retry logic.
> 
> In addition, print the number of bytes for tlb alloc failure.
> 
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> ---
>  kernel/dma/swiotlb.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index fd21f4162f4b..1758b724c7a8 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -242,6 +242,9 @@ void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
>  	if (swiotlb_force_disable)
>  		return;
>  
> +	if (nslabs < IO_TLB_MIN_SLABS)
> +		panic("%s: nslabs = %lu too small\n", __func__, nslabs);

Hi,

This patch breaks MIPS. Please take a look. Thanks.

On v5.19.0:
  Linux version 5.19.0 (builder@buildhost) (mips64-openwrt-linux-musl-gcc (OpenWrt GCC 11.2.0 r19590-042d558536) 11.2.0, GNU ld (GNU Binutils) 2.37) #0 SMP Sun Jul 31 15:12:47 2022
  Skipping L2 locking due to reduced L2 cache size
  CVMSEG size: 0 cache lines (0 bytes)
  printk: bootconsole [early0] enabled
  CPU0 revision is: 000d9301 (Cavium Octeon II)
  Kernel sections are not in the memory maps
  Wasting 278528 bytes for tracking 4352 unused pages
  Initrd not found or empty - disabling initrd
  Using appended Device Tree.
  software IO TLB: SWIOTLB bounce buffer size adjusted to 0MB
  software IO TLB: mapped [mem 0x0000000004b0c000-0x0000000004b4c000] (0MB)

On v6.0-rc1, with
  commit 0bf28fc40d89 ("swiotlb: panic if nslabs is too small")
  commit 20347fca71a3 ("swiotlb: split up the global swiotlb lock")
  commit 534ea58b3ceb ("Revert "MIPS: octeon: Remove vestiges of CONFIG_CAVIUM_RESERVE32"")

  Linux version 6.0.0-rc1 (builder@buildhost) (mips64-openwrt-linux-musl-gcc (OpenWrt GCC 11.2.0 r19590-042d558536) 11.2.0, GNU ld (GNU Binutils) 2.37) #0 SMP Sun Jul 31 15:12:47 2022
  Failed to allocate CAVIUM_RESERVE32 memory area
  Skipping L2 locking due to reduced L2 cache size
  CVMSEG size: 0 cache lines (0 bytes)
  printk: bootconsole [early0] enabled
  CPU0 revision is: 000d9301 (Cavium Octeon II)
  Kernel sections are not in the memory maps
  Wasting 278528 bytes for tracking 4352 unused pages
  Initrd not found or empty - disabling initrd
  Using appended Device Tree.
  software IO TLB: SWIOTLB bounce buffer size adjusted to 0MB
  software IO TLB: area num 1.
  Kernel panic - not syncing: swiotlb_init_remap: nslabs = 128 too small

On v6.0-rc1, with
  commit 20347fca71a3 ("swiotlb: split up the global swiotlb lock")
  commit 534ea58b3ceb ("Revert "MIPS: octeon: Remove vestiges of CONFIG_CAVIUM_RESERVE32"")

  Linux version 6.0.0-rc1+ (builder@buildhost) (mips64-openwrt-linux-musl-gcc (OpenWrt GCC 11.2.0 r19590-042d558536) 11.2.0, GNU ld (GNU Binutils) 2.37) #0 SMP Sun Jul 31 15:12:47 2022
  Failed to allocate CAVIUM_RESERVE32 memory area
  Skipping L2 locking due to reduced L2 cache size
  CVMSEG size: 0 cache lines (0 bytes)
  printk: bootconsole [early0] enabled
  CPU0 revision is: 000d9301 (Cavium Octeon II)
  Kernel sections are not in the memory maps
  Wasting 278528 bytes for tracking 4352 unused pages
  Initrd not found or empty - disabling initrd
  Using appended Device Tree.
  software IO TLB: SWIOTLB bounce buffer size adjusted to 0MB
  software IO TLB: area num 1.
  software IO TLB: mapped [mem 0x0000000004c0c000-0x0000000004c4c000] (0MB)
