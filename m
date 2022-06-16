Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1EF754E596
	for <lists+linux-hyperv@lfdr.de>; Thu, 16 Jun 2022 17:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377807AbiFPPDX (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 16 Jun 2022 11:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377805AbiFPPDW (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 16 Jun 2022 11:03:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9A5CDB20
        for <linux-hyperv@vger.kernel.org>; Thu, 16 Jun 2022 08:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655391800;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sU1/eCcg6yRW4nibZ27Ei/SlX0WtSksIdirbQsLBVsA=;
        b=NW6yalav6SgJAP8AP4mxya1Ce24mjmj53pZf6z8oARptSAJrs8Nkvp2kWB5lugPdXR0zuJ
        Xl3YjgqipTHes2qc/lAQWP3UKeiKhBq0Y8lfUreHDTJB0zij7ZrrsX71zWiNLiLvPYLVQt
        l5fj9W+0XkwvKFCSt7newsCl2r2ySOg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-392-F6eL_T6AORCiu14PGKKqTA-1; Thu, 16 Jun 2022 11:03:19 -0400
X-MC-Unique: F6eL_T6AORCiu14PGKKqTA-1
Received: by mail-wm1-f69.google.com with SMTP id o3-20020a05600c510300b0039743540ac7so755802wms.5
        for <linux-hyperv@vger.kernel.org>; Thu, 16 Jun 2022 08:03:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=sU1/eCcg6yRW4nibZ27Ei/SlX0WtSksIdirbQsLBVsA=;
        b=5s3Th6YpgqIb+n6gRFQGoZHMDLNVhL5DA0PwZ49H47AtmTiEe+Q+kS98yNcWL9vUYF
         38yuEsLJtW9+mRI5uj+0Vok1VCUJa2esSR9gllbOtP+X9hn4Im4w/Aq4foc6aZI+cqBA
         BnityF0PS4SYdF5LbXJv1Ar0NaVnJ/01U8feVSIgkI5H/OnlPueHvxELqf/VDHrJfy/0
         ZogDKvXRNF9lOEttC0Tfy9lD4ssWyxr78xoBHY1njObqUIfJLED3ovRS2Cu/K1b/lzmO
         uuU1PF7TyrB7jPYZyu/rlRjXymXxlj4I4g/suXc7RXWhF/Na9LXYmssggfvQZaAMGga6
         fNYA==
X-Gm-Message-State: AJIora9z+xT4h0Z3pqy+TEFXjgudLNhs/pDNB57d2D1tYNeaJXN/WuK7
        4VgQaxdqU0MPKiqMoYEC63kzkSaEboofSpI1hs050T7WLB9twZ2WfSMMC6IbS0D0gHv0DuWk3Jf
        8x+IKgDW8It0hU94aAF2K0kyN
X-Received: by 2002:a05:600c:1991:b0:39c:88ba:2869 with SMTP id t17-20020a05600c199100b0039c88ba2869mr5389430wmq.14.1655391797740;
        Thu, 16 Jun 2022 08:03:17 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1un6/x5EK3gX2NjOv2Ng9CzA86bVIABMgzjcFEcizAaklAzsMgY7pQ1TOk+gIpJce1/3+sDgw==
X-Received: by 2002:a05:600c:1991:b0:39c:88ba:2869 with SMTP id t17-20020a05600c199100b0039c88ba2869mr5389407wmq.14.1655391797463;
        Thu, 16 Jun 2022 08:03:17 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id 64-20020a1c1943000000b0039c6390730bsm6107323wmz.29.2022.06.16.08.03.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 08:03:16 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Vit Kabele <vit.kabele@sysgo.com>, linux-hyperv@vger.kernel.org
Cc:     mikelley@microsoft.com, linux-kernel@vger.kernel.org,
        kys@microsoft.com
Subject: Re: [RFC PATCH] Hyper-V: Initialize crash reporting before vmbus
In-Reply-To: <YqtAyitIGRAHL7V0@czspare1-lap.sysgo.cz>
References: <YqtAyitIGRAHL7V0@czspare1-lap.sysgo.cz>
Date:   Thu, 16 Jun 2022 17:03:16 +0200
Message-ID: <874k0kirbf.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Vit Kabele <vit.kabele@sysgo.com> writes:

> The Hyper-V crash reporting feature is initialized after a successful
> vmbus setup. The reporting feature however does not require vmbus at all
> and Windows guests can indeed use the reporting capabilities even with
> the minimal Hyper-V implementation (as described in the Minimal
> Requirements document).
>
> Reorder the initialization callbacks so that the crash reporting
> callbacks are registered before the vmbus initialization starts.
>
> Nevertheless, I am not sure about following:
>
> 1/ The vmbus_initiate_unload function is called within the panic handler
> even when the vmbus initialization does not finish (there might be no
> vmbus at all). This should probably not be problem because the vmbus
> unload function always checks for current connection state and does
> nothing when this is "DISCONNECTED". For better readability, it might be
> better to add separate panic notifier for vmbus and crash reporting.
>
> 2/ Wouldn't it be better to extract the whole reporting capability out
> of the vmbus module, so that it stays present in the kernel even when
> the vmbus module is possibly unloaded?

IMHO yes but as you mention hyperv_panic_event() currently does to
things:
1) Initiates VMBus unload
2) Reports panic to the hypervisor

I think untangling them moving the later to arch/x86/hyper-v (and
arch/arm64/hyperv/) makes sense.

>
> Signed-off-by: Vit Kabele <vit.kabele@sysgo.com>
>
> ---
>  drivers/hv/vmbus_drv.c | 77 +++++++++++++++++++++++-------------------
>  1 file changed, 42 insertions(+), 35 deletions(-)
>
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 714d549b7b46..97873f03aa7a 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -1509,41 +1509,6 @@ static int vmbus_bus_init(void)
>  	if (hv_is_isolation_supported())
>  		sysctl_record_panic_msg = 0;
>  
> -	/*
> -	 * Only register if the crash MSRs are available
> -	 */
> -	if (ms_hyperv.misc_features & HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE) {
> -		u64 hyperv_crash_ctl;
> -		/*
> -		 * Panic message recording (sysctl_record_panic_msg)
> -		 * is enabled by default in non-isolated guests and
> -		 * disabled by default in isolated guests; the panic
> -		 * message recording won't be available in isolated
> -		 * guests should the following registration fail.
> -		 */
> -		hv_ctl_table_hdr = register_sysctl_table(hv_root_table);
> -		if (!hv_ctl_table_hdr)
> -			pr_err("Hyper-V: sysctl table register error");
> -
> -		/*
> -		 * Register for panic kmsg callback only if the right
> -		 * capability is supported by the hypervisor.
> -		 */
> -		hyperv_crash_ctl = hv_get_register(HV_REGISTER_CRASH_CTL);
> -		if (hyperv_crash_ctl & HV_CRASH_CTL_CRASH_NOTIFY_MSG)
> -			hv_kmsg_dump_register();
> -
> -		register_die_notifier(&hyperv_die_block);
> -	}
> -
> -	/*
> -	 * Always register the panic notifier because we need to unload
> -	 * the VMbus channel connection to prevent any VMbus
> -	 * activity after the VM panics.
> -	 */
> -	atomic_notifier_chain_register(&panic_notifier_list,
> -			       &hyperv_panic_block);
> -
>  	vmbus_request_offers();
>  
>  	return 0;
> @@ -2675,6 +2640,46 @@ static struct syscore_ops hv_synic_syscore_ops = {
>  	.resume = hv_synic_resume,
>  };
>  
> +static void __init crash_reporting_init(void)
> +{
> +	/*
> +	 * Only register if the crash MSRs are available
> +	 */
> +	if (ms_hyperv.misc_features & HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE) {
> +		u64 hyperv_crash_ctl;
> +		/*
> +		 * Panic message recording (sysctl_record_panic_msg)
> +		 * is enabled by default in non-isolated guests and
> +		 * disabled by default in isolated guests; the panic
> +		 * message recording won't be available in isolated
> +		 * guests should the following registration fail.
> +		 */
> +		hv_ctl_table_hdr = register_sysctl_table(hv_root_table);
> +		if (!hv_ctl_table_hdr)
> +			pr_err("Hyper-V: sysctl table register error");
> +
> +		/*
> +		 * Register for panic kmsg callback only if the right
> +		 * capability is supported by the hypervisor.
> +		 */
> +		hyperv_crash_ctl = hv_get_register(HV_REGISTER_CRASH_CTL);
> +		if (hyperv_crash_ctl & HV_CRASH_CTL_CRASH_NOTIFY_MSG)
> +			hv_kmsg_dump_register();
> +
> +		register_die_notifier(&hyperv_die_block);
> +	}
> +
> +	/*
> +	 * Always register the panic notifier because we need to unload
> +	 * the VMbus channel connection to prevent any VMbus
> +	 * activity after the VM panics.
> +	 */
> +	atomic_notifier_chain_register(&panic_notifier_list,
> +			       &hyperv_panic_block);
> +
> +
> +}
> +
>  static int __init hv_acpi_init(void)
>  {
>  	int ret, t;
> @@ -2687,6 +2692,8 @@ static int __init hv_acpi_init(void)
>  
>  	init_completion(&probe_event);
>  
> +	crash_reporting_init();
> +
>  	/*
>  	 * Get ACPI resources first.
>  	 */

-- 
Vitaly

