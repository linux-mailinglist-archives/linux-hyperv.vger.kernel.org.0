Return-Path: <linux-hyperv+bounces-8556-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +CMWACfeeWnI0QEAu9opvQ
	(envelope-from <linux-hyperv+bounces-8556-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 28 Jan 2026 11:00:07 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E1719F266
	for <lists+linux-hyperv@lfdr.de>; Wed, 28 Jan 2026 11:00:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 09AD43039EF2
	for <lists+linux-hyperv@lfdr.de>; Wed, 28 Jan 2026 09:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585EA34D4E6;
	Wed, 28 Jan 2026 09:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="osuPLtwk"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B7434BA20;
	Wed, 28 Jan 2026 09:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769594142; cv=none; b=GEbBYBTJ6Kf0jc0scjcGY1jmYPOoA+8hlmHDGl01UdKjWGt062QmY4xA9znp2IKzuMGguNM8zSqR8JR+gVyK1NLMTMiXrEEujl0342J+83p+d5M+hmTrqs2jGz9+kqjC3oe29w/bSl8flGSwRtu+1pCNpu3D876zeo25QMTJIDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769594142; c=relaxed/simple;
	bh=Nh8eZJNKaK7g93eRXEY1KophJItHTMM7iy/fZuPRY9M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PLBEQj5FXJEKxzdkopcFFYoQ/rO9h85EdUQdb+pNi+prnSF0hjPHBPQ6hjWh/Ae3BVwVCWgG3XlI5l2Nef/+f7PKY3ozlmKPjks4gbvoraqf/ViC/NlVvwXcphWODupGfhShKXzFWkDSafOdOz6YP92iQS5UXKZs6DckDbvukkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=osuPLtwk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5269AC4CEF1;
	Wed, 28 Jan 2026 09:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769594141;
	bh=Nh8eZJNKaK7g93eRXEY1KophJItHTMM7iy/fZuPRY9M=;
	h=From:To:Cc:Subject:Date:From;
	b=osuPLtwki64/LvIcNy1A7G2HJfKyF5es+gN5yLKW1r/56wS1ooQzaqlwt9bAVGFqq
	 LIlwQ1KELhj2/tXsCspiqZlCO+Mg5JYzkRf1Kt+fClmvWpnBb48pHqTZSJ5NPbvlQN
	 6oGJRmhMHcZbATM4Ud5PXRM7gbgmvaq5xrpBTZStYtlbW6XHH/3N4j3odc/Bzr52LV
	 LpzPiM2aNG5smtJMSo+7lV3TDTJd01JZG6uALARcXDZmf/x1UGMxXGSC8x/D+cJ3FM
	 NkiVOBh3gorweuejXFhxaqISB0G5DCw/lqoGANkYbMoUB5fMsf8B8c0tub03oiL6mk
	 G4xMzGnM6Jyow==
From: Leon Romanovsky <leon@kernel.org>
To: Long Li <longli@microsoft.com>,
	Konstantin Taranov <kotaranov@microsoft.com>
Cc: linux-rdma@vger.kernel.org,
	linux-hyperv@vger.kernel.org
Subject: [PATCH rdma-next] MAINTAINERS: Drop RDMA files from Hyper-V section
Date: Wed, 28 Jan 2026 11:55:25 +0200
Message-ID: <20260128-get-maintainers-fix-v1-1-fc5e58ce9f02@nvidia.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20260128-get-maintainers-fix-a9319fc985c8
X-Mailer: b4 0.15-dev-47773
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8556-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-hyperv@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[get_maintainer.pl:url,nvidia.com:mid,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3E1719F266
X-Rspamd-Action: no action

From: Leon Romanovsky <leonro@nvidia.com>=0D
=0D
MAINTAINERS entries are organized by subsystem ownership, and the RDMA=0D
files belong under drivers/infiniband. Remove the overly broad mana_ib=0D
entries from the Hyper-V section, and instead add the Hyper-V mailing list=
=0D
to CC on mana_ib patches.=0D
=0D
This makes get_maintainer.pl behave more sensibly when running it on=0D
mana_ib patches.=0D
=0D
Fixes: 428ca2d4c6aa ("MAINTAINERS: Add Long Li as a Hyper-V maintainer")=0D
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>=0D
---=0D
 MAINTAINERS | 3 +--=0D
 1 file changed, 1 insertion(+), 2 deletions(-)=0D
=0D
diff --git a/MAINTAINERS b/MAINTAINERS=0D
index 12f49de7fe03..d2e3353a1d29 100644=0D
--- a/MAINTAINERS=0D
+++ b/MAINTAINERS=0D
@@ -11739,7 +11739,6 @@ F:	arch/x86/kernel/cpu/mshyperv.c=0D
 F:	drivers/clocksource/hyperv_timer.c=0D
 F:	drivers/hid/hid-hyperv.c=0D
 F:	drivers/hv/=0D
-F:	drivers/infiniband/hw/mana/=0D
 F:	drivers/input/serio/hyperv-keyboard.c=0D
 F:	drivers/iommu/hyperv-iommu.c=0D
 F:	drivers/net/ethernet/microsoft/=0D
@@ -11758,7 +11757,6 @@ F:	include/hyperv/hvhdk_mini.h=0D
 F:	include/linux/hyperv.h=0D
 F:	include/net/mana=0D
 F:	include/uapi/linux/hyperv.h=0D
-F:	include/uapi/rdma/mana-abi.h=0D
 F:	net/vmw_vsock/hyperv_transport.c=0D
 F:	tools/hv/=0D
 =0D
@@ -17318,6 +17316,7 @@ MICROSOFT MANA RDMA DRIVER=0D
 M:	Long Li <longli@microsoft.com>=0D
 M:	Konstantin Taranov <kotaranov@microsoft.com>=0D
 L:	linux-rdma@vger.kernel.org=0D
+L:	linux-hyperv@vger.kernel.org=0D
 S:	Supported=0D
 F:	drivers/infiniband/hw/mana/=0D
 F:	include/net/mana=0D
=0D
---=0D
base-commit: a01745ccf7c41043c503546cae7ba7b0ff499d38=0D
change-id: 20260128-get-maintainers-fix-a9319fc985c8=0D
=0D
Best regards,=0D
--  =0D
Leon Romanovsky <leonro@nvidia.com>=0D
=0D

