Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A344957190E
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 Jul 2022 13:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbiGLLyI (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 12 Jul 2022 07:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232844AbiGLLxl (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 12 Jul 2022 07:53:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 71035B5212
        for <linux-hyperv@vger.kernel.org>; Tue, 12 Jul 2022 04:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657626748;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dhbH7KElfOyWiL5eIhAtguRUr0eHcXNIg5bb45tjqNE=;
        b=eLWdRgdCzL+kl4jBC59VpRddjxUNTECiveC2fYIebgL1RmwQ1eGduYBYeYEy3ZZ0J1G2UB
        ZEF4chnIgouNWXO7wPJRK3DPkCDhR1AN7c+JSj3HJV/fPgOsIM2lidz27pge3JzIGmVq5B
        MDkq34lB+LS9yXSR2MhB7H1kQ34XeWU=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-619-tmndzi5BPHS9JQEcs7vRDA-1; Tue, 12 Jul 2022 07:52:27 -0400
X-MC-Unique: tmndzi5BPHS9JQEcs7vRDA-1
Received: by mail-qv1-f69.google.com with SMTP id r12-20020ad4404c000000b00472ffb530e2so1654259qvp.18
        for <linux-hyperv@vger.kernel.org>; Tue, 12 Jul 2022 04:52:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=dhbH7KElfOyWiL5eIhAtguRUr0eHcXNIg5bb45tjqNE=;
        b=tGBIgHp8OMLtlsoxCDn4eL3963MRMSR0uGZ6lrHns+LP98LipV/J9tLvEQSOcUaH8E
         WvVC7q5M1p/aFhVe0nWbwjZIk6P9fwLndvCLHNzgqg8aacLlq4wB0YLYr2q/huCTFjhZ
         g+PM1z/TlMuV95ED/1Jdg7YcjKyiiwV2KHFvsET+2ciZ62hZy5vx3a73BDsdYCyfrJDI
         ZeYoamNjnlC+uG3v1hMHpBqDzhWWtj1p5FvMj9xae1Ub0Z3sdPSuphupdn3v5sEQ+nmX
         phB84pCn3FqIC/oMVaSbdFYDJSpGiM6kpz9pJ13qxb9JPnBKCDhLddwMgxPg1rY8uDEW
         vyZQ==
X-Gm-Message-State: AJIora/sl8daA9/ar0Tu3RNHQVjVMWQFtw4pQRhCHjNYIQz1fhPHtz4Q
        5IGtBJkWS3BEOTeMJFjqtY+yjP0JrvNkwfh9/qZkvUO09q3o08/kpQtL2h+X3XHbJ7rY/JOC5aW
        kfJejaYQ1pLbiyHNSBDWl+T10
X-Received: by 2002:a05:620a:288a:b0:6b5:3d7d:5c22 with SMTP id j10-20020a05620a288a00b006b53d7d5c22mr14480466qkp.603.1657626745947;
        Tue, 12 Jul 2022 04:52:25 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sEGjmBVqQz0S7Qf0iQ9nIMt3O3IZzz5WmXPQMyFXuPxc6Trhfrnmn1TD7JlrXBV9C5wQe3fA==
X-Received: by 2002:a05:620a:288a:b0:6b5:3d7d:5c22 with SMTP id j10-20020a05620a288a00b006b53d7d5c22mr14480447qkp.603.1657626745706;
        Tue, 12 Jul 2022 04:52:25 -0700 (PDT)
Received: from [10.35.4.238] (bzq-82-81-161-50.red.bezeqint.net. [82.81.161.50])
        by smtp.gmail.com with ESMTPSA id h19-20020a379e13000000b006b55da43182sm8164931qke.23.2022.07.12.04.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 04:52:25 -0700 (PDT)
Message-ID: <f0b3d3ef960882b34e365bc6fbb97d8df8931efc.camel@redhat.com>
Subject: Re: [PATCH v3 08/25] KVM: selftests: Switch to updated eVMCSv1
 definition
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 12 Jul 2022 14:52:21 +0300
In-Reply-To: <20220708144223.610080-9-vkuznets@redhat.com>
References: <20220708144223.610080-1-vkuznets@redhat.com>
         <20220708144223.610080-9-vkuznets@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-5.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
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
> Update Enlightened VMCS definition in selftests from KVM.
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  .../selftests/kvm/include/x86_64/evmcs.h      | 45 +++++++++++++++++--
>  1 file changed, 42 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/include/x86_64/evmcs.h b/tools/testing/selftests/kvm/include/x86_64/evmcs.h
> index 3c9260f8e116..a777711d5474 100644
> --- a/tools/testing/selftests/kvm/include/x86_64/evmcs.h
> +++ b/tools/testing/selftests/kvm/include/x86_64/evmcs.h
> @@ -203,14 +203,25 @@ struct hv_enlightened_vmcs {
>  		u32 reserved:30;
>  	} hv_enlightenments_control;
>  	u32 hv_vp_id;
> -
> +	u32 padding32_2;

This is not just an update, this is a fix - I do see that padding field,
in the spec. It is possible that compiler added that padding on its own
to pad everything to 8 bytes though.

>  	u64 hv_vm_id;
>  	u64 partition_assist_page;
>  	u64 padding64_4[4];
>  	u64 guest_bndcfgs;
> -	u64 padding64_5[7];
> +	u64 guest_ia32_perf_global_ctrl;
> +	u64 guest_ia32_s_cet;
> +	u64 guest_ssp;
> +	u64 guest_ia32_int_ssp_table_addr;
> +	u64 guest_ia32_lbr_ctl;
> +	u64 padding64_5[2];
Matches the spec.


>  	u64 xss_exit_bitmap;
> -	u64 padding64_6[7];
> +	u64 host_ia32_perf_global_ctrl;
> +	u64 encls_exiting_bitmap;
This is swapped here as well, expains why it was not caught in the testing.

> +	u64 tsc_multiplier;
> +	u64 host_ia32_s_cet;
> +	u64 host_ssp;
> +	u64 host_ia32_int_ssp_table_addr;
> +	u64 padding64_6;
>  };
>  
>  #define HV_VMX_ENLIGHTENED_CLEAN_FIELD_NONE                     0
> @@ -656,6 +667,18 @@ static inline int evmcs_vmread(uint64_t encoding, uint64_t *value)
>  	case VIRTUAL_PROCESSOR_ID:
>  		*value = current_evmcs->virtual_processor_id;
>  		break;
> +	case HOST_IA32_PERF_GLOBAL_CTRL:
> +		*value = current_evmcs->host_ia32_perf_global_ctrl;
> +		break;
> +	case GUEST_IA32_PERF_GLOBAL_CTRL:
> +		*value = current_evmcs->guest_ia32_perf_global_ctrl;
> +		break;
> +	case ENCLS_EXITING_BITMAP:
> +		*value = current_evmcs->encls_exiting_bitmap;
> +		break;
> +	case TSC_MULTIPLIER:
> +		*value = current_evmcs->tsc_multiplier;
> +		break;
>  	default: return 1;
>  	}
>  
> @@ -1169,6 +1192,22 @@ static inline int evmcs_vmwrite(uint64_t encoding, uint64_t value)
>  		current_evmcs->virtual_processor_id = value;
>  		current_evmcs->hv_clean_fields &= ~HV_VMX_ENLIGHTENED_CLEAN_FIELD_CONTROL_XLAT;
>  		break;
> +	case HOST_IA32_PERF_GLOBAL_CTRL:
> +		current_evmcs->host_ia32_perf_global_ctrl = value;
> +		current_evmcs->hv_clean_fields &= ~HV_VMX_ENLIGHTENED_CLEAN_FIELD_HOST_GRP1;
> +		break;
> +	case GUEST_IA32_PERF_GLOBAL_CTRL:
> +		current_evmcs->guest_ia32_perf_global_ctrl = value;
> +		current_evmcs->hv_clean_fields &= ~HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP1;
> +		break;
> +	case ENCLS_EXITING_BITMAP:
> +		current_evmcs->encls_exiting_bitmap = value;
> +		current_evmcs->hv_clean_fields &= ~HV_VMX_ENLIGHTENED_CLEAN_FIELD_CONTROL_GRP2;
> +		break;
> +	case TSC_MULTIPLIER:
> +		current_evmcs->tsc_multiplier = value;
> +		current_evmcs->hv_clean_fields &= ~HV_VMX_ENLIGHTENED_CLEAN_FIELD_CONTROL_GRP2;
> +		break;
>  	default: return 1;
>  	}
>  

Other than bug in the order of host_ia32_perf_global_ctrl/encls_exiting_bitmap, everything else looks fine to me.

So with this bug fixed:

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky


