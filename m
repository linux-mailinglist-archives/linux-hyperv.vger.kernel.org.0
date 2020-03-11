Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9663D181AF1
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Mar 2020 15:17:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729683AbgCKORc (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 11 Mar 2020 10:17:32 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53546 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729559AbgCKORc (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 11 Mar 2020 10:17:32 -0400
Received: by mail-wm1-f68.google.com with SMTP id 25so2279462wmk.3;
        Wed, 11 Mar 2020 07:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=I7eOL65ZNqa3gn2e8dEFcQnY6e+zHyU8AljZLv8aig4=;
        b=hUll7QwQmc6uf0wAxMRzpz3+R33/ySwyEcA+TUucM0e+k6m9Qs2ueb9yVCVKNfV7q8
         nF3DVSDcoRj6jyg+7DJNrHX6+FCb5rbHJdfaw9bL5dGRiyb5pPs2JJ0+qI6am2VFzAKW
         fe5npINVmuOm4zTOgLC1yB2Dnbl9JQnJfVpPNJPHsdRtk9ietsHms1A4vey4NGn90Gdi
         SpJSZSiPgpxBcdY4EN/F0Uo+OIzyIfDcbcDFVCHFtj1WoNSS+E9ftStE/UUZsj1zuXTF
         9BD7tnKxSvBKTGy7oZW/jhwsg1dfAKq9OwPFuLzH4xM2bFMNmOpFccwFZGKUX/HXe2FY
         6/vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=I7eOL65ZNqa3gn2e8dEFcQnY6e+zHyU8AljZLv8aig4=;
        b=Bplzqvf4qttL99X5FyiSfWDGgOmYs4KJklzDguxkLkPhKLwmmyHiJ2frEyvvclfQ4i
         gDCIGmIoqarYJiwLvNPndw1MXc82noeC8aRvfaDHaSkcsg+BZjDE4Eqg1HmEZZ6qyY5T
         eaZcZSJEcYhI0t5LpADWJzRysomNxFj1IKbZiCrMSYQe/D+v9L68QjVTIK6Ogiyy951X
         jMuY04oDLJwgHQEU/Zi3hTJ6JUHna98BM9HnGwhPsae4V24Qg019s9aBX3quSDps4C8B
         QPXHS6IJcNBJk3Y7+t/pxcI+ANjPSb1TA/ZJRPBkTgaKCu3LXliq/anq1Qm3LNcc1wad
         MF8A==
X-Gm-Message-State: ANhLgQ0TC0Zqk2JL7f+K3KNhnYcS0iLmix9uRJIMXUFcLR1nF4OCgS/p
        CNa3x/KLeZH1NUJDWhQUnH0=
X-Google-Smtp-Source: ADFU+vvADab4WONrsG1oXOYJkoa9IYPSmxIlRwRgxbMg8mJMQAJDabPwTraFtGj2QJOO+gvV2uzE4Q==
X-Received: by 2002:a05:600c:22d8:: with SMTP id 24mr1608196wmg.108.1583936250009;
        Wed, 11 Mar 2020 07:17:30 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id w1sm7987977wmc.11.2020.03.11.07.17.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Mar 2020 07:17:29 -0700 (PDT)
Date:   Wed, 11 Mar 2020 14:17:28 +0000
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
Subject: Re: [PATCH v1 1/5] drivers/base/memory: rename MMOP_ONLINE_KEEP to
 MMOP_ONLINE
Message-ID: <20200311141728.iav3lh3hcki5p7zc@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20200311123026.16071-1-david@redhat.com>
 <20200311123026.16071-2-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311123026.16071-2-david@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Mar 11, 2020 at 01:30:22PM +0100, David Hildenbrand wrote:
>The name is misleading. Let's just name it like the online_type name we
>expose to user space ("online").
>
>Add some documentation to the types.
>
>Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>Cc: Andrew Morton <akpm@linux-foundation.org>
>Cc: Michal Hocko <mhocko@kernel.org>
>Cc: Oscar Salvador <osalvador@suse.de>
>Cc: "Rafael J. Wysocki" <rafael@kernel.org>
>Cc: Baoquan He <bhe@redhat.com>
>Cc: Wei Yang <richard.weiyang@gmail.com>
>Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>

>---
> drivers/base/memory.c          | 9 +++++----
> include/linux/memory_hotplug.h | 6 +++++-
> 2 files changed, 10 insertions(+), 5 deletions(-)
>
>diff --git a/drivers/base/memory.c b/drivers/base/memory.c
>index 6448c9ece2cb..8c5ce42c0fc3 100644
>--- a/drivers/base/memory.c
>+++ b/drivers/base/memory.c
>@@ -216,7 +216,7 @@ static int memory_subsys_online(struct device *dev)
> 	 * attribute and need to set the online_type.
> 	 */
> 	if (mem->online_type < 0)
>-		mem->online_type = MMOP_ONLINE_KEEP;
>+		mem->online_type = MMOP_ONLINE;
> 
> 	ret = memory_block_change_state(mem, MEM_ONLINE, MEM_OFFLINE);
> 
>@@ -251,7 +251,7 @@ static ssize_t state_store(struct device *dev, struct device_attribute *attr,
> 	else if (sysfs_streq(buf, "online_movable"))
> 		online_type = MMOP_ONLINE_MOVABLE;
> 	else if (sysfs_streq(buf, "online"))
>-		online_type = MMOP_ONLINE_KEEP;
>+		online_type = MMOP_ONLINE;
> 	else if (sysfs_streq(buf, "offline"))
> 		online_type = MMOP_OFFLINE;
> 	else {
>@@ -262,7 +262,7 @@ static ssize_t state_store(struct device *dev, struct device_attribute *attr,
> 	switch (online_type) {
> 	case MMOP_ONLINE_KERNEL:
> 	case MMOP_ONLINE_MOVABLE:
>-	case MMOP_ONLINE_KEEP:
>+	case MMOP_ONLINE:
> 		/* mem->online_type is protected by device_hotplug_lock */
> 		mem->online_type = online_type;
> 		ret = device_online(&mem->dev);
>@@ -342,7 +342,8 @@ static ssize_t valid_zones_show(struct device *dev,
> 	}
> 
> 	nid = mem->nid;
>-	default_zone = zone_for_pfn_range(MMOP_ONLINE_KEEP, nid, start_pfn, nr_pages);
>+	default_zone = zone_for_pfn_range(MMOP_ONLINE, nid, start_pfn,
>+					  nr_pages);
> 	strcat(buf, default_zone->name);
> 
> 	print_allowed_zone(buf, nid, start_pfn, nr_pages, MMOP_ONLINE_KERNEL,
>diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
>index f4d59155f3d4..261dbf010d5d 100644
>--- a/include/linux/memory_hotplug.h
>+++ b/include/linux/memory_hotplug.h
>@@ -47,9 +47,13 @@ enum {
> 
> /* Types for control the zone type of onlined and offlined memory */
> enum {
>+	/* Offline the memory. */
> 	MMOP_OFFLINE = -1,
>-	MMOP_ONLINE_KEEP,
>+	/* Online the memory. Zone depends, see default_zone_for_pfn(). */
>+	MMOP_ONLINE,
>+	/* Online the memory to ZONE_NORMAL. */
> 	MMOP_ONLINE_KERNEL,
>+	/* Online the memory to ZONE_MOVABLE. */
> 	MMOP_ONLINE_MOVABLE,
> };
> 
>-- 
>2.24.1

-- 
Wei Yang
Help you, Help me
