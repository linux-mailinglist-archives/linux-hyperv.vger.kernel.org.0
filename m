Return-Path: <linux-hyperv+bounces-5608-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B2E3ABFE29
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 May 2025 22:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BF174A7EF1
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 May 2025 20:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79652BD59A;
	Wed, 21 May 2025 20:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qp1CATHn"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58C92BD03C;
	Wed, 21 May 2025 20:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747860385; cv=none; b=JJ2TRf3BLrancx5uqgThAePftM1NWcptRTZ5QiKKpH12yG1gLld9KvE6kLkJTbVChYiM8/YfXa4oedSCpLWTxEh4BVP6MySwfVIYnsUNHNVXvB/ulbWm2UYKF68IkviiFm7460e47uz9vRUH5YsKChD7pvAmHAJpmHWlbkUIivQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747860385; c=relaxed/simple;
	bh=euBwZn0uIF7MJHWwzG0lTQpTqXVn0Aafo4uJEYuZTeg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JqtkvmIOiQWlLR1yZsZlFqG/NsuSb0kGldROGGqpU7KWTMhw7ensG0QPdrJgEfd+j224ZwOC2w6fov9oBRs4KDoMeH6fL/uvcsFEbsckHw4TCJiPUbKPTm4FF6GQ/RDKffUxWdTXq9Cq/c1F8UUpayoLjnjOsrMS9zGSL36aQX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qp1CATHn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4254FC4AF0C;
	Wed, 21 May 2025 20:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747860385;
	bh=euBwZn0uIF7MJHWwzG0lTQpTqXVn0Aafo4uJEYuZTeg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qp1CATHn/VUgcgqz5540CDqe9HC/FGZfq6354MEUoXOkWB6NJGVtkzDjng4qAGzon
	 cTDJf+C1DALZnWz2U20HvefxhjUDTvQYvdP8bkugAY1ahAjWCv//R80yvOvE8NvCF5
	 Jq2CRf8oyLEP8n3yfk/n4D+qj0e2lQlvC5ml62mfo7Kp5p67SAcL4GTXlyMfBD67ST
	 6Q7gesCMIf0+EMCtrugQXzxS3BNWhlh4R2vTH+oW/ac3S+rC9sJoZKYEO9AS9HBVBB
	 W9edJ2gxt98KwUs1IrG5W+z6kaqSOFcwg5iaFTwGePxjLy3/+iKA8iXjem+yziG5xy
	 JOBnlh/Y+vwyg==
From: Kees Cook <kees@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Kees Cook <kees@kernel.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Hayes Wang <hayeswang@realtek.com>,
	Douglas Anderson <dianders@chromium.org>,
	Grant Grundler <grundler@chromium.org>,
	linux-usb@vger.kernel.org,
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
	Simon Horman <horms@kernel.org>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Cosmin Ratiu <cratiu@nvidia.com>,
	Lei Yang <leiyang@redhat.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Samuel Mendoza-Jonas <sam@mendozajonas.com>,
	Paul Fertser <fercerpav@gmail.com>,
	Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
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
	linux-hyperv@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH net-next v2 5/8] net: usb: r8152: Convert to use struct sockaddr_storage internally
Date: Wed, 21 May 2025 13:46:13 -0700
Message-Id: <20250521204619.2301870-5-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250521204310.it.500-kees@kernel.org>
References: <20250521204310.it.500-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5749; i=kees@kernel.org; h=from:subject; bh=euBwZn0uIF7MJHWwzG0lTQpTqXVn0Aafo4uJEYuZTeg=; b=owGbwMvMwCVmps19z/KJym7G02pJDBl61tNTbid3VDsEvv/Je3byvSnbZApvNVxZwDuV+/TbL 6/nPO3521HKwiDGxSArpsgSZOce5+Lxtj3cfa4izBxWJpAhDFycAjCR91GMDI8f3zrrs/khq3SY 7h+rlhYrxidKIqwq3lmy3XkqJad3ODL8U5Zee+WEQPsPn2mhNe2ijo02p6oKuXV3fjQ6dcz47u8 AJgA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

To support coming API type changes, switch to sockaddr_storage usage
internally.

Acked-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Hayes Wang <hayeswang@realtek.com>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Grant Grundler <grundler@chromium.org>
Cc: <linux-usb@vger.kernel.org>
Cc: <netdev@vger.kernel.org>
---
 drivers/net/usb/r8152.c | 52 +++++++++++++++++++++--------------------
 1 file changed, 27 insertions(+), 25 deletions(-)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 67f5d30ffcba..b18dee1b1bb3 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -1665,14 +1665,14 @@ static int
 rtl8152_set_speed(struct r8152 *tp, u8 autoneg, u32 speed, u8 duplex,
 		  u32 advertising);
 
-static int __rtl8152_set_mac_address(struct net_device *netdev, void *p,
+static int __rtl8152_set_mac_address(struct net_device *netdev,
+				     struct sockaddr_storage *addr,
 				     bool in_resume)
 {
 	struct r8152 *tp = netdev_priv(netdev);
-	struct sockaddr *addr = p;
 	int ret = -EADDRNOTAVAIL;
 
-	if (!is_valid_ether_addr(addr->sa_data))
+	if (!is_valid_ether_addr(addr->__data))
 		goto out1;
 
 	if (!in_resume) {
@@ -1683,10 +1683,10 @@ static int __rtl8152_set_mac_address(struct net_device *netdev, void *p,
 
 	mutex_lock(&tp->control);
 
-	eth_hw_addr_set(netdev, addr->sa_data);
+	eth_hw_addr_set(netdev, addr->__data);
 
 	ocp_write_byte(tp, MCU_TYPE_PLA, PLA_CRWECR, CRWECR_CONFIG);
-	pla_ocp_write(tp, PLA_IDR, BYTE_EN_SIX_BYTES, 8, addr->sa_data);
+	pla_ocp_write(tp, PLA_IDR, BYTE_EN_SIX_BYTES, 8, addr->__data);
 	ocp_write_byte(tp, MCU_TYPE_PLA, PLA_CRWECR, CRWECR_NORAML);
 
 	mutex_unlock(&tp->control);
@@ -1706,7 +1706,8 @@ static int rtl8152_set_mac_address(struct net_device *netdev, void *p)
  * host system provided MAC address.
  * Examples of this are Dell TB15 and Dell WD15 docks
  */
-static int vendor_mac_passthru_addr_read(struct r8152 *tp, struct sockaddr *sa)
+static int vendor_mac_passthru_addr_read(struct r8152 *tp,
+					 struct sockaddr_storage *ss)
 {
 	acpi_status status;
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
@@ -1774,47 +1775,48 @@ static int vendor_mac_passthru_addr_read(struct r8152 *tp, struct sockaddr *sa)
 		ret = -EINVAL;
 		goto amacout;
 	}
-	memcpy(sa->sa_data, buf, 6);
+	memcpy(ss->__data, buf, 6);
 	tp->netdev->addr_assign_type = NET_ADDR_STOLEN;
 	netif_info(tp, probe, tp->netdev,
-		   "Using pass-thru MAC addr %pM\n", sa->sa_data);
+		   "Using pass-thru MAC addr %pM\n", ss->__data);
 
 amacout:
 	kfree(obj);
 	return ret;
 }
 
-static int determine_ethernet_addr(struct r8152 *tp, struct sockaddr *sa)
+static int determine_ethernet_addr(struct r8152 *tp,
+				   struct sockaddr_storage *ss)
 {
 	struct net_device *dev = tp->netdev;
 	int ret;
 
-	sa->sa_family = dev->type;
+	ss->ss_family = dev->type;
 
-	ret = eth_platform_get_mac_address(&tp->udev->dev, sa->sa_data);
+	ret = eth_platform_get_mac_address(&tp->udev->dev, ss->__data);
 	if (ret < 0) {
 		if (tp->version == RTL_VER_01) {
-			ret = pla_ocp_read(tp, PLA_IDR, 8, sa->sa_data);
+			ret = pla_ocp_read(tp, PLA_IDR, 8, ss->__data);
 		} else {
 			/* if device doesn't support MAC pass through this will
 			 * be expected to be non-zero
 			 */
-			ret = vendor_mac_passthru_addr_read(tp, sa);
+			ret = vendor_mac_passthru_addr_read(tp, ss);
 			if (ret < 0)
 				ret = pla_ocp_read(tp, PLA_BACKUP, 8,
-						   sa->sa_data);
+						   ss->__data);
 		}
 	}
 
 	if (ret < 0) {
 		netif_err(tp, probe, dev, "Get ether addr fail\n");
-	} else if (!is_valid_ether_addr(sa->sa_data)) {
+	} else if (!is_valid_ether_addr(ss->__data)) {
 		netif_err(tp, probe, dev, "Invalid ether addr %pM\n",
-			  sa->sa_data);
+			  ss->__data);
 		eth_hw_addr_random(dev);
-		ether_addr_copy(sa->sa_data, dev->dev_addr);
+		ether_addr_copy(ss->__data, dev->dev_addr);
 		netif_info(tp, probe, dev, "Random ether addr %pM\n",
-			   sa->sa_data);
+			   ss->__data);
 		return 0;
 	}
 
@@ -1824,17 +1826,17 @@ static int determine_ethernet_addr(struct r8152 *tp, struct sockaddr *sa)
 static int set_ethernet_addr(struct r8152 *tp, bool in_resume)
 {
 	struct net_device *dev = tp->netdev;
-	struct sockaddr sa;
+	struct sockaddr_storage ss;
 	int ret;
 
-	ret = determine_ethernet_addr(tp, &sa);
+	ret = determine_ethernet_addr(tp, &ss);
 	if (ret < 0)
 		return ret;
 
 	if (tp->version == RTL_VER_01)
-		eth_hw_addr_set(dev, sa.sa_data);
+		eth_hw_addr_set(dev, ss.__data);
 	else
-		ret = __rtl8152_set_mac_address(dev, &sa, in_resume);
+		ret = __rtl8152_set_mac_address(dev, &ss, in_resume);
 
 	return ret;
 }
@@ -8421,7 +8423,7 @@ static int rtl8152_post_reset(struct usb_interface *intf)
 {
 	struct r8152 *tp = usb_get_intfdata(intf);
 	struct net_device *netdev;
-	struct sockaddr sa;
+	struct sockaddr_storage ss;
 
 	if (!tp || !test_bit(PROBED_WITH_NO_ERRORS, &tp->flags))
 		goto exit;
@@ -8429,8 +8431,8 @@ static int rtl8152_post_reset(struct usb_interface *intf)
 	rtl_set_accessible(tp);
 
 	/* reset the MAC address in case of policy change */
-	if (determine_ethernet_addr(tp, &sa) >= 0)
-		dev_set_mac_address (tp->netdev, &sa, NULL);
+	if (determine_ethernet_addr(tp, &ss) >= 0)
+		dev_set_mac_address(tp->netdev, (struct sockaddr *)&ss, NULL);
 
 	netdev = tp->netdev;
 	if (!netif_running(netdev))
-- 
2.34.1


