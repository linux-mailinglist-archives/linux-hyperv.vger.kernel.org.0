Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90683189C84
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Mar 2020 14:06:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbgCRNFx (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 18 Mar 2020 09:05:53 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:59946 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726821AbgCRNFx (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 18 Mar 2020 09:05:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584536751;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rEc/Fi0HtCRksr3RR+jEtjuBFNtDmtlrQKs7EcBkpIE=;
        b=eRScT9fvdjP8vE5amJ10n7xofE2dvOtPMkDlJgTWoDwlVCtMXN6Yju2EgxGXBniYDsWcgc
        hWOsbJt/DnDE0/IE7hQyJs7PHR09fhCWDtxa32nvVDmimGMXvNs1fHecEeQEiktKI6lYfD
        2Q+NrWTc1peU+A+1pwJY0QdwUxKdeBc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-319-Fx28kn8nP7-AcMX5JfSHgA-1; Wed, 18 Mar 2020 09:05:50 -0400
X-MC-Unique: Fx28kn8nP7-AcMX5JfSHgA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 61AF8107B7DD;
        Wed, 18 Mar 2020 13:05:46 +0000 (UTC)
Received: from localhost (ovpn-12-66.pek2.redhat.com [10.72.12.66])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 637AA67265;
        Wed, 18 Mar 2020 13:05:20 +0000 (UTC)
Date:   Wed, 18 Mar 2020 21:05:17 +0800
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
Message-ID: <20200318130517.GC30899@MiWiFi-R3L-srv>
References: <20200317104942.11178-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200317104942.11178-1-david@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 03/17/20 at 11:49am, David Hildenbrand wrote:
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

This patch series looks good, thanks. Since Andrew has merged it to -mm again,
I won't add my Reviewed-by to bother. 

Hi David, Vitaly

There are several things unclear to me.

So, these improved interfaces are used to alleviate the burden of the 
existing udev rules, or try to replace it? As you know, we have been
using udev rules to interact between kernel and user space on bare metal,
and guests who want to hot add/remove.

And also the OOM issue in hyperV when onlining pages after adding memory
block. I am not a virt devel expert, could this happen on bare metal
system?

Thanks
Baoquan

