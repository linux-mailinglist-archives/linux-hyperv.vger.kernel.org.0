Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E66F4571949
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 Jul 2022 13:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbiGLL72 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 12 Jul 2022 07:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233032AbiGLL67 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 12 Jul 2022 07:58:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 47B2BF59
        for <linux-hyperv@vger.kernel.org>; Tue, 12 Jul 2022 04:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657627113;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tN6vFUpo/wAbFsq44AFOSDmkPA0arGUmJ053wonWD+c=;
        b=ZHNKlbCF8sl+rcAvyLk9ZnouqkmvX8UfJ0a/G1dYz5xHbODZGI+GhmBsBM1m0VJcA5VVlK
        pFr+Wb0yrcsvhJ63YNRoAfcaLF9gp0gcTNquvEJXi+dlXP1I+5mMcBU+15DCyaduDSRAoy
        XaIdLDsyPTEtrI5yD6UUDKqNoKBQFEw=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-416-EC5SuggyNJy630YesaNLyA-1; Tue, 12 Jul 2022 07:58:32 -0400
X-MC-Unique: EC5SuggyNJy630YesaNLyA-1
Received: by mail-qv1-f70.google.com with SMTP id ok7-20020a0562143c8700b00472f0b33853so1660995qvb.12
        for <linux-hyperv@vger.kernel.org>; Tue, 12 Jul 2022 04:58:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=tN6vFUpo/wAbFsq44AFOSDmkPA0arGUmJ053wonWD+c=;
        b=eJZoem6HPRQANDZWm4rAz8LYcyRnfNIYTVrixY1iNk4ONrYpTjpiUSqti/3a++gjJN
         xDz4FM9m+QwpjNUOaoDtIzi8Qb5t/6+hUnTRd8vuVReTxUPmyRb7yPqCTykUvWMB/Jub
         3wT9sx8fNJJfrNm8OIGh0XovYyv9aHMqTmo6xyLMt+9ZEHTgiwqkS+G40jGb1Isz0JsU
         y4JyGhmJr6AdsQ6y1AniBjSuUMMNtWR8tggpSk0UrGFzgtWTgP+9EE614E2tEwpCgHyn
         J4ovS8PWiNH2fj8HBz5TBWtRLjxglo1yhodYCEemffa593SG5QoxNrxN8WsCKOTsmqmv
         pgYg==
X-Gm-Message-State: AJIora87R1p8go922aicnfgCc3x/HtNZXpIuGYsSTBDKPw6WTKNhpF39
        G6lDqRqHBeLwIxZcO+wNmtVIr+SgnvFOyc8jSExf+TfLEVHtkxucec+/fvWk9yFIsbTACZuc1Ze
        4ajqK7zy5a7r4+nRIc9uZvOPu
X-Received: by 2002:a37:8d3:0:b0:6b5:8adf:208a with SMTP id 202-20020a3708d3000000b006b58adf208amr5902022qki.215.1657627111817;
        Tue, 12 Jul 2022 04:58:31 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1veJb+pDI8XvNUrlheSB9UNvRqZZJS0lkNPKf9/bHp/iY23Zpjl5fYcNzGAM12JOh1bJyJp4g==
X-Received: by 2002:a37:8d3:0:b0:6b5:8adf:208a with SMTP id 202-20020a3708d3000000b006b58adf208amr5902015qki.215.1657627111625;
        Tue, 12 Jul 2022 04:58:31 -0700 (PDT)
Received: from [10.35.4.238] (bzq-82-81-161-50.red.bezeqint.net. [82.81.161.50])
        by smtp.gmail.com with ESMTPSA id u19-20020a05620a0c5300b006b5ab88e544sm421901qki.124.2022.07.12.04.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 04:58:31 -0700 (PDT)
Message-ID: <085a6f661672da1e507422ea4404e144abbd5562.camel@redhat.com>
Subject: Re: [PATCH v3 19/25] KVM: VMX: Adjust CR3/INVPLG interception for
 EPT=y at runtime, not setup
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 12 Jul 2022 14:58:27 +0300
In-Reply-To: <20220708144223.610080-20-vkuznets@redhat.com>
References: <20220708144223.610080-1-vkuznets@redhat.com>
         <20220708144223.610080-20-vkuznets@redhat.com>
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
> From: Sean Christopherson <seanjc@google.com>
> 
> Clear the CR3 and INVLPG interception controls at runtime based on
> whether or not EPT is being _used_, as opposed to clearing the bits at
> setup if EPT is _supported_ in hardware, and then restoring them when EPT
> is not used.  Not mucking with the base config will allow using the base
> config as the starting point for emulating the VMX capability MSRs.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Reviewed-by: Jim Mattson <jmattson@google.com>
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  arch/x86/kvm/vmx/vmx.c | 18 +++++++-----------
>  1 file changed, 7 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 9771c771c8f5..eca6875d6732 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -2501,13 +2501,8 @@ static __init int setup_vmcs_config(struct vmcs_config *vmcs_conf,
>         rdmsr_safe(MSR_IA32_VMX_EPT_VPID_CAP,
>                 &vmx_cap->ept, &vmx_cap->vpid);
>  
> -       if (_cpu_based_2nd_exec_control & SECONDARY_EXEC_ENABLE_EPT) {
> -               /* CR3 accesses and invlpg don't need to cause VM Exits when EPT
> -                  enabled */
> -               _cpu_based_exec_control &= ~(CPU_BASED_CR3_LOAD_EXITING |
> -                                            CPU_BASED_CR3_STORE_EXITING |
> -                                            CPU_BASED_INVLPG_EXITING);
> -       } else if (vmx_cap->ept) {
> +       if (!(_cpu_based_2nd_exec_control & SECONDARY_EXEC_ENABLE_EPT) &&
> +           vmx_cap->ept) {
>                 pr_warn_once("EPT CAP should not exist if not support "
>                                 "1-setting enable EPT VM-execution control\n");
>  
> @@ -4264,10 +4259,11 @@ static u32 vmx_exec_control(struct vcpu_vmx *vmx)
>                 exec_control |= CPU_BASED_CR8_STORE_EXITING |
>                                 CPU_BASED_CR8_LOAD_EXITING;
>  #endif
> -       if (!enable_ept)
> -               exec_control |= CPU_BASED_CR3_STORE_EXITING |
> -                               CPU_BASED_CR3_LOAD_EXITING  |
> -                               CPU_BASED_INVLPG_EXITING;
> +       /* No need to intercept CR3 access or INVPLG when using EPT. */
> +       if (enable_ept)
> +               exec_control &= ~(CPU_BASED_CR3_LOAD_EXITING |
> +                                 CPU_BASED_CR3_STORE_EXITING |
> +                                 CPU_BASED_INVLPG_EXITING);
>         if (kvm_mwait_in_guest(vmx->vcpu.kvm))
>                 exec_control &= ~(CPU_BASED_MWAIT_EXITING |
>                                 CPU_BASED_MONITOR_EXITING);


Makes sense, although the 'runtime' word a bit misleading, as we don't allow to change
'enable_ept' after kvm_intel is loaded I think.


Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky

