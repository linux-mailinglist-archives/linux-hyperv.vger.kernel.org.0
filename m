Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F8559DE2E
	for <lists+linux-hyperv@lfdr.de>; Tue, 27 Aug 2019 08:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbfH0Gls (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 27 Aug 2019 02:41:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42532 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725943AbfH0Glr (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 27 Aug 2019 02:41:47 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5C833C0568FA
        for <linux-hyperv@vger.kernel.org>; Tue, 27 Aug 2019 06:41:47 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id b15so339371wrp.21
        for <linux-hyperv@vger.kernel.org>; Mon, 26 Aug 2019 23:41:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=R3N0Ux8sXWlDkwBv6LnZ39XXekdpR8uOz0RxueTkq8c=;
        b=cfJGSl4YHxBitk9iQ/IEM2RQ7RV7nAhqVlQMC6f5BKxcS/UY7aoCdNPpyUS5tpuzCc
         SWLf3vu+ZwU+TpuS8nBNdeK0bcuUllNhnNwZ2O/7Uuzy8/VtIBgI0AR5fWQh+RiGoUjz
         YeDuY3tZ7qNAuY+qeHJXcwKFZvJMqCtqDf84+0Gks8J+KAunmheerYnBYTv/rJ2zTKRt
         ZBGfnE9xaATWum8J8T8KjsadyeTPNLhvgq7KAj5GdZ8zCw/Sd/IeZRe/CaSIwckn8yXn
         5EeXEKkO68CY/7sKOxaX5vw91PgbFfeNKz4X5ZjNCHYCmgQKklqpHd9CvEEgXONQ8YvQ
         lcaw==
X-Gm-Message-State: APjAAAVemv6ipXVJK7Q5Yj6rWc/6g1F2fLB+new6uTF4j23JiCSByF56
        9c7iOoBQ+ndyUfhAZRmnSrQNE1n9Rz+MPJFIDgTUrzHMmERigY8liVhGENd3ZpIbsux+kup2DpK
        TLKBnmGnWXnnSKnfa+jHMkuYd
X-Received: by 2002:a1c:6145:: with SMTP id v66mr27541192wmb.42.1566888106026;
        Mon, 26 Aug 2019 23:41:46 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy2GI0NmyS361uOvgSgC8vAQPveBM+fESLiQwCenbAGMgIf/+ayRt++zlV0fLjGFgWERAv3gA==
X-Received: by 2002:a1c:6145:: with SMTP id v66mr27541156wmb.42.1566888105812;
        Mon, 26 Aug 2019 23:41:45 -0700 (PDT)
Received: from vitty.brq.redhat.com (ip-89-176-161-20.net.upcbroadband.cz. [89.176.161.20])
        by smtp.gmail.com with ESMTPSA id 39sm42348076wrc.45.2019.08.26.23.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 23:41:45 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     lantianyu1986@gmail.com
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, pbonzini@redhat.com,
        rkrcmar@redhat.com, corbet@lwn.net, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com, sashal@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, michael.h.kelley@microsoft.com
Subject: Re: [PATCH V3 0/3] KVM/Hyper-V: Add Hyper-V direct tlb flush support
In-Reply-To: <20190819131737.26942-1-Tianyu.Lan@microsoft.com>
References: <20190819131737.26942-1-Tianyu.Lan@microsoft.com>
Date:   Tue, 27 Aug 2019 08:41:43 +0200
Message-ID: <87ftlnm7o8.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

lantianyu1986@gmail.com writes:

> From: Tianyu Lan <Tianyu.Lan@microsoft.com>
>
> This patchset is to add Hyper-V direct tlb support in KVM. Hyper-V
> in L0 can delegate L1 hypervisor to handle tlb flush request from
> L2 guest when direct tlb flush is enabled in L1.
>
> Patch 2 introduces new cap KVM_CAP_HYPERV_DIRECT_TLBFLUSH to enable
> feature from user space. User space should enable this feature only
> when Hyper-V hypervisor capability is exposed to guest and KVM profile
> is hided. There is a parameter conflict between KVM and Hyper-V hypercall.
> We hope L2 guest doesn't use KVM hypercall when the feature is
> enabled. Detail please see comment of new API
> "KVM_CAP_HYPERV_DIRECT_TLBFLUSH"

I was thinking about this for awhile and I think I have a better
proposal. Instead of adding this new capability let's enable direct TLB
flush when KVM guest enables Hyper-V Hypercall page (writes to
HV_X64_MSR_HYPERCALL) - this guarantees that the guest doesn't need KVM
hypercalls as we can't handle both KVM-style and Hyper-V-style
hypercalls simultaneously and kvm_emulate_hypercall() does:

	if (kvm_hv_hypercall_enabled(vcpu->kvm))
		return kvm_hv_hypercall(vcpu);

What do you think?

(and instead of adding the capability we can add kvm.ko module parameter
to enable direct tlb flush unconditionally, like
'hv_direct_tlbflush=-1/0/1' with '-1' being the default (autoselect
based on Hyper-V hypercall enablement, '0' - permanently disabled, '1' -
permanenetly enabled)).

-- 
Vitaly
