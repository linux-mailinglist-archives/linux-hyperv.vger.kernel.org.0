Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99AFAD5564
	for <lists+linux-hyperv@lfdr.de>; Sun, 13 Oct 2019 11:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728496AbfJMJCt (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 13 Oct 2019 05:02:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49352 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728080AbfJMJCs (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 13 Oct 2019 05:02:48 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B47CDC05683F
        for <linux-hyperv@vger.kernel.org>; Sun, 13 Oct 2019 09:02:47 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id z17so7020654wru.13
        for <linux-hyperv@vger.kernel.org>; Sun, 13 Oct 2019 02:02:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=8Io2fFp+LSlEu5IIHdAyNIkb3kMUT1TQFKgMauDHggc=;
        b=gsRR5MjmgTP7WKIYj0rDn8oQ8y5B9mFayrSrLdd9WaETLKUqQpX0zMszOjidis0n1K
         UPvlbnteThoQ6S4Pw5vZC5ToAgyCHsI2jGgBWJq9mSoMGWWKUjKLmglqRXBb3k+UE7JO
         FvkiVV4ORHDy8m/WX4c718qD/PE7Gpdvzs2cYwWBfl+ANKxKoWIv1HndVQA394aHXu4t
         Yecz6n2FmMy5k8rTaomPiHXTUtnTrEGu5epgZMa4P52zfAurB6RhWUeRwMDFCgy0Dqvi
         keWHL4zJmODXvbpHvAhzxMb0ev4Xgf0LQ+s6U6huOxMSo7P5j1nVgEVyBZ0YrcHoiR0m
         tzXQ==
X-Gm-Message-State: APjAAAVOPJ3TZZMwLFy2yoTlQaqTZH8H577MfAQwr+k8VgnagU8vcHpc
        qM+QPtUK8Rh07KzfCgq7uvaEg3y0TQsnFz0uQVjUOmZA/SuCiMfbAIAPxDwVUsiiMBYYqeP+HJ8
        C2mbB/FBKNGfcuZzY6GQPqR9+
X-Received: by 2002:adf:f68f:: with SMTP id v15mr20391549wrp.234.1570957366302;
        Sun, 13 Oct 2019 02:02:46 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwKAheZffHkSCPWMhS6Cg1JEcvChcdw7s3Ft8V5LOHraZQFHzUpf5Zi6v2gCGKg53hSBohZcg==
X-Received: by 2002:adf:f68f:: with SMTP id v15mr20391527wrp.234.1570957366037;
        Sun, 13 Oct 2019 02:02:46 -0700 (PDT)
Received: from vitty.brq.redhat.com ([95.82.135.110])
        by smtp.gmail.com with ESMTPSA id f18sm11958383wmh.43.2019.10.13.02.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Oct 2019 02:02:45 -0700 (PDT)
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
        Jonathan Corbet <corbet@lwn.net>,
        "H. Peter Anvin" <hpa@zytor.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v5 3/5] x86/kvm: Add "nopvspin" parameter to disable PV spinlocks
In-Reply-To: <1570439071-9814-4-git-send-email-zhenzhong.duan@oracle.com>
References: <1570439071-9814-1-git-send-email-zhenzhong.duan@oracle.com> <1570439071-9814-4-git-send-email-zhenzhong.duan@oracle.com>
Date:   Sun, 13 Oct 2019 11:02:44 +0200
Message-ID: <87o8yl587f.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Zhenzhong Duan <zhenzhong.duan@oracle.com> writes:

> There are cases where a guest tries to switch spinlocks to bare metal
> behavior (e.g. by setting "xen_nopvspin" on XEN platform and
> "hv_nopvspin" on HYPER_V).
>
> That feature is missed on KVM, add a new parameter "nopvspin" to disable
> PV spinlocks for KVM guest.
>
> The new 'nopvspin' parameter will also replace Xen and Hyper-V specific
> parameters in future patches.
>
> Define variable nopvsin as global because it will be used in future
> patches as above.
>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Krcmar <rkrcmar@redhat.com>
> Cc: Sean Christopherson <sean.j.christopherson@intel.com>
> Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
> Cc: Wanpeng Li <wanpengli@tencent.com>
> Cc: Jim Mattson <jmattson@google.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Will Deacon <will@kernel.org>
> ---
>  Documentation/admin-guide/kernel-parameters.txt |  5 +++++
>  arch/x86/include/asm/qspinlock.h                |  1 +
>  arch/x86/kernel/kvm.c                           | 21 +++++++++++++++++----
>  kernel/locking/qspinlock.c                      |  7 +++++++
>  4 files changed, 30 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index c7ac2f3..89d77ea 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -5330,6 +5330,11 @@
>  			as generic guest with no PV drivers. Currently support
>  			XEN HVM, KVM, HYPER_V and VMWARE guest.
>  
> +	nopvspin	[X86,KVM]
> +			Disables the qspinlock slow path using PV optimizations
> +			which allow the hypervisor to 'idle' the guest on lock
> +			contention.
> +
>  	xirc2ps_cs=	[NET,PCMCIA]
>  			Format:
>  			<irq>,<irq_mask>,<io>,<full_duplex>,<do_sound>,<lockup_hack>[,<irq2>[,<irq3>[,<irq4>]]]
> diff --git a/arch/x86/include/asm/qspinlock.h b/arch/x86/include/asm/qspinlock.h
> index 444d6fd..d86ab94 100644
> --- a/arch/x86/include/asm/qspinlock.h
> +++ b/arch/x86/include/asm/qspinlock.h
> @@ -32,6 +32,7 @@ static __always_inline u32 queued_fetch_set_pending_acquire(struct qspinlock *lo
>  extern void __pv_init_lock_hash(void);
>  extern void __pv_queued_spin_lock_slowpath(struct qspinlock *lock, u32 val);
>  extern void __raw_callee_save___pv_queued_spin_unlock(struct qspinlock *lock);
> +extern bool nopvspin;
>  
>  #define	queued_spin_unlock queued_spin_unlock
>  /**
> diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> index ef836d6..6e14bd4 100644
> --- a/arch/x86/kernel/kvm.c
> +++ b/arch/x86/kernel/kvm.c
> @@ -825,18 +825,31 @@ __visible bool __kvm_vcpu_is_preempted(long cpu)
>   */
>  void __init kvm_spinlock_init(void)
>  {
> -	/* Does host kernel support KVM_FEATURE_PV_UNHALT? */
> -	if (!kvm_para_has_feature(KVM_FEATURE_PV_UNHALT))
> +	/*
> +	 * Disable PV qspinlocks if host kernel doesn't support
> +	 * KVM_FEATURE_PV_UNHALT feature or there is only 1 vCPU.
> +	 * virt_spin_lock_key is enabled to avoid lock holder
> +	 * preemption issue.
> +	 */
> +	if (!kvm_para_has_feature(KVM_FEATURE_PV_UNHALT) ||
> +	    num_possible_cpus() == 1) {
> +		pr_info("PV spinlocks disabled\n");

Why don't we need static_branch_disable(&virt_spin_lock_key) here?

Also, as you're printing the exact reason for PV spinlocks disablement
in other cases, I'd suggest separating "no host support" and "single
CPU" cases.

>  		return;
> +	}
>  
>  	if (kvm_para_has_hint(KVM_HINTS_REALTIME)) {
> +		pr_info("PV spinlocks disabled with KVM_HINTS_REALTIME hints.\n");
>  		static_branch_disable(&virt_spin_lock_key);
>  		return;
>  	}
>  
> -	/* Don't use the pvqspinlock code if there is only 1 vCPU. */
> -	if (num_possible_cpus() == 1)
> +	if (nopvspin) {
> +		pr_info("PV spinlocks disabled forced by \"nopvspin\" parameter.\n");

Nit: to make it sound better a comma is missing between 'disabled' and
'forced', or

"PV spinlocks forcefully disabled by ..." if you prefer.

> +		static_branch_disable(&virt_spin_lock_key);
>  		return;
> +	}
> +
> +	pr_info("PV spinlocks enabled\n");
>  
>  	__pv_init_lock_hash();
>  	pv_ops.lock.queued_spin_lock_slowpath = __pv_queued_spin_lock_slowpath;
> diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
> index 2473f10..75193d6 100644
> --- a/kernel/locking/qspinlock.c
> +++ b/kernel/locking/qspinlock.c
> @@ -580,4 +580,11 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
>  #include "qspinlock_paravirt.h"
>  #include "qspinlock.c"
>  
> +bool nopvspin __initdata;
> +static __init int parse_nopvspin(char *arg)
> +{
> +	nopvspin = true;
> +	return 0;
> +}
> +early_param("nopvspin", parse_nopvspin);
>  #endif

-- 
Vitaly
