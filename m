Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1313618F289
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Mar 2020 11:16:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbgCWKQr (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 23 Mar 2020 06:16:47 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:25502 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727842AbgCWKQr (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 23 Mar 2020 06:16:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584958605;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DHX3G/HAJrIPBm/kQCkLNNm+40k06i4E5QNgUcCEDS4=;
        b=Fs7NJlQCfq/aPTIV+oAQdyc5cxyxgeZMeamo+YbUnTGEUdhoj29zLvNXK53aSXmAcZ3NCn
        GxAxR5bmXDRe8UkuWqih0A8GVorTMkNz1TfmR51Ni1AU//nvoWNbeGPel62LsMCsEGhVaK
        3H0IF8BaHNZhF31MqRpgRFcy+s8DO44=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-201-rCZrNJXNNZC_eiOVnbfQCA-1; Mon, 23 Mar 2020 06:16:43 -0400
X-MC-Unique: rCZrNJXNNZC_eiOVnbfQCA-1
Received: by mail-wr1-f70.google.com with SMTP id i18so7108110wrx.17
        for <linux-hyperv@vger.kernel.org>; Mon, 23 Mar 2020 03:16:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=DHX3G/HAJrIPBm/kQCkLNNm+40k06i4E5QNgUcCEDS4=;
        b=QCfPAAJYVubKlFXYmTf2oy8Fd6IKKRL8zru7KKMKQwoF3MVlBzPC4KJi7jcqWWvW9S
         1Tp3sHbBQ2dvluzjqC2/NOED63nMirly3U2cq6v7PKJfb5yrMoMozVZ5PEKJ7jpwnP1d
         iYjnpcQJsU2XEIfCkwgq1MxhtD2daAjxtFJW5OMi1IbXsfXEvlhIYMj3QZYXUPE0pNdK
         tfxw0W2YS300D8DRvLmuTZ7BjgVuY8zQtmdswS9UaAcS18NGD3NuAlInoITOeKZ6emjg
         BDje5jrjo+uXwF/IH1AieDBTBoBw51AzaiB0hARBsm0YiPnUFf9N4/LSuHXV12K1skGk
         Oi+A==
X-Gm-Message-State: ANhLgQ2lN+h6RejEG3WzP8DMRUIEyJk2mpZxaGQTkQA1su3YLkl3cTpU
        8aeA3V06UYVlrn/4+O0eDPu0gYVqZDn51n7hqdHJywpS4otEwxV+VFQv0a6JrguW3Ufw+d9PyzI
        QcpHOkpwleYORBe7CkArMYl+O
X-Received: by 2002:a1c:4486:: with SMTP id r128mr24718309wma.32.1584958602089;
        Mon, 23 Mar 2020 03:16:42 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuJITYZqrWvgDgsRVuualAmEYTKCOGhQ9kmRfo0Nn5X36UgOsGqcqcIf9m9XhMHrf4L5zgKcg==
X-Received: by 2002:a1c:4486:: with SMTP id r128mr24718208wma.32.1584958600836;
        Mon, 23 Mar 2020 03:16:40 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id k204sm7418938wma.17.2020.03.23.03.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 03:16:40 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Jon Doron <arilou@gmail.com>
Cc:     kvm@vger.kernel.org, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH v9 2/6] x86/kvm/hyper-v: Simplify addition for custom cpuid leafs
In-Reply-To: <20200320172839.1144395-3-arilou@gmail.com>
References: <20200320172839.1144395-1-arilou@gmail.com> <20200320172839.1144395-3-arilou@gmail.com>
Date:   Mon, 23 Mar 2020 11:16:39 +0100
Message-ID: <87wo7b9y0o.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Jon Doron <arilou@gmail.com> writes:

> Simlify the code to define a new cpuid leaf group by enabled feature.
>
> This also fixes a bug in which the max cpuid leaf was always set to
> HYPERV_CPUID_NESTED_FEATURES regardless if nesting is supported or not.
>
> Any new CPUID group needs to consider the max leaf and be added in the
> correct order, in this method there are two rules:
> 1. Each cpuid leaf group must be order in an ascending order
> 2. The appending for the cpuid leafs by features also needs to happen by
>    ascending order.
>
> Signed-off-by: Jon Doron <arilou@gmail.com>
> ---
>  arch/x86/kvm/hyperv.c | 46 ++++++++++++++++++++++++++++++-------------
>  1 file changed, 32 insertions(+), 14 deletions(-)
>
> diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
> index a86fda7a1d03..7383c7e7d4af 100644
> --- a/arch/x86/kvm/hyperv.c
> +++ b/arch/x86/kvm/hyperv.c
> @@ -1785,27 +1785,45 @@ int kvm_vm_ioctl_hv_eventfd(struct kvm *kvm, struct kvm_hyperv_eventfd *args)
>  	return kvm_hv_eventfd_assign(kvm, args->conn_id, args->fd);
>  }
>  
> +// Must be sorted in ascending order by function

scripts/checkpatch.pl should've complained here, kernel coding style
always requires /* */ 

> +static struct kvm_cpuid_entry2 core_cpuid_entries[] = {
> +	{ .function = HYPERV_CPUID_VENDOR_AND_MAX_FUNCTIONS },
> +	{ .function = HYPERV_CPUID_INTERFACE },
> +	{ .function = HYPERV_CPUID_VERSION },
> +	{ .function = HYPERV_CPUID_FEATURES },
> +	{ .function = HYPERV_CPUID_ENLIGHTMENT_INFO },
> +	{ .function = HYPERV_CPUID_IMPLEMENT_LIMITS },
> +};
> +
> +static struct kvm_cpuid_entry2 evmcs_cpuid_entries[] = {
> +	{ .function = HYPERV_CPUID_NESTED_FEATURES },
> +};
> +
> +#define HV_MAX_CPUID_ENTRIES \
> +	ARRAY_SIZE(core_cpuid_entries) +\
> +	ARRAY_SIZE(evmcs_cpuid_entries)
> +
>  int kvm_vcpu_ioctl_get_hv_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid2 *cpuid,
>  				struct kvm_cpuid_entry2 __user *entries)
>  {
>  	uint16_t evmcs_ver = 0;
> -	struct kvm_cpuid_entry2 cpuid_entries[] = {
> -		{ .function = HYPERV_CPUID_VENDOR_AND_MAX_FUNCTIONS },
> -		{ .function = HYPERV_CPUID_INTERFACE },
> -		{ .function = HYPERV_CPUID_VERSION },
> -		{ .function = HYPERV_CPUID_FEATURES },
> -		{ .function = HYPERV_CPUID_ENLIGHTMENT_INFO },
> -		{ .function = HYPERV_CPUID_IMPLEMENT_LIMITS },
> -		{ .function = HYPERV_CPUID_NESTED_FEATURES },
> -	};
> -	int i, nent = ARRAY_SIZE(cpuid_entries);
> +	struct kvm_cpuid_entry2 cpuid_entries[HV_MAX_CPUID_ENTRIES];
> +	int i, nent = 0;
> +
> +	/* Set the core cpuid entries required for Hyper-V */
> +	memcpy(&cpuid_entries[nent], &core_cpuid_entries,
> +	       sizeof(core_cpuid_entries));
> +	nent += ARRAY_SIZE(core_cpuid_entries);

Strictly speaking "+=" is not needed here as nent is zero.

>  
>  	if (kvm_x86_ops->nested_get_evmcs_version)
>  		evmcs_ver = kvm_x86_ops->nested_get_evmcs_version(vcpu);
>  
> -	/* Skip NESTED_FEATURES if eVMCS is not supported */
> -	if (!evmcs_ver)
> -		--nent;
> +	if (evmcs_ver) {
> +		/* EVMCS is enabled, add the required EVMCS CPUID leafs */
> +		memcpy(&cpuid_entries[nent], &evmcs_cpuid_entries,
> +		       sizeof(evmcs_cpuid_entries));
> +		nent += ARRAY_SIZE(evmcs_cpuid_entries);
> +	}
>  
>  	if (cpuid->nent < nent)
>  		return -E2BIG;
> @@ -1821,7 +1839,7 @@ int kvm_vcpu_ioctl_get_hv_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid2 *cpuid,
>  		case HYPERV_CPUID_VENDOR_AND_MAX_FUNCTIONS:
>  			memcpy(signature, "Linux KVM Hv", 12);
>  
> -			ent->eax = HYPERV_CPUID_NESTED_FEATURES;
> +			ent->eax = cpuid_entries[nent - 1].function;
>  			ent->ebx = signature[0];
>  			ent->ecx = signature[1];
>  			ent->edx = signature[2];

With the nitpicks mentioned above:

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

