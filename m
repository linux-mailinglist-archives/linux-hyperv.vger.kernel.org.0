Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C88C63AAEFC
	for <lists+linux-hyperv@lfdr.de>; Thu, 17 Jun 2021 10:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbhFQIoo (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 17 Jun 2021 04:44:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54884 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229712AbhFQIon (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 17 Jun 2021 04:44:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623919356;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sS6kybXx9hY6peXNH5/f9ArBP3605EB1bdQQ5Et7bb4=;
        b=BH3ca2tvy7w+N2Q5cJSox6o2mSbzlby3hQ7JRc3+75fWwU0Qt7jmZAVg27erv6LV1kXQ0/
        x61Ugi5rkk9bmWjOZ+VEdTP3wXrqYLHMC7uLG8lvobH+WCoc9ceco4B83NfQyX38AL7Svw
        f8wCDDx3ofq4fBmQzcuiIFscHfhKxys=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-mFXshlsXNr-Iy_3Kesmr2w-1; Thu, 17 Jun 2021 04:42:34 -0400
X-MC-Unique: mFXshlsXNr-Iy_3Kesmr2w-1
Received: by mail-wm1-f72.google.com with SMTP id n21-20020a7bcbd50000b02901a2ee0826aeso1922153wmi.7
        for <linux-hyperv@vger.kernel.org>; Thu, 17 Jun 2021 01:42:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=sS6kybXx9hY6peXNH5/f9ArBP3605EB1bdQQ5Et7bb4=;
        b=iI5taWJV0Zd+1bDsgs+0tQvrbRqRQDVSL8kAR8aJGmA6SE8ln+DVvthjNFbtt6eCEv
         W6aqXsHmU+4AdXT4ri0V67IpadfvAjaIdC9zGr25M8FW7V8q9chJLKqm/Jvp7Z8yC5xN
         BB/1N307IA0rNBWNo4gWT2j5rekF+hEN5kmjHC2W2SwZPjj3lscjD+Mc2/SopTiQms22
         GHI/BkJZ2IJzB3sOnwRZxdR1MyWYEKoKjMkE/6o8NjgxkDCR1bUbwzFEjH3EPDmaWF9E
         gJ26btKdRsFgVbLp8VPsN1awne4x8PWv1PyMNGBIiV6F3sxDDX4beTYWvpydUJYijiKk
         27Qg==
X-Gm-Message-State: AOAM531QFY1TSNENmFP/N9kqIWkaq3UWDX/GfTpjHHaXjEUjDxcXfWzJ
        IAZH3USlAvtd04ZHV7Y5Je9Q8dCgPFkPnIoKe1R1NqjnAw2X3I5kfNsKJkdepE4FBAjUx9yGzGc
        GmMDkPiUgKvs/CLyn+WI8349+
X-Received: by 2002:a5d:6a41:: with SMTP id t1mr4339155wrw.113.1623919353703;
        Thu, 17 Jun 2021 01:42:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzgyAySce1qxN63jHG7zCIwNglZXJq5pK6V0M+5PBzfDOhc3A7qqxXGjPafRDi1waNvg3aeUg==
X-Received: by 2002:a5d:6a41:: with SMTP id t1mr4339135wrw.113.1623919353505;
        Thu, 17 Jun 2021 01:42:33 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6170.dip0.t-ipconnect.de. [91.12.97.112])
        by smtp.gmail.com with ESMTPSA id l10sm4681548wrv.82.2021.06.17.01.42.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jun 2021 01:42:33 -0700 (PDT)
Subject: Re: vmemmap alloc failure in hot_add_req()
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>,
        Hillf Danton <hdanton@sina.com>
References: <YMO+CoYnCgObRtOI@DESKTOP-1V8MEUQ.localdomain>
 <20210612021115.2136-1-hdanton@sina.com>
 <951ddbaf-3d74-7043-4866-3809ff991cfd@redhat.com>
 <d6a82778-024a-3a01-a081-dab6c8b54d62@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <98cba3fa-f787-081f-b833-cfea3a124254@redhat.com>
Date:   Thu, 17 Jun 2021 10:42:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <d6a82778-024a-3a01-a081-dab6c8b54d62@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> It does look like this kernel configuration has
> CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE=y.

Okay, so then it's most likely really more of an issue with fragmented 
physical memory -- which is suboptimal but not a show blocker in your setup.

(there are still cases where memory onlining can fail, especially with 
kasan running, but these are rather corner cases)

> 
>> If it's not getting onlined, you easily sport after hotplug e.g., via
>> "lsmem" that there are quite some offline memory blocks.
>>
>> Note that x86_64 code will fallback from populating huge pages to
>> populating base pages for the vmemmap; this can happen easily when under
>> memory pressure.
> 
> Not sure if it is relevant or not but this warning can show up within a
> minute of startup without me doing anything in particular.

I remember that Hyper-V will start with a certain (configured) boot VM 
memory size and once the guest is up and running, use memory stats of 
the guest to decide whether to add (hotplug) or remove (balloon inflate) 
memory from the VM.

So this could just be Hyper-V trying to apply its heuristics.

> 
>> If adding memory would fail completely, you'd see another "hot_add
>> memory failed error is ..." error message from hyper-v in the kernel
>> log. If that doesn't show up, it's simply suboptimal, but hotplugging
>> memory still succeeded.
> 
> I did notice that from the code in hv_balloon.c but I do not think I
> have ever seen that message in my logs.

Okay, so at least hotplugging memory is working.

-- 
Thanks,

David / dhildenb

