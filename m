Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94CE01E7AE1
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 May 2020 12:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbgE2KrH (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 29 May 2020 06:47:07 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:20036 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726477AbgE2KrD (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 29 May 2020 06:47:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590749221;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5ZyzBn3kN44DFoEairny9wYPI8hbjny9xpu0cs3OwKg=;
        b=aVMrsGyPAw7aEGf1bhTTngcN+cbu3FVPe7ANUQmB9u9svgFs6lJebHo95Co6/KGGPlTQHr
        omTFGA6/fXaFpMXv12rbaDGA7nnpxtODM4YNeQ5JsXH1ANr6lFKbwMn0PVhZiQhEyia4uj
        V8pxEOAoSBt3+MgTVaE4z1xJz17D6GQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-460-ZRl4nGGYOFqHPjWL9Kd-Lw-1; Fri, 29 May 2020 06:46:58 -0400
X-MC-Unique: ZRl4nGGYOFqHPjWL9Kd-Lw-1
Received: by mail-wr1-f71.google.com with SMTP id l1so881874wrc.8
        for <linux-hyperv@vger.kernel.org>; Fri, 29 May 2020 03:46:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5ZyzBn3kN44DFoEairny9wYPI8hbjny9xpu0cs3OwKg=;
        b=TcXuBtgI6ri/xcCPHWrcYVq3OKhs0TOwSNNaDEs2ZVisi1wR8xIKte4P66qzaDyVQ5
         2RSZ+zJtkzoiLbxYjot2JzKy/qhyt0qBA9lr3yT5vahd5Rs28KBsgZaX/jDDSxXlIe0I
         Th0Y9SFDwfNijvCCg3jBWT2y3gLcKvpFaq+/KhnyNSextCHsMMsEuWLuLxyo+91XUVPU
         AxvY2goh8OWaC8XKhxLctzKymzh8gP1FT2UXMjaf346w35LTlsQqq6VAVbfGtNIQvf+E
         Y6vkyWDcUOOwQx2SygDoGZPukLgmd2yuTvieDLiwYNfbhgxL59NRbYnOzDBPWXc1WZig
         51Xg==
X-Gm-Message-State: AOAM532KOMbm9RJd/fsFu7ZUfIwrRw4xMSjwznKPfFRDorVfZhupnG2A
        sgHtybJ70y7798S/yiZVzK8/eqP36k2S+sL2pu4dAjESOmrEdp0VHMyeWCcPtpE88GKZgsedD3i
        1I8b4VQDfYQYWZNsCbxzZpdW8
X-Received: by 2002:adf:eb47:: with SMTP id u7mr8080977wrn.14.1590749216773;
        Fri, 29 May 2020 03:46:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyNhQ9hgZbqSGo6sl++puYpTtIz8IbEag41ylRf1VuiwlQ/i6x9UvRQaKcyQ6yqMpbfGSY4jQ==
X-Received: by 2002:adf:eb47:: with SMTP id u7mr8080963wrn.14.1590749216587;
        Fri, 29 May 2020 03:46:56 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:b096:1b7:7695:e4f7? ([2001:b07:6468:f312:b096:1b7:7695:e4f7])
        by smtp.gmail.com with ESMTPSA id u3sm11928336wmg.38.2020.05.29.03.46.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2020 03:46:55 -0700 (PDT)
Subject: Re: [PATCH v11 4/7] x86/kvm/hyper-v: Add support for synthetic
 debugger capability
To:     Jon Doron <arilou@gmail.com>, kvm@vger.kernel.org,
        linux-hyperv@vger.kernel.org
Cc:     vkuznets@redhat.com
References: <20200424113746.3473563-1-arilou@gmail.com>
 <20200424113746.3473563-5-arilou@gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <12df4348-3dc1-a4cc-aa41-4492cd42dcc8@redhat.com>
Date:   Fri, 29 May 2020 12:46:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200424113746.3473563-5-arilou@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 24/04/20 13:37, Jon Doron wrote:
> +static int syndbg_get_msr(struct kvm_vcpu *vcpu, u32 msr, u64 *pdata, bool host)
> +{
> +	struct kvm_hv_syndbg *syndbg = vcpu_to_hv_syndbg(vcpu);
> +
> +	if (!syndbg->active && !host)
> +		return 1;
> +

One small thing: is the ENABLE_CAP and active field needed?  Can you
just check if the guest has the syndbg CPUID bits set?

Thanks,

Paolo

