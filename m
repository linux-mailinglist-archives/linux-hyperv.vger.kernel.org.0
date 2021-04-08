Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A54B13588CE
	for <lists+linux-hyperv@lfdr.de>; Thu,  8 Apr 2021 17:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbhDHPrc (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 8 Apr 2021 11:47:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41026 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231480AbhDHPrc (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 8 Apr 2021 11:47:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617896841;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YTgmH756AhLxTUX70sV9sEtjSkUIHcT5ErPkRW1CdPU=;
        b=Z9ET8wZf03YHHTqNh0Zt0OIDdjb/0S/4quxWVaIBdKP1bBBUn3QXX7SciMIM6T5mpXJDbY
        ldY8Q2FA5vjABBPz9RMRCcSPbWcAEp/fZUnj20Nfy3ttNHJQu1+SVv+V/VITJiuTyQZl07
        3hV7mGPVawuJecZceqOVnmLd/3Te6FI=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-QpfRfmKlN1WORugpoNiG3Q-1; Thu, 08 Apr 2021 11:47:19 -0400
X-MC-Unique: QpfRfmKlN1WORugpoNiG3Q-1
Received: by mail-ej1-f69.google.com with SMTP id a11so808963ejg.7
        for <linux-hyperv@vger.kernel.org>; Thu, 08 Apr 2021 08:47:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YTgmH756AhLxTUX70sV9sEtjSkUIHcT5ErPkRW1CdPU=;
        b=OsDuWnnUSXeJi2Q1VRwJFik5hgNjW/pYNpL0CeGHoIIn/Fz15YaqsU9RLAWZRybIqI
         niV/pCqeSUqy/wgiQhh3WLBKX6luIT4XCC0rMjnRfjGza7piMwpVcUtQJ+O4Px1IVwbU
         W7uFiadDR0R8vxd06WiivBUmqy55anjOxLdU+mgOQ5eO0UeMbSUCRbXSHyuJaO+ZRO3q
         ipKfuECllmdxfZi7EkWrrquZJANbSJqs2xBKpgbVdTYVSrMP8Y9YefxkIN8dt30jmka0
         JH329q5jTVUdd872FLCZ8XPvxR+JkRKBIWnAxxHIuM/oYCS8390k+AOj3QhYfpn9Pse8
         JN0g==
X-Gm-Message-State: AOAM533wIPAZ/fayAyGSRBwXCU5QkanZY91SLN15/e8YQbgyDOuuDQbJ
        XN9xQBCAOa9Km+gSC9/whAuZN7mJ2/mN9nLAJ5CtCkpzUSL3njZg1ago7PZfW36h+lv6C/tf1vO
        XyY7/DmGYetNsXBSSYXLZi4MGxnRxZqqDIVM1A+YRTBcHZDZng96MT6bwsIN4QWcp2coO3JwkKm
        A8
X-Received: by 2002:a17:906:7e53:: with SMTP id z19mr2999621ejr.422.1617896838198;
        Thu, 08 Apr 2021 08:47:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyKGb2aWaaqbI0/Ib/6Q0YDqGF8YzM0XjfD52Zv6Hen9YRdCmYCPhA95jv92MLfrWIXCkYaAw==
X-Received: by 2002:a17:906:7e53:: with SMTP id z19mr2999580ejr.422.1617896837965;
        Thu, 08 Apr 2021 08:47:17 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.gmail.com with ESMTPSA id r19sm14422213ejr.55.2021.04.08.08.47.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Apr 2021 08:47:17 -0700 (PDT)
Subject: Re: [PATCH 6/7] KVM: SVM: hyper-v: Enlightened MSR-Bitmap support
To:     Vineeth Pillai <viremana@linux.microsoft.com>,
        Lan Tianyu <Tianyu.Lan@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, Wei Liu <wei.liu@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "K. Y. Srinivasan" <kys@microsoft.com>, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org
References: <cover.1617804573.git.viremana@linux.microsoft.com>
 <5cf935068a9539146e033276b6d9a6c9b1e42119.1617804573.git.viremana@linux.microsoft.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <58df22aa-5d2c-f99f-6dfb-9a8b4260dc21@redhat.com>
Date:   Thu, 8 Apr 2021 17:47:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <5cf935068a9539146e033276b6d9a6c9b1e42119.1617804573.git.viremana@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 07/04/21 16:41, Vineeth Pillai wrote:
>   
> +#if IS_ENABLED(CONFIG_HYPERV)
> +static inline void hv_vmcb_dirty_nested_enlightenments(struct kvm_vcpu *vcpu)
> +{
> +	struct vmcb *vmcb = to_svm(vcpu)->vmcb;
> +
> +	/*
> +	 * vmcb can be NULL if called during early vcpu init.
> +	 * And its okay not to mark vmcb dirty during vcpu init
> +	 * as we mark it dirty unconditionally towards end of vcpu
> +	 * init phase.
> +	 */
> +	if (vmcb && vmcb_is_clean(vmcb, VMCB_HV_NESTED_ENLIGHTENMENTS) &&
> +	    vmcb->hv_enlightenments.hv_enlightenments_control.msr_bitmap)
> +		vmcb_mark_dirty(vmcb, VMCB_HV_NESTED_ENLIGHTENMENTS);
> +}

In addition to what Vitaly said, can svm->vmcb really be NULL?  If so it 
might be better to reorder initializations and skip the NULL check.

Paolo

