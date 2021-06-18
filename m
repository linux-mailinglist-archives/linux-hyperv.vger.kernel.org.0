Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3563AD493
	for <lists+linux-hyperv@lfdr.de>; Fri, 18 Jun 2021 23:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234591AbhFRVvi (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 18 Jun 2021 17:51:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:34122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230338AbhFRVvi (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 18 Jun 2021 17:51:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4CD0E60FF4;
        Fri, 18 Jun 2021 21:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624052968;
        bh=5/rudTHymhS5/VkI6IvvQ85pgOE0dlvzeUnEKWNpFME=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=mp3O28Yx6lGIUqPBlRzqUcz3w3lYXgEkW+Fs5UqRIDqZNRVI4a3AooALQ3rJf4+lE
         dyTiRxyreslt8Wvu3O3GyV3YpgwQsZlqJnEPSacB2DbU1NIjaRMGOtrS893DPf+ZqV
         BEQ47w2nm9aQL2u3wM1MPZ9NE+mkuK8MG/BH5qzLrxwsA/gad7zUPBxlWzggilnxfy
         3rVSpHVWIzRtEt8AIGFz8ou3OpWhkAdNaFPrsMHaNEiKTv3yRkmnp3USfAgHtD1Ufj
         lL1mOFO0GjpMoBNLqrOMZ//cXA1ArNJle9f0NZQ+nloy2ORAV51ALozQPggohhOLqT
         cQBsJe72Z+Ifw==
Subject: Re: vmemmap alloc failure in hot_add_req()
To:     Michael Kelley <mikelley@microsoft.com>,
        David Hildenbrand <david@redhat.com>
Cc:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Hillf Danton <hdanton@sina.com>
References: <YMO+CoYnCgObRtOI@DESKTOP-1V8MEUQ.localdomain>
 <20210612021115.2136-1-hdanton@sina.com>
 <951ddbaf-3d74-7043-4866-3809ff991cfd@redhat.com>
 <d6a82778-024a-3a01-a081-dab6c8b54d62@kernel.org>
 <98cba3fa-f787-081f-b833-cfea3a124254@redhat.com>
 <MWHPR21MB159397B915AFE4EF1FEEF301D70D9@MWHPR21MB1593.namprd21.prod.outlook.com>
From:   Nathan Chancellor <nathan@kernel.org>
Message-ID: <ff7f3fd0-dfd9-25c8-ef01-8fe29d5af9f5@kernel.org>
Date:   Fri, 18 Jun 2021 14:49:22 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <MWHPR21MB159397B915AFE4EF1FEEF301D70D9@MWHPR21MB1593.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Michael,

On 6/17/2021 5:16 PM, Michael Kelley wrote:
> From: David Hildenbrand <david@redhat.com> Sent: Thursday, June 17, 2021 1:43 AM
>>
>>> It does look like this kernel configuration has
>>> CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE=y.
>>
>> Okay, so then it's most likely really more of an issue with fragmented
>> physical memory -- which is suboptimal but not a show blocker in your setup.
>>
>> (there are still cases where memory onlining can fail, especially with
>> kasan running, but these are rather corner cases)
>>
>>>
>>>> If it's not getting onlined, you easily sport after hotplug e.g., via
>>>> "lsmem" that there are quite some offline memory blocks.
>>>>
>>>> Note that x86_64 code will fallback from populating huge pages to
>>>> populating base pages for the vmemmap; this can happen easily when under
>>>> memory pressure.
>>>
>>> Not sure if it is relevant or not but this warning can show up within a
>>> minute of startup without me doing anything in particular.
>>
>> I remember that Hyper-V will start with a certain (configured) boot VM
>> memory size and once the guest is up and running, use memory stats of
>> the guest to decide whether to add (hotplug) or remove (balloon inflate)
>> memory from the VM.
>>
>> So this could just be Hyper-V trying to apply its heuristics.
> 
> Nathan --
> 
> Could you clarify if your VM is running in the context of the Windows
> Subsystem for Linux (WSL) v2 feature in Windows 10?  Or are you
> running a "traditional" VM created using the Hyper-V Manager UI
> or Powershell?

This is a traditional VM created using the Hyper-V Manager.

> If the latter, how do you have the memory configuration set up?  In
> the UI, first you can specify the RAM allocated to the VM.  Then
> separately, you can enable the "Dynamic Memory" feature, in which
> case you also specify a "Minimum RAM" and "Maximum RAM".  It
> looks like you must have the "Dynamic Memory" feature enabled
> since the original stack trace includes the hot_add_req() function
> from the hv_balloon driver.

That is correct. I believe Dynamic Memory is the default setting so I 
just left that as it was. The startup memory for this virtual machine is 
2GB as it is a lightweight Arch Linux Xfce4 configuration and aside from 
occasionally compiling software, it will just be sitting there because 
it is mainly there for testing kernels.

> The Dynamic Memory feature is generally used only when you
> need to allow Hyper-V to manage the allocation of physical memory
> across multiple VMs.  Dynamic Memory is essentially Hyper-V's way of
> allowing memory overcommit.  If you don't need that capability,
> turning off Dynamic Memory and just specifying the amount of
> memory you want to assign to the VM is the best course of action.

Ack. My workstation was occasionally memory constrained so I figured 
relying on the Dynamic Memory feature would make sense. I upgraded the 
amount of RAM that I had today so I will probably just end up disabling 
the Dynamic Memory feature and allocating the amount of memory up front.

> With Dynamic Memory enabled, you may have encountered a
> situation where the memory needs of the VM grew very quickly,
> and Hyper-V balloon driver got into a situation where it needed
> to allocate memory in order to add memory, and it couldn't.  If
> you want to continue to use the Dynamic Memory feature, then
> you probably need to increase the initial amount of RAM assigned
> to the VM (the "RAM" setting in the Hyper-V Manager UI).

I will keep that in mind and see if I can find a good number.

Thanks for the reply!

Cheers,
Nathan
