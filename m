Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5555952A3AD
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 May 2022 15:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347238AbiEQNlz (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 17 May 2022 09:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346974AbiEQNlm (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 17 May 2022 09:41:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CC9BF19002
        for <linux-hyperv@vger.kernel.org>; Tue, 17 May 2022 06:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652794898;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Rcgoxye+RRDn/HQa/bQ/dm45ldKxX6uZBW2Ftk3ScGM=;
        b=Zm6KX7olK5KK644DO3lNcUuyo2/U9R8bXDjj/QiEj37E59w1wlIm2kaEiZcjFkcslcSttK
        jbi2JPHM0P3FSDtjOuWPvdFa20EiIMKloF3iTflv8mf4tzsQ/kQCR6a/eRZYcFJF3SvsDH
        eBgvAsSNq+7VNFxamh9hxhdc8DUKfpU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-504-wQt-PLPSNoyisEZLYDIrmQ-1; Tue, 17 May 2022 09:41:36 -0400
X-MC-Unique: wQt-PLPSNoyisEZLYDIrmQ-1
Received: by mail-wm1-f69.google.com with SMTP id t184-20020a1c46c1000000b00394209f54f1so8197426wma.4
        for <linux-hyperv@vger.kernel.org>; Tue, 17 May 2022 06:41:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=Rcgoxye+RRDn/HQa/bQ/dm45ldKxX6uZBW2Ftk3ScGM=;
        b=sv/ENffcu2LbhChfLXK6zUkxpPv1kl+ECY0P7PHusZifr/CeB7KnN1bVDnig4BC73K
         VTndgRTecQyZg0A1NYPYNAp3KXWn/Ql0TO8sIdg/w/9Qawt3IAb+YSoNpmOGB7nRc2FG
         dKtCWAE8QliV7bohXZcyvSgOLG7wYD/oBF3jjM56HFAa95mUHRzZMAmlQnmfEnN08TV2
         hX02utJEPHP5bFtvPkk0n1mggPndEa59WilrPgLMXB70ugxoPFbAEmaTom7j1xdJMpqI
         Nhsyh4F+Ad7OSSazr8MhHMw5FHXelZfiNPQMdypvLyDZxEJ/EkVVqEKe0j+PatmHzvdz
         dU2w==
X-Gm-Message-State: AOAM530xbj9grE9GCidN5IxDqjo+erjnvRLO0qid2AtIcangkVD/InQp
        IiZla51VYggufaOG2ZbY1phzcIwAW1S+4TZaVXhhPfLlEOmJ2x1PTtQSrWOC26ULuYnQ8r/gMiu
        u0Y4EtqCe4dyp8VpQvkIvVcCs
X-Received: by 2002:a05:600c:3641:b0:38e:4b2f:330 with SMTP id y1-20020a05600c364100b0038e4b2f0330mr32028433wmq.180.1652794895059;
        Tue, 17 May 2022 06:41:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyRn9SODL1CzaKtVz0YNiiMOy1/tcqkq0qTESapTZMo+sFwzVO0bjmPTe0TVbwx5mkrv36TIg==
X-Received: by 2002:a05:600c:3641:b0:38e:4b2f:330 with SMTP id y1-20020a05600c364100b0038e4b2f0330mr32028412wmq.180.1652794894791;
        Tue, 17 May 2022 06:41:34 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id l31-20020a05600c1d1f00b003942a244ecesm2196631wms.19.2022.05.17.06.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 06:41:34 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Siddharth Chandrasekaran <sidcha@amazon.de>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 04/34] KVM: x86: hyper-v: Handle
 HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST{,EX} calls gently
In-Reply-To: <YoKo1An5t7+owfzR@google.com>
References: <20220414132013.1588929-1-vkuznets@redhat.com>
 <20220414132013.1588929-5-vkuznets@redhat.com>
 <YoKo1An5t7+owfzR@google.com>
Date:   Tue, 17 May 2022 15:41:33 +0200
Message-ID: <87mtfguvhu.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Sean Christopherson <seanjc@google.com> writes:

> On Thu, Apr 14, 2022, Vitaly Kuznetsov wrote:
>> @@ -1862,15 +1890,58 @@ void kvm_hv_vcpu_flush_tlb(struct kvm_vcpu *vcpu)
>>  {
>>  	struct kvm_vcpu_hv_tlb_flush_ring *tlb_flush_ring;
>>  	struct kvm_vcpu_hv *hv_vcpu = to_hv_vcpu(vcpu);
>> +	struct kvm_vcpu_hv_tlb_flush_entry *entry;
>> +	int read_idx, write_idx;
>> +	u64 address;
>> +	u32 count;
>> +	int i, j;
>>  
>> -	kvm_vcpu_flush_tlb_guest(vcpu);
>> -
>> -	if (!hv_vcpu)
>> +	if (!tdp_enabled || !hv_vcpu) {
>> +		kvm_vcpu_flush_tlb_guest(vcpu);
>>  		return;
>> +	}
>>  
>>  	tlb_flush_ring = &hv_vcpu->tlb_flush_ring;
>>  
>> -	tlb_flush_ring->read_idx = tlb_flush_ring->write_idx;
>> +	/*
>> +	 * TLB flush must be performed on the target vCPU so 'read_idx'
>> +	 * (AKA 'tail') cannot change underneath, the compiler is free
>> +	 * to re-read it.
>> +	 */
>> +	read_idx = tlb_flush_ring->read_idx;
>> +
>> +	/*
>> +	 * 'write_idx' (AKA 'head') can be concurently updated by a different
>> +	 * vCPU so we must be sure it's read once.
>> +	 */
>> +	write_idx = READ_ONCE(tlb_flush_ring->write_idx);
>> +
>> +	/* Pairs with smp_wmb() in hv_tlb_flush_ring_enqueue() */
>> +	smp_rmb();
>> +
>> +	for (i = read_idx; i != write_idx; i = (i + 1) % KVM_HV_TLB_FLUSH_RING_SIZE) {
>> +		entry = &tlb_flush_ring->entries[i];
>> +
>> +		if (entry->flush_all)
>> +			goto out_flush_all;
>> +
>> +		/*
>> +		 * Lower 12 bits of 'address' encode the number of additional
>> +		 * pages to flush.
>> +		 */
>> +		address = entry->addr & PAGE_MASK;
>> +		count = (entry->addr & ~PAGE_MASK) + 1;
>> +		for (j = 0; j < count; j++)
>> +			static_call(kvm_x86_flush_tlb_gva)(vcpu, address + j * PAGE_SIZE);
>> +	}
>> +	++vcpu->stat.tlb_flush;
>
> Bumping tlb_flush is inconsistent with how KVM handles INVLPG, and could be wrong
> if the ring is empty (might be impossible without a bug?).  And if my math is right,
> or at least in the ballpark, tlb_flush will be incremented once regardless of whether
> the loop flushed 1 page or 64k pages (completely full ring, full count on every one).
>
> I'd prefer to either drop the stat adjustment entirely, or bump invlpg in the loop, e.g.
>
> diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
> index 56f06cf85282..5654c9d56289 100644
> --- a/arch/x86/kvm/hyperv.c
> +++ b/arch/x86/kvm/hyperv.c
> @@ -1945,10 +1945,11 @@ void kvm_hv_vcpu_flush_tlb(struct kvm_vcpu *vcpu)
>         for (i = read_idx; i != write_idx; i = (i + 1) % KVM_HV_TLB_FLUSH_RING_SIZE) {
>                 address = tlb_flush_ring->entries[i] & PAGE_MASK;
>                 count = (tlb_flush_ring->entries[i] & ~PAGE_MASK) + 1;
> -               for (j = 0; j < count; j++)
> +               for (j = 0; j < count; j++) {
>                         static_call(kvm_x86_flush_tlb_gva)(vcpu, address + j * PAGE_SIZE);
> +                       ++vcpu->stat.invlpg;
> +               }
>         }
> -       ++vcpu->stat.tlb_flush;
>
>  out_empty_ring:
>         tlb_flush_ring->read_idx = write_idx;
>

My idea was that flushing individual GVAs is always 'less intrusive'
than flushing the whole address space which counts as '1' in
'stat.tlb_flush'. Yes, 'flush 1 GVA' is equal to 'flush 64k' but on the
other hand if we do the math yor way we get:
- flush the whole address space: "stat.tlb_flush" is incremented by '1'.
- flush 100 indivudual GVAs: "stat.tlb_flush" is incremented by '100'.

What if we instead give 'stat.tlb_flush' the following meaning here:
"how many indivudual TLB flush requests were submitted", i.e.:

         for (i = read_idx; i != write_idx; i = (i + 1) % KVM_HV_TLB_FLUSH_RING_SIZE) {
                 address = tlb_flush_ring->entries[i] & PAGE_MASK;
                 count = (tlb_flush_ring->entries[i] & ~PAGE_MASK) + 1;
                 for (j = 0; j < count; j++)
                         static_call(kvm_x86_flush_tlb_gva)(vcpu, address + j * PAGE_SIZE);
                 ++vcpu->stat.invlpg;
          }

(something in between what I have now and what you suggest). What do you think?

-- 
Vitaly

