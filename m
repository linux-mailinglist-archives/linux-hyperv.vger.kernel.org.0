Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97E701E7B69
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 May 2020 13:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725971AbgE2LNR (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 29 May 2020 07:13:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36691 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725681AbgE2LNQ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 29 May 2020 07:13:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590750795;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k3AfmsRT0TiIWR7m+9uIgkkFYc4AqBIq+Eofk3eZmvk=;
        b=J1VZZMPENFGU0+7E2txoMPVKSPiBWkfhA2E+YSmf0NpgY91eR3gpgE6PEDn2FnyFHK7t4k
        Qzt720LXK+DGP5jsi6qZzzIHGAJeKbNbNpIYF1HQRF7eHxF02zfeI4ftjBf+1EqgGgp7IP
        W/SzqudKYFbfhA72oVg0/rDib1bN9w0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-215-4_K6rw-3OLCgwv-TECwi_A-1; Fri, 29 May 2020 07:13:12 -0400
X-MC-Unique: 4_K6rw-3OLCgwv-TECwi_A-1
Received: by mail-wm1-f69.google.com with SMTP id b65so551186wmb.5
        for <linux-hyperv@vger.kernel.org>; Fri, 29 May 2020 04:13:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=k3AfmsRT0TiIWR7m+9uIgkkFYc4AqBIq+Eofk3eZmvk=;
        b=EG4LBgYXoHHbboo4f63JC1B4irEkgrGn2bByREEsRoGFQtjN/TuWolNJjBF2I6K5Aw
         A/PNwerjTDvyoUfg8ukktSMfH4lRn8kq1fx0vuhoOWeh9FZHVpnHYkDcbLhMskCs3YOj
         dORv3b01JriNt7yz0xGXpM18WRICLeZmpg1mV02JkEWwfDZxRNeRG7mVV7Aqa3SJHwBB
         4oBILGrgTBghsJAGNckrH8PIg1ARjnDO3SLctDHkX5caJBHuY/b+6nGoY2LGQHsZYE6h
         9sK6U7GcHO/BvBf0mx7Owz15Vp1Ss/zJea1RImeD8gAXYoUEQ1Frqay3SebLgyYQlpAm
         41wA==
X-Gm-Message-State: AOAM533heFYMYI4Xu5u2H0WC0AvOuv54hxSlvpblEUJVliAuUhUfgnNi
        cXAL2x1PXAzezd71rqzg60BlC9Uums3rTEwUUd8l35Appr9n2ygQ/pJ+w+w18kieBP69en9gEpA
        Gd9UQgdLUkWz+b3ZzX+cPt0+2
X-Received: by 2002:adf:9f0b:: with SMTP id l11mr4003804wrf.66.1590750790967;
        Fri, 29 May 2020 04:13:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwDYEHrheOkcfEc2jUohO+GtONYKzeGu2Vjgv978rRE4MKHlxn9rxABO3lp12HN2dFuTClPmA==
X-Received: by 2002:adf:9f0b:: with SMTP id l11mr4003778wrf.66.1590750790711;
        Fri, 29 May 2020 04:13:10 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:b096:1b7:7695:e4f7? ([2001:b07:6468:f312:b096:1b7:7695:e4f7])
        by smtp.gmail.com with ESMTPSA id u130sm10768318wmg.32.2020.05.29.04.13.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2020 04:13:10 -0700 (PDT)
Subject: Re: [PATCH v11 2/7] x86/kvm/hyper-v: Simplify addition for custom
 cpuid leafs
To:     Jon Doron <arilou@gmail.com>, Roman Kagan <rvkagan@yandex-team.ru>,
        kvm@vger.kernel.org, linux-hyperv@vger.kernel.org,
        vkuznets@redhat.com
References: <20200424113746.3473563-1-arilou@gmail.com>
 <20200424113746.3473563-3-arilou@gmail.com>
 <20200513092404.GB29650@rvkaganb.lan> <20200513124915.GM2862@jondnuc>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <df0a2749-ea11-43bb-bf5a-1c37bd931389@redhat.com>
Date:   Fri, 29 May 2020 13:13:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200513124915.GM2862@jondnuc>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 13/05/20 14:49, Jon Doron wrote:
>>
> 
> To be honest from my understanding of the TLFS it states:
> "The maximum input value for hypervisor CPUID information."
> 
> So we should not expose stuff we wont "answer" to, I agree you can
> always issue CPUID to any leaf and you will get zeroes but if we try to
> follow TLFS it sounds like this needs to be capped here.

I think Roman is right in the reading, but it's also nicer to have a
capped EAX because you can just look at EAX and guess what features are
there (it's simpler than looking for zeroes).

Paolo

