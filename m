Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31732574A27
	for <lists+linux-hyperv@lfdr.de>; Thu, 14 Jul 2022 12:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237673AbiGNKIH (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 14 Jul 2022 06:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238023AbiGNKIG (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 14 Jul 2022 06:08:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DB992509D7
        for <linux-hyperv@vger.kernel.org>; Thu, 14 Jul 2022 03:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657793285;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5yLJ2bZUwPbEJHKaSwHhV1p/EnBfuuZT7nkMtiX7CVI=;
        b=fQhl7aFa5MH73iDBmc3YF9Xyk9xwBwwKaTSq2XRyRRTJ3uLcjKW1TtsnITxM86NwXn7QRy
        jV9O9bwPACfNnsbcbrWZjwJcMc+RHkfIYWOl+fJW3Rx+2/KM4t1TSRmXb9FI4g1zxb+cxj
        k88Nov8SAnxnl6VVbH4n9p6CimDOAuM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-93-JbputoJCM06dNzwY3jRXww-1; Thu, 14 Jul 2022 06:08:01 -0400
X-MC-Unique: JbputoJCM06dNzwY3jRXww-1
Received: by mail-wm1-f70.google.com with SMTP id v18-20020a05600c215200b003a2fea66b7cso547723wml.4
        for <linux-hyperv@vger.kernel.org>; Thu, 14 Jul 2022 03:08:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=5yLJ2bZUwPbEJHKaSwHhV1p/EnBfuuZT7nkMtiX7CVI=;
        b=yCCUbVkZEkMCnCRRTQG8swbZaUqLMLl/i3Z8YGgDQa1qdQ+BRv2zlB3hkVJN16OX+n
         hMuPAvTOSgwM7wcSqfndyTt8QbtsKq+DE5VBdDPZREUz4zTqX8pUnBcO9rEb/WsGWmM1
         R92y6JXhqRe5HTGMqHq2H1N0Kebqwvuq8mfaVY9JVak2APKD12TVkjL2EScJD+qEL6md
         f39UjH2NvR5ZDXMGswRXQ2KXTP3Ecknmob4Ri8MC/eyiMEk9qE/J93/WO/9B36iSFbYu
         yoVN0JZIIqQfXwSaV224DXa+qxweHRyyfQvSLXG7xztgHK0lLCbDBRy5sf7PrLbOw9EK
         J1AQ==
X-Gm-Message-State: AJIora+KaKdL25pRu7DweRt502hF6M/ZmsLjfgrdWX/Z8+EJMXVj3P+a
        wOghJea/EXTJpXbuva+VLRh9ztl1hkHraWN3CanYb6fqk8e9aFxbPehROV2lb5pVqjTqTPQcZn4
        DxB6omJrQiPKIdiXeCDI1n3Ej
X-Received: by 2002:a5d:5311:0:b0:21d:656b:807e with SMTP id e17-20020a5d5311000000b0021d656b807emr7337464wrv.521.1657793280642;
        Thu, 14 Jul 2022 03:08:00 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1spOrGYWP6gQ8F45DcZ+A44Aq18Wu0zW2WhwkrP140A8f4VGuWYv5/Pa7tkvvSjMmUb46z+eg==
X-Received: by 2002:a5d:5311:0:b0:21d:656b:807e with SMTP id e17-20020a5d5311000000b0021d656b807emr7337443wrv.521.1657793280463;
        Thu, 14 Jul 2022 03:08:00 -0700 (PDT)
Received: from [10.35.4.238] (bzq-82-81-161-50.red.bezeqint.net. [82.81.161.50])
        by smtp.gmail.com with ESMTPSA id o3-20020adfeac3000000b0021d6ac977fasm1042092wrn.69.2022.07.14.03.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 03:07:59 -0700 (PDT)
Message-ID: <3f4ff61979116c502663ab8b49ce869100f53e2a.camel@redhat.com>
Subject: Re: [PATCH v4 08/25] KVM: selftests: Switch to updated eVMCSv1
 definition
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 14 Jul 2022 13:07:58 +0300
In-Reply-To: <20220714091327.1085353-9-vkuznets@redhat.com>
References: <20220714091327.1085353-1-vkuznets@redhat.com>
         <20220714091327.1085353-9-vkuznets@redhat.com>
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

On Thu, 2022-07-14 at 11:13 +0200, Vitaly Kuznetsov wrote:
> Update Enlightened VMCS definition in selftests from KVM.
> 
> Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  .../selftests/kvm/include/x86_64/evmcs.h      | 45 +++++++++++++++++--
>  1 file changed, 42 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/include/x86_64/evmcs.h b/tools/testing/selftests/kvm/include/x86_64/evmcs.h
> index 3c9260f8e116..58db74f68af2 100644
> --- a/tools/testing/selftests/kvm/include/x86_64/evmcs.h
> +++ b/tools/testing/selftests/kvm/include/x86_64/evmcs.h
> @@ -203,14 +203,25 @@ struct hv_enlightened_vmcs {
>                 u32 reserved:30;
>         } hv_enlightenments_control;
>         u32 hv_vp_id;
> -
> +       u32 padding32_2;
>         u64 hv_vm_id;
>         u64 partition_assist_page;
>         u64 padding64_4[4];
>         u64 guest_bndcfgs;
> -       u64 padding64_5[7];
> +       u64 guest_ia32_perf_global_ctrl;
> +       u64 guest_ia32_s_cet;
> +       u64 guest_ssp;
> +       u64 guest_ia32_int_ssp_table_addr;
> +       u64 guest_ia32_lbr_ctl;
> +       u64 padding64_5[2];
>         u64 xss_exit_bitmap;
> -       u64 padding64_6[7];
> +       u64 encls_exiting_bitmap;
> +       u64 host_ia32_perf_global_ctrl;

Fixed here as well, thanks!

Best regards,
	Maxim Levitsky

> +       u64 tsc_multiplier;
> +       u64 host_ia32_s_cet;
> +       u64 host_ssp;
> +       u64 host_ia32_int_ssp_table_addr;
> +       u64 padding64_6;
>  };
>  
>  #define HV_VMX_ENLIGHTENED_CLEAN_FIELD_NONE                     0
> @@ -656,6 +667,18 @@ static inline int evmcs_vmread(uint64_t encoding, uint64_t *value)
>         case VIRTUAL_PROCESSOR_ID:
>                 *value = current_evmcs->virtual_processor_id;
>                 break;
> +       case HOST_IA32_PERF_GLOBAL_CTRL:
> +               *value = current_evmcs->host_ia32_perf_global_ctrl;
> +               break;
> +       case GUEST_IA32_PERF_GLOBAL_CTRL:
> +               *value = current_evmcs->guest_ia32_perf_global_ctrl;
> +               break;
> +       case ENCLS_EXITING_BITMAP:
> +               *value = current_evmcs->encls_exiting_bitmap;
> +               break;
> +       case TSC_MULTIPLIER:
> +               *value = current_evmcs->tsc_multiplier;
> +               break;
>         default: return 1;
>         }
>  
> @@ -1169,6 +1192,22 @@ static inline int evmcs_vmwrite(uint64_t encoding, uint64_t value)
>                 current_evmcs->virtual_processor_id = value;
>                 current_evmcs->hv_clean_fields &= ~HV_VMX_ENLIGHTENED_CLEAN_FIELD_CONTROL_XLAT;
>                 break;
> +       case HOST_IA32_PERF_GLOBAL_CTRL:
> +               current_evmcs->host_ia32_perf_global_ctrl = value;
> +               current_evmcs->hv_clean_fields &= ~HV_VMX_ENLIGHTENED_CLEAN_FIELD_HOST_GRP1;
> +               break;
> +       case GUEST_IA32_PERF_GLOBAL_CTRL:
> +               current_evmcs->guest_ia32_perf_global_ctrl = value;
> +               current_evmcs->hv_clean_fields &= ~HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP1;
> +               break;
> +       case ENCLS_EXITING_BITMAP:
> +               current_evmcs->encls_exiting_bitmap = value;
> +               current_evmcs->hv_clean_fields &= ~HV_VMX_ENLIGHTENED_CLEAN_FIELD_CONTROL_GRP2;
> +               break;
> +       case TSC_MULTIPLIER:
> +               current_evmcs->tsc_multiplier = value;
> +               current_evmcs->hv_clean_fields &= ~HV_VMX_ENLIGHTENED_CLEAN_FIELD_CONTROL_GRP2;
> +               break;
>         default: return 1;
>         }
>  


