Return-Path: <linux-hyperv+bounces-5610-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0413ABFE2F
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 May 2025 22:47:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D7951BC46EF
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 May 2025 20:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F5F2BD5AF;
	Wed, 21 May 2025 20:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IUA7A1yu"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59D72BD03E;
	Wed, 21 May 2025 20:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747860385; cv=none; b=OHldTGetH8ah5satO8pJ7ViLO81VshPELra1RApAi5DLmwOPfPfZXsa5TXcpBV+03YhY2cGR3GZUKZAqz2bvfCH8Al7gxXf+t+js+kDSGnpZs59S+vtti86jTQ/tbV3UkRqLQbQHk/rA5jEZsKtv7jvqTnPg4BEB8i6PMusRXv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747860385; c=relaxed/simple;
	bh=3y8pSwiI7jCa8xZO0oBuKIKAgQevvuirBhuCp91Tvu4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R2upLHo9OJTEAjaBu66rBluBxerydqV3g/u9Jr0sIPs1tgOmulC/NrAygUf+QB7eTslguGR3B3+5TqwNvJsBYAxlw4FgxZny078YX4xUK67sM7pWMuyubGBcdQ3SWDoAv+7aQiqGoukeFEVLW9DyXPZjMktc/9ObgD6qND7iMuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IUA7A1yu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32D0AC4CEF4;
	Wed, 21 May 2025 20:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747860385;
	bh=3y8pSwiI7jCa8xZO0oBuKIKAgQevvuirBhuCp91Tvu4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IUA7A1yu0JrsaxGi5EzTCOO2xY4d1qxn1DTToRANfpD02L98ghVSo9IuISrg708MN
	 enPnIklzCj6+x7pVzjOKHxHhtAALpnzEOvbMZvTSUp+f/HhkueqYGeU0Oh2Dbom7zx
	 G84gQJiVNvFg7FginlVGDylNsxZbDKC3LhrtbPSehJrQdI0mZuLmunCCfK/N1kXOH9
	 TU0Lvl7iYpfM+49umOtu3PyybRSkaMTTccKcr9Nw4LqgU2lIE439Vr5Diin189GGQ9
	 YieBY0FYwPmXt0XCJtkBDfDL3qfRTNliawLQ+GU2A0kKTob9KkxhzpS8GX5ZRfAGvA
	 58yr3e/vnJGFQ==
From: Kees Cook <kees@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Kees Cook <kees@kernel.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
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
	linux-usb@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH net-next v2 4/8] ieee802154: Use struct sockaddr_storage with dev_set_mac_address()
Date: Wed, 21 May 2025 13:46:12 -0700
Message-Id: <20250521204619.2301870-4-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250521204310.it.500-kees@kernel.org>
References: <20250521204310.it.500-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1715; i=kees@kernel.org; h=from:subject; bh=3y8pSwiI7jCa8xZO0oBuKIKAgQevvuirBhuCp91Tvu4=; b=owGbwMvMwCVmps19z/KJym7G02pJDBl61tM+/vrfcvu0l8g3/bz5B1f9fCd9py2/fs/uOc9e1 ygknbvm3FHKwiDGxSArpsgSZOce5+Lxtj3cfa4izBxWJpAhDFycAjARfTtGhjVTLjttiI4JEWDM vWAUXOF3rqqblWcbu7s2p2TB/Pt7ljH84fgh/dAjvPNvwSa18qB6o3wjvXXTTU9c29jAYqXbmxP AAQA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Switch to struct sockaddr_storage for calling dev_set_mac_address(). Add
a temporary cast to struct sockaddr, which will be removed in a
subsequent patch.

Acked-by: Gustavo A. R. Silva <gustavoars@kernel.org>
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


