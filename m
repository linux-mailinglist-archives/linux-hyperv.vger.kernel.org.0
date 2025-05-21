Return-Path: <linux-hyperv+bounces-5586-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03055ABE866
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 May 2025 02:05:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C7644A44AC
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 May 2025 00:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CEA8186A;
	Wed, 21 May 2025 00:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="mByMJzwT"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21F4184;
	Wed, 21 May 2025 00:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747785915; cv=none; b=JvWGmmpjrESU3b6axe/sHUe9eFGmnDb14hg6Z6FSlYyLhsbr1gHb2Ip2puVGV35mc8ComlG2DP58xxGRZ5UWX+40vkbRwV3b5plz9odo6EzU9zwmZ8vZNAAtZBSo7R8AzDzf6XKt1/R5xinjOGIV7v9Fz3QVBW/OixyKDoCM/j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747785915; c=relaxed/simple;
	bh=5ZFwxb9nBkCINXBwK7WDelH3c0zwh3C4EzMiPPUMgiw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hwWKz5CejUmTbxj3zRBmNX45L/v1ZdxK6E1A+0MPVAu8WqiVZrY010ycuZye7sp0dh+M9nIQmUPi/+zhp9wZpd0qjhQpp5bZ5PJglhKAc7RgtdfYKBcNeInXsJqhhH+KJEHTLVmM/It04Pv+GOckav+y+MqkGCtB+aoqzZlWiWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=mByMJzwT; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747785914; x=1779321914;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AjC+PxuyUMb05WxAtrT+CDSka3468z6AHpnQ9tN4+4Q=;
  b=mByMJzwTnqVmFCchLuTdJU+DXokHl4wO8vOiQNSk1bjjHgtRkjZEhi7R
   jDs/ov/YzH2DJ2Mk/A9gxH3OpsEUkxTv8t9PyeOgkB3HzIQ4mLWBbeNb6
   delyC2RasjEvwVx+NB4ajJqXLiHqi+6mVzZzdZrq9tlM0vaiYsP8Guw1F
   drcq1GpnYVLeDPlAAiD5QjIL605xF3ibxbtlDBIwT+3/AGUWIrds/rchv
   ekOdhupqmyYApLaATspkz7XuviOePpaPidZXIZ1zkTIybpFJn0AGhgouW
   nXEqd6cexnW19+CnTuK/SE3tBxSt1zBCb1jDVQXSYmhouvBBgmQQmlry9
   g==;
X-IronPort-AV: E=Sophos;i="6.15,303,1739836800"; 
   d="scan'208";a="494410687"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 00:05:06 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:63604]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.29.53:2525] with esmtp (Farcaster)
 id 22b1456d-ef53-4eeb-baaf-b9aea32cf8a2; Wed, 21 May 2025 00:05:05 +0000 (UTC)
X-Farcaster-Flow-ID: 22b1456d-ef53-4eeb-baaf-b9aea32cf8a2
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 21 May 2025 00:05:05 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.171.41) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 21 May 2025 00:04:57 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kees@kernel.org>
CC: <ahmed.zaki@intel.com>, <aleksander.lobakin@intel.com>,
	<alex.aring@gmail.com>, <andrew+netdev@lunn.ch>, <ardb@kernel.org>,
	<christophe.leroy@csgroup.eu>, <cratiu@nvidia.com>, <d.bogdanov@yadro.com>,
	<davem@davemloft.net>, <decui@microsoft.com>, <dianders@chromium.org>,
	<ebiggers@google.com>, <edumazet@google.com>, <fercerpav@gmail.com>,
	<gmazyland@gmail.com>, <grundler@chromium.org>, <gustavoars@kernel.org>,
	<haiyangz@microsoft.com>, <hayeswang@realtek.com>, <hch@lst.de>,
	<horms@kernel.org>, <idosch@nvidia.com>, <jiri@resnulli.us>,
	<jv@jvosburgh.net>, <kch@nvidia.com>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<kys@microsoft.com>, <leiyang@redhat.com>, <linux-hardening@vger.kernel.org>,
	<linux-hyperv@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-nvme@lists.infradead.org>, <linux-scsi@vger.kernel.org>,
	<linux-usb@vger.kernel.org>, <linux-wpan@vger.kernel.org>,
	<linux@treblig.org>, <martin.petersen@oracle.com>, <mgurtovoy@nvidia.com>,
	<michael.christie@oracle.com>, <mingzhe.zou@easystack.cn>,
	<miquel.raynal@bootlin.com>, <mlombard@redhat.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <phahn-oss@avm.de>, <sagi@grimberg.me>,
	<sam@mendozajonas.com>, <sdf@fomichev.me>, <shaw.leon@gmail.com>,
	<stefan@datenfreihafen.org>, <target-devel@vger.kernel.org>,
	<viro@zeniv.linux.org.uk>, <wei.liu@kernel.org>
Subject: Re: [PATCH 1/7] net: core: Convert inet_addr_is_any() to sockaddr_storage
Date: Tue, 20 May 2025 17:04:46 -0700
Message-ID: <20250521000449.6279-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520223108.2672023-1-kees@kernel.org>
References: <20250520223108.2672023-1-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D045UWC004.ant.amazon.com (10.13.139.203) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Kees Cook <kees@kernel.org>
Date: Tue, 20 May 2025 15:31:00 -0700
> All the callers of inet_addr_is_any() have a sockaddr_storage-backed
> sockaddr. Avoid casts and switch prototype to the actual object being
> used.
> 
> Acked-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> Signed-off-by: Kees Cook <kees@kernel.org>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

