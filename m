Return-Path: <linux-hyperv+bounces-3859-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0558CA2CFFB
	for <lists+linux-hyperv@lfdr.de>; Fri,  7 Feb 2025 22:46:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BCD1188B200
	for <lists+linux-hyperv@lfdr.de>; Fri,  7 Feb 2025 21:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F1181B4F0A;
	Fri,  7 Feb 2025 21:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxonhyperv.com header.i=@linuxonhyperv.com header.b="EaU60se4"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA221198E81;
	Fri,  7 Feb 2025 21:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738964799; cv=none; b=SVZ1HRn+SrbTL8eSZ6xJLNYolQr8Ie9JGTlj44xDe60QkHxsHq0tOvx/lTyaT5ndmiEguizTolW/AWWuTYo0s48VjrNGEN+KPT8WzO8F1LmeYoJAV39F8Dh9kPJ77t7P71L+cd78BNT0N5ersbNUnxyJnJZ6US8+ZTXbvSDrXTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738964799; c=relaxed/simple;
	bh=bG0GwKRCzVDPITLXIn+hrslhB/Bdl0rDkLP9TIC51EA=;
	h=From:To:Cc:Subject:Date:Message-Id; b=taVsu1dIAQXQB+j44JXln1K43yT1F4WT9/BKjzelU0TYuFlwjKQfCV2HXtQGuEGM4bjdIv2d9TvT2mpYkdcg7p/qFdxgFeBZeUcUsp4oeaFkrKKBlEffv4E6yqJRzQm+FPTjqfy2rBmak92HnIeJ0+1Kalf00PEGNMbYcr30CM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxonhyperv.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linuxonhyperv.com header.i=@linuxonhyperv.com header.b=EaU60se4; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1202)
	id 7B89E2107303; Fri,  7 Feb 2025 13:46:37 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7B89E2107303
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
	s=default; t=1738964797;
	bh=3qNqk4dztYJF3RUaf93xHthsUFS3KCS+MwDm4NkTJQk=;
	h=From:To:Cc:Subject:Date:From;
	b=EaU60se4OISMra3ceXL5GbxWTXmSKeq8NC+XRbUwDBNb04qj/K8fKPAL2u4xYhme/
	 vNtulAhqOS/nXLNRi4sdzh7PhMFVyqxv7RyUkDbjlVEGYg3xqmaedzBa8EMOWqg7zb
	 45tbJQej0BWyVGRP7JFUr0eYIsdWY0Hf/UXfXeJw=
From: longli@linuxonhyperv.com
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Ajay Sharma <sharmaajay@microsoft.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	Long Li <longli@microsoft.com>
Subject: [PATCH rdma-next] MAINTAINERS: update maintainer for Microsoft MANA RDMA driver
Date: Fri,  7 Feb 2025 13:46:28 -0800
Message-Id: <1738964792-21140-1-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

From: Long Li <longli@microsoft.com>

Ajay is no longer working on the MANA RDMA driver.

Konstantin Taranov has made significant contributions to implementing RC
QP in both kernel and user-mode.

He will take the responsibility of fixing bugs, reviewing patches and
developing new features for MANA RDMA driver.

Signed-off-by: Long Li <longli@microsoft.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0fa7c5728f1e..b43843e96e07 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15543,7 +15543,7 @@ F:	include/uapi/linux/cciss*.h
 
 MICROSOFT MANA RDMA DRIVER
 M:	Long Li <longli@microsoft.com>
-M:	Ajay Sharma <sharmaajay@microsoft.com>
+M:	Konstantin Taranov <kotaranov@microsoft.com>
 L:	linux-rdma@vger.kernel.org
 S:	Supported
 F:	drivers/infiniband/hw/mana/
-- 
2.34.1


