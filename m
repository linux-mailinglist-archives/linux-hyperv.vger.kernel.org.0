Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 916735C0505
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 Sep 2022 19:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbiIURBX (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 21 Sep 2022 13:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231192AbiIURAp (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 21 Sep 2022 13:00:45 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD596F54F
        for <linux-hyperv@vger.kernel.org>; Wed, 21 Sep 2022 10:00:38 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id bu5-20020a17090aee4500b00202e9ca2182so4059595pjb.0
        for <linux-hyperv@vger.kernel.org>; Wed, 21 Sep 2022 10:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=XOa4aurffGm0tCv2VayZ1RuwmmJV/QHgF+XodULO/e4=;
        b=M1thJhs3crptdcTk9AppPMG4GQTA+ygwGlHofw5z+VfZQZzJzJRuWgcYw7wA6BJReQ
         4c/ax5qtQesPHD6rKMfjnzVcGgn05tLTCPaGLf2qaezxvI3hVaSXXZBXutYZfYAemGji
         Lak86dQ6DnlPGIc4MIUIt33+x4D/WKGPUgbvID95muAzoiMdPwhfqQF1JG5juAe7r+c5
         3u2gyKd2+b0NVJRe6jPFyRG2Xz+KqDIjqnzG0F9H0s/2LMRE8Yho3PZPz5HvL6PP3wt5
         xQN3OgVAAk+5nCKTImUjnWiN2LIiGq7DTqD7lCWE5IzK/gjwCQmLySJmIqpT6yWMJrlL
         q9ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=XOa4aurffGm0tCv2VayZ1RuwmmJV/QHgF+XodULO/e4=;
        b=ARDy1Px9Kxme9jG8ua0GIcVubYdx3OZ4YDj4xcOiomZ0woMJAltlBUx30iA/DMRERD
         k/O6kRTNpB69AQ77lUZd+tk3XU81od8/Y3ommIDbZg0ZeqjPrO9KFnQnRrAoTnZh83+G
         jo6qv7bzbORQRFrvBhX6dW1e9TX/qPAqb5lZEhkDE6ru3fcT9aE4WH6+seXfrk4VVtGW
         SsYMVciB6GkuQthGjWwMNTKpF+M4aZvBGYvfl43dx2AV3gXvdNfw9j1/6E3Vscuicpl+
         kXUu0pWVt+FB70JURA70rP5f5UX1U9YQpHwg0eyniKx5f4UTn/fBokJVL1PSclUZuCVz
         YH7Q==
X-Gm-Message-State: ACrzQf18AeParRnaEPl4sZSrrRqbQOIOovDF04tF325v/6BUAMVT294L
        +K3pcE1sghzmDpLGYjuZnMhOtA==
X-Google-Smtp-Source: AMsMyM5uqALCb8WGeHhzM8f0JqsMbjmUyhG8VuxXHzkBcroII1eIs3TfX4LfvlzwPp5mJshCSi1Nxg==
X-Received: by 2002:a17:90a:9f07:b0:203:5a3:1d25 with SMTP id n7-20020a17090a9f0700b0020305a31d25mr10962125pjp.74.1663779637571;
        Wed, 21 Sep 2022 10:00:37 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id i9-20020a17090332c900b00176b63535ccsm2291536plr.193.2022.09.21.10.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 10:00:37 -0700 (PDT)
Date:   Wed, 21 Sep 2022 17:00:33 +0000
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
Subject: Re: [PATCH v10 05/39] KVM: x86: hyper-v: Handle
 HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST{,EX} calls gently
Message-ID: <YytDMRUVZp2203v9@google.com>
References: <20220921152436.3673454-1-vkuznets@redhat.com>
 <20220921152436.3673454-6-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220921152436.3673454-6-vkuznets@redhat.com>
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

On Wed, Sep 21, 2022, Vitaly Kuznetsov wrote:
>  void kvm_hv_vcpu_flush_tlb(struct kvm_vcpu *vcpu)
>  {
>  	struct kvm_vcpu_hv_tlb_flush_fifo *tlb_flush_fifo;
>  	struct kvm_vcpu_hv *hv_vcpu = to_hv_vcpu(vcpu);
> +	u64 entries[KVM_HV_TLB_FLUSH_FIFO_SIZE];
> +	int i, j, count;
> +	gva_t gva;
>  
> -	kvm_vcpu_flush_tlb_guest(vcpu);
> -
> -	if (!hv_vcpu)
> +	if (!tdp_enabled || !hv_vcpu) {
> +		kvm_vcpu_flush_tlb_guest(vcpu);
>  		return;
> +	}
>  
>  	tlb_flush_fifo = &hv_vcpu->tlb_flush_fifo;
>  
> +	count = kfifo_out(&tlb_flush_fifo->entries, entries, KVM_HV_TLB_FLUSH_FIFO_SIZE);
> +
> +	for (i = 0; i < count; i++) {
> +		if (entries[i] == KVM_HV_TLB_FLUSHALL_ENTRY)
> +			goto out_flush_all;
> +
> +		/*
> +		 * Lower 12 bits of 'address' encode the number of additional
> +		 * pages to flush.
> +		 */
> +		gva = entries[i] & PAGE_MASK;
> +		for (j = 0; j < (entries[i] & ~PAGE_MASK) + 1; j++)
> +			static_call(kvm_x86_flush_tlb_gva)(vcpu, gva + j * PAGE_SIZE);
> +
> +		++vcpu->stat.tlb_flush;
> +	}
> +	return;
> +
> +out_flush_all:
> +	kvm_vcpu_flush_tlb_guest(vcpu);
>  	kfifo_reset_out(&tlb_flush_fifo->entries);
>  }

If kvm_vcpu_flush_tlb_guest() is done as a fallback, then this can use -ENOSPC,
which again I like from a documentation perspective.

out_flush_all:
	kfifo_reset_out(&tlb_flush_fifo->entries);
	return -ENOSPC;
