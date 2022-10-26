Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B70160EB8E
	for <lists+linux-hyperv@lfdr.de>; Thu, 27 Oct 2022 00:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233044AbiJZW0m (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 26 Oct 2022 18:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231877AbiJZW0l (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 26 Oct 2022 18:26:41 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F4710B7A1
        for <linux-hyperv@vger.kernel.org>; Wed, 26 Oct 2022 15:26:40 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id m2so11480113pjr.3
        for <linux-hyperv@vger.kernel.org>; Wed, 26 Oct 2022 15:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tqbgx6vGuPr6QXe5nVugDDXs7m8igdwmYOTsQMhzjQc=;
        b=grGY2VihREOe7uB+BoPpRhDBsyjcAVx7+rM0ZkR+4SzGVyhpD0yQTDnccIWazOHXri
         JYR3jfeva2NVGCnaCrY/dLOP/ScNzbVlY2YyP2G6cGTLOWOg9FrNUZA0fQm2VpzKWBOn
         sIRLTLnjgUOCtyvORy+Fdfs42fXQIWo3euXdipTRheRFUsWOIudF67KXIspjoZbZfaZT
         JOyfs4gykVCt+Xb2tFJHHnqHRIsc7nEvzxjkPCatQIn6O9COuyl9TVE7q86if3uJsSZL
         DaYaVK9qKm9T6WgZOxdUBdnYDJnuAep0EBZuycxtXs3wdy6WbRGhoUUGhXJwbG/ncppT
         7BFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tqbgx6vGuPr6QXe5nVugDDXs7m8igdwmYOTsQMhzjQc=;
        b=u9DAnHFuA4SFk4xL/QsU7f0filkvnoRgGt5N2l5skO9bzeD7zGWzNiZxiTtMfky3Wv
         b5HdOiTYaExiFlFgTdcRkNFYNtljjyqE0jgjPh8JtjgfCGKn2ZFWbNrJm+Ycq4bVgOCs
         Se31616NvrzHX2SeQJxDw/kQlRTPRUmacVb9LawpD0x0oA9FMFv13Jm++rvQGDbPuAvb
         mcR2L/fn5t2Pj30w+NZv+DXJwPyvrziCQH2IIxlVg4POfhFyP8THLdE1aSFXXbDjk01H
         PkruCw9Io/lQQRPbYl5cR/ZhmiDVi3Wi3Tm6B/54glWgz/tMq5pT+mtC14mpvdMVpMO4
         JlCQ==
X-Gm-Message-State: ACrzQf2WEfK3VwEs9qeITf64dChbeT5zE9WCzW8uWFu8uCFbdPr1BVgk
        EYkScPVdAtgIqWjtiQGvMEbO2A==
X-Google-Smtp-Source: AMsMyM6gc1z6YLTu4AoAEf0/bp/7Aij9NnLvbHU1dCILxib4owz5pjdj9ZjZjJba992euitLZThuqg==
X-Received: by 2002:a17:902:dac3:b0:186:a437:f4b8 with SMTP id q3-20020a170902dac300b00186a437f4b8mr18675201plx.70.1666823199778;
        Wed, 26 Oct 2022 15:26:39 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id f28-20020aa79d9c000000b0056b6d31ac8asm3565462pfq.178.2022.10.26.15.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 15:26:39 -0700 (PDT)
Date:   Wed, 26 Oct 2022 22:26:36 +0000
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
Subject: Re: [PATCH v12 13/46] KVM: x86: Prepare kvm_hv_flush_tlb() to handle
 L2's GPAs
Message-ID: <Y1m0HCMgwJen/NnU@google.com>
References: <20221021153521.1216911-1-vkuznets@redhat.com>
 <20221021153521.1216911-14-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221021153521.1216911-14-vkuznets@redhat.com>
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

On Fri, Oct 21, 2022, Vitaly Kuznetsov wrote:
> To handle L2 TLB flush requests, KVM needs to translate the specified
> L2 GPA to L1 GPA to read hypercall arguments from there.
> 
> No functional change as KVM doesn't handle VMCALL/VMMCALL from L2 yet.
> 
> Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  arch/x86/kvm/hyperv.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
> index fca9c51891f5..df1efb821eb0 100644
> --- a/arch/x86/kvm/hyperv.c
> +++ b/arch/x86/kvm/hyperv.c
> @@ -23,6 +23,7 @@
>  #include "ioapic.h"
>  #include "cpuid.h"
>  #include "hyperv.h"
> +#include "mmu.h"
>  #include "xen.h"
>  
>  #include <linux/cpu.h>
> @@ -1908,6 +1909,12 @@ static u64 kvm_hv_flush_tlb(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc)
>  	 */
>  	BUILD_BUG_ON(KVM_HV_MAX_SPARSE_VCPU_SET_BITS > 64);
>  
> +	if (!hc->fast && is_guest_mode(vcpu)) {

Please add a comment explaining why only "slow" hypercalls need to translate the
GPA from L2=>L1.

With a comment (and assuming this isn't a bug),

Reviewed-by: Sean Christopherson <seanjc@google.com>
