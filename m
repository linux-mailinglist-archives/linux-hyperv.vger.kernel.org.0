Return-Path: <linux-hyperv+bounces-11712-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Whr7BOk7RGrrqwoAu9opvQ
	(envelope-from <linux-hyperv+bounces-11712-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 30 Jun 2026 23:58:01 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4FB6E83D9
	for <lists+linux-hyperv@lfdr.de>; Tue, 30 Jun 2026 23:58:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=SVYyNjuE;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11712-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11712-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 172C4305FAC0
	for <lists+linux-hyperv@lfdr.de>; Tue, 30 Jun 2026 21:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1DA2312836;
	Tue, 30 Jun 2026 21:57:58 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73F92D592C;
	Tue, 30 Jun 2026 21:57:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782856678; cv=none; b=V8kQvKYqxzI4lVgMjaLb7TOGRqI/5U+IxXaTAAe9KylmoPaWYOp1Cy0Ilfn5mXJPjYA05HgdAKBYpnSHjh7b4Hq8BnyTicPygnOOjZMwGjWowMsRROx1wkMHuHMPAJnRrO2NnwwInnUyr63UtPxpu1XJqRbjZ1p45AbcF0R5a8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782856678; c=relaxed/simple;
	bh=+kZe0PjH8G14gZWeBzK7oZnDykkjXHdzsJbJzqlqCVE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H5omzgoaX7aQuBEmT6Z3aOktFBxm9/nEWzj7f3JBAeD6XQcZnpEYkz5PlQU/deiCyGLFHLJ0+578wZe62n+N2CTcctYQxt9lLL9tjzL1Bs5tc8v54mHnvp1KiD98EwOS2goOK/vF6qHRF0SJBcjex39J4kK4Hajbyo7RM7GiuZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SVYyNjuE; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F5991F000E9;
	Tue, 30 Jun 2026 21:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782856677;
	bh=t85DkWwsmnF/KSxEPx7WybeVqj8vLCigV4gp0NJRo/c=;
	h=From:To:Cc:Subject:Date;
	b=SVYyNjuEgCkVNixIq12heEA5xi4OahAWKHjvs/TXNEQvMsxRXh5lZPBNiev+EMrJx
	 3xrCYwPINr9ohL8zZ2Ydct7ncGHF9ofyrsaBBOFrdO/GmcrwqelTHZH1lpH+THqjzy
	 ci7gR54/mmqds9E24/eB/QZguVvpClgpwE5+PpnKXVueBwu0Coi/JogDVm3Dg7wqV9
	 //WQzMMw8EnRGM0LxVN0ZtZFwVynz29ksdjAEZYGnXlIPOSyjXdeELgNKlULfOccOj
	 EH3DOqmDIDM0QR0BzmN3RYKzBbd+cg5fAvXtZtQu0sB1L1SA8LRa4UmVo0dBeP5sSE
	 8Wn9VULYX6CHw==
From: wei.liu@kernel.org
To: Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Cc: Wei Liu <wei.liu@kernel.org>,
	stable@kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] mshv: fix hv_input_get_system_property struct
Date: Tue, 30 Jun 2026 14:57:54 -0700
Message-ID: <20260630215754.200779-1-wei.liu@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11712-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:linux-hyperv@vger.kernel.org,m:wei.liu@kernel.org,m:stable@kernel.org,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:decui@microsoft.com,m:longli@microsoft.com,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[wei.liu@kernel.org,linux-hyperv@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.liu@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[linux-hyperv];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5F4FB6E83D9

From: Wei Liu <wei.liu@kernel.org>

Keep it in sync with the correct definition.

The old code worked by chance.

Cc: stable@kernel.org
Signed-off-by: Wei Liu <wei.liu@kernel.org>
---
 include/hyperv/hvhdk_mini.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/hyperv/hvhdk_mini.h b/include/hyperv/hvhdk_mini.h
index b4cb2fa26e9b..035ba20870f7 100644
--- a/include/hyperv/hvhdk_mini.h
+++ b/include/hyperv/hvhdk_mini.h
@@ -184,8 +184,9 @@ enum hv_dynamic_processor_feature_property {
 
 struct hv_input_get_system_property {
 	u32 property_id; /* enum hv_system_property */
+	u32 reserved;
 	union {
-		u32 as_uint32;
+		u64 as_uint64;
 #if IS_ENABLED(CONFIG_X86)
 		/* enum hv_dynamic_processor_feature_property */
 		u32 hv_processor_feature;
-- 
2.53.0


