Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35802571946
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 Jul 2022 13:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233061AbiGLL6m (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 12 Jul 2022 07:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233040AbiGLL6V (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 12 Jul 2022 07:58:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3B61FB6288
        for <linux-hyperv@vger.kernel.org>; Tue, 12 Jul 2022 04:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657627071;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E6mo0fjgCJvn0COaKmNGfmwMaRUQgez7gOZGTdEXFuU=;
        b=HGsQRMGxuITEsWz1IUSTmXSDtR+6xrBV0tf322Dj0mG50yhjLWXmf9M3rXRqbNugRFp9IA
        2aG0lYywnG1cHq8N1NHj+YA0+1iT8F0ehdzENDWc79ZhUk4uvk9Q3bVuKpGa/otqo7kGiO
        39wAHUwBjlSJFjlKnukK8pa4UC0DMiI=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-483-QP7wRt19N6CX6--dE5hPpg-1; Tue, 12 Jul 2022 07:57:50 -0400
X-MC-Unique: QP7wRt19N6CX6--dE5hPpg-1
Received: by mail-qk1-f200.google.com with SMTP id de4-20020a05620a370400b006a9711bd9f8so7559001qkb.9
        for <linux-hyperv@vger.kernel.org>; Tue, 12 Jul 2022 04:57:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=E6mo0fjgCJvn0COaKmNGfmwMaRUQgez7gOZGTdEXFuU=;
        b=WVr52MiWiKZ09TyFm+Gu0rfEd26oi3GChzjfULtIcjbnEVyPU0Unu0DsrtSTVAcSmm
         zOCnEj0Jr+q0scZ1X63yiJZlxZWbO6y/ZjgMwIe/ubtZIOj+NOQlGjhouBeapolCvPUN
         EON6LyQR+lMKBvxLJU3woH3PmGPEsuyIGnlbSrdWlG5J+Wh7Wi9s8zLOVd808eV1iBk5
         2f3VBaAKD+CMSPvdZqoqS3EqTVDLspBpDs2Av8X6oKJHXtHjLZ8KdECWfrVZk6ludsfo
         C2Pw/ff6yEnwektkQuqixZBtLs3D7kmnNXmaT/IM5+nHgkldbqgubOEBxAhezvow6VcG
         D7Cw==
X-Gm-Message-State: AJIora/eqAySLzJBaMStTglpfCtHCc1INBtZQ5lGT26h/DoQEvoYP5c+
        S5ElYdrtFwtUdaccFUUfP6SmtlHB6VVV1cYyFGRlUpAN77mD7G6/5R8Zq4bdWUebl4TP/3iNqbX
        aEQ6NgAjaiQXoWIdNK1C4qrzZ
X-Received: by 2002:ac8:7c4d:0:b0:31a:6e91:5f7a with SMTP id o13-20020ac87c4d000000b0031a6e915f7amr17204266qtv.441.1657627069327;
        Tue, 12 Jul 2022 04:57:49 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vvYmQmiVDjM/8YLCpDfQjgb7wdvPNRHF0AqwpZAs8YlTirKABOeI3IIhmjUZTWbhdmXETGZg==
X-Received: by 2002:ac8:7c4d:0:b0:31a:6e91:5f7a with SMTP id o13-20020ac87c4d000000b0031a6e915f7amr17204252qtv.441.1657627069114;
        Tue, 12 Jul 2022 04:57:49 -0700 (PDT)
Received: from [10.35.4.238] (bzq-82-81-161-50.red.bezeqint.net. [82.81.161.50])
        by smtp.gmail.com with ESMTPSA id a187-20020ae9e8c4000000b006b5517da3casm8552810qkg.22.2022.07.12.04.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 04:57:48 -0700 (PDT)
Message-ID: <da1cd0745c84fc580c49382d8aff1d047f45b16d.camel@redhat.com>
Subject: Re: [PATCH v3 18/25] KVM: VMX: Add missing CPU based VM execution
 controls to vmcs_config
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 12 Jul 2022 14:57:45 +0300
In-Reply-To: <20220708144223.610080-19-vkuznets@redhat.com>
References: <20220708144223.610080-1-vkuznets@redhat.com>
         <20220708144223.610080-19-vkuznets@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-5.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, 2022-07-08 at 16:42 +0200, Vitaly Kuznetsov wrote:
> As a preparation to reusing the result of setup_vmcs_config() in
> nested VMX MSR setup, add the CPU based VM execution controls which KVM
> doesn't use but supports for nVMX to KVM_OPT_VMX_CPU_BASED_VM_EXEC_CONTROL
> and filter them out in vmx_exec_control().
> 
> No functional change intended.
> 
> Reviewed-by: Jim Mattson <jmattson@google.com>
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  arch/x86/kvm/vmx/vmx.c | 6 ++++++
>  arch/x86/kvm/vmx/vmx.h | 6 +++++-
>  2 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 2fb89bdcbbd8..9771c771c8f5 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -4240,6 +4240,12 @@ static u32 vmx_exec_control(struct vcpu_vmx *vmx)
>  {
>         u32 exec_control = vmcs_config.cpu_based_exec_ctrl;
>  
> +       /* Not used by KVM but supported for nesting. */
> +       exec_control &= ~(CPU_BASED_RDTSC_EXITING |
> +                         CPU_BASED_USE_IO_BITMAPS |
> +                         CPU_BASED_MONITOR_TRAP_FLAG |
> +                         CPU_BASED_PAUSE_EXITING);
> +
>         /* INTR_WINDOW_EXITING and NMI_WINDOW_EXITING are toggled dynamically */
>         exec_control &= ~(CPU_BASED_INTR_WINDOW_EXITING |
>                           CPU_BASED_NMI_WINDOW_EXITING);
> diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
> index e9c392398f1b..758f80c41beb 100644
> --- a/arch/x86/kvm/vmx/vmx.h
> +++ b/arch/x86/kvm/vmx/vmx.h
> @@ -539,9 +539,13 @@ static inline u8 vmx_get_rvi(void)
>  #endif
>  
>  #define KVM_OPT_VMX_CPU_BASED_VM_EXEC_CONTROL                  \
> -       (CPU_BASED_TPR_SHADOW |                                 \
> +       (CPU_BASED_RDTSC_EXITING |                              \
> +       CPU_BASED_TPR_SHADOW |                                  \
> +       CPU_BASED_USE_IO_BITMAPS |                              \
> +       CPU_BASED_MONITOR_TRAP_FLAG |                           \
>         CPU_BASED_USE_MSR_BITMAPS |                             \
>         CPU_BASED_NMI_WINDOW_EXITING |                          \
> +       CPU_BASED_PAUSE_EXITING |                               \
>         CPU_BASED_ACTIVATE_SECONDARY_CONTROLS |                 \
>         CPU_BASED_ACTIVATE_TERTIARY_CONTROLS)
>  

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky <mlevitsk@redhat.com>

