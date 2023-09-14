Return-Path: <linux-hyperv+bounces-76-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A845A7A0871
	for <lists+linux-hyperv@lfdr.de>; Thu, 14 Sep 2023 17:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 621DA281E3E
	for <lists+linux-hyperv@lfdr.de>; Thu, 14 Sep 2023 15:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE951CFB0;
	Thu, 14 Sep 2023 14:49:14 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FB628E11
	for <linux-hyperv@vger.kernel.org>; Thu, 14 Sep 2023 14:49:14 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id C436B1FC9
	for <linux-hyperv@vger.kernel.org>; Thu, 14 Sep 2023 07:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694702952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JJNWd5PCe2BYCxEP8rDUQkK/YgAeIPdVdWnp3Lyzy3o=;
	b=K1oM7fY99l9Xx2kzfLM6hcnwPk8R6pnqZmQvd4E18GQduyznP+ejlmPqAwGhGOjVFWDMZI
	A6/yHGmzp2I8SxHxyXHni5kn79U0hviwrHvEnlk2do00vWk677XVPEJn6BbZztFMAmoBZS
	s5u1yyXdDCzw3VNrN1iwsiT/2W+bQTw=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-UkuMCJbMPleDbopM7PpfUg-1; Thu, 14 Sep 2023 10:49:11 -0400
X-MC-Unique: UkuMCJbMPleDbopM7PpfUg-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-50daa85e940so729055a12.0
        for <linux-hyperv@vger.kernel.org>; Thu, 14 Sep 2023 07:49:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694702950; x=1695307750;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JJNWd5PCe2BYCxEP8rDUQkK/YgAeIPdVdWnp3Lyzy3o=;
        b=sd9rVCX6+0KhMQM0KL74kzTQ0Mrb3B2Odbqq7CYyIRAsREVsBYO3TxX2GdwC2T5nxc
         kZFlwZ4ZUAo4XzCAp0RP4DRuP+9Bd2olXei3BVyzKwZP3OHSx8yuTEwKf0Wwwn8VjdiR
         pJusG88rblz3dvGn3E2/Sb49byQ02o5zvKLcLWOx1xETe19xAnkRczSR7kSVP2/k5qV6
         rq4PffuVajVaRQLFfYokskcUZYSeB5Eh4u8sJS/iQj8ZNASPWFo6mcuvk33S6SxTSUgS
         ZBv1kRMfmbC8JUSOZ+4wVwHowdsDc31iJl96xN2u2kIzn43MlKM4l3N4hRBPiikFQujS
         7O8A==
X-Gm-Message-State: AOJu0Yx/ZVWsPBoppwXfuGqm2Q00vY9jvQMI9U5ZGukMHQv8yWPYz5vP
	Glzkki/ojgCWBjzdfkm65ygJRF1fz1nnL2ivdZ4tm2kMsyhBTKssA7+8/7ffDbTD8+RIBo7+4JX
	+2p8r0sZ0XPzKgQlgXOKPQsCK
X-Received: by 2002:a17:906:55:b0:9a1:fbfb:4d11 with SMTP id 21-20020a170906005500b009a1fbfb4d11mr5271988ejg.73.1694702950363;
        Thu, 14 Sep 2023 07:49:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFuUh+o4qBa2QpPTqZcV/CAgpJXUP4q4YCRFbbhogb7vavGnViV5ntjLQB4fVRFpDMI4D+1TQ==
X-Received: by 2002:a17:906:55:b0:9a1:fbfb:4d11 with SMTP id 21-20020a170906005500b009a1fbfb4d11mr5271965ejg.73.1694702950001;
        Thu, 14 Sep 2023 07:49:10 -0700 (PDT)
Received: from fedora (g2.ign.cz. [91.219.240.8])
        by smtp.gmail.com with ESMTPSA id rn5-20020a170906d92500b009a1e0349c4csm1119680ejb.23.2023.09.14.07.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 07:49:09 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Saurabh Sengar <ssengar@linux.microsoft.com>
Cc: ssengar@microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 x86@kernel.org, hpa@zytor.com, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, mikelley@microsoft.com
Subject: Re: [PATCH] x86/hyperv: Restrict get_vtl to only VTL platforms
In-Reply-To: <1694604531-17128-1-git-send-email-ssengar@linux.microsoft.com>
References: <1694604531-17128-1-git-send-email-ssengar@linux.microsoft.com>
Date: Thu, 14 Sep 2023 16:49:08 +0200
Message-ID: <874jjwq07v.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Saurabh Sengar <ssengar@linux.microsoft.com> writes:

> For non VTL platforms vtl is always 0, and there is no need of
> get_vtl function. For VTL platforms get_vtl should always succeed
> and should return the correct VTL.
>
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> ---
>  arch/x86/hyperv/hv_init.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index 783ed339f341..e589c240565a 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -416,8 +416,8 @@ static u8 __init get_vtl(void)
>  	if (hv_result_success(ret)) {
>  		ret = output->as64.low & HV_X64_VTL_MASK;
>  	} else {
> -		pr_err("Failed to get VTL(%lld) and set VTL to zero by default.\n", ret);
> -		ret = 0;
> +		pr_err("Failed to get VTL(error: %lld) exiting...\n", ret);

Nitpick: arch/x86/hyperv/hv_init.c lacks pr_fmt so the message won't get
prefixed with "Hyper-V". I'm not sure 'VTL' abbreviation has the only,
Hyper-V specific meaning. I'd suggest we add 

#define pr_fmt(fmt)  "Hyper-V: " fmt

to the beginning of the file.

> +		BUG();
>  	}
>  
>  	local_irq_restore(flags);
> @@ -604,8 +604,10 @@ void __init hyperv_init(void)
>  	hv_query_ext_cap(0);
>  
>  	/* Find the VTL */
> -	if (!ms_hyperv.paravisor_present && hv_isolation_type_snp())
> +	if (IS_ENABLED(CONFIG_HYPERV_VTL_MODE))
>  		ms_hyperv.vtl = get_vtl();
> +	else
> +		ms_hyperv.vtl = 0;

Is 'else' branch really needed? 'ms_hyperv' seems to be a statically
allocated global. But instead of doing this, what about putting the
whole get_vtl() funtion under '#if (IS_ENABLED(CONFIG_HYPERV_VTL_MODE))', i.e.:

#if IS_ENABLED(CONFIG_HYPERV_VTL_MODE)
static u8 __init get_vtl(void)
{
        u64 control = HV_HYPERCALL_REP_COMP_1 | HVCALL_GET_VP_REGISTERS;
...
}
#else
static inline get_vtl(void) { return 0; }
#endif

and then we can always do

      ms_hyperv.vtl = get_vtl();

unconditionally?

>  
>  	return;

-- 
Vitaly


