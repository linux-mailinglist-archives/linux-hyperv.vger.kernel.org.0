Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 124F58D4CB
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 Aug 2019 15:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbfHNNdU (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 14 Aug 2019 09:33:20 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55656 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbfHNNdU (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 14 Aug 2019 09:33:20 -0400
Received: by mail-wm1-f68.google.com with SMTP id f72so4624403wmf.5
        for <linux-hyperv@vger.kernel.org>; Wed, 14 Aug 2019 06:33:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=StWDmI2leKU54QSXvYjmfmAGy4K9xDCc49w71+uaK+4=;
        b=MSoT92OkhsmgFy2WzkDFAZv6QRsa0gZbnQTpqVduOlKbdCt2K7yXj73jbvboZMEOOj
         lAWGKLcna81GwSz9dB205wE/IxxFvUbxzPkGq2UI+w3H9upCTQIPEx54JM9v9nWRwjV+
         TB8A5QtAFJex3A2/HwoIJXW3kkLF7+XzFvg1zme/bsB3vjvZG4VwXPlZYM/TE8boIV30
         cNCu7QkX4Sj/ujtRHfXFOum59KB6EOF3ofVVtuM4r6N+kkcH0Ea4mnNYoUe9f+Zj4270
         5A7u1ZbE0e65DWOm2qElAWz7HOS7c9z92E9sCwCJDvja6xIXtLCGFWvr1/g479OkUjzT
         77Ng==
X-Gm-Message-State: APjAAAVvyNIiQZNurv85UQoYL8eWzZivZdPOVAHuHbEiHm0ahdJxKG1R
        +D6GX7IQnSp+29S26SkXgU1juQ==
X-Google-Smtp-Source: APXvYqxRCG8CIFrb2MV/85J/MZEVigfCoj7dDBh0t2vCtmy4l3mnZa0oimzzNk0UARfbs4djy9dnmw==
X-Received: by 2002:a1c:9cc5:: with SMTP id f188mr3195983wme.163.1565789598082;
        Wed, 14 Aug 2019 06:33:18 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:2cae:66cd:dd43:92d9? ([2001:b07:6468:f312:2cae:66cd:dd43:92d9])
        by smtp.gmail.com with ESMTPSA id b26sm4945229wmj.14.2019.08.14.06.33.16
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Aug 2019 06:33:17 -0700 (PDT)
Subject: Re: [PATCH V2 3/3] KVM/Hyper-V/VMX: Add direct tlb flush support
To:     lantianyu1986@gmail.com, kys@microsoft.com, haiyangz@microsoft.com,
        sthemmin@microsoft.com, sashal@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        rkrcmar@redhat.com, michael.h.kelley@microsoft.com
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Tianyu Lan <Tianyu.Lan@microsoft.com>
References: <20190814073447.96141-1-Tianyu.Lan@microsoft.com>
 <20190814073447.96141-4-Tianyu.Lan@microsoft.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <1a1410a7-e2dc-904e-a271-3e2017d42bae@redhat.com>
Date:   Wed, 14 Aug 2019 15:33:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190814073447.96141-4-Tianyu.Lan@microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 14/08/19 09:34, lantianyu1986@gmail.com wrote:
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index c5da875f19e3..479ad76661e6 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -500,6 +500,7 @@ struct kvm {
>  	struct srcu_struct srcu;
>  	struct srcu_struct irq_srcu;
>  	pid_t userspace_pid;
> +	struct hv_partition_assist_pg *hv_pa_pg;
>  };
>  
>  #define kvm_err(fmt, ...) \

This does not exist on non-x86 architectures.  Please move it to struct
kvm_arch.

Paolo
