Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 266B029D6AE
	for <lists+linux-hyperv@lfdr.de>; Wed, 28 Oct 2020 23:17:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731530AbgJ1WR1 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 28 Oct 2020 18:17:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:60520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731515AbgJ1WR1 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 28 Oct 2020 18:17:27 -0400
Received: from mail.kernel.org (ip5f5ad5b2.dynamic.kabel-deutschland.de [95.90.213.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F5EC247DC;
        Wed, 28 Oct 2020 14:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603895016;
        bh=V55kML6ZxYgrWh9dQxvA0NQQHIIGvXnirU8tS4cgqss=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Nk1iOBv6NAXLWub3+kQYCsPMMnXXyVWBxNTYQBAxUFUana3YS4FGJfxKHWN7w8sDa
         dACx4aBx56ySCIt9vsvJMtF23kC/cSz9Tbd9xmmJ6bhdvfefJtvw4yMsIl90wgsmFs
         h+Nh8pCR0ljh0/pIZCaTALP6TONt1cVUIO0ciPPk=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kXmMQ-003hmE-1L; Wed, 28 Oct 2020 15:23:34 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 32/33] docs: ABI: stable: remove a duplicated documentation
Date:   Wed, 28 Oct 2020 15:23:30 +0100
Message-Id: <b0138bf07d3933ce023229e718abca279c29a994.1603893146.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1603893146.git.mchehab+huawei@kernel.org>
References: <cover.1603893146.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Perhaps due to a wrong cut-and-paste, this entry:

	What:		/sys/bus/vmbus/devices/<UUID>/channels/<N>/cpu

was added twice by the same patch, one following the other.

Remove the duplication.

Fixes: c2e5df616e1a ("vmbus: add per-channel sysfs info")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/ABI/stable/sysfs-bus-vmbus | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/Documentation/ABI/stable/sysfs-bus-vmbus b/Documentation/ABI/stable/sysfs-bus-vmbus
index 8e8d167eca31..c27b7b89477c 100644
--- a/Documentation/ABI/stable/sysfs-bus-vmbus
+++ b/Documentation/ABI/stable/sysfs-bus-vmbus
@@ -63,13 +63,6 @@ Contact:	Stephen Hemminger <sthemmin@microsoft.com>
 Description:	VCPU (sub)channel is affinitized to
 Users:		tools/hv/lsvmbus and other debugging tools
 
-What:		/sys/bus/vmbus/devices/<UUID>/channels/<N>/cpu
-Date:		September. 2017
-KernelVersion:	4.14
-Contact:	Stephen Hemminger <sthemmin@microsoft.com>
-Description:	VCPU (sub)channel is affinitized to
-Users:		tools/hv/lsvmbus and other debugging tools
-
 What:		/sys/bus/vmbus/devices/<UUID>/channels/<N>/in_mask
 Date:		September. 2017
 KernelVersion:	4.14
-- 
2.26.2

