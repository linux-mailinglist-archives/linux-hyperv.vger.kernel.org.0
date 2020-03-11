Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6426181B03
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Mar 2020 15:20:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729717AbgCKOUH (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 11 Mar 2020 10:20:07 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37233 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729712AbgCKOUG (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 11 Mar 2020 10:20:06 -0400
Received: by mail-wm1-f67.google.com with SMTP id a141so2342342wme.2;
        Wed, 11 Mar 2020 07:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=U8yHxOLld6I5yONtEEjc1KYpMfk+7prWIw3BzC1un4I=;
        b=XPZBKHUzoxtFiu/PBGZnp0TlZJM7RHTR+pRT3HJmGJGEzlUfiPsSCfxa86Kjh+2qxg
         nfzi+qJIaliw91wL4h/v5MEVCFwDWiv5kYkfNrkcFrAK50mruIgOyvLnuhraVwcyz/T+
         +caYMZLv+5eWwP1Tq7ocIDcc1Tfmoc2/La9I5YBDPVTo4TXDqmmLbOKfv4MI92bmeN3b
         eK3S+N7LCjikrA7tRfFTxtIVdj97FWJ8kLFfqNifcV9hf1GEy1pIbxxcTa9BfTiYKO21
         +TiuPN48K2Vpk821PF7hLxze5YkrYxGkZmEyrwfXKvovX71eikmV3M35gWi+sVMLFclT
         kYPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=U8yHxOLld6I5yONtEEjc1KYpMfk+7prWIw3BzC1un4I=;
        b=M7Sy788BvyxveC23pZQc8GriThpT+8RlDD9Efj1H7P9uSdIvZJxTQE9wlWSr4b0JkI
         Hg0LpoC5QHLumbl/fK/bvJqBkV3rFH0yGqZzjKX+ANl1AfZCNnR8MI0YnUG/4Vu/7QJr
         BpuYXG51B9YrvRPTeY8iQJdZsWgGfoqGPT8+0gCJ27sUvhFzLLsaeoegQXL19z7b8+6V
         EBf5UKA+SXNrI/XnY8zF/Il/SNEQ+YPWOlVGH4ff9EH2lSWCNPawC1wmbMVE2ObNoRi1
         7u2Bq7sKNjfYNYIfm5cB9foEsLXUl6McFybMiHGDkiUoNHCS5nF1I5X2UkTrHqRAllBs
         P8ZA==
X-Gm-Message-State: ANhLgQ2nE6Kro7ykARvP9eyI88JSb6X2dMsHADqLdkxsOAFKPO5LZtjk
        xyQ8cbSNM1HYmc9fRglKypE=
X-Google-Smtp-Source: ADFU+vu6XvNhjX9fUk/vGR9XwGi4Kb+PTmIwG/KCc8VoVTWG4HjFikyiQTu493sCs87Z+jnc8lzQFQ==
X-Received: by 2002:a7b:c354:: with SMTP id l20mr3892521wmj.40.1583936404859;
        Wed, 11 Mar 2020 07:20:04 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id i6sm6083016wru.40.2020.03.11.07.20.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Mar 2020 07:20:03 -0700 (PDT)
Date:   Wed, 11 Mar 2020 14:20:02 +0000
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
Subject: Re: [PATCH v1 3/5] drivers/base/memory: store mapping between MMOP_*
 and string in an array
Message-ID: <20200311142002.2htiv4llyam2svta@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20200311123026.16071-1-david@redhat.com>
 <20200311123026.16071-4-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311123026.16071-4-david@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Mar 11, 2020 at 01:30:24PM +0100, David Hildenbrand wrote:
>Let's use a simple array which we can reuse soon. While at it, move the
>string->mmop conversion out of the device hotplug lock.
>
>Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>Cc: Andrew Morton <akpm@linux-foundation.org>
>Cc: Michal Hocko <mhocko@kernel.org>
>Cc: Oscar Salvador <osalvador@suse.de>
>Cc: "Rafael J. Wysocki" <rafael@kernel.org>
>Cc: Baoquan He <bhe@redhat.com>
>Cc: Wei Yang <richard.weiyang@gmail.com>
>Signed-off-by: David Hildenbrand <david@redhat.com>
>---
> drivers/base/memory.c | 38 +++++++++++++++++++++++---------------
> 1 file changed, 23 insertions(+), 15 deletions(-)
>
>diff --git a/drivers/base/memory.c b/drivers/base/memory.c
>index e7e77cafef80..8a7f29c0bf97 100644
>--- a/drivers/base/memory.c
>+++ b/drivers/base/memory.c
>@@ -28,6 +28,24 @@
> 
> #define MEMORY_CLASS_NAME	"memory"
> 
>+static const char *const online_type_to_str[] = {
>+	[MMOP_OFFLINE] = "offline",
>+	[MMOP_ONLINE] = "online",
>+	[MMOP_ONLINE_KERNEL] = "online_kernel",
>+	[MMOP_ONLINE_MOVABLE] = "online_movable",
>+};
>+
>+static int memhp_online_type_from_str(const char *str)
>+{
>+	int i;
>+
>+	for (i = 0; i < ARRAY_SIZE(online_type_to_str); i++) {
>+		if (sysfs_streq(str, online_type_to_str[i]))
>+			return i;
>+	}
>+	return -EINVAL;
>+}
>+
> #define to_memory_block(dev) container_of(dev, struct memory_block, dev)
> 
> static int sections_per_block;
>@@ -236,26 +254,17 @@ static int memory_subsys_offline(struct device *dev)
> static ssize_t state_store(struct device *dev, struct device_attribute *attr,
> 			   const char *buf, size_t count)
> {
>+	const int online_type = memhp_online_type_from_str(buf);

In your following patch, you did the same conversion. Is it possible to merge
them into this one?

> 	struct memory_block *mem = to_memory_block(dev);
>-	int ret, online_type;
>+	int ret;
>+
>+	if (online_type < 0)
>+		return -EINVAL;
> 
> 	ret = lock_device_hotplug_sysfs();
> 	if (ret)
> 		return ret;
> 
>-	if (sysfs_streq(buf, "online_kernel"))
>-		online_type = MMOP_ONLINE_KERNEL;
>-	else if (sysfs_streq(buf, "online_movable"))
>-		online_type = MMOP_ONLINE_MOVABLE;
>-	else if (sysfs_streq(buf, "online"))
>-		online_type = MMOP_ONLINE;
>-	else if (sysfs_streq(buf, "offline"))
>-		online_type = MMOP_OFFLINE;
>-	else {
>-		ret = -EINVAL;
>-		goto err;
>-	}
>-
> 	switch (online_type) {
> 	case MMOP_ONLINE_KERNEL:
> 	case MMOP_ONLINE_MOVABLE:
>@@ -271,7 +280,6 @@ static ssize_t state_store(struct device *dev, struct device_attribute *attr,
> 		ret = -EINVAL; /* should never happen */
> 	}
> 
>-err:
> 	unlock_device_hotplug();
> 
> 	if (ret < 0)
>-- 
>2.24.1

-- 
Wei Yang
Help you, Help me
