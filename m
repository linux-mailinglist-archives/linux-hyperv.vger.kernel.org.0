Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 465F3181B21
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Mar 2020 15:26:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729100AbgCKO0g (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 11 Mar 2020 10:26:36 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44077 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729057AbgCKO0g (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 11 Mar 2020 10:26:36 -0400
Received: by mail-wr1-f68.google.com with SMTP id l18so2852859wru.11;
        Wed, 11 Mar 2020 07:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CsTbLtbFJBK1CBJJUlE0MFl94CmaUOLGCz5Mkq+OEkw=;
        b=aePPmYDnoI4RewHsJ7PIf4IJD1UEiDm22ZxJsfHqe0fflICqXL+sNoyCZnK4fIsMEA
         rSmtVqB++yTeLqfn79SFyplP5gdxjQzJsjtkaLFA8FVWiDCNLa2u1FG+Fls6KW9qG98Y
         OGXrCwkwT9GAth1nZ2zt5vh2WpoEQf4wEDDC3X3llrNY+26gZ/cVfestr4/EEyv1j9QM
         +rP6pOS/w3SQgo0PuN+oWHdGZzMGwQbCkKxyPsXwKJxgSP05PChvyUUhbOReiZGRLUBg
         cDfMqXVLiBZIUfAKEoMDbhqJdzs4V5ZJGvfbv0t+4YD5kAves9NGiRbQdwjs0S4tB9hu
         HEzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=CsTbLtbFJBK1CBJJUlE0MFl94CmaUOLGCz5Mkq+OEkw=;
        b=Yao1ELSRwc5CwJleXyZsCVt6dpqxaJZ/COl4mQ7K+f4HTQTUPJHWq92rASRlRxpyJu
         Dj+wT0EdPNZSHh5NwSjvhRzfZ1HL7+1TWOvIkoyOpoXecF215KxURFyCZXLZZz68kaTv
         vHckCqb501lj4N5UZuwh25DqrElhtyMjEhMrVgiCX63soHgQ7jys0ZySoH3vRnj2dRDa
         Vc0+qY9AUFFJSHck+MkP9bTY71l+l4euJhWP/m0L1128y8Aah0LkU801GFZogfK05Eo6
         n4l4+eSdG8sqMPHbeFBqH2xo8zFiEbx6+QCWcyas0H/gJOOOXT56g8xN/uhjdqZVkphG
         FcHg==
X-Gm-Message-State: ANhLgQ12B7WvksyRUydxNbFksJ5kpvBfOk5BpXX9yhKpQmuvJdtFFHb1
        KNIdwISkmqRVu77M7z8nCRKKcMS8
X-Google-Smtp-Source: ADFU+vs4N9H4NmCIYVGtkISk1DRai7Z1/9w16SPv6LvlOjT+MD/1Y3ePN+L7ARQFCQwtIeNpFr5Iyw==
X-Received: by 2002:a5d:6086:: with SMTP id w6mr4715591wrt.224.1583936793924;
        Wed, 11 Mar 2020 07:26:33 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id c72sm8381117wme.35.2020.03.11.07.26.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Mar 2020 07:26:33 -0700 (PDT)
Date:   Wed, 11 Mar 2020 14:26:32 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, linux-hyperv@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Baoquan He <bhe@redhat.com>,
        Wei Yang <richard.weiyang@gmail.com>
Subject: Re: [PATCH v1 5/5] mm/memory_hotplug: allow to specify a default
 online_type
Message-ID: <20200311142632.xvdwqk2lun4ookez@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20200311123026.16071-1-david@redhat.com>
 <20200311123026.16071-6-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311123026.16071-6-david@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Mar 11, 2020 at 01:30:26PM +0100, David Hildenbrand wrote:
>For now, distributions implement advanced udev rules to essentially
>- Don't online any hotplugged memory (s390x)
>- Online all memory to ZONE_NORMAL (e.g., most virt environments like
>  hyperv)
>- Online all memory to ZONE_MOVABLE in case the zone imbalance is taken
>  care of (e.g., bare metal, special virt environments)
>
>In summary: All memory is usually onlined the same way, however, the
>kernel always has to ask userspace to come up with the same answer.
>E.g., HyperV always waits for a memory block to get onlined before
>continuing, otherwise it might end up adding memory faster than
>hotplugging it, which can result in strange OOM situations.
>
>Let's allow to specify a default online_type, not just "online" and
>"offline". This allows distributions to configure the default online_type
>when booting up and be done with it.
>
>We can now specify "offline", "online", "online_movable" and
>"online_kernel" via
>- "memhp_default_state=" on the kernel cmdline
>- /sys/devices/systemn/memory/auto_online_blocks
>just like we are able to specify for a single memory block via
>/sys/devices/systemn/memory/memoryX/state
>
>Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>Cc: Andrew Morton <akpm@linux-foundation.org>
>Cc: Michal Hocko <mhocko@kernel.org>
>Cc: Oscar Salvador <osalvador@suse.de>
>Cc: "Rafael J. Wysocki" <rafael@kernel.org>
>Cc: Baoquan He <bhe@redhat.com>
>Cc: Wei Yang <richard.weiyang@gmail.com>
>Signed-off-by: David Hildenbrand <david@redhat.com>

Ok, I got the reason to leave the change on string compare here.

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>

>---
> drivers/base/memory.c          | 11 +++++------
> include/linux/memory_hotplug.h |  2 ++
> mm/memory_hotplug.c            |  8 ++++----
> 3 files changed, 11 insertions(+), 10 deletions(-)
>
>diff --git a/drivers/base/memory.c b/drivers/base/memory.c
>index 8d3e16dab69f..2b09b68b9f78 100644
>--- a/drivers/base/memory.c
>+++ b/drivers/base/memory.c
>@@ -35,7 +35,7 @@ static const char *const online_type_to_str[] = {
> 	[MMOP_ONLINE_MOVABLE] = "online_movable",
> };
> 
>-static int memhp_online_type_from_str(const char *str)
>+int memhp_online_type_from_str(const char *str)
> {
> 	int i;
> 
>@@ -394,13 +394,12 @@ static ssize_t auto_online_blocks_store(struct device *dev,
> 					struct device_attribute *attr,
> 					const char *buf, size_t count)
> {
>-	if (sysfs_streq(buf, "online"))
>-		memhp_default_online_type = MMOP_ONLINE;
>-	else if (sysfs_streq(buf, "offline"))
>-		memhp_default_online_type = MMOP_OFFLINE;
>-	else
>+	const int online_type = memhp_online_type_from_str(buf);
>+
>+	if (online_type < 0)
> 		return -EINVAL;
> 
>+	memhp_default_online_type = online_type;
> 	return count;
> }
> 
>diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
>index c6e090b34c4b..ef55115320fb 100644
>--- a/include/linux/memory_hotplug.h
>+++ b/include/linux/memory_hotplug.h
>@@ -117,6 +117,8 @@ extern int arch_add_memory(int nid, u64 start, u64 size,
> 			struct mhp_restrictions *restrictions);
> extern u64 max_mem_size;
> 
>+extern int memhp_online_type_from_str(const char *str);
>+
> /* Default online_type (MMOP_*) when new memory blocks are added. */
> extern int memhp_default_online_type;
> /* If movable_node boot option specified */
>diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
>index 01443c70aa27..4a96273eafa7 100644
>--- a/mm/memory_hotplug.c
>+++ b/mm/memory_hotplug.c
>@@ -75,10 +75,10 @@ EXPORT_SYMBOL_GPL(memhp_default_online_type);
> 
> static int __init setup_memhp_default_state(char *str)
> {
>-	if (!strcmp(str, "online"))
>-		memhp_default_online_type = MMOP_ONLINE;
>-	else if (!strcmp(str, "offline"))
>-		memhp_default_online_type = MMOP_OFFLINE;
>+	const int online_type = memhp_online_type_from_str(str);
>+
>+	if (online_type >= 0)
>+		memhp_default_online_type = online_type;
> 
> 	return 1;
> }
>-- 
>2.24.1

-- 
Wei Yang
Help you, Help me
