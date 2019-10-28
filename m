Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DCB8E75F1
	for <lists+linux-hyperv@lfdr.de>; Mon, 28 Oct 2019 17:17:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730627AbfJ1QR6 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 28 Oct 2019 12:17:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:40456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729798AbfJ1QR6 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 28 Oct 2019 12:17:58 -0400
Received: from localhost (unknown [91.217.168.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B91D20873;
        Mon, 28 Oct 2019 16:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572279477;
        bh=FTD8UTLcgLaGI9mBwbZAP+9OgidQNFDpWRVoGM6yAsc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vYVakxo+EsEPXom6s7IRdjYw6W3NFGAH7Y7//mxwDU3HPAFW+Jnto7kCMWhEyEvO6
         LHZmPyg6HHoxkuzfFtugztwoTgFzKOPMXHUyt9x/pfOb+LPE0kmgHvpzQbZXsXpovg
         NW04GO4Z9N9trCQp/m88MrVuVd15bTfVKQ0re8TA=
Date:   Mon, 28 Oct 2019 12:17:54 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Olaf Hering <olaf@aepfle.de>
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "open list:Hyper-V CORE AND DRIVERS" <linux-hyperv@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] tools/hv: async name resolution in kvp_daemon
Message-ID: <20191028161754.GF1554@sasha-vm>
References: <20191024144943.26199-1-olaf@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191024144943.26199-1-olaf@aepfle.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Oct 24, 2019 at 04:49:43PM +0200, Olaf Hering wrote:
>The hostname is resolved just once since commit 58125210ab3b ("Tools:
>hv: cache FQDN in kvp_daemon to avoid timeouts") to make sure the VM
>responds within the timeout limits to requests from the host.
>
>If for some reason getaddrinfo fails, the string returned by the
>"FullyQualifiedDomainName" request contains some error string, which is
>then used by tools on the host side.
>
>Adjust the code to resolve the current hostname in a separate thread.
>This thread loops until getaddrinfo returns success. During this time
>all "FullyQualifiedDomainName" requests will be answered with an empty
>string.
>
>Signed-off-by: Olaf Hering <olaf@aepfle.de>

Thank for the patch Olaf. However, it seems to break build for me:

/usr/bin/ld: hv_kvp_daemon-in.o: in function `kvp_obtain_domain_name':
/home/sasha/linux/tools/hv/hv_kvp_daemon.c:1372: undefined reference to `pthread_create'
/usr/bin/ld: /home/sasha/linux/tools/hv/hv_kvp_daemon.c:1377: undefined reference to `pthread_detach'
collect2: error: ld returned 1 exit status

-- 
Thanks,
Sasha
