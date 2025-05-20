Return-Path: <linux-hyperv+bounces-5581-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E77ABE71B
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 May 2025 00:32:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF7251BC0329
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 May 2025 22:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD30826562C;
	Tue, 20 May 2025 22:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BOwFhMEv"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCF626462C;
	Tue, 20 May 2025 22:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747780275; cv=none; b=rrPGJnaMH75ovdAYyr6Th35iEsKMcUfc5reKPyDLVEZgt5H9VHljPBMxmgNxfcLv8zvUOYIcyxZXfHdGl6MYeac4zI2Dfwk+ndMG5knyu5g3/2TK8Af39wwvqB0DjCUo/vhWa8l+DY6XCiNH86hMrpn+BdFwF8fiovENRKVCSU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747780275; c=relaxed/simple;
	bh=7Qa/IpuQKFOWRWF79NofDyxxIjQyXX1yFfRlJmNAhpQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FMGvzHCkuxWqFl+EdeIaiVXvWM22bM1XJy5kvTmjTryNWpe/9siMWQcQEU50HrVch5PMu2DM+GQA+KKftY3EDepBiQj5wCiiItWSzMh+Y8ue1eE+W9Hwp2K/UcdljULWD1lI4QK0DMDxxJSvDq4XpdM2Y4rcvM1R+v9WBnlsinA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BOwFhMEv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CF8AC4CEF2;
	Tue, 20 May 2025 22:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747780274;
	bh=7Qa/IpuQKFOWRWF79NofDyxxIjQyXX1yFfRlJmNAhpQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BOwFhMEvnncEbt04sunuSxfflgKvjcUp7JSXl1Rx49NjhAjlJs3CnmgFEO2OjYLFS
	 FnxMRf+Y0l8NIw9qbw2FBVhJEmGUfzmI3o5rYjb5Xats4x1tM2hRAQqRSZlsxW/PVs
	 99R5M0bnHfVohXHQoaW/qQCm7BPLAGEzVl0pXcL5Vst2Vc6khbh8bQjuyOktICMffX
	 U3L1qVyImNx2jT/9p34tb3ykRcqoI2oa5OpAV4Lpy5hLXCv+0K7HtW4O6s6vPI/P8i
	 l2MNooYeY9cP5g1ou6cmJiHAiz4cPxZ+ZQeRqLYZPnvcGd3eMSvAungNxE2YUbqYgG
	 83Ywtr100ZzXw==
From: Kees Cook <kees@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Kees Cook <kees@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
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
	linux-wpan@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH 7/7] rtnetlink: do_setlink: Use struct sockaddr_storage
Date: Tue, 20 May 2025 15:31:06 -0700
Message-Id: <20250520223108.2672023-7-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250520222452.work.063-kees@kernel.org>
References: <20250520222452.work.063-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2093; i=kees@kernel.org; h=from:subject; bh=7Qa/IpuQKFOWRWF79NofDyxxIjQyXX1yFfRlJmNAhpQ=; b=owGbwMvMwCVmps19z/KJym7G02pJDBm6TKtmnOlUkkri/PtTpKuJWcgyguPHyic/Ci2ju8tye j+JT8rrKGVhEONikBVTZAmyc49z8XjbHu4+VxFmDisTyBAGLk4BmIiyHcP/5OXSpk/zfC1KOKbI rnhQbaXzKEa72P+m2Oa4bIZV4bfXMzKsmyNVf+e5ovVutyS7NQKZupb5O/XKFvdZxT2fsS5DZR0 TAA==
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


