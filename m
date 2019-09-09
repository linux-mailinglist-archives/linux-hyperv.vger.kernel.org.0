Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F013AD835
	for <lists+linux-hyperv@lfdr.de>; Mon,  9 Sep 2019 13:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732847AbfIILsk (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 9 Sep 2019 07:48:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52850 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732500AbfIILsj (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 9 Sep 2019 07:48:39 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5F33A302455F;
        Mon,  9 Sep 2019 11:48:39 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-116-173.ams2.redhat.com [10.36.116.173])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 69F13100197A;
        Mon,  9 Sep 2019 11:48:31 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, Souptick Joarder <jrdr.linux@gmail.com>,
        linux-hyperv@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Qian Cai <cai@lca.pw>, Sasha Levin <sashal@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH v1 0/3] mm/memory_hotplug: Export generic_online_page()
Date:   Mon,  9 Sep 2019 13:48:27 +0200
Message-Id: <20190909114830.662-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Mon, 09 Sep 2019 11:48:39 +0000 (UTC)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Based on linux/next + "[PATCH 0/3] Remove __online_page_set_limits()"

Let's replace the __online_page...() functions by generic_online_page().
Hyper-V only wants to delay the actual onlining of un-backed pages, so we
can simpy re-use the generic function.

Only compile-tested.

Cc: Souptick Joarder <jrdr.linux@gmail.com>

David Hildenbrand (3):
  mm/memory_hotplug: Export generic_online_page()
  hv_balloon: Use generic_online_page()
  mm/memory_hotplug: Remove __online_page_free() and
    __online_page_increment_counters()

 drivers/hv/hv_balloon.c        |  3 +--
 include/linux/memory_hotplug.h |  4 +---
 mm/memory_hotplug.c            | 17 ++---------------
 3 files changed, 4 insertions(+), 20 deletions(-)

-- 
2.21.0

