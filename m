Return-Path: <linux-hyperv+bounces-4643-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98FD1A6A626
	for <lists+linux-hyperv@lfdr.de>; Thu, 20 Mar 2025 13:22:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2081817ACF0
	for <lists+linux-hyperv@lfdr.de>; Thu, 20 Mar 2025 12:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90FD3221DA6;
	Thu, 20 Mar 2025 12:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="XrEHnCM9"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1470E221D92;
	Thu, 20 Mar 2025 12:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742473345; cv=none; b=dEAlgwIWfkc6wziANQTGV+UCj6fPsHo2x104krE43v1p698CfWrt6IPvcT2MY/kDSr5LnwgEHk8ddgeBZiReTLw21FrPP6DUbWjBusS9/vu80hFVujcBrDAmmZo6o6gQu3hzlOATmZYpeDE2o52GoSp1zc6bOkctbIOW9KoPFoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742473345; c=relaxed/simple;
	bh=b9v858p0OIaRBMwtd4olUrdpUpSNpUSwYD8pwZH55AM=;
	h=From:To:Subject:Date:Message-Id; b=W7dHtG06962qZUx5wMFfZw5ohTJsfFBpW7J9lut64x8Ns7NFsilJY6GzCg5tqFhOOjI7PzNgZ25jXGhtsXu4OZ7uTUJij1pEof9BDjK86b/8sQDpqC/99t0LtaBScP1zkE9Bz8n3ly+2QMQrc+kNck58AO1+Iy/BtOVHs9OqNas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=XrEHnCM9; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 4F18D2116B34; Thu, 20 Mar 2025 05:22:23 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4F18D2116B34
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1742473343;
	bh=nmXuhRxA4O5/iLeq1TWM0swpJEXmF9yq9iS58rojMrw=;
	h=From:To:Subject:Date:From;
	b=XrEHnCM9bQSDvYdYumIFkdIg+C64BIaGVOO5dml1XMl70uD9tno+jiWtmdHBOfonQ
	 nNcB5P7Bp6rKip1IYN5w1X2o+yD7cJ5IxTE9dOEuPElJYjx1/IYibAdNuorlZVLofk
	 eGpwfzkh1OdHRkDQAM6ComdjKVs3NZYwO8ggFZSY=
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
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
	brett.creeley@amd.com,
	ernis@linux.microsoft.com,
	surenb@google.com,
	schakrabarti@linux.microsoft.com,
	kent.overstreet@linux.dev,
	shradhagupta@linux.microsoft.com,
	erick.archer@outlook.com,
	rosenp@gmail.com,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: [PATCH 0/3] Add support for speed in MANA ethtool
Date: Thu, 20 Mar 2025 05:22:18 -0700
Message-Id: <1742473341-15262-1-git-send-email-ernis@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Display speed information of the port via get_link_ksettings
ethtool operation using a HWC command MANA_QUERY_LINK_CONFIG
to fetch the speed information from the hardware.

Add support for mana_set_link_ksettings in MANA ethtool operation.
A HWC command (MANA_SET_BW_CLAMP) is sent to hardware to set
the bandwidth at specified speed.

This feature is not supported by all hardware. For any unsupported
clusters, the speed will be displayed as Unknown.

Erni Sri Satya Vennela (3):
  net: mana: Add speed support in mana_get_link_ksettings
  net: mana: Implement set_link_ksettings in ethtool for speed
  net: mana: Handle unsupported HWC commands

 .../net/ethernet/microsoft/mana/hw_channel.c  |  4 +
 drivers/net/ethernet/microsoft/mana/mana_en.c | 92 +++++++++++++++++++
 .../ethernet/microsoft/mana/mana_ethtool.c    | 19 ++++
 include/net/mana/mana.h                       | 33 +++++++
 4 files changed, 148 insertions(+)

-- 
2.34.1


