Return-Path: <linux-hyperv+bounces-8461-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qNDLJD5vcmlpkwAAu9opvQ
	(envelope-from <linux-hyperv+bounces-8461-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Jan 2026 19:41:02 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 227D56C928
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Jan 2026 19:41:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1BC413006B01
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Jan 2026 18:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7EC338551E;
	Thu, 22 Jan 2026 18:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="l1mM3ZOi"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E973559E6;
	Thu, 22 Jan 2026 18:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769107259; cv=none; b=tnekFw6qO8v37GLEN6/h6uaMXIV80IUmBUTCtjor7/O67hOSCwvyZbPjiIFotU3RV52/7pDPEBJgA2VP/ECvnqlnNCetvUIZGj006A3DON41uMznRM1rTKInqWSBCyqVsZl6U3Ehvir9uMJaSPWenyXgHsXlnSpUwmzUWR4DNVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769107259; c=relaxed/simple;
	bh=n4jGYLV7IbVBN9Oyk3sD9+JGQ1D9Ov0vGtQeWrDdP+U=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nUsqVPdRWpe52Y4CyLLRgkWRkyWm935ZzDOKPgpceiL4ScHlrl0+OcVdQLPYtA9FcaZEUHd1t5xkVGjlhm0bXhmYgA4C2F/Yo4fs6Reckrr7ruY8x0rhaZCrIFnmtq6e4qcBFkzsqfAqN2toA2DTCevN6fQ1nCWO4hqt1pEkgjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=l1mM3ZOi; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:From:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=8BCSCWE0O1i1J2Ae50ZuzMEMixBn/aV8HDlnqXZ9VGE=; b=l1mM3ZOiTUQ/NEzw0X6zuNMATB
	9nqPBgs9T7Yc8ZfPi2DRux0pqKebbFJEk9oXS564+oNFH5ioaFCfLSMs6O7H4kEXsBCeRn8dlBFsK
	HgI0okfQWgBFzO46yGOwmsH1K6JSvit/JJyQkkveMPtqABQsCwHpTUiuMU5ygymOz177gV69TbQiX
	zAiCZJtiDmoDyjPu2Li0NDwY5OEOc4eC8nJ7hP225/qC0NO8b6zlBKPShTR/Aglwc9Q2b8iftT1MB
	PfDjSeEamnV9Wg63lhZmAR7d/sqjM93oEA3VGJSzeL7WMYUBjPpHnzdWUkjGhUlgoXFxrhE5ajg+H
	WdyGcfOQ==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vizbm-00DE0B-Bv; Thu, 22 Jan 2026 18:40:43 +0000
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next v2 0/9] net: convert drivers to .get_rx_ring_count
 (last part)
Date: Thu, 22 Jan 2026 10:40:12 -0800
Message-Id: <20260122-grxring_big_v4-v2-0-94dbe4dcaa10@debian.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA5vcmkC/3WNQQ6CMBBFr9LMmppptRBZeQ9DCIWhjItC2tpgC
 Hc34Nr1f/+9DSIFpgi12CBQ5sizh1roQkA/dd6R5AFqARp1iUor6cIa2LvWsmvzTRqD12q8E6I
 iKAQsgUZeT+ETPCXpaU3Q/Jb4ti/q0+E72IljmsPnbGd1Pv5lspIosSqNsWRK24+PgSx3/jIHB
 82+719Dk/HOyQAAAA==
X-Change-ID: 20260121-grxring_big_v4-55037f9e001e
To: Ajit Khaparde <ajit.khaparde@broadcom.com>, 
 Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>, 
 Somnath Kotur <somnath.kotur@broadcom.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Igor Russkikh <irusskikh@marvell.com>, Simon Horman <horms@kernel.org>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
 Alexander Duyck <alexanderduyck@fb.com>, kernel-team@meta.com, 
 Edward Cree <ecree.xilinx@gmail.com>, Brett Creeley <brett.creeley@amd.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 oss-drivers@corigine.com, linux-hyperv@vger.kernel.org, 
 linux-net-drivers@amd.com, Breno Leitao <leitao@debian.org>, 
 Subbaraya Sundeep <sbhatta@marvell.com>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=3128; i=leitao@debian.org;
 h=from:subject:message-id; bh=n4jGYLV7IbVBN9Oyk3sD9+JGQ1D9Ov0vGtQeWrDdP+U=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpcm8jCBEbxl4TPx40pujFrpDCxZhJFwR/S43mg
 OsM40udrI+JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaXJvIwAKCRA1o5Of/Hh3
 bfITEACHkkz8hRElyhsDFachHGIJatNvm6unrg/2V2SvOtz0GIn7KPDDdCFhfqYWq+fylek6Zdm
 +08qi0BqNS5aryjmUh+n4Y9X869SWDph3IM2hN5C6jKOvm0xezhaVTvJedwWSKX+HuzEARIs/Yf
 4FxC909AwXnkREyZyHpwrUgcUnpYQEDISkr7vfr+siSwtGHZ/Ab0jexPXAEJdqELlZJAQ+53FwN
 44TpFa9RPdu3fB7/mfolbp8UETSRPAH3CmsbwBTubTAoATNNGhX2cR3XbITEjiz6tVeesThQT77
 hPGSey50pwJiUjHIvcT/scJsT7+9hBNbD51wXZxSh+aeMEgbtZofHWJ/v9an3pKJxJ/4YC/Z++2
 GFVOSy0ukbs1fixfK4mEkfM7xIGp/AT2H+3oNiRSdsjPbageiawy1Qm7k4SuJ2jdLj2ltCoFhRV
 ug+0W1v9LGqbtbfJThk3TOJ/uksbej/lCJSa4XCN/Nmi95WhgBDHgPABNiS+wap0CdYmKPGTQke
 Udp1UcI0dc/TfxhMjnKJ7sbwRePEW4JPr1Nj0XxXR2l8OTQ4xlptKrsVUWTVDmGZpqbEZnmlZyL
 zCSoEbHHdT24oOqS/X/rC4zhmUYfz+bJQWGZAYPW9XFNmSyF6EdTwsExII4bPdcVw20Q2AyG1e7
 RjXI3o+maWOORjw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[broadcom.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,marvell.com,microsoft.com,fb.com,meta.com,gmail.com,amd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[debian.org];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-8461-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 227D56C928
X-Rspamd-Action: no action

Commit 84eaf4359c36 ("net: ethtool: add get_rx_ring_count callback to
optimize RX ring queries") added specific support for GRXRINGS callback,
simplifying .get_rxnfc.

Remove the handling of GRXRINGS in .get_rxnfc() by moving it to the new
.get_rx_ring_count().

This simplifies the RX ring count retrieval and aligns the following
drivers with the new ethtool API for querying RX ring parameters.

 * sfc
 * ionic
 * sfc/siena
 * sfc/ef100
 * fbnic
 * mana
 * nfp
 * atlantic
 * benet (this is v2 in fact, where v1 had some discussions that
   required a v2). See link [0]

Link: https://lore.kernel.org/all/20260119094514.5b12a097@kernel.org/ [0]

This is covering the last drivers, and as soon as this lands, I will
change the ethtool framework to avoid calling .get_rx_ring_count for
ETHTOOL_GRXRINGS, simplifying the ethtool core framework.

Part 1 is already merged in net-next and can be seen in
https://lore.kernel.org/all/20260109-grxring_big_v1-v1-0-a0f77f732006@debian.org/

Part 2 is already merged in net-next except benet driver, which is now included
in here
https://lore.kernel.org/all/20260115-grxring_big_v2-v1-0-b3e1b58bced5@debian.org/

PS: all of these change were compile-tested only.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
Changes in v2:
- Respect reverse xmas tree in Atlantic driver (Brett Creeley)
- Link to v1: https://patch.msgid.link/20260121-grxring_big_v4-v1-0-07655be56bcf@debian.org

---
Breno Leitao (9):
      net: benet: convert to use .get_rx_ring_count
      net: atlantic: convert to use .get_rx_ring_count
      net: nfp: convert to use .get_rx_ring_count
      net: mana: convert to use .get_rx_ring_count
      net: fbnic: convert to use .get_rx_ring_count
      net: ionic: convert to use .get_rx_ring_count
      net: sfc: efx: convert to use .get_rx_ring_count
      net: sfc: siena: convert to use .get_rx_ring_count
      net: sfc: falcon: convert to use .get_rx_ring_count

 .../net/ethernet/aquantia/atlantic/aq_ethtool.c    | 18 +++++++----
 drivers/net/ethernet/emulex/benet/be_ethtool.c     | 37 ++++++++--------------
 drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c    | 12 ++++---
 drivers/net/ethernet/microsoft/mana/mana_ethtool.c | 13 ++------
 .../net/ethernet/netronome/nfp/nfp_net_ethtool.c   | 11 +++++--
 .../net/ethernet/pensando/ionic/ionic_ethtool.c    | 18 ++---------
 drivers/net/ethernet/sfc/ef100_ethtool.c           |  1 +
 drivers/net/ethernet/sfc/ethtool.c                 |  1 +
 drivers/net/ethernet/sfc/ethtool_common.c          | 11 ++++---
 drivers/net/ethernet/sfc/ethtool_common.h          |  1 +
 drivers/net/ethernet/sfc/falcon/ethtool.c          | 12 ++++---
 drivers/net/ethernet/sfc/siena/ethtool.c           |  1 +
 drivers/net/ethernet/sfc/siena/ethtool_common.c    | 11 ++++---
 drivers/net/ethernet/sfc/siena/ethtool_common.h    |  1 +
 14 files changed, 75 insertions(+), 73 deletions(-)
---
base-commit: d8f87aa5fa0a4276491fa8ef436cd22605a3f9ba
change-id: 20260121-grxring_big_v4-55037f9e001e

Best regards,
--  
Breno Leitao <leitao@debian.org>


