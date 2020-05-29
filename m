Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 863901E7AE4
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 May 2020 12:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725775AbgE2Ksf (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 29 May 2020 06:48:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27387 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726549AbgE2Ksb (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 29 May 2020 06:48:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590749310;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9lZTwXys9JODCXs4XiXlRjVl8buJ25dhhOGvmDlLOBA=;
        b=QlUXb8gPM5ubmh6V1tHtQxkwmPRb+ayl1NJIvktYhScvwr5gzr+H9goewzztG5u4MXKh3K
        Qq5FsbaRLMkJMQZ4u9QmzlNHXkCKruJnODWBPgJhG/l9V6KVkOA8RUg9XWd03REzEkjw3O
        M4xTsGTH1QfxUTeeG4CeTwEubXlEMng=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-96-RHn-MkdRNgelswsocZ9A2g-1; Fri, 29 May 2020 06:48:28 -0400
X-MC-Unique: RHn-MkdRNgelswsocZ9A2g-1
Received: by mail-wm1-f71.google.com with SMTP id t62so627201wmt.7
        for <linux-hyperv@vger.kernel.org>; Fri, 29 May 2020 03:48:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9lZTwXys9JODCXs4XiXlRjVl8buJ25dhhOGvmDlLOBA=;
        b=CNkqQVFc0onj0G9DoUH5hg1b0B8+3Nj6fGqA0T9HJ1daUweXnxBD2YYFEHUElggq3n
         a8kT4oSp1nlmzIg0wjxBRdM3GceTHIPydnRf18im2Q/LvPs+7LNEMra7vzq6zksNhoga
         Nar2Oe7Ux8hreqF4/svubLWqoTcnv5K2daH6+bIinu9LGX5IpDtRxnyNTs4wGCqgDhI8
         VnPWPzygxkz3Xt3ceCSyW5SLu1ACa+M8Qq/ysPwkFfhouxAuWFJHDUpzb1tiephkdswF
         SpKLhFarOc2ZLKOpZEF1wOXAHMl7h2mAqSUGVMfpK2RoaLd4oFN5y5/ukt2S2Alu1LxN
         w8Xg==
X-Gm-Message-State: AOAM533HrB7ilQCc8B7U+Q6jNgGNBXWmndqa3nqfChzd1UNSkWo48TX8
        vSAXs1QKBg7PyqkXGyPsJES6YS6CgbfO6y6pH3OZZUWq4knrUWzwYfaMpP7quVZ/1aN7Dh6QaDA
        exh8HeTz3bNlQzwwRnpEcY/+Q
X-Received: by 2002:adf:ea8b:: with SMTP id s11mr8318353wrm.168.1590749307143;
        Fri, 29 May 2020 03:48:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyq5ZFwQJ+jQLcj8SlKA74AIKEYwZxYdLQNJdwXmzuehZryK6oNdOxBvH2VRvGqurWBH55Plw==
X-Received: by 2002:adf:ea8b:: with SMTP id s11mr8318340wrm.168.1590749306948;
        Fri, 29 May 2020 03:48:26 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:b096:1b7:7695:e4f7? ([2001:b07:6468:f312:b096:1b7:7695:e4f7])
        by smtp.gmail.com with ESMTPSA id k21sm5167153wrd.24.2020.05.29.03.48.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2020 03:48:26 -0700 (PDT)
Subject: Re: [PATCH v11 5/7] x86/kvm/hyper-v: enable hypercalls without
 hypercall page with syndbg
To:     Jon Doron <arilou@gmail.com>, kvm@vger.kernel.org,
        linux-hyperv@vger.kernel.org
Cc:     vkuznets@redhat.com
References: <20200424113746.3473563-1-arilou@gmail.com>
 <20200424113746.3473563-6-arilou@gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7ad6cc8a-7c4a-f556-4f59-704234ce73cb@redhat.com>
Date:   Fri, 29 May 2020 12:48:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200424113746.3473563-6-arilou@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 24/04/20 13:37, Jon Doron wrote:
> diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
> index 435516595090..524b5466a515 100644
> --- a/arch/x86/kvm/hyperv.c
> +++ b/arch/x86/kvm/hyperv.c
> @@ -1650,7 +1650,10 @@ static u64 kvm_hv_send_ipi(struct kvm_vcpu *current_vcpu, u64 ingpa, u64 outgpa,
>  
>  bool kvm_hv_hypercall_enabled(struct kvm *kvm)
>  {
> -	return READ_ONCE(kvm->arch.hyperv.hv_hypercall) & HV_X64_MSR_HYPERCALL_ENABLE;
> +	struct kvm_hv *hv = &kvm->arch.hyperv;
> +
> +	return READ_ONCE(hv->hv_hypercall) & HV_X64_MSR_HYPERCALL_ENABLE ||
> +	       (hv->hv_syndbg.active && READ_ONCE(hv->hv_guest_os_id) != 0);
>  }

Here too we could just shrug and allow hypercalls if the guest OS is not
NULL.

Paolo

