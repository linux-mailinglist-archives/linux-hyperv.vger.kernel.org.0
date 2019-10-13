Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E659AD556A
	for <lists+linux-hyperv@lfdr.de>; Sun, 13 Oct 2019 11:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728567AbfJMJJB (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 13 Oct 2019 05:09:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49772 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728408AbfJMJJB (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 13 Oct 2019 05:09:01 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A11365AFF8
        for <linux-hyperv@vger.kernel.org>; Sun, 13 Oct 2019 09:09:00 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id 7so1744763wrl.2
        for <linux-hyperv@vger.kernel.org>; Sun, 13 Oct 2019 02:09:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=nAWhy7odG0FujfQYmHKfpv+5JLZcSg6B+H4R/Q0IQ00=;
        b=ItM+m6/PS896WyBjzP6wk2dZTuD2vVShCbzcfe0l0C/wo+db0U2hyxgKs3gBPRTCKR
         rVhgCZNkniUmDZCle1sK1hqMUsh97q3MULwzsf5MoNXb7dH9RsV25elKqVZTdwNze3Bq
         1LH7se5hye4yc4Rgq/uvsagdHd/dThJvF5o0prv48PS4m0+BFzC+bMW/mA7jeLa5+TF+
         F/3PfvgIpKf/VTZx3rqUXOSSRNUKB+2Y33eEK0Dzlx8smeJGWwrcJdYoumjd9/3WIqlh
         TZq/VOA+W+f3HKi3++l83e0rSrimq6hD08dYQh9Tk/Qm8BSi3iusWyVojuPbdO64wjyg
         uvjw==
X-Gm-Message-State: APjAAAVNh/an9kTOyhYTnxMe43MNxp+Kub519iM07GQIoTnWy1r4kg2n
        c1fWC3tr8PRrLJz64SuLQcaL6GRXRVY1unVS7yP3HGI2Bh0A8wfEEmiKC2fXiiQ9/ILjcNiDJvD
        P+ka6nrbgQl5A1+SQtrfzfdlj
X-Received: by 2002:adf:ed43:: with SMTP id u3mr20961630wro.236.1570957739332;
        Sun, 13 Oct 2019 02:08:59 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzIzwmhjGUXEM93sW2zs2h1TtgmZHS84QZDWIvG2/HpyyINs7Rab5/h4zGKNtRA36lQ1oOFCw==
X-Received: by 2002:adf:ed43:: with SMTP id u3mr20961575wro.236.1570957738796;
        Sun, 13 Oct 2019 02:08:58 -0700 (PDT)
Received: from vitty.brq.redhat.com ([95.82.135.110])
        by smtp.gmail.com with ESMTPSA id a18sm20772149wrs.27.2019.10.13.02.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Oct 2019 02:08:58 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-hyperv@vger.kernel.org, kvm@vger.kernel.org,
        kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, pbonzini@redhat.com, rkrcmar@redhat.com,
        sean.j.christopherson@intel.com, wanpengli@tencent.com,
        jmattson@google.com, joro@8bytes.org, boris.ostrovsky@oracle.com,
        jgross@suse.com, sstabellini@kernel.org, peterz@infradead.org,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v5 1/5] Revert "KVM: X86: Fix setup the virt_spin_lock_key before static key get initialized"
In-Reply-To: <1570439071-9814-2-git-send-email-zhenzhong.duan@oracle.com>
References: <1570439071-9814-1-git-send-email-zhenzhong.duan@oracle.com> <1570439071-9814-2-git-send-email-zhenzhong.duan@oracle.com>
Date:   Sun, 13 Oct 2019 11:08:56 +0200
Message-ID: <87imot57x3.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Zhenzhong Duan <zhenzhong.duan@oracle.com> writes:

> This reverts commit 34226b6b70980a8f81fff3c09a2c889f77edeeff.
>
> Commit 8990cac6e5ea ("x86/jump_label: Initialize static branching
> early") adds jump_label_init() call in setup_arch() to make static
> keys initialized early, so we could use the original simpler code
> again.
>
> The similar change for XEN is in commit 090d54bcbc54 ("Revert
> "x86/paravirt: Set up the virt_spin_lock_key after static keys get
> initialized"")
>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Krcmar <rkrcmar@redhat.com>
> Cc: Sean Christopherson <sean.j.christopherson@intel.com>
> Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
> Cc: Wanpeng Li <wanpengli@tencent.com>
> Cc: Jim Mattson <jmattson@google.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> ---
>  arch/x86/kernel/kvm.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
>
> diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> index e820568..3bc6a266 100644
> --- a/arch/x86/kernel/kvm.c
> +++ b/arch/x86/kernel/kvm.c
> @@ -527,13 +527,6 @@ static void kvm_smp_send_call_func_ipi(const struct cpumask *mask)
>  	}
>  }
>  
> -static void __init kvm_smp_prepare_cpus(unsigned int max_cpus)
> -{
> -	native_smp_prepare_cpus(max_cpus);
> -	if (kvm_para_has_hint(KVM_HINTS_REALTIME))
> -		static_branch_disable(&virt_spin_lock_key);
> -}
> -
>  static void __init kvm_smp_prepare_boot_cpu(void)
>  {
>  	/*
> @@ -633,7 +626,6 @@ static void __init kvm_guest_init(void)
>  		apic_set_eoi_write(kvm_guest_apic_eoi_write);
>  
>  #ifdef CONFIG_SMP
> -	smp_ops.smp_prepare_cpus = kvm_smp_prepare_cpus;
>  	smp_ops.smp_prepare_boot_cpu = kvm_smp_prepare_boot_cpu;
>  	if (kvm_para_has_feature(KVM_FEATURE_PV_SCHED_YIELD) &&
>  	    !kvm_para_has_hint(KVM_HINTS_REALTIME) &&
> @@ -835,8 +827,10 @@ void __init kvm_spinlock_init(void)
>  	if (!kvm_para_has_feature(KVM_FEATURE_PV_UNHALT))
>  		return;
>  
> -	if (kvm_para_has_hint(KVM_HINTS_REALTIME))
> +	if (kvm_para_has_hint(KVM_HINTS_REALTIME)) {
> +		static_branch_disable(&virt_spin_lock_key);
>  		return;
> +	}
>  
>  	/* Don't use the pvqspinlock code if there is only 1 vCPU. */
>  	if (num_possible_cpus() == 1)

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly
