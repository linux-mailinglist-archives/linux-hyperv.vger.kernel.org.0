Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3F0E181AF7
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Mar 2020 15:18:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729559AbgCKOSZ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 11 Mar 2020 10:18:25 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40664 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729798AbgCKOSZ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 11 Mar 2020 10:18:25 -0400
Received: by mail-wr1-f66.google.com with SMTP id p2so2839497wrw.7;
        Wed, 11 Mar 2020 07:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UlqHsGcMH2wgZ4HNYQSAfQVihbtUyreW0G2xFxwpzcs=;
        b=PdYhcmI7s3rv/HMRFF/5hUVPIoLN4hdtpSANHt1mmnYHd7bvwLK/oGC56J9RethYth
         +H9fjEMKeBDyP/sBCAjJGnkXzzwhlfGin+8iMaNGcxpbvbV96pZBQ/UBopbr7B8cFg8S
         SxYq5gUPBKhAJN4jVfyflW8sGzRweWAD/9keqVDhqxMMFgL9Y7gblvTCpa+iZ6JrITEk
         H+HlG2w8NvqamdHQMk0ZRPotGvpBILQmL3bJzWVVCH3OErZjB9v7FgdeReAzV5OhB5w1
         1tFvQ+9MhnRGDXTkpuiIoE7rS6bxZrBxBw5RLfp9G3hvhDa8QMIhm2Reb52dR9/wC1BX
         LpJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=UlqHsGcMH2wgZ4HNYQSAfQVihbtUyreW0G2xFxwpzcs=;
        b=pxjY5zXlk6GvWBjrC5Mm/bPXpkiEj0g4QFAFXbhqm0Ys9J201hy5GkU5HHIOJdEkoU
         MIMvs99H03pPE81hUGQyfquhDaskscmXlQhdd1bNqikxYgcuNzTgujNuHAQfYsI46swa
         tREyZVPx7/iLhLwYKTOxyMl5rxujJwqBRFyUKgcN8qRfOpGV3xE6BCUHw1tAnVfiHkEI
         V1MilP/U/AjKJdmRM0pvv8LlsIbitJjw0nIKCHQCLzWTKLGhfvkEJ/Dmdx/m8XwgaIDT
         fZKiIWNop+J2hwhZxqH0HA8cQS4weoIe4VZZqYH6XluK7QMII2SgbT0dHlOdYAJyaeOr
         3igg==
X-Gm-Message-State: ANhLgQ1yhBGmUS6muyTLggI6B9OihSAm7YDh6yuWwBRWP+rhUWEdNMZ7
        Bpu0jgJhb+jypyZIuFT5BgRxu4GR
X-Google-Smtp-Source: ADFU+vsw6V6UgCNg8FHXcehLCdyjM4B1DerfYBOPeu8xfu5rzRUy1y7z6jr/QaB3Qyd9/Wiihx1TAA==
X-Received: by 2002:a05:6000:100d:: with SMTP id a13mr4580847wrx.234.1583936301649;
        Wed, 11 Mar 2020 07:18:21 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id q4sm26328172wro.56.2020.03.11.07.18.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Mar 2020 07:18:21 -0700 (PDT)
Date:   Wed, 11 Mar 2020 14:18:20 +0000
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
Subject: Re: [PATCH v1 2/5] drivers/base/memory: map MMOP_OFFLINE to 0
Message-ID: <20200311141820.zgmwiz3rdj5co6kf@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20200311123026.16071-1-david@redhat.com>
 <20200311123026.16071-3-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311123026.16071-3-david@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Mar 11, 2020 at 01:30:23PM +0100, David Hildenbrand wrote:
>I have no idea why we have to start at -1. Just treat 0 as the special
>case. Clarify a comment (which was wrong, when we come via
>device_online() the first time, the online_type would have been 0 /
>MEM_ONLINE). The default is now always MMOP_OFFLINE.
>
>This is a preparation to use the online_type as an array index.
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
> drivers/base/memory.c          | 11 ++++-------
> include/linux/memory_hotplug.h |  2 +-
> 2 files changed, 5 insertions(+), 8 deletions(-)
>
>diff --git a/drivers/base/memory.c b/drivers/base/memory.c
>index 8c5ce42c0fc3..e7e77cafef80 100644
>--- a/drivers/base/memory.c
>+++ b/drivers/base/memory.c
>@@ -211,17 +211,14 @@ static int memory_subsys_online(struct device *dev)
> 		return 0;
> 
> 	/*
>-	 * If we are called from state_store(), online_type will be
>-	 * set >= 0 Otherwise we were called from the device online
>-	 * attribute and need to set the online_type.
>+	 * When called via device_online() without configuring the online_type,
>+	 * we want to default to MMOP_ONLINE.
> 	 */
>-	if (mem->online_type < 0)
>+	if (mem->online_type == MMOP_OFFLINE)
> 		mem->online_type = MMOP_ONLINE;
> 
> 	ret = memory_block_change_state(mem, MEM_ONLINE, MEM_OFFLINE);
>-
>-	/* clear online_type */
>-	mem->online_type = -1;
>+	mem->online_type = MMOP_OFFLINE;
> 
> 	return ret;
> }
>diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
>index 261dbf010d5d..c2e06ed5e0e9 100644
>--- a/include/linux/memory_hotplug.h
>+++ b/include/linux/memory_hotplug.h
>@@ -48,7 +48,7 @@ enum {
> /* Types for control the zone type of onlined and offlined memory */
> enum {
> 	/* Offline the memory. */
>-	MMOP_OFFLINE = -1,
>+	MMOP_OFFLINE = 0,
> 	/* Online the memory. Zone depends, see default_zone_for_pfn(). */
> 	MMOP_ONLINE,
> 	/* Online the memory to ZONE_NORMAL. */
>-- 
>2.24.1

-- 
Wei Yang
Help you, Help me
