Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7B857193D
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 Jul 2022 13:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232965AbiGLL5r (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 12 Jul 2022 07:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232414AbiGLL5X (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 12 Jul 2022 07:57:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 22584B5D3F
        for <linux-hyperv@vger.kernel.org>; Tue, 12 Jul 2022 04:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657627039;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=olaRyc5m79LX2YhKauQNe+T3doYLi+ybnhrejxK98CE=;
        b=TJ1AxfvxO6K1rnNK4A9c/Bv0dApp/g7D/rfJtq4bEGomcrNMuPGKJtbhJYPgON5WNInuFC
        InREvzyXccyp9IHk1rx5sKo3WilEaTHoiLNaJ7/SBA90RfPEaREWYvp8E68fTrv8TPdd7U
        CtRFa7t8qAO8xXxM2UsaXiRMF8OfJyA=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-98-RaVtIlmJM12odnXzDSEryw-1; Tue, 12 Jul 2022 07:57:17 -0400
X-MC-Unique: RaVtIlmJM12odnXzDSEryw-1
Received: by mail-qk1-f200.google.com with SMTP id s9-20020a05620a254900b006b54dd4d6deso7584053qko.3
        for <linux-hyperv@vger.kernel.org>; Tue, 12 Jul 2022 04:57:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=olaRyc5m79LX2YhKauQNe+T3doYLi+ybnhrejxK98CE=;
        b=Ysh7wSVjHa9gRGgf//qi2mpxlLTpbLyQPXs8sQ4VZZ5neBWiZOv0DI1GXwSGmWsGUP
         XNREBj7+JOmbRwmdPrFAd3/3s2RzEg0mAeZV3pG+oUrG95XA61ofh4vE/tu3CoGO5de4
         MusZIFXRocuDUh3Y+eDg36YhaSX8JT1APhJ10mHVI57JG/j9XiKesU3Jsyg6FDbPnqQ1
         HTqMlw8+go2RRcHeH06TwvILBNQVV5em4haaiPjm7tSwium/wbJ0yMsUo+LKXyUpDZnr
         0qZCSVwSuwYGpSkVqTREWNeMJt/hnbE8vf35SfjYt08//yQ/amOR6d7hAbaqAOohAdy5
         Mr6w==
X-Gm-Message-State: AJIora+ybBg999fEwHvT78ow4LJMhwWGZDQYwXhLH/RJGm8YTKpQ5OPK
        YWJZUVpf/w6Tae1wCzYlv3/hOPgQKk0bLjqGRfqMgJGCgNZkIhkGmQcl8OepvPlGq6LW3p0l41u
        9tj8ySS/LqPQOK3GawyuiUdDg
X-Received: by 2002:ac8:5a4a:0:b0:31e:c15f:c1f9 with SMTP id o10-20020ac85a4a000000b0031ec15fc1f9mr1802433qta.12.1657627037538;
        Tue, 12 Jul 2022 04:57:17 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1urHh4ODy0b6XiDk4WThbx6/yS3IFDPugQq8wMUsZi0/m+3IrBehtXOQ128Owji6o19BTZj8A==
X-Received: by 2002:ac8:5a4a:0:b0:31e:c15f:c1f9 with SMTP id o10-20020ac85a4a000000b0031ec15fc1f9mr1802350qta.12.1657627036023;
        Tue, 12 Jul 2022 04:57:16 -0700 (PDT)
Received: from [10.35.4.238] (bzq-82-81-161-50.red.bezeqint.net. [82.81.161.50])
        by smtp.gmail.com with ESMTPSA id n7-20020ae9c307000000b006a34a22bc60sm8400241qkg.9.2022.07.12.04.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 04:57:15 -0700 (PDT)
Message-ID: <031867fe65f26f7e2d37cc41ec071b3aea98ee90.camel@redhat.com>
Subject: Re: [PATCH v3 17/25] KVM: VMX: Add missing VMEXIT controls to
 vmcs_config
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 12 Jul 2022 14:57:11 +0300
In-Reply-To: <20220708144223.610080-18-vkuznets@redhat.com>
References: <20220708144223.610080-1-vkuznets@redhat.com>
         <20220708144223.610080-18-vkuznets@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-5.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, 2022-07-08 at 16:42 +0200, Vitaly Kuznetsov wrote:
> As a preparation to reusing the result of setup_vmcs_config() in
> nested VMX MSR setup, add the VMEXIT controls which KVM doesn't
> use but supports for nVMX to KVM_OPT_VMX_VM_EXIT_CONTROLS and
> filter them out in vmx_vmexit_ctrl().
> 
> No functional change intended.
> 
> Reviewed-by: Jim Mattson <jmattson@google.com>
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  arch/x86/kvm/vmx/vmx.c | 4 ++++
>  arch/x86/kvm/vmx/vmx.h | 3 +++
>  2 files changed, 7 insertions(+)
> 
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index d7170990f469..2fb89bdcbbd8 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -4196,6 +4196,10 @@ static u32 vmx_vmexit_ctrl(void)
>  {
>         u32 vmexit_ctrl = vmcs_config.vmexit_ctrl;
>  
> +       /* Not used by KVM but supported for nesting. */
> +       vmexit_ctrl &= ~(VM_EXIT_SAVE_IA32_PAT | VM_EXIT_SAVE_IA32_EFER |
> +                        VM_EXIT_SAVE_VMX_PREEMPTION_TIMER);
> +
>         if (vmx_pt_mode_is_system())
>                 vmexit_ctrl &= ~(VM_EXIT_PT_CONCEAL_PIP |
>                                  VM_EXIT_CLEAR_IA32_RTIT_CTL);
> diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
> index 89eaab3495a6..e9c392398f1b 100644
> --- a/arch/x86/kvm/vmx/vmx.h
> +++ b/arch/x86/kvm/vmx/vmx.h
> @@ -498,8 +498,11 @@ static inline u8 vmx_get_rvi(void)
>  #endif
>  #define KVM_OPT_VMX_VM_EXIT_CONTROLS                           \
>               (VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL |             \
> +             VM_EXIT_SAVE_IA32_PAT |                           \
>               VM_EXIT_LOAD_IA32_PAT |                           \
> +             VM_EXIT_SAVE_IA32_EFER |                          \
>               VM_EXIT_LOAD_IA32_EFER |                          \
> +             VM_EXIT_SAVE_VMX_PREEMPTION_TIMER |               \
>               VM_EXIT_CLEAR_BNDCFGS |                           \
>               VM_EXIT_PT_CONCEAL_PIP |                          \
>               VM_EXIT_CLEAR_IA32_RTIT_CTL)


Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky

