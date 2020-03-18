Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1C23189E46
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Mar 2020 15:50:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbgCROum (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 18 Mar 2020 10:50:42 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:53702 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726647AbgCROul (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 18 Mar 2020 10:50:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584543040;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Pg3T1YSkd/t+cEXO/Ncu3CZsj7y8ycoimX/LbjLT0SY=;
        b=KAEI0kAwVQ95hzTb+ABSyphQMQZKvE3RZMXtJ/iw9A7f1ZyhjK8SPFNzemdBoiJ7s3byeD
        HyvX4ShufC58CKymCVIEzSJZFfLQtj8/NoHdSDLJwygC/RYScBBm1G2vDlWRRGYq45CQHN
        +QxvfWVWqLkzJtuTl1Vumen8c/mlwAU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-Tzw0Wt77OHWjREzHnSG7Wg-1; Wed, 18 Mar 2020 10:50:37 -0400
X-MC-Unique: Tzw0Wt77OHWjREzHnSG7Wg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3833F1005512;
        Wed, 18 Mar 2020 14:50:34 +0000 (UTC)
Received: from localhost (ovpn-12-66.pek2.redhat.com [10.72.12.66])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3CF618F35B;
        Wed, 18 Mar 2020 14:50:30 +0000 (UTC)
Date:   Wed, 18 Mar 2020 22:50:26 +0800
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
Subject: Re: [PATCH v2 0/8] mm/memory_hotplug: allow to specify a default
 online_type
Message-ID: <20200318145026.GF30899@MiWiFi-R3L-srv>
References: <20200317104942.11178-1-david@redhat.com>
 <20200318130517.GC30899@MiWiFi-R3L-srv>
 <67a054f6-df07-e4fb-dd4b-e503cb767276@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67a054f6-df07-e4fb-dd4b-e503cb767276@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 03/18/20 at 02:50pm, David Hildenbrand wrote:
> On 18.03.20 14:05, Baoquan He wrote:
> > On 03/17/20 at 11:49am, David Hildenbrand wrote:
> >> Distributions nowadays use udev rules ([1] [2]) to specify if and
> >> how to online hotplugged memory. The rules seem to get more complex with
> >> many special cases. Due to the various special cases,
> >> CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE cannot be used. All memory hotplug
> >> is handled via udev rules.
> >>
> >> Everytime we hotplug memory, the udev rule will come to the same
> >> conclusion. Especially Hyper-V (but also soon virtio-mem) add a lot of
> >> memory in separate memory blocks and wait for memory to get onlined by user
> >> space before continuing to add more memory blocks (to not add memory faster
> >> than it is getting onlined). This of course slows down the whole memory
> >> hotplug process.
> >>
> >> To make the job of distributions easier and to avoid udev rules that get
> >> more and more complicated, let's extend the mechanism provided by
> >> - /sys/devices/system/memory/auto_online_blocks
> >> - "memhp_default_state=" on the kernel cmdline
> >> to be able to specify also "online_movable" as well as "online_kernel"
> > 
> > This patch series looks good, thanks. Since Andrew has merged it to -mm again,
> > I won't add my Reviewed-by to bother. 
> > 
> > Hi David, Vitaly
> > 
> > There are several things unclear to me.
> > 
> > So, these improved interfaces are used to alleviate the burden of the 
> > existing udev rules, or try to replace it? As you know, we have been
> 
> At least in RHEL, my plan is to replace it / use a udev rules as a
> fallback on older kernels (see the example scripts below). But other

Ok, got it. Didn't notice the script and the systemd service are your
part of plan, thought you are demonstrating the status. Thanks.

> distribution can handle it as they want.
> 
> > using udev rules to interact between kernel and user space on bare metal,
> > and guests who want to hot add/remove.>
> > And also the OOM issue in hyperV when onlining pages after adding memory
> > block. I am not a virt devel expert, could this happen on bare metal
> > system?
> 
> Don't think it's relevant on bare metal. If you plug a big DIMM, all
> memory blocks will be added first in one shot and then all memory blocks
> will be onlined. So it doesn't matter "how fast" you online that memory.
> 
> In contrast, Hyper-V (and virtio-mem) add one (or a limited number of)
> memory block at a time and wait for them to get onlined.
> 
> -- 
> Thanks,
> 
> David / dhildenb

