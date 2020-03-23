Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE7ED18F22E
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Mar 2020 10:53:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727752AbgCWJx0 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 23 Mar 2020 05:53:26 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:30477 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727738AbgCWJxZ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 23 Mar 2020 05:53:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584957204;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VPD/Jl19hS8LZpj/pgb6n0uGZoGyOvZALf7c52VQrx0=;
        b=M8Qc5BB2PNsvHbRy7T+7eBpesAJkyc6nSktbwho/j8RqzQsH5WlDaRU5Nl2Z0oNWGSEhbI
        NrceOWRW8Ntx1rJtk6kmeHTh+nSHa0sW0IlPJMMTX5d2shZF2y2E3JrzckmtsmtD4dDvcI
        bLLaQ8l8yesDTXEBGWGYqjugNlxFSDw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-414-GvtjfxdINnOWBVr3WOZujA-1; Mon, 23 Mar 2020 05:53:23 -0400
X-MC-Unique: GvtjfxdINnOWBVr3WOZujA-1
Received: by mail-wm1-f69.google.com with SMTP id w9so727560wmi.2
        for <linux-hyperv@vger.kernel.org>; Mon, 23 Mar 2020 02:53:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=VPD/Jl19hS8LZpj/pgb6n0uGZoGyOvZALf7c52VQrx0=;
        b=j74yA9M3Z6Us35gDoDEzlG+JZREbUR7hSzJI1sRaX4ltRt0bFAAF/61KzEgjmxP1/M
         h3QsT2+OSNahPuXAycnzqyYRMbH8aO5M12C2gAgwu2d0bBQSH29QWBzyitauR47/U5Zr
         Nn22IMP5zttEH4NuK6YpD4OAoTHzSj8htFNmoSGLulzlPsxDGI+HvYTE3kvr7InHIpec
         5Lx4fq1WZfhsJkMs1QkqaDIn9YdWuFb0ht3WwchHoxfh1oh/ltWGxzp1J1kwxhsebSFY
         F4zRsBsFUBX3tRSCt6EmPDxMZf6NtTwWo4M0sp9AW3aEFgL2hrWT5ePLzzcXEHJ5VKAs
         hsdg==
X-Gm-Message-State: ANhLgQ3re9as5NAH8VDi6Q4Y9SwkbX0WWPgWq3GfZyQiAmyCxGUngxaO
        LlS5N0HcGe092hc5AFqcwSofZRdGQ6HwuFKZ7Do9bhZsieJb/wVZqArTOi7nLaDU0gKPZNlzhTX
        2wFouF8mV0jL+SUgnk+1H+Ax0
X-Received: by 2002:a1c:3241:: with SMTP id y62mr27598458wmy.66.1584957201449;
        Mon, 23 Mar 2020 02:53:21 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtwCAOGgPAR0vwL4cDhzymGqUrzBFlAq+C1qd3tAwY4wzCvAxHsdZwLP/SPzxu8jkejeHa20A==
X-Received: by 2002:a1c:3241:: with SMTP id y62mr27598435wmy.66.1584957201245;
        Mon, 23 Mar 2020 02:53:21 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id v7sm21926822wml.18.2020.03.23.02.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 02:53:20 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Jon Doron <arilou@gmail.com>
Cc:     kvm@vger.kernel.org, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH v9 1/6] x86/kvm/hyper-v: Explicitly align hcall param for kvm_hyperv_exit
In-Reply-To: <20200320172839.1144395-2-arilou@gmail.com>
References: <20200320172839.1144395-1-arilou@gmail.com> <20200320172839.1144395-2-arilou@gmail.com>
Date:   Mon, 23 Mar 2020 10:53:19 +0100
Message-ID: <87zhc79z3k.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Jon Doron <arilou@gmail.com> writes:

> The problem the patch is trying to address is the fact that 'struct
> kvm_hyperv_exit' has different layout on when compiling in 32 and 64 bit
> modes.
>
> In 64-bit mode the default alignment boundary is 64 bits thus
> forcing extra gaps after 'type' and 'msr' but in 32-bit mode the
> boundary is at 32 bits thus no extra gaps.
>
> This is an issue as even when the kernel is 64 bit, the userspace using
> the interface can be both 32 and 64 bit but the same 32 bit userspace has
> to work with 32 bit kernel.
>
> The issue is fixed by forcing the 64 bit layout, this leads to ABI
> change for 32 bit builds and while we are obviously breaking '32 bit
> userspace with 32 bit kernel' case, we're fixing the '32 bit userspace
> with 64 bit kernel' one.
>
> As the interface has no (known) users and 32 bit KVM is rather baroque
> nowadays, this seems like a reasonable decision.
>
> Signed-off-by: Jon Doron <arilou@gmail.com>
> ---
>  Documentation/virt/kvm/api.rst | 2 ++
>  include/uapi/linux/kvm.h       | 2 ++
>  2 files changed, 4 insertions(+)
>
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> index ebd383fba939..4872c47bbcff 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -5025,9 +5025,11 @@ EOI was received.
>    #define KVM_EXIT_HYPERV_SYNIC          1
>    #define KVM_EXIT_HYPERV_HCALL          2
>  			__u32 type;
> +			__u32 pad1;
>  			union {
>  				struct {
>  					__u32 msr;
> +					__u32 pad2;
>  					__u64 control;
>  					__u64 evt_page;
>  					__u64 msg_page;
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 4b95f9a31a2f..7ee0ddc4c457 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -189,9 +189,11 @@ struct kvm_hyperv_exit {
>  #define KVM_EXIT_HYPERV_SYNIC          1
>  #define KVM_EXIT_HYPERV_HCALL          2
>  	__u32 type;
> +	__u32 pad1;
>  	union {
>  		struct {
>  			__u32 msr;
> +			__u32 pad2;
>  			__u64 control;
>  			__u64 evt_page;
>  			__u64 msg_page;

Already said that on v8 but the tag got lost,

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

