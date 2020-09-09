Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20443262C44
	for <lists+linux-hyperv@lfdr.de>; Wed,  9 Sep 2020 11:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730304AbgIIJoC (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 9 Sep 2020 05:44:02 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40806 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730293AbgIIJoA (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 9 Sep 2020 05:44:00 -0400
Received: by mail-wr1-f66.google.com with SMTP id j2so2199573wrx.7;
        Wed, 09 Sep 2020 02:43:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=itunWBeUEUF+I5zgor+uJyYhdBRIEn0Nbwdk7PfivcQ=;
        b=RRVLS1pD2MxO+E31swCf+52VnO23O93ZcgXgGtXBAf5Xj4W8cWsHBtychCYIF4YTHL
         5tdAAAUPQilXuAacE+JH0Z2X1/SftEfzs+TLDCYXdJyonQKyNxw6rvJCkIGik7KrKDNs
         EtZhLQF8jNVzNoFh5yazuVLdlb5qk4BZy47fg5dBAUE1F/kOArIp6P2olPcX4P++LcC3
         DAyYJWbm09CYX1gyvKmopo6bBRU2F75diEawM11zAj9f6XRbj6p5iVBcWxdwEmbRqwDr
         nvcyVrij63/EHc8aZZ3WdvF28uU1R+nF+56fr6zwBzd4+wvY8M+5j5816CsMCezfEVn2
         oy2g==
X-Gm-Message-State: AOAM533G6wsZB1m6SfpH4JVBM3vIubqQL+Ozk8w9FNeKTucW4O50bn0h
        8eFUL9PNYq1XtOdQcWkZPzM=
X-Google-Smtp-Source: ABdhPJw4m6JIIMVzIcBEfdyNOEzdxl4ubsib7FAe+AQwVP/swI1ur/mk9/fv0YgWwez/zmAN9CDF6A==
X-Received: by 2002:adf:f552:: with SMTP id j18mr3339957wrp.128.1599644633198;
        Wed, 09 Sep 2020 02:43:53 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id y1sm3048033wmi.36.2020.09.09.02.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 02:43:52 -0700 (PDT)
Date:   Wed, 9 Sep 2020 09:43:51 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-hyperv@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-acpi@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-s390@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Baoquan He <bhe@redhat.com>,
        Wei Yang <richardw.yang@linux.intel.com>
Subject: Re: [PATCH v2 7/7] hv_balloon: try to merge system ram resources
Message-ID: <20200909094351.2a6lpsqoqj6b4nk2@liuwe-devbox-debian-v2>
References: <20200908201012.44168-1-david@redhat.com>
 <20200908201012.44168-8-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200908201012.44168-8-david@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Sep 08, 2020 at 10:10:12PM +0200, David Hildenbrand wrote:
> Let's try to merge system ram resources we add, to minimize the number
> of resources in /proc/iomem. We don't care about the boundaries of
> individual chunks we added.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: "K. Y. Srinivasan" <kys@microsoft.com>
> Cc: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: Stephen Hemminger <sthemmin@microsoft.com>
> Cc: Wei Liu <wei.liu@kernel.org>
> Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Wei Yang <richardw.yang@linux.intel.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Wei Liu <wei.liu@kernel.org>
