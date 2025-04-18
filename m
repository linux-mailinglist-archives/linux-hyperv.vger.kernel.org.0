Return-Path: <linux-hyperv+bounces-4967-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 857FFA92EDE
	for <lists+linux-hyperv@lfdr.de>; Fri, 18 Apr 2025 02:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 939B746631C
	for <lists+linux-hyperv@lfdr.de>; Fri, 18 Apr 2025 00:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E2652E401;
	Fri, 18 Apr 2025 00:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxonhyperv.com header.i=@linuxonhyperv.com header.b="etqfJq7v"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31E21BDCF;
	Fri, 18 Apr 2025 00:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744937001; cv=none; b=mdOdFH2h/qrmVSB33OWqBzTZK8uZ/9jXzcjJOFDrj6Rcv/wl06jgmQeOyveKPzZkWF/VYrmt5zB7lfujBDQBdK8MVFHcTZg77rNeCdKF9PpO8IRW3r7+ysa0R5/H5xEvlBEva3WMfe2uRnhj2ypY1kLtWA6fTAlBmGZMCT2M1VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744937001; c=relaxed/simple;
	bh=9TtSbYUfqH1uAFljPj9ZspGbpOpeNju38/AMbEh6tB8=;
	h=From:To:Cc:Subject:Date:Message-Id; b=VOb/6SNQB7F1i1k0936V6XUgzmVT7ieFrBdlbJ+7JrF0Rgfl5egLSXlY6N7qfjnKy6yG3c0/c3BjA4QTISnJ6DugB1cURLPWwTPXL5kpjxysXx4EQzKAiv5oR7bOkGKNbrb3sbVEWMFcPo30hZsMwdDrQM2xt/SEsr+dxOHY2tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxonhyperv.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linuxonhyperv.com header.i=@linuxonhyperv.com header.b=etqfJq7v; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1202)
	id 810FE205251B; Thu, 17 Apr 2025 17:43:19 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 810FE205251B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
	s=default; t=1744936999;
	bh=0xHP/+CAEd1JI/jblGUpBF22vKkR0lipHXYGRWStSyM=;
	h=From:To:Cc:Subject:Date:From;
	b=etqfJq7vRlY5MVeIrXhlve96KCJE6cja1I+Ka9N98eafq3/vVbyl436If/8HKzaOd
	 8KhvTYiK58Q/LWJx5A46wqJd0QQoCgKR30VRFiA5A4xQI/L36Mrv40BLdSau1mpsLm
	 cMSgSCHuY5M4jNBvJLhuizV7SmEKD+htB+Z0ejcM=
From: longli@linuxonhyperv.com
To: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Long Li <longli@microsoft.com>
Subject: [PATCH 0/2] Fix uio_hv_generic on 64k page systems
Date: Thu, 17 Apr 2025 17:43:15 -0700
Message-Id: <1744936997-7844-1-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

From: Long Li <longli@microsoft.com>

UIO framework requires the device memory aligned to page boundary.
Hyper-V may allocate some memory that is Hyper-V page aligned (4k)
but not system page aligned.

Fix this by having Hyper-V always allocate those pages on system page
boundary and expose them to user-mode.

Long Li (2):
  Drivers: hv: Allocate interrupt and monitor pages aligned to system
    page boundary
  uio_hv_generic: Use correct size for interrupt and monitor pages

 drivers/hv/hv_common.c       | 29 +++++++----------------------
 drivers/uio/uio_hv_generic.c |  4 ++--
 2 files changed, 9 insertions(+), 24 deletions(-)

-- 
2.34.1


