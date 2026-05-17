Return-Path: <linux-hyperv+bounces-10992-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EKniMV2+CWqqngQAu9opvQ
	(envelope-from <linux-hyperv+bounces-10992-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sun, 17 May 2026 15:10:53 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CAD65611F9
	for <lists+linux-hyperv@lfdr.de>; Sun, 17 May 2026 15:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 639C6300A610
	for <lists+linux-hyperv@lfdr.de>; Sun, 17 May 2026 13:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B77938B7D9;
	Sun, 17 May 2026 13:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=berkoc.com header.i=@berkoc.com header.b="pfpT511i"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-01.1984.is (mail-01.1984.is [185.112.145.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205CA38CFFE;
	Sun, 17 May 2026 13:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.112.145.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779023408; cv=none; b=uue/MXDG3cNZM5Nusie5vj5xj4+Bg+hNCDRW0gXiDc3Elqrz9sL2L0QAjxAUanbAIsKZ0PXRS3t2BTfLk6WZrlPKkr7aZ2JGfD0AjDNNi+/ZH/4cwvbBlCXWbwE6L/hL2/hK5xbcOKiCNeTPlHM4Rz18qAc8hix9H8mHvrDuOJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779023408; c=relaxed/simple;
	bh=lxIQXDqcCK6bENgJnOOV7zQ9/RfTn8yccIUSUnPe7Xo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=azPqXTRzMVe4E5JBxusJNP3N6UmvAW2hUMLpNMbgtSMViiKJBy1VwpFdjt6X2xawNf4pXeKiIoTMytB/D90dKrCgRnatQJoQRXMCeQzcWH6A13El83MNfjlJfOtzzbfuWJ+tECKGyy3hSCY3d22UCZTLKIJAiSag6gULgGXO+NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkoc.com; spf=pass smtp.mailfrom=berkoc.com; dkim=pass (2048-bit key) header.d=berkoc.com header.i=@berkoc.com header.b=pfpT511i; arc=none smtp.client-ip=185.112.145.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=berkoc.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=berkoc.com;
	s=1984; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date
	:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=eAHnVX5ofCROL6dD/lUWJLdN6yFCfghtocjMNvR+AIY=; b=pfpT511iiLMpDH2n2tGpOrAA/z
	mcvV4hoVjiHCy+WT0ZjSDbuqywwAIZP9nBwoNtbtCVuqWNaDreWSeZUGz8T5j4T7xnYj6U2my5FiM
	RHo0+LBwPgUVtOH87IddThLvXWFGt5+XnZE3DKJDcGIgFNHGHVhWFR0J7Wh8FFupI8zQXPR0FEf6o
	JBZmP4Hhn/1IDJsV3AzHYPBp3nLnVT8lci/EBT+Frnpnjg9C4eNFmvFVKXHDIvhgXaqOTgWCMJoMb
	0LS+6D8qT0WyQ/e4X3EKvBr3lBIMbu9Pu4awb6J5uL/2JNEIZAq/HoPsWzk3SNYKoqBf+nSSRghBa
	e+eurULg==;
Received: from localhost
	by mail-01.1984.is with utf8esmtp (Exim 4.96)
	(envelope-from <me@berkoc.com>)
	id 1wObFn-00G0yq-2c;
	Sun, 17 May 2026 13:10:00 +0000
From: Berkant Koc <me@berkoc.com>
To: Saurabh Sengar <ssengar@linux.microsoft.com>, Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>
Cc: linux-hyperv@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Wei Liu <wei.liu@kernel.org>, Michael Kelley <mhklinux@outlook.com>, Thomas Zimmermann <tzimmermann@suse.de>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Deepak Rawat <drawat.floss@gmail.com>
Subject: [PATCH 0/2] drm/hyperv: harden VMBus message parser input validation
Date: Sun, 17 May 2026 14:55:00 +0200
Message-ID: <20260517-drm-hyperv-cover@berkoc.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Score: -0.0 (/)
X-Authenticated-User: me@berkoc.com
X-Sender-Address: me@berkoc.com
X-Rspamd-Queue-Id: 4CAD65611F9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.04 / 15.00];
	DMARC_POLICY_REJECT(2.00)[berkoc.com : SPF not aligned (strict),reject];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[berkoc.com:s=1984];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10992-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,kernel.org,outlook.com,suse.de,linux.intel.com,gmail.com];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[me@berkoc.com,linux-hyperv@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[berkoc.com:-];
	NEURAL_HAM(-0.00)[-0.917];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[berkoc.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

The hyperv synthetic video driver parses VMBus messages from the host
without bounding two host-controlled values that feed into fixed-size
buffers. Both items are input validation, not security bugs: the
Hyper-V host sits inside the trusted compute base under the default
Hyper-V threat-model. The patches still trim the inputs the driver
accepts at face value, matching the trajectory drivers/hv/ has
followed for Confidential-VMBus work where the host is no longer
fully trusted.

Patch 1 bounds resolution_count against
supported_resolution[SYNTHVID_MAX_RESOLUTION_COUNT]; the existing
default_resolution_index check is bypassable when both values
exceed 64.

Patch 2 forwards bytes_recvd from vmbus_recvpacket() into the
sub-handler so that vid_hdr.type and feature_chg.is_dirt_needed
are only read once the host actually delivered enough bytes, and
so that the init_buf memcpy uses the received length.

Sending as a plain patch series, not a security disclosure.
Compile-tested against drm-fixes (6916d5703ddf), static-only.

Berkant Koc (2):
  drm/hyperv: validate resolution_count from host VMBus message
  drm/hyperv: validate VMBus packet size in receive callback

 drivers/gpu/drm/hyperv/hyperv_drm_proto.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)


base-commit: 6916d5703ddf9a38f1f6c2cc793381a24ee914c6
-- 
2.47.3

