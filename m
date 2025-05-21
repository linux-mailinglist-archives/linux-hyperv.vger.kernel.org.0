Return-Path: <linux-hyperv+bounces-5613-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6F0ABFE55
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 May 2025 22:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B0401BC5B63
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 May 2025 20:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 091182BEC4A;
	Wed, 21 May 2025 20:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GKUaA8HJ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FDF2BE0E4;
	Wed, 21 May 2025 20:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747860386; cv=none; b=D/assLVGrq9YnUuaXPRIwEP7Dno8sDSD7FZLzdFofBnJagdV05rjgMiv2FySy1i7yksvvSZ5uM5Y2vLQJaNQt6YkO+0NGCdW7iahxMRq2+pzXGfeyHQKT8eWpVubgvVc79v+IJgzZ4tKZzpT4aTb0vjAe4wRC8yn0J2RrhQzMtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747860386; c=relaxed/simple;
	bh=l0FQvf1M3ScltpOkIqN+MDVq9vIgvD938vpt9yDUCJ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JH5+ROpe5ossj7T489Jp9xVaT0qO/bzxX64M36esNcpDPySct5+fw68lTcIpM2Q2rF0BGqwf5uAbd+YK+fQxvBimdQ3qiQRzj2/vw1wZIp2v6QFaNW4Pm3K+QToG0lMonrurPVlZV9feVNaZt53dxw9DUOyb8YLGAYlZopUdlkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GKUaA8HJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 092CDC4CEE4;
	Wed, 21 May 2025 20:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747860386;
	bh=l0FQvf1M3ScltpOkIqN+MDVq9vIgvD938vpt9yDUCJ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GKUaA8HJuMHueMQ43f9BlsAoZQ8tB64VoBZ0/vQHrZ1O00BzIgD1butpvZFA4qmyJ
	 cmtBak74rNAZBzi78g9XCcOOzO2JmpmavrDdbeB3Cwr/o5KOy7ZAojs3PX0tYYFb2M
	 kHLr0NLNigCJ/AH8PE8xnq2XeP8KOV7CEv+OtoG2KS4SxBJZ3960mSuTw1qlzyIaKj
	 grOLGspy0g7sU6LfZH/6OqPD2P8wd6gzkc4oCoktcadVjIAv6+ACWXOfO6DB7CuXRj
	 FDWLjqLvgOX1LAv9PbKRs+AJSEJeSW8jxouWJ8u+W5CxnAjL5ktbc6Ff3+HSqSTvxa
	 mdP1RGY2gr7Cw==
From: Kees Cook <kees@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Kees Cook <kees@kernel.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
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
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Cosmin Ratiu <cratiu@nvidia.com>,
	Lei Yang <leiyang@redhat.com>,
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
Subject: [PATCH net-next v2 7/8] rtnetlink: do_setlink: Use struct sockaddr_storage
Date: Wed, 21 May 2025 13:46:15 -0700
Message-Id: <20250521204619.2301870-7-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250521204310.it.500-kees@kernel.org>
References: <20250521204310.it.500-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2148; i=kees@kernel.org; h=from:subject; bh=l0FQvf1M3ScltpOkIqN+MDVq9vIgvD938vpt9yDUCJ4=; b=owGbwMvMwCVmps19z/KJym7G02pJDBl61tMbYmZ7vqv3y5thHs3r9nVXSVtZ7MEJ73YFLVVlf crw4fn/jlIWBjEuBlkxRZYgO/c4F4+37eHucxVh5rAygQxh4OIUgImYKjAyfDV1aEz44sad4qiz 39HRp5zLnFf5iffcMym3Px+wdE/gY/ineFOBL/PIyU28LFO3x+ZnOm9YpcfdFuQ7kyW368Lt3AU cAA==
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Instead of a heap allocating a variably sized struct sockaddr and lying
about the type in the call to netif_set_mac_address(), use a stack
allocated struct sockaddr_storage. This lets us drop the cast and avoid
the allocation.

Putting "ss" on the stack means it will get a reused stack slot since
it is the same size (128B) as other existing single-scope stack variables,
like the vfinfo array (128B), so no additional stack space is used by
this function.

Acked-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>
Cc: Ido Schimmel <idosch@nvidia.com>
Cc: <netdev@vger.kernel.org>
---
 net/core/rtnetlink.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 9743f1c2ae3c..f9a35bdc58ad 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3080,17 +3080,7 @@ static int do_setlink(const struct sk_buff *skb, struct net_device *dev,
 	}
 
 	if (tb[IFLA_ADDRESS]) {
-		struct sockaddr *sa;
-		int len;
-
-		len = sizeof(sa_family_t) + max_t(size_t, dev->addr_len,
-						  sizeof(*sa));
-		sa = kmalloc(len, GFP_KERNEL);
-		if (!sa) {
-			err = -ENOMEM;
-			goto errout;
-		}
-		sa->sa_family = dev->type;
+		struct sockaddr_storage ss = { };
 
 		netdev_unlock_ops(dev);
 
@@ -3098,10 +3088,9 @@ static int do_setlink(const struct sk_buff *skb, struct net_device *dev,
 		down_write(&dev_addr_sem);
 		netdev_lock_ops(dev);
 
-		memcpy(sa->sa_data, nla_data(tb[IFLA_ADDRESS]),
-		       dev->addr_len);
-		err = netif_set_mac_address(dev, (struct sockaddr_storage *)sa, extack);
-		kfree(sa);
+		ss.ss_family = dev->type;
+		memcpy(ss.__data, nla_data(tb[IFLA_ADDRESS]), dev->addr_len);
+		err = netif_set_mac_address(dev, &ss, extack);
 		if (err) {
 			up_write(&dev_addr_sem);
 			goto errout;
-- 
2.34.1


