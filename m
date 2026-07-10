Return-Path: <linux-hyperv+bounces-11889-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FyTKAPlYUGqAxAIAu9opvQ
	(envelope-from <linux-hyperv+bounces-11889-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Jul 2026 04:29:13 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 71839736A93
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Jul 2026 04:29:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Fp6qZNcy;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11889-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11889-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 733723025C5B
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Jul 2026 02:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA302BEFF5;
	Fri, 10 Jul 2026 02:29:02 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9BD2C3255
	for <linux-hyperv@vger.kernel.org>; Fri, 10 Jul 2026 02:29:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783650542; cv=none; b=rnBBtzjuLK6YL1wPgGufmP6PSHHeDol12WuraVsPI59BqoO9QxTXiem/k1s7e3hftEYp3cUQ4H2EQ9/aUpGMnjhSBIAMhlqPx/YjcAWHvZ1MMR+k7QwbumnNE0/qCvZmqZS0CBlRNTlQg3BmqEp2bBNAcpAZSLVyS4TqdjK3Mro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783650542; c=relaxed/simple;
	bh=IJkqPJypQc7GLzpERLUahs7dKBADnN+RxSys4p0uAWw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=njoruulTtHALIuwLxRlS04KKgb/To6dXyT53tNssn430kiuviw0CrUDwZXb26iGRIDJ6eI3JkpOYEiqPTm3xJj4Ux9eYyF1b/bzeZa+3dPJAs1jhDjpqO7tJp8pthX6y4hXodAqnpSwkHqJs0+rCy+LiUPrHW03yts5cDWthlrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fp6qZNcy; arc=none smtp.client-ip=209.85.222.181
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-92ed3993c1eso23139585a.1
        for <linux-hyperv@vger.kernel.org>; Thu, 09 Jul 2026 19:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783650540; x=1784255340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eokHULuHuReut0+2I3ViyzYy6XEeFIbj+NJmSsqM9JY=;
        b=Fp6qZNcysCjj+oR7YU6eK/Kxtf/8NwStFvYDclOODYj3LicZoJ0/QPDC1Ew6D0gWtL
         ZTlrPmUc7UhNVa4DKAfaKjklPqXHOUFCftLJgIbtkdGgdJKqy6bY6qqSW7Xqbcf8LZMC
         UNpafK8KLzIPgEXMgq2xPC/WxrmtrqMU43d3QKJWRrdUfQEgQ4tpDqdvI5EZ3gd06+Dr
         7LvF/B7HJqWYhWKhnvTZS/frP8zVwhXhalppioD8rbO9a2b0N9DTNPzGS4dDxJ/dovi2
         bpigm1dlqcyIBuflepWSp+PDoHeAZ1G96GAvqJCLQ+6HPqWpGGxG1Shw4Qu65twkyTvd
         sEmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783650540; x=1784255340;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eokHULuHuReut0+2I3ViyzYy6XEeFIbj+NJmSsqM9JY=;
        b=QZV/JocaofjiuVfHbBnN+0X+yfp0RRelHnnpjC4jmfwZG7niz6DYfHlr//81qYcAie
         7MtiHZwXZu5Wf3/bBRFYWl8mMO0kcEBRKd6MX/ds1kNjqzbqV5NI3Gr8oMK4tRZveo9G
         Ytcr10MSSk2Rc8dFlP3aVk09p/5w+pD6IIQIW8GeChH9ZyPKAZsx9jXErXVSV5udPiAO
         0friwftNS+6Iv6GpXwXZwe8WcrqkttxOYOJ4vMru2y4Lrcgqd/5P2UDJ7YaZ4FbvFdbT
         HnGMTrQXzn+7oDG6yrA74oWX0KVSFFIWZqfaK3cZ7xA4TnQdBe5dgT0wqKPCg0cgk9Y6
         pnfQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq86e8zxYGixwXoRqILXQutNinfggEp1dcY7x69UqEEiZC1EsoLZWFDlRFekNOr0kHuaalS7P/rG85GV8s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXldYeimSLFEr32B3rdStyUE86YQ6emVWS/Jhfv7hkGSMpbYX0
	X8Wu2HM5VrpgDkepqVqRrMC40IHRdhClr2g2xDWWwi56fMp3XOKDbZWS
X-Gm-Gg: AfdE7cnuexex156h5Ngl5VHTHrln/bEGeXtwtUS4s6RqWUKcOxoopAa+3bllkHdnQyq
	GxmbB/PDbQKFbR76xuKKUe7rKGGrZ0/OhcV7I/cxcVVfy3nI3L2aw57mIbr6T1NwAe6Mk2lUkfQ
	/1gvKwbYnno8dLBqSxpo7UWQIPPnnZKd2+Hs0uCw57C3qh4nuhs4s5XlMsgKTj3kryqJmjta7SF
	XMIi0e3tX4faXCZNKsuEwRKvrtD50AaoLYV5wjW5GcAU7kyRnn+nuSNqGdJy2BoAdSBn6apWSLC
	MvWdV/THGuIu+ecItOP/3L2C1gt9grggtTO3hQdjWIusbfqXIkc3emEZzFFUZTxct/pH6srDJis
	yjAJCD65F51oY3jNAWziqPi5r0tY6EaNkr4nWcb5UOxryXHlyyej1KYnK93Vxecb0ygGPc6u8FP
	/AYsIuOSzpKzN+9vXKxih50n3lXJUD55SYJMNzT6uhBlR7AFVSFxNQYZbJxOTj7495PvQhZCbo5
	21zK7z/iJG2yjmgYZQwd8qDouIPzFLG
X-Received: by 2002:a05:620a:46a9:b0:92b:67e6:8ac2 with SMTP id af79cd13be357-92ecf6b4bedmr1085970385a.60.1783650539736;
        Thu, 09 Jul 2026 19:28:59 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5b86276sm90507885a.11.2026.07.09.19.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 19:28:59 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	kys@microsoft.com,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>
Cc: Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	linux-input@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 0/2] HID: hyperv: bound initial device info descriptor
Date: Thu,  9 Jul 2026 22:28:52 -0400
Message-ID: <20260710022854.3739558-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11889-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jikos@kernel.org,m:bentiss@kernel.org,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:longli@microsoft.com,m:linux-input@vger.kernel.org,m:linux-hyperv@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[michaelbommarito@gmail.com,linux-hyperv@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 71839736A93

A malicious Hyper-V host or backend can crash a guest with a short
SYNTH_HID_INITIAL_DEVICE_INFO message. mousevsc_on_receive_device_info()
trusts the HID descriptor bLength and wDescriptorLength without checking
that the received VMBus packet actually contains both byte ranges, so a
truncated packet with an oversized report-descriptor length makes the
guest read past the received packet while copying the descriptor. This
matters most for a confidential guest, where the host is outside the trust
boundary.

Patch 1 passes the received initial-device-info size into the parser and
rejects descriptor lengths that exceed the packet. Patch 2 adds
same-translation-unit KUnit coverage: a well-formed message that must
still parse and the truncated/oversized message that must now be rejected.

Reproduced with the KUnit/KASAN test: stock reads past the packet on the
short message after the benign control passes; patched rejects it and both
cases pass.

Cc: stable@vger.kernel.org

Michael Bommarito (2):
  HID: hyperv: validate initial device info bounds
  HID: hyperv: add KUnit coverage for device info bounds

 drivers/hid/Kconfig      |  10 +++
 drivers/hid/hid-hyperv.c | 144 ++++++++++++++++++++++++++++++++++++---
 2 files changed, 144 insertions(+), 10 deletions(-)

--
2.53.0

