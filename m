Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7383548382
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Jun 2022 11:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234457AbiFMJai (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 13 Jun 2022 05:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbiFMJai (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 13 Jun 2022 05:30:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F0DF51835F
        for <linux-hyperv@vger.kernel.org>; Mon, 13 Jun 2022 02:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655112636;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CxmwLRzBimA5rbS1J0tB8FxPcFX5Qex3a/zavVgSKZs=;
        b=akI1OeA1+Y7+ujB8jXeFes9pYtIskaxBcr+vIkuua/Laogpae26lVU1YJghfotkUsGWMl2
        FD/p1BD9TYgrSWXm6PUF1+sxoFazc+RROpr9+rw4sH/8R52HLcx5NKWs49PWl/RQxDoVDV
        mVSDzYhwsprGiKxDcukeCFqH0DCRrVY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-295-9jyd0-hSMNC-cmGpsudG2w-1; Mon, 13 Jun 2022 05:30:06 -0400
X-MC-Unique: 9jyd0-hSMNC-cmGpsudG2w-1
Received: by mail-wm1-f71.google.com with SMTP id k5-20020a05600c0b4500b003941ca130f9so2243843wmr.0
        for <linux-hyperv@vger.kernel.org>; Mon, 13 Jun 2022 02:30:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=CxmwLRzBimA5rbS1J0tB8FxPcFX5Qex3a/zavVgSKZs=;
        b=xSW6nwHABnqUHgNp0kUiyPVV41qiajO3R139Bqezx/OxSXagxJ67aZsphwDJHkkiu3
         uJMM4hy0g5ZD6rykoGjGLdDcyOIhQBwy+JOnzRNSWsaYFRs61uXA8aFx+rrO8ZxU4x+d
         mponXt7MPPtiJd3gkjSP+RSpfsi54IMJcb+jJsM6LVsLXNDnChESzJ1fcrou6OnPYw3c
         PFdGs4q8YyuizmeHx8Y8Q3hD+7HGEqhc+yCpmQH4s2sqLC9bkvPDFjs9GOkAxur2mGj0
         wdZgwpDnHh+1/5D4076f3QZcmNi9sXorHv7IYaleTo6/trYiABc8tq7xLq9/BRecQCqx
         FGWw==
X-Gm-Message-State: AOAM532aXIoFke7KVmJnibYoxlhF+4RA20vezOrRVEJL+d1G6Bz7RHVA
        +IR6SOAh8nJtcF/IBPhWUqnECBpqGGWb2FiL76RbwgV8r46qfTg0DaGjLi2gMmwLEpp0THeZTMl
        8DjTYkNH47PH2ZxuQlo4Ve9MM
X-Received: by 2002:a05:600c:3d99:b0:39c:55ba:ecc3 with SMTP id bi25-20020a05600c3d9900b0039c55baecc3mr13977582wmb.42.1655112596901;
        Mon, 13 Jun 2022 02:29:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz6fsf7q7uTH6of/nUiO+MSHXuX7TStfSortIVUfpzHT93MZMfdECqyfcTcLcznQ3AaQ4+q/Q==
X-Received: by 2002:a05:600c:3d99:b0:39c:55ba:ecc3 with SMTP id bi25-20020a05600c3d9900b0039c55baecc3mr13977557wmb.42.1655112596578;
        Mon, 13 Jun 2022 02:29:56 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:bd00:963c:5455:c10e:fa6f? (p200300cbc706bd00963c5455c10efa6f.dip0.t-ipconnect.de. [2003:cb:c706:bd00:963c:5455:c10e:fa6f])
        by smtp.gmail.com with ESMTPSA id bg30-20020a05600c3c9e00b0039c454067ddsm8796452wmb.15.2022.06.13.02.29.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jun 2022 02:29:56 -0700 (PDT)
Message-ID: <f9fefc32-3d62-b05d-ac3a-7114b13c82c6@redhat.com>
Date:   Mon, 13 Jun 2022 11:29:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: AW: hv_balloon: Only works in ubuntu
Content-Language: en-US
To:     Florian M?ller <max06.net@outlook.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        David Hildenbrand <dhildenb@redhat.com>
References: <DB3PR0602MB3674BB09316BB82B4116F27DFFA99@DB3PR0602MB3674.eurprd06.prod.outlook.com>
 <PH0PR21MB302513B8500C25CEADA56718D7A99@PH0PR21MB3025.namprd21.prod.outlook.com>
 <DB3PR0602MB3674E1BD958D00FC4B9124ADFFA99@DB3PR0602MB3674.eurprd06.prod.outlook.com>
 <PH0PR21MB30252F8660A16DE36206B0EBD7A99@PH0PR21MB3025.namprd21.prod.outlook.com>
 <DB3PR0602MB36740EE00B8BA3B897BCB7C0FFA99@DB3PR0602MB3674.eurprd06.prod.outlook.com>
 <BY3PR21MB3033FBB3CF2011B1D0DA2978D7AB9@BY3PR21MB3033.namprd21.prod.outlook.com>
 <87r13tj8ou.fsf@redhat.com>
 <DB3PR0602MB3674C185377647FDBBEEDDDCFFAB9@DB3PR0602MB3674.eurprd06.prod.outlook.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <DB3PR0602MB3674C185377647FDBBEEDDDCFFAB9@DB3PR0602MB3674.eurprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 13.06.22 10:53, Florian M?ller wrote:
>>>>>>>>
>>>>>>>> Issues showed up when I set up a Kali Linux Guest. I missed
>>>>>>>> the memory configuration before booting up the instance, so
>>>>>>>> it started with 1GB of memory, and ballooning active between
>>>>>>>> 512MB and several TB of memory. Hyper-V started to allocate
>>>>>>>> more and more memory to this guest since the reported memory
>>>>>>>> requirements also increased. The guest kernel didn't see any
>>>>>>>> of that allocated memory, as far as I can tell.
> 
> Please do not forget about this: (emoji-pointing-up)
> 
>>>>>
>>>>> Yes, that looks like a good solution.  I didn't remember that there
>>>>> is a kernel config option to automatically do the onlining.  With
>>>>> this kernel option enabled, using a udev rule obviously isn't
>>>>> needed.  The kernel option was added in Linux kernel version 4.7,
>>>>> which might be after the last time I looked at Hyper-V memory hot-add
>> in detail.
>>>>>
>>>>> Michael
>>>>>
>>>>
>>>> Awesome!
>>>>
>>>> Last question: Since not having the kernel option by default and also
>>>> not having the udev rule in some distributions causes the Hyper-V
>>>> host to eat up all the memory up to the defined limit (and to die
>>>> eventually), should this be considered as a bug? And if the answer is
>>>> no, how can I (or anyone) forward the requirement to the publishers to
>> be solved at the source?
>>>>
>>>> Thank you!
>>>>
>>>
>>> It's unclear whether this should be treated as a bug.  We certainly
>>> want the "right" thing to happen as seamlessly as possible, but there
>>> are tradeoffs.  Back when Vitaly Kuznetsov added
>>> CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE,
>>> I can see there was some debate about whether this option should be
>>> enabled by default. There was reluctance to do so because of potential
>>> backwards compatibility problems with other environments.  When
>>> hot-adding real physical memory to a bare-metal server, apparently you
>>> don't want to automatically online the added memory.
> 
> By bug I meant the effects on the hypervisor (see above). A guest without proper onlining of newly added memory is currently able to choke the host to standstill.

That's a hypervisor bug.


-- 
Thanks,

David / dhildenb

