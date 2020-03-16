Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6256E186E68
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Mar 2020 16:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731696AbgCPPT0 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 16 Mar 2020 11:19:26 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38289 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729856AbgCPPT0 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 16 Mar 2020 11:19:26 -0400
Received: by mail-wm1-f66.google.com with SMTP id t13so12164402wmi.3;
        Mon, 16 Mar 2020 08:19:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9gCLfTwG3giIuIHsNt54BqZ2oPFCe851NK97n7eWk0U=;
        b=kjAsd3vqIDXPBheSE4Ep3nle0/UXfTq4ajDnjCnQBA3a4wA1FJ2epKcA0mgchyjSgs
         bZiQMO2Oxk6U5j/4pNPj4BStVgc2Ub6b+EjAgX+N6UpDiV14stVDgStnDjxc3LMcglC1
         jGwPizkc4Oqy7lMtV7IzXMBdXhfwmdY+jzJNFQFMW2EbFm6xoHWhncTFCUkcrkjXnSVi
         3VQNFLVi34INX/r/j4eTUYAP7s6JuD9lirX4p8SXEGIIdIor2ZOhKX850DbjBrFZt82G
         MVYEZE335ILbUGP2PpOQ0QmEvGiIfL+nQvtIJOoBjNNB/KlvGU4oX8zudJmQnhKZtGi5
         lO8w==
X-Gm-Message-State: ANhLgQ0MAnaKRYHtxcWaDnAIz9WPrHz2F6GLTaG679D9CHtlmSQsBeiq
        QZGIr+5qoQ+PPv53tAJ7zD4=
X-Google-Smtp-Source: ADFU+vvOYExuooXZ898XQrqAGBWNBedWRADee7iQ/jiwP4Lm03/iQnl4/TOMx1px3Igm+ARPH+fmlA==
X-Received: by 2002:a7b:c0cf:: with SMTP id s15mr29520903wmh.106.1584371964191;
        Mon, 16 Mar 2020 08:19:24 -0700 (PDT)
Received: from localhost ([37.188.132.163])
        by smtp.gmail.com with ESMTPSA id w204sm79069wma.1.2020.03.16.08.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 08:19:23 -0700 (PDT)
Date:   Mon, 16 Mar 2020 16:19:22 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, linux-hyperv@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Baoquan He <bhe@redhat.com>,
        Wei Yang <richard.weiyang@gmail.com>
Subject: Re: [PATCH v1 2/5] drivers/base/memory: map MMOP_OFFLINE to 0
Message-ID: <20200316151922.GT11482@dhcp22.suse.cz>
References: <20200311123026.16071-1-david@redhat.com>
 <20200311123026.16071-3-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311123026.16071-3-david@redhat.com>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed 11-03-20 13:30:23, David Hildenbrand wrote:
> I have no idea why we have to start at -1.

Because this is how the offline state offline was represented
originally.

> Just treat 0 as the special
> case. Clarify a comment (which was wrong, when we come via
> device_online() the first time, the online_type would have been 0 /
> MEM_ONLINE). The default is now always MMOP_OFFLINE.

git grep says that you have covered the only remaining place which
hasn't used the enum value.

> This is a preparation to use the online_type as an array index.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Wei Yang <richard.weiyang@gmail.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  drivers/base/memory.c          | 11 ++++-------
>  include/linux/memory_hotplug.h |  2 +-
>  2 files changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
> index 8c5ce42c0fc3..e7e77cafef80 100644
> --- a/drivers/base/memory.c
> +++ b/drivers/base/memory.c
> @@ -211,17 +211,14 @@ static int memory_subsys_online(struct device *dev)
>  		return 0;
>  
>  	/*
> -	 * If we are called from state_store(), online_type will be
> -	 * set >= 0 Otherwise we were called from the device online
> -	 * attribute and need to set the online_type.
> +	 * When called via device_online() without configuring the online_type,
> +	 * we want to default to MMOP_ONLINE.
>  	 */
> -	if (mem->online_type < 0)
> +	if (mem->online_type == MMOP_OFFLINE)
>  		mem->online_type = MMOP_ONLINE;
>  
>  	ret = memory_block_change_state(mem, MEM_ONLINE, MEM_OFFLINE);
> -
> -	/* clear online_type */
> -	mem->online_type = -1;
> +	mem->online_type = MMOP_OFFLINE;
>  
>  	return ret;
>  }
> diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
> index 261dbf010d5d..c2e06ed5e0e9 100644
> --- a/include/linux/memory_hotplug.h
> +++ b/include/linux/memory_hotplug.h
> @@ -48,7 +48,7 @@ enum {
>  /* Types for control the zone type of onlined and offlined memory */
>  enum {
>  	/* Offline the memory. */
> -	MMOP_OFFLINE = -1,
> +	MMOP_OFFLINE = 0,
>  	/* Online the memory. Zone depends, see default_zone_for_pfn(). */
>  	MMOP_ONLINE,
>  	/* Online the memory to ZONE_NORMAL. */
> -- 
> 2.24.1

-- 
Michal Hocko
SUSE Labs
