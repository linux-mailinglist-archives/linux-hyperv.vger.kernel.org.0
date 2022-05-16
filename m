Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32F38529084
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 May 2022 22:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239976AbiEPUIc (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 16 May 2022 16:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348922AbiEPT7D (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 16 May 2022 15:59:03 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0945E36B48
        for <linux-hyperv@vger.kernel.org>; Mon, 16 May 2022 12:52:57 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id nr2-20020a17090b240200b001df2b1bfc40so315297pjb.5
        for <linux-hyperv@vger.kernel.org>; Mon, 16 May 2022 12:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MiA2IbbGB4PrztiBYAGqSxVhR5Rwcu/jU2Fpvn36Dl0=;
        b=deJtJBiCfl3UmX5GrP4pGKU4l3G56jfiOmXHqodW6G/JMHuzegFzyHLrLeu+ZaHJkg
         NmN40D91Pl+R2RlRC4Jo5htGdRwHzZhP5A/FL+L0HT4z5xXc5nOo22Qqc1DTZZ7VTcAO
         W4mh6HvlyBjzkOcNSOcolsmPzM80BE14dVS/8ewQQuSd0OGpSfOVLvkpA+KWxYzObt+O
         cPHv7+4KH2Dn3pa0srAGD45Z+roR2Z33UakwPw6V99hO6dKk1/cmC3CVpBlrDNZMJ//o
         c8igbCLZxPOHU2OONg1QdnFk5l5IEkUTgpV6xdqR8UOxb+0bp6XrWxEuBMIFkarojoai
         2qig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MiA2IbbGB4PrztiBYAGqSxVhR5Rwcu/jU2Fpvn36Dl0=;
        b=Q4aJz+r66R41bHG6l00aRjtqY+1JssOS//9ROQPbjmsf/vQRNp8fb1DH/AkTOEf2/i
         fOckFoE+cBsq+RqyCmV3sAzogIf0B5AGpDTn134tt6fzMfdov+qSqNilAfL9/kWMqlrV
         CyN1Z/EubEedd5gHLv7ALbWkXbjivOL1S2xYrrdJUIXy/AMNrJi0vz/GHR714bkGt/5J
         Prt5HbHNSKM/R562gLjOSwu9zuDf3Nk0tWnkVOQuS7omyB7iP1jpFEwSWrH5sD9y2XMK
         VOSIH3nnyIasVaKmCbmvcrDQ7JQA12bsh3YgRFDCG18Y7BnfjzUAf1hxhPn60wn0FTE+
         5xBQ==
X-Gm-Message-State: AOAM531BHfwxBWYfP6aDXttW+xoWGqX6lFOyiFP1qb2iqj//dcKVW/Op
        Lnq/kzHPGy3TTabbWVtNfFL6qw==
X-Google-Smtp-Source: ABdhPJzNV/v9eBVXXMXhCt2k3rEPI8Qh5FZO4UU5+6FwTfuFJm8S0FMztukLIgePJ6T+WiIHqsbotQ==
X-Received: by 2002:a17:90b:1482:b0:1df:5b39:8a4 with SMTP id js2-20020a17090b148200b001df5b3908a4mr6265490pjb.233.1652730776434;
        Mon, 16 May 2022 12:52:56 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id q23-20020a170902bd9700b0015e8d4eb2e2sm7337538pls.300.2022.05.16.12.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 12:52:55 -0700 (PDT)
Date:   Mon, 16 May 2022 19:52:52 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Siddharth Chandrasekaran <sidcha@amazon.de>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 09/34] KVM: x86: hyper-v: Don't use
 sparse_set_to_vcpu_mask() in kvm_hv_send_ipi()
Message-ID: <YoKrlMKq6o0dMfLt@google.com>
References: <20220414132013.1588929-1-vkuznets@redhat.com>
 <20220414132013.1588929-10-vkuznets@redhat.com>
 <94cec439f345313c1a909f6a012665dd10686d47.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94cec439f345313c1a909f6a012665dd10686d47.camel@redhat.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, May 11, 2022, Maxim Levitsky wrote:
> On Thu, 2022-04-14 at 15:19 +0200, Vitaly Kuznetsov wrote:
> > @@ -2089,8 +2108,8 @@ static u64 kvm_hv_flush_tlb(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc)
> >  		((u64)hc->rep_cnt << HV_HYPERCALL_REP_COMP_OFFSET);
> >  }
> >  
> > -static void kvm_send_ipi_to_many(struct kvm *kvm, u32 vector,
> > -				 unsigned long *vcpu_bitmap)
> > +static void kvm_hv_send_ipi_to_many(struct kvm *kvm, u32 vector,
> > +				    u64 *sparse_banks, u64 valid_bank_mask)
> I think the indentation is wrong here (was wrong before as well)

It's correct, the "+" from the diff/patch misaligns the first line because there's
no tab to eat the extra character.  Amusingly, the misaligment just gets worse the
more ">" / quotes that get added to the front.

I usually end up applying a patch to double check if I suspect indentation is
wrong, it's too hard for me to tell based on the raw patch alone unless it's super
bad/obvious.
