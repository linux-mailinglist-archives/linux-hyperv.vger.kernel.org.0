Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91472181B1E
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Mar 2020 15:25:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729726AbgCKOZE (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 11 Mar 2020 10:25:04 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51139 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729531AbgCKOZE (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 11 Mar 2020 10:25:04 -0400
Received: by mail-wm1-f68.google.com with SMTP id a5so2326506wmb.0;
        Wed, 11 Mar 2020 07:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2Nb1plmfKVAC2MuOfuDX+4wev59kTOAoXYnUwoJgsEc=;
        b=U7HIdGTFOGwgnYE5FaqaayFnfK6pdYCBoTLTdF3EBIatnVSAEqU6MF5IJaFluI92I1
         LHzqVxK+GuJfCrIQ3zLu7znfofv+au3P5nQSxqG85vopccus3Y4VlB31wswOU2RtJR4K
         h9rJLbgf01C80Vq6b0GYIk28BudIk+HvCa+xUaxYFuKTpGj2bSOZpKFF7inK23Gq3pFq
         0nl+WDcXbgekhWuJCfppzb68QbKGLWEYXOvNnBwZ8IMImjJiMQeWVsCCQ3sshpYI1bhB
         W/49GxRp/Tt3FGJh3Poo+OHzNUjr692j4R0t85CexK4eMXx+O577Rv4/3WqaviKAcsBV
         KjHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=2Nb1plmfKVAC2MuOfuDX+4wev59kTOAoXYnUwoJgsEc=;
        b=k2O69ZuCEpGLcxxBErGdc4xHADSe330pyCPFwJVoYD4g8hdjZs8QoCDKZGdRSM4bgj
         fpPL4Mjf400pHyOUZKN60BF/SkwGI+gMl7tsLlsbpwpU/szks/XRmByd+1aaUbGr1PUW
         BgjyBCTWqS5Vyfgdv0mnY/kCd7AEOQ+PIlZR9HUhOTEefKDS9FPTQ2NMGuFeAhuO80lL
         I9Oqfl9T8AenS2rB8bZoTgLngQEsPLgUqEj105NWyf/ZfEPhT9R4HHaoaJ4JQcyYgoyw
         4oLCBLegOUxGAJli0Kx5BkUimzbSoVx2XvrfEQ3JyGhYGvB1ykC2pgF+HKxN70t/PFtU
         cZvw==
X-Gm-Message-State: ANhLgQ0uQ5UIQ0cciv/wH6svHy4Q+7aft6TvDyoqGqdTdmXsEgi4xgzJ
        hOQt9j6ybyF1U+I9atZOSKA=
X-Google-Smtp-Source: ADFU+vv0xKGBUYpBIvH40iDkndpgBVMWwB6DdAtSmVeVuY13QccFoclSfNHbas6fXIRJ1zXzVhp0Rg==
X-Received: by 2002:a7b:c202:: with SMTP id x2mr4023042wmi.71.1583936702561;
        Wed, 11 Mar 2020 07:25:02 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 9sm8541009wmo.38.2020.03.11.07.25.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Mar 2020 07:25:01 -0700 (PDT)
Date:   Wed, 11 Mar 2020 14:25:00 +0000
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
        Wei Yang <richard.weiyang@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v1 4/5] mm/memory_hotplug: convert memhp_auto_online to
 store an online_type
Message-ID: <20200311142500.ja5ftlfhv4fgmgcj@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20200311123026.16071-1-david@redhat.com>
 <20200311123026.16071-5-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311123026.16071-5-david@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Mar 11, 2020 at 01:30:25PM +0100, David Hildenbrand wrote:
>... and rename it to memhp_default_online_type. This is a preparation
>for more detailed default online behavior.
>
>Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>Cc: Andrew Morton <akpm@linux-foundation.org>
>Cc: Michal Hocko <mhocko@kernel.org>
>Cc: Oscar Salvador <osalvador@suse.de>
>Cc: "Rafael J. Wysocki" <rafael@kernel.org>
>Cc: Baoquan He <bhe@redhat.com>
>Cc: Wei Yang <richard.weiyang@gmail.com>
>Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>Cc: Paul Mackerras <paulus@samba.org>
>Cc: Michael Ellerman <mpe@ellerman.id.au>
>Cc: "K. Y. Srinivasan" <kys@microsoft.com>
>Cc: Haiyang Zhang <haiyangz@microsoft.com>
>Cc: Stephen Hemminger <sthemmin@microsoft.com>
>Cc: Wei Liu <wei.liu@kernel.org>
>Cc: Thomas Gleixner <tglx@linutronix.de>
>Cc: linuxppc-dev@lists.ozlabs.org
>Cc: linux-hyperv@vger.kernel.org
>Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>

>---
> arch/powerpc/platforms/powernv/memtrace.c |  2 +-
> drivers/base/memory.c                     | 10 ++++------
> drivers/hv/hv_balloon.c                   |  2 +-
> include/linux/memory_hotplug.h            |  3 ++-
> mm/memory_hotplug.c                       | 13 +++++++------
> 5 files changed, 15 insertions(+), 15 deletions(-)
>
>diff --git a/arch/powerpc/platforms/powernv/memtrace.c b/arch/powerpc/platforms/powernv/memtrace.c
>index d6d64f8718e6..e15a600cfa4d 100644
>--- a/arch/powerpc/platforms/powernv/memtrace.c
>+++ b/arch/powerpc/platforms/powernv/memtrace.c
>@@ -235,7 +235,7 @@ static int memtrace_online(void)
> 		 * If kernel isn't compiled with the auto online option
> 		 * we need to online the memory ourselves.
> 		 */
>-		if (!memhp_auto_online) {
>+		if (memhp_default_online_type == MMOP_OFFLINE) {
> 			lock_device_hotplug();
> 			walk_memory_blocks(ent->start, ent->size, NULL,
> 					   online_mem_block);
>diff --git a/drivers/base/memory.c b/drivers/base/memory.c
>index 8a7f29c0bf97..8d3e16dab69f 100644
>--- a/drivers/base/memory.c
>+++ b/drivers/base/memory.c
>@@ -386,10 +386,8 @@ static DEVICE_ATTR_RO(block_size_bytes);
> static ssize_t auto_online_blocks_show(struct device *dev,
> 				       struct device_attribute *attr, char *buf)
> {
>-	if (memhp_auto_online)
>-		return sprintf(buf, "online\n");
>-	else
>-		return sprintf(buf, "offline\n");
>+	return sprintf(buf, "%s\n",
>+		       online_type_to_str[memhp_default_online_type]);
> }
> 
> static ssize_t auto_online_blocks_store(struct device *dev,
>@@ -397,9 +395,9 @@ static ssize_t auto_online_blocks_store(struct device *dev,
> 					const char *buf, size_t count)
> {
> 	if (sysfs_streq(buf, "online"))
>-		memhp_auto_online = true;
>+		memhp_default_online_type = MMOP_ONLINE;
> 	else if (sysfs_streq(buf, "offline"))
>-		memhp_auto_online = false;
>+		memhp_default_online_type = MMOP_OFFLINE;
> 	else
> 		return -EINVAL;
> 
>diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
>index a02ce43d778d..3b90fd12e0c5 100644
>--- a/drivers/hv/hv_balloon.c
>+++ b/drivers/hv/hv_balloon.c
>@@ -727,7 +727,7 @@ static void hv_mem_hot_add(unsigned long start, unsigned long size,
> 		spin_unlock_irqrestore(&dm_device.ha_lock, flags);
> 
> 		init_completion(&dm_device.ol_waitevent);
>-		dm_device.ha_waiting = !memhp_auto_online;
>+		dm_device.ha_waiting = memhp_default_online_type == MMOP_OFFLINE;
> 
> 		nid = memory_add_physaddr_to_nid(PFN_PHYS(start_pfn));
> 		ret = add_memory(nid, PFN_PHYS((start_pfn)),
>diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
>index c2e06ed5e0e9..c6e090b34c4b 100644
>--- a/include/linux/memory_hotplug.h
>+++ b/include/linux/memory_hotplug.h
>@@ -117,7 +117,8 @@ extern int arch_add_memory(int nid, u64 start, u64 size,
> 			struct mhp_restrictions *restrictions);
> extern u64 max_mem_size;
> 
>-extern bool memhp_auto_online;
>+/* Default online_type (MMOP_*) when new memory blocks are added. */
>+extern int memhp_default_online_type;
> /* If movable_node boot option specified */
> extern bool movable_node_enabled;
> static inline bool movable_node_is_enabled(void)
>diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
>index 1a00b5a37ef6..01443c70aa27 100644
>--- a/mm/memory_hotplug.c
>+++ b/mm/memory_hotplug.c
>@@ -67,18 +67,18 @@ void put_online_mems(void)
> bool movable_node_enabled = false;
> 
> #ifndef CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE
>-bool memhp_auto_online;
>+int memhp_default_online_type = MMOP_OFFLINE;
> #else
>-bool memhp_auto_online = true;
>+int memhp_default_online_type = MMOP_ONLINE;
> #endif
>-EXPORT_SYMBOL_GPL(memhp_auto_online);
>+EXPORT_SYMBOL_GPL(memhp_default_online_type);
> 
> static int __init setup_memhp_default_state(char *str)
> {
> 	if (!strcmp(str, "online"))
>-		memhp_auto_online = true;
>+		memhp_default_online_type = MMOP_ONLINE;
> 	else if (!strcmp(str, "offline"))
>-		memhp_auto_online = false;
>+		memhp_default_online_type = MMOP_OFFLINE;
> 
> 	return 1;
> }
>@@ -991,6 +991,7 @@ static int check_hotplug_memory_range(u64 start, u64 size)
> 
> static int online_memory_block(struct memory_block *mem, void *arg)
> {
>+	mem->online_type = memhp_default_online_type;
> 	return device_online(&mem->dev);
> }
> 
>@@ -1063,7 +1064,7 @@ int __ref add_memory_resource(int nid, struct resource *res)
> 	mem_hotplug_done();
> 
> 	/* online pages if requested */
>-	if (memhp_auto_online)
>+	if (memhp_default_online_type != MMOP_OFFLINE)
> 		walk_memory_blocks(start, size, NULL, online_memory_block);
> 
> 	return ret;
>-- 
>2.24.1

-- 
Wei Yang
Help you, Help me
