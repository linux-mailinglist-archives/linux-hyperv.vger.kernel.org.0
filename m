Return-Path: <linux-hyperv+bounces-10513-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2NfjKhjU8mmyugEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10513-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 30 Apr 2026 06:01:28 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A0249D1A4
	for <lists+linux-hyperv@lfdr.de>; Thu, 30 Apr 2026 06:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B493930103BB
	for <lists+linux-hyperv@lfdr.de>; Thu, 30 Apr 2026 04:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BFCF35295E;
	Thu, 30 Apr 2026 04:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="lcKZKe1r"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85054A35;
	Thu, 30 Apr 2026 04:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777521685; cv=none; b=hlOvBnzelqpRqulmFsasvKEmX9BQK0MGgAkLv8KnCa90b47JajSfqTymzmaap0JQlcrrn1AqB04XVJMvJynvwv/Fn77JQqh9auYQ9x9Lo/W2kewVvBmXyDa5VaGvpNYRLpG5JEJBgywvoeu5fq30JjLaeh6esjsrfFiRWans9ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777521685; c=relaxed/simple;
	bh=8oxP5EqKXJYQuAtM9mvq5dYKEkKBVCKuUMutgRZC1mM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Jg75/PtL9Qx4KIu+nIgESFm3mf6ip/Y67xLpnUKfWT4/J2MlW3EkyX6RCk/obIpSqwIzenSWUUIsXfwc+p3830KYOw6PjBGF/uooDDCZC/3bfv9laeRA2lrwQ+S607R/kVCA9O7CvCeM6WDoJUc5y4LW+C6wY2CIZljNX4p81yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=lcKZKe1r; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 99BFF20B716C;
	Wed, 29 Apr 2026 21:01:23 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 99BFF20B716C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777521683;
	bh=KRsW0ZE1gsdLQcEsyxF+0Whp9BSulyxr8i92HJWzBww=;
	h=From:To:Subject:Date:From;
	b=lcKZKe1r7ErSAkUflJjK5oHZi6OGOoIvW/jqQzamDGsZ6c99zUHQ7xQEkFJNQ6mic
	 bywkglQWfbbVyV5Y7BsHoyEr2TS0jqG5z+ILeRbDNUGunxjGQBKozRXfgR8KfuCIlQ
	 +7nmxGgIdkn7TaPE3ld/5HrcVzl6Y18Z7QTwYGjk=
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
	yury.norov@gmail.com
Subject: [PATCH 0/3] net: mana: Fix mana_destroy_rxq() cleanup for partial RXQ init
Date: Wed, 29 Apr 2026 20:57:51 -0700
Message-ID: <20260430035935.1859220-1-dipayanroy@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 88A0249D1A4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10513-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[microsoft.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,linux.microsoft.com,vger.kernel.org,networkplumber.org,intel.com,debian.org,gmail.com,iogearbox.net,fomichev.me];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dipayanroy@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

When mana_create_rxq() fails partway through initialization (e.g. the
hardware rejects the WQ object creation), the error path calls
mana_destroy_rxq() to tear down a partially-initialized RXQ.
This exposed multiple issues in mana_destroy_rxq() path, as it assumed
the RXQ was always fully initialized, leading to multiple issues:

1. xdp_rxq_info_unreg() was called on an unregistered xdp_rxq,
   triggering a WARN_ON ("Driver BUG") in net/core/xdp.c.

2. mana_destroy_wq_obj() was called with INVALID_MANA_HANDLE,
   sending a bogus destroy command to the hardware.

3. mana_deinit_cq() was called twice — once inside mana_destroy_rxq()
   and again in mana_create_rxq()'s error path — causing a
   use-after-free since mana_destroy_rxq() frees the rxq first.

This was observed during ethtool ring parameter changes when the
hardware returned an error creating the RXQ. This series makes
mana_destroy_rxq() safe to call at any stage of RXQ initialization
by guarding each teardown step, and removes the redundant cleanup
in mana_create_rxq().

Dipayaan Roy (3):
  net: mana: check xdp_rxq registration before unreg in
    mana_destroy_rxq()
  net: mana: Skip WQ object destruction for uninitialized RXQ
  net: mana: remove double CQ cleanup in mana_create_rxq error path

 drivers/net/ethernet/microsoft/mana/mana_en.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

-- 
2.43.0


