Return-Path: <linux-hyperv+bounces-11182-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UIxxB4oEFGpSIwcAu9opvQ
	(envelope-from <linux-hyperv+bounces-11182-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 25 May 2026 10:12:58 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9107F5C7853
	for <lists+linux-hyperv@lfdr.de>; Mon, 25 May 2026 10:12:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 153733017BD1
	for <lists+linux-hyperv@lfdr.de>; Mon, 25 May 2026 08:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 961C33DEAE0;
	Mon, 25 May 2026 08:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="hmK/apTH"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0093DC4D0;
	Mon, 25 May 2026 08:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779696746; cv=none; b=dc3jEqiWhY6Pz010+rl+X74ySb1p9KC6fiXWMaWTx96KX3lSMJVk27TME+mxTpiRx3uasbOypj7s3JTz98jmVbub04khMdHxnUeH6D9tm3lQfL90CVlHsKl6FiMR/IR/JEOtjKWXrf6D4QB50EB1ffzl/LjYXs5CWVNO3ONci3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779696746; c=relaxed/simple;
	bh=6WkTC/HbSabZ+JULKTVHSv/7mEown2M+txjSQJP/g+4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u6HHm0E4Vt5P/Y1eyLGjGcBi3QXuyh3QGBRPv1RxbxrrxoNDq0AZrTGv/jgOxUvP7dXmTFlC6JWZGkn/Qxv1GwPAsyid1QPnZD9jFrFczrIfGBv9oTuL2I3Vtuf0C3AkIq6v1OF/KVDPNXEo1Yv9hi/2NZKhgOiBd6YjcZEbUq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=hmK/apTH; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id B383C20B716A;
	Mon, 25 May 2026 01:12:06 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B383C20B716A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1779696726;
	bh=yUPS4+X1jCtRIosSeKaXW0vT+grEGU2AMILBtNl9IpI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=hmK/apTH1yvHX75Q8xyzDXBjsGpewpzVO5hns7qygOg6Apto41dcjcuyrZT9z5moz
	 bKk0iSKuqoc7fbLGb0zyqHkNCXxTTIb2L90c7O5MyU/pLLBUXRE3d6qmoZSgivRlzw
	 hWqB92wZVd5Q8ptA7ISAq2U/OApJ89wK+jJpfIb4=
From: Dipayaan Roy <dipayanroy@linux.microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	leon@kernel.org,
	longli@microsoft.com,
	kotaranov@microsoft.com,
	horms@kernel.org,
	shradhagupta@linux.microsoft.com,
	ssengar@linux.microsoft.com,
	ernis@linux.microsoft.com,
	shirazsaleem@microsoft.com,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	stephen@networkplumber.org,
	jacob.e.keller@intel.com,
	dipayanroy@microsoft.com,
	leitao@debian.org,
	kees@kernel.org,
	john.fastabend@gmail.com,
	hawk@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	ast@kernel.org,
	sdf@fomichev.me,
	yury.norov@gmail.com,
	pavan.chebbi@broadcom.com
Subject: [PATCH net v3 2/2] net: mana: Skip redundant detach on already-detached port
Date: Mon, 25 May 2026 01:08:25 -0700
Message-ID: <20260525081129.1230035-3-dipayanroy@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260525081129.1230035-1-dipayanroy@linux.microsoft.com>
References: <20260525081129.1230035-1-dipayanroy@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[microsoft.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,linux.microsoft.com,vger.kernel.org,networkplumber.org,intel.com,debian.org,gmail.com,iogearbox.net,fomichev.me,broadcom.com];
	TAGGED_FROM(0.00)[bounces-11182-lists,linux-hyperv=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dipayanroy@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	NEURAL_HAM(-0.00)[-0.984];
	RCPT_COUNT_TWELVE(0.00)[34];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux.microsoft.com:mid,linux.microsoft.com:dkim]
X-Rspamd-Queue-Id: 9107F5C7853
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When mana_per_port_queue_reset_work_handler() runs after a previous
detach succeeded but attach failed, the port is left in a detached
state with apc->tx_qp and apc->rxqs already freed. Calling
mana_detach() again unconditionally leads to NULL pointer dereferences
during queue teardown.

Add an early exit in mana_detach() when the port is already in
detached state (!netif_device_present) for non-close callers, making
it safe to call idempotently. This allows the queue reset handler and
other recovery paths to simply retry mana_attach() without redundant
teardown.

Fixes: 3b194343c250 ("net: mana: Implement ndo_tx_timeout and serialize queue resets per port.")
Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Dipayaan Roy <dipayanroy@linux.microsoft.com>
---
 drivers/net/ethernet/microsoft/mana/mana_en.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 0582803907a8..1e1ad2795c3c 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -3350,6 +3350,12 @@ int mana_detach(struct net_device *ndev, bool from_close)
 
 	ASSERT_RTNL();
 
+	/* If already detached (indicates detach succeeded but attach failed
+	 * previously). Now skip mana detach and just retry mana_attach.
+	 */
+	if (!from_close && !netif_device_present(ndev))
+		return 0;
+
 	apc->port_st_save = apc->port_is_up;
 	apc->port_is_up = false;
 
-- 
2.43.0


