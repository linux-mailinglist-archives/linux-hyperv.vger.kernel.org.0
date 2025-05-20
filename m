Return-Path: <linux-hyperv+bounces-5582-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB882ABE718
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 May 2025 00:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC4714C806D
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 May 2025 22:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B98265CC2;
	Tue, 20 May 2025 22:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ldaHrxJ+"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD6126462E;
	Tue, 20 May 2025 22:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747780275; cv=none; b=bCpGnBNode+d/B+5BovTq3/G3f7BzHHmEIDc0hRWhSi7ib7IyUHIzQZLP/7U+T0SKSzXxToNts6UDMst0nxTnwrVUA+RgCYnugNJyTPIlPrWeG+A3QoS/Tje/gTKiqhdFi/YenhMu/o7zy3ollLxOjgDVWFdHtP+kYNk+JqPWfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747780275; c=relaxed/simple;
	bh=7+5aLCST6s7T/oujRRoROLyuAQnVT9g0E0a0chHKZpY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Zhr2pMNfIWzLzZDaaVBh8eC6yNThmDLApwRSB8t4PZxEnB2GnthYlSXS/hy8Qj+HlA8loPbt/3bUWc41Ccxz8ADTDbc5M8xAYFaTlH1bVEOl5d7n0FP3hQ6esQcYiDAMZfu2q6MsB9V/oj4IF2G68rVQQ7T3bjD7lANx8581xB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ldaHrxJ+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CDE3C4CEEF;
	Tue, 20 May 2025 22:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747780274;
	bh=7+5aLCST6s7T/oujRRoROLyuAQnVT9g0E0a0chHKZpY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ldaHrxJ+HWhXTPlP+sI/ZOa+dyUowLN+FvRZgsV/pojXZLN+5l0tMTfDgW+FvxXEi
	 l6kB4qqCzEH3QJojzSOdG0Soxb7diNMYVQQOQiXH/QZ4nG0KbFvhE62wcMzLmR5wxD
	 vYzJC23akqQAfWN3ae9OeyTLnv3bVi7P8nb8oOO0LP8BA+/UnJMz2QJIxAl+Rf5ezs
	 7/5N5COJCJr+5jsF5lwzw4tt9uCvfW/BgZqa5cozToSzp+Lk/4dFSB90zs1JQnJbXc
	 IxOg9p8m+B+dfNQb13ftdez29WQRPrpGVFpYOcgPikp73u22S2Sai2erFI4eeN0eEi
	 Vcrs0XReQcjHA==
From: Kees Cook <kees@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Kees Cook <kees@kernel.org>,
	Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
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
	Samuel Mendoza-Jonas <sam@mendozajonas.com>,
	Paul Fertser <fercerpav@gmail.com>,
	Hayes Wang <hayeswang@realtek.com>,
	Douglas Anderson <dianders@chromium.org>,
	Grant Grundler <grundler@chromium.org>,
	Jay Vosburgh <jv@jvosburgh.net>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Eric Biggers <ebiggers@google.com>,
	Milan Broz <gmazyland@gmail.com>,
	Philipp Hahn <phahn-oss@avm.de>,
	Ard Biesheuvel <ardb@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Xiao Liang <shaw.leon@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH 4/7] ieee802154: Use struct sockaddr_storage with dev_set_mac_address()
Date: Tue, 20 May 2025 15:31:03 -0700
Message-Id: <20250520223108.2672023-4-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250520222452.work.063-kees@kernel.org>
References: <20250520222452.work.063-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1660; i=kees@kernel.org; h=from:subject; bh=7+5aLCST6s7T/oujRRoROLyuAQnVT9g0E0a0chHKZpY=; b=owGbwMvMwCVmps19z/KJym7G02pJDBm6TCuvblF8lhP5XPy9sMWyEMOOBf5mZU1r2a84b9zO5 XOSa+eDjlIWBjEuBlkxRZYgO/c4F4+37eHucxVh5rAygQxh4OIUgIn0SzEydIpvmvaTp0OOf/HG wvDqKzx16Tpczr9fn9p0tPx64oXQBwz/U432vV52/+aEDRx7zU2ryn2Z8narzXt2blLAxWNdZx/ NYQEA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Switch to struct sockaddr_storage for calling dev_set_mac_address(). Add
a temporary cast to struct sockaddr, which will be removed in a
subsequent patch.

Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Alexander Aring <alex.aring@gmail.com>
Cc: Stefan Schmidt <stefan@datenfreihafen.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>
Cc: <linux-wpan@vger.kernel.org>
Cc: <netdev@vger.kernel.org>
---
 net/ieee802154/nl-phy.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/ieee802154/nl-phy.c b/net/ieee802154/nl-phy.c
index 359249ab77bf..ee2b190e8e0d 100644
--- a/net/ieee802154/nl-phy.c
+++ b/net/ieee802154/nl-phy.c
@@ -224,17 +224,17 @@ int ieee802154_add_iface(struct sk_buff *skb, struct genl_info *info)
 	dev_hold(dev);
 
 	if (info->attrs[IEEE802154_ATTR_HW_ADDR]) {
-		struct sockaddr addr;
+		struct sockaddr_storage addr;
 
-		addr.sa_family = ARPHRD_IEEE802154;
-		nla_memcpy(&addr.sa_data, info->attrs[IEEE802154_ATTR_HW_ADDR],
+		addr.ss_family = ARPHRD_IEEE802154;
+		nla_memcpy(&addr.__data, info->attrs[IEEE802154_ATTR_HW_ADDR],
 			   IEEE802154_ADDR_LEN);
 
 		/* strangely enough, some callbacks (inetdev_event) from
 		 * dev_set_mac_address require RTNL_LOCK
 		 */
 		rtnl_lock();
-		rc = dev_set_mac_address(dev, &addr, NULL);
+		rc = dev_set_mac_address(dev, (struct sockaddr *)&addr, NULL);
 		rtnl_unlock();
 		if (rc)
 			goto dev_unregister;
-- 
2.34.1


