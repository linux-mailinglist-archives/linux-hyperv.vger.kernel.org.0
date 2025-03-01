Return-Path: <linux-hyperv+bounces-4188-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E41A4ACC5
	for <lists+linux-hyperv@lfdr.de>; Sat,  1 Mar 2025 17:16:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D7A37A57B6
	for <lists+linux-hyperv@lfdr.de>; Sat,  1 Mar 2025 16:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E61E71DFD98;
	Sat,  1 Mar 2025 16:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ICWxcXXJ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 798FD2CA8;
	Sat,  1 Mar 2025 16:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740845800; cv=none; b=Qb8+J3vFpIfommZsjIHEw/mlvqYpPdD0phXkktkn8MY1YicYlJqN4PTy9MXkmqNa/oYZWxfaSuDR2mN3P5pTunU/SPWOASM0fb5KHY8zWt2YvoiWF3MOaKw2O9sR2o9YulOQuAcQ48CVW9VV+UZbt2zKmFai/Inen/BdqYC5Nx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740845800; c=relaxed/simple;
	bh=fgj8BWOyEI+YEMg+NBuRHMnmsl4uGmFu/x1CXxeKwEs=;
	h=From:To:Cc:Subject:Date:Message-Id; b=L37OHzU5dOZRdeFRuRY7XnsieK6SoL0cTRgYHY8DXWQlZzyfxXGxzXQ1YQgpgnZkeMeofK6Iu9Af3402nAp7Vd+bVt/h84yyBSfirt48zk4TetMDw1FmZ7pZnGjVNrPFAFUKb5v0JuG9lADyVNKi0nU2stu5gb2MO0Ti3bou1Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ICWxcXXJ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id DDEF72038A3D;
	Sat,  1 Mar 2025 08:16:38 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DDEF72038A3D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740845798;
	bh=sf8ttahzm+9GqpA9ajwAW7LpDIvZye2F3bcdngIic6g=;
	h=From:To:Cc:Subject:Date:From;
	b=ICWxcXXJHGq8jS1KvB/OX7qhnCv1s6h85Cg++CKY/Nfvxjd/argKjPyfUOOyAfjWV
	 +bjOb4nAYp1ddkFX5onJexMY8Z7zo7446B8VRRTIOJRTlfUQs8+R8swk7cvOlD0iUV
	 cSPcuUziRh8GrmqWq+FfT764yzlqkfrAdcFpdxXA=
From: Saurabh Sengar <ssengar@linux.microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	deller@gmx.de,
	akpm@linux-foundation.org,
	linux-hyperv@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: ssengar@microsoft.com,
	mhklinux@outlook.com
Subject: [PATCH v3 0/2] fbdev: hyperv_fb: framebuffer release cleanup
Date: Sat,  1 Mar 2025 08:16:29 -0800
Message-Id: <1740845791-19977-1-git-send-email-ssengar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

This patch series addresses an issue in the unbind path of the hyperv_fb
driver, which is resolved in the second patch of this series.

While working on this fix, it was observed that hvfb_putmem() and its
child functions could be cleaned up first to simplify the movement of
hvfb_putmem(). This cleanup is done in the first patch.

Although hvfb_getmem() could also be cleaned up, it depends on
vmbus_allocate_mmio(), which is used by multiple other drivers. Since
addressing hvfb_getmem() is independent of this fix, it will be handled
in a separate patch series.

[V3]
 - Add a patch 1 for cleanup of hvfb_putmem()
 - Use the simplified hvfb_putmem()

Saurabh Sengar (2):
  fbdev: hyperv_fb: Simplify hvfb_putmem
  fbdev: hyperv_fb: Allow graceful removal of framebuffer

 drivers/video/fbdev/hyperv_fb.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

-- 
2.43.0


