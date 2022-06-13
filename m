Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89D6C548237
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Jun 2022 10:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239579AbiFMIrq (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 13 Jun 2022 04:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239678AbiFMIro (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 13 Jun 2022 04:47:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AAFB02608
        for <linux-hyperv@vger.kernel.org>; Mon, 13 Jun 2022 01:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655110061;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4v1yZgyO7LaLJcwizIcZ1MrmcRRZoh9Qo9lEGUC/XHk=;
        b=bPG8di8c7ygkfg4i5+LHTLeFrQS29e0oSU6qmz7kDD2+IxETilcA2By6zxvMiIp2LTqMYa
        djCM3ZExi5B+EpI7kkwFq3W2fQhIpVjFGUVbIGt8E1VnyLLnUUGqHYRQHSPLnXnlY9IqFS
        1XCPw540aK4shZlhG1/p7bbf+vOMpDg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-76-BcDvyzMQPEOogsEbRYjqfA-1; Mon, 13 Jun 2022 04:47:40 -0400
X-MC-Unique: BcDvyzMQPEOogsEbRYjqfA-1
Received: by mail-wm1-f69.google.com with SMTP id c125-20020a1c3583000000b003978decffedso5532782wma.5
        for <linux-hyperv@vger.kernel.org>; Mon, 13 Jun 2022 01:47:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=4v1yZgyO7LaLJcwizIcZ1MrmcRRZoh9Qo9lEGUC/XHk=;
        b=2H4YU9/fYA9mEbD6El7Z628mce1Rpqubov2r34lcZpJP7YVAk/G6k+DV+dmQ5xuFwZ
         WXcUjoT2FUzv7jE6rzdAsc9EmwNK41CGBYIYtrRkTS6I4l3xfKfdf9KDPcuDTp/OFnRG
         ggdxEhiG0diTbTGGWC564vp80Byj4IjFvUOgOVdCkK7l3azCewrRxwUwkFGVPpvsWwsB
         aRTk5qpxTDzgE7jvGHpr9KVWCNDc3pxDZhaL3XcSgZt4V5j8uderakizpTkSA2gzIgAs
         Xwjc8FJ5Pki+jIYFkNVEBA6eDTcKUBIyrHmkTDPCgTDzzIgbebxk02bek8xmm7aUssrP
         EEiw==
X-Gm-Message-State: AOAM531kAg4dk5QeBpzhVwh5WDw0mE8vwYDLUTpfHgJxsUzA7am48hk5
        xPNN/zYX4bO7eXRCLwAGDGdJ4PQHnge3p+1ePOxNEeU58BUeH4QFHjsqHbxY3UAlRxmzf80pKxF
        U36uDFnNTAU3jw+13P0SSHr2A
X-Received: by 2002:adf:ea87:0:b0:211:68d:7c93 with SMTP id s7-20020adfea87000000b00211068d7c93mr55033703wrm.412.1655110058791;
        Mon, 13 Jun 2022 01:47:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxSWiao+qtZ8beJ5y1gZjlkcIZQd5Vy0mepDsfPKgki6mWxdTdkZa9aEFn6A+T+gaC/iEyebQ==
X-Received: by 2002:adf:ea87:0:b0:211:68d:7c93 with SMTP id s7-20020adfea87000000b00211068d7c93mr55033682wrm.412.1655110058445;
        Mon, 13 Jun 2022 01:47:38 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:bd00:963c:5455:c10e:fa6f? (p200300cbc706bd00963c5455c10efa6f.dip0.t-ipconnect.de. [2003:cb:c706:bd00:963c:5455:c10e:fa6f])
        by smtp.gmail.com with ESMTPSA id z10-20020a05600c0a0a00b003974b95d897sm14490113wmp.37.2022.06.13.01.47.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jun 2022 01:47:37 -0700 (PDT)
Message-ID: <20d6d9bb-b443-6f23-48c8-4459c6438aef@redhat.com>
Date:   Mon, 13 Jun 2022 10:47:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        =?UTF-8?Q?Florian_M=c3=bcller?= <max06.net@outlook.com>
Cc:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        David Hildenbrand <dhildenb@redhat.com>
References: <DB3PR0602MB3674BB09316BB82B4116F27DFFA99@DB3PR0602MB3674.eurprd06.prod.outlook.com>
 <PH0PR21MB302513B8500C25CEADA56718D7A99@PH0PR21MB3025.namprd21.prod.outlook.com>
 <DB3PR0602MB3674E1BD958D00FC4B9124ADFFA99@DB3PR0602MB3674.eurprd06.prod.outlook.com>
 <PH0PR21MB30252F8660A16DE36206B0EBD7A99@PH0PR21MB3025.namprd21.prod.outlook.com>
 <DB3PR0602MB36740EE00B8BA3B897BCB7C0FFA99@DB3PR0602MB3674.eurprd06.prod.outlook.com>
 <BY3PR21MB3033FBB3CF2011B1D0DA2978D7AB9@BY3PR21MB3033.namprd21.prod.outlook.com>
 <87r13tj8ou.fsf@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: hv_balloon: Only works in ubuntu
In-Reply-To: <87r13tj8ou.fsf@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 13.06.22 09:58, Vitaly Kuznetsov wrote:
> "Michael Kelley (LINUX)" <mikelley@microsoft.com> writes:
> 
>> From: Florian Müller <max06.net@outlook.com> Sent: Saturday, June 11, 2022 12:45 PM
>>>
>>>>>>>
>>>>>>> Issues showed up when I set up a Kali Linux Guest. I missed the
>>>>>>> memory configuration before booting up the instance, so it started
>>>>>>> with 1GB of memory, and ballooning active between 512MB and
>>>>>>> several TB of memory. Hyper-V started to allocate more and more
>>>>>>> memory to this guest since the reported memory requirements also
>>>>>>> increased. The guest kernel didn't see any of that allocated memory, as 
>>>>>>> far as I can tell.
>>>>>>
>>>>>> Hot-adding new memory is done partially by the hv_balloon driver,
>>>>>> but it also requires user space action.  The user space action is provided
>>>>>> by udev rules.
>>>>>> In your Ubuntu Server 20.04 guest, there's a file
>>>>>> /lib/udev/rules.d/40-vm- hotadd.rules.
>>>>>> This file contains udev rules for hot-adding memory and CPUs.  You
>>>>>> should be able to copy this file with the udev rules onto your Kali
>>>>>> system, and then the memory hot-add should work correctly.
>>>>>>
>>>>>> I'm not sure why Kali doesn't already have such udev rules.  You
>>>>>> might grep through all the files in /lib/udev/rules.d and if there
>>>>>> are any rules for SUBSYSTEM==memory.
>>>>>> Sometimes there are rules present, but commented out.
>>>>>>
>>>>> Thanks, I'll check these ones out!
>>>>>
>>>>> In the meantime, I was able to get it working, by compiling a kernel
>>>>> with CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE=y
>>>>> Which was previously unset. It's enabled in ubuntu and it seems to
>>>>> make hv_balloon work properly.
>>>>> This seems to be the same case with Debian.
>>>>>
>>>>
>>>> Yes, that looks like a good solution.  I didn't remember that there is a kernel
>>>> config option to automatically do the onlining.  With this kernel option
>>>> enabled, using a udev rule obviously isn't needed.  The kernel option was
>>>> added in Linux kernel version 4.7, which might be after the last time I looked
>>>> at Hyper-V memory hot-add in detail.
>>>>
>>>> Michael
>>>>
>>>
>>> Awesome!
>>>
>>> Last question: Since not having the kernel option by default and also not having the
>>> udev rule in some distributions causes the Hyper-V host to eat up all the memory up to
>>> the defined limit (and to die eventually), should this be considered as a bug? And if the
>>> answer is no, how can I (or anyone) forward the requirement to the publishers to be
>>> solved at the source?
>>>
>>> Thank you!
>>>
>>
>> It's unclear whether this should be treated as a bug.  We certainly want the
>> "right" thing to happen as seamlessly as possible, but there are tradeoffs.  Back
>> when Vitaly Kuznetsov added CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE,
>> I can see there was some debate about whether this option should be enabled
>> by default. There was reluctance to do so because of potential backwards
>> compatibility problems with other environments.  When hot-adding real
>> physical memory to a bare-metal server, apparently you don't want to 
>> automatically online the added memory.
> 
> On x86/ARM you most likely do (as why plugging in memory in the first
> place?) but there are not many bare metal systems which allow that.

You actually do want to online in most cases, except, for example,
s390x. There might be weird cases with PFN-mapping offline memory into
VMs, but that is really a corner case when it comes to hotplugging memory.

However, "how" you want to online memory (normal/movable) depends on the
use case, the hotplug mechanism, and other factors (e.g., how much
memory will we hotplug, what are the system demands regarding
normal/movable memory, ...).

Hyperv-balloon just wants to online memory "normal", so not to
ZONE_MOVABLE. CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE should get the job done.

> 
> Note, there were some developments after I've added
> CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE, namely
> 
> commit 5f47adf762b78cae97de58d9ff01d2d44db09467
> Author: David Hildenbrand <david@redhat.com>
> Date:   Mon Apr 6 20:07:44 2020 -0700
> 
>     mm/memory_hotplug: allow to specify a default online_type
> 

I was working on a systemd unit to just configure memory onlining
semi-automatically, avoiding udev rules and to just configure
auto-onlining in the kernel during system boot.

Delaying memory onlining due to udev rules is a known issue when it
comes to hotplugging a lot of memory via hyperv balloon. We want kernel
to be onlined as fast as possible, directly when adding it in the kernel.

I currently don't have the capacity to work on the systemd unit, but the
latest version resides at:

https://github.com/davidhildenbrand/systemd/tree/memoryhotplugd

The idea is to let the unit figure out what might be best to do in the
detected environment. In addition, the admin can adjust the
configure/fine-tune handling without messing with udev rules, kernel
parameters or the sysfs.

>>
>> The Ubuntu image you were testing is specifically an image configured for use
>> in an Azure VM, so it makes sense to have memory automatically onlined by
>> the kernel.  So I looked at a generic Ubuntu 18.04 system, and it also has
>> this kernel option set by default.  But as another data point, RHEL/CentOS 8.4
>> does *not* have the kernel option set.  So each distro evidently makes their
>> own decision about this.  
> 
> Note: Fedora kernels come with CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE=y as
> well.

IIRC, even on s390x. It's different on RHEL, where we leave standby
memory under s390x offline via udev rules right now.

> 
>> But both generic Ubuntu 18.04 and RHEL/CentOS 8.4
>> have the udev rules.  The RHEL/CentOS 8.4 udev rule is more sophisticated
>> in that it does not online the added memory when running on System/390
>> and PowerPC.
> 
> I remember that with s390 we certainly don't want all memory to go
> online automatically because but I don't remember the reason :-)

The semantics of standby memory as you would find under z/VM and LPAR is
different: the admin is supposed to online it on demand; until then,
it's supposed to stay offline. Onlining will trigger actual backing of
the VM with additional memory, so some weird form of on-demand memory
hotplug.

> 
>>
>> I could envision changing the Linux kernel config rules to automatically set
>> CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE whenever 
>> CONFIG_HYPERV_BALLOON is selected. 
> 
> That could work for custom kernels but not for those shipped with
> distributions as these will always have CONFIG_HYPERV_BALLOON if
> Hyper-V is one of the supported targets (and it likely is).
> 

Yeah, that would be broken and nacked by me.

>> Alternatively, the Kali Linux folks could consider adding the
>> appropriate udev rule.
> 
> Or just enable CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE. We've enabled
> CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE in Fedora in 2016 and haven't heard
> many (any?) complaints (besides ppc64 where it was disabled) since.

The would work, most probably also for s390x. I assume most s390x users
that run these distros (fedora, kali,...) most probably don't care about
standby memory at all, meaning, not even having the option available in
their LPARs/VMs.


-- 
Thanks,

David / dhildenb

