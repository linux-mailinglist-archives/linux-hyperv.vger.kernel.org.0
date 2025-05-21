Return-Path: <linux-hyperv+bounces-5609-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E587ABFE2B
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 May 2025 22:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 235944A7D34
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 May 2025 20:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1FAD2BD5A3;
	Wed, 21 May 2025 20:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CY2dNAVQ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59732BD03D;
	Wed, 21 May 2025 20:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747860385; cv=none; b=aJECsbJW4adNU9/vwQ7QHxyjjwr9ydhQaKkC2Hy0WYt1P8WFHZugYi0SRPku3W9gGq0lJd/Mor5Io+1rgxPhEAnfGVvYYIodJqin7m77Ks4lNvQAmGmgYuZE53mD8DaZ3gKDchGV+QC35HzXDj6lrTEJDBdQB0+lIMaIoAMkTYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747860385; c=relaxed/simple;
	bh=i87MvUevoj8uyAYI8nnxISSHyUr7lFY0+y/mpyvJnDM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Eo2UJvAEI9dcWsx7oi9F1c60KpMj49G1sMm5P+hydSS/Rm5kVhhW0yHGw9cggVv68ZEOslB9GWPW3VbLhs5sBnF7GL6hU1/6xaNuI9lWt1OwjsqNllvFElWLv1jkESzTtK8+b5ai7P2nNhymO9aXXfhNhNrhsnKKE4OFPBwHnkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CY2dNAVQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A980C4CEF2;
	Wed, 21 May 2025 20:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747860385;
	bh=i87MvUevoj8uyAYI8nnxISSHyUr7lFY0+y/mpyvJnDM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CY2dNAVQhpEWYOAH6LEYhA76mSsj82yqs7kmpn3Uwa193qNSjS8a6PSz/MIGUJlJr
	 LIXooYQ9ZJ6ONBGbRFtKHotCRwaNRbqBHmhGi+4HNMv9KULQGZ5GhF0b+qXy6nS60x
	 vqDNWW+pjKAtv4LPs1o+EXmreG23KVQdmyYQ61DC2t5UsOQTcCSTZxXf7hnaIjQm99
	 F+BHuLr31NZQcuBldIjYgHv1pVzEz218++YXlt3RlY9RD7uEdPLDV9K7DzRIXIH7bW
	 7aPelkd1PlmufM4WWslbqIHcBh8J5eCadXRtsTUZUn8d/DYXx7LtAjJbMrtxnmQkpP
	 TiRPIftNERtcw==
From: Kees Cook <kees@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Kees Cook <kees@kernel.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Simon Horman <horms@kernel.org>,
	Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Samuel Mendoza-Jonas <sam@mendozajonas.com>,
	Paul Fertser <fercerpav@gmail.com>,
	Hayes Wang <hayeswang@realtek.com>,
	Douglas Anderson <dianders@chromium.org>,
	Grant Grundler <grundler@chromium.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Cosmin Ratiu <cratiu@nvidia.com>,
	Lei Yang <leiyang@redhat.com>,
	netdev@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-wpan@vger.kernel.org,
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
	Ido Schimmel <idosch@nvidia.com>,
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
	linux-hardening@vger.kernel.org
Subject: [PATCH net-next v2 6/8] net: core: Convert dev_set_mac_address() to struct sockaddr_storage
Date: Wed, 21 May 2025 13:46:14 -0700
Message-Id: <20250521204619.2301870-6-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250521204310.it.500-kees@kernel.org>
References: <20250521204310.it.500-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=13167; i=kees@kernel.org; h=from:subject; bh=i87MvUevoj8uyAYI8nnxISSHyUr7lFY0+y/mpyvJnDM=; b=owGbwMvMwCVmps19z/KJym7G02pJDBl61tPdwp8mOb2vEO4oPDfJ4LpHu2WD3iO7twdPTjTZz H0lcE5pRwkLgxgXg6yYIkuQnXuci8fb9nD3uYowc1iZQIYwcHEKwERkPBj+imQ08b7tCbvyIDPn oei3z8Xd7fruz9+Y/r4bk2ZVzqa8jOEzS07f2tmOfMpTWirPLV2ZxjnN3M73kjhD1+7nLOIP+lk B
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

All users of dev_set_mac_address() are now using a struct sockaddr_storage.
Convert the internal data type to struct sockaddr_storage, drop the casts,
and update pointer types.

Acked-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Jay Vosburgh <jv@jvosburgh.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Wei Liu <wei.liu@kernel.org>
Cc: Dexuan Cui <decui@microsoft.com>
Cc: Jiri Pirko <jiri@resnulli.us>
Cc: Simon Horman <horms@kernel.org>
Cc: Alexander Aring <alex.aring@gmail.com>
Cc: Stefan Schmidt <stefan@datenfreihafen.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Samuel Mendoza-Jonas <sam@mendozajonas.com>
Cc: Paul Fertser <fercerpav@gmail.com>
Cc: Hayes Wang <hayeswang@realtek.com>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Grant Grundler <grundler@chromium.org>
Cc: Stanislav Fomichev <sdf@fomichev.me>
Cc: Cosmin Ratiu <cratiu@nvidia.com>
Cc: Lei Yang <leiyang@redhat.com>
Cc: <netdev@vger.kernel.org>
Cc: <linux-hyperv@vger.kernel.org>
Cc: <linux-usb@vger.kernel.org>
Cc: <linux-wpan@vger.kernel.org>
---
 include/linux/netdevice.h       |  2 +-
 drivers/net/bonding/bond_alb.c  |  8 +++-----
 drivers/net/bonding/bond_main.c | 15 ++++++---------
 drivers/net/hyperv/netvsc_drv.c |  6 +++---
 drivers/net/macvlan.c           | 18 +++++++++---------
 drivers/net/team/team_core.c    |  2 +-
 drivers/net/usb/r8152.c         |  2 +-
 net/core/dev.c                  |  1 +
 net/core/dev_api.c              |  6 +++---
 net/ieee802154/nl-phy.c         |  2 +-
 net/ncsi/ncsi-manage.c          |  2 +-
 11 files changed, 30 insertions(+), 34 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 47200a394a02..b4242b997373 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -4214,7 +4214,7 @@ int dev_pre_changeaddr_notify(struct net_device *dev, const char *addr,
 			      struct netlink_ext_ack *extack);
 int netif_set_mac_address(struct net_device *dev, struct sockaddr_storage *ss,
 			  struct netlink_ext_ack *extack);
-int dev_set_mac_address(struct net_device *dev, struct sockaddr *sa,
+int dev_set_mac_address(struct net_device *dev, struct sockaddr_storage *ss,
 			struct netlink_ext_ack *extack);
 int dev_set_mac_address_user(struct net_device *dev, struct sockaddr *sa,
 			     struct netlink_ext_ack *extack);
diff --git a/drivers/net/bonding/bond_alb.c b/drivers/net/bonding/bond_alb.c
index 7edf0fd58c34..2d37b07c8215 100644
--- a/drivers/net/bonding/bond_alb.c
+++ b/drivers/net/bonding/bond_alb.c
@@ -1035,7 +1035,7 @@ static int alb_set_slave_mac_addr(struct slave *slave, const u8 addr[],
 	 */
 	memcpy(ss.__data, addr, len);
 	ss.ss_family = dev->type;
-	if (dev_set_mac_address(dev, (struct sockaddr *)&ss, NULL)) {
+	if (dev_set_mac_address(dev, &ss, NULL)) {
 		slave_err(slave->bond->dev, dev, "dev_set_mac_address on slave failed! ALB mode requires that the base driver support setting the hw address also when the network device's interface is open\n");
 		return -EOPNOTSUPP;
 	}
@@ -1273,8 +1273,7 @@ static int alb_set_mac_address(struct bonding *bond, void *addr)
 			break;
 		bond_hw_addr_copy(tmp_addr, rollback_slave->dev->dev_addr,
 				  rollback_slave->dev->addr_len);
-		dev_set_mac_address(rollback_slave->dev,
-				    (struct sockaddr *)&ss, NULL);
+		dev_set_mac_address(rollback_slave->dev, &ss, NULL);
 		dev_addr_set(rollback_slave->dev, tmp_addr);
 	}
 
@@ -1763,8 +1762,7 @@ void bond_alb_handle_active_change(struct bonding *bond, struct slave *new_slave
 				  bond->dev->addr_len);
 		ss.ss_family = bond->dev->type;
 		/* we don't care if it can't change its mac, best effort */
-		dev_set_mac_address(new_slave->dev, (struct sockaddr *)&ss,
-				    NULL);
+		dev_set_mac_address(new_slave->dev, &ss, NULL);
 
 		dev_addr_set(new_slave->dev, tmp_addr);
 	}
diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 98cf4486fcee..c4d53e8e7c15 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1112,8 +1112,7 @@ static void bond_do_fail_over_mac(struct bonding *bond,
 			ss.ss_family = bond->dev->type;
 		}
 
-		rv = dev_set_mac_address(new_active->dev,
-					 (struct sockaddr *)&ss, NULL);
+		rv = dev_set_mac_address(new_active->dev, &ss, NULL);
 		if (rv) {
 			slave_err(bond->dev, new_active->dev, "Error %d setting MAC of new active slave\n",
 				  -rv);
@@ -1127,8 +1126,7 @@ static void bond_do_fail_over_mac(struct bonding *bond,
 				  new_active->dev->addr_len);
 		ss.ss_family = old_active->dev->type;
 
-		rv = dev_set_mac_address(old_active->dev,
-					 (struct sockaddr *)&ss, NULL);
+		rv = dev_set_mac_address(old_active->dev, &ss, NULL);
 		if (rv)
 			slave_err(bond->dev, old_active->dev, "Error %d setting MAC of old active slave\n",
 				  -rv);
@@ -2127,7 +2125,7 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
 	}
 
 	ss.ss_family = slave_dev->type;
-	res = dev_set_mac_address(slave_dev, (struct sockaddr *)&ss, extack);
+	res = dev_set_mac_address(slave_dev, &ss, extack);
 	if (res) {
 		slave_err(bond_dev, slave_dev, "Error %d calling set_mac_address\n", res);
 		goto err_restore_mtu;
@@ -2455,7 +2453,7 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
 		bond_hw_addr_copy(ss.__data, new_slave->perm_hwaddr,
 				  new_slave->dev->addr_len);
 		ss.ss_family = slave_dev->type;
-		dev_set_mac_address(slave_dev, (struct sockaddr *)&ss, NULL);
+		dev_set_mac_address(slave_dev, &ss, NULL);
 	}
 
 err_restore_mtu:
@@ -2649,7 +2647,7 @@ static int __bond_release_one(struct net_device *bond_dev,
 		bond_hw_addr_copy(ss.__data, slave->perm_hwaddr,
 				  slave->dev->addr_len);
 		ss.ss_family = slave_dev->type;
-		dev_set_mac_address(slave_dev, (struct sockaddr *)&ss, NULL);
+		dev_set_mac_address(slave_dev, &ss, NULL);
 	}
 
 	if (unregister) {
@@ -4936,8 +4934,7 @@ static int bond_set_mac_address(struct net_device *bond_dev, void *addr)
 		if (rollback_slave == slave)
 			break;
 
-		tmp_res = dev_set_mac_address(rollback_slave->dev,
-					      (struct sockaddr *)&tmp_ss, NULL);
+		tmp_res = dev_set_mac_address(rollback_slave->dev, &tmp_ss, NULL);
 		if (tmp_res) {
 			slave_dbg(bond_dev, rollback_slave->dev, "%s: unwind err %d\n",
 				   __func__, tmp_res);
diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
index d8b169ac0343..14a0d04e21ae 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -1371,7 +1371,7 @@ static int netvsc_set_mac_addr(struct net_device *ndev, void *p)
 	struct net_device_context *ndc = netdev_priv(ndev);
 	struct net_device *vf_netdev = rtnl_dereference(ndc->vf_netdev);
 	struct netvsc_device *nvdev = rtnl_dereference(ndc->nvdev);
-	struct sockaddr *addr = p;
+	struct sockaddr_storage *addr = p;
 	int err;
 
 	err = eth_prepare_mac_addr_change(ndev, p);
@@ -1387,12 +1387,12 @@ static int netvsc_set_mac_addr(struct net_device *ndev, void *p)
 			return err;
 	}
 
-	err = rndis_filter_set_device_mac(nvdev, addr->sa_data);
+	err = rndis_filter_set_device_mac(nvdev, addr->__data);
 	if (!err) {
 		eth_commit_mac_addr_change(ndev, p);
 	} else if (vf_netdev) {
 		/* rollback change on VF */
-		memcpy(addr->sa_data, ndev->dev_addr, ETH_ALEN);
+		memcpy(addr->__data, ndev->dev_addr, ETH_ALEN);
 		dev_set_mac_address(vf_netdev, addr, NULL);
 	}
 
diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
index 7045b1d58754..4df991e494bd 100644
--- a/drivers/net/macvlan.c
+++ b/drivers/net/macvlan.c
@@ -754,13 +754,13 @@ static int macvlan_sync_address(struct net_device *dev,
 static int macvlan_set_mac_address(struct net_device *dev, void *p)
 {
 	struct macvlan_dev *vlan = netdev_priv(dev);
-	struct sockaddr *addr = p;
+	struct sockaddr_storage *addr = p;
 
-	if (!is_valid_ether_addr(addr->sa_data))
+	if (!is_valid_ether_addr(addr->__data))
 		return -EADDRNOTAVAIL;
 
 	/* If the addresses are the same, this is a no-op */
-	if (ether_addr_equal(dev->dev_addr, addr->sa_data))
+	if (ether_addr_equal(dev->dev_addr, addr->__data))
 		return 0;
 
 	if (vlan->mode == MACVLAN_MODE_PASSTHRU) {
@@ -768,10 +768,10 @@ static int macvlan_set_mac_address(struct net_device *dev, void *p)
 		return dev_set_mac_address(vlan->lowerdev, addr, NULL);
 	}
 
-	if (macvlan_addr_busy(vlan->port, addr->sa_data))
+	if (macvlan_addr_busy(vlan->port, addr->__data))
 		return -EADDRINUSE;
 
-	return macvlan_sync_address(dev, addr->sa_data);
+	return macvlan_sync_address(dev, addr->__data);
 }
 
 static void macvlan_change_rx_flags(struct net_device *dev, int change)
@@ -1295,11 +1295,11 @@ static void macvlan_port_destroy(struct net_device *dev)
 	 */
 	if (macvlan_passthru(port) &&
 	    !ether_addr_equal(port->dev->dev_addr, port->perm_addr)) {
-		struct sockaddr sa;
+		struct sockaddr_storage ss;
 
-		sa.sa_family = port->dev->type;
-		memcpy(&sa.sa_data, port->perm_addr, port->dev->addr_len);
-		dev_set_mac_address(port->dev, &sa, NULL);
+		ss.ss_family = port->dev->type;
+		memcpy(&ss.__data, port->perm_addr, port->dev->addr_len);
+		dev_set_mac_address(port->dev, &ss, NULL);
 	}
 
 	kfree(port);
diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
index d8fc0c79745d..a64e661c21a1 100644
--- a/drivers/net/team/team_core.c
+++ b/drivers/net/team/team_core.c
@@ -55,7 +55,7 @@ static int __set_port_dev_addr(struct net_device *port_dev,
 
 	memcpy(addr.__data, dev_addr, port_dev->addr_len);
 	addr.ss_family = port_dev->type;
-	return dev_set_mac_address(port_dev, (struct sockaddr *)&addr, NULL);
+	return dev_set_mac_address(port_dev, &addr, NULL);
 }
 
 static int team_port_set_orig_dev_addr(struct team_port *port)
diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index b18dee1b1bb3..d6589b24c68d 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -8432,7 +8432,7 @@ static int rtl8152_post_reset(struct usb_interface *intf)
 
 	/* reset the MAC address in case of policy change */
 	if (determine_ethernet_addr(tp, &ss) >= 0)
-		dev_set_mac_address(tp->netdev, (struct sockaddr *)&ss, NULL);
+		dev_set_mac_address(tp->netdev, &ss, NULL);
 
 	netdev = tp->netdev;
 	if (!netif_running(netdev))
diff --git a/net/core/dev.c b/net/core/dev.c
index f8c8aad7df2e..1f1900ec26b2 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -9683,6 +9683,7 @@ int netif_set_mac_address(struct net_device *dev, struct sockaddr_storage *ss,
 
 DECLARE_RWSEM(dev_addr_sem);
 
+/* "sa" is a true struct sockaddr with limited "sa_data" member. */
 int dev_get_mac_address(struct sockaddr *sa, struct net *net, char *dev_name)
 {
 	size_t size = sizeof(sa->sa_data_min);
diff --git a/net/core/dev_api.c b/net/core/dev_api.c
index b5f293e637d9..6011a5ef649d 100644
--- a/net/core/dev_api.c
+++ b/net/core/dev_api.c
@@ -319,20 +319,20 @@ EXPORT_SYMBOL(dev_set_allmulti);
 /**
  * dev_set_mac_address() - change Media Access Control Address
  * @dev: device
- * @sa: new address
+ * @ss: new address
  * @extack: netlink extended ack
  *
  * Change the hardware (MAC) address of the device
  *
  * Return: 0 on success, -errno on failure.
  */
-int dev_set_mac_address(struct net_device *dev, struct sockaddr *sa,
+int dev_set_mac_address(struct net_device *dev, struct sockaddr_storage *ss,
 			struct netlink_ext_ack *extack)
 {
 	int ret;
 
 	netdev_lock_ops(dev);
-	ret = netif_set_mac_address(dev, (struct sockaddr_storage *)sa, extack);
+	ret = netif_set_mac_address(dev, ss, extack);
 	netdev_unlock_ops(dev);
 
 	return ret;
diff --git a/net/ieee802154/nl-phy.c b/net/ieee802154/nl-phy.c
index ee2b190e8e0d..4c07a475c567 100644
--- a/net/ieee802154/nl-phy.c
+++ b/net/ieee802154/nl-phy.c
@@ -234,7 +234,7 @@ int ieee802154_add_iface(struct sk_buff *skb, struct genl_info *info)
 		 * dev_set_mac_address require RTNL_LOCK
 		 */
 		rtnl_lock();
-		rc = dev_set_mac_address(dev, (struct sockaddr *)&addr, NULL);
+		rc = dev_set_mac_address(dev, &addr, NULL);
 		rtnl_unlock();
 		if (rc)
 			goto dev_unregister;
diff --git a/net/ncsi/ncsi-manage.c b/net/ncsi/ncsi-manage.c
index 0202db2aea3e..b36947063783 100644
--- a/net/ncsi/ncsi-manage.c
+++ b/net/ncsi/ncsi-manage.c
@@ -1058,7 +1058,7 @@ static void ncsi_configure_channel(struct ncsi_dev_priv *ndp)
 		break;
 	case ncsi_dev_state_config_apply_mac:
 		rtnl_lock();
-		ret = dev_set_mac_address(dev, (struct sockaddr *)&ndp->pending_mac, NULL);
+		ret = dev_set_mac_address(dev, &ndp->pending_mac, NULL);
 		rtnl_unlock();
 		if (ret < 0)
 			netdev_warn(dev, "NCSI: 'Writing MAC address to device failed\n");
-- 
2.34.1


