Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 772ACB276F
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Sep 2019 23:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731276AbfIMVoY (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 13 Sep 2019 17:44:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37804 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730990AbfIMVoX (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 13 Sep 2019 17:44:23 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 271317F75E;
        Fri, 13 Sep 2019 21:44:23 +0000 (UTC)
Received: from [10.36.116.16] (ovpn-116-16.ams2.redhat.com [10.36.116.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 700B95D712;
        Fri, 13 Sep 2019 21:44:21 +0000 (UTC)
Subject: Re: [PATCH] hv_balloon: Add the support of hibernation
To:     Dexuan Cui <decui@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
References: <1568245010-66879-1-git-send-email-decui@microsoft.com>
 <42de5835-8faa-2047-0f77-db51dd57b036@redhat.com>
 <PU1P153MB0169E922DF7A5A43C7026D82BFB00@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <7d218fd5-76d9-f5fa-548a-76fe5dfab230@redhat.com>
 <PU1P153MB01691EC455AAF37BC6AF26DDBFB30@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
From:   David Hildenbrand <david@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <ef6f8554-8324-a4d8-4549-759495e482b7@redhat.com>
Date:   Fri, 13 Sep 2019 23:44:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <PU1P153MB01691EC455AAF37BC6AF26DDBFB30@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.71]); Fri, 13 Sep 2019 21:44:23 +0000 (UTC)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 13.09.19 22:54, Dexuan Cui wrote:
>> From: David Hildenbrand <david@redhat.com>
>> Sent: Friday, September 13, 2019 12:46 AM
>>
>> On 12.09.19 21:18, Dexuan Cui wrote:
>>> 3. Hibernation can be especially useful when we pass through a PCIe device,
>>> e.g. a NIC, a NVMe controller or a GPU, to the VM, as usually save/restore
>>> and live migration can not work with this kind of configuration, because
>>> usually the host doesn't know how to save/restore the state of the PCIe
>>> device.
>>
>> Interesting. Under QEMU/KVM (especially for migration), the discussed
>> solutions I am aware of rather wanted to temporarily unplug the PCI
>> devices or replace them with some kind of "standby" device temporarily.
> 
> For the complex devices like a modern GPU, there may not be an 
> equivalent "standby" software-emulated device for it, and unplugging the
> PCI device temporarily is not good, as it may not be transparent to the
> userspace applications. Hibernation here is especially useful, e.g. to Virtual
> Desktop Infrastructure users whose VMs can own physical GPUs, because
> all the userspace applications are frozen when the VM is hibernated, and
> when the VM resumes back, the applications are automatically resumed 
> and continue to run seamlessly, at least in theory. A hibernated VM saves
> compute resources and cost for the users.

Yes, I can see how GPUs might be problematic, especially for desktop
infrastructures (and maybe especially when running specific guest
operating systems :) ). Thanks for the explanation.

[...]

> On recent Windows Server 2019+ hosts, the toolstacks on the hosts
> guarantees that Dynamic Memory and Memory Resizing can not be enabled
> if the virtual ACPI S4 state is enabled, and vice versa. Please refer to the
> long write-up I made here: https://lkml.org/lkml/2019/9/5/1160 .

Hah, so the patch here is not actually relevant for modern Hyper-V
installations. (I would have loved to read that in the patch description
- but maybe I missed that)

> 
> And, to make the hibernation functionality automated, the host is able to
> send a "please hibernate" message to the VM via the Hyper-V shutdown
> device upon the user's request (e.g. via GUI or scripting): see 
> https://lkml.org/lkml/2019/9/13/811 . When the host sends the message,
> it checks if the virtual ACPI S4 state is enabled for the VM: if not, the host
> refuses to send the message. This means that the user does want to make
> sure the virtual ACPI S4 state is enabled for the VM, if the user of the VM
> wants to use the hibernation feature, and this means Dynamic Memory
> and Memory Resizing can not be active due to the restrictions from the 
> host toolstack.

Okay, *but* this is a current limitation. Just saying. If you could at
least support balloon inflate/deflate, that would be a clear win for
users. And less configuration knobs.

> 
> And the hibernation functionality won't be officially supported on old
> Windows Server hosts.
> 
> So, IMHO we can't be bother to implement the idea you described in
> detail. Sorry. :-)

No worries, I neither develop for, use or work with Hyper-V. I was just
reading along and wondering why you basically make the hv_balloon
unusable in these environments. (initially I thought, "why don't you
just disallow probing the device completely")

I am aware of the (hypervisor) issues of hibernation/suspend when it
comes to balloon drivers / memory hot(un)plug. (currently working on
virtio-mem myself and initially decided to block any
hibernation/suspension attempts in case the driver is loaded and memory
was plugged/unplugged)

> 
> And, while I agree your idea is good, technically speaking I suspect it may
> not be really useful, because once hv_balloon allows balloon-up/down,
> hv_balloon effectively loses control of memory pages: after the host
> takes some memory away, the VM never knows when exactly the
> host will give it back -- actually the host never guarantees how soon
> it will give the memory back. Consequently, the VM almost immediately
> ends up in an un-hibernatable state...
If you go via the host, you might be able to make sure to request to
deflate the balloon before you try to hibernate, and inflate again when
back up. You might even ask the user for permissions. Of course, once
you deflated the balloon, it might not be guaranteed to inflate the
balloon to the original size. But after all, it's "dynamic memory", so
it might even be what the name suggests. It could be very well
controlled from the host.

If you go via the guest, you would first have to tell your hypervisor
"please allow me to deflate so I can hibernate", or something like that.
After hibernation (or some time X), the host might then decide to
inflate again.

E.g., take a look at virtio-balloon. When suspending, it simply deflates
(without asking ...), to inflate again when resuming. Not saying that's
the best approach (it's not :) ), but one approach to at least make it work.

Anyhow, just some comments from my side :) I can see how Windows Server
worked around that issue right now by just XOR'ing both features.

> 
> Thanks,
> -- Dexuan
> 


-- 

Thanks,

David / dhildenb
