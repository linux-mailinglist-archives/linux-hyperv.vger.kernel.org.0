Return-Path: <linux-hyperv+bounces-2039-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C01988B0763
	for <lists+linux-hyperv@lfdr.de>; Wed, 24 Apr 2024 12:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA0041C217DE
	for <lists+linux-hyperv@lfdr.de>; Wed, 24 Apr 2024 10:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35FD142621;
	Wed, 24 Apr 2024 10:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="gros7Kmr"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DEE8433AD;
	Wed, 24 Apr 2024 10:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713954786; cv=none; b=ftdb52ypxg1SGS1lwCca2Mu/GEGBHx8+dazLe0JSfrEDnBYFw/0cIPmJkX4TD4uCIhYv4foDCwBKOQ/g7GXkhvtAN2bG/T8Ea6P+0UzK74ki+sALM8Bx9jUfUOk51J7EM0rImb8NHiWXo0rBsn0tGzECdRJI5pEzsIFEx9YvJCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713954786; c=relaxed/simple;
	bh=jCVljMfq1PpKaWHeVUKrIL8LOKqChFRbFlWU60rpjRo=;
	h=From:To:Cc:Subject:Date:Message-Id; b=O1RFW3m0XY4hYWpkqqNvHaZBEXxpx6Ny58zWYMfsxvAdwHgHfjy7p9WF/dNtuYEApnhmwRxXL3yuPtRTkQP2aUD1kAR7QaTkCq4/28of7rvCwOircnlqNhrkVp5oKhMDTPg2D5R+xO72qzxFuCGUAzuEGqVepi/oNiRibxgSto8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=gros7Kmr; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id C9E19208591D; Wed, 24 Apr 2024 03:33:02 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C9E19208591D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1713954782;
	bh=LzzCfUU9HvnZaQBq2MUqtGpeAstNrDhVt8hKpFsSmes=;
	h=From:To:Cc:Subject:Date:From;
	b=gros7KmrRv5FTZZZxQQEGeft3ZsQGpTtO5qnaHhPn4Rg+CnlajHylcHiA6YTmr/5S
	 5YwZ+Ggu6H2izV2gB4pFkOzK/exXeJBuSVLt/0z8rVLnwsrGtnyGVyLHO6WB9+RhNg
	 twxinsWdzgnqf/KaCHvUPh93bkIJ/9aqBIKiwXLM=
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Johannes Berg <johannes.berg@intel.com>,
	Breno Leitao <leitao@debian.org>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Yury Norov <yury.norov@gmail.com>,
	linux-hyperv@vger.kernel.org
Cc: Shradha Gupta <shradhagupta@linux.microsoft.com>,
	shradhagupta@microsoft.com
Subject: [PATCH net-next v2 0/2] Add sysfs attributes for MANA
Date: Wed, 24 Apr 2024 03:32:54 -0700
Message-Id: <1713954774-29953-1-git-send-email-shradhagupta@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

These patches include adding sysfs attributes for improving
debuggability on MANA devices.

The first patch consists on max_mtu, min_mtu attributes that are
implemented generically for all devices

The second patch has mana specific attributes max_num_msix and num_ports

Shradha Gupta (2):
  net: Add sysfs atttributes for max_mtu min_mtu
  net: mana: Add new device attributes for mana

 Documentation/ABI/testing/sysfs-class-net     | 16 ++++++++++
 .../net/ethernet/microsoft/mana/gdma_main.c   | 32 +++++++++++++++++++
 net/core/net-sysfs.c                          |  4 +++
 3 files changed, 52 insertions(+)

-- 
2.34.1


