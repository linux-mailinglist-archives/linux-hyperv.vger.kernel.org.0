Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68F5A2B207
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 May 2019 12:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbfE0KWD (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 27 May 2019 06:22:03 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45364 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbfE0KWC (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 27 May 2019 06:22:02 -0400
Received: by mail-wr1-f66.google.com with SMTP id b18so16349742wrq.12
        for <linux-hyperv@vger.kernel.org>; Mon, 27 May 2019 03:22:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=b21qaBk7xgBLkh/tR0jiPGLO6jWcDKAw7epKgIMYkgI=;
        b=akHAn20IpEgfRxhiI7Zmaatc/INvcjYBiaA1CISNbrahEu6WJTWBY18Qzj/e8njf8C
         CV8IEoZsfx6whjkzk2kR47N28FdZkBgzEk/X/L9csEvO/4KIyR7W/2/HmlyEcDhpYclg
         YJDqZY92/HzHIQdVhMJIOv/zfOG487u1Fb2cCAh66za7+kmvmDnmrYiOmaLNlDSxtiCb
         qVy1VGWFtKACniEvO3VwFt/MEodc6PlXqknhRrxq7dvQQPMFI1vk/VGWUOheiK1KQ33i
         Rfae7WMB6JVW+mUhgz8oZsr7sgtLJBhQVgAB0rl0U6eZskdhnDCg3MH2eIq8yYoiJwO+
         +9ng==
X-Gm-Message-State: APjAAAU+rON9hCVhy+2DdT7Y4a0PXchDSbzeIOTEgVetey9QIaW2ENHE
        2/GPj0nnSbUjnQZj31z/UK9+6A==
X-Google-Smtp-Source: APXvYqyHBiTtlTwjGNSoRY9mSrO2K+MXLJKpJDqJEZ9a29tUYpcW0gYHSxIWv7TusW+bveIx9CmIaw==
X-Received: by 2002:adf:db87:: with SMTP id u7mr25167674wri.245.1558952521069;
        Mon, 27 May 2019 03:22:01 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c43e:46a8:e962:cee8? ([2001:b07:6468:f312:c43e:46a8:e962:cee8])
        by smtp.gmail.com with ESMTPSA id a17sm8328827wrr.80.2019.05.27.03.21.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 May 2019 03:22:00 -0700 (PDT)
Subject: Re: [RFC PATCH 5/6] x86/mm/tlb: Flush remote and local TLBs
 concurrently
To:     Peter Zijlstra <peterz@infradead.org>,
        Juergen Gross <jgross@suse.com>
Cc:     Nadav Amit <namit@vmware.com>, Ingo Molnar <mingo@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        linux-hyperv@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        xen-devel@lists.xenproject.org
References: <20190525082203.6531-1-namit@vmware.com>
 <20190525082203.6531-6-namit@vmware.com>
 <08b21fb5-2226-7924-30e3-31e4adcfc0a3@suse.com>
 <20190527094710.GU2623@hirez.programming.kicks-ass.net>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e9c0dc1f-799a-b6e3-8d41-58f0a6b693cd@redhat.com>
Date:   Mon, 27 May 2019 12:21:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190527094710.GU2623@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 27/05/19 11:47, Peter Zijlstra wrote:
> On Sat, May 25, 2019 at 10:54:50AM +0200, Juergen Gross wrote:
>> On 25/05/2019 10:22, Nadav Amit wrote:
> 
>>> diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
>>> index 946f8f1f1efc..3a156e63c57d 100644
>>> --- a/arch/x86/include/asm/paravirt_types.h
>>> +++ b/arch/x86/include/asm/paravirt_types.h
>>> @@ -211,6 +211,12 @@ struct pv_mmu_ops {
>>>  	void (*flush_tlb_user)(void);
>>>  	void (*flush_tlb_kernel)(void);
>>>  	void (*flush_tlb_one_user)(unsigned long addr);
>>> +	/*
>>> +	 * flush_tlb_multi() is the preferred interface. When it is used,
>>> +	 * flush_tlb_others() should return false.
>>
>> This comment does not make sense. flush_tlb_others() return type is
>> void.
> 
> I suspect that is an artifact from before the static_key; an attempt to
> make the pv interface less awkward.
> 
> Something like the below would work for KVM I suspect, the others
> (Hyper-V and Xen are more 'interesting').
> 
> ---
> --- a/arch/x86/kernel/kvm.c
> +++ b/arch/x86/kernel/kvm.c
> @@ -580,7 +580,7 @@ static void __init kvm_apf_trap_init(voi
>  
>  static DEFINE_PER_CPU(cpumask_var_t, __pv_tlb_mask);
>  
> -static void kvm_flush_tlb_others(const struct cpumask *cpumask,
> +static void kvm_flush_tlb_multi(const struct cpumask *cpumask,
>  			const struct flush_tlb_info *info)
>  {
>  	u8 state;
> @@ -594,6 +594,9 @@ static void kvm_flush_tlb_others(const s
>  	 * queue flush_on_enter for pre-empted vCPUs
>  	 */
>  	for_each_cpu(cpu, flushmask) {
> +		if (cpu == smp_processor_id())
> +			continue;
> +

Even this would be just an optimization; the vCPU you're running on
cannot be preempted.  You can just change others to multi.

Paolo

>  		src = &per_cpu(steal_time, cpu);
>  		state = READ_ONCE(src->preempted);
>  		if ((state & KVM_VCPU_PREEMPTED)) {
> @@ -603,7 +606,7 @@ static void kvm_flush_tlb_others(const s
>  		}
>  	}
>  
> -	native_flush_tlb_others(flushmask, info);
> +	native_flush_tlb_multi(flushmask, info);
>  }
>  
>  static void __init kvm_guest_init(void)
> @@ -628,9 +631,8 @@ static void __init kvm_guest_init(void)
>  	if (kvm_para_has_feature(KVM_FEATURE_PV_TLB_FLUSH) &&
>  	    !kvm_para_has_hint(KVM_HINTS_REALTIME) &&
>  	    kvm_para_has_feature(KVM_FEATURE_STEAL_TIME)) {
> -		pv_ops.mmu.flush_tlb_others = kvm_flush_tlb_others;
> +		pv_ops.mmu.flush_tlb_multi = kvm_flush_tlb_multi;
>  		pv_ops.mmu.tlb_remove_table = tlb_remove_table;
> -		static_key_disable(&flush_tlb_multi_enabled.key);
>  	}
>  
>  	if (kvm_para_has_feature(KVM_FEATURE_PV_EOI))
> 

