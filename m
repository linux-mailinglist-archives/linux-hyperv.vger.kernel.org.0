Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 142C7186E74
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Mar 2020 16:25:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731505AbgCPPZD (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 16 Mar 2020 11:25:03 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54942 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731483AbgCPPZD (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 16 Mar 2020 11:25:03 -0400
Received: by mail-wm1-f68.google.com with SMTP id n8so18117874wmc.4;
        Mon, 16 Mar 2020 08:25:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=n/vSqbJLFSGGAzMuc9Ghgl2CCp2FLye+L7Ituywfqjo=;
        b=HuQJKhrYDGj9WORZ3EwLWze5uISIFCjKql0IJRlqFobZ7+nG/st9ZI85DB+x91we7c
         Ye3El03eF2FwNdZTwfXG7sRk3+TYevm3VpIOF5jkmt5nCyBaBI9Z9WjxVMquvSzDdbe0
         FRZ373E5xnghbDXhqJaJnypYJ3yQ5ivP5jugYg/+AmvlygQLXcbIaba88XQ8pYtcFOn0
         wcqd5I8kbBuU1BOAhBLQ6jG+5YEbmmROZ7FNVT38beBVBMfWubjTfb9cuMujYbnzkkr2
         mUS4iqR6PiS1LovwtnCba7kK4wXc/ofh/uneBws5IplkF+TWE0NicOI/IXvNkiLjmRjR
         1aoQ==
X-Gm-Message-State: ANhLgQ1qSOM75COdEW8sHYkCJbSqq5Fa0lEfMLWu8EBEnDC48EorlEUQ
        EoFRj++C3yqpvBBiORkRlho=
X-Google-Smtp-Source: ADFU+vvsjT1C7lNgXq2aVZ5qSLcQDvUcsaTPiQ2+pP5WAHp0LquIvuG4Yo4sXMJ+KBJMSQrZOYGGvw==
X-Received: by 2002:a1c:a584:: with SMTP id o126mr28710245wme.49.1584372300910;
        Mon, 16 Mar 2020 08:25:00 -0700 (PDT)
Received: from localhost ([37.188.132.163])
        by smtp.gmail.com with ESMTPSA id q72sm48569wme.31.2020.03.16.08.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 08:25:00 -0700 (PDT)
Date:   Mon, 16 Mar 2020 16:24:59 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, linux-hyperv@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
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
Message-ID: <20200316152459.GV11482@dhcp22.suse.cz>
References: <20200311123026.16071-1-david@redhat.com>
 <20200311123026.16071-5-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311123026.16071-5-david@redhat.com>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed 11-03-20 13:30:25, David Hildenbrand wrote:
[...]
> diff --git a/arch/powerpc/platforms/powernv/memtrace.c b/arch/powerpc/platforms/powernv/memtrace.c
> index d6d64f8718e6..e15a600cfa4d 100644
> --- a/arch/powerpc/platforms/powernv/memtrace.c
> +++ b/arch/powerpc/platforms/powernv/memtrace.c
> @@ -235,7 +235,7 @@ static int memtrace_online(void)
>  		 * If kernel isn't compiled with the auto online option
>  		 * we need to online the memory ourselves.
>  		 */
> -		if (!memhp_auto_online) {
> +		if (memhp_default_online_type == MMOP_OFFLINE) {
>  			lock_device_hotplug();
>  			walk_memory_blocks(ent->start, ent->size, NULL,
>  					   online_mem_block);

Whut? This stinks, doesn't it. For your defense, the original code is
fishy already but this just makes it even more ugly.
-- 
Michal Hocko
SUSE Labs
