Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCEE218ADF6
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2020 09:08:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725895AbgCSIIr (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 19 Mar 2020 04:08:47 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:43346 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725768AbgCSIIr (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 19 Mar 2020 04:08:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584605326;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SlJrsOiPEFfP8xQL+2MTzWgFawZiNaS1jJXa4jmFhqA=;
        b=iYlLg5hIVV2TyvX3y0YaBXJF//DSwwn78FJCDwDUvvV5v0JADbapACF6kEaI3Ysa+IO60M
        jDGb8m3ODXoYLfvO+qXVuRu6Tm+3mmEZFCt+pXxq+jz4rEN9AoX4lt3Gc+qrEwWJ1bDJXg
        qsGsRpcO+/uu61Lm7XNtbbZ5rZSidRU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-53-ORspJVxhOWegU1XW-1VN2Q-1; Thu, 19 Mar 2020 04:08:44 -0400
X-MC-Unique: ORspJVxhOWegU1XW-1VN2Q-1
Received: by mail-wr1-f69.google.com with SMTP id d17so607103wrw.19
        for <linux-hyperv@vger.kernel.org>; Thu, 19 Mar 2020 01:08:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=SlJrsOiPEFfP8xQL+2MTzWgFawZiNaS1jJXa4jmFhqA=;
        b=dN5kSdIQ9s2TF4EJftbj2yoBDzNTkWs3wAgrQdeUKOduqge5Q3/j5Id7s1+BucysRk
         lQqBkeWb6a2NnGspSt/15ZHI/DqVHBVdrXz/OyayjCNBFjRWie0IIMCjq91VP08DuRQg
         ar7RoOzfIJQX/NplSLT86OWJW5HT6ICPJeRHMT80VjhxX9s3+L6NJtane1fOpl56Lkx8
         ZucloUTSm+vGU7RlnXbCPxRvaw6vYSvhbtXwqupzwdAFD2UX14/qQOFACe+BeWuM2+zT
         sVqYvWSMq/dZ3QixMmWKtwzB5qcHXppRxKw/uYyUOhBiRQc+4/Yc5Lvro14hnozHN7cQ
         OK2Q==
X-Gm-Message-State: ANhLgQ2OjyRVJzvvigmD2atwqGgdd66rr4BsyJtdyWFIyQ9PYa6ies2g
        tYjzYwqcBNl5aXEFVO6TsqIicBTVEX5KJ7XZfwCDM6qYDXRWkS6XRJa27SRClq78LCVMRexleOE
        iTicseB7kfFTzA13u/+eC2m9T
X-Received: by 2002:a7b:c4cd:: with SMTP id g13mr2246559wmk.151.1584605322951;
        Thu, 19 Mar 2020 01:08:42 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuHul2WwD85TA8ajS4E+DeyZ8lqBhFZsQV3ofqPUzIbkGIIMM6eJzdwpfnX3UGfRPKInTOCMw==
X-Received: by 2002:a7b:c4cd:: with SMTP id g13mr2246536wmk.151.1584605322742;
        Thu, 19 Mar 2020 01:08:42 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id r18sm2275564wro.13.2020.03.19.01.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 01:08:42 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Jon Doron <arilou@gmail.com>
Cc:     kvm@vger.kernel.org, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH v8 1/5] x86/kvm/hyper-v: Explicitly align hcall param for kvm_hyperv_exit
In-Reply-To: <20200319063836.678562-2-arilou@gmail.com>
References: <20200319063836.678562-1-arilou@gmail.com> <20200319063836.678562-2-arilou@gmail.com>
Date:   Thu, 19 Mar 2020 09:08:41 +0100
Message-ID: <87k13g22d2.fsf@vitty.brq.redhat.com>
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

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

