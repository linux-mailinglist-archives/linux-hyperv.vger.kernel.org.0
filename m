Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12A4117A8DA
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Mar 2020 16:29:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbgCEP36 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 5 Mar 2020 10:29:58 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35429 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726243AbgCEP36 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 5 Mar 2020 10:29:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583422197;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SGKVvVBgOQqSZ9BJAtYl4BSq1YMkFsfS42RhbTqXmA4=;
        b=D7GmixDIwqjF3WdRNyDozHE8heJTBJPWAEaX9sdlR6NujTE6hEu8H8EZIzktMy44NwTBtg
        PTO/AvHGjMNF2G4RXarmja707DRJv/75IupfvOWgARLzyVsYZ4y5Xj9UBugv5YxwWiqSRA
        e1uniDWha6oVKSFh0cg1J63EulL7+9E=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-471-Z3TyJVGcP9-SERPFLn4vQw-1; Thu, 05 Mar 2020 10:29:55 -0500
X-MC-Unique: Z3TyJVGcP9-SERPFLn4vQw-1
Received: by mail-wr1-f70.google.com with SMTP id n12so2431985wrp.19
        for <linux-hyperv@vger.kernel.org>; Thu, 05 Mar 2020 07:29:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SGKVvVBgOQqSZ9BJAtYl4BSq1YMkFsfS42RhbTqXmA4=;
        b=BRWkc7DJf/t0VKrQWvsRh5c1HL4wdNtfq5nIILbBpTLXLHouCdXzJy1VMIPSS1U/fV
         kx6q1skaS3BZa7Z9QR3h+vAqV/kP2eLC/G7+ruQ7SIDvHUp+hMTX0jnTuzwOSn5aGtEJ
         dVUKlUst+S5D74AZzCyCpDujbC+83hzvQ4yoxk0x+ChM53qyojwMPWOpIqq+3R1XgZaS
         FtzQpAmTRocBW9DXnXgoBJAYWdzXvB+NDi+EPrg6qXnrIzgclggWdO7r9+E+cGCM4Eq/
         3fT1sR6jAb0ygndWNf99/z7QaUWYFqIr67hYjnMJUV9PYfC+CTzECyRHAHvcwNMRW9wa
         h6XQ==
X-Gm-Message-State: ANhLgQ32j3piNS2wKDZETtrr1cCWmxQZfhmP0pQC4Rw+UghRAC23ht5B
        oi8wg88CjFhivlb29FEzlZP7UXeTSOb8TeDkokA4+5FQg2NjnKIUBnfOLH3Dh335p9j1Hd3SbrI
        KOeYzMHwzUvhWbEJSEkoWCUu7
X-Received: by 2002:a7b:ce92:: with SMTP id q18mr10147345wmj.70.1583422194639;
        Thu, 05 Mar 2020 07:29:54 -0800 (PST)
X-Google-Smtp-Source: ADFU+vs3OaFqffNk8yPiF4xMhTmOX7NY4K4c1qWmVPq3edR/Xd9LAUoPPnRFIB7JVP4B1iZGX0Xnww==
X-Received: by 2002:a7b:ce92:: with SMTP id q18mr10147317wmj.70.1583422194261;
        Thu, 05 Mar 2020 07:29:54 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:9def:34a0:b68d:9993? ([2001:b07:6468:f312:9def:34a0:b68d:9993])
        by smtp.gmail.com with ESMTPSA id w16sm11143703wrp.8.2020.03.05.07.29.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2020 07:29:53 -0800 (PST)
Subject: Re: [PATCH v2 1/4] x86/kvm/hyper-v: Align the hcall param for
 kvm_hyperv_exit
To:     Jon Doron <arilou@gmail.com>
Cc:     kvm@vger.kernel.org, linux-hyperv@vger.kernel.org,
        Vitaly Kuznetsov <vkuznets@redhat.com>
References: <20200305140142.413220-1-arilou@gmail.com>
 <20200305140142.413220-2-arilou@gmail.com>
 <09762184-9913-d334-0a33-b76d153bc371@redhat.com>
 <CAP7QCoj9=mZCWdiOa92QP9Fjb=p3DfKTs0xHKZYQ+yRiMabmLA@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0edfee0e-01ee-bb62-5fc5-67d7d45ec192@redhat.com>
Date:   Thu, 5 Mar 2020 16:29:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAP7QCoj9=mZCWdiOa92QP9Fjb=p3DfKTs0xHKZYQ+yRiMabmLA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 05/03/20 15:53, Jon Doron wrote:
> Vitaly recommended we will align the struct to 64bit...

Oh, then I think you actually should add a padding after "__u32 type;"
and "__u32 msr;" if you want to make it explicit.  The patch, as is, is
not aligning anything, hence my confusion.

Thanks,

Paolo

> On Thu, Mar 5, 2020 at 4:24 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> On 05/03/20 15:01, Jon Doron wrote:
>>> Signed-off-by: Jon Doron <arilou@gmail.com>
>>> ---
>>>  include/uapi/linux/kvm.h | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
>>> index 4b95f9a31a2f..9b4d449f4d20 100644
>>> --- a/include/uapi/linux/kvm.h
>>> +++ b/include/uapi/linux/kvm.h
>>> @@ -200,6 +200,7 @@ struct kvm_hyperv_exit {
>>>                       __u64 input;
>>>                       __u64 result;
>>>                       __u64 params[2];
>>> +                     __u32 pad;
>>>               } hcall;
>>>       } u;
>>>  };
>>>
>>
>> Can you explain the purpose of this patch?
>>
>> Paolo
>>
> 

