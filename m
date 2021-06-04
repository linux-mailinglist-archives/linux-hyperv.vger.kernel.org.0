Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A20539BC30
	for <lists+linux-hyperv@lfdr.de>; Fri,  4 Jun 2021 17:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbhFDPtB (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 4 Jun 2021 11:49:01 -0400
Received: from linux.microsoft.com ([13.77.154.182]:34238 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbhFDPtB (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 4 Jun 2021 11:49:01 -0400
Received: from [192.168.86.35] (c-73-38-52-84.hsd1.vt.comcast.net [73.38.52.84])
        by linux.microsoft.com (Postfix) with ESMTPSA id AE8E520B7178;
        Fri,  4 Jun 2021 08:47:13 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AE8E520B7178
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1622821635;
        bh=Ta7AVDVq80wxtJAhEMWvq0u4Gd9WlURarydMVI8XT1k=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=EvwSr33U36IyVGLo2CVg17brY69lpZrFsmUl6MgJ+yGjNKKMWS2uLcxj9J0FeLCtA
         JP4K36MdJ9ZcHXSVXw2eK5uSuCwqdCJ6lYnPC66W1FRf8UqbxqEbEG1vfI7nxVmDCf
         gNIn7BXiph6Hz0wJB+Qs0C71qlqG09i+yYUtgMP0=
Subject: Re: [bug report] Commit ccf953d8f3d6 ("fb_defio: Remove custom
 address_space_operations") breaks Hyper-V FB driver
To:     Wei Liu <wei.liu@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Kelley <mikelley@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>
References: <87v96tzujm.fsf@vitty.brq.redhat.com>
 <20210604130014.tkeozyn4wxdsr6o2@liuwe-devbox-debian-v2>
From:   Vineeth Pillai <viremana@linux.microsoft.com>
Message-ID: <e5c90203-df8c-1e72-f77d-41db4ff5413f@linux.microsoft.com>
Date:   Fri, 4 Jun 2021 11:47:13 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210604130014.tkeozyn4wxdsr6o2@liuwe-devbox-debian-v2>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org


On 6/4/2021 9:00 AM, Wei Liu wrote:
> On Fri, Jun 04, 2021 at 02:25:01PM +0200, Vitaly Kuznetsov wrote:
>> Hi,
>>
>> Commit ccf953d8f3d6 ("fb_defio: Remove custom address_space_operations")
>> seems to be breaking Hyper-V framebuffer
>> (drivers/video/fbdev/hyperv_fb.c) driver for me: Hyper-V guest boots
>> well and plymouth even works but when I try starting Gnome, virtual
>> screen just goes black. Reverting the above mentioned commit on top of
>> 5.13-rc4 saves the day. The behavior is 100% reproducible. I'm using
>> Gen2 guest runing on Hyper-V 2019. It was also reported that Gen1 guests
>> are equally broken.
>>
>> Is this something known?
>>
> I've heard a similar report from Vineeth but we didn't get to the bottom
> of this.
I have just tried reverting the commit mentioned above and it solves the 
GUI freeze
I was also seeing. Previously, login screen was just freezing, but VM 
was accessible
through ssh. With the above commit reverted, I can login to Gnome.

Looks like I am also experiencing the same bug mentioned here.

Thanks,
Vineeth

