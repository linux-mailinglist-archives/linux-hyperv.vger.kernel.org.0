Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D337A1D9CCD
	for <lists+linux-hyperv@lfdr.de>; Tue, 19 May 2020 18:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729417AbgESQdU (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 19 May 2020 12:33:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:46454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729400AbgESQdR (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 19 May 2020 12:33:17 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 566432084C;
        Tue, 19 May 2020 16:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589905997;
        bh=hj4+aDlyCCczCFo/NFqRHPo0CtYhTwWBBDnNyGdYbXw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P5HkZwJ+EeMn18kHufDBdBOyMA/MgPV1yKej26eCe38e+AJ6JQTn44WNgn3xgSHSp
         p8s/sBv5TIlbmZVW5UPLiuDdFestdaRE4tKazfdyZnwsN6+f7LwWeVZ5kYt8Bk0TNL
         Wks9+uzBU48V2I4avBGuvTvnx8EnmCCEB6/AJ4mA=
From:   Sasha Levin <sashal@kernel.org>
To:     alexander.deucher@amd.com, chris@chris-wilson.co.uk,
        ville.syrjala@linux.intel.com, Hawking.Zhang@amd.com,
        tvrtko.ursulin@intel.com
Cc:     linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, spronovo@microsoft.com, iourit@microsoft.com,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        gregkh@linuxfoundation.org, Sasha Levin <sashal@kernel.org>
Subject: [RFC PATCH 4/4] gpu: dxgkrnl: create a MAINTAINERS entry
Date:   Tue, 19 May 2020 12:32:34 -0400
Message-Id: <20200519163234.226513-5-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200519163234.226513-1-sashal@kernel.org>
References: <20200519163234.226513-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e64e5db31497..dccdfadda5df 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4997,6 +4997,13 @@ F:	Documentation/filesystems/dnotify.txt
 F:	fs/notify/dnotify/
 F:	include/linux/dnotify.h
 
+DirectX GPU DRIVER
+M:	Sasha Levin <sashal@kernel.org>
+M:	Iouri Tarassov <iourit@microsoft.com>
+L:	linux-hyperv@vger.kernel.org
+S:	Supported
+F:	drivers/gpu/dxgcore/
+
 DISK GEOMETRY AND PARTITION HANDLING
 M:	Andries Brouwer <aeb@cwi.nl>
 S:	Maintained
-- 
2.25.1

