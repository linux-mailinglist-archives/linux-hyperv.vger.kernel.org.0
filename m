Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57E7930411E
	for <lists+linux-hyperv@lfdr.de>; Tue, 26 Jan 2021 15:58:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391544AbhAZO6A (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 26 Jan 2021 09:58:00 -0500
Received: from mail-wr1-f46.google.com ([209.85.221.46]:35027 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391529AbhAZO56 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 26 Jan 2021 09:57:58 -0500
Received: by mail-wr1-f46.google.com with SMTP id l12so16781892wry.2;
        Tue, 26 Jan 2021 06:57:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oMRD2IGlQe0VkH5NsMlo8MCUYOvYpaFDA5hfK4f4djg=;
        b=hAXcS9BqDadKqzi26avz7QBjCS4yhHTk+RA96N2muwYYntpr6o3rRAQy6uW0PyTJ/K
         14t4OEvVUCtf9BPLlSYb2TKhpIAearsHRgZ1weByIF1mi8m+Nxy9MMvPAgwbvlBNRseY
         EKI2BXVltDIZDi9fA+2LJeXo5xJDNzrFPn682kq5WnrJWDYbNffWAaXcWSShq6bWOpPO
         Xb+fg32CE/jomC4qOUep50D7ROd9M2yUlVKDKX8H7z1GT77vE76K0gex+hekC83ASQOh
         tF3uoXmBRf7Pf//NP6vXYD0tp6ISty+bhTrMSugIzzb9hezpQtGrySHMgR1NNWcuO0yQ
         KhkQ==
X-Gm-Message-State: AOAM530ZLRIvQqkK2I8JkutiCMMTgDQNYFZJUy/Uf2EtijUHZR+Zqsnl
        hkmYvvCKw4HDZJ+nl5gBr+M=
X-Google-Smtp-Source: ABdhPJw18oH4tmuy9z2F9V3xuEToq19UFYiLcSIFZ7flLsr+XdOXG/LONMS+wSMYNNeu+39F8YAJNA==
X-Received: by 2002:a5d:4402:: with SMTP id z2mr6518007wrq.265.1611673037155;
        Tue, 26 Jan 2021 06:57:17 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id u14sm3511919wmq.45.2021.01.26.06.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 06:57:16 -0800 (PST)
Date:   Tue, 26 Jan 2021 14:57:15 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        linux-hyperv@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        xen-devel@lists.xenproject.org
Subject: Re: [PATCH v1] mm/memory_hotplug: MEMHP_MERGE_RESOURCE ->
 MHP_MERGE_RESOURCE
Message-ID: <20210126145715.ne5m7lmnqgzn53a2@liuwe-devbox-debian-v2>
References: <20210126115829.10909-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210126115829.10909-1-david@redhat.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Jan 26, 2021 at 12:58:29PM +0100, David Hildenbrand wrote:
> Let's make "MEMHP_MERGE_RESOURCE" consistent with "MHP_NONE", "mhp_t" and
> "mhp_flags". As discussed recently [1], "mhp" is our internal
> acronym for memory hotplug now.
> 
> [1] https://lore.kernel.org/linux-mm/c37de2d0-28a1-4f7d-f944-cfd7d81c334d@redhat.com/
> 
[...]
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Wei Liu <wei.liu@kernel.org>
