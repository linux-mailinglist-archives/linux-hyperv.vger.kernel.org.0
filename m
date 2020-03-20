Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADE9618CB00
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Mar 2020 11:00:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbgCTKAM (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 20 Mar 2020 06:00:12 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:39697 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726851AbgCTKAM (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 20 Mar 2020 06:00:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584698411;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wav6xNqI9ihDDoXx/GoMx+TsMvEpi21uQTIJBLfXuG4=;
        b=ArtPZJsuV5zjr8g5tZpggswtPafK/aolowqcIzdh/Los1y5qeMzT1xOqlfgcS+XRxy/Vlb
        bN0i+mXLLlJk0HzlSXH9VFNcIirVXsLxuXDvNlyRIA7iRQiDYaoHYPQFIFw9ossX/l3ECl
        GshujYM9CekJazDvSqI4FvBRxAeDd94=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-256-1Zz8HvToOJmcmiDI4OJmtA-1; Fri, 20 Mar 2020 06:00:07 -0400
X-MC-Unique: 1Zz8HvToOJmcmiDI4OJmtA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 960B418CA245;
        Fri, 20 Mar 2020 10:00:05 +0000 (UTC)
Received: from localhost (ovpn-13-97.pek2.redhat.com [10.72.13.97])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 315A37389C;
        Fri, 20 Mar 2020 10:00:00 +0000 (UTC)
Date:   Fri, 20 Mar 2020 17:59:58 +0800
From:   Baoquan He <bhe@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, linux-hyperv@vger.kernel.org,
        Wei Yang <richard.weiyang@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v3 3/8] drivers/base/memory: store mapping between MMOP_*
 and string in an array
Message-ID: <20200320095958.GF2987@MiWiFi-R3L-srv>
References: <20200319131221.14044-1-david@redhat.com>
 <20200319131221.14044-4-david@redhat.com>
 <20200320073653.GE2987@MiWiFi-R3L-srv>
 <166f7f03-eda9-00a8-bd18-128898526313@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166f7f03-eda9-00a8-bd18-128898526313@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 03/20/20 at 10:50am, David Hildenbrand wrote:
> On 20.03.20 08:36, Baoquan He wrote:
> > On 03/19/20 at 02:12pm, David Hildenbrand wrote:
> >> Let's use a simple array which we can reuse soon. While at it, move the
> >> string->mmop conversion out of the device hotplug lock.
> >>
> >> Reviewed-by: Wei Yang <richard.weiyang@gmail.com>
> >> Acked-by: Michal Hocko <mhocko@suse.com>
> >> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >> Cc: Andrew Morton <akpm@linux-foundation.org>
> >> Cc: Michal Hocko <mhocko@kernel.org>
> >> Cc: Oscar Salvador <osalvador@suse.de>
> >> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> >> Cc: Baoquan He <bhe@redhat.com>
> >> Cc: Wei Yang <richard.weiyang@gmail.com>
> >> Signed-off-by: David Hildenbrand <david@redhat.com>
> >> ---
> >>  drivers/base/memory.c | 38 +++++++++++++++++++++++---------------
> >>  1 file changed, 23 insertions(+), 15 deletions(-)
> >>
> >> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
> >> index e7e77cafef80..8a7f29c0bf97 100644
> >> --- a/drivers/base/memory.c
> >> +++ b/drivers/base/memory.c
> >> @@ -28,6 +28,24 @@
> >>  
> >>  #define MEMORY_CLASS_NAME	"memory"
> >>  
> >> +static const char *const online_type_to_str[] = {
> >> +	[MMOP_OFFLINE] = "offline",
> >> +	[MMOP_ONLINE] = "online",
> >> +	[MMOP_ONLINE_KERNEL] = "online_kernel",
> >> +	[MMOP_ONLINE_MOVABLE] = "online_movable",
> >> +};
> >> +
> >> +static int memhp_online_type_from_str(const char *str)
> >> +{
> >> +	int i;
> > 
> > I would change it as: 
> > 
> > 	for (int i = 0; i < ARRAY_SIZE(online_type_to_str); i++) {
> > 
> 
> That's not allowed by the C90 standard (and -std=gnu89).
> 
> $ gcc main.c -std=gnu89
> main.c: In function 'main':
> main.c:3:2: error: 'for' loop initial declarations are only allowed in
> C99 or C11 mode
>     3 |  for (int i = 0; i < 8; i++) {
>       |  ^~~

Good to know, thanks.

> 
> One of the reasons why
> 	git grep "for (int "
> 
> will result in very little hits (IOW, only 5 in driver code only).
> 
> -- 
> Thanks,
> 
> David / dhildenb

