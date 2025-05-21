Return-Path: <linux-hyperv+bounces-5587-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F0EABE87B
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 May 2025 02:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F7AE4A85D9
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 May 2025 00:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2934D8CE;
	Wed, 21 May 2025 00:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="To3jBKwf"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D64679D2;
	Wed, 21 May 2025 00:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747786798; cv=none; b=mO+ZIWHpiHfvqVq84076r5A9dp+WeSqMg3MdmnNbCHiV1qkwWQ5f49q+PRi9Z6JlAohZbep3siXYwQicPTo8c2RCkAgQ4cME9kZR7Hrttzyv5Y/pnR6k+3IQvOz0id5C7SaZQfLCk+97EJDxE9suJstWqjgnGqO5FrlEmedDJo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747786798; c=relaxed/simple;
	bh=OFMybc4kDgXIwCtMw7uWmySrO/fD7npn2Bwdcl/Yhlg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EjtbtE7Havpjvgj8UMfiYQdNUtxB0M7gZIxs8qewyMkuxqlREpN3thnTpYKjKMuPF2OhuAgOKzxscFCNEqeZwWDb3+MprxgJEs7rds67padrH+0a2q7mHACsBTkV9VEKbBOc9QuHPRNHMgn/qVjsQyGywxxjulcnQAILVYsdST0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=To3jBKwf; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747786796; x=1779322796;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=M8x9xVJbTJ6ZOrCEE1Hl8YcOSI9042SY+wnYiiCHovQ=;
  b=To3jBKwfBhY9uSbKxMF7/RJdtmCTvdv98vcSFkJOaQiYDSBNBv/5C64+
   eGobvFQMz07FjU+YE1tvEbXXidnEWBog1G17+ktLFYZaBmWoNluxnh3q0
   l0UI5feNY+KqW9satC6yZPNrb/UZeC6MtV21V9RJN70tk82KJNEsIamGb
   GARYAnOaY8uWyPe6pmQF7twq4a4w+DOVgqKpLZ/QcL8wyMBgnR9A3w5SW
   vbcNkApvvQj5F9Nlo9hwEoFjjIGyQpdRINJH4PVqP1bxK8HlhltFKypDq
   UIB2R2z+vGlRmSSOiZEPgFqU42jwFMybNrLSNpwFeGKMia8a4YvMo29UN
   Q==;
X-IronPort-AV: E=Sophos;i="6.15,303,1739836800"; 
   d="scan'208";a="95451227"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 00:19:49 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:8022]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.26.241:2525] with esmtp (Farcaster)
 id a87e7087-986a-42c5-9bfb-1c06732e239e; Wed, 21 May 2025 00:19:48 +0000 (UTC)
X-Farcaster-Flow-ID: a87e7087-986a-42c5-9bfb-1c06732e239e
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 21 May 2025 00:19:47 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.171.41) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 21 May 2025 00:19:39 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kees@kernel.org>
CC: <ahmed.zaki@intel.com>, <aleksander.lobakin@intel.com>,
	<alex.aring@gmail.com>, <andrew+netdev@lunn.ch>, <ardb@kernel.org>,
	<christophe.leroy@csgroup.eu>, <cratiu@nvidia.com>, <d.bogdanov@yadro.com>,
	<davem@davemloft.net>, <decui@microsoft.com>, <dianders@chromium.org>,
	<ebiggers@google.com>, <edumazet@google.com>, <fercerpav@gmail.com>,
	<gmazyland@gmail.com>, <grundler@chromium.org>, <haiyangz@microsoft.com>,
	<hayeswang@realtek.com>, <hch@lst.de>, <horms@kernel.org>,
	<idosch@nvidia.com>, <jiri@resnulli.us>, <jv@jvosburgh.net>,
	<kch@nvidia.com>, <kuba@kernel.org>, <kuniyu@amazon.com>,
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
Subject: Re: [PATCH 0/7] net: Convert dev_set_mac_address() to struct sockaddr_storage
Date: Tue, 20 May 2025 17:19:20 -0700
Message-ID: <20250521001931.7761-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520222452.work.063-kees@kernel.org>
References: <20250520222452.work.063-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWA003.ant.amazon.com (10.13.139.44) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Kees Cook <kees@kernel.org>
Date: Tue, 20 May 2025 15:30:59 -0700
> Hi,
> 
> As part of the effort to allow the compiler to reason about object sizes,
> we need to deal with the problematic variably sized struct sockaddr,
> which has no internal runtime size tracking. In much of the network
> stack the use of struct sockaddr_storage has been adopted. Continue the
> transition toward this for more of the internal APIs. Specifically:
> 
> - inet_addr_is_any()
> - netif_set_mac_address()
> - dev_set_mac_address()
> 
> Only 3 callers of dev_set_mac_address() needed adjustment; all others
> were already using struct sockaddr_storage internally.

I guess dev_set_mac_address_user() was missed on the way ?

For example, tap_ioctl() still uses sockaddr and calls
dev_set_mac_address_user(), which cast it to _storage.

