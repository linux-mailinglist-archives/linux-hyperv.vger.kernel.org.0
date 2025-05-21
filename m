Return-Path: <linux-hyperv+bounces-5612-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A34ABFE54
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 May 2025 22:48:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1067A1BC5B61
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 May 2025 20:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021FB2BEC2A;
	Wed, 21 May 2025 20:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fBTJp1Ai"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D992BE0E1;
	Wed, 21 May 2025 20:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747860386; cv=none; b=R93WFV9FnUZbFTKwC3uj0aeqBvGdrXgeI8BW8TV4Q7aqPa1oeWmzwL/DVz1z5yFUm4CQjGni8jdSO/kTqVqBxxtgVbztMMk91QUeFlFsT7EDaWd84UDJJeXfLwg3GUwNILkJlr+PgqS2It0i2yGbf+NkOY7V8LflFjh/ik0t5/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747860386; c=relaxed/simple;
	bh=uukxrEpJUYAyupSlleSqs7Dnu8Ku05Cf2zA1scbEPws=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R6gOcEJylfmg22K5ULim9j5Qk5wyJ24XfZpLbOIHqWAhyq/ub0p3KtPupDNIv4XDHE8Kouefk325goefK2qZ4I5SRemE0xCXINsHLQ7pAS8qwKISwuQyRd5QxWrgzWMfkgtc5NzyMb6mr86spe4Uz2Fc23NYCTsBNLNwwv2RMk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fBTJp1Ai; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18E6FC4CEF1;
	Wed, 21 May 2025 20:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747860386;
	bh=uukxrEpJUYAyupSlleSqs7Dnu8Ku05Cf2zA1scbEPws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fBTJp1Aipta+gv7edcYonzjM2tkxkmReYflq95ozqHQ9fIyJA+9hvQzZjaDrCQH5u
	 sS5yaj7Zooxfty8T4FI0zqqis2BxQ7LM27ImicICpU/DpXNiG0WYYSrY5Ox397CNtz
	 /Lm8W108V3ClijzV05IuwLsbhHpETeNClTl8DTx1TKrlJwOHVzuBMScBbOx4ClkcsI
	 bRxzp6y0wO7zEpWcOO0jNf+d5ZWmJJijJRge3pZmMY/s8kIxsnLvin7EuM/LPBae73
	 iVcjt+q3Iskqn5RgQAjomzRDkTU68eu0gQ3Ra65DX17glfUBipzsgjklF59lJ1yiZT
	 YVbezXOD4QP+Q==
From: Kees Cook <kees@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Kees Cook <kees@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Cosmin Ratiu <cratiu@nvidia.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Maxim Georgiev <glipus@gmail.com>,
	netdev@vger.kernel.org,
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
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Lei Yang <leiyang@redhat.com>,
	Ido Schimmel <idosch@nvidia.com>,
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
Subject: [PATCH net-next v2 8/8] net: core: Convert dev_set_mac_address_user() to use struct sockaddr_storage
Date: Wed, 21 May 2025 13:46:16 -0700
Message-Id: <20250521204619.2301870-8-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250521204310.it.500-kees@kernel.org>
References: <20250521204310.it.500-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5481; i=kees@kernel.org; h=from:subject; bh=uukxrEpJUYAyupSlleSqs7Dnu8Ku05Cf2zA1scbEPws=; b=owGbwMvMwCVmps19z/KJym7G02pJDBl61jM2yvHveiO5bCO79hbl2xaaia+7dH6tKefuW3NeW oH30HebjlIWBjEuBlkxRZYgO/c4F4+37eHucxVh5rAygQxh4OIUgIl4ujP8TzXgvz1rLdPhJvMc ifokhpB3NWdP3Wlj/MzwS6tqucLENwz/i9PmCR2I//nx7YRNT9ftYvna3xWiMoGnfp7/pl3btjw OZQIA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Convert callers of dev_set_mac_address_user() to use struct
sockaddr_storage. Add sanity checks on dev->addr_len usage.

Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>
Cc: Stanislav Fomichev <sdf@fomichev.me>
Cc: Cosmin Ratiu <cratiu@nvidia.com>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Kory Maincent <kory.maincent@bootlin.com>
Cc: Maxim Georgiev <glipus@gmail.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: <netdev@vger.kernel.org>
---
 include/linux/netdevice.h |  2 +-
 drivers/net/tap.c         | 14 +++++++++-----
 drivers/net/tun.c         |  8 +++++++-
 net/core/dev_api.c        |  5 +++--
 net/core/dev_ioctl.c      |  6 ++++--
 5 files changed, 24 insertions(+), 11 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index b4242b997373..adb14db25798 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -4216,7 +4216,7 @@ int netif_set_mac_address(struct net_device *dev, struct sockaddr_storage *ss,
 			  struct netlink_ext_ack *extack);
 int dev_set_mac_address(struct net_device *dev, struct sockaddr_storage *ss,
 			struct netlink_ext_ack *extack);
-int dev_set_mac_address_user(struct net_device *dev, struct sockaddr *sa,
+int dev_set_mac_address_user(struct net_device *dev, struct sockaddr_storage *ss,
 			     struct netlink_ext_ack *extack);
 int dev_get_mac_address(struct sockaddr *sa, struct net *net, char *dev_name);
 int dev_get_port_parent_id(struct net_device *dev,
diff --git a/drivers/net/tap.c b/drivers/net/tap.c
index d4ece538f1b2..bdf0788d8e66 100644
--- a/drivers/net/tap.c
+++ b/drivers/net/tap.c
@@ -923,7 +923,7 @@ static long tap_ioctl(struct file *file, unsigned int cmd,
 	unsigned int __user *up = argp;
 	unsigned short u;
 	int __user *sp = argp;
-	struct sockaddr sa;
+	struct sockaddr_storage ss;
 	int s;
 	int ret;
 
@@ -1000,16 +1000,17 @@ static long tap_ioctl(struct file *file, unsigned int cmd,
 			return -ENOLINK;
 		}
 		ret = 0;
-		dev_get_mac_address(&sa, dev_net(tap->dev), tap->dev->name);
+		dev_get_mac_address((struct sockaddr *)&ss, dev_net(tap->dev),
+				    tap->dev->name);
 		if (copy_to_user(&ifr->ifr_name, tap->dev->name, IFNAMSIZ) ||
-		    copy_to_user(&ifr->ifr_hwaddr, &sa, sizeof(sa)))
+		    copy_to_user(&ifr->ifr_hwaddr, &ss, sizeof(ifr->ifr_hwaddr)))
 			ret = -EFAULT;
 		tap_put_tap_dev(tap);
 		rtnl_unlock();
 		return ret;
 
 	case SIOCSIFHWADDR:
-		if (copy_from_user(&sa, &ifr->ifr_hwaddr, sizeof(sa)))
+		if (copy_from_user(&ss, &ifr->ifr_hwaddr, sizeof(ifr->ifr_hwaddr)))
 			return -EFAULT;
 		rtnl_lock();
 		tap = tap_get_tap_dev(q);
@@ -1017,7 +1018,10 @@ static long tap_ioctl(struct file *file, unsigned int cmd,
 			rtnl_unlock();
 			return -ENOLINK;
 		}
-		ret = dev_set_mac_address_user(tap->dev, &sa, NULL);
+		if (tap->dev->addr_len > sizeof(ifr->ifr_hwaddr))
+			ret = -EINVAL;
+		else
+			ret = dev_set_mac_address_user(tap->dev, &ss, NULL);
 		tap_put_tap_dev(tap);
 		rtnl_unlock();
 		return ret;
diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 7babd1e9a378..1207196cbbed 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -3193,7 +3193,13 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
 
 	case SIOCSIFHWADDR:
 		/* Set hw address */
-		ret = dev_set_mac_address_user(tun->dev, &ifr.ifr_hwaddr, NULL);
+		if (tun->dev->addr_len > sizeof(ifr.ifr_hwaddr)) {
+			ret = -EINVAL;
+			break;
+		}
+		ret = dev_set_mac_address_user(tun->dev,
+					       (struct sockaddr_storage *)&ifr.ifr_hwaddr,
+					       NULL);
 		break;
 
 	case TUNGETSNDBUF:
diff --git a/net/core/dev_api.c b/net/core/dev_api.c
index 6011a5ef649d..1bf0153195f2 100644
--- a/net/core/dev_api.c
+++ b/net/core/dev_api.c
@@ -84,14 +84,15 @@ void dev_set_group(struct net_device *dev, int new_group)
 	netdev_unlock_ops(dev);
 }
 
-int dev_set_mac_address_user(struct net_device *dev, struct sockaddr *sa,
+int dev_set_mac_address_user(struct net_device *dev,
+			     struct sockaddr_storage *ss,
 			     struct netlink_ext_ack *extack)
 {
 	int ret;
 
 	down_write(&dev_addr_sem);
 	netdev_lock_ops(dev);
-	ret = netif_set_mac_address(dev, (struct sockaddr_storage *)sa, extack);
+	ret = netif_set_mac_address(dev, ss, extack);
 	netdev_unlock_ops(dev);
 	up_write(&dev_addr_sem);
 
diff --git a/net/core/dev_ioctl.c b/net/core/dev_ioctl.c
index fff13a8b48f1..616479e71466 100644
--- a/net/core/dev_ioctl.c
+++ b/net/core/dev_ioctl.c
@@ -572,9 +572,11 @@ static int dev_ifsioc(struct net *net, struct ifreq *ifr, void __user *data,
 		return dev_set_mtu(dev, ifr->ifr_mtu);
 
 	case SIOCSIFHWADDR:
-		if (dev->addr_len > sizeof(struct sockaddr))
+		if (dev->addr_len > sizeof(ifr->ifr_hwaddr))
 			return -EINVAL;
-		return dev_set_mac_address_user(dev, &ifr->ifr_hwaddr, NULL);
+		return dev_set_mac_address_user(dev,
+						(struct sockaddr_storage *)&ifr->ifr_hwaddr,
+						NULL);
 
 	case SIOCSIFHWBROADCAST:
 		if (ifr->ifr_hwaddr.sa_family != dev->type)
-- 
2.34.1


