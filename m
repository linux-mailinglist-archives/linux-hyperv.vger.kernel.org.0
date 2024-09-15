Return-Path: <linux-hyperv+bounces-3022-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 385FA9794A4
	for <lists+linux-hyperv@lfdr.de>; Sun, 15 Sep 2024 06:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 606A31C21BF9
	for <lists+linux-hyperv@lfdr.de>; Sun, 15 Sep 2024 04:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375B311CAF;
	Sun, 15 Sep 2024 04:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="W6Dd31fd"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B73911B85CD;
	Sun, 15 Sep 2024 04:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726376187; cv=none; b=n5ywVrWrdZTvRTiSqpVXn4Li+lUAdvrveCj1Ki6xNcVLZZtMkA4cCx5oar6m4QPxajxRE5QsmZpx5Qtsv/Hm4V+20NODd5bxQx0RWrjHjp6grIlJVsRMlpzFmnCyFD6xRYZDkT4Cl13Ctaie7Vln9rgIRgXyqHTndqyCJhdDBUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726376187; c=relaxed/simple;
	bh=9w30dChxYIMmPxhl67+/YhDv8UAzy02LRnlwADKHBNg=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Tbt3iMr1STSbA9v2n5zE58Idlhf49eUqmUL2Ia6X53ixYpSsylOs/HhDex3pXXjTzaKv047kadHbXzmSIXHBeHJMG0//9iadOtMwAAacMqksnwgXNBcF4DsR4BbIeHORDIBCX5Sl4/i4Gm3BGnCGj94C1m/Y+xdHKR9RYZdUOsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=W6Dd31fd; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id 2ED1D20C08A3; Sat, 14 Sep 2024 21:56:25 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2ED1D20C08A3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1726376185;
	bh=N+lwgWnXJnJIv3ORmL8lZsGxIiQ/BGyrO1aZxWResDM=;
	h=From:To:Cc:Subject:Date:From;
	b=W6Dd31fdlCYaoBHGnUNiNgYBg4SHFoHewSeoHayK7WCFR7ECh3Bfk+yRFdiI3D/++
	 Je6I0S9nR6LcT6MrU8LyY/0/d4yHDuYCMe6a17I4Xp7vK6OuDtsX3iI+aETGDkUgP5
	 UQRO3XlqkPP4bFxi2Xsa3Yj9xYEbLyeYjxuPafzw=
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Cc: Shradha Gupta <shradhagupta@linux.microsoft.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Long Li <longli@microsoft.com>,
	Simon Horman <horms@kernel.org>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>,
	Erick Archer <erick.archer@outlook.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Shradha Gupta <shradhagupta@microsoft.com>
Subject: [PATCH net-next] net: mana: Increase the DEF_RX_BUFFERS_PER_QUEUE to 1024
Date: Sat, 14 Sep 2024 21:56:24 -0700
Message-Id: <1726376184-14874-1-git-send-email-shradhagupta@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Through some experiments, we found out that increasing the default
RX buffers count from 512 to 1024, gives slightly better throughput
and significantly reduces the no_wqe_rx errs on the receiver side.
Along with these, other parameters like cpu usage, retrans seg etc
also show some improvement with 1024 value.

Following are some snippets from the experiments

ntttcp tests with 512 Rx buffers
---------------------------------------
connections|  throughput|  no_wqe errs|
---------------------------------------
1          |  40.93Gbps | 123,211     |
16         | 180.15Gbps | 190,120
128        | 180.20Gbps | 173,508     |
256        | 180.27Gbps | 189,884     |

ntttcp tests with 1024 Rx buffers
---------------------------------------
connections|  throughput|  no_wqe errs|
---------------------------------------
1          |  44.22Gbps | 19,864      |
16         | 180.19Gbps | 4,430       |
128        | 180.21Gbps | 2,560       |
256        | 180.29Gbps | 1,529       |

So, increasing the default RX buffers per queue count to 1024

Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 include/net/mana/mana.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
index f2a5200d8a0f..9b0faa24b758 100644
--- a/include/net/mana/mana.h
+++ b/include/net/mana/mana.h
@@ -43,7 +43,7 @@ enum TRI_STATE {
  * size beyond this value gets rejected by __alloc_page() call.
  */
 #define MAX_RX_BUFFERS_PER_QUEUE 8192
-#define DEF_RX_BUFFERS_PER_QUEUE 512
+#define DEF_RX_BUFFERS_PER_QUEUE 1024
 #define MIN_RX_BUFFERS_PER_QUEUE 128
 
 /* This max value for TX buffers is derived as the maximum allocatable
-- 
2.34.1


