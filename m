Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0801571931
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 Jul 2022 13:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232812AbiGLL5F (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 12 Jul 2022 07:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232888AbiGLL4u (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 12 Jul 2022 07:56:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 415EB2A71D
        for <linux-hyperv@vger.kernel.org>; Tue, 12 Jul 2022 04:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657626992;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qfc1A89ED4fhg0R8xqH3w64VTj5vw+dyc3zkUFhfwYU=;
        b=gycflAmx2JKdLHNg2aoni1l98gXfa9/ga4V167bJB94+aWDEpXd523AmNWb/HhL9pNYcK/
        D4dbD4eI9ZSeAaTBKj610I4c5nUa7YtEL4Gc7x0mwhnIiDe4/4VpT5mkJorE2R6kfxyQYQ
        nKI84+A3iYhVIXB2HgZBVjIAQ5loi2A=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-344-4kDzVr22M-S6QFEIMDFlig-1; Tue, 12 Jul 2022 07:56:26 -0400
X-MC-Unique: 4kDzVr22M-S6QFEIMDFlig-1
Received: by mail-qv1-f72.google.com with SMTP id q4-20020a0ce9c4000000b00473004919ddso1665580qvo.16
        for <linux-hyperv@vger.kernel.org>; Tue, 12 Jul 2022 04:56:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=qfc1A89ED4fhg0R8xqH3w64VTj5vw+dyc3zkUFhfwYU=;
        b=ZAbDcAfOuBi3cOxyxDlHSqkwHF31zXgM7T1HMwguRdolmTjRD5j+LEYa6HzPCduH+P
         uiOcB1mniL0du55DznofDJxrB3Hm1pg+R5Gsmccsd6MY3LCWJUoO5rgBwNMHTJNzhrfB
         8bk7/xF2Cm+hS/lvLIqe2kHYJAnZKjTN1leFG5JL9sP8ACg/Cm7ZdOc2ldB0pvITYRAz
         AbQ4oU2QTzTkDLhqfpyoGC69bbyH+TcXyzogdI7ttxNpR+F+Xy+dRE3vc1CmkW9Vre0A
         dqXuMCsH9p/JWmgb1MVZ08RaClEbyTFs5w/xqVMplf3msNEAHCSe5xjroPI5nAPYGRfw
         p6hQ==
X-Gm-Message-State: AJIora9t587XAqOS3zLaNLhzdQc1A7q2U2ZZN54aBnxUQ0QdudzOTW8g
        qjpGrqzsj/8TkdhccME2jtNvBsdLVuVqROq2J5NYTERsnUNaSBH2gtXGFOp7uHzE2dv74giH1/S
        xveT/w2+7xhtjNJxLbPiyreSt
X-Received: by 2002:ac8:5e46:0:b0:317:6146:6f05 with SMTP id i6-20020ac85e46000000b0031761466f05mr18139051qtx.490.1657626986414;
        Tue, 12 Jul 2022 04:56:26 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1smwE8DmmPk8Zo8gZR1AzKKySTix/flcz8j70kP3A4KvDNHGomiSv4SWkOBMk2VnYq5OceaNQ==
X-Received: by 2002:ac8:5e46:0:b0:317:6146:6f05 with SMTP id i6-20020ac85e46000000b0031761466f05mr18139039qtx.490.1657626986214;
        Tue, 12 Jul 2022 04:56:26 -0700 (PDT)
Received: from [10.35.4.238] (bzq-82-81-161-50.red.bezeqint.net. [82.81.161.50])
        by smtp.gmail.com with ESMTPSA id w15-20020ac86b0f000000b0031eb00e6fc9sm6120884qts.32.2022.07.12.04.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 04:56:25 -0700 (PDT)
Message-ID: <27bfdbc9ef7e7471fd20b18d697f6845fdceb388.camel@redhat.com>
Subject: Re: [PATCH v3 14/25] KVM: VMX: Tweak the special handling of
 SECONDARY_EXEC_ENCLS_EXITING in setup_vmcs_config()
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 12 Jul 2022 14:56:21 +0300
In-Reply-To: <20220708144223.610080-15-vkuznets@redhat.com>
References: <20220708144223.610080-1-vkuznets@redhat.com>
         <20220708144223.610080-15-vkuznets@redhat.com>
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
> SECONDARY_EXEC_ENCLS_EXITING is conditionally added to the 'optional'
> checklist in setup_vmcs_config() but there's little value in doing so.
> First, as the control is optional, we can always check for its
> presence, no harm done. Second, the only real value cpu_has_sgx() check
> gives is that on the CPUs which support SECONDARY_EXEC_ENCLS_EXITING but
> don't support SGX, the control is not getting enabled. It's highly unlikely
> such CPUs exist but it's possible that some hypervisors expose broken vCPU
> models.
> 
> Preserve cpu_has_sgx() check but filter the result of adjust_vmx_controls()
> instead of the input.
> 
> Reviewed-by: Jim Mattson <jmattson@google.com>
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  arch/x86/kvm/vmx/vmx.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index ce54f13d8da1..566be73c6509 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -2528,9 +2528,9 @@ static __init int setup_vmcs_config(struct vmcs_config *vmcs_conf,
>                         SECONDARY_EXEC_PT_CONCEAL_VMX |
>                         SECONDARY_EXEC_ENABLE_VMFUNC |
>                         SECONDARY_EXEC_BUS_LOCK_DETECTION |
> -                       SECONDARY_EXEC_NOTIFY_VM_EXITING;
> -               if (cpu_has_sgx())
> -                       opt2 |= SECONDARY_EXEC_ENCLS_EXITING;
> +                       SECONDARY_EXEC_NOTIFY_VM_EXITING |
> +                       SECONDARY_EXEC_ENCLS_EXITING;
> +
>                 if (adjust_vmx_controls(min2, opt2,
>                                         MSR_IA32_VMX_PROCBASED_CTLS2,
>                                         &_cpu_based_2nd_exec_control) < 0)
> @@ -2577,6 +2577,9 @@ static __init int setup_vmcs_config(struct vmcs_config *vmcs_conf,
>                 vmx_cap->vpid = 0;
>         }
>  
> +       if (!cpu_has_sgx())
> +               _cpu_based_2nd_exec_control &= ~SECONDARY_EXEC_ENCLS_EXITING;
> +
>         if (_cpu_based_exec_control & CPU_BASED_ACTIVATE_TERTIARY_CONTROLS) {
>                 u64 opt3 = TERTIARY_EXEC_IPI_VIRT;
>  


Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky


