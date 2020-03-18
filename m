Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAF15189E17
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Mar 2020 15:42:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbgCROmD (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 18 Mar 2020 10:42:03 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:53382 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726680AbgCROmD (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 18 Mar 2020 10:42:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584542521;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T7kBegBwWcEdb3wj4I7SyRaROqMrOxZ30lybsvlhbDs=;
        b=h8UR69SXKDY4t+rFDD7bmkVsh1Bp7zssvFRFRVUDCpa2fZ2ADZNoSUZ6pzFVy3SFL3fRUG
        0hJgIJOlP+f0MN3Pa+Xtyos/3R7DbfQo1OKG/XZKqJcZfFmXq6zXa1KPIlmU2TvMSSbFYH
        9R6RUicaKCDY5t9XxuLqcHPzeRHu5P4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-362-pO2FWBMJMNunXEjOqVSYpA-1; Wed, 18 Mar 2020 10:42:00 -0400
X-MC-Unique: pO2FWBMJMNunXEjOqVSYpA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B7D2BA1361;
        Wed, 18 Mar 2020 14:41:57 +0000 (UTC)
Received: from localhost (ovpn-12-66.pek2.redhat.com [10.72.12.66])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6FBE160BFB;
        Wed, 18 Mar 2020 14:41:48 +0000 (UTC)
Date:   Wed, 18 Mar 2020 22:41:46 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        linux-hyperv@vger.kernel.org,
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
        Oscar Salvador <osalvador@suse.de>,
        Paul Mackerras <paulus@samba.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Wei Yang <richard.weiyang@gmail.com>
Subject: Re: [PATCH v2 0/8] mm/memory_hotplug: allow to specify a default
 online_type
Message-ID: <20200318144146.GE30899@MiWiFi-R3L-srv>
References: <20200317104942.11178-1-david@redhat.com>
 <20200318130517.GC30899@MiWiFi-R3L-srv>
 <20200318135408.GP21362@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200318135408.GP21362@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 03/18/20 at 02:54pm, Michal Hocko wrote:
> On Wed 18-03-20 21:05:17, Baoquan He wrote:
> > On 03/17/20 at 11:49am, David Hildenbrand wrote:
> > > Distributions nowadays use udev rules ([1] [2]) to specify if and
> > > how to online hotplugged memory. The rules seem to get more complex with
> > > many special cases. Due to the various special cases,
> > > CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE cannot be used. All memory hotplug
> > > is handled via udev rules.
> > > 
> > > Everytime we hotplug memory, the udev rule will come to the same
> > > conclusion. Especially Hyper-V (but also soon virtio-mem) add a lot of
> > > memory in separate memory blocks and wait for memory to get onlined by user
> > > space before continuing to add more memory blocks (to not add memory faster
> > > than it is getting onlined). This of course slows down the whole memory
> > > hotplug process.
> > > 
> > > To make the job of distributions easier and to avoid udev rules that get
> > > more and more complicated, let's extend the mechanism provided by
> > > - /sys/devices/system/memory/auto_online_blocks
> > > - "memhp_default_state=" on the kernel cmdline
> > > to be able to specify also "online_movable" as well as "online_kernel"
> > 
> > This patch series looks good, thanks. Since Andrew has merged it to -mm again,
> > I won't add my Reviewed-by to bother. 
> 
> JFYI, Andrew usually adds R-b or A-b tags as they are posted.

Got it, thanks for telling.

