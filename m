Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00EB41B24C0
	for <lists+linux-hyperv@lfdr.de>; Tue, 21 Apr 2020 13:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728391AbgDULQw (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 21 Apr 2020 07:16:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33908 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726018AbgDULQv (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 21 Apr 2020 07:16:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587467809;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=97DLxg4Yjg3km/mFNl5Zacv6VSLE1VXtqLZ5V4giXi0=;
        b=hB1KiTs3qBrvNn8DtVzJvdFpbht1EOEp7UioZOBUBdfg1X6nFHcE3CvdI6lLFYox1MbfTH
        eTSj5JYYHSbxQ/2Jeyhc1aunuTM0qLuF1d1J3qAIjQ7pACjlrALg6//33kCva2wpYmGvDi
        d2mRbut+sbK2/55atlInaomncF3uM+8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-221-5tdE4wqROgirujWu_hGwvg-1; Tue, 21 Apr 2020 07:16:44 -0400
X-MC-Unique: 5tdE4wqROgirujWu_hGwvg-1
Received: by mail-wr1-f70.google.com with SMTP id g7so6436596wrw.18
        for <linux-hyperv@vger.kernel.org>; Tue, 21 Apr 2020 04:16:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=97DLxg4Yjg3km/mFNl5Zacv6VSLE1VXtqLZ5V4giXi0=;
        b=Awmg3hzgAF99qdpZy0yg79qLwyzCiGYPmBcbIQrGwUwpUt/vlv5lAQlSoG6D8YfiKK
         4+DwQSoUwov/up1jLOq6nhE4rTJPARfF98Du6obVnk+SdLeDvtgrDRRv4lJYWmtG8NMY
         EPk50hGzmlLUT9o7/rMXSyCL4MUigqjIXqgVHQwPEdnIUTS82Yq9R291n88kY3ocu1Jd
         3YNm/B5efT+LmO4oyJ9qY9F2l/HlsGEmLku045PumRn6XYLzpYsN19NnVuVgXLeIRQtT
         nKkC2D9+ztj6IgynC/d5ON/dGUNvWuiAli3H6PrFpiVzQuIzH2WEWnl67aNR25wc6rfo
         cQ5w==
X-Gm-Message-State: AGi0PubaplHQPLDnIwVPcnbABAUhej38lW6oSyBgUKMDCYK6XKxeyEmS
        hHqD7KaUzhPy+tvN9Iqw+Wylxp4Ibzlb/kSmHSyfSiz42gXPL5fcghCPlEZ1jkOvVFcOWK9Hb8W
        FJi0PepbO4/MWH2hUTgYpfOqc
X-Received: by 2002:a5d:5652:: with SMTP id j18mr6767454wrw.40.1587467803537;
        Tue, 21 Apr 2020 04:16:43 -0700 (PDT)
X-Google-Smtp-Source: APiQypIM+q3J6iSnskRnURVF3g9hh9MdKKvxJisuR8ZZlbkBs6sJqC1TWZ4HVghfB2r6qghAm3/t8A==
X-Received: by 2002:a5d:5652:: with SMTP id j18mr6767417wrw.40.1587467803259;
        Tue, 21 Apr 2020 04:16:43 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:f43b:97b2:4c89:7446? ([2001:b07:6468:f312:f43b:97b2:4c89:7446])
        by smtp.gmail.com with ESMTPSA id t17sm3290485wro.2.2020.04.21.04.16.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2020 04:16:42 -0700 (PDT)
Subject: Re: [PATCH 1/4] KVM: x86: hyperv: Remove duplicate definitions of
 Reference TSC Page
To:     Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, sean.j.christopherson@intel.com,
        vkuznets@redhat.com, wanpengli@tencent.com, jmattson@google.com,
        joro@8bytes.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org
References: <20200420173838.24672-1-mikelley@microsoft.com>
 <20200420173838.24672-2-mikelley@microsoft.com>
 <20200421092925.rxb72yep4paruvi6@debian>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6c2bae31-14a8-39cf-6e6d-139d84146477@redhat.com>
Date:   Tue, 21 Apr 2020 13:16:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200421092925.rxb72yep4paruvi6@debian>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 21/04/20 11:29, Wei Liu wrote:
> On Mon, Apr 20, 2020 at 10:38:35AM -0700, Michael Kelley wrote:
>> The Hyper-V Reference TSC Page structure is defined twice. struct
>> ms_hyperv_tsc_page has padding out to a full 4 Kbyte page size. But
>> the padding is not needed because the declaration includes a union
>> with HV_HYP_PAGE_SIZE.  KVM uses the second definition, which is
>> struct _HV_REFERENCE_TSC_PAGE, because it does not have the padding.
>>
>> Fix the duplication by removing the padding from ms_hyperv_tsc_page.
>> Fix up the KVM code to use it. Remove the no longer used struct
>> _HV_REFERENCE_TSC_PAGE.
>>
>> There is no functional change.
>>
>> Signed-off-by: Michael Kelley <mikelley@microsoft.com>
>> ---
>>  arch/x86/include/asm/hyperv-tlfs.h | 8 --------
>>  arch/x86/include/asm/kvm_host.h    | 2 +-
>>  arch/x86/kvm/hyperv.c              | 4 ++--
> 
> Paolo, this patch touches KVM code. Let me know how you would like to
> handle this.

Just include it, I don't expect conflicts.

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

Paolo

