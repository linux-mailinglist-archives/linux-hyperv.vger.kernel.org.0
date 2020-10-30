Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 376B429FEC8
	for <lists+linux-hyperv@lfdr.de>; Fri, 30 Oct 2020 08:42:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgJ3Hmc (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 30 Oct 2020 03:42:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:51662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726094AbgJ3HlF (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 30 Oct 2020 03:41:05 -0400
Received: from mail.kernel.org (ip5f5ad5bb.dynamic.kabel-deutschland.de [95.90.213.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA94A24102;
        Fri, 30 Oct 2020 07:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604043664;
        bh=d/kKjG4wp1TUDYStQdVDPIhb0Ohf5JqUyt0zN/IS+xI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gVhBYk/J3hp0OJTv058z6m9lqQPSugTUcXz+keEBnc56r86skZvYPnX8fwRa66u76
         CPKWfnd15xctgyHEdKGowMpysLehDj2M7ZLJuuuEzCfdbiR+sR2lgv6Z446U+VGMqn
         TWEg6xfGdfSYdtNuNuMixQXVN100r18jf2qsXVUc=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kYP1x-004Ogn-TN; Fri, 30 Oct 2020 08:41:01 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 33/39] docs: ABI: stable: remove a duplicated documentation
Date:   Fri, 30 Oct 2020 08:40:52 +0100
Message-Id: <091e8de5543c280ceb47edcb3ab6d0e9f3fa085b.1604042072.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1604042072.git.mchehab+huawei@kernel.org>
References: <cover.1604042072.git.mchehab+huawei@kernel.org>
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
Acked-by: Wei Liu <wei.liu@kernel.org>
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

