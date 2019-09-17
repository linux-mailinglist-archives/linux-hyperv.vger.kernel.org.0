Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26076B4F28
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Sep 2019 15:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbfIQN1s (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 17 Sep 2019 09:27:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:19205 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727901AbfIQN1s (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 17 Sep 2019 09:27:48 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0A0F486679
        for <linux-hyperv@vger.kernel.org>; Tue, 17 Sep 2019 13:27:48 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id o188so1256560wmo.5
        for <linux-hyperv@vger.kernel.org>; Tue, 17 Sep 2019 06:27:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1P0dSGUS+WWJgIEsGv0bzVV8obUlEtzj+cS48y+KeEY=;
        b=Av6+IUYn6jWEno2OmJuiIV81NNkRQl6iPrCkt3hBJ3/OkNhs6qP9qiZyGYMTzlZ6aG
         UvxeWnhHJ8PfU5S3Wt+Z7axmCzRKYAQardwVMTfcg18G/py3IpfCZPU86JoswC5cnwFg
         RGRtgBtaZSgUnEB4pohsCpvGDKu3Zgi+/iwmrPbmCh7D66Qxb8YQOex9sifBZgDHKaL5
         /m9aa3Yqbr3Mj6pJ+/XbAw5I01jykE9/CrQmN8XiD/yjVhv/zQ/tD/DLh/mTyhLnC//U
         yapHFdwbHNGKJbHZlol2ABNDfxW48E2RGiWD5jXub+IOiNeDffvBcoWOv45U5KChtuJH
         dfLA==
X-Gm-Message-State: APjAAAWGPQFccEkTD0xQmQ6ddQ7ynCGhpMA7k/gRw27znUmm7IscA+lc
        ox28l0yGjmy+0PgyxznEbN/O8p1RW87ps0BtL8CCgX4odN6H9t8TU8eosbpAn5fB5O6P+BsbCs3
        I4l83bkXnRjTvJ4D67LejYvfM
X-Received: by 2002:adf:f303:: with SMTP id i3mr3196356wro.242.1568726866531;
        Tue, 17 Sep 2019 06:27:46 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxFU9EERU1lbrrSdMwmejNG+OkwH4Dchh8n9cZ1MOq5r+sDWbio0dFe9hnBTYw15bHDvn+q+Q==
X-Received: by 2002:adf:f303:: with SMTP id i3mr3196322wro.242.1568726866217;
        Tue, 17 Sep 2019 06:27:46 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c46c:2acb:d8d2:21d8? ([2001:b07:6468:f312:c46c:2acb:d8d2:21d8])
        by smtp.gmail.com with ESMTPSA id 33sm4277057wra.41.2019.09.17.06.27.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Sep 2019 06:27:45 -0700 (PDT)
Subject: Re: [PATCH V4 0/3] KVM/Hyper-V: Add Hyper-V direct tlb flush support
To:     lantianyu1986@gmail.com, rkrcmar@redhat.com, corbet@lwn.net,
        kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        michael.h.kelley@microsoft.com
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, vkuznets@redhat.com
References: <20190822143021.7518-1-Tianyu.Lan@microsoft.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <7ea7fa06-f100-1507-8507-1c701877c8ab@redhat.com>
Date:   Tue, 17 Sep 2019 15:27:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190822143021.7518-1-Tianyu.Lan@microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 22/08/19 16:30, lantianyu1986@gmail.com wrote:
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
> enabled. Detail please see comment of new API "KVM_CAP_HYPERV_DIRECT_TLBFLUSH"
> 
> Change since v3:
>        - Update changelog in each patches. 
> 
> Change since v2:
>        - Move hv assist page(hv_pa_pg) from struct kvm  to struct kvm_hv.
> 
> Change since v1:
>        - Fix offset issue in the patch 1.
>        - Update description of KVM KVM_CAP_HYPERV_DIRECT_TLBFLUSH.
> 
> Tianyu Lan (2):
>   x86/Hyper-V: Fix definition of struct hv_vp_assist_page
>   KVM/Hyper-V: Add new KVM capability KVM_CAP_HYPERV_DIRECT_TLBFLUSH
> 
> Vitaly Kuznetsov (1):
>   KVM/Hyper-V/VMX: Add direct tlb flush support
> 
>  Documentation/virtual/kvm/api.txt  | 13 +++++++++++++
>  arch/x86/include/asm/hyperv-tlfs.h | 24 ++++++++++++++++++-----
>  arch/x86/include/asm/kvm_host.h    |  4 ++++
>  arch/x86/kvm/vmx/evmcs.h           |  2 ++
>  arch/x86/kvm/vmx/vmx.c             | 39 ++++++++++++++++++++++++++++++++++++++
>  arch/x86/kvm/x86.c                 |  8 ++++++++
>  include/uapi/linux/kvm.h           |  1 +
>  7 files changed, 86 insertions(+), 5 deletions(-)
> 

Queued, thanks.

Paolo
