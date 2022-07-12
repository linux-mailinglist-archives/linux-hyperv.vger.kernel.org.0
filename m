Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08067571920
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 Jul 2022 13:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232070AbiGLLy7 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 12 Jul 2022 07:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232912AbiGLLyl (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 12 Jul 2022 07:54:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AE234B521C
        for <linux-hyperv@vger.kernel.org>; Tue, 12 Jul 2022 04:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657626857;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K/Y45MWLvtRZQAQMme1NWCA15wADRq0pOspGW9SWYbc=;
        b=JvlkMhTpI6Qo8JKmSPvk/lfydowUSFpIrCwzd9TglBkMAf9Myr0G3h+Cq4uCEACrB1pIC3
        ewRra4sOz9aKfVECOtsy/oC+ZQbE85fMSMCr4r6IgM1bfCRIxtr1qOhDkpwrHB5t9k7wyC
        Lk351XqcClr59F/OLx/Ac9OGHaBtHBY=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-21-8DjfxmfoPES7-LGk2GN8gA-1; Tue, 12 Jul 2022 07:54:16 -0400
X-MC-Unique: 8DjfxmfoPES7-LGk2GN8gA-1
Received: by mail-qk1-f197.google.com with SMTP id a7-20020a37b107000000b006af3bc02282so7685432qkf.21
        for <linux-hyperv@vger.kernel.org>; Tue, 12 Jul 2022 04:54:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=K/Y45MWLvtRZQAQMme1NWCA15wADRq0pOspGW9SWYbc=;
        b=UXgpI/la6xy68Uh5yAr44/I3bWCvippmT8MZNqoaphvJvENtRBXp9l9u+soxaBQBUW
         Sk5ZobxtKvS/BpNz/ppMlLzJKwEVmDL6JelqX9EpilXyz9Rn19dpgyLu7NVbJCr3DvHI
         MOU4wTk5ddd4B/HU+LwaU4Su3YXhbhl7rXFVTA/HkyDiGyUIzQZHtskgJcqjrYJqSMfU
         AWw3GJZt3om/1NcArmJk3K13i9zbitKL0e61avmxw10LZgTUA+MD/vYnPSwghRBrSftb
         QrjlXe4Jf9xuJuqe96s0R0P5EH8PQvEbgR7DXWqXuETSoXdb6zuM5S/pShSuDhhv2nCc
         IvYQ==
X-Gm-Message-State: AJIora8nnz6sp+YJNyZSTDIeB4WiOqSORa0SM3kisQjF3jjPEX6bwsqE
        9HiVwxSV7zzu6NU/5SVP+mxeu4ENU5tJnrzGSTiIadejbPTq8Nf8Kb1cGT8EOVYja6mkBmsW1M9
        VDu3T+glV2uO9GQVTIKPS6lsJ
X-Received: by 2002:a05:620a:2991:b0:6b5:9921:6bb6 with SMTP id r17-20020a05620a299100b006b599216bb6mr3861381qkp.553.1657626856318;
        Tue, 12 Jul 2022 04:54:16 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uttgtgZ9z3Hy3T6ZIJ02RXN1KbaDIKXQ51OXBaCi+NRy80KGVyzDnRNPyv/kz+rtPXo5jpVw==
X-Received: by 2002:a05:620a:2991:b0:6b5:9921:6bb6 with SMTP id r17-20020a05620a299100b006b599216bb6mr3861367qkp.553.1657626856113;
        Tue, 12 Jul 2022 04:54:16 -0700 (PDT)
Received: from [10.35.4.238] (bzq-82-81-161-50.red.bezeqint.net. [82.81.161.50])
        by smtp.gmail.com with ESMTPSA id v24-20020a05622a189800b0031e99798d70sm7529905qtc.29.2022.07.12.04.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 04:54:15 -0700 (PDT)
Message-ID: <c3cf37f3dd115286db53df6fa175d7ee729610d4.camel@redhat.com>
Subject: Re: [PATCH v3 10/25] KVM: selftests: Enable TSC scaling in evmcs
 selftest
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 12 Jul 2022 14:54:11 +0300
In-Reply-To: <20220708144223.610080-11-vkuznets@redhat.com>
References: <20220708144223.610080-1-vkuznets@redhat.com>
         <20220708144223.610080-11-vkuznets@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-5.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, 2022-07-08 at 16:42 +0200, Vitaly Kuznetsov wrote:
> The updated Enlightened VMCS v1 definition enables TSC scaling, test
> that SECONDARY_EXEC_TSC_SCALING can now be enabled.
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  .../testing/selftests/kvm/x86_64/evmcs_test.c | 31 +++++++++++++++++--
>  1 file changed, 29 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/x86_64/evmcs_test.c b/tools/testing/selftests/kvm/x86_64/evmcs_test.c
> index 8dda527cc080..80135b98dc3b 100644
> --- a/tools/testing/selftests/kvm/x86_64/evmcs_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/evmcs_test.c
> @@ -18,6 +18,9 @@
>  
>  #include "vmx.h"
>  
> +/* Test flags */
> +#define HOST_HAS_TSC_SCALING BIT(0)
> +
>  static int ud_count;
>  
>  static void guest_ud_handler(struct ex_regs *regs)
> @@ -64,11 +67,14 @@ void l2_guest_code(void)
>         vmcall();
>         rdmsr_gs_base(); /* intercepted */
>  
> +       /* TSC scaling */
> +       vmcall();
> +
>         /* Done, exit to L1 and never come back.  */
>         vmcall();
>  }
>  
> -void guest_code(struct vmx_pages *vmx_pages)
> +void guest_code(struct vmx_pages *vmx_pages, u64 test_flags)
>  {
>  #define L2_GUEST_STACK_SIZE 64
>         unsigned long l2_guest_stack[L2_GUEST_STACK_SIZE];
> @@ -150,6 +156,18 @@ void guest_code(struct vmx_pages *vmx_pages)
>         GUEST_ASSERT(vmreadz(VM_EXIT_REASON) == EXIT_REASON_VMCALL);
>         GUEST_SYNC(11);
>  
> +       if (test_flags & HOST_HAS_TSC_SCALING) {
> +               GUEST_ASSERT((rdmsr(MSR_IA32_VMX_PROCBASED_CTLS2) >> 32) &
> +                            SECONDARY_EXEC_TSC_SCALING);
> +               /* Try enabling TSC scaling */
> +               vmwrite(SECONDARY_VM_EXEC_CONTROL, vmreadz(SECONDARY_VM_EXEC_CONTROL) |
> +                       SECONDARY_EXEC_TSC_SCALING);
> +               vmwrite(TSC_MULTIPLIER, 1);
> +       }
> +       GUEST_ASSERT(!vmresume());
> +       GUEST_ASSERT(vmreadz(VM_EXIT_REASON) == EXIT_REASON_VMCALL);
> +       GUEST_SYNC(12);
> +
>         /* Try enlightened vmptrld with an incorrect GPA */
>         evmcs_vmptrld(0xdeadbeef, vmx_pages->enlightened_vmcs);
>         GUEST_ASSERT(vmlaunch());
> @@ -204,6 +222,7 @@ int main(int argc, char *argv[])
>         struct kvm_vm *vm;
>         struct kvm_run *run;
>         struct ucall uc;
> +       u64 test_flags = 0;
>         int stage;
>  
>         vm = vm_create_with_one_vcpu(&vcpu, guest_code);
> @@ -212,11 +231,19 @@ int main(int argc, char *argv[])
>         TEST_REQUIRE(kvm_has_cap(KVM_CAP_NESTED_STATE));
>         TEST_REQUIRE(kvm_has_cap(KVM_CAP_HYPERV_ENLIGHTENED_VMCS));
>  
> +       if ((kvm_get_feature_msr(MSR_IA32_VMX_PROCBASED_CTLS2) >> 32) &
> +           SECONDARY_EXEC_TSC_SCALING) {
> +               test_flags |= HOST_HAS_TSC_SCALING;
> +               pr_info("TSC scaling is supported, adding to test\n");
> +       } else {
> +               pr_info("TSC scaling is not supported\n");
> +       }
> +
>         vcpu_set_hv_cpuid(vcpu);
>         vcpu_enable_evmcs(vcpu);
>  
>         vcpu_alloc_vmx(vm, &vmx_pages_gva);
> -       vcpu_args_set(vcpu, 1, vmx_pages_gva);
> +       vcpu_args_set(vcpu, 2, vmx_pages_gva, test_flags);
>  
>         vm_init_descriptor_tables(vm);
>         vcpu_init_descriptor_tables(vcpu);

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky



