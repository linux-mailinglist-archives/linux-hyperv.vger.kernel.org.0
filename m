Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F189188A3F
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Mar 2020 17:29:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726016AbgCQQ3S (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 17 Mar 2020 12:29:18 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:37622 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726473AbgCQQ3R (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 17 Mar 2020 12:29:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584462556;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hJ9IRxNEXJZnQrunYJpAkXFYXEUKw/iYEqZiM94FqR4=;
        b=cptiBHPhfZ2cGBgOSRZh7Sm/Fo1Ne2eAHWj/T2+gcTHlzvbxmjacUrQ6TmNywaSPtGj0NO
        21GQHMu1dA9CG2qx0rjn8jtmijPlnlOt6YfMCjwX/OiZmLZek2WuJR0FdtDSIq0t4N5jCZ
        tNm8j2u1CmYgdiVOw6DBXec7mS48akw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-i3V-N9UMOP2gSiAu-r_Qbg-1; Tue, 17 Mar 2020 12:29:15 -0400
X-MC-Unique: i3V-N9UMOP2gSiAu-r_Qbg-1
Received: by mail-wr1-f69.google.com with SMTP id 94so6253372wrr.3
        for <linux-hyperv@vger.kernel.org>; Tue, 17 Mar 2020 09:29:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=hJ9IRxNEXJZnQrunYJpAkXFYXEUKw/iYEqZiM94FqR4=;
        b=kf5GeJKairNyjHO/cEck/ywTPGTAt/1QeLDhP8QrLjiDXWw2wEEDQsJs8l6T/TDD/c
         qS00Kqb12pkCC+R1TgbXYkLvshp5BobOjpG5HOnMI0foUNyfickDPHL1L3Bk9F5e1OL6
         O2r/ovgQ06W3BAQS8Hb4Jeq3v/0EyyF082Ld/mZ/1BsqQTuuSfk3+zuZBd1rpLeC9akK
         UvFve06wFtVMuSB5Xn4O0prQdIAaXQjsvpENy7k7CjqRYobfeF2yL7uBKkeqha1nPczB
         6AhRuXa6g4j/kO9sZi9izk/Ur+CTbEG4GLf9DUnhwW8Kb95TciMt7bSETbF+D1Nit08L
         yCuQ==
X-Gm-Message-State: ANhLgQ2/DOl9XhasWpG+WUdKbg/a1nGPJrovclCN6ny11Y3XC2Si2SZF
        TldEdYtHPT9jTMNMgPW2xn5eblsson5/PHjURTlyV7cI9YtZ7RS2TFLONbzusWadp0c3do1K2uu
        rx5A8w3iL1mZ59kt1UCZA8HO5
X-Received: by 2002:a1c:4c16:: with SMTP id z22mr155409wmf.50.1584462553802;
        Tue, 17 Mar 2020 09:29:13 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vu7fxbd1NOj1Fd8X5IeMCfKPLtyDx4k9CrBADtVAaVO0WdO+/adOUSeBrq8Zo7JnejqPA35DQ==
X-Received: by 2002:a1c:4c16:: with SMTP id z22mr155367wmf.50.1584462553538;
        Tue, 17 Mar 2020 09:29:13 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id 19sm4550594wma.3.2020.03.17.09.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 09:29:11 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        linux-hyperv@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Baoquan He <bhe@redhat.com>,
        Wei Yang <richard.weiyang@gmail.com>
Subject: Re: [PATCH v2 5/8] hv_balloon: don't check for memhp_auto_online manually
In-Reply-To: <20200317104942.11178-6-david@redhat.com>
References: <20200317104942.11178-1-david@redhat.com> <20200317104942.11178-6-david@redhat.com>
Date:   Tue, 17 Mar 2020 17:29:09 +0100
Message-ID: <877dzj3pyi.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

David Hildenbrand <david@redhat.com> writes:

> We get the MEM_ONLINE notifier call if memory is added right from the
> kernel via add_memory() or later from user space.
>
> Let's get rid of the "ha_waiting" flag - the wait event has an inbuilt
> mechanism (->done) for that. Initialize the wait event only once and
> reinitialize before adding memory. Unconditionally call complete() and
> wait_for_completion_timeout().
>
> If there are no waiters, complete() will only increment ->done - which
> will be reset by reinit_completion(). If complete() has already been
> called, wait_for_completion_timeout() will not wait.
>
> There is still the chance for a small race between concurrent
> reinit_completion() and complete(). If complete() wins, we would not
> wait - which is tolerable (and the race exists in current code as
> well).

How can we see concurent reinit_completion() and complete()? Obvioulsy,
we are not onlining new memory in kernel and hv_mem_hot_add() calls are
serialized, we're waiting up to 5*HZ for the added block to come online
before proceeding to the next one. Or do you mean we actually hit this
5*HZ timeout, proceeded to the next block and immediately after
reinit_completion() we saw complete() for the previously added block?
This is tolerable indeed, we're making forward progress (and this all is
'best effort' anyway).

>
> Note: We only wait for "some" memory to get onlined, which seems to be
>       good enough for now.
>
> Cc: "K. Y. Srinivasan" <kys@microsoft.com>
> Cc: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: Stephen Hemminger <sthemmin@microsoft.com>
> Cc: Wei Liu <wei.liu@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Wei Yang <richard.weiyang@gmail.com>
> Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
> Cc: linux-hyperv@vger.kernel.org
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  drivers/hv/hv_balloon.c | 25 ++++++++++---------------
>  1 file changed, 10 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
> index a02ce43d778d..af5e09f08130 100644
> --- a/drivers/hv/hv_balloon.c
> +++ b/drivers/hv/hv_balloon.c
> @@ -533,7 +533,6 @@ struct hv_dynmem_device {
>  	 * State to synchronize hot-add.
>  	 */
>  	struct completion  ol_waitevent;
> -	bool ha_waiting;
>  	/*
>  	 * This thread handles hot-add
>  	 * requests from the host as well as notifying
> @@ -634,10 +633,7 @@ static int hv_memory_notifier(struct notifier_block *nb, unsigned long val,
>  	switch (val) {
>  	case MEM_ONLINE:
>  	case MEM_CANCEL_ONLINE:
> -		if (dm_device.ha_waiting) {
> -			dm_device.ha_waiting = false;
> -			complete(&dm_device.ol_waitevent);
> -		}
> +		complete(&dm_device.ol_waitevent);
>  		break;
>  
>  	case MEM_OFFLINE:
> @@ -726,8 +722,7 @@ static void hv_mem_hot_add(unsigned long start, unsigned long size,
>  		has->covered_end_pfn +=  processed_pfn;
>  		spin_unlock_irqrestore(&dm_device.ha_lock, flags);
>  
> -		init_completion(&dm_device.ol_waitevent);
> -		dm_device.ha_waiting = !memhp_auto_online;
> +		reinit_completion(&dm_device.ol_waitevent);
>  
>  		nid = memory_add_physaddr_to_nid(PFN_PHYS(start_pfn));
>  		ret = add_memory(nid, PFN_PHYS((start_pfn)),
> @@ -753,15 +748,14 @@ static void hv_mem_hot_add(unsigned long start, unsigned long size,
>  		}
>  
>  		/*
> -		 * Wait for the memory block to be onlined when memory onlining
> -		 * is done outside of kernel (memhp_auto_online). Since the hot
> -		 * add has succeeded, it is ok to proceed even if the pages in
> -		 * the hot added region have not been "onlined" within the
> -		 * allowed time.
> +		 * Wait for memory to get onlined. If the kernel onlined the
> +		 * memory when adding it, this will return directly. Otherwise,
> +		 * it will wait for user space to online the memory. This helps
> +		 * to avoid adding memory faster than it is getting onlined. As
> +		 * adding succeeded, it is ok to proceed even if the memory was
> +		 * not onlined in time.
>  		 */
> -		if (dm_device.ha_waiting)
> -			wait_for_completion_timeout(&dm_device.ol_waitevent,
> -						    5*HZ);
> +		wait_for_completion_timeout(&dm_device.ol_waitevent, 5 * HZ);
>  		post_status(&dm_device);
>  	}
>  }
> @@ -1707,6 +1701,7 @@ static int balloon_probe(struct hv_device *dev,
>  #ifdef CONFIG_MEMORY_HOTPLUG
>  	set_online_page_callback(&hv_online_page);
>  	register_memory_notifier(&hv_memory_nb);
> +	init_completion(&dm_device.ol_waitevent);
>  #endif
>  
>  	hv_set_drvdata(dev, &dm_device);

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

