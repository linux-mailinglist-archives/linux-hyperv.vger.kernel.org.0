Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B47C25A936
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Sep 2020 12:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbgIBKP3 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 2 Sep 2020 06:15:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:56542 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726285AbgIBKP1 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 2 Sep 2020 06:15:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D97A3AC61;
        Wed,  2 Sep 2020 10:15:26 +0000 (UTC)
Subject: Re: [PATCH v1 4/5] xen/balloon: try to merge system ram resources
To:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-hyperv@vger.kernel.org, xen-devel@lists.xenproject.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>,
        Julien Grall <julien@xen.org>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Baoquan He <bhe@redhat.com>,
        Wei Yang <richardw.yang@linux.intel.com>
References: <20200821103431.13481-1-david@redhat.com>
 <20200821103431.13481-5-david@redhat.com>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <226413fc-ef25-59bd-772f-79012fda0ee3@suse.com>
Date:   Wed, 2 Sep 2020 12:15:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200821103431.13481-5-david@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 21.08.20 12:34, David Hildenbrand wrote:
> Let's reuse the new mechanism to merge system ram resources below the
> root. We are the only one hotplugging system ram (e.g., DIMMs don't apply),
> so this is safe to be used.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Cc: Juergen Gross <jgross@suse.com>
> Cc: Stefano Stabellini <sstabellini@kernel.org>
> Cc: Roger Pau Monné <roger.pau@citrix.com>
> Cc: Julien Grall <julien@xen.org>
> Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Wei Yang <richardw.yang@linux.intel.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>   drivers/xen/balloon.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/xen/balloon.c b/drivers/xen/balloon.c
> index 37ffccda8bb87..5ec73f752b8a7 100644
> --- a/drivers/xen/balloon.c
> +++ b/drivers/xen/balloon.c
> @@ -338,6 +338,10 @@ static enum bp_state reserve_additional_memory(void)
>   	if (rc) {
>   		pr_warn("Cannot add additional memory (%i)\n", rc);
>   		goto err;
> +	} else {
> +		resource = NULL;
> +		/* Try to reduce the number of system ram resources. */
> +		merge_system_ram_resources(&iomem_resource);
>   	}

I don't see the need for setting resource to NULL and to use an "else"
clause here.


Juergen
