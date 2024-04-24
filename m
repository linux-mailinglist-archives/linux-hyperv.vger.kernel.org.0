Return-Path: <linux-hyperv+bounces-2040-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B63688B0766
	for <lists+linux-hyperv@lfdr.de>; Wed, 24 Apr 2024 12:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E71511C21C42
	for <lists+linux-hyperv@lfdr.de>; Wed, 24 Apr 2024 10:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8614E142E62;
	Wed, 24 Apr 2024 10:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="QthLMQ3O"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3B313DBB2;
	Wed, 24 Apr 2024 10:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713954821; cv=none; b=BzFmz2fwXOn6goSE1KF5dR9S9iWpZFrlOPdtzEVM8NKCWHPqnbJ+rN3DSiyx7fNzkpdz6OiBHgCxZcDU7JORaIaKO6MHv9xQDbWAwBnlQs3/B0fY7cNxwcG7HUJ3CIQ+K2axUjJ2N06T7nqICnx2l4Nqc32I9Y2pLGirWClVjMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713954821; c=relaxed/simple;
	bh=LDWhUK0jDEvgCD/wSr4IUcRjzC8SZUkMJLbsuVglrYo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=hFC5qY/snUHprD+uI0JgYEZqbGTpIK34Z1VSj+buASyvTrjWP9oLEHbhHn7AqnlqpTfjOYwABV/LeIc6NCUv/pp1I7ARPPJPaNgladCjGJjobkhVPttviu7TYOePkpOWmM8qJW4PGMrszxHPRGIrdB5/QPs6xI3hSu5+P6o0j6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=QthLMQ3O; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id E09C0208591D; Wed, 24 Apr 2024 03:33:39 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E09C0208591D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1713954819;
	bh=V1mal6zq+xdeJfcmGXIqdRpTal7N99j0myea4I6HSlE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QthLMQ3OGJ47JeoAeOwmOy2PnbZj8TbUaGhCtbHpoj/Dp9SZU4fZClI8Fnm/WU+UZ
	 UiKYfYchd9ESdwLW/HcP1eN1eWlNhz1evt+EEt8UG6iGj3gm50vMcP0s9ma0KO2nPQ
	 Ian4DEwomU69hf3sJHR4uXkTgclY3DFa5n+qjO98=
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
Subject: [PATCH net-next v2 1/2] net: Add sysfs atttributes for max_mtu min_mtu
Date: Wed, 24 Apr 2024 03:33:37 -0700
Message-Id: <1713954817-30133-1-git-send-email-shradhagupta@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1713954774-29953-1-git-send-email-shradhagupta@linux.microsoft.com>
References: <1713954774-29953-1-git-send-email-shradhagupta@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Add sysfs attributes to read max_mtu and min_mtu value for
network devices

Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
---
 Changes in v2:
 * Created a new patch for generic attributes
---
 Documentation/ABI/testing/sysfs-class-net | 16 ++++++++++++++++
 net/core/net-sysfs.c                      |  4 ++++
 2 files changed, 20 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-net b/Documentation/ABI/testing/sysfs-class-net
index ebf21beba846..f68f3b9be6ec 100644
--- a/Documentation/ABI/testing/sysfs-class-net
+++ b/Documentation/ABI/testing/sysfs-class-net
@@ -352,3 +352,19 @@ Description:
 		0  threaded mode disabled for this dev
 		1  threaded mode enabled for this dev
 		== ==================================
+
+What:           /sys/class/net/<iface>/max_mtu
+Date:           April 2024
+KernelVersion:  6.10
+Contact:        netdev@vger.kernel.org
+Description:
+                Indicates the interface's maximum supported MTU value, in
+                bytes, and in decimal format.
+
+What:           /sys/class/net/<iface>/min_mtu
+Date:           April 2024
+KernelVersion:  6.10
+Contact:        netdev@vger.kernel.org
+Description:
+                Indicates the interface's minimum supported MTU value, in
+                bytes, and in decimal format.
diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index e3d7a8cfa20b..525b85d47676 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -114,6 +114,8 @@ NETDEVICE_SHOW_RO(addr_len, fmt_dec);
 NETDEVICE_SHOW_RO(ifindex, fmt_dec);
 NETDEVICE_SHOW_RO(type, fmt_dec);
 NETDEVICE_SHOW_RO(link_mode, fmt_dec);
+NETDEVICE_SHOW_RO(max_mtu, fmt_dec);
+NETDEVICE_SHOW_RO(min_mtu, fmt_dec);
 
 static ssize_t iflink_show(struct device *dev, struct device_attribute *attr,
 			   char *buf)
@@ -671,6 +673,8 @@ static struct attribute *net_class_attrs[] __ro_after_init = {
 	&dev_attr_carrier_up_count.attr,
 	&dev_attr_carrier_down_count.attr,
 	&dev_attr_threaded.attr,
+	&dev_attr_max_mtu.attr,
+	&dev_attr_min_mtu.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(net_class);
-- 
2.34.1


