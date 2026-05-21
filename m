Return-Path: <linux-hyperv+bounces-11143-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cFXAAWRxD2qOMQYAu9opvQ
	(envelope-from <linux-hyperv+bounces-11143-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 May 2026 22:56:04 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 575BB5ABEF0
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 May 2026 22:56:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0DA05302B3BB
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 May 2026 20:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A551A36CDE0;
	Thu, 21 May 2026 20:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=berkoc.com header.i=@berkoc.com header.b="I/d1xpaN";
	dkim=pass (2048-bit key) header.d=berkoc.com header.i=@berkoc.com header.b="j0Bb4uDn"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-01.1984.is (mail-01.1984.is [185.112.145.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88256343898;
	Thu, 21 May 2026 20:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.112.145.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779396961; cv=none; b=tfiOteWyxBHsmC2NUeb5prZF+LTy3edXS6HwHS76dzQiW2gIJa6ZDr7653GKFFltYUkX5hkcYiQ8+C6WMyVv6J0K+SISBgJr0L9DG7urIlgqZQbvNc8NUiDJj6VNXWLqjXZ0CRF29xtONvsdohA7OL+ifnpbEK9xVCXsHpOuKl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779396961; c=relaxed/simple;
	bh=UbtkUziU9MrEBAh6wfoFRZEbuggto4T8tPHJyZQiNpI=;
	h=Message-ID:From:To:Cc:Date:Subject; b=bJ2MKFZHDNabH85PcoLpv4vGhttc2eqSfrseKTZwtffBLRhoYYD+asJ5GDAphiDw8ORtHrevGfI+ahZCijw9D7pnzNQ88hI4cwuKBaUtuJdoVB/yXYg7XRPua3B+abpvNloWZ+QwL32t0weL4h0O81D/OAq6dcZYWwWLyM1rwws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=berkoc.com; spf=pass smtp.mailfrom=berkoc.com; dkim=pass (2048-bit key) header.d=berkoc.com header.i=@berkoc.com header.b=I/d1xpaN; dkim=pass (2048-bit key) header.d=berkoc.com header.i=@berkoc.com header.b=j0Bb4uDn; arc=none smtp.client-ip=185.112.145.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=berkoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=berkoc.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=berkoc.com;
	s=1984; h=Subject:Date:Cc:To:From:Message-ID:Sender:Reply-To:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=6gyF0HZWcO8v8WBQPrpU9hBMFdJgjkwXswAwpoH1LRo=; b=I/d1xpaN7Ul+dre+WI2o9hsBhL
	cLwU2D6isXRfZyRhCh9qVV/q5f1LN+NKX4HyyKjRAwQh/V0DDop2xuRVkgxI2m9Zoy/GtkhZbng2s
	gUXHy7Oue2KDtb7McJ6coDuaFdYXmThRdbeGMvSdpgzbvoH37ZQx6c6g0UNPVMJZAPqpuZtz9aleY
	QjnQpPu/xtP/H017TuxP9bH781wy0Nfy+pB+IsS2I2nGOAILoekS8qOUeG4/KQ1KqSOJhl60PgwGA
	zqqJ/7RHipAEzrD1k7k3bJILemw1gXyyk+2PoaJQjo0wKZ3mPUIidLRjmm2IbRA2mV4rCdRXIuPw/
	eGd9cKTQ==;
Received: from localhost
	by mail-01.1984.is with utf8esmtp (Exim 4.96)
	(envelope-from <me@berkoc.com>)
	id 1wQAQi-00DeZ4-3C;
	Thu, 21 May 2026 20:55:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=berkoc.com;
 i=@berkoc.com; q=dns/txt; s=me; t=1779396933; h=message-id : date :
 subject : cc : to : from : sender : reply-to;
 bh=6gyF0HZWcO8v8WBQPrpU9hBMFdJgjkwXswAwpoH1LRo=;
 b=j0Bb4uDns7zMYvdhVWX768q9/2zAbVC1+B81gj5q9WP8E1K+mB7hKs6wakh6euhee9RAw
 RsFEmvqS0bsQXL4EM5QOhx9EI9CRxIoy1wLm3Yivyu9r75TphX5hDmYGP93tGgGV+ez5mAI
 bPaKcrL9wN9A9KRJqbWmyUMRyvyImY/WwqHg64vkDdhvW4BEqnl4JhbKZiYFiZlAdySKWx6
 T0s0hCnmHTv4UypKRXzZ7jcc1BODq8XrfRFBuNc/yCwWwjPbdQUIAh5583+m0S9YvmQU7KV
 E0Zu8Q4KNoI4dv8gyKIQgNIK8bTd7IKm8o29TP+jHeBuLDm8juxZAfalvyYg==
Message-ID: <cover.1779396074.git.me@berkoc.com>
From: Berkant Koc <me@berkoc.com>
To: Saurabh Sengar <ssengar@linux.microsoft.com>, Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>
Cc: linux-hyperv@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, K. Y. Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Michael Kelley <mhklinux@outlook.com>, Thomas Zimmermann <tzimmermann@suse.de>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Deepak Rawat <drawat.floss@gmail.com>
Date: Thu, 21 May 2026 22:41:14 +0200
Subject: [PATCH v4 0/2] drm/hyperv: harden host message parsing
X-Spam-Score: -0.2 (/)
X-Authenticated-User: me@berkoc.com
X-Sender-Address: me@berkoc.com
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [5.64 / 15.00];
	SEM_URIBL_FRESH15(3.00)[berkoc.com:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[berkoc.com:s=me];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_MIXED(0.00)[];
	TAGGED_FROM(0.00)[bounces-11143-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,microsoft.com,kernel.org,outlook.com,suse.de,linux.intel.com,gmail.com];
	GREYLIST(0.00)[pass,meta];
	RCPT_COUNT_TWELVE(0.00)[14];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_DKIM_REJECT(0.00)[berkoc.com:s=1984];
	DMARC_POLICY_ALLOW(0.00)[berkoc.com,quarantine];
	DKIM_TRACE(0.00)[berkoc.com:-,berkoc.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	FROM_NEQ_ENVFROM(0.00)[me@berkoc.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c0a:e001:db::/64:c];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[berkoc.com:mid,berkoc.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 575BB5ABEF0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Two independent issues in the synthetic video driver that both stem
from trusting unvalidated host data.

1/2 bounds resolution_count from SYNTHVID_RESOLUTION_RESPONSE against
the supported_resolution[] array, and populates WIN8 defaults for
hv->screen_*_max / hv->preferred_* in both the WIN10-probe-failure
path and the pre-WIN10 path, so a failed or pre-WIN10 probe yields a
usable display instead of having drm_internal_framebuffer_create()
reject every userspace framebuffer with -EINVAL.

2/2 forwards bytes_recvd from vmbus_recvpacket() into the sub-handler,
rejects packets that do not cover the synthvid header, and requires
the type-specific payload size before memcpy/complete or before
reading the feature-change byte. Rejected packets are logged via
drm_err_ratelimited() instead of being silently dropped, matching the
CoCo-hardened pattern in hv_kvp_onchannelcallback().

1/2 is unchanged from v3 and carries Michael Kelley's Reviewed-by.

Changes since v3 (per review by Michael Kelley):

  2/2: validate SYNTHVID_RESOLUTION_RESPONSE against its actual
       variable length. The response carries resolution_count entries,
       not the full SYNTHVID_MAX_RESOLUTION_COUNT array, so requiring
       sizeof(struct synthvid_supported_resolution_resp) rejected the
       shorter responses the host legitimately sends and broke
       resolution probing. Require the fixed prefix, read and bound
       resolution_count, then require only the count-sized array.

  2/2: only run hyperv_receive_sub() when vmbus_recvpacket() returned
       success. v3 dropped the bytes_recvd upper bound as redundant,
       which holds only on a successful receive: on -ENOBUFS
       vmbus_recvpacket() reports the required length in bytes_recvd,
       which can exceed the 16 KiB hv->recv_buf, and the subsequent
       memcpy(hv->init_buf, msg, bytes_recvd) would read and write
       past both buffers. Gating on the success return restores the
       invariant that made the bound redundant, so an oversized host
       packet is dropped rather than copied.

Changes since v2 (per review by Michael Kelley):

  1/2: dropped the reinit_completion() change; the stale completion can
       only outlive its request in hyperv_vmbus_resume() after a
       get_supported_resolution() timeout, which is a narrower fix that
       belongs in a separate patch against the resume path. Pre-WIN10
       branch now also populates hv->preferred_*. The else branch is
       gone; a single screen_width_max == 0 check covers both the
       pre-WIN10 case and a failed WIN10 probe.

  2/2: added a per-type switch for the three completion-driving message
       types so the wait-completion path validates payload size before
       memcpy/complete. Every reject path emits drm_err_ratelimited()
       rather than returning silently.

Changes since v1:

  1/2: bound resolution_count check folded into the existing zero check;
       populate WIN8 defaults when hyperv_get_supported_resolution()
       fails.
  2/2: forward bytes_recvd into hyperv_receive_sub(); enforce the pipe +
       synthvid header minimum; check synthvid_feature_change payload
       size before reading is_dirt_needed.

The shared init_buf reuse (a duplicate or late host response can
overwrite init_buf between successive request/response cycles) and the
related completion reinit are real but orthogonal to this size
validation. As discussed on v2, they are queued as a separate follow-up
against the resume/expected-type path once this series lands.

This series is verified by static analysis and code inspection against
the synthvid protocol structures and the vmbus_recvpacket() contract. I
do not currently have a Hyper-V test environment to exercise the receive
and resolution-probe paths at runtime, so confirmation from someone who
can run it in a Hyper-V VM would be welcome.

Both patches carry an Assisted-by: Claude:claude-opus-4-7 berkoc-pipeline
trailer per the kernel coding-assistants policy. Code, analysis and
review responses are mine; the model is used as a structured reviewer
under human verification.

Berkant Koc (2):
  drm/hyperv: validate resolution_count and fix WIN8 fallback
  drm/hyperv: validate VMBus packet size in receive callback

 drivers/gpu/drm/hyperv/hyperv_drm_proto.c | 76 ++++++++++++++++++++---
 1 file changed, 69 insertions(+), 7 deletions(-)


base-commit: 4bf5d3da79c48e1df4bab82c9680c53adeff7820
-- 
2.47.3


