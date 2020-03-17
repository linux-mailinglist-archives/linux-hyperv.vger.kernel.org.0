Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A009D189147
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Mar 2020 23:24:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbgCQWYO (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 17 Mar 2020 18:24:14 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35111 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbgCQWYN (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 17 Mar 2020 18:24:13 -0400
Received: by mail-wr1-f68.google.com with SMTP id h4so7215446wru.2;
        Tue, 17 Mar 2020 15:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AX+RV3FQdaQCktHrarZsh0Sc9mln1v0WFAS6/e+iIl4=;
        b=IT859BKvTYsEhZFBH4MCcu+1EzWJKxGDCp4UF0/Pd+CTDCQCLqxGClzj4JlyFd+4LH
         Ys0kdoodElRrZC0JA5gmXQH5/Enga8utUXxLWr/tDEaNN0n9PBcNIcLda8VwIVneVhuV
         oHgC2SUi3ijq9doiATuSyswY2nqyyyuRoopSvbo1HIjJ3GPNlmOZtVheSIM+OyffJwto
         YgOdpUCIovDEF0qVLkHvas8uHY03LXf4QxKm/EW5YA5VW2khMJziEFoC3LllzOtRKJ3D
         I6+WZxCWPG3WLQ1DFwpZbw9SJQrNvj7ynV1sAX5FMjR8iWutGUfR8tskrvj93mT116Io
         4uDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=AX+RV3FQdaQCktHrarZsh0Sc9mln1v0WFAS6/e+iIl4=;
        b=Hnyv1TYAQGvqht5RtO1/x8AmNlpUWg7jOQqNtEpePDSF3lpmNtHvqEJzhsUikUbRKJ
         PqDSYmKP8GVbPmk5v5W3xPClzdzXWwgXNE8xUxyYImvtRVPJOkE5P2JujgY3XOtBAIYZ
         mjKQJrLoCefRHAVvgaNGiJovRSn1u61thDsyp/o3ROazAla1dtq4UnCltXjeCDJ7y99q
         jW0cavh8pjhhiKHIli9JNbOoicleHLWZ8Y2bLmSWRHqcU0GgDTZE290H5mpXjMYGd3QT
         l4k4OvRM4ZWgrpMfgoIcBOmG3ydiBHi9hBSiDAmVavSzVBCrbK5MQ2IhRNe+6xxiurqZ
         8g1Q==
X-Gm-Message-State: ANhLgQ2HsBykdYUVPDs62LpNRrr/DSUpuUdhFkb3m/V2wRbeYnPJG6fc
        xJRmuYRO6qja6EY7LOrMhEc=
X-Google-Smtp-Source: ADFU+vt8f4AAZPIyrQa8ZOQhtBN+IMVOluhC7o/agtBjdWF696Gd3ZLLKacockNGMxdBtWXoieIFag==
X-Received: by 2002:adf:b197:: with SMTP id q23mr1198513wra.412.1584483851329;
        Tue, 17 Mar 2020 15:24:11 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id f203sm1088742wmf.18.2020.03.17.15.24.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Mar 2020 15:24:09 -0700 (PDT)
Date:   Tue, 17 Mar 2020 22:24:09 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, linux-hyperv@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Baoquan He <bhe@redhat.com>,
        Wei Yang <richard.weiyang@gmail.com>
Subject: Re: [PATCH v2 6/8] mm/memory_hotplug: unexport memhp_auto_online
Message-ID: <20200317222409.jufwrcrqtyu263cc@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20200317104942.11178-1-david@redhat.com>
 <20200317104942.11178-7-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200317104942.11178-7-david@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Mar 17, 2020 at 11:49:40AM +0100, David Hildenbrand wrote:
>All in-tree users except the mm-core are gone. Let's drop the export.
>
>Cc: Andrew Morton <akpm@linux-foundation.org>
>Cc: Michal Hocko <mhocko@kernel.org>
>Cc: Oscar Salvador <osalvador@suse.de>
>Cc: "Rafael J. Wysocki" <rafael@kernel.org>
>Cc: Baoquan He <bhe@redhat.com>
>Cc: Wei Yang <richard.weiyang@gmail.com>
>Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>

>---
> mm/memory_hotplug.c | 1 -
> 1 file changed, 1 deletion(-)
>
>diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
>index 1a00b5a37ef6..2d2aae830b92 100644
>--- a/mm/memory_hotplug.c
>+++ b/mm/memory_hotplug.c
>@@ -71,7 +71,6 @@ bool memhp_auto_online;
> #else
> bool memhp_auto_online = true;
> #endif
>-EXPORT_SYMBOL_GPL(memhp_auto_online);
> 
> static int __init setup_memhp_default_state(char *str)
> {
>-- 
>2.24.1

-- 
Wei Yang
Help you, Help me
