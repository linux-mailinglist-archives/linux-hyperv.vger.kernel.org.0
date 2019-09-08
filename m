Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12073ACB0B
	for <lists+linux-hyperv@lfdr.de>; Sun,  8 Sep 2019 07:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725961AbfIHFJg (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 8 Sep 2019 01:09:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:46698 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725957AbfIHFJg (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 8 Sep 2019 01:09:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2F8FBAC64;
        Sun,  8 Sep 2019 05:09:34 +0000 (UTC)
Subject: Re: [PATCH 2/3] xen/ballon: Avoid calling dummy function
 __online_page_set_limits()
To:     Souptick Joarder <jrdr.linux@gmail.com>, richard.weiyang@gmail.com,
        dan.j.williams@intel.com, sashal@kernel.org,
        sstabellini@kernel.org, cai@lca.pw, akpm@linux-foundation.org,
        haiyangz@microsoft.com, kys@microsoft.com, sthemmin@microsoft.com,
        boris.ostrovsky@oracle.com, david@redhat.com,
        pasha.tatashin@soleen.com, Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.com>
Cc:     linux-mm@kvack.org, xen-devel@lists.xenproject.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1567889743.git.jrdr.linux@gmail.com>
 <cover.1567889743.git.jrdr.linux@gmail.com>
 <854db2cf8145d9635249c95584d9a91fd774a229.1567889743.git.jrdr.linux@gmail.com>
From:   Juergen Gross <jgross@suse.com>
Message-ID: <6b666a74-da96-878a-9288-e0271428c0ee@suse.com>
Date:   Sun, 8 Sep 2019 07:09:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <854db2cf8145d9635249c95584d9a91fd774a229.1567889743.git.jrdr.linux@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 07.09.19 23:47, Souptick Joarder wrote:
> __online_page_set_limits() is a dummy function and an extra call
> to this function can be avoided.
> 
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>

Reviewed-by: Juergen Gross <jgross@suse.com>


Juergen
