Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18BD03BD95D
	for <lists+linux-hyperv@lfdr.de>; Tue,  6 Jul 2021 17:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232204AbhGFPHq (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 6 Jul 2021 11:07:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31556 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232141AbhGFPHp (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 6 Jul 2021 11:07:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625583906;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q2uDQFfbEEnoXVD07oyEydX792HJ7X0nk2qGNk3vVko=;
        b=D+petRB6xkrXH+aaM6rFHKs3l7qUlJJG+l6n6SeLDaMZKqqsQOLGJPVNgLD9Cbf1p6FaUe
        aLtrZ+HASyMj8QuFdNaQ8kCZcSpd5dvzcxerYI9CLq97xsL69SqIdML/ZVx+MdrMJqV/2B
        8m7/adaFR+AZ1Tkk4UGQQDz0u1rBRHI=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-419-Rd8rdxD0Nn-B1v_Z0id1vA-1; Tue, 06 Jul 2021 11:05:03 -0400
X-MC-Unique: Rd8rdxD0Nn-B1v_Z0id1vA-1
Received: by mail-ed1-f69.google.com with SMTP id i19-20020a05640200d3b02903948b71f25cso10947704edu.4
        for <linux-hyperv@vger.kernel.org>; Tue, 06 Jul 2021 08:05:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=q2uDQFfbEEnoXVD07oyEydX792HJ7X0nk2qGNk3vVko=;
        b=NIWgMhCrSHI3mouG6jJkcLlOkMY4zcln7RX7DmHeVA6HZf3GkRkHChZ5MUnZrJtmDs
         zr4rggnVYtbzJV2/+aFhZ5FOlxzQs/P9++pTsuJR8OPiRwK9zAHVNWvN119Rog0YE6cX
         sX9QnEcHreva6LiNs0VqPjHmSKcAhEeD/s8Ss++x8aMmOTWwMabKGm8wsFr/a244CDh/
         uiz8Ok1+2x8kYrQSPMOmTDb5U6Q9O5YxeTAqisxqAm48y58+A8JNyMtL4gxTIvdIaVBD
         v8ImWBbNtqPKhpx2EZBj4Jr1o/t++qKf0YgMy+i123GULevtGFzj+uDL7/H120PQ4WD/
         PCvg==
X-Gm-Message-State: AOAM530ENKg7JO2ulVwZ78GLOuqPiyGc7pfgMKrisCGMbkEKbPY0LyLU
        BWGZGiY2vaxys5J1ncVAvYJZPOhDGwlTD/CUwEjZlc+TO9eA9fpavudL5QQfu33kThuYz1kmqwl
        OGXbTX6UzsiD7RrtMM7pywS0s
X-Received: by 2002:a50:f0cf:: with SMTP id a15mr23385502edm.347.1625583901924;
        Tue, 06 Jul 2021 08:05:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx4JZdaoLVBIs59oV7XxVix+8w+NQtA7nL8i3Dt7I2MXGAg2Ez37F+DmFIWNBHLnqqCa/+jJQ==
X-Received: by 2002:a50:f0cf:: with SMTP id a15mr23385458edm.347.1625583901736;
        Tue, 06 Jul 2021 08:05:01 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id n11sm6026214ejg.43.2021.07.06.08.05.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jul 2021 08:05:01 -0700 (PDT)
Subject: Re: [PATCH v4 0/4] Add support for XMM fast hypercalls
To:     Siddharth Chandrasekaran <sidcha@amazon.de>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Siddharth Chandrasekaran <sidcha.dev@gmail.com>,
        Alexander Graf <graf@amazon.com>,
        Evgeny Iakovlev <eyakovl@amazon.de>,
        Liran Alon <liran@amazon.com>,
        Ioannis Aslanidis <iaslan@amazon.de>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
References: <cover.1622019133.git.sidcha@amazon.de>
 <20210630115559.GA32360@u366d62d47e3651.ant.amazon.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f318fd42-6b98-1a82-f334-d05f4e6cb715@redhat.com>
Date:   Tue, 6 Jul 2021 17:04:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210630115559.GA32360@u366d62d47e3651.ant.amazon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 30/06/21 13:56, Siddharth Chandrasekaran wrote:
> On Wed, May 26, 2021 at 10:56:07AM +0200, Siddharth Chandrasekaran wrote:
>> Hyper-V supports the use of XMM registers to perform fast hypercalls.
>> This allows guests to take advantage of the improved performance of the
>> fast hypercall interface even though a hypercall may require more than
>> (the current maximum of) two general purpose registers.
>>
>> The XMM fast hypercall interface uses an additional six XMM registers
>> (XMM0 to XMM5) to allow the caller to pass an input parameter block of
>> up to 112 bytes. Hyper-V can also return data back to the guest in the
>> remaining XMM registers that are not used by the current hypercall.
>>
>> Although the Hyper-v TLFS mentions that a guest cannot use this feature
>> unless the hypervisor advertises support for it, some hypercalls which
>> we plan on upstreaming in future uses them anyway. This patchset adds
>> necessary infrastructure for handling input/output via XMM registers and
>> patches kvm_hv_flush_tlb() to use xmm input arguments.
> 
> Hi Paolo,
> 
> Are you expecting more reviews on these patches?

They are part of 5.14 already. :)

Paolo

