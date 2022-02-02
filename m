Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAB174A734B
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Feb 2022 15:36:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232632AbiBBOgn (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 2 Feb 2022 09:36:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiBBOgm (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 2 Feb 2022 09:36:42 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C950CC061714;
        Wed,  2 Feb 2022 06:36:42 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id z5so18418129plg.8;
        Wed, 02 Feb 2022 06:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=c5ilWsskzu3dpmU/mylu+bxXBWHwHUo4oYiiOl8lnqg=;
        b=j+i2IH9TTmno5Ci2jjglXFh9gBPNQE2OQMt7YSZ8a1DQH78WbW59Aq3Y0q34FjwVeN
         0kkoijgeIvYexpdiSHjIdr3sR6zvDRIqZrV1R1K9uf7alixm3pzNB+6iGi/6XivHMdBb
         9aF1qQuWeJkITh1Kys6H9pbIl6PjfJ4NziO/qGJx0vbek3/z41GWzHuzB5GtwX/8hHUB
         Bj+Bl4+G77sMnfbqgZtNGYbgvYRzkuDZvI+Ng0CzO7R0414Wh3jOGq42RbghwCZddTNy
         t7krMJ8BRBUY8eaX05HjjHsJU9OkrI+bIbTsuYhv19ZYwz25jZ9e+vpf6ooSwruSGnJL
         l92Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=c5ilWsskzu3dpmU/mylu+bxXBWHwHUo4oYiiOl8lnqg=;
        b=SU9tb9f+iJPKNV/whvD3L6A/Y8OrN9jc3KLANxJszlhxDEzEcaC4TPm4t84CuW5+UB
         i8hzp/L4cLXK8fAUW6Tb2MMewou6MUCMaAhmAkHIGrNahGThvNc0sdphSV2xDZtI6+Ph
         yPVuFZIbIfvVIx9kVtQri0Vu0kOAaxrf8nPf6tGQuAnOWR5n/bwFnDYGRfay4NYvAF0y
         w4ZLbz5cM/fE8sZbUKAe9hLpy994tzr7XEE7ZJ0FkDTm+ETwgEiHComW41zP0lG7wQu+
         f4dELzERkrvvOo5PyokSVFddw9YvzM6/lltnyXdqSl+ywBFAW54yLNSysILpqqnJzv+A
         Pepg==
X-Gm-Message-State: AOAM532KEdSHFIAptGdOsbDTrOWFd+5lw3lGnVvD5lwNze1URcUhm68T
        cM2jMUN5qzv91Uaru3hHL/E=
X-Google-Smtp-Source: ABdhPJz8auFLIWpqoq6yDdtZumYJt3qYm8v+O3l0kwOtA8BmumK/WvbzPOELeOyiqW7qERFyR3aEZw==
X-Received: by 2002:a17:90a:1b0d:: with SMTP id q13mr8453842pjq.14.1643812602299;
        Wed, 02 Feb 2022 06:36:42 -0800 (PST)
Received: from ?IPV6:2404:f801:0:5:8000::50c? ([2404:f801:9000:1a:efea::50c])
        by smtp.gmail.com with ESMTPSA id j8sm1148137pfu.55.2022.02.02.06.36.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Feb 2022 06:36:42 -0800 (PST)
Message-ID: <a11c5b65-5284-16e7-5302-23147401eb1c@gmail.com>
Date:   Wed, 2 Feb 2022 22:36:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 0/2] x86/hyperv/Swiotlb: Add swiotlb_alloc_from_low_pages
 switch
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, m.szyprowski@samsung.com,
        robin.murphy@arm.com, michael.h.kelley@microsoft.com,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        iommu@lists.linux-foundation.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, vkuznets@redhat.com,
        brijesh.singh@amd.com, konrad.wilk@oracle.com, hch@lst.de,
        parri.andrea@gmail.com, thomas.lendacky@amd.com
References: <20220126161053.297386-1-ltykernel@gmail.com>
 <Yfo84XYBsV7tA6Xd@infradead.org>
From:   Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <Yfo84XYBsV7tA6Xd@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 2/2/2022 4:12 PM, Christoph Hellwig wrote:
> I think this interface is a little too hacky.  In the end all the
> non-trusted hypervisor schemes (including the per-device swiotlb one)
> can allocate the memory from everywhere and want for force use of
> swiotlb.  I think we need some kind of proper interface for that instead
> of setting all kinds of global variables.

Hi Christoph:
      Thanks for your review. I draft the following patch to export a
interface swiotlb_set_alloc_from_low_pages(). Could you have a look
whether this looks good for you.

diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index f6c3638255d5..2b4f92668bc7 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -39,6 +39,7 @@ enum swiotlb_force {
  extern void swiotlb_init(int verbose);
  int swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose);
  unsigned long swiotlb_size_or_default(void);
+void swiotlb_set_alloc_from_low_pages(bool low);
  extern int swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs);
  extern int swiotlb_late_init_with_default_size(size_t default_size);
  extern void __init swiotlb_update_mem_attributes(void);
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index f1e7ea160b43..62bf8b5cc3e4 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -73,6 +73,8 @@ enum swiotlb_force swiotlb_force;

  struct io_tlb_mem io_tlb_default_mem;

+static bool swiotlb_alloc_from_low_pages = true;
+
  phys_addr_t swiotlb_unencrypted_base;

  /*
@@ -116,6 +118,11 @@ void swiotlb_set_max_segment(unsigned int val)
                 max_segment = rounddown(val, PAGE_SIZE);
  }

+void swiotlb_set_alloc_from_low_pages(bool low)
+{
+       swiotlb_alloc_from_low_pages = low;
+}
+
  unsigned long swiotlb_size_or_default(void)
  {
         return default_nslabs << IO_TLB_SHIFT;
@@ -284,8 +291,15 @@ swiotlb_init(int verbose)
         if (swiotlb_force == SWIOTLB_NO_FORCE)
                 return;

-       /* Get IO TLB memory from the low pages */
-       tlb = memblock_alloc_low(bytes, PAGE_SIZE);
+       /*
+        * Get IO TLB memory from the low pages if 
swiotlb_alloc_from_low_pages
+        * is set.
+        */
+       if (swiotlb_alloc_from_low_pages)
+               tlb = memblock_alloc_low(bytes, PAGE_SIZE);
+       else
+               tlb = memblock_alloc(bytes, PAGE_SIZE);
+
         if (!tlb)
                 goto fail;
         if (swiotlb_init_with_tbl(tlb, default_nslabs, verbose))


