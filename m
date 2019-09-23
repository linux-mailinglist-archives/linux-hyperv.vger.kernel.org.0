Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2210FBB350
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Sep 2019 14:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732026AbfIWMHV (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 23 Sep 2019 08:07:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:37486 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732008AbfIWMHV (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 23 Sep 2019 08:07:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 29354AEAC;
        Mon, 23 Sep 2019 12:07:20 +0000 (UTC)
Date:   Mon, 23 Sep 2019 14:07:19 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Souptick Joarder <jrdr.linux@gmail.com>,
        linux-hyperv@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Oscar Salvador <osalvador@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Qian Cai <cai@lca.pw>, Sasha Levin <sashal@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Yang <richard.weiyang@gmail.com>
Subject: Re: [PATCH v1 0/3] mm/memory_hotplug: Export generic_online_page()
Message-ID: <20190923120719.GM6016@dhcp22.suse.cz>
References: <20190909114830.662-1-david@redhat.com>
 <f73c4d0f-ad81-81a6-1107-852f2b9cad41@redhat.com>
 <20190923085807.GD6016@dhcp22.suse.cz>
 <df15f269-48df-8738-c714-9fae3cb3b44c@redhat.com>
 <20190923111559.GK6016@dhcp22.suse.cz>
 <88ac3511-4ad8-d5c8-8e6a-0cca0a0f0989@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88ac3511-4ad8-d5c8-8e6a-0cca0a0f0989@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon 23-09-19 13:34:18, David Hildenbrand wrote:
> On 23.09.19 13:15, Michal Hocko wrote:
[...]
> > I am wondering why those pages get onlined when they are, in fact,
> > supposed to be offline.
> > 
> 
> It's the current way of emulating sub-memory-block hotplug on top of the
> memory bock device API we have. Hyper-V and XEN have been using that for
> a long time.

Do they really have to use the existing block interface when they in
fact do not operate on the block granularity? Zone device memory already
acts on sub section/block boundaries.
-- 
Michal Hocko
SUSE Labs
