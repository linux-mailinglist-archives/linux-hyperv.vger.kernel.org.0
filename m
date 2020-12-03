Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6FA2CDCB3
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Dec 2020 18:51:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbgLCRug (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 3 Dec 2020 12:50:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21591 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726567AbgLCRuf (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 3 Dec 2020 12:50:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607017748;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YZXe59hLHI7lUJaoCikBZP/PP9yfQkA8Mgqf1mIV4UE=;
        b=hJgHLfqL2JnQqGx1b98qQ++aW9/t53FJEkQoAwKf85SntGaM5+0VVm81TdUUjZnzPN6ebU
        0OaFWt+mKAa3gOq4qE7V+pG2lMqEJt37ZxDjeQOlo89/eHME350hEOhW4/0eg0uJpt2LNl
        Rgm2WIByRWxwpfmg/9uufPwSzVXDri4=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-3-a6-VlKojMsiiYJwsC4VfNA-1; Thu, 03 Dec 2020 12:49:06 -0500
X-MC-Unique: a6-VlKojMsiiYJwsC4VfNA-1
Received: by mail-ed1-f69.google.com with SMTP id dh21so422963edb.6
        for <linux-hyperv@vger.kernel.org>; Thu, 03 Dec 2020 09:49:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=YZXe59hLHI7lUJaoCikBZP/PP9yfQkA8Mgqf1mIV4UE=;
        b=aJWUfKNust/ii5hFVHsyjaAbPp6NK+AoEr8CmJKIDj3oV+VtEfzqPEYrucadCrPRJ+
         ULJD8RGZQkS2Kw3xxPOwMuAbQbnJXmU34hniT3+vzTe+SylrfblZErT2za08OdmUnyN8
         OElFyIqgxvDEKswOWGfrBAa4IDvLdQ7+pjlVNUN1RgzeMGfT2DCw/On1ZyGIm/Dxq9YU
         R4Z/aTMF4IH1QT/DrqU65Zc7S48bQBqQL1slTpAxTSpw48Nsl5fa4t86T7CurPNsokTY
         QNUQSjIyVNP5hTFNnooxxlVmidXyD1u6EC1bbzwP6RG3ZcX+v4QnV+7HaOOJzpaIAW+T
         rdSg==
X-Gm-Message-State: AOAM530+3Fm8JHy56vAchwTMu9qM+HQE+DlDWU2KLdH19LESvqCBzwUD
        KLXY4SgEvP2/Jdd+RwOzuz5Es/Kt1y88y6lZyDLUV+KM9jaf6Qmp0ojmRTA7KJvXPblhE0FmT0f
        6tvPVA6jyv+L+irseCvRjQ41Q
X-Received: by 2002:a17:906:edca:: with SMTP id sb10mr3612233ejb.284.1607017745575;
        Thu, 03 Dec 2020 09:49:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyp0k7CatgeJ755yk7AjY9Y6ia6uo6Bm6jyGm88jmShQrJoGutTAD06IVsR7/e0vtPLY3KDQg==
X-Received: by 2002:a17:906:edca:: with SMTP id sb10mr3612222ejb.284.1607017745440;
        Thu, 03 Dec 2020 09:49:05 -0800 (PST)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id x20sm1308351ejv.66.2020.12.03.09.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 09:49:04 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     David Hildenbrand <david@redhat.com>, linux-hyperv@vger.kernel.org
Cc:     Wei Liu <wei.liu@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 2/2] hv_balloon: do adjust_managed_page_count() when
 ballooning/un-ballooning
In-Reply-To: <9202aafa-f30e-4d96-72a9-3ccd083cc58c@redhat.com>
References: <20201202161245.2406143-1-vkuznets@redhat.com>
 <20201202161245.2406143-3-vkuznets@redhat.com>
 <9202aafa-f30e-4d96-72a9-3ccd083cc58c@redhat.com>
Date:   Thu, 03 Dec 2020 18:49:04 +0100
Message-ID: <871rg6ok4v.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

David Hildenbrand <david@redhat.com> writes:

> On 02.12.20 17:12, Vitaly Kuznetsov wrote:
>> Unlike virtio_balloon/virtio_mem/xen balloon drivers, Hyper-V balloon driver
>> does not adjust managed pages count when ballooning/un-ballooning and this leads
>> to incorrect stats being reported, e.g. unexpected 'free' output.
>> 
>> Note, the calculation in post_status() seems to remain correct: ballooned out
>> pages are never 'available' and we manually add dm->num_pages_ballooned to
>> 'commited'.
>> 
>> Suggested-by: David Hildenbrand <david@redhat.com>
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>>  drivers/hv/hv_balloon.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
>> index da3b6bd2367c..8c471823a5af 100644
>> --- a/drivers/hv/hv_balloon.c
>> +++ b/drivers/hv/hv_balloon.c
>> @@ -1198,6 +1198,7 @@ static void free_balloon_pages(struct hv_dynmem_device *dm,
>>  		__ClearPageOffline(pg);
>>  		__free_page(pg);
>>  		dm->num_pages_ballooned--;
>> +		adjust_managed_page_count(pg, 1);
>>  	}
>>  }
>>  
>> @@ -1238,8 +1239,10 @@ static unsigned int alloc_balloon_pages(struct hv_dynmem_device *dm,
>>  			split_page(pg, get_order(alloc_unit << PAGE_SHIFT));
>>  
>>  		/* mark all pages offline */
>> -		for (j = 0; j < alloc_unit; j++)
>> +		for (j = 0; j < alloc_unit; j++) {
>>  			__SetPageOffline(pg + j);
>> +			adjust_managed_page_count(pg + j, -1);
>> +		}
>>  
>>  		bl_resp->range_count++;
>>  		bl_resp->range_array[i].finfo.start_page =
>> 
>
> I assume this has been properly tested such that it does not change the
> system behavior regarding when/how HyperV decides to add/remove memory.
>

I'm always reluctant to confirm 'proper testing' as no matter how small
and 'obvious' the change is, regressions keep happening :-) But yes,
this was tested on a Hyper-V host and 'stress' and I observed 'free'
when the balloon was both inflated and deflated, values looked sane.

> LGTM
>
> Reviewed-by: David Hildenbrand <david@redhat.com>

Thanks!

-- 
Vitaly

