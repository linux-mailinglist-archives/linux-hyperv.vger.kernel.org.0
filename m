Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B879D2CDAF4
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Dec 2020 17:17:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728499AbgLCQOw (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 3 Dec 2020 11:14:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32642 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387636AbgLCQOu (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 3 Dec 2020 11:14:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607012004;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6ZhQw7VlgrEreUBDAlCwi/iVR9qzViCUUe1Dw24VKkQ=;
        b=GcU7yqCmuvYDSmm2H9xOQTPUULa70d+Bl6k3pxGN8cSjIDHF3SmESvlZ1QXOSdGMCvx3iN
        MeoPtrY0GWttojllrzPaHi722aZ7pBgqiT4thqoJvxJnCQvCfh7QB1ggwyjzA9X5tx8Hcb
        1zqs/V6g7D4ytvJx8EQCjLhKprqfIXQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-584-2oZb4b4YMkKfpqrE5rjnwg-1; Thu, 03 Dec 2020 11:13:19 -0500
X-MC-Unique: 2oZb4b4YMkKfpqrE5rjnwg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2E5F3107ACE6;
        Thu,  3 Dec 2020 16:13:18 +0000 (UTC)
Received: from [10.36.113.250] (ovpn-113-250.ams2.redhat.com [10.36.113.250])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7990A60873;
        Thu,  3 Dec 2020 16:13:16 +0000 (UTC)
Subject: Re: [PATCH 2/2] hv_balloon: do adjust_managed_page_count() when
 ballooning/un-ballooning
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        linux-hyperv@vger.kernel.org
Cc:     Wei Liu <wei.liu@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20201202161245.2406143-1-vkuznets@redhat.com>
 <20201202161245.2406143-3-vkuznets@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <9202aafa-f30e-4d96-72a9-3ccd083cc58c@redhat.com>
Date:   Thu, 3 Dec 2020 17:13:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201202161245.2406143-3-vkuznets@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 02.12.20 17:12, Vitaly Kuznetsov wrote:
> Unlike virtio_balloon/virtio_mem/xen balloon drivers, Hyper-V balloon driver
> does not adjust managed pages count when ballooning/un-ballooning and this leads
> to incorrect stats being reported, e.g. unexpected 'free' output.
> 
> Note, the calculation in post_status() seems to remain correct: ballooned out
> pages are never 'available' and we manually add dm->num_pages_ballooned to
> 'commited'.
> 
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  drivers/hv/hv_balloon.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
> index da3b6bd2367c..8c471823a5af 100644
> --- a/drivers/hv/hv_balloon.c
> +++ b/drivers/hv/hv_balloon.c
> @@ -1198,6 +1198,7 @@ static void free_balloon_pages(struct hv_dynmem_device *dm,
>  		__ClearPageOffline(pg);
>  		__free_page(pg);
>  		dm->num_pages_ballooned--;
> +		adjust_managed_page_count(pg, 1);
>  	}
>  }
>  
> @@ -1238,8 +1239,10 @@ static unsigned int alloc_balloon_pages(struct hv_dynmem_device *dm,
>  			split_page(pg, get_order(alloc_unit << PAGE_SHIFT));
>  
>  		/* mark all pages offline */
> -		for (j = 0; j < alloc_unit; j++)
> +		for (j = 0; j < alloc_unit; j++) {
>  			__SetPageOffline(pg + j);
> +			adjust_managed_page_count(pg + j, -1);
> +		}
>  
>  		bl_resp->range_count++;
>  		bl_resp->range_array[i].finfo.start_page =
> 

I assume this has been properly tested such that it does not change the
system behavior regarding when/how HyperV decides to add/remove memory.

LGTM

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

