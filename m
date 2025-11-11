Return-Path: <linux-hyperv+bounces-7493-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B24C4C51E
	for <lists+linux-hyperv@lfdr.de>; Tue, 11 Nov 2025 09:15:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BEB8C34F946
	for <lists+linux-hyperv@lfdr.de>; Tue, 11 Nov 2025 08:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63BA2314A67;
	Tue, 11 Nov 2025 08:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Ge86m7n6"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC172EAB70;
	Tue, 11 Nov 2025 08:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762848878; cv=none; b=Bfazboc4Ho6nsLnLyzPAU7rPT2TFJ8FsCIzSqndzCmluQWknx97KYT3bRYi/MZZxykeuCOxo05L7daT6/ML5sz/45cePKshVImGvfRiETo0HNBh5vmjrmMjJLRsSpEgEeFpQ77oZOY1jKZ5yH0wVM1jiFbQP1IIKaGewSGluPVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762848878; c=relaxed/simple;
	bh=Qwo3rPU9Fh7kPz/WyZaXKxKAT3VS4DQqUY/wyUb3dxI=;
	h=From:To:Cc:Subject:Date:Message-Id; b=jBYlBctABVssau5mV/vySM1z2SjxOll3MFv2XVE3OCf7hhT186QXFZXLcOu0k5DG3R1N+KFIC4Hnu4t7xVEUJxdjVdQeDpo4doqXbwKcDFeUZjvHFo1mAvj4yBPvja+NFIOqwiH76eXz0H742hhY/DHXWL5o7m2I7K7+tL6jWSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Ge86m7n6; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1231)
	id 76182212AE41; Tue, 11 Nov 2025 00:14:36 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 76182212AE41
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1762848876;
	bh=Q7YowF45bfdEhm2L9J/KmqosdLFilrexEOPDfkd4Od0=;
	h=From:To:Cc:Subject:Date:From;
	b=Ge86m7n6Kh9zazc627rUF17vJttULKpRkGksc+b/J3Y3JuVNn5yu3znxHyE9Q7VbE
	 fEDBhyrFniCL6RVL7MgX71wPQhWMM/+76jNEYvzyeaZQ7AZrLanIvAP/fK2cxbt1BT
	 jsdczkUO5eJgXoCokzm1F0wQpvO1XitIHv74Se0c=
From: Aditya Garg <gargaditya@linux.microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	longli@microsoft.com,
	kotaranov@microsoft.com,
	horms@kernel.org,
	shradhagupta@linux.microsoft.com,
	ssengar@linux.microsoft.com,
	ernis@linux.microsoft.com,
	dipayanroy@linux.microsoft.com,
	shirazsaleem@microsoft.com,
	leon@kernel.org,
	mlevitsk@redhat.com,
	yury.norov@gmail.com,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	gargaditya@microsoft.com
Cc: Aditya Garg <gargaditya@linux.microsoft.com>
Subject: [PATCH net-next v3 0/2] net: mana: Enforce TX SGE limit and fix error cleanup
Date: Tue, 11 Nov 2025 00:12:59 -0800
Message-Id: <1762848781-357-1-git-send-email-gargaditya@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Add pre-transmission checks to block SKBs that exceed the hardware's SGE 
limit. Force software segmentation for GSO traffic and linearize non-GSO 
packets as needed.

Update TX error handling to drop failed SKBs and unmap resources 
immediately.

Aditya Garg (2):
  net: mana: Handle SKB if TX SGEs exceed hardware limit
  net: mana: Drop TX skb on post failure and unmap resources

 .../net/ethernet/microsoft/mana/gdma_main.c   |  1 -
 drivers/net/ethernet/microsoft/mana/mana_en.c | 44 ++++++++++++++++---
 .../ethernet/microsoft/mana/mana_ethtool.c    |  2 +
 include/net/mana/gdma.h                       |  6 ++-
 include/net/mana/mana.h                       |  2 +
 5 files changed, 47 insertions(+), 8 deletions(-)

-- 
2.43.0


