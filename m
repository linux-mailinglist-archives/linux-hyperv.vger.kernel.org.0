Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF5B85718E4
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 Jul 2022 13:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232330AbiGLLvB (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 12 Jul 2022 07:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbiGLLvA (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 12 Jul 2022 07:51:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3542332D99
        for <linux-hyperv@vger.kernel.org>; Tue, 12 Jul 2022 04:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657626659;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uhQ1e32cAsQhl7wXXe/WWIG20tXbjxkVpQUAq7qDxOA=;
        b=e6gkFO3haJJaErLYrfz8P81EztknmcQyUVMgT/J9s3IQLTHeyRbiFIxtBbe/2+HMyqSXJv
        Rm+DDuG0QNz00Fwl8sTvUW+cv1vNJEkU5F6IGB+EO3QOeTFFD0qXR/DvMOYgf4QTsSgCRZ
        BMiX9Lm+7VpY1Wpgia+5e8/2e/Ew53g=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-210-IdbcfXRCMQaioHJFzQ84-Q-1; Tue, 12 Jul 2022 07:50:56 -0400
X-MC-Unique: IdbcfXRCMQaioHJFzQ84-Q-1
Received: by mail-qt1-f198.google.com with SMTP id o22-20020ac87c56000000b0031d4ab81b21so6697581qtv.1
        for <linux-hyperv@vger.kernel.org>; Tue, 12 Jul 2022 04:50:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=uhQ1e32cAsQhl7wXXe/WWIG20tXbjxkVpQUAq7qDxOA=;
        b=4PqqIzTsh4MEJVp+9fDvta9prpa+03LkcJ7JI2cl+jPDYMAQ3gSs4dJXJiYyvw5Aoo
         v5xesYppbQGjhMVzdjgjhfA8i0hLHZg7pwWV511CUjoWyt/35cDrSkpaHLm7uldYEFz/
         A9foJXxiwGvGS7qMP/Cu/IgD0SQp43kfYmd0tHAc/Co9VMmDqb+hSwN9trMCkCrY2E1v
         nDd3H2fK4heTU0mBkqjLuifsnwo3YfK+Zrl8PLIOlVcXk9BvtwpVq4+Lj7xEiY/+rodV
         Td6dz7b4/B/LygF8KQQsZP8znlZU2DyFCiPy+VIHh0SVRNXtwq+ant5oHjxU6yL9yy4c
         TCvw==
X-Gm-Message-State: AJIora8DFBcW/WDFjB6VmGzV7dvA5TDCX47Q6OC0+5X6aFvKL3yHelpA
        qfnSNmB91N7IwYK4U8E4MErviISVl4rRExLNAesRve56+NL8cDngzcwlEyws99n5xkyt+OG3itS
        46LtiHoHz0eDU+Xw4wzVpRKOP
X-Received: by 2002:a05:620a:40c2:b0:6af:d667:532a with SMTP id g2-20020a05620a40c200b006afd667532amr14752331qko.616.1657626655802;
        Tue, 12 Jul 2022 04:50:55 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1v2qGVQTARKu0OjXoQGwV0zbnGFEiKyJpZiqtkaR4OpRY56uw0+iih/cRGTBYSWBzdYmsApRg==
X-Received: by 2002:a05:620a:40c2:b0:6af:d667:532a with SMTP id g2-20020a05620a40c200b006afd667532amr14752322qko.616.1657626655602;
        Tue, 12 Jul 2022 04:50:55 -0700 (PDT)
Received: from [10.35.4.238] (bzq-82-81-161-50.red.bezeqint.net. [82.81.161.50])
        by smtp.gmail.com with ESMTPSA id bq37-20020a05620a46a500b006a36b0d7f27sm9080067qkb.76.2022.07.12.04.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 04:50:55 -0700 (PDT)
Message-ID: <488553b9a51b5c0f7f20dae5857278f38da01226.camel@redhat.com>
Subject: Re: [PATCH v3 04/25] KVM: VMX: Define VMCS-to-EVMCS conversion for
 the new fields
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 12 Jul 2022 14:50:51 +0300
In-Reply-To: <20220708144223.610080-5-vkuznets@redhat.com>
References: <20220708144223.610080-1-vkuznets@redhat.com>
         <20220708144223.610080-5-vkuznets@redhat.com>
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
> Enlightened VMCS v1 definition was updated with new fields, support
> them in KVM by defining VMCS-to-EVMCS conversion.
> 
> Note: SSP, CET and Guest LBR features are not supported by KVM yet and
> the corresponding fields are not defined in 'enum vmcs_field', leave
> them commented out for now.
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  arch/x86/kvm/vmx/evmcs.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/arch/x86/kvm/vmx/evmcs.c b/arch/x86/kvm/vmx/evmcs.c
> index 6a61b1ae7942..8bea5dea0341 100644
> --- a/arch/x86/kvm/vmx/evmcs.c
> +++ b/arch/x86/kvm/vmx/evmcs.c
> @@ -28,6 +28,8 @@ const struct evmcs_field vmcs_field_to_evmcs_1[] = {
>  		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_HOST_GRP1),
>  	EVMCS1_FIELD(HOST_IA32_EFER, host_ia32_efer,
>  		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_HOST_GRP1),
> +	EVMCS1_FIELD(HOST_IA32_PERF_GLOBAL_CTRL, host_ia32_perf_global_ctrl,
> +		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_HOST_GRP1),
>  	EVMCS1_FIELD(HOST_CR0, host_cr0,
>  		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_HOST_GRP1),
>  	EVMCS1_FIELD(HOST_CR3, host_cr3,
> @@ -78,6 +80,8 @@ const struct evmcs_field vmcs_field_to_evmcs_1[] = {
>  		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP1),
>  	EVMCS1_FIELD(GUEST_IA32_EFER, guest_ia32_efer,
>  		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP1),
> +	EVMCS1_FIELD(GUEST_IA32_PERF_GLOBAL_CTRL, guest_ia32_perf_global_ctrl,
> +		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP1),
>  	EVMCS1_FIELD(GUEST_PDPTR0, guest_pdptr0,
>  		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP1),
>  	EVMCS1_FIELD(GUEST_PDPTR1, guest_pdptr1,
> @@ -126,6 +130,28 @@ const struct evmcs_field vmcs_field_to_evmcs_1[] = {
>  		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP1),
>  	EVMCS1_FIELD(XSS_EXIT_BITMAP, xss_exit_bitmap,
>  		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_CONTROL_GRP2),
> +	EVMCS1_FIELD(ENCLS_EXITING_BITMAP, encls_exiting_bitmap,
> +		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_CONTROL_GRP2),
> +	EVMCS1_FIELD(TSC_MULTIPLIER, tsc_multiplier,
> +		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_CONTROL_GRP2),
> +	/*
> +	 * Not used by KVM:
> +	 *
> +	 * EVMCS1_FIELD(0x00006828, guest_ia32_s_cet,
> +	 *	     HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP1),
> +	 * EVMCS1_FIELD(0x0000682A, guest_ssp,
> +	 *	     HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_BASIC),

> +	 * EVMCS1_FIELD(0x0000682C, guest_ia32_int_ssp_table_addr,
> +	 *	     HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP1),


> +	 * EVMCS1_FIELD(0x00002816, guest_ia32_lbr_ctl,
> +	 *	     HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP1),

> +	 * EVMCS1_FIELD(0x00006C18, host_ia32_s_cet,
> +	 *	     HV_VMX_ENLIGHTENED_CLEAN_FIELD_HOST_GRP1),

> +	 * EVMCS1_FIELD(0x00006C1A, host_ssp,
> +	 *	     HV_VMX_ENLIGHTENED_CLEAN_FIELD_HOST_GRP1),
> +	 * EVMCS1_FIELD(0x00006C1C, host_ia32_int_ssp_table_addr,
> +	 *	     HV_VMX_ENLIGHTENED_CLEAN_FIELD_HOST_GRP1),
> +	 */

>  
>  	/* 64 bit read only */
>  	EVMCS1_FIELD(GUEST_PHYSICAL_ADDRESS, guest_physical_address,


I checked the Intel's SDM for encodings of the unused fields,
and checked the [1] for the clean bits.
All look good but as usual I could have missed something.

[1] https://docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/tlfs/datatypes/hv_vmx_enlightened_vmcs

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky

