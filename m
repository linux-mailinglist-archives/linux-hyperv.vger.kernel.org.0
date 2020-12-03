Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20F802CDAF7
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Dec 2020 17:17:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728720AbgLCQQk (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 3 Dec 2020 11:16:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32792 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726032AbgLCQQi (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 3 Dec 2020 11:16:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607012111;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MAA80sKrwAqbdNWVRk/U3s5sf/jojJUGYqWNq1RmsV0=;
        b=g8WAMFFF7MAf2nzZtvPMt6fqjCQWC/VJzpNgtLqg5Ns2uvt0Pj0DKf01ZJWxPZCbBPryIR
        6a+kjeaMZ7oG6CcnDarWMrMGMkhskaY/iXeoW1vmiYgrw4if3KZcGH8gqNE1hrHmEu2qK2
        i7lPuEGovZ8kQ7b36yp6TarUsLRG4qk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-396-JSp74mNdP06RwoHnK6VzGw-1; Thu, 03 Dec 2020 11:15:08 -0500
X-MC-Unique: JSp74mNdP06RwoHnK6VzGw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B3D7FBBEE3;
        Thu,  3 Dec 2020 16:15:06 +0000 (UTC)
Received: from [10.36.113.250] (ovpn-113-250.ams2.redhat.com [10.36.113.250])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 07FC25D9CA;
        Thu,  3 Dec 2020 16:15:04 +0000 (UTC)
Subject: Re: [PATCH 1/2] hv_balloon: simplify math in alloc_balloon_pages()
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        linux-hyperv@vger.kernel.org
Cc:     Wei Liu <wei.liu@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20201202161245.2406143-1-vkuznets@redhat.com>
 <20201202161245.2406143-2-vkuznets@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <47b49c1a-6ea9-9b86-e08c-bb6915d79ea2@redhat.com>
Date:   Thu, 3 Dec 2020 17:15:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201202161245.2406143-2-vkuznets@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 02.12.20 17:12, Vitaly Kuznetsov wrote:
> 'alloc_unit' in alloc_balloon_pages() is either '512' for 2M allocations or
> '1' for 4k allocations. So
> 
> 1 << get_order(alloc_unit << PAGE_SHIFT)
> 
> equals to 'alloc_unit' and the for loop basically sets all them offline.
> Simplify the math to improve the readability.
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  drivers/hv/hv_balloon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
> index eb56e09ae15f..da3b6bd2367c 100644
> --- a/drivers/hv/hv_balloon.c
> +++ b/drivers/hv/hv_balloon.c
> @@ -1238,7 +1238,7 @@ static unsigned int alloc_balloon_pages(struct hv_dynmem_device *dm,
>  			split_page(pg, get_order(alloc_unit << PAGE_SHIFT));
>  
>  		/* mark all pages offline */
> -		for (j = 0; j < (1 << get_order(alloc_unit << PAGE_SHIFT)); j++)
> +		for (j = 0; j < alloc_unit; j++)
>  			__SetPageOffline(pg + j);
>  
>  		bl_resp->range_count++;
> 

Right, alloc_unit is multiples of 4k pages, such that it can directly be
used for page ranges in deflation/inflation paths.

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

