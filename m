Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48D59189C6F
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Mar 2020 13:56:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbgCRM45 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 18 Mar 2020 08:56:57 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:29823 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726765AbgCRM44 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 18 Mar 2020 08:56:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584536215;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c9OQLq568ttEIueUGuMUb23dN7QtaHm5mZw/a87/b74=;
        b=cyAHkxcCpbjkA38SGbJTS7k969BfRuX2G9jTOjMbrDka4po9zAQvBboKUnc/cqMGI38DwN
        DZwsPFjGegX494ZFd30blreAH2H1EyuKXSSQYREKD7SH3uYg8LWJHY7kuZASWJPi2CN0Lc
        fZW5oxis6VpIAi9nyGQXO5MPURgNpJM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-443-BvA9l6G5NjWulMqGjHSQaQ-1; Wed, 18 Mar 2020 08:56:53 -0400
X-MC-Unique: BvA9l6G5NjWulMqGjHSQaQ-1
Received: by mail-wr1-f72.google.com with SMTP id u18so12227020wrn.11
        for <linux-hyperv@vger.kernel.org>; Wed, 18 Mar 2020 05:56:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=c9OQLq568ttEIueUGuMUb23dN7QtaHm5mZw/a87/b74=;
        b=QhpK1n373UFYnDjjthMla1XH0cSetNltyJk1g/fQ9CiSN5SOvDpszaUBPt0BM/ZekS
         u6wtIdUUHG0bkV2PSOXRf7i61rMWaXlyS0nKx7l+JyzZgV2jEYTbbbRjxmAPYvJLDgFb
         l+vB7k+kARBDJEMukwKs95zBnOW6fwXsR4hrI5BplclNVq1guWGHCRTZfrvr+yFE91TG
         nvFtPfxbeTWYuB34ZU3qpJXhrD1knqb0J907Ro2PpR2i2jFpCvsI356HpdcsROfR1869
         8qc+ixW3D0qG8cjKpm8l+N0vECt5YiD/hy0ZyHCs5OP6srBxq1Vj4qzya7oPi+I+tOad
         A7+A==
X-Gm-Message-State: ANhLgQ3J91ZfCbxnC/o/csm+Tmgh96MQ6in2eUnitPJbdwZba8fcUaJM
        JScjHrDNgEjmCq59briyxxH9Ae52Ae8ielpXa5C683wEWIjX31/r/XRpLKNdS35q0FO1Njc4gQT
        MAqtx/8qX/TIr+oBUMTWZKRGk
X-Received: by 2002:adf:e891:: with SMTP id d17mr5509629wrm.348.1584536211220;
        Wed, 18 Mar 2020 05:56:51 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsu6NX99ToSq9XsCTNE17TrJduAWxqFRpvNndDOnAPnU3c14uxrUpAN9ZL5FWUSnFwSgLDg4g==
X-Received: by 2002:adf:e891:: with SMTP id d17mr5509613wrm.348.1584536210950;
        Wed, 18 Mar 2020 05:56:50 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id r9sm3874667wma.47.2020.03.18.05.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 05:56:50 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Jon Doron <arilou@gmail.com>
Cc:     kvm@vger.kernel.org, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH v6 1/5] x86/kvm/hyper-v: Explicitly align hcall param for kvm_hyperv_exit
In-Reply-To: <20200317034804.112538-2-arilou@gmail.com>
References: <20200317034804.112538-1-arilou@gmail.com> <20200317034804.112538-2-arilou@gmail.com>
Date:   Wed, 18 Mar 2020 13:56:49 +0100
Message-ID: <87r1xp3jou.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Jon Doron <arilou@gmail.com> writes:

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

This looks good to me but probably not to an unprepared reader some time
later. What's going on here is:

The problem the patch is trying to address is the fact that 'struct
kvm_hyperv_exit' has different layout on when compiling in 32 and 64 bit
modes. In 64-bit mode the default alignment boundary is 64 bits thus
forcing extra gaps after 'type' and 'msr' but in 32-bit mode the
boundary is at 32 bits thus no extra gaps. This is an issue as even when
the kernel is 64 bit, the userspace using the interface can be both 32
and 64 bit but the same 32 bit userspace has to work with 32 bit kernel.
The issue is fixed by forcing the 64 bit layout, this leads to ABI
change for 32 bit builds and while we are obviously breaking '32 bit
userspace with 32 bit kernel' case, we're fixing the '32 bit userspace
with 64 bit kernel' one. As the interface has no (known) users and 32
bit KVM is rather baroque nowadays, this seems like a reasonable
decision.

I think something like the paragraph above should be the commit
message. With this fixed,

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

