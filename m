Return-Path: <linux-hyperv+bounces-11938-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id G0DiLz3DUWqiIQMAu9opvQ
	(envelope-from <linux-hyperv+bounces-11938-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 11 Jul 2026 06:14:53 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B44974041A
	for <lists+linux-hyperv@lfdr.de>; Sat, 11 Jul 2026 06:14:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.microsoft.com header.s=default header.b=OmsVJg0q;
	dmarc=pass (policy=none) header.from=linux.microsoft.com;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11938-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11938-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B5C0301DE07
	for <lists+linux-hyperv@lfdr.de>; Sat, 11 Jul 2026 04:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E132EB859;
	Sat, 11 Jul 2026 04:14:44 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1DB2E7165;
	Sat, 11 Jul 2026 04:14:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783743284; cv=none; b=SGbKM/LuSCqO5SxM6Rch1LQurDRz3Pn/3fTpTfAXw/Y+7xJMA35FVu29Q4R7v9a9xFOn7eQU3Ikt3jG48nRsCXKHcVXZ/5ZN6JMMs2HTFEJxU/8ifEBKz7kyhLToHuwfLjnq9b+TV2bs7hIhSEHZjSDFD//ihKjydLRqi4LrDIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783743284; c=relaxed/simple;
	bh=okSyZywuqHV+Cm2f8lzFI27HsSTmR6M4in7XkC4F/oA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sAscS+bY5Xto3PWgmAFXVSA83WbSN9YEarb8lFxLys8IahT5zZIafxV8eBCbUPqj609tMIQCc9wFYKMXAgCIKuofcwgI8qK5gP5zYmdsNXfpcPUqHBpRUDn+XakOJtVvoOmIIVPNnlfjFmBcc2Q/2cnAQITIfX4WVdUt0zNHi1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=OmsVJg0q; arc=none smtp.client-ip=13.77.154.182
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 81C5920B7172;
	Fri, 10 Jul 2026 21:14:33 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 81C5920B7172
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1783743273;
	bh=QUJr0cSBp7DDYOpENoiFxljH1AKPOMDQDxe5QybqQo4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=OmsVJg0qDaEa8xvcK1Zgf6EIDfjKTZBc4q5n1AIafgjkoLmY9zeHaLX7P6rOBmzFP
	 TrwoJWD2sGkScJfDMqNcNAazKt/U6AqsOkzfxBKAh2uoQzxmiL7GQIRcRxEkCp9UBF
	 5Pl1tfoJi379pDeKQKcWJQc5dyacyS8bi+yP3CV8=
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
	pavan.chebbi@broadcom.com,
	schakrabarti@linux.microsoft.com,
	gargaditya@linux.microsoft.com
Subject: [PATCH net-next v12 2/4] net: mana: do not bail out of mana_detach on dealloc failure
Date: Fri, 10 Jul 2026 21:10:22 -0700
Message-ID: <20260711041415.3008868-3-dipayanroy@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260711041415.3008868-1-dipayanroy@linux.microsoft.com>
References: <20260711041415.3008868-1-dipayanroy@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[microsoft.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11938-lists,linux-hyperv=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[microsoft.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,linux.microsoft.com,vger.kernel.org,networkplumber.org,intel.com,debian.org,gmail.com,iogearbox.net,fomichev.me,broadcom.com];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[dipayanroy@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:leon@kernel.org,m:longli@microsoft.com,m:kotaranov@microsoft.com,m:horms@kernel.org,m:shradhagupta@linux.microsoft.com,m:ssengar@linux.microsoft.com,m:ernis@linux.microsoft.com,m:shirazsaleem@microsoft.com,m:linux-hyperv@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:stephen@networkplumber.org,m:jacob.e.keller@intel.com,m:dipayanroy@microsoft.com,m:leitao@debian.org,m:kees@kernel.org,m:john.fastabend@gmail.com,m:hawk@kernel.org,m:bpf@vger.kernel.org,m:daniel@iogearbox.net,m:ast@kernel.org,m:sdf@fomichev.me,m:yury.norov@gmail.com,m:pavan.chebbi@broadcom.com,m:schakrabarti@linux.microsoft.com,m:gargaditya@linux.microsoft.com,m:andrew@lunn.ch,m:johnfastabend@gmail.com,m:yurynorov@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[36];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dipayanroy@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:from_mime,linux.microsoft.com:dkim,linux.microsoft.com:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5B44974041A

mana_detach() sets port_is_up = false before calling
mana_dealloc_queues(). If that call were to fail and return early,
netif_device_detach() and mana_cleanup_port_context() are skipped,
leaving the port in an inconsistent state where port_is_up is false
but netif_device_present() still returns true. A subsequent
mana_detach() from the reset work handler would then overwrite
port_st_save with false, causing mana_attach() to skip queue
allocation and leave the port permanently dead.

Remove the early return so that mana_detach() always completes its
full teardown. mana_dealloc_queues() already performs best-effort
cleanup regardless of internal errors (and in practice cannot fail
here since port_is_up is already false), so continuing to
netif_device_detach() and mana_cleanup_port_context() is safe and
ensures the state is always consistent for recovery.

Signed-off-by: Dipayaan Roy <dipayanroy@linux.microsoft.com>
---
 drivers/net/ethernet/microsoft/mana/mana_en.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 89e7f59f635d..5e3c7a2a2b49 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -3707,10 +3707,8 @@ int mana_detach(struct net_device *ndev, bool from_close)
 
 	if (apc->port_st_save) {
 		err = mana_dealloc_queues(ndev);
-		if (err) {
+		if (err)
 			netdev_err(ndev, "%s failed to deallocate queues: %d\n", __func__, err);
-			return err;
-		}
 	}
 
 	if (!from_close) {
-- 
2.43.0


