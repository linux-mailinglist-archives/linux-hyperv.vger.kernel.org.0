Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D97AF4856DB
	for <lists+linux-hyperv@lfdr.de>; Wed,  5 Jan 2022 17:50:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242018AbiAEQuj (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 5 Jan 2022 11:50:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43847 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242014AbiAEQuh (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 5 Jan 2022 11:50:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641401436;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ZeXQGQsnd6fmuh87PORrGNZfi1tukb7V3nJM/haD+x8=;
        b=gDCff1EcDOqeenb4lCoz2kJxC7/9BYH0Z43AJkWMI3S4aKAkfcQG1aFJq25fj/sQO4gyAE
        cZrBgvBo96zTpo8icv30pUDXfVWI9tk6lbXMgIO1243fNQT/ke6bO+GRgHlSXZwVeH1xfm
        pXEf5AYBAKGRQRN1cnvHBviLSeAs3AA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-34-EkNYejUIPD6bZUUhGOn8bw-1; Wed, 05 Jan 2022 11:50:33 -0500
X-MC-Unique: EkNYejUIPD6bZUUhGOn8bw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9FEAE81CCB5;
        Wed,  5 Jan 2022 16:50:31 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.40.194.48])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1B5387E8F4;
        Wed,  5 Jan 2022 16:50:28 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     linux-hyperv@vger.kernel.org
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH RFC] Drivers: hv: balloon: Temporary disable the driver on ARM64 when PAGE_SIZE != 4k
Date:   Wed,  5 Jan 2022 17:50:28 +0100
Message-Id: <20220105165028.1343706-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hyper-V ballooning and memory hotplug protocol always seems to assume
4k page size so all PFNs in the structures used for communication are
4k PFNs. In case a different page size is in use on the guest (e.g.
64k), things go terribly wrong all over:
- When reporting statistics, post_status() reports them in guest pages
and hypervisor sees very low memory usage.
- When ballooning, guest reports back PFNs of the allocated pages but
the hypervisor treats them as 4k PFNs.
- When unballooning or memory hotplugging, PFNs coming from the host
are 4k PFNs and they may not even be 64k aligned making it difficult
to handle.

While statistics and ballooning requests would be relatively easy to
handle by converting between guest and hypervisor page sizes in the
communication structures, handling unballooning and memory hotplug
requests seem to be harder. In particular, when ballooning up
alloc_balloon_pages() shatters huge pages so unballooning request can
be handled for any part of it. It is not possible to shatter a 64k
page into 4k pages so it's unclear how to handle unballooning for a
sub-range if such request ever comes so we can't just report a 64k
page as 16 separate 4k pages.

Ideally, the protocol between the guest and the host should be changed
to allow for different guest page sizes.

While there's no solution for the above mentioned problems, it seems
we're better off without the driver in problematic cases.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 drivers/hv/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
index 0747a8f1fcee..fb353a13e5c4 100644
--- a/drivers/hv/Kconfig
+++ b/drivers/hv/Kconfig
@@ -25,7 +25,7 @@ config HYPERV_UTILS
 
 config HYPERV_BALLOON
 	tristate "Microsoft Hyper-V Balloon driver"
-	depends on HYPERV
+	depends on HYPERV && (X86 || (ARM64 && ARM64_4K_PAGES))
 	select PAGE_REPORTING
 	help
 	  Select this option to enable Hyper-V Balloon driver.
-- 
2.33.1

