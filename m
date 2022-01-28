Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84ED749F756
	for <lists+linux-hyperv@lfdr.de>; Fri, 28 Jan 2022 11:34:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbiA1KeU (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 28 Jan 2022 05:34:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22651 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229555AbiA1KeT (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 28 Jan 2022 05:34:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643366058;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=sH8hNE8QNqDm4q7zd5u3rJiinzGbKInxk5HJjzs+H10=;
        b=cg8fj8KokKIngk5CEhzGKaYstArEgzJ1wwuw7M9OW/pwswLYvjehliQPWIQQCiELBC/k42
        cJTrmicgaFP1zrvmLk3rqRz7qd7hRgooXOXf7DJeRKr/APfIkZ4zjo+UaIwGNgLcK4S6h3
        5etcqIckWCSOf8rSiODPxl0fWLXOg+Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-424-6WeNzuTMM6-mjdlJpcAAcg-1; Fri, 28 Jan 2022 05:34:16 -0500
X-MC-Unique: 6WeNzuTMM6-mjdlJpcAAcg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8A81B1898292;
        Fri, 28 Jan 2022 10:34:15 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.40.193.77])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2D40D7B6D5;
        Fri, 28 Jan 2022 10:34:12 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     linux-hyperv@vger.kernel.org, Wei Liu <wei.liu@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Michael Kelley <mikelley@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>
Subject: [PATCH 0/2] Drivers: hv: Minor cleanup around init_vp_index()
Date:   Fri, 28 Jan 2022 11:34:10 +0100
Message-Id: <20220128103412.3033736-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Two minor changes with no functional change intended:
- s,alloced,allocated
- compare cpumasks and not their weights

Vitaly Kuznetsov (2):
  Drivers: hv: Rename 'alloced' to 'allocated'
  Drivers: hv: Compare cpumasks and not their weights in init_vp_index()

 drivers/hv/channel_mgmt.c | 19 +++++++++----------
 drivers/hv/hyperv_vmbus.h | 14 +++++++-------
 drivers/hv/vmbus_drv.c    |  2 +-
 3 files changed, 17 insertions(+), 18 deletions(-)

-- 
2.34.1

