Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 347385B5C34
	for <lists+linux-hyperv@lfdr.de>; Mon, 12 Sep 2022 16:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbiILO3w (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 12 Sep 2022 10:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbiILO3t (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 12 Sep 2022 10:29:49 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C25E3615B
        for <linux-hyperv@vger.kernel.org>; Mon, 12 Sep 2022 07:29:43 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id o23so6976709pji.4
        for <linux-hyperv@vger.kernel.org>; Mon, 12 Sep 2022 07:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=GFheNGVqLERZhSYCSZk/aU+ENoKVQ3v9+pQbZTcslEY=;
        b=exu7ea6b5fYdoPyhBfsq0X2/RyFa0nkTMBzKAhu/TECnWWoAiZHfnnwLAwMv3264+V
         fXHM3vi4u+FYXFDPi8lgH79yRErt5ZSm0OjEyIk4DTUOGRATDN4ye/pFZ0hOBeGwQMm+
         W/8jR6Hn+qX+5SqgaVqIG29xbM0agMOTL1bJnT6lT2WXBzCyq/aQvqNns0j1ZNrv5Aqk
         cZNf41l4yXFpBVe8FuZpCTTUZr0uicnZK4kOofuiYwoL7b5OBsNOiuLq6l2cZ2VKMUKz
         E3xq9TfZ8xigxuNDAJ6vqCOa67m63/y47yzeWjZcxhPF1Csy5kfCGmBsHaF1fKg4xohQ
         OHiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=GFheNGVqLERZhSYCSZk/aU+ENoKVQ3v9+pQbZTcslEY=;
        b=jlPFenXsQ8TcF2O9HMe1gx11lTnk49SF+Cur3dLjtu3mbQQ7hwWNT/0rApvmzr/1TG
         TSlmDN1dnFKqUA5/xzAPIRMtrEt9NjzYWLa4obVuxzfoi2FhA3YqWUbYNAIgWcq7Q4o+
         qm55gkw6UFYj2D4Zaz97Jywq+hBwBJm7MmSiGFD0iTvoghF+yQwnD4GW08jxup604IrL
         I0HF9Hf9c1pd2aJknFisbKyEeRVgdTUXd3wDYE5dkG2DuVURGom0xR/FOASCBiVsRx2j
         13zv1AlVpCHrSPqi7V1jGElAHKmeQ9aZdZePKiguAUjd7xJ9aGJk57jCSegaOBVMjvl5
         +Pdg==
X-Gm-Message-State: ACgBeo2maha5w/mrC5wxOeagluNJa5pqH5M4wui6vhIzx5cKXkLECgmY
        aeYtE/g9tGAVfWhi+d9bQC9L+w==
X-Google-Smtp-Source: AA6agR5eQXImfKaiccrP3GiMD3RTxMTyGKrsX6U7ojJdLRpLHqDclHPP5oVBbofCP8Qq/PcjRB6U6A==
X-Received: by 2002:a17:902:7d83:b0:170:9353:f299 with SMTP id a3-20020a1709027d8300b001709353f299mr26584625plm.41.1662992982931;
        Mon, 12 Sep 2022 07:29:42 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id t23-20020a635f17000000b0042b5095b7b4sm5758510pgb.5.2022.09.12.07.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 07:29:42 -0700 (PDT)
Date:   Mon, 12 Sep 2022 14:29:39 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] KVM: selftests: Test Hyper-V invariant TSC control
Message-ID: <Yx9CU++TkHZwVfEs@google.com>
References: <20220831085009.1627523-1-vkuznets@redhat.com>
 <20220831085009.1627523-4-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220831085009.1627523-4-vkuznets@redhat.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Aug 31, 2022, Vitaly Kuznetsov wrote:
> Add a test for the newly introduced Hyper-V invariant TSC control feature:
> - HV_X64_MSR_TSC_INVARIANT_CONTROL is not available without
>  HV_ACCESS_TSC_INVARIANT CPUID bit set and available with it.
> - BIT(0) of HV_X64_MSR_TSC_INVARIANT_CONTROL controls the filtering of
> architectural invariant TSC (CPUID.80000007H:EDX[8]) bit.
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  .../selftests/kvm/x86_64/hyperv_features.c    | 67 +++++++++++++++++++
>  1 file changed, 67 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/x86_64/hyperv_features.c b/tools/testing/selftests/kvm/x86_64/hyperv_features.c
> index 4ec4776662a4..26e8c5f7677e 100644
> --- a/tools/testing/selftests/kvm/x86_64/hyperv_features.c
> +++ b/tools/testing/selftests/kvm/x86_64/hyperv_features.c
> @@ -15,6 +15,9 @@
>  
>  #define LINUX_OS_ID ((u64)0x8100 << 48)
>  
> +/* CPUID.80000007H:EDX */
> +#define X86_FEATURE_INVTSC (1 << 8)
> +
>  static inline uint8_t hypercall(u64 control, vm_vaddr_t input_address,
>  				vm_vaddr_t output_address, uint64_t *hv_status)
>  {
> @@ -60,6 +63,24 @@ static void guest_msr(struct msr_data *msr)
>  		GUEST_ASSERT_2(!vector, msr->idx, vector);
>  	else
>  		GUEST_ASSERT_2(vector == GP_VECTOR, msr->idx, vector);
> +
> +	/* Invariant TSC bit appears when TSC invariant control MSR is written to */
> +	if (msr->idx == HV_X64_MSR_TSC_INVARIANT_CONTROL) {
> +		u32 eax, ebx, ecx, edx;
> +
> +		cpuid(0x80000007, &eax, &ebx, &ecx, &edx);

Add a proper kvm_x86_cpu_feature so that this is simply

		this_cpu_has(X86_FEATURE_INVTSC)

> +
> +		/*
> +		 * TSC invariant bit is present without the feature (legacy) or
> +		 * when the feature is present and enabled.
> +		 */
> +		if ((!msr->should_not_gp && !msr->write) || (msr->write && msr->write_val == 1))

Relying purely on the inputs is rather nasty as it creates a subtle dependency
on the "write 1" testcase coming last.  This function already reads the guest
MSR value, just use that to check if INVTSC should be enabled.  And if we want
to verify KVM "wrote" the correct value, then that can be done in the common
path.

And I think that will make this code self-documenting, e.g.

	if (msr->idx == HV_X64_MSR_TSC_INVARIANT_CONTROL)
		GUEST_ASSERT(this_cpu_has(X86_FEATURE_INVTSC) ==
			     !!(msr_val & ...));

> +			GUEST_ASSERT(edx & X86_FEATURE_INVTSC);
> +		else
> +			GUEST_ASSERT(!(edx & X86_FEATURE_INVTSC));
> +	}
> +
> +
>  	GUEST_DONE();
>  }
>  
> @@ -104,6 +125,15 @@ static void vcpu_reset_hv_cpuid(struct kvm_vcpu *vcpu)
>  	vcpu_clear_cpuid_entry(vcpu, HYPERV_CPUID_SYNDBG_PLATFORM_CAPABILITIES);
>  }
>  
> +static bool guest_has_invtsc(void)
> +{
> +	const struct kvm_cpuid_entry2 *cpuid;
> +
> +	cpuid = kvm_get_supported_cpuid_entry(0x80000007);
> +
> +	return cpuid->edx & X86_FEATURE_INVTSC;
> +}
> +
>  static void guest_test_msrs_access(void)
>  {
>  	struct kvm_cpuid2 *prev_cpuid = NULL;
> @@ -115,6 +145,7 @@ static void guest_test_msrs_access(void)
>  	int stage = 0;
>  	vm_vaddr_t msr_gva;
>  	struct msr_data *msr;
> +	bool has_invtsc = guest_has_invtsc();

Huh, I never added vcpu_has_cpuid_feature()?  Can you add that instead of
open-coding the check?
