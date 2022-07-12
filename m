Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E65F15718E7
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 Jul 2022 13:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232382AbiGLLvT (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 12 Jul 2022 07:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbiGLLvS (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 12 Jul 2022 07:51:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2B241B31C8
        for <linux-hyperv@vger.kernel.org>; Tue, 12 Jul 2022 04:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657626677;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Pu5HpFtltIVsBRjVtOQ6HAzFmE6im22Ds+SLjPOebFg=;
        b=XSf1yNwsrf/5IgRERspe0CPQ7SJq2HmPoM+IjVSaHcrrj/Yr1CHSLggCK3UpRvHTMNnO8Q
        5Ga/EqlWK6zICBNZ/3Em+7PxZU4mateV5Wq++vV5tcVeFUESd/Kbq05Ht2gnaXrFECCvoK
        tCAa3cO1Ko6rywxXzWKMRFDVeo1Efb0=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-465-lfybQufIPKeMXNJqHm3XPg-1; Tue, 12 Jul 2022 07:51:14 -0400
X-MC-Unique: lfybQufIPKeMXNJqHm3XPg-1
Received: by mail-qk1-f197.google.com with SMTP id x22-20020a05620a259600b006b552a69231so7573009qko.18
        for <linux-hyperv@vger.kernel.org>; Tue, 12 Jul 2022 04:51:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=Pu5HpFtltIVsBRjVtOQ6HAzFmE6im22Ds+SLjPOebFg=;
        b=gSasQlJseuExKTWH7LcRK10JmzPQpc+HV2T7jcMxgrbeDU4CA43wLe2RVkYfs9GRDw
         sts0Wd0gExS5OYCyAlt+SON7a9Dv+AcG5em8vZat9WzjwmkFi6EaYOIF6OlHrdfhNCOn
         SksjGtcmA1sA2wyHwn5QOcAJIVT3ZR03o+CVxu0BlVihpghN4m/rkTd/NZOwnr4N0txF
         ZbQY9fEBBVRWmME5MEtixKIHlYEj+ljb1v7aJ/TfAQiZo0K0+uKSxpfZDnqyAjGTQwNL
         sjnYTYm2jKNpm9wFE0cshcRqucxKhj3BUUePNWCYrKjBBpzdAS9FCMrd3Hx50oc25l4e
         G5BQ==
X-Gm-Message-State: AJIora/BjU2ALIHYkbvBes3RANtFQdrT68EowgNbKt53/6DdUxF26Pb8
        jbDyT2zJ47laxnwUGfoTM5lxJN8FufuCzb1GqQON4NjtDa1M/pUCBUvaxORttC3y6tsFOrx1Rm+
        K7Cg82INNvWJ2dkf3TPeiXHcr
X-Received: by 2002:a0c:eb4a:0:b0:472:f936:3ea0 with SMTP id c10-20020a0ceb4a000000b00472f9363ea0mr17624097qvq.43.1657626673823;
        Tue, 12 Jul 2022 04:51:13 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sAmCrQDiM3HG8ckaM1gZI3DAX4ar7jMdogSWlMsC7V8zRIrmKQ62wg7e71rBtKTus/ToKSKQ==
X-Received: by 2002:a0c:eb4a:0:b0:472:f936:3ea0 with SMTP id c10-20020a0ceb4a000000b00472f9363ea0mr17624080qvq.43.1657626673615;
        Tue, 12 Jul 2022 04:51:13 -0700 (PDT)
Received: from [10.35.4.238] (bzq-82-81-161-50.red.bezeqint.net. [82.81.161.50])
        by smtp.gmail.com with ESMTPSA id n7-20020ae9c307000000b006a34a22bc60sm8389923qkg.9.2022.07.12.04.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 04:51:13 -0700 (PDT)
Message-ID: <6cf5812083ebfa18ba52563527298cb8b91f7fab.camel@redhat.com>
Subject: Re: [PATCH v3 03/25] x86/hyperv: Update 'struct
 hv_enlightened_vmcs' definition
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 12 Jul 2022 14:51:09 +0300
In-Reply-To: <20220708144223.610080-4-vkuznets@redhat.com>
References: <20220708144223.610080-1-vkuznets@redhat.com>
         <20220708144223.610080-4-vkuznets@redhat.com>
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
> Updated Hyper-V Enlightened VMCS specification lists several new
> fields for the following features:
> 
> - PerfGlobalCtrl
> - EnclsExitingBitmap
> - Tsc Scaling
> - GuestLbrCtl
> - CET
> - SSP
> 
> Update the definition. The updated definition is available only when
> CPUID.0x4000000A.EBX BIT(0) is '1'. Add a define for it as well.
> 
> Note: The latest TLFS is available at
> https://docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/tlfs/tlfs
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  arch/x86/include/asm/hyperv-tlfs.h | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
> index 6f0acc45e67a..6f2c3cdacdf4 100644
> --- a/arch/x86/include/asm/hyperv-tlfs.h
> +++ b/arch/x86/include/asm/hyperv-tlfs.h
> @@ -138,6 +138,9 @@
>  #define HV_X64_NESTED_GUEST_MAPPING_FLUSH		BIT(18)
>  #define HV_X64_NESTED_MSR_BITMAP			BIT(19)
>  

Maybe add a comment that this is undocumented + what that cpuid bit does?

> +/* Nested quirks. These are HYPERV_CPUID_NESTED_FEATURES.EBX bits. */
> +#define HV_X64_NESTED_EVMCS1_2022_UPDATE		BIT(0)
> +
>  /*
>   * This is specific to AMD and specifies that enlightened TLB flush is
>   * supported. If guest opts in to this feature, ASID invalidations only
> @@ -559,9 +562,20 @@ struct hv_enlightened_vmcs {
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

This change looks OK

>  	u64 xss_exit_bitmap;
> -	u64 padding64_6[7];
> +	u64 host_ia32_perf_global_ctrl;
> +	u64 encls_exiting_bitmap;
> +	u64 tsc_multiplier;
> +	u64 host_ia32_s_cet;
> +	u64 host_ssp;
> +	u64 host_ia32_int_ssp_table_addr;
> +	u64 padding64_6;

I think we have a mistake here:

UINT64 XssExitingBitmap;
UINT64 EnclsExitingBitmap;
UINT64 HostPerfGlobalCtrl;
UINT64 TscMultiplier;
UINT64 HostSCet;
UINT64 HostSsp;
UINT64 HostInterruptSspTableAddr;
UINT64 Rsvd8;


I think you need to swap encls_exiting_bitmap and host_ia32_perf_global_ctrl

I used https://docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/tlfs/datatypes/hv_vmx_enlightened_vmcs
as the reference. 


Best regards,
	Maxim Levitsky


>  } __packed;
>  
>  #define HV_VMX_ENLIGHTENED_CLEAN_FIELD_NONE			0


