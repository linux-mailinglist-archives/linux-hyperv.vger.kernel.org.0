Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1058422A1
	for <lists+linux-hyperv@lfdr.de>; Wed, 12 Jun 2019 12:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408812AbfFLKgu (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 12 Jun 2019 06:36:50 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40933 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406315AbfFLKgu (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 12 Jun 2019 06:36:50 -0400
Received: by mail-wm1-f68.google.com with SMTP id v19so5966908wmj.5
        for <linux-hyperv@vger.kernel.org>; Wed, 12 Jun 2019 03:36:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=iB7poecQTyOsB8cRpdZU55/OXu7pHm3+QgOZegkblOA=;
        b=ApSo+z48FwnTnQ4cb9R+e4NoAogYlMd0jhMwIJNMcEOEubAFFp8zFMGEjCLCaksZuw
         qK03liojDUECq6Mot20XTWYJPFfJMCzVXUjKllm4eVVrnzQ4A0vZs+PvOE6JXqRJ92Yo
         yHVucquFWRMQk+qkA8/Fir17NrAnuekkwYAiiaaBOxLnorUb7wphsblO5rHuYgIeRsbx
         yHp/Kd1XCfesHpu8GlPEzNOxn2VuY7VjiP72dqmQ9qkdUNJQqEVQ36O9Xj8en3V4Spyt
         HeYdB8mb7ykED5qP8S/RVmGpOL1sbymABllbe5j3gWLzqhylfXSz3uj/7u/W+Nv7xHHd
         MLfA==
X-Gm-Message-State: APjAAAUs09ZQ3VPOTXVEaDw2vZ0jq1mjj0hXi7nxIymHvsgWt1cCS3X+
        bH0dPmp1aSiKVm8zQVEebvyu5w==
X-Google-Smtp-Source: APXvYqy2Lghsff9p2s0NVwakfOM4HR5RGFJK7Z2VwhreSAptAgNhXLLGpYIKpQpgKAuNvJTn5PVdng==
X-Received: by 2002:a1c:a6d1:: with SMTP id p200mr22496960wme.169.1560335808470;
        Wed, 12 Jun 2019 03:36:48 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id q15sm9705618wrr.19.2019.06.12.03.36.47
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 03:36:48 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Maya Nakamura <m.maya.nakamura@gmail.com>
Cc:     x86@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikelley@microsoft.com,
        kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org
Subject: Re: [PATCH v2 2/5] x86: hv: hv_init.c: Add functions to allocate/deallocate page for Hyper-V
In-Reply-To: <5cf4ad6f3fae8dec33e364b367b99cbb5b0f2ba4.1559807514.git.m.maya.nakamura@gmail.com>
References: <cover.1559807514.git.m.maya.nakamura@gmail.com> <5cf4ad6f3fae8dec33e364b367b99cbb5b0f2ba4.1559807514.git.m.maya.nakamura@gmail.com>
Date:   Wed, 12 Jun 2019 12:36:47 +0200
Message-ID: <87muindr9c.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Maya Nakamura <m.maya.nakamura@gmail.com> writes:

> Introduce two new functions, hv_alloc_hyperv_page() and
> hv_free_hyperv_page(), to allocate/deallocate memory with the size and
> alignment that Hyper-V expects as a page. Although currently they are
> not used, they are ready to be used to allocate/deallocate memory on x86
> when their ARM64 counterparts are implemented, keeping symmetry between
> architectures with potentially different guest page sizes.
>
> Signed-off-by: Maya Nakamura <m.maya.nakamura@gmail.com>
> ---
>  arch/x86/hyperv/hv_init.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index e4ba467a9fc6..84baf0e9a2d4 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -98,6 +98,20 @@ EXPORT_SYMBOL_GPL(hyperv_pcpu_input_arg);
>  u32 hv_max_vp_index;
>  EXPORT_SYMBOL_GPL(hv_max_vp_index);
>  
> +void *hv_alloc_hyperv_page(void)
> +{
> +	BUILD_BUG_ON(!(PAGE_SIZE == HV_HYP_PAGE_SIZE));

(nit)

PAGE_SIZE != HV_HYP_PAGE_SIZE ?

> +
> +	return (void *)__get_free_page(GFP_KERNEL);
> +}
> +EXPORT_SYMBOL_GPL(hv_alloc_hyperv_page);
> +
> +void hv_free_hyperv_page(unsigned long addr)
> +{
> +	free_page(addr);
> +}
> +EXPORT_SYMBOL_GPL(hv_free_hyperv_page);
> +
>  static int hv_cpu_init(unsigned int cpu)
>  {
>  	u64 msr_vp_index;

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly
