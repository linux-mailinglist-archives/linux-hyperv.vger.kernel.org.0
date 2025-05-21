Return-Path: <linux-hyperv+bounces-5611-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A97DABFE34
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 May 2025 22:47:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94D2316CCC0
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 May 2025 20:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285D22BDC03;
	Wed, 21 May 2025 20:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VwFYVtzp"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A3B2BD03F;
	Wed, 21 May 2025 20:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747860385; cv=none; b=W1jHNMPLi0cO74nI5aTaZTE/f5HaTYf6wr4VHO0q72PNcH/mo112fsjhvCH7yGCpvGk7co5WD8ojQQIQyTRclktFk7vvc5u8CrgNhCTVt8QUBAWnO/qIVWt5gXoXlRvxjoobPgOL5E9bSjvlwLkdS3GoQ+3Sm2Gu9MkV+DgfQgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747860385; c=relaxed/simple;
	bh=oyO2kHo52UaIsAQcglcDyoAoO9nTWXsxoVThOn5vUn4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EunAJhDJt5QDr+kEUfiOVYldDEZVIPM7Dxt0oyNd8op+TopFXSK8AwtiQO/zw8eHLsZG81+GZa2Wa6YiQxZ80k56U9cCQUYpI8gJthHzHcYlT+KNgo87W64gewSN8sgsY9DzTYhkTmdE/ufyypKlnIEj8D7FDpPSNmFziIkFAoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VwFYVtzp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F651C4CEF1;
	Wed, 21 May 2025 20:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747860385;
	bh=oyO2kHo52UaIsAQcglcDyoAoO9nTWXsxoVThOn5vUn4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VwFYVtzpf9WkeR6nYzutlaZAe6SJLLXzfuB6QG2UO1mXsf6rdq9oGSKt/iwLL8++I
	 0NvNt3mKIPM8j3pONU6uONEEx62v22K02fDw9Bf+V7iLiuNLgjDWUw+RRB/PchfaJc
	 d2YoXmPjejQa6KzNVrtkv/JcouXYpYvn6t42ed71wUAywhgw4gPxVau0jq2nUBolY2
	 VGUj5G66EO7s7vvwRkhXzkcVRr+mrI+q0eYnd0NQh3oyrrSl7EDaFfdWqSZViZ7U5j
	 QWat3w0IouGUG7GT6vsSfUUiukYta/XPIqQatfSRoRrQwZDcEiMWAxuMwfjbMrEmQf
	 JQ7ToGCYQbuDQ==
From: Kees Cook <kees@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Kees Cook <kees@kernel.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	Samuel Mendoza-Jonas <sam@mendozajonas.com>,
	Paul Fertser <fercerpav@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
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
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Cosmin Ratiu <cratiu@nvidia.com>,
	Lei Yang <leiyang@redhat.com>,
	Ido Schimmel <idosch@nvidia.com>,
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
Subject: [PATCH net-next v2 3/8] net/ncsi: Use struct sockaddr_storage for pending_mac
Date: Wed, 21 May 2025 13:46:11 -0700
Message-Id: <20250521204619.2301870-3-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250521204310.it.500-kees@kernel.org>
References: <20250521204310.it.500-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4416; i=kees@kernel.org; h=from:subject; bh=oyO2kHo52UaIsAQcglcDyoAoO9nTWXsxoVThOn5vUn4=; b=owGbwMvMwCVmps19z/KJym7G02pJDBl61tPO/lrCWRv7YqfZrYue/y5Wn2TfOaHe8a6Cuu2sQ JuC/z0NHaUsDGJcDLJiiixBdu5xLh5v28Pd5yrCzGFlAhnCwMUpABOZxc3IsE78skSC8JKZL3d+ fXyCKUNLuybSRL44LLyk5JLAdusWUYZ/5ueiFH9H/Tq7b9Wr6V56zvPO3X73qYxXwzb5FMd13ax WZgA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

To avoid future casting with coming API type changes, switch struct
ncsi_dev_priv::pending_mac to a full struct sockaddr_storage.

Acked-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Samuel Mendoza-Jonas <sam@mendozajonas.com>
Cc: Paul Fertser <fercerpav@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>
Cc: <netdev@vger.kernel.org>
---
 net/ncsi/internal.h    |  2 +-
 net/ncsi/ncsi-manage.c |  2 +-
 net/ncsi/ncsi-rsp.c    | 18 +++++++++---------
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/net/ncsi/internal.h b/net/ncsi/internal.h
index 2c260f33b55c..e76c6de0c784 100644
--- a/net/ncsi/internal.h
+++ b/net/ncsi/internal.h
@@ -322,7 +322,7 @@ struct ncsi_dev_priv {
 #define NCSI_DEV_RESHUFFLE	4
 #define NCSI_DEV_RESET		8            /* Reset state of NC          */
 	unsigned int        gma_flag;        /* OEM GMA flag               */
-	struct sockaddr     pending_mac;     /* MAC address received from GMA */
+	struct sockaddr_storage pending_mac; /* MAC address received from GMA */
 	spinlock_t          lock;            /* Protect the NCSI device    */
 	unsigned int        package_probe_id;/* Current ID during probe    */
 	unsigned int        package_num;     /* Number of packages         */
diff --git a/net/ncsi/ncsi-manage.c b/net/ncsi/ncsi-manage.c
index b36947063783..0202db2aea3e 100644
--- a/net/ncsi/ncsi-manage.c
+++ b/net/ncsi/ncsi-manage.c
@@ -1058,7 +1058,7 @@ static void ncsi_configure_channel(struct ncsi_dev_priv *ndp)
 		break;
 	case ncsi_dev_state_config_apply_mac:
 		rtnl_lock();
-		ret = dev_set_mac_address(dev, &ndp->pending_mac, NULL);
+		ret = dev_set_mac_address(dev, (struct sockaddr *)&ndp->pending_mac, NULL);
 		rtnl_unlock();
 		if (ret < 0)
 			netdev_warn(dev, "NCSI: 'Writing MAC address to device failed\n");
diff --git a/net/ncsi/ncsi-rsp.c b/net/ncsi/ncsi-rsp.c
index 8668888c5a2f..472cc68ad86f 100644
--- a/net/ncsi/ncsi-rsp.c
+++ b/net/ncsi/ncsi-rsp.c
@@ -628,7 +628,7 @@ static int ncsi_rsp_handler_snfc(struct ncsi_request *nr)
 static int ncsi_rsp_handler_oem_gma(struct ncsi_request *nr, int mfr_id)
 {
 	struct ncsi_dev_priv *ndp = nr->ndp;
-	struct sockaddr *saddr = &ndp->pending_mac;
+	struct sockaddr_storage *saddr = &ndp->pending_mac;
 	struct net_device *ndev = ndp->ndev.dev;
 	struct ncsi_rsp_oem_pkt *rsp;
 	u32 mac_addr_off = 0;
@@ -644,11 +644,11 @@ static int ncsi_rsp_handler_oem_gma(struct ncsi_request *nr, int mfr_id)
 	else if (mfr_id == NCSI_OEM_MFR_INTEL_ID)
 		mac_addr_off = INTEL_MAC_ADDR_OFFSET;
 
-	saddr->sa_family = ndev->type;
-	memcpy(saddr->sa_data, &rsp->data[mac_addr_off], ETH_ALEN);
+	saddr->ss_family = ndev->type;
+	memcpy(saddr->__data, &rsp->data[mac_addr_off], ETH_ALEN);
 	if (mfr_id == NCSI_OEM_MFR_BCM_ID || mfr_id == NCSI_OEM_MFR_INTEL_ID)
-		eth_addr_inc((u8 *)saddr->sa_data);
-	if (!is_valid_ether_addr((const u8 *)saddr->sa_data))
+		eth_addr_inc(saddr->__data);
+	if (!is_valid_ether_addr(saddr->__data))
 		return -ENXIO;
 
 	/* Set the flag for GMA command which should only be called once */
@@ -1088,7 +1088,7 @@ static int ncsi_rsp_handler_netlink(struct ncsi_request *nr)
 static int ncsi_rsp_handler_gmcma(struct ncsi_request *nr)
 {
 	struct ncsi_dev_priv *ndp = nr->ndp;
-	struct sockaddr *saddr = &ndp->pending_mac;
+	struct sockaddr_storage *saddr = &ndp->pending_mac;
 	struct net_device *ndev = ndp->ndev.dev;
 	struct ncsi_rsp_gmcma_pkt *rsp;
 	int i;
@@ -1105,15 +1105,15 @@ static int ncsi_rsp_handler_gmcma(struct ncsi_request *nr)
 			    rsp->addresses[i][4], rsp->addresses[i][5]);
 	}
 
-	saddr->sa_family = ndev->type;
+	saddr->ss_family = ndev->type;
 	for (i = 0; i < rsp->address_count; i++) {
 		if (!is_valid_ether_addr(rsp->addresses[i])) {
 			netdev_warn(ndev, "NCSI: Unable to assign %pM to device\n",
 				    rsp->addresses[i]);
 			continue;
 		}
-		memcpy(saddr->sa_data, rsp->addresses[i], ETH_ALEN);
-		netdev_warn(ndev, "NCSI: Will set MAC address to %pM\n", saddr->sa_data);
+		memcpy(saddr->__data, rsp->addresses[i], ETH_ALEN);
+		netdev_warn(ndev, "NCSI: Will set MAC address to %pM\n", saddr->__data);
 		break;
 	}
 
-- 
2.34.1


