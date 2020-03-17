Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4881B18820D
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Mar 2020 12:22:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbgCQLVP (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 17 Mar 2020 07:21:15 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52735 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727427AbgCQK7S (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 17 Mar 2020 06:59:18 -0400
Received: by mail-wm1-f65.google.com with SMTP id 11so20896232wmo.2;
        Tue, 17 Mar 2020 03:59:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8HFvJMFCJYNvz0dXv6Ch2UJSZolJY7vrNfNN5EOFEwc=;
        b=siBQzjg1amBaD6qNQZLm60/lFV7eQlgZx5i5Jza1wu++MWulSnauV8pDhZOXImsAIH
         Z1bVBvvRhgM0QyabJBvWntUXDd8kR4yvji5u3PAMQMS3cYXqCMfqX724evPzTDpwRCmX
         JkvluF76P0+f42xLSY2pWcAiPucwd10Vt6E4lFzcsx2YYvh8vWtZ5GLUxxV9PHQOcOWh
         /gbjuEz08+GGBoQHnydlsmoRk5CntHC4mPqTABWLYUG9ilpPj6A7w86J2qAIIRtMGm1X
         m7GCUCdyRf/J+k+a4Lo4EzlRuVJ4Jp2D/2btjxvwzwSKL4rns+N3GvQmWeaE97gtzkIQ
         PLoA==
X-Gm-Message-State: ANhLgQ0MbvcQSL/j39QOAgkZJT09anNIVhARv0SynHTFFpPz47HGGhFJ
        HpVGJwpztK4Vj9xuOOAc5PJ/WXtl
X-Google-Smtp-Source: ADFU+vuKcSeScQJxJfHf3Bzh98ayLivgd2aUQq71FVoJVb8q4dHZuM8Z1Syn9jMTiCpNxqkeFdgWRw==
X-Received: by 2002:a1c:6285:: with SMTP id w127mr4938571wmb.133.1584442756028;
        Tue, 17 Mar 2020 03:59:16 -0700 (PDT)
Received: from localhost (ip-37-188-255-121.eurotel.cz. [37.188.255.121])
        by smtp.gmail.com with ESMTPSA id m17sm4293118wrw.3.2020.03.17.03.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 03:59:15 -0700 (PDT)
Date:   Tue, 17 Mar 2020 11:59:14 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, linux-hyperv@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Baoquan He <bhe@redhat.com>,
        Wei Yang <richard.weiyang@gmail.com>
Subject: Re: [PATCH v2 6/8] mm/memory_hotplug: unexport memhp_auto_online
Message-ID: <20200317105914.GL26018@dhcp22.suse.cz>
References: <20200317104942.11178-1-david@redhat.com>
 <20200317104942.11178-7-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200317104942.11178-7-david@redhat.com>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue 17-03-20 11:49:40, David Hildenbrand wrote:
> All in-tree users except the mm-core are gone. Let's drop the export.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Wei Yang <richard.weiyang@gmail.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/memory_hotplug.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 1a00b5a37ef6..2d2aae830b92 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -71,7 +71,6 @@ bool memhp_auto_online;
>  #else
>  bool memhp_auto_online = true;
>  #endif
> -EXPORT_SYMBOL_GPL(memhp_auto_online);
>  
>  static int __init setup_memhp_default_state(char *str)
>  {
> -- 
> 2.24.1

-- 
Michal Hocko
SUSE Labs
