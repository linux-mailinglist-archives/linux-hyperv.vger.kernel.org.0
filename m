Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08D09189D61
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Mar 2020 14:54:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbgCRNyN (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 18 Mar 2020 09:54:13 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38543 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726857AbgCRNyN (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 18 Mar 2020 09:54:13 -0400
Received: by mail-wr1-f66.google.com with SMTP id s1so8784163wrv.5;
        Wed, 18 Mar 2020 06:54:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ngy8A2YvpuwSAkIHITqsxwhgr3uY9q04Wj+xXFxPERw=;
        b=Gg3QDTQV4FlHYnc95udwQauTpJ/ckkB2XPs61itNXcx4a+tvpKbYK4LxCQ6jJUWoGe
         L7kImEj9/DkmUI5PK48+z7DS0kicJqTaI2WU3I4GYFubkq5TEhIuHMPHewLOxB/gvQKI
         U0eTmyD+TmzK/dcRW6sIMZBvEu0bu39lAIfdbM8yh3iw61iuxMWN1GClWLW+aKVacOjL
         60VUDQ1o6a88H6QnhznSuKEopTL88wZdHu8W1jiwea9QF9ODJmwcrKGY20Qr/VQRkeGt
         5Rqi3VjI6+LFBZtacZDhJQrUjfyh+ky7fk3iXY+CAOIwIsC2aIbzegzYUVJVs7T3xYlQ
         gXVA==
X-Gm-Message-State: ANhLgQ25qXLsPEH7SE8IVhr86JVsKmSDMHs/tQ8jLGHBaDGEMi5LRZAr
        jvH8ZSBTUQv1mHnYXD5DZ+M=
X-Google-Smtp-Source: ADFU+vt7+qT3flEZeTSP4vvFvbKpC/QUOdsY3jrET0kgzQHel35UwsgLvygyXmij4VftsNdLAZApgw==
X-Received: by 2002:a05:6000:11d0:: with SMTP id i16mr5649369wrx.319.1584539651261;
        Wed, 18 Mar 2020 06:54:11 -0700 (PDT)
Received: from localhost (ip-37-188-180-89.eurotel.cz. [37.188.180.89])
        by smtp.gmail.com with ESMTPSA id n2sm1696410wro.25.2020.03.18.06.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 06:54:10 -0700 (PDT)
Date:   Wed, 18 Mar 2020 14:54:08 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Baoquan He <bhe@redhat.com>
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
Message-ID: <20200318135408.GP21362@dhcp22.suse.cz>
References: <20200317104942.11178-1-david@redhat.com>
 <20200318130517.GC30899@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200318130517.GC30899@MiWiFi-R3L-srv>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed 18-03-20 21:05:17, Baoquan He wrote:
> On 03/17/20 at 11:49am, David Hildenbrand wrote:
> > Distributions nowadays use udev rules ([1] [2]) to specify if and
> > how to online hotplugged memory. The rules seem to get more complex with
> > many special cases. Due to the various special cases,
> > CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE cannot be used. All memory hotplug
> > is handled via udev rules.
> > 
> > Everytime we hotplug memory, the udev rule will come to the same
> > conclusion. Especially Hyper-V (but also soon virtio-mem) add a lot of
> > memory in separate memory blocks and wait for memory to get onlined by user
> > space before continuing to add more memory blocks (to not add memory faster
> > than it is getting onlined). This of course slows down the whole memory
> > hotplug process.
> > 
> > To make the job of distributions easier and to avoid udev rules that get
> > more and more complicated, let's extend the mechanism provided by
> > - /sys/devices/system/memory/auto_online_blocks
> > - "memhp_default_state=" on the kernel cmdline
> > to be able to specify also "online_movable" as well as "online_kernel"
> 
> This patch series looks good, thanks. Since Andrew has merged it to -mm again,
> I won't add my Reviewed-by to bother. 

JFYI, Andrew usually adds R-b or A-b tags as they are posted.

-- 
Michal Hocko
SUSE Labs
