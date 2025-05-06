Return-Path: <linux-hyperv+bounces-5355-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0568AAAB8D5
	for <lists+linux-hyperv@lfdr.de>; Tue,  6 May 2025 08:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 944F33B62AC
	for <lists+linux-hyperv@lfdr.de>; Tue,  6 May 2025 06:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC79B2F4031;
	Tue,  6 May 2025 03:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxonhyperv.com header.i=@linuxonhyperv.com header.b="PmDKpH8e"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48322297A76;
	Tue,  6 May 2025 00:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746493007; cv=none; b=a14qtlyuQILSCBJse1gfuBZp0Xyw0foZIIMUDpXZ2kbjhmUJDYqop5ONY242nrEkHM0UP2DtwQFJ13OJkSXPTp1skzxp4KUYx2Qo2h5ouo2+PEE1SbbqpFbZGCyNFnmXDwX80sYy+n5vOgeLGoLmqPAfn3bFoNDkmVqJk1TYq9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746493007; c=relaxed/simple;
	bh=v/W1aM1MuNzXSODygweN18dljZ/ub2atw6+YAw+lTII=;
	h=From:To:Cc:Subject:Date:Message-Id; b=f7sTFFFMZ8PJOxCs/X8e7POPEuEi7f8szWiNKm4UENmBw3Zubdirl2Fh5IxIiSkuHbsXLaP8pdtyk1yEjY4c6liEYhOEsmuTpUWwSzhPakG0zXzF5GnAhW21gmhJk+foEZbqpYWqkT58A4rQr7WeeHGmok74kIsJXRVIZHZWpnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxonhyperv.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linuxonhyperv.com header.i=@linuxonhyperv.com header.b=PmDKpH8e; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1202)
	id 10762204E7F7; Mon,  5 May 2025 17:56:40 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 10762204E7F7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
	s=default; t=1746493000;
	bh=5Og7Z75KyR6u/BxtputNeS+3yNPqnOlEkKfpVTbR/mc=;
	h=From:To:Cc:Subject:Date:From;
	b=PmDKpH8eVXKUAEeRyNc7xPdDzuvV7U6mCN7Htdj7D84o9s3oRM39pkaIZPcSRR2Ud
	 8g52Eqv4TTk46t5RIAWGzKcYfR8L9+TiytpIs0w9R03IyFSUE1BTxKaYYoa/I4Z2Hx
	 jJKdA7ayBV7bomZAEF9ps8LpPGw45+zIPUj0tnxE=
From: longli@linuxonhyperv.com
To: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Long Li <longli@microsoft.com>
Subject: [Patch v3 0/5] Fix uio_hv_generic on systems with >4k page sizes
Date: Mon,  5 May 2025 17:56:32 -0700
Message-Id: <1746492997-4599-1-git-send-email-longli@linuxonhyperv.com>
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

Change in v2:
Added two more patches to the series:
"uio_hv_generic: Adjust ring size according to system page alignment"
"Drivers: hv: Remove hv_free/alloc_* helpers"

Added more details in the commit message of
"uio_hv_generic: Use correct size for interrupt and monitor pages"

Change in v3:
Rearranged the patch on removing hv_alloc/free* helpers
Added "Drivers: hv: Use kzalloc for panic page allocation"
Fixed typos.

Long Li (5):
  Drivers: hv: Allocate interrupt and monitor pages aligned to system
    page boundary
  uio_hv_generic: Use correct size for interrupt and monitor pages
  uio_hv_generic: Align ring size to system page
  Drivers: hv: Use kzalloc for panic page allocation
  Drivers: hv: Remove hv_alloc/free_* helpers

 drivers/hv/connection.c        | 23 ++++++++++++-----
 drivers/hv/hv_common.c         | 45 +++-------------------------------
 drivers/uio/uio_hv_generic.c   |  7 ++++--
 include/asm-generic/mshyperv.h |  4 ---
 4 files changed, 25 insertions(+), 54 deletions(-)

-- 
2.34.1


