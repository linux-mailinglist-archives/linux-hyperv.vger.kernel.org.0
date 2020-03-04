Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3B381791D3
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Mar 2020 14:58:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728432AbgCDN6Y (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 4 Mar 2020 08:58:24 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40910 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728244AbgCDN6Y (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 4 Mar 2020 08:58:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583330302;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3kAy1mxF/iEPG19osRMx+mDCDQEPCAf6CYbZmlawD5s=;
        b=RN9xKu1iZybkSrBX7uAQhrzfVwXH89AR54WqOIycAU8vUD0O+5GOb/Q5x97hhmyk3riMmu
        lC52VvFQICWd/jhVLjL4oAlwgRgAqEzrpsjVkbozCXqXENIo9l1pKIedKKZVFB2qDdTyVQ
        qk2A6d6Y8R4n7fgSHVU+Eu2Xrz/Jp5E=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-AOTflzQRPlyAHrzJVTZbdA-1; Wed, 04 Mar 2020 08:58:21 -0500
X-MC-Unique: AOTflzQRPlyAHrzJVTZbdA-1
Received: by mail-wm1-f70.google.com with SMTP id y18so1928690wmi.1
        for <linux-hyperv@vger.kernel.org>; Wed, 04 Mar 2020 05:58:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=3kAy1mxF/iEPG19osRMx+mDCDQEPCAf6CYbZmlawD5s=;
        b=fEd6uTXnx2ONL9PBEuukDAWcBi5c2xdPQ3UsYeK/njszgps90m4GmoWzkmVxehgt5G
         3hh6Z9N0SlGng+IahoItpElA5ec/TJqmGS5yhN5O53sDNbpEh29GFvyvCbhDaBrQP9tL
         PONzJ6PS6YZjCvoWOOMWLYBIC/6x/RfnRahyfYCwwGBFSIRekn8slYX7Rw+vWDxkt0kn
         C9E3n+DnBWMwWjuU7+72sl30aMs5ewftRhnBb2znLuUsRKOSyP8W5hzfZDCc3Qg86Kqb
         hqjG4d00oXJGRrRT7N19VXB98sZDnTa0jzT+0k6rMeXj/bCbmNsU8nfSIyt3vGvm1dh8
         EHMQ==
X-Gm-Message-State: ANhLgQ0r1OXO2KsK6RBUfJfhmgoJ3RT4j4dDQXPiOqbk93p4Lkz/f9TO
        3f/q7rbhCRdh0bHQPaBXvOWaGzewgFEsD04HQDlJSE6dPWopHED38AU9B2s8MNayyZxae8FPutE
        +yY1GCB9a5CNrEpF7/CwJc3Ak
X-Received: by 2002:a1c:81d3:: with SMTP id c202mr3940567wmd.79.1583330299932;
        Wed, 04 Mar 2020 05:58:19 -0800 (PST)
X-Google-Smtp-Source: ADFU+vuPNTWTD9RI+ams7yAcbxDxktjcz32mFc5odev+35OalYkzB+bvFzZUTHmXpFcCSIo1WOJbOg==
X-Received: by 2002:a1c:81d3:: with SMTP id c202mr3940540wmd.79.1583330299654;
        Wed, 04 Mar 2020 05:58:19 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id k66sm1744965wmf.0.2020.03.04.05.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 05:58:19 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Jon Doron <arilou@gmail.com>
Cc:     kvm@vger.kernel.org, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH v1 2/3] x86/kvm/hyper-v: enable hypercalls regardless of hypercall page
In-Reply-To: <20200303130356.50405-3-arilou@gmail.com>
References: <20200303130356.50405-1-arilou@gmail.com> <20200303130356.50405-3-arilou@gmail.com>
Date:   Wed, 04 Mar 2020 14:58:18 +0100
Message-ID: <87pndsdxxh.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Jon Doron <arilou@gmail.com> writes:

> Microsoft's kdvm.dll dbgtransport module does not respect the hypercall
> page and simply identifies the CPU being used (AMD/Intel) and according
> to it simply makes hypercalls with the relevant instruction
> (vmmcall/vmcall respectively).
>
> The relevant function in kdvm is KdHvConnectHypervisor which first checks
> if the hypercall page has been enabled via HV_X64_MSR_HYPERCALL_ENABLE,
> and in case it was not it simply sets the HV_X64_MSR_GUEST_OS_ID to
> 0x1000101010001 which means:
> build_number = 0x0001
> service_version = 0x01
> minor_version = 0x01
> major_version = 0x01
> os_id = 0x00 (Undefined)
> vendor_id = 1 (Microsoft)
> os_type = 0 (A value of 0 indicates a proprietary, closed source OS)
>
> and starts issuing the hypercall without setting the hypercall page.
>
> To resolve this issue simply enable hypercalls if the guest_os_id is
> not 0.
>
> Signed-off-by: Jon Doron <arilou@gmail.com>
> ---
>  arch/x86/kvm/hyperv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
> index 13176ec23496..7ec962d433af 100644
> --- a/arch/x86/kvm/hyperv.c
> +++ b/arch/x86/kvm/hyperv.c
> @@ -1615,7 +1615,7 @@ static u64 kvm_hv_send_ipi(struct kvm_vcpu *current_vcpu, u64 ingpa, u64 outgpa,
>  
>  bool kvm_hv_hypercall_enabled(struct kvm *kvm)
>  {
> -	return READ_ONCE(kvm->arch.hyperv.hv_hypercall) & HV_X64_MSR_HYPERCALL_ENABLE;
> +	return READ_ONCE(kvm->arch.hyperv.hv_guest_os_id) != 0;
>  }
>  
>  static void kvm_hv_hypercall_set_result(struct kvm_vcpu *vcpu, u64 result)

I would've enabled it in both cases,

return (READ_ONCE(kvm->arch.hyperv.hv_hypercall) &
 HV_X64_MSR_HYPERCALL_ENABLE) || (READ_ONCE(kvm->arch.hyperv.hv_guest_os_id) != 0);

to be safe. We can also check what genuine Hyper-V does but I bet it has
hypercalls always enabled. Also, the function can be made inline,
there's a single caller.

-- 
Vitaly

