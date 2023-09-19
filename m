Return-Path: <linux-hyperv+bounces-117-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA297A6094
	for <lists+linux-hyperv@lfdr.de>; Tue, 19 Sep 2023 13:04:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B75AA28056C
	for <lists+linux-hyperv@lfdr.de>; Tue, 19 Sep 2023 11:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0237C3589B;
	Tue, 19 Sep 2023 11:04:54 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F90E2E639
	for <linux-hyperv@vger.kernel.org>; Tue, 19 Sep 2023 11:04:52 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF92112F
	for <linux-hyperv@vger.kernel.org>; Tue, 19 Sep 2023 04:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695121489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wpbrdLK1aN164ZiqLi72UGFResb0onUWuvtwINnIXW4=;
	b=KNTkx4WuAQMIrdcdYO1Flgxg+u/oQF3OK6F1oPnO2Os7O2WDrWfSi76lClNxUiUK24dUVb
	AW0xfazdn9lX1ZtWwYFNyhssVgbp66NsGWmcVWoQObUss9RhKca62rWCJXb3JbFIIo6F7l
	NSlvvU8JUy75+uSGiD5fjyiP/gludQw=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-AmdhFywfN0mMUZ0fkX5JWw-1; Tue, 19 Sep 2023 07:04:48 -0400
X-MC-Unique: AmdhFywfN0mMUZ0fkX5JWw-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-94a355c9028so400537666b.3
        for <linux-hyperv@vger.kernel.org>; Tue, 19 Sep 2023 04:04:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695121487; x=1695726287;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wpbrdLK1aN164ZiqLi72UGFResb0onUWuvtwINnIXW4=;
        b=T+eAW08FwxYezOI4RYh1jgueOnLuUoDcZpXQUC4r5cG0GLgmkuFtpfF0lpvTEv9zHN
         /e9c8kiB4iX+b2WSjdQB73Cn8KamkPAVIF6lVDkh23BZCVubFNtutYG2LBI0Z2yJ6qDw
         DGDqtF3NCMX5NTAfs/AAC67wn8myb9kSSAhQE4IhI3pafv7UyNeatNzpCS1pUKTKPeCM
         lBtAbujh8mVn0HViZMSonEprXD2WcsorZ6L/9iiQdLBSZTk9DglhQblx96wqP1KiYzaZ
         +3fSxTZwcCwBIuJX/IedFHW59zx3OSHsY1KrmWmgbm0UEkCSsRoztYafsZHmWJM9qAFI
         eB+A==
X-Gm-Message-State: AOJu0YyPw/MsIodg4OImfqj8+p6uPXS/XWemn9cKgGtU0RN4RVCXAV1y
	jliNfpE0OrrrLSqUNLFLrviNRYb31b0ZAC7v/CFxkfG3dYf0u7VMfj3M0WmYDD6xX8Ku/Det7m0
	sNu9bfNK643xJq+PrG71i7Vvu
X-Received: by 2002:a17:907:6087:b0:9a5:cf6f:3efc with SMTP id ht7-20020a170907608700b009a5cf6f3efcmr8673801ejc.77.1695121487494;
        Tue, 19 Sep 2023 04:04:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlLQeG7D6Ljt5+qx+wMv+B8dMsdKiuudDL3TU0i0qwDm8uDYU48ExXOxvwwMGAs3WNVXLeFQ==
X-Received: by 2002:a17:907:6087:b0:9a5:cf6f:3efc with SMTP id ht7-20020a170907608700b009a5cf6f3efcmr8673775ejc.77.1695121487204;
        Tue, 19 Sep 2023 04:04:47 -0700 (PDT)
Received: from fedora (g2.ign.cz. [91.219.240.8])
        by smtp.gmail.com with ESMTPSA id ck19-20020a170906c45300b0099297c99314sm7594521ejb.113.2023.09.19.04.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 04:04:46 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Saurabh Sengar <ssengar@linux.microsoft.com>
Cc: ssengar@microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 x86@kernel.org, hpa@zytor.com, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, mikelley@microsoft.com
Subject: Re: [PATCH v2] x86/hyperv: Restrict get_vtl to only VTL platforms
In-Reply-To: <1695101408-22432-1-git-send-email-ssengar@linux.microsoft.com>
References: <1695101408-22432-1-git-send-email-ssengar@linux.microsoft.com>
Date: Tue, 19 Sep 2023 13:04:45 +0200
Message-ID: <87jzsme84y.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Saurabh Sengar <ssengar@linux.microsoft.com> writes:

> For non VTL platforms vtl is always 0, and there is no need of
> get_vtl function. For VTL platforms get_vtl should always succeed
> and should return the correct VTL.

Nitpicking, an alternative summary:

"""
When Linux runs in a non-default VTL (CONFIG_HYPERV_VTL_MODE=y),
get_vtl() must never fail as the result it returns is used in
negotiations with the host. In the more generic case,
(CONFIG_HYPERV_VTL_MODE=n) the VTL is always zero so there's no need to
do the hypercall.

Make get_vtl() BUG() in case of failure and put the implementation under
"if IS_ENABLED(CONFIG_HYPERV_VTL_MODE)" to avoid the call altogether in
the most generic use case.
"""

>
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

> ---
> [V2]
>  - Put the if else at function definition rather then at the caller
>
>  arch/x86/hyperv/hv_init.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index 783ed339f341..f0128fd4031d 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -394,6 +394,7 @@ static void __init hv_get_partition_id(void)
>  	local_irq_restore(flags);
>  }
>  
> +#if IS_ENABLED(CONFIG_HYPERV_VTL_MODE)
>  static u8 __init get_vtl(void)
>  {
>  	u64 control = HV_HYPERCALL_REP_COMP_1 | HVCALL_GET_VP_REGISTERS;
> @@ -416,13 +417,16 @@ static u8 __init get_vtl(void)
>  	if (hv_result_success(ret)) {
>  		ret = output->as64.low & HV_X64_VTL_MASK;
>  	} else {
> -		pr_err("Failed to get VTL(%lld) and set VTL to zero by default.\n", ret);
> -		ret = 0;
> +		pr_err("Failed to get VTL(error: %lld) exiting...\n", ret);
> +		BUG();
>  	}
>  
>  	local_irq_restore(flags);
>  	return ret;
>  }
> +#else
> +static inline u8 get_vtl(void) { return 0; }
> +#endif
>  
>  /*
>   * This function is to be invoked early in the boot sequence after the
> @@ -604,8 +608,7 @@ void __init hyperv_init(void)
>  	hv_query_ext_cap(0);
>  
>  	/* Find the VTL */
> -	if (!ms_hyperv.paravisor_present && hv_isolation_type_snp())
> -		ms_hyperv.vtl = get_vtl();
> +	ms_hyperv.vtl = get_vtl();
>  
>  	return;

-- 
Vitaly


