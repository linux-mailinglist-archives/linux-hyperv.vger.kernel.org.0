Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4F818CB09
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Mar 2020 11:01:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbgCTKBy (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 20 Mar 2020 06:01:54 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:32589 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726527AbgCTKBy (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 20 Mar 2020 06:01:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584698512;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WzV2FN2ok/NhA5NWpOHsyZ7D0zfIBp3v9eJJSSNVJkQ=;
        b=eZuhTeEUg5bO32eOh0h4hOQPVdKJG9Dl4rsG7pfnHhpS+V4El//N3QYsMN/HZO8ckg8HYY
        zy+sAX9fI1BS71H2CvGcMNnOV5sbHwfMlIBK0Ov7/WscicK1fEY8/RyuZyoVyQBZI1dAy2
        M9T3FKPOVGoDLBxdXEHkjk4bXkdtn6s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-333-w0dPq5DaN-2l2TxvoiClSQ-1; Fri, 20 Mar 2020 06:01:49 -0400
X-MC-Unique: w0dPq5DaN-2l2TxvoiClSQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0130418B5F78;
        Fri, 20 Mar 2020 10:01:33 +0000 (UTC)
Received: from localhost (ovpn-13-97.pek2.redhat.com [10.72.13.97])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 83DD396F92;
        Fri, 20 Mar 2020 10:01:30 +0000 (UTC)
Date:   Fri, 20 Mar 2020 18:01:27 +0800
From:   Baoquan He <bhe@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, linux-hyperv@vger.kernel.org,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Yumei Huang <yuhuang@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Eduardo Habkost <ehabkost@redhat.com>,
        Milan Zamazal <mzamazal@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Hocko <mhocko@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Paul Mackerras <paulus@samba.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Wei Yang <richard.weiyang@gmail.com>
Subject: Re: [PATCH v3 0/8] mm/memory_hotplug: allow to specify a default
 online_type
Message-ID: <20200320100127.GG2987@MiWiFi-R3L-srv>
References: <20200319131221.14044-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200319131221.14044-1-david@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 03/19/20 at 02:12pm, David Hildenbrand wrote:
> Distributions nowadays use udev rules ([1] [2]) to specify if and
> how to online hotplugged memory. The rules seem to get more complex with
> many special cases. Due to the various special cases,
> CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE cannot be used. All memory hotplug
> is handled via udev rules.
> 
> Everytime we hotplug memory, the udev rule will come to the same
> conclusion. Especially Hyper-V (but also soon virtio-mem) add a lot of
> memory in separate memory blocks and wait for memory to get onlined by user
> space before continuing to add more memory blocks (to not add memory faster
> than it is getting onlined). This of course slows down the whole memory
> hotplug process.
> 
> To make the job of distributions easier and to avoid udev rules that get
> more and more complicated, let's extend the mechanism provided by
> - /sys/devices/system/memory/auto_online_blocks
> - "memhp_default_state=" on the kernel cmdline
> to be able to specify also "online_movable" as well as "online_kernel"
> 
> v2 -> v3:
> - "hv_balloon: don't check for memhp_auto_online manually"
> -- init_completion() before register_memory_notifier()
> - Minor typo fix
> 
> v1 -> v2:
> - Tweaked some patch descriptions
> - Added
> -- "powernv/memtrace: always online added memory blocks"
> -- "hv_balloon: don't check for memhp_auto_online manually"
> -- "mm/memory_hotplug: unexport memhp_auto_online"
> - "mm/memory_hotplug: convert memhp_auto_online to store an online_type"
> -- No longer touches hv/memtrace code

Ack the series.

Reviewed-by: Baoquan He <bhe@redhat.com>

