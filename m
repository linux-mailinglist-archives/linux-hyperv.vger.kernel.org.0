Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7371E358870
	for <lists+linux-hyperv@lfdr.de>; Thu,  8 Apr 2021 17:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232076AbhDHPa6 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 8 Apr 2021 11:30:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36450 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232066AbhDHPay (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 8 Apr 2021 11:30:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617895842;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f7y+qV1QX6itWVJvsPTpvv4qB/DYjHt3u6N1WcKj9Bg=;
        b=X2UjctatBVWt3/SBMJCPnREiC6wjgpH0SdxRoyN8hw0behg/yB7EruNokL2ldJAJn7367A
        ZMWk7wziHb/SpQwRORbRc1AXo2/6RnjKpI/XmibKWpIO8Qfg9JUQHEw/5abVlbv73CaK7B
        aYrWFE2MCYTGNAP3K74LgmXrVSa8y9s=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-237-W1mGWSx0NnGaDuR6mha7VA-1; Thu, 08 Apr 2021 11:30:40 -0400
X-MC-Unique: W1mGWSx0NnGaDuR6mha7VA-1
Received: by mail-ej1-f70.google.com with SMTP id bn26so1017499ejb.20
        for <linux-hyperv@vger.kernel.org>; Thu, 08 Apr 2021 08:30:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=f7y+qV1QX6itWVJvsPTpvv4qB/DYjHt3u6N1WcKj9Bg=;
        b=UN7M5ZKtUn+Jq2mfz6Yz6V5dSJe9Mj6HHP6M3CdUVeq8+m8yS3R+5/m7WbO6rGknhj
         eesHzDwjBi1RimYbVZFXsKXdaxA/dr33rh4uum0nuDhrI+OhjqDVBy1IdVhpMTFQIbIQ
         8yKKlfZ0tfQ1day71DvlWGkOLbT0OYdoCfZ2aVbITRoMHQfjYoSUR6Ey6cbfedwUFyVc
         KS+hi8QAPhZI026JfBoBK8upnfoxmL2WjHQGlEiVJSjSsNvUe8kXiUIAhwEENjicqbza
         bmInEUxnefpr1qpASrRN+fkoKcR3kUcN96PqDz+Cc+eR7OVnVYgPocTP3RXMNCskdsG3
         UKuQ==
X-Gm-Message-State: AOAM53166XuMqyzexOkp7Hkao69j1mSPZFaShogqqAST8CBGjYzuHzWW
        Gkek7iIAO+Bg3UPogn30TQCr2SNeDOjzHe4QoMd04FLWSg3chfBhuGmm/BcYpd2lw4v54dBGcjb
        IZ3fmaC9ItrCvbk4Jxm2CHKr/
X-Received: by 2002:a17:906:f2c4:: with SMTP id gz4mr11221023ejb.369.1617895835503;
        Thu, 08 Apr 2021 08:30:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw0Y3dI6nxcGhLpQ0Wo61Aeoqztdw5kKwf3X3+bdymlXu5DaOTJRHYyc2lp0yIFxYtWUBsSww==
X-Received: by 2002:a17:906:f2c4:: with SMTP id gz4mr11220328ejb.369.1617895829796;
        Thu, 08 Apr 2021 08:30:29 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.gmail.com with ESMTPSA id h23sm6317924ejd.103.2021.04.08.08.30.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Apr 2021 08:30:28 -0700 (PDT)
Subject: Re: [PATCH 0/4] Add support for XMM fast hypercalls
To:     Wei Liu <wei.liu@kernel.org>,
        Siddharth Chandrasekaran <sidcha@amazon.de>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, seanjc@google.com, vkuznets@redhat.com,
        wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org,
        graf@amazon.com, eyakovl@amazon.de, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <20210407212926.3016-1-sidcha@amazon.de>
 <20210408152817.k4d4hjdqu7hsjllo@liuwe-devbox-debian-v2>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <033e7d77-d640-2c12-4918-da6b5b7f4e21@redhat.com>
Date:   Thu, 8 Apr 2021 17:30:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210408152817.k4d4hjdqu7hsjllo@liuwe-devbox-debian-v2>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 08/04/21 17:28, Wei Liu wrote:
>> Although the Hyper-v TLFS mentions that a guest cannot use this feature
>> unless the hypervisor advertises support for it, some hypercalls which
>> we plan on upstreaming in future uses them anyway.
>
> No, please don't do this. Check the feature bit(s) before you issue
> hypercalls which rely on the extended interface.

Perhaps Siddharth should clarify this, but I read it as Hyper-V being 
buggy and using XMM arguments unconditionally.

Paolo

