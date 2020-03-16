Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBAC2186F0A
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Mar 2020 16:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731904AbgCPPtC (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 16 Mar 2020 11:49:02 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:48581 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731868AbgCPPtB (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 16 Mar 2020 11:49:01 -0400
X-Greylist: delayed 1910 seconds by postgrey-1.27 at vger.kernel.org; Mon, 16 Mar 2020 11:49:01 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584373740;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=aJCci1JpnVafZT1pCNJDWw/c8ajwNjmH5zsDBnK+wN4=;
        b=Up9+HPH8gfbKxHiKKnI0SDspHR4E7tv/ao/32Ti1Y/gFnDYDHZiBk97AVCAqrGLErPnH9F
        /gzHyDG8piyebHQLgh3cYgz47lM21NHRTBDU2HN5Y9YrjfaSzssornbaScGv1KtYq+eN4n
        hQ7q/vs7FswRr/9xGxqhbbCltOshjaA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-42-K1fzh2o9PiCg1bNXJzv67w-1; Mon, 16 Mar 2020 11:48:56 -0400
X-MC-Unique: K1fzh2o9PiCg1bNXJzv67w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7BEFB1196B20;
        Mon, 16 Mar 2020 15:48:39 +0000 (UTC)
Received: from [10.36.118.207] (ovpn-118-207.ams2.redhat.com [10.36.118.207])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4216E5DA7B;
        Mon, 16 Mar 2020 15:48:37 +0000 (UTC)
Subject: Re: [PATCH v1 5/5] mm/memory_hotplug: allow to specify a default
 online_type
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, linux-hyperv@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Baoquan He <bhe@redhat.com>,
        Wei Yang <richard.weiyang@gmail.com>
References: <20200311123026.16071-1-david@redhat.com>
 <20200311123026.16071-6-david@redhat.com>
 <20200316153131.GW11482@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat GmbH
Message-ID: <5ed312d3-bc2d-38da-166e-452ae3df9e81@redhat.com>
Date:   Mon, 16 Mar 2020 16:48:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200316153131.GW11482@dhcp22.suse.cz>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Content-Transfer-Encoding: quoted-printable
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 16.03.20 16:31, Michal Hocko wrote:
> On Wed 11-03-20 13:30:26, David Hildenbrand wrote:
>> For now, distributions implement advanced udev rules to essentially
>> - Don't online any hotplugged memory (s390x)
>> - Online all memory to ZONE_NORMAL (e.g., most virt environments like
>>   hyperv)
>> - Online all memory to ZONE_MOVABLE in case the zone imbalance is take=
n
>>   care of (e.g., bare metal, special virt environments)
>>
>> In summary: All memory is usually onlined the same way, however, the
>> kernel always has to ask userspace to come up with the same answer.
>> E.g., HyperV always waits for a memory block to get onlined before
>> continuing, otherwise it might end up adding memory faster than
>> hotplugging it, which can result in strange OOM situations.
>>
>> Let's allow to specify a default online_type, not just "online" and
>> "offline". This allows distributions to configure the default online_t=
ype
>> when booting up and be done with it.
>>
>> We can now specify "offline", "online", "online_movable" and
>> "online_kernel" via
>> - "memhp_default_state=3D" on the kernel cmdline
>> - /sys/devices/systemn/memory/auto_online_blocks
>> just like we are able to specify for a single memory block via
>> /sys/devices/systemn/memory/memoryX/state
>=20
> I still strongly believe that the whole interface is wrong. This is jus=
t
> adding more lipstick on the pig. On the other hand I recognize that the
> event based onlining is a PITA as well. The proper interface would
> somehow communicate the type of the memory via the event or other sysfs
> attribute and then the FW/HV could tell that this is an offline memory,
> hotplugable memory or just an additional memory that doesn't need to
> support hotremove by the consumer. The userspace or the kernel could
> handle the hotadd request much more easier that way.

Yeah, and I proposed patches like that which were not well received [1] [=
2].

But then, user space usually wants to online all memory the same way
right now. Also, HyperV and virtio-mem don't want to wait for onlining
to happen in user space, because it slows down the whole "add a hole
bunch of memory" process.

>=20
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Michal Hocko <mhocko@kernel.org>
>> Cc: Oscar Salvador <osalvador@suse.de>
>> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
>> Cc: Baoquan He <bhe@redhat.com>
>> Cc: Wei Yang <richard.weiyang@gmail.com>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>=20
> That being said, I will not object to this patch. I simply gave up
> fighting this interface. So if it works for consumers and it doesn't
> break the existing userspace (which is shouldn't AFAICS) then go ahead.

As it solves a real problem and makes the interface to auto online
usable, I don't think anything speaks against it.

Thanks!

[1] https://spinics.net/lists/linux-driver-devel/msg118337.html
[2]
https://www.mail-archive.com/xen-devel@lists.xenproject.org/msg32420.html

--=20
Thanks,

David / dhildenb

