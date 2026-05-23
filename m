Return-Path: <linux-hyperv+bounces-11173-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kKRWJMO1EWpupAYAu9opvQ
	(envelope-from <linux-hyperv+bounces-11173-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 23 May 2026 16:12:19 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA855BF480
	for <lists+linux-hyperv@lfdr.de>; Sat, 23 May 2026 16:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA0D4302BDF0
	for <lists+linux-hyperv@lfdr.de>; Sat, 23 May 2026 13:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B46BD3947B8;
	Sat, 23 May 2026 13:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=berkoc.com header.i=@berkoc.com header.b="hVoif81v";
	dkim=pass (2048-bit key) header.d=berkoc.com header.i=@berkoc.com header.b="YKDlhUk1"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-03.1984.is (mail-03.1984.is [93.95.224.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9714025B0AA;
	Sat, 23 May 2026 13:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.95.224.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779544749; cv=none; b=GDOaU1xzPjC2urHJTbh+HLK1wsGHnS69+zgYSLDocZUxrnsKce+ijpftLgZptyyCwCxzqvKMrbM0tSd8YCpUMklhqvC6EiM6znioy0P0+A/oqFbKKUtp/OeTCqAO84FWEws/8ix790guSo1w62LU+eZ+L6f7eTuyY8a/qWiwTxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779544749; c=relaxed/simple;
	bh=FFDXoVXQmLtVPEZdyCChcI4fmDsy41lJVmTuSnI2jwE=;
	h=Message-ID:From:To:Cc:Date:Subject; b=p5aeR+x1Wwp/rYve3w/F9h8QKmR4kXN0f8wZ+IRvvX/IGNbPVdBmP8wwltoAdBVAojflxR5Fw6KLods/dnExveP+ESzzz6b6EtyPOZ5YzV/xDWJc2LIQ+8/rhttesL4vN7YC+O6TKyBLqLd2hiQQYNnzK1yFKEW9CXk4lT5xne4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=berkoc.com; spf=pass smtp.mailfrom=berkoc.com; dkim=pass (2048-bit key) header.d=berkoc.com header.i=@berkoc.com header.b=hVoif81v; dkim=pass (2048-bit key) header.d=berkoc.com header.i=@berkoc.com header.b=YKDlhUk1; arc=none smtp.client-ip=93.95.224.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=berkoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=berkoc.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=berkoc.com;
	s=1984; h=Subject:Date:Cc:To:From:Message-ID:Sender:Reply-To:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=AfbvvKdcTGdnNuSgMETMip6O9mEDFZRdMO+Wt+D6oX8=; b=hVoif81vuqwzeV6+lOaABVLsEA
	KYwGxxTlt9nTPqzXrsi/mXq8AkmGiW21IVN5fOgjbRTlBeqtWt4HVZiQHx1faokgpSpXPHr4UG4BA
	prEvjfWLV4ZiNih6FUhkESwxubQIiFR8BsNGEoH7281Rs4/1f2XmhrXlrWvsBFQI1Nb2dPXw5ySZq
	7XM0+9Zg9SoCRfBI7tohUQM5xDzx92cZR6l/x+qR2uU8wX6ET23/d5f/nUa+tiXjXS1KZObwOsNmB
	nWkWx2ku5cjG+xN2qzyZBajz2qO+uWrtKk9qkmC1fxRMPXxDlDi2KEIjWJAHMNidqMQS7b+Nc021i
	Jezk7TbA==;
Received: from localhost
	by mail-03.1984.is with utf8esmtp (Exim 4.96)
	(envelope-from <me@berkoc.com>)
	id 1wQmsV-004m47-10;
	Sat, 23 May 2026 13:59:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=berkoc.com;
 i=@berkoc.com; q=dns/txt; s=me; t=1779544724; h=message-id : date :
 subject : cc : to : from : sender : reply-to;
 bh=AfbvvKdcTGdnNuSgMETMip6O9mEDFZRdMO+Wt+D6oX8=;
 b=YKDlhUk1WRDcfLlqbEx1pmDQT1Un40SIonJfzUhPiA7unMfdXQehZ6GfgKYrEw0FKPZfe
 9ENtTS3y/2TWaBvo9IQ5UI/dHrLrL5pIYLLfbkEiRsCcIYJKoZoYrMe2hMxqL4Q39A2k66b
 BKypGZULauBnmVNGpAJAEAtr8YCSEOkBe/piOnb6mhx2wwMA/Cd/JnUWpVttTY2taO8sYpQ
 wzZ5ZoY4LqC+QfH2bnk6GMAEixKkmjFNXOkKOUo00Qm4c4aHsknknsdJ3Aishp/vt9F8R3G
 cnouZEgmlzwoaGLVaXM4NumrjCgcVWuyDquutkHZt2ODDDBmLDXy80sI5mHw==
Message-ID: <cover.1779542874.git.me@berkoc.com>
From: Berkant Koc <me@berkoc.com>
To: Saurabh Sengar <ssengar@linux.microsoft.com>, Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>
Cc: linux-hyperv@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, K. Y. Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Michael Kelley <mhklinux@outlook.com>, Thomas Zimmermann <tzimmermann@suse.de>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Deepak Rawat <drawat.floss@gmail.com>
Date: Sat, 23 May 2026 15:27:54 +0200
Subject: [PATCH v5 0/2] drm/hyperv: harden host message parsing
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
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11173-lists,linux-hyperv=lfdr.de];
	DKIM_MIXED(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,microsoft.com,kernel.org,outlook.com,suse.de,linux.intel.com,gmail.com];
	GREYLIST(0.00)[pass,body];
	RCPT_COUNT_TWELVE(0.00)[14];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_DKIM_REJECT(0.00)[berkoc.com:s=1984];
	DMARC_POLICY_ALLOW(0.00)[berkoc.com,quarantine];
	DKIM_TRACE(0.00)[berkoc.com:-,berkoc.com:+];
	NEURAL_HAM(-0.00)[-0.968];
	TAGGED_RCPT(0.00)[linux-hyperv];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[me@berkoc.com,linux-hyperv@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	R_SPF_ALLOW(0.00)[+ip4:172.234.253.10:c];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[berkoc.com:mid,berkoc.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 2DA855BF480
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

1/2 is unchanged from v3/v4 and carries Michael Kelley's Reviewed-by.

Changes since v4 (per review by Michael Kelley):

  2/2: collapsed the leading "if (type == ... ) { ... switch ... }"
       plus the separate "if (type == FEATURE_CHANGE)" into a single
       switch on msg->vid_hdr.type. The three completion-driving cases
       compute their per-type size and break to a shared exit that does
       the size check + memcpy(init_buf) + complete(); FEATURE_CHANGE is
       its own case that validates its payload and returns without
       falling through; unknown types hit default and return. No
       functional change, fewer lines.

  2/2: the vmbus_recvpacket() nonzero-return path (e.g. -ENOBUFS for a
       too-big packet) is itself a malformed-message case. It is now
       logged via drm_err_ratelimited(), consistent with the
       sub-handler's other reject paths, instead of being silently
       skipped. No channel recovery is attempted, as that is not worth
       the added code for this rare host-side condition.

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

 drivers/gpu/drm/hyperv/hyperv_drm_proto.c | 113 +++++++++++++++++++---
 1 file changed, 97 insertions(+), 16 deletions(-)


base-commit: 4bf5d3da79c48e1df4bab82c9680c53adeff7820
-- 
2.47.3


