Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC34360772D
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Oct 2022 14:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbiJUMpI (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 21 Oct 2022 08:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiJUMpG (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 21 Oct 2022 08:45:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B38F035
        for <linux-hyperv@vger.kernel.org>; Fri, 21 Oct 2022 05:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666356303;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QHzZGIR/L3eWjmkvGxDRS//SKT5lTAiH8nYjXGv6sWo=;
        b=OyE7wQE1et3OaWtGrBkgZkvU4OGt0UPZRqNAa9qKUAd9MKvGqDoRg5Gp4C4eg4k/wmhejM
        56KaTn3JX5sUaDUW6KomWIjT+lt+Ht5HQvtPL12ZIfbrY5Exee5gpEo9Vflh8byOHB966s
        TDzkFfIaEQjyLL2AjN9JDZRJKNHitC0=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-103-xUR_66uUPCmaX9OeepJmGA-1; Fri, 21 Oct 2022 08:41:23 -0400
X-MC-Unique: xUR_66uUPCmaX9OeepJmGA-1
Received: by mail-ed1-f69.google.com with SMTP id h9-20020a05640250c900b0045cfb639f56so2296699edb.13
        for <linux-hyperv@vger.kernel.org>; Fri, 21 Oct 2022 05:41:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QHzZGIR/L3eWjmkvGxDRS//SKT5lTAiH8nYjXGv6sWo=;
        b=CMTrjd8FFNJQtKHTIJuEJTCWbKef/W//GegT9RFweccgt3LVEm7q9JdlQBme1wDWXx
         OK1IVjVtuA+fIiyuEn4QemZA/iNIyhp3nhcq+uO2TALZYBFku/gwXjrj1CMcHaQccj+d
         gFKMOjA/lZ5+qITm1ZJpp7I8wrQjgUEecaZx+sFxSq+zD8NyK8N+ie5jkanAUfxX/P2b
         3iXxiXDGX0dXs2B737HpzMAxG5XtSeL4EjDBs8I7iqzQSDktZM7vK7OtfpgHws/GMwTz
         VSSsscS47HeDAO4hKejFko3U9ra74fNhTQhOfatWTnzLNzocrKuBTeHiA8gE1kHWTp5B
         8G9w==
X-Gm-Message-State: ACrzQf1jy+n5yxxN5aknE2VvG4tjAnLVigyz/HXKqWtR9FWWi1wxQgKQ
        1YgwsZLUsesh+bSamVJv79BIowAfw3C6N/aDqWXEKnURr0cY1Xs4l4DJVpPM/q9ItDeP/CHNAEd
        UxgyD3lNDZGs/Swl2u7+TozJ2
X-Received: by 2002:a50:baec:0:b0:461:4c59:12bf with SMTP id x99-20020a50baec000000b004614c5912bfmr2386056ede.54.1666356081942;
        Fri, 21 Oct 2022 05:41:21 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6RSW63B8AxPtX3+pwhw0aXbCOhejwCfMPNftvJiTc6+wgGrJqhZFR9SUaQf54iaKqPePBggQ==
X-Received: by 2002:a50:baec:0:b0:461:4c59:12bf with SMTP id x99-20020a50baec000000b004614c5912bfmr2386039ede.54.1666356081696;
        Fri, 21 Oct 2022 05:41:21 -0700 (PDT)
Received: from ovpn-192-65.brq.redhat.com (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id n26-20020aa7c69a000000b0046146c730easm910838edq.75.2022.10.21.05.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 05:41:21 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Siddharth Chandrasekaran <sidcha@amazon.de>,
        Yuan Yao <yuan.yao@linux.intel.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 16/46] KVM: x86: hyper-v: Don't use
 sparse_set_to_vcpu_mask() in kvm_hv_send_ipi()
In-Reply-To: <87czalczo6.fsf@redhat.com>
References: <20221004123956.188909-1-vkuznets@redhat.com>
 <20221004123956.188909-17-vkuznets@redhat.com>
 <Y1BahCzO4jxFC9Ey@google.com> <87czalczo6.fsf@redhat.com>
Date:   Fri, 21 Oct 2022 14:41:19 +0200
Message-ID: <877d0tcpsg.fsf@ovpn-192-65.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Vitaly Kuznetsov <vkuznets@redhat.com> writes:

> Sean Christopherson <seanjc@google.com> writes:
>
>> On Tue, Oct 04, 2022, Vitaly Kuznetsov wrote:
>
> ...
>
>>>  
>>> -	if (all_cpus) {
>>> -		kvm_send_ipi_to_many(kvm, vector, NULL);
>>> -	} else {
>>> -		sparse_set_to_vcpu_mask(kvm, sparse_banks, valid_bank_mask, vcpu_mask);
>>> -
>>> -		kvm_send_ipi_to_many(kvm, vector, vcpu_mask);
>>> -	}
>>> +	kvm_hv_send_ipi_to_many(kvm, vector, all_cpus ? NULL : sparse_banks, valid_bank_mask);
>>
>> Any objection to not using a ternary operator?
>>
>> 	if (all_cpus)
>> 		kvm_hv_send_ipi_to_many(kvm, vector, NULL, 0);
>> 	else
>> 		kvm_hv_send_ipi_to_many(kvm, vector, sparse_banks, valid_bank_mask);
>>
>
> Not at all,
>
>> Mostly because it's somewhat arbitrary that earlier code ensures valid_bank_mask
>> is set in the all_cpus=true case, e.g. arguably KVM doesn't need to do the var_cnt
>> sanity check in the all_cpus case:
>>
>> 		all_cpus = send_ipi_ex.vp_set.format == HV_GENERIC_SET_ALL;
>> 		if (all_cpus)
>> 			goto check_and_send_ipi;
>>
>> 		valid_bank_mask = send_ipi_ex.vp_set.valid_bank_mask;
>> 		if (hc->var_cnt != hweight64(valid_bank_mask))
>> 			return HV_STATUS_INVALID_HYPERCALL_INPUT;
>>
>> 		if (!hc->var_cnt)
>> 			goto ret_success;
>>
>
> I think 'var_cnt' (== hweight64(valid_bank_mask)) has to be checked in
> 'all_cpus' case, especially in kvm_hv_flush_tlb(): the code which reads
> TLB flush entries will read them from the wrong offset (data_offset/
> consumed_xmm_halves) otherwise. The problem is less severe in
> kvm_hv_send_ipi() as there's no data after CPU banks. 
>
> At the bare minimum, "KVM: x86: hyper-v: Handle
> HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST{,EX} calls gently" patch from this
> series will have to be adjusted. I *think* mandating var_cnt==0 in 'all_cpus'
> is OK but I don't recall such requirement from TLFS, maybe it's safer to
> just adjust 'data_offset'/'consumed_xmm_halves' even in 'all_cpus' case.
>
> Let me do some tests... 

"We can neither confirm nor deny the existence of the problem". Windows
guests seem to be smart enough to avoid using *_EX hypercalls altogether
for "all cpus" case (as non-ex versions are good enough). Let's keep
allowing non-zero var_cnt for 'all cpus' case for now and think about
hardening it later...

-- 
Vitaly

