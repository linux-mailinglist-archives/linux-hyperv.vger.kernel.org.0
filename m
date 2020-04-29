Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDDA61BE423
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Apr 2020 18:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgD2QmB (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 29 Apr 2020 12:42:01 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35340 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726493AbgD2QmA (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 29 Apr 2020 12:42:00 -0400
Received: by mail-wm1-f65.google.com with SMTP id r26so2765278wmh.0;
        Wed, 29 Apr 2020 09:41:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=b1NmnG+Bha+R6DCsicsXkjR18of0wt/SYtjmCqwDrqU=;
        b=PR+6NhRs7ma3EUG96L3i8LgOEy/NDjUnLNIwxK3li0CbGM8rXzGX+vp6eF78DZ/nSM
         QKKNjhEniYZCMrsVyoqFGrDqevTsPXmtyJvMe3kYaYe/UZPzCPf9H9f3cyxcYlVi7ma7
         xesPgqgAFheQeKVS9kCy+VG3z6j6ybPcgFfzNgV2+aKaBM2DJErDrjs8mFKaDEEk/kfp
         WpOxVxh1u+b0QgaVsv6Kum4Aq5GUArU7d/Gok3e4rQicnPLolDibhGNG2EfCDbMUknD6
         ZnECIh6/ivV5WxnBvqV0ICbyIrx88Vxt7h3WtHHNCDFV3lUggPT/dAs5VlAx00g+1cWl
         GV0Q==
X-Gm-Message-State: AGi0PuaPD2jbx8GrkKc+at1Aw19eXwGMlU3ydOlAcU7Z/ajiTWQ6KJp+
        B/VN+Z+qmZ8gvWrBfBu13rE=
X-Google-Smtp-Source: APiQypK92COmCk6jtDXQuM8RbqIzlQmTZkmvIjtD7/GMtqebIJTWbJ+7ip3K+A9bRbw+AFyvMNQEDw==
X-Received: by 2002:a1c:2383:: with SMTP id j125mr4175112wmj.6.1588178518352;
        Wed, 29 Apr 2020 09:41:58 -0700 (PDT)
Received: from liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id i25sm8360761wml.43.2020.04.29.09.41.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 09:41:57 -0700 (PDT)
Date:   Wed, 29 Apr 2020 16:41:55 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        virtio-dev@lists.oasis-open.org,
        virtualization@lists.linux-foundation.org,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-hyperv@vger.kernel.org,
        linux-s390@vger.kernel.org, xen-devel@lists.xenproject.org,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Jason Wang <jasowang@redhat.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Pingfan Liu <kernelfans@gmail.com>,
        Leonardo Bras <leobras.c@gmail.com>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>, Baoquan He <bhe@redhat.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH v1 1/3] mm/memory_hotplug: Prepare passing flags to
 add_memory() and friends
Message-ID: <20200429164154.ctflq4ouwrwwe4wq@liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net>
References: <20200429160803.109056-1-david@redhat.com>
 <20200429160803.109056-2-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429160803.109056-2-david@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Apr 29, 2020 at 06:08:01PM +0200, David Hildenbrand wrote:
> We soon want to pass flags - prepare for that.
> 
> This patch is based on a similar patch by Oscar Salvador:
> 
> https://lkml.kernel.org/r/20190625075227.15193-3-osalvador@suse.de
> 
[...]
> ---
>  drivers/hv/hv_balloon.c                         |  2 +-

> diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
> index 32e3bc0aa665..0194bed1a573 100644
> --- a/drivers/hv/hv_balloon.c
> +++ b/drivers/hv/hv_balloon.c
> @@ -726,7 +726,7 @@ static void hv_mem_hot_add(unsigned long start, unsigned long size,
>  
>  		nid = memory_add_physaddr_to_nid(PFN_PHYS(start_pfn));
>  		ret = add_memory(nid, PFN_PHYS((start_pfn)),
> -				(HA_CHUNK << PAGE_SHIFT));
> +				(HA_CHUNK << PAGE_SHIFT), 0);
>  
>  		if (ret) {
>  			pr_err("hot_add memory failed error is %d\n", ret);

Acked-by: Wei Liu <wei.liu@kernel.org>
