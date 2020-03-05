Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A960E17AAC7
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Mar 2020 17:45:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725991AbgCEQpZ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 5 Mar 2020 11:45:25 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:26419 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726004AbgCEQpZ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 5 Mar 2020 11:45:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583426724;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ctNq4CCoaNBHGFzM1KPycpQ4JYOcWX3tmGXm2KQziW8=;
        b=ftA4Otd+w4thiQWFMnr+QVKAp5U8emMbdrxFELHRI+q2mWK3ybRbqXcv3sVcEjvIwXKoQR
        tXQsAbHBIRgbx68FEx+RmXvJSwiH0nrROCS+emvrUN92BVWd8qh5NfFL0xuBQxxwXcieDI
        G3qNYI3VhNDY9f28N1iJd3e3E0dHyL8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-172-JhQSio5nMGS9SZ_p0ZHHfA-1; Thu, 05 Mar 2020 11:45:23 -0500
X-MC-Unique: JhQSio5nMGS9SZ_p0ZHHfA-1
Received: by mail-wm1-f69.google.com with SMTP id d129so2307998wmd.2
        for <linux-hyperv@vger.kernel.org>; Thu, 05 Mar 2020 08:45:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ctNq4CCoaNBHGFzM1KPycpQ4JYOcWX3tmGXm2KQziW8=;
        b=NfNbsCMwi1fFEuHXnq1Ew7jlzV/H4XLbsRmhP9izqmZIFAmLIrOWbpz063ySjUPTn6
         QkB1zZREdbgGqy3P0+sHrilb1L8pVYYLLlxH5cADwvTbGSJh664hOgXJf8KRj9RSHvUR
         hn0T0m7viRUEPY1BIa+706It4Oej3WdH/zp9ODZhonDNStn8N3JTfwTGZh4/+EwkpfAz
         l/vZcpLErfSBwYf68d+Hl70YQVIm6n257RySltWpj6/7E3HZTgx5oS6Rl35ePSIBGYVE
         w7Oi59v7VkKcBsqdmiIxh/oLWG8tBVD9LX8ZFX8LuzGjcT01oBz8gQx9CXo0E9cm9a27
         n3Rg==
X-Gm-Message-State: ANhLgQ0V96LNAvdvP13d7BhO9R+rnKlAmJp+AXe3kUHuk33Q1f19tkVL
        27S8ydYq9MThK6kDezAKL/O8ivkJ6PEGo1XLmR8QshaoWYhfUOZQRKvTog9xdOEweeC31BjFzQP
        FngZUlFqbf7rJRAAzs9HwHYmO
X-Received: by 2002:a05:600c:4108:: with SMTP id j8mr10410538wmi.188.1583426720208;
        Thu, 05 Mar 2020 08:45:20 -0800 (PST)
X-Google-Smtp-Source: ADFU+vtqIAyf6ANiV/6hH7zyPHEAgMKe6UD6gdYRfrFD40jdUM+Pii4EnaD7zdAuV588Uc8uu6P6iQ==
X-Received: by 2002:a05:600c:4108:: with SMTP id j8mr10410494wmi.188.1583426719539;
        Thu, 05 Mar 2020 08:45:19 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:9def:34a0:b68d:9993? ([2001:b07:6468:f312:9def:34a0:b68d:9993])
        by smtp.gmail.com with ESMTPSA id m19sm9856625wmc.34.2020.03.05.08.45.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2020 08:45:18 -0800 (PST)
Subject: Re: [PATCH v2 1/4] x86/kvm/hyper-v: Align the hcall param for
 kvm_hyperv_exit
To:     Jon Doron <arilou@gmail.com>
Cc:     kvm@vger.kernel.org, linux-hyperv@vger.kernel.org,
        Vitaly Kuznetsov <vkuznets@redhat.com>
References: <20200305140142.413220-1-arilou@gmail.com>
 <20200305140142.413220-2-arilou@gmail.com>
 <09762184-9913-d334-0a33-b76d153bc371@redhat.com>
 <CAP7QCoj9=mZCWdiOa92QP9Fjb=p3DfKTs0xHKZYQ+yRiMabmLA@mail.gmail.com>
 <0edfee0e-01ee-bb62-5fc5-67d7d45ec192@redhat.com>
 <CAP7QCogGkC_wOPuuz2cZDb0aRv0GzMGDR2Y0voU8w4hdtO39BQ@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <bb520125-71e5-51b2-5477-164205656fb7@redhat.com>
Date:   Thu, 5 Mar 2020 17:45:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAP7QCogGkC_wOPuuz2cZDb0aRv0GzMGDR2Y0voU8w4hdtO39BQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 05/03/20 16:52, Jon Doron wrote:
> bah you are right sorry :( but if ill do that ill break userspace no?

No, you'd just be making the padding explicit.

Paolo

> 
> On Thu, Mar 5, 2020 at 5:30 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>> On 05/03/20 15:53, Jon Doron wrote:
>>> Vitaly recommended we will align the struct to 64bit...
>> Oh, then I think you actually should add a padding after "__u32 type;"
>> and "__u32 msr;" if you want to make it explicit.  The patch, as is, is
>> not aligning anything, hence my confusion.

