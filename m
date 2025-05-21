Return-Path: <linux-hyperv+bounces-5607-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 038CAABFE28
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 May 2025 22:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FD9D188BEB3
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 May 2025 20:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E43F32BD599;
	Wed, 21 May 2025 20:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bql3AOZW"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A584F2BD03B;
	Wed, 21 May 2025 20:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747860385; cv=none; b=cM70pyUuEt9vo8v9EVTI4RCIM1fgLVEVqUcIO57dVabUm4IGoWPKC72s30vZqGMI+n8RgYU0kvGwqMg54lEAXlMoMNpY8P7FSfXGEF0X5SFEboQjB1ong0y2+VUBJjLdbHmRoOcnlwLSVi/BCQbbINuUdJuhE+goMiCdG/+L40w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747860385; c=relaxed/simple;
	bh=Fru2a2wknGSBl0q6Nax0SDpUsXlR8ZDF7QEBrKNvk3E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bhEplBhczPTT7Ear4CfAoxIE2tct6A6bYChcUQnLfTxCya7khh2Q2BsIHY4qEa3nX1imKuWJDyKQy5lha/Jak/ZE8bfIZU84JkkNinVgAzcJTWQdd33HXh9pjy9vbEFCJnScGopMrIDNwoW1c0e2DX28EcdrXRHFey1XlDjgWcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bql3AOZW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37EADC4CEF3;
	Wed, 21 May 2025 20:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747860385;
	bh=Fru2a2wknGSBl0q6Nax0SDpUsXlR8ZDF7QEBrKNvk3E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Bql3AOZWaR4EFundCOS6uO3xYDlqFQVHPQEN+DSFX4oXQ0L2OP+QqSyp7t1INmVBo
	 ff2ReW7aCg+K/y9lxx1rIIIsl4A3U+oakODlYD8J+D28bg0h5g3giH9P3Q/FfaztS8
	 Uq4/Cd0aAKlLKlBG/5ef2AxcMCFhJ9w1fGmMyt4i/+Iu/OgFf4XaSqu5WOXNUw9aqE
	 UfwX5BecJXyzmuBlpQSHF2Hc/anoJfU9teheXtguBXEB4iagjq/a1KqnaANi+KKBLX
	 wbx7z/fKZuWRPg6aj5kVhWo84fFLJsDBTWZmh1Yrfm9AfnhbYdKx8puuhtfEK2rR/i
	 krLDsfgP6hpnw==
From: Kees Cook <kees@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Kees Cook <kees@kernel.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Cosmin Ratiu <cratiu@nvidia.com>,
	Lei Yang <leiyang@redhat.com>,
	Ido Schimmel <idosch@nvidia.com>,
	netdev@vger.kernel.org,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Mike Christie <michael.christie@oracle.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>,
	Maurizio Lombardi <mlombard@redhat.com>,
	Dmitry Bogdanov <d.bogdanov@yadro.com>,
	Mingzhe Zou <mingzhe.zou@easystack.cn>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Samuel Mendoza-Jonas <sam@mendozajonas.com>,
	Paul Fertser <fercerpav@gmail.com>,
	Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Hayes Wang <hayeswang@realtek.com>,
	Douglas Anderson <dianders@chromium.org>,
	Grant Grundler <grundler@chromium.org>,
	Jay Vosburgh <jv@jvosburgh.net>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jason Wang <jasowang@redhat.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Maxim Georgiev <glipus@gmail.com>,
	Aleksander Jan Bajkowski <olek2@wp.pl>,
	Philipp Hahn <phahn-oss@avm.de>,
	Eric Biggers <ebiggers@google.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Xiao Liang <shaw.leon@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org,
	linux-wpan@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH net-next v2 2/8] net: core: Switch netif_set_mac_address() to struct sockaddr_storage
Date: Wed, 21 May 2025 13:46:10 -0700
Message-Id: <20250521204619.2301870-2-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250521204310.it.500-kees@kernel.org>
References: <20250521204310.it.500-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4356; i=kees@kernel.org; h=from:subject; bh=Fru2a2wknGSBl0q6Nax0SDpUsXlR8ZDF7QEBrKNvk3E=; b=owGbwMvMwCVmps19z/KJym7G02pJDBl61tPs+/4v7AleJH1KqILpp5KVUPuWuIcz5Lftarm/o +7/q91VHaUsDGJcDLJiiixBdu5xLh5v28Pd5yrCzGFlAhnCwMUpABP59Zrhn93Sdg+zNqErm05k qr7i0E7dkuZ8YmZRmVjUnZzoqZ6xmxgZLpgE7/ma8rloRYndfcszeuKmb4o+zuXf5GsgcWyX55v bzAA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

In order to avoid passing around struct sockaddr that has a size the
compiler cannot reason about (nor track at runtime), convert
netif_set_mac_address() to take struct sockaddr_storage. This is just a
cast conversion, so there is are no binary changes. Following patches
will make actual allocation changes.

Acked-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Stanislav Fomichev <sdf@fomichev.me>
Cc: Cosmin Ratiu <cratiu@nvidia.com>
Cc: Lei Yang <leiyang@redhat.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Ido Schimmel <idosch@nvidia.com>
Cc: <netdev@vger.kernel.org>
---
 include/linux/netdevice.h |  2 +-
 net/core/dev.c            | 10 +++++-----
 net/core/dev_api.c        |  4 ++--
 net/core/rtnetlink.c      |  2 +-
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index ea9d335de130..47200a394a02 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -4212,7 +4212,7 @@ int netif_set_mtu(struct net_device *dev, int new_mtu);
 int dev_set_mtu(struct net_device *, int);
 int dev_pre_changeaddr_notify(struct net_device *dev, const char *addr,
 			      struct netlink_ext_ack *extack);
-int netif_set_mac_address(struct net_device *dev, struct sockaddr *sa,
+int netif_set_mac_address(struct net_device *dev, struct sockaddr_storage *ss,
 			  struct netlink_ext_ack *extack);
 int dev_set_mac_address(struct net_device *dev, struct sockaddr *sa,
 			struct netlink_ext_ack *extack);
diff --git a/net/core/dev.c b/net/core/dev.c
index fccf2167b235..f8c8aad7df2e 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -9655,7 +9655,7 @@ int dev_pre_changeaddr_notify(struct net_device *dev, const char *addr,
 }
 EXPORT_SYMBOL(dev_pre_changeaddr_notify);
 
-int netif_set_mac_address(struct net_device *dev, struct sockaddr *sa,
+int netif_set_mac_address(struct net_device *dev, struct sockaddr_storage *ss,
 			  struct netlink_ext_ack *extack)
 {
 	const struct net_device_ops *ops = dev->netdev_ops;
@@ -9663,15 +9663,15 @@ int netif_set_mac_address(struct net_device *dev, struct sockaddr *sa,
 
 	if (!ops->ndo_set_mac_address)
 		return -EOPNOTSUPP;
-	if (sa->sa_family != dev->type)
+	if (ss->ss_family != dev->type)
 		return -EINVAL;
 	if (!netif_device_present(dev))
 		return -ENODEV;
-	err = dev_pre_changeaddr_notify(dev, sa->sa_data, extack);
+	err = dev_pre_changeaddr_notify(dev, ss->__data, extack);
 	if (err)
 		return err;
-	if (memcmp(dev->dev_addr, sa->sa_data, dev->addr_len)) {
-		err = ops->ndo_set_mac_address(dev, sa);
+	if (memcmp(dev->dev_addr, ss->__data, dev->addr_len)) {
+		err = ops->ndo_set_mac_address(dev, ss);
 		if (err)
 			return err;
 	}
diff --git a/net/core/dev_api.c b/net/core/dev_api.c
index f9a160ab596f..b5f293e637d9 100644
--- a/net/core/dev_api.c
+++ b/net/core/dev_api.c
@@ -91,7 +91,7 @@ int dev_set_mac_address_user(struct net_device *dev, struct sockaddr *sa,
 
 	down_write(&dev_addr_sem);
 	netdev_lock_ops(dev);
-	ret = netif_set_mac_address(dev, sa, extack);
+	ret = netif_set_mac_address(dev, (struct sockaddr_storage *)sa, extack);
 	netdev_unlock_ops(dev);
 	up_write(&dev_addr_sem);
 
@@ -332,7 +332,7 @@ int dev_set_mac_address(struct net_device *dev, struct sockaddr *sa,
 	int ret;
 
 	netdev_lock_ops(dev);
-	ret = netif_set_mac_address(dev, sa, extack);
+	ret = netif_set_mac_address(dev, (struct sockaddr_storage *)sa, extack);
 	netdev_unlock_ops(dev);
 
 	return ret;
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 8a914b37ef6e..9743f1c2ae3c 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3100,7 +3100,7 @@ static int do_setlink(const struct sk_buff *skb, struct net_device *dev,
 
 		memcpy(sa->sa_data, nla_data(tb[IFLA_ADDRESS]),
 		       dev->addr_len);
-		err = netif_set_mac_address(dev, sa, extack);
+		err = netif_set_mac_address(dev, (struct sockaddr_storage *)sa, extack);
 		kfree(sa);
 		if (err) {
 			up_write(&dev_addr_sem);
-- 
2.34.1


