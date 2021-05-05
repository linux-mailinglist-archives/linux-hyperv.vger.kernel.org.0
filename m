Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED22F373C30
	for <lists+linux-hyperv@lfdr.de>; Wed,  5 May 2021 15:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233273AbhEENSy (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 5 May 2021 09:18:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44842 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233083AbhEENSy (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 5 May 2021 09:18:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620220677;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QtrXxKUiAvmqmB6yyp++vsOaAc/bZaOc4BH5ZWRKiJg=;
        b=cvmkcuvDFybGFr8kCaBP7OyAsXx6GxLLeEPPFx5NqvE90X4NXOnwJQjmYDYdIq0kYrXklr
        QcUvHGaBwQCrf5LkxWj9yRTcTfk4knbXHbYoPYhXCbQVANWAaDUenr/eHo3xPuqdXQ/jYi
        H/1vqS/UGo9c0KCb26PA4WwWvaOAE6k=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-540-kyIUA0MeN-i9ZMr1_jNuUw-1; Wed, 05 May 2021 09:17:56 -0400
X-MC-Unique: kyIUA0MeN-i9ZMr1_jNuUw-1
Received: by mail-wr1-f71.google.com with SMTP id 91-20020adf94640000b029010b019075afso682167wrq.17
        for <linux-hyperv@vger.kernel.org>; Wed, 05 May 2021 06:17:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=QtrXxKUiAvmqmB6yyp++vsOaAc/bZaOc4BH5ZWRKiJg=;
        b=mz7f3NA+3Jhs4vuGDQ7nhScISJdhABvwogezXPxXaBG1pirTKiKweEBrQSb91ru065
         S9YkV7HymyYCsy3G2HWwcWwQBgzfMALR1ReQkKiTkwyBb3HwCv5rFflD57mE8btrya9m
         Q2Vt8EGaOaCntheiVjL91/s4xu9CyDMG1bgERJbx2KtNoyiEY5dmVgYnvEXMsvoXwU6z
         XdoMAj2qMGvcL7eO2DRWzWsRWzpW15JNpw36/97TwldZN41gZSDKwFZNUJxPN9CaWZix
         T4vNz5nTq0On8zH3Sg6qLO+bntQK1UV+FUarKgYcgpc/2/DNTFHxNAcOBcHz7yZ9g/zn
         C8jw==
X-Gm-Message-State: AOAM533+fOq0vcHs8GPGdl0o6b9dq6gSnLWTsJtFhlWmr7iPs50zirzy
        DOM1nwU2ocJ2E1v1rgyfQrZ+Dh6CeIiD3XU98SM7qdkzNBHTjKK0khNnJHEQ1t+URFW28pz5RH4
        Psz5YhxhCkg4DcoKpTyXPJ3se
X-Received: by 2002:a7b:c74d:: with SMTP id w13mr32277694wmk.25.1620220674943;
        Wed, 05 May 2021 06:17:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJznzW0sfSsf6GMPNX1ppZVMk3nl9+IxB31SmKuXCFiIEFbzLjLS3W1tcOolWD10Wc36ulvXeg==
X-Received: by 2002:a7b:c74d:: with SMTP id w13mr32277671wmk.25.1620220674718;
        Wed, 05 May 2021 06:17:54 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c63bc.dip0.t-ipconnect.de. [91.12.99.188])
        by smtp.gmail.com with ESMTPSA id v13sm20005354wrt.65.2021.05.05.06.17.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 May 2021 06:17:54 -0700 (PDT)
Subject: Re: [PATCH v1 3/7] mm: rename and move page_is_poisoned()
To:     Michal Hocko <mhocko@suse.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Oscar Salvador <osalvador@suse.de>,
        Roman Gushchin <guro@fb.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Steven Price <steven.price@arm.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Aili Yao <yaoaili@kingsoft.com>, Jiri Bohac <jbohac@suse.cz>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-hyperv@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
References: <20210429122519.15183-1-david@redhat.com>
 <20210429122519.15183-4-david@redhat.com> <YJKZ5yXdl18m9YSM@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <0710d8d5-2608-aeed-10c7-50a272604d97@redhat.com>
Date:   Wed, 5 May 2021 15:17:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YJKZ5yXdl18m9YSM@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 05.05.21 15:13, Michal Hocko wrote:
> On Thu 29-04-21 14:25:15, David Hildenbrand wrote:
>> Commit d3378e86d182 ("mm/gup: check page posion status for coredump.")
>> introduced page_is_poisoned(), however, v5 [1] of the patch used
>> "page_is_hwpoison()" and something went wrong while upstreaming. Rename the
>> function and move it to page-flags.h, from where it can be used in other
>> -- kcore -- context.
>>
>> Move the comment to the place where it belongs and simplify.
>>
>> [1] https://lkml.kernel.org/r/20210322193318.377c9ce9@alex-virtual-machine
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
> 
> I do agree that being explicit about hwpoison is much better. Poisoned
> page can be also an unitialized one and I believe this is the reason why
> you are bringing that up.

I'm bringing it up because I want to reuse that function as state above :)

> 
> But you've made me look at d3378e86d182 and I am wondering whether this
> is really a valid patch. First of all it can leak a reference count
> AFAICS. Moreover it doesn't really fix anything because the page can be
> marked hwpoison right after the check is done. I do not think the race
> is feasible to be closed. So shouldn't we rather revert it?

I am not sure if we really care about races here that much here? I mean, 
essentially we are racing with HW breaking asynchronously. Just because 
we would be synchronizing with SetPageHWPoison() wouldn't mean we can 
stop HW from breaking.

Long story short, this should be good enough for the cases we actually 
can handle? What am I missing?

-- 
Thanks,

David / dhildenb

