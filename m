Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9AC72FD528
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 Jan 2021 17:14:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388748AbhATQMx (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 20 Jan 2021 11:12:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391295AbhATQJ5 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 20 Jan 2021 11:09:57 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 689E5C061575
        for <linux-hyperv@vger.kernel.org>; Wed, 20 Jan 2021 08:09:11 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id f1so12270965edr.12
        for <linux-hyperv@vger.kernel.org>; Wed, 20 Jan 2021 08:09:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uFPoWmdT1E7447c/foHDjqNJuO8UPeUXJAj8ZTCeNuI=;
        b=bNp4m8GXBuiU/FXyjO9D9cA/C4gIGIPznUcpKtSxPEKyebwvVQ+aRwdeBURGW60Aqn
         LWDM8IY14JaXyGVpmy9pspE7lfObh3UXUk1T9JUoE9m742jY/UWqwZOuCBJ1bPyIODGl
         UnlPbfbmqFegwGszXH5A2WM1t7WLON4F/hTTf41tPfVOHi9uvgUn8pBT7w/CdD4OSxCR
         Pj4XoIeByZmeoQNQ4FhMnueL2wZ9/ttGENz2s0DHc9xIW18UNCzE7rgOV30lEB4IWM6K
         z43ISZVwDPuNuqM8j3RZAlGmRUAK0i/ai2ThrTF7kmw/zPRYVf/biTfeZ/ArEDWa+95U
         iDfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uFPoWmdT1E7447c/foHDjqNJuO8UPeUXJAj8ZTCeNuI=;
        b=l4/SqDbrxoqcXo13HYbyluZqLlEne0cO1SQ9gwBNFALKDb3C9fZfeFBFreMVKkWT2S
         ngBUfjwIhy1Tn7a7Bc9GWhPh2CUuJP8Cq368QXoaz1Cgq8hq5CgzyUil6ipmE9+iWbvD
         wcG2IGvShIZZ1xfcl4Urm3YwlQbXCVDTjyzyyl3y2MKGzfC6tvdtrIUJ0D1gLqTWHQjb
         9i++EcE6LL4ZKUZyFcsgtnHQgWXhsx3EW4yrNqyYLrMNfK9eH5jfwmP9pI2NRJjBXsCe
         wJ3acNo8A8qa2YcSv+91wbNVSHAwmEvzBcfFI+tvgP//DGyLwWneHLJKwbxKxvLyGKa4
         nVmQ==
X-Gm-Message-State: AOAM533B+5YOh6mzxTYTYMKF6iBb371zfdYY8g9rtgqdOh94upgkVfpX
        SfQXjZujhd26kTU/5SSFdGH2NTLQ1NMfUlWZ/vaTV6MB8aizsA==
X-Google-Smtp-Source: ABdhPJzzrx43U/MRM+U+2IS6fjT5/s61ISkHSJJW/uV0YTHN3o25ui9xpDMoE2/qruoEGyRFVzUk7yyVBnemuDxnOFQ=
X-Received: by 2002:aa7:d803:: with SMTP id v3mr7685979edq.153.1611158950213;
 Wed, 20 Jan 2021 08:09:10 -0800 (PST)
MIME-Version: 1.0
References: <20210120120058.29138-1-wei.liu@kernel.org> <20210120120058.29138-5-wei.liu@kernel.org>
In-Reply-To: <20210120120058.29138-5-wei.liu@kernel.org>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Wed, 20 Jan 2021 11:08:34 -0500
Message-ID: <CA+CK2bByGvCr_H3_wv_3-vAOONhRenonFNeHff5UdeFLDxSoUw@mail.gmail.com>
Subject: Re: [PATCH v5 04/16] iommu/hyperv: don't setup IRQ remapping when
 running as root
To:     Wei Liu <wei.liu@kernel.org>
Cc:     Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        Joerg Roedel <jroedel@suse.de>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Jan 20, 2021 at 7:01 AM Wei Liu <wei.liu@kernel.org> wrote:
>
> The IOMMU code needs more work. We're sure for now the IRQ remapping
> hooks are not applicable when Linux is the root partition.
>
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> Acked-by: Joerg Roedel <jroedel@suse.de>
> Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  drivers/iommu/hyperv-iommu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iommu/hyperv-iommu.c b/drivers/iommu/hyperv-iommu.c
> index 1d21a0b5f724..b7db6024e65c 100644
> --- a/drivers/iommu/hyperv-iommu.c
> +++ b/drivers/iommu/hyperv-iommu.c
> @@ -20,6 +20,7 @@
>  #include <asm/io_apic.h>
>  #include <asm/irq_remapping.h>
>  #include <asm/hypervisor.h>
> +#include <asm/mshyperv.h>
>
>  #include "irq_remapping.h"
>
> @@ -122,7 +123,7 @@ static int __init hyperv_prepare_irq_remapping(void)
>
>         if (!hypervisor_is_type(X86_HYPER_MS_HYPERV) ||
>             x86_init.hyper.msi_ext_dest_id() ||
> -           !x2apic_supported())
> +           !x2apic_supported() || hv_root_partition)
>                 return -ENODEV;

Reviewed-by: Pavel Tatashin <pasha.tatashin@soleen.com>
