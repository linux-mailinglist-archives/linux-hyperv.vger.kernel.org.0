Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 127ED189CAC
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Mar 2020 14:13:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbgCRNNs (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 18 Mar 2020 09:13:48 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:28175 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726840AbgCRNNr (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 18 Mar 2020 09:13:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584537227;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zxwIBa7TPXSx20q9s/ZV/cOPZzER5Oa7xunuPQ/atX8=;
        b=i3ifr7j4uS7NdKoEofp+spTaVgMEiJBVe3SV268EPTh4JXaCtwtURTqD+qpmFNvLjWR2KP
        t08QHY0ivi3ZWSk9nqwTsFeOaLH7dOsIEcxKIwZZN9SjtioPTAOxpHxL7KLI1iKBRZjGLg
        U3uor2UHq/wqg9HG/cFYtT9QHNI1yCg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-280-FikBnCIfMfyy3EiNY5unLA-1; Wed, 18 Mar 2020 09:13:46 -0400
X-MC-Unique: FikBnCIfMfyy3EiNY5unLA-1
Received: by mail-wm1-f71.google.com with SMTP id n188so1081706wmf.0
        for <linux-hyperv@vger.kernel.org>; Wed, 18 Mar 2020 06:13:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=zxwIBa7TPXSx20q9s/ZV/cOPZzER5Oa7xunuPQ/atX8=;
        b=pusX1rT4tj9mnIyIJFsu2eI2e5pigo95Gx8d15GWQ2I3xb8GaRQuGwO3edxjG/0Caz
         ZXzYc6iy/2aOLuNenKjM6ezQqOBxTR3Isko9Q49GnCoHXZkpF8miqKlE+Hu2o4qtmHkW
         5b1EYxqHZ4sQVjEry6Yy16te+s5KFDw2/TvNykh/g1rReU7tVCRkS8WCvhWk96N1L3c4
         ylTpM5ANXn3jDFmSYMdvwSIPsT1HLba1i0yMZCNACcf4V3GCdmxftnH/M6zQm0U/knbB
         AL4Z3uicZ0k90VfhIyGOLd3mnCSVg2xqU+k823WwkmDo5g1r6NhkFTSMeQG5FTEp/qkj
         1OCQ==
X-Gm-Message-State: ANhLgQ0aOh1wQzcgsVV3gyhMq2l8rf1hjwaQ83KwItsr1FgB0WkiqY/7
        vHucqvXEPYcekzI/vNwKUXG/0qIcrW3SMbGmGQBDYfXfnFwCeohI1zZTvsk+aO0jQrCIcxslbqZ
        kq3f28V5Vf8oP0Z9hIugq1vdz
X-Received: by 2002:a5d:4a10:: with SMTP id m16mr5350409wrq.333.1584537224545;
        Wed, 18 Mar 2020 06:13:44 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtV4d8keinFKoLoZiZA3YcLpB7G3TetcOUm/5R041Z/gXFbIgl+hl68YutsL+eKaYHCf2h4bQ==
X-Received: by 2002:a5d:4a10:: with SMTP id m16mr5350388wrq.333.1584537224288;
        Wed, 18 Mar 2020 06:13:44 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id l5sm9231446wro.15.2020.03.18.06.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 06:13:43 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Jon Doron <arilou@gmail.com>
Cc:     kvm@vger.kernel.org, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH v6 5/5] x86/kvm/hyper-v: Add support for synthetic debugger via hypercalls
In-Reply-To: <20200317034804.112538-6-arilou@gmail.com>
References: <20200317034804.112538-1-arilou@gmail.com> <20200317034804.112538-6-arilou@gmail.com>
Date:   Wed, 18 Mar 2020 14:13:42 +0100
Message-ID: <87imj13iwp.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Jon Doron <arilou@gmail.com> writes:

> There is another mode for the synthetic debugger which uses hypercalls
> to send/recv network data instead of the MSR interface.
>
> This interface is much slower and less recommended since you might get
> a lot of VMExits while KDVM polling for new packets to recv, rather
> than simply checking the pending page to see if there is data avialble
> and then request.
>
> Signed-off-by: Jon Doron <arilou@gmail.com>
> ---
>  arch/x86/kvm/hyperv.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
> index 917b10a637fc..4a77ff61658b 100644
> --- a/arch/x86/kvm/hyperv.c
> +++ b/arch/x86/kvm/hyperv.c
> @@ -1821,6 +1821,28 @@ int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
>  		}
>  		ret = kvm_hv_send_ipi(vcpu, ingpa, outgpa, true, false);
>  		break;
> +	case HVCALL_POST_DEBUG_DATA:
> +	case HVCALL_RETRIEVE_DEBUG_DATA:
> +		if (unlikely(fast)) {
> +			ret = HV_STATUS_INVALID_PARAMETER;
> +			break;
> +		}
> +		/* fallthrough */

This is now being changed to 'fallthrough;'

> +	case HVCALL_RESET_DEBUG_SESSION: {
> +		struct kvm_hv_syndbg *syndbg = vcpu_to_hv_syndbg(vcpu);
> +		if (!(syndbg->options & HV_X64_SYNDBG_OPTION_USE_HCALLS)) {
> +			ret = HV_STATUS_OPERATION_DENIED;
> +			break;
> +		}
> +		vcpu->run->exit_reason = KVM_EXIT_HYPERV;
> +		vcpu->run->hyperv.type = KVM_EXIT_HYPERV_HCALL;
> +		vcpu->run->hyperv.u.hcall.input = param;
> +		vcpu->run->hyperv.u.hcall.params[0] = ingpa;
> +		vcpu->run->hyperv.u.hcall.params[1] = outgpa;
> +		vcpu->arch.complete_userspace_io =
> +				kvm_hv_hypercall_complete_userspace;
> +		return 0;
> +	}
>  	default:
>  		ret = HV_STATUS_INVALID_HYPERCALL_CODE;
>  		break;

And the hypercall should also check whether KVM_CAP_HYPERV_DEBUGGING is
enabled.

-- 
Vitaly

