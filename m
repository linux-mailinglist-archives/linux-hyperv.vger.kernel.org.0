Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8B257D606
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 Jul 2022 23:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233836AbiGUVcJ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 21 Jul 2022 17:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbiGUVcI (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 21 Jul 2022 17:32:08 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F7AD9287F
        for <linux-hyperv@vger.kernel.org>; Thu, 21 Jul 2022 14:32:07 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id pc13so2734731pjb.4
        for <linux-hyperv@vger.kernel.org>; Thu, 21 Jul 2022 14:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hwDcOu7LN9Dw2toWSOc35XI4MHXeLdUNl8u96Y2Tf38=;
        b=B3hZ855CTyXHAXlIhrn3uu9tf4LNKr3XEQYwUIfhZ2nMRJsUmL62z4eAMRqjhvNiQd
         NYa3ZVaeBkzeOfH+/hopGkGmnntsXMGEOSPzLS7bC7QpsvWh3lJ7AuZYW9d8TvBxZryT
         wYxixEj3M7Id5GaGecv2X0Nx0UQp9j6wM60Mx3cqBoFuMiVBC9WdSi5jlO/Tvj7zcdBY
         HbJoKZ7dNfajw08xttZpNME1QSyM8rrV04dQ5X3XASdZ7FOak2zGVrxHPb3y+G15Bzge
         8lAmEq4Eyfk+DdOOThKX0/m+Is3tgn/hg/rxTDQFMkTOJb+BM7ADt+Q6/8/o3hlRo/C/
         +PAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hwDcOu7LN9Dw2toWSOc35XI4MHXeLdUNl8u96Y2Tf38=;
        b=n2Ank5yABI9qpvIQlFcIUA7kYpbuPGFkrXm7i/0mmUtBqv1R1HzuDBe9ch6oqiWeG6
         RaI4FMc0u9LtI5u0x9nx0TbZTfMDXl/4q69pDZUGbw8NXNUPqaJBWuJKGvRh5qPh38Xu
         cUSZSY0adakxh6R1ytJyfJzzTjfI1QATG07W5Ji9hc6lS8TN75oLEltK4Tm8Urwm2uKL
         wZxVW4Aq9H0NarU176+weOT2WJ9cwNUuW8jNb3Nl7PaW1PGgLabotuEYwj+f/+qTNYmr
         iRQy5ZTU2TUJZxSUHotEWWSm6SoyZjAyuO3Wf6B5TE0BzK0eHAxgXF5k8Q6gLiCiCilT
         wGeQ==
X-Gm-Message-State: AJIora8uiT1nO2HnH43zmeaQhXUZURJvAb2tjnERBghBarHrYhF2sIwR
        qvsCy6GM4babmZ1CivAFf/dQcQ==
X-Google-Smtp-Source: AGRyM1vaJbihXeme2HVwPKDEkXAC02RH9yfXYC/UoHS42V92vNQP8i1GvTakXThmP8OgRHqr5v8/OQ==
X-Received: by 2002:a17:902:d395:b0:16b:e5e9:ac59 with SMTP id e21-20020a170902d39500b0016be5e9ac59mr281038pld.74.1658439126537;
        Thu, 21 Jul 2022 14:32:06 -0700 (PDT)
Received: from google.com (123.65.230.35.bc.googleusercontent.com. [35.230.65.123])
        by smtp.gmail.com with ESMTPSA id g3-20020a1709026b4300b0016c6e360ff6sm2131990plt.303.2022.07.21.14.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 14:32:06 -0700 (PDT)
Date:   Thu, 21 Jul 2022 21:32:02 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Siddharth Chandrasekaran <sidcha@amazon.de>,
        Yuan Yao <yuan.yao@linux.intel.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 28/39] KVM: selftests: Fill in vm->vpages_mapped
 bitmap in virt_map() too
Message-ID: <YtnF0haNc3MDYw+g@google.com>
References: <20220714134929.1125828-1-vkuznets@redhat.com>
 <20220714134929.1125828-29-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220714134929.1125828-29-vkuznets@redhat.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Jul 14, 2022, Vitaly Kuznetsov wrote:
> Similar to vm_vaddr_alloc(), virt_map() needs to reflect the mapping
> in vm->vpages_mapped.
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  tools/testing/selftests/kvm/lib/kvm_util.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> index 768f3bce0161..63f411f7da1e 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -1275,6 +1275,9 @@ void virt_map(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr,
>  		virt_pg_map(vm, vaddr, paddr);
>  		vaddr += page_size;
>  		paddr += page_size;
> +
> +		sparsebit_set(vm->vpages_mapped,
> +			vaddr >> vm->page_shift);

No need to wrap.  Can you also fix vm_vaddr_alloc(), which I assume is the source
of the copy+paste?
