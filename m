Return-Path: <linux-hyperv+bounces-11038-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EGlMMFnIDGrAlwUAu9opvQ
	(envelope-from <linux-hyperv+bounces-11038-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 19 May 2026 22:30:17 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E81584B64
	for <lists+linux-hyperv@lfdr.de>; Tue, 19 May 2026 22:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 11454300BC6A
	for <lists+linux-hyperv@lfdr.de>; Tue, 19 May 2026 20:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253EF3B9D89;
	Tue, 19 May 2026 20:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=berkoc.com header.i=@berkoc.com header.b="VZmFfgCe";
	dkim=pass (2048-bit key) header.d=berkoc.com header.i=@berkoc.com header.b="Bbm8HnIA"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-03.1984.is (mail-03.1984.is [93.95.224.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8D92E7F2C;
	Tue, 19 May 2026 20:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.95.224.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779222221; cv=none; b=AzGp0bf/Y660tHwgAUajbQ0z/AfsQAjL8kpb/4TZVgfO2GjaLWdOvqJMk2nN1SASj8r1znXDMqq+PAAVPaNUaak9wIE47QdWCAUMooKQpXALuOaN2pD0zPGLmp3dzaVLQJFxHX/7gLSCovwohEfcjk0/GiZ6BBe8zHDynn6fJnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779222221; c=relaxed/simple;
	bh=OFzCaVVzTmLw929dhIW2yHjin3/KxOuFB9l+ZSxxZM8=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:To:Cc; b=OEO6tlVyPQt56giBnuirbtW731UvHP25j30BvPExMLCgV3CXQPyag4U62K1X8O8LWxLehUCJjy4VQyXMejkMzS1fAmIH0NEAw3/rUi3VCUx3SPiBO+gYdny0JaMLBxni24Ca9KEmG0tGWygCt1dnYbDHpT5yfILz8TGexu62CcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=berkoc.com; spf=pass smtp.mailfrom=berkoc.com; dkim=pass (2048-bit key) header.d=berkoc.com header.i=@berkoc.com header.b=VZmFfgCe; dkim=pass (2048-bit key) header.d=berkoc.com header.i=@berkoc.com header.b=Bbm8HnIA; arc=none smtp.client-ip=93.95.224.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=berkoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=berkoc.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=berkoc.com;
	s=1984; h=Cc:To:Subject:Date:From:References:In-Reply-To:Message-ID:Sender:
	Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=DgZVpf0/mLQMLhxPoO/PM6ZgBWGJ3fgV45Hs7h77mu0=; b=VZmFfgCeS6fpiu9cXWU3mT0v32
	Arum1BSD3AJ+OSvJ+puA1RpSIh5vezr2fTSZnrlCgd80OQrE8OKUjLYPxClSOIsKJlwlKyGCsK4kD
	akSMJbVAhhcsj+96Q13LHBWrIDgu5HwQMZUqDrM/CpxvTz1WvXR+2l7DDwCo05Z9irIFHXguL8WEN
	EStaarfkEzjuMbH91r4Sq3g3iKy+V1ITOfXDk0HvWjIIWHgH2OavQoOSdr77rJmJSiYoNEEAbP5RS
	ARrG5uzWxgfYErGHMcXfFLgFYbkcWgSa/iQyjHDpcS/pzYRWpH/twOxYmYTjmiKNlYuVUAAQb7Fj8
	wrnrBL7w==;
Received: from localhost
	by mail-03.1984.is with utf8esmtp (Exim 4.96)
	(envelope-from <me@berkoc.com>)
	id 1wPQyP-007hMj-0o;
	Tue, 19 May 2026 20:23:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=berkoc.com;
 i=@berkoc.com; q=dns/txt; s=me; t=1779222197; h=message-id : date :
 subject : cc : to : from : sender : reply-to;
 bh=DgZVpf0/mLQMLhxPoO/PM6ZgBWGJ3fgV45Hs7h77mu0=;
 b=Bbm8HnIApgDONfegBCe/GRcoLpjiA9sJEg2SF5oj+WA1Z0rwN9Xu0pwYsgiYfdF9euNuj
 hrZkvl0eMdLhwmx8E2fzVNQBegVS2JYsiMYy1+ZouJsFFqzGVseHvbXo/CWrLKSkQjVfKUv
 eHH3z33fDBgyW2w9YzHLVjLLNyngPr3L5ADbqyMmoCDNCAEuS5bnpnhfpLqvNzpoH2uVAYB
 DQGpPZZLcVyJnmvUf/3kvhRLagxhJajHLdbrYv+dw3IlUqvN+cxTk6XSsm1f8oERLjVdZoB
 qcyCskbNiYZQ84OWUAuBt78YrLwgUIBXWr2YTewOqikaxGkmKdaiTxelLOTA==
Message-ID: <cover.1779221339.git.me@berkoc.com>
In-Reply-To: <20260517-drm-hyperv-cover-v2@berkoc.com>
References: <20260517-drm-hyperv-cover@berkoc.com>
	<20260517-drm-hyperv-cover-v2@berkoc.com>
From: Berkant Koc <me@berkoc.com>
Date: Tue, 19 May 2026 22:08:59 +0200
Subject: [PATCH v3 0/2] drm/hyperv: harden host message parsing
To: Saurabh Sengar <ssengar@linux.microsoft.com>,
    Dexuan Cui <decui@microsoft.com>,
    Long Li <longli@microsoft.com>
Cc: linux-hyperv@vger.kernel.org,
    dri-devel@lists.freedesktop.org,
    linux-kernel@vger.kernel.org,
    K. Y. Srinivasan <kys@microsoft.com>,
    Haiyang Zhang <haiyangz@microsoft.com>,
    Wei Liu <wei.liu@kernel.org>,
    Michael Kelley <mhklinux@outlook.com>,
    Thomas Zimmermann <tzimmermann@suse.de>,
    Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
    Maxime Ripard <mripard@kernel.org>,
    Deepak Rawat <drawat.floss@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-11038-lists,linux-hyperv=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	FROM_NEQ_ENVFROM(0.00)[me@berkoc.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c15:e001:75::/64:c];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[berkoc.com:mid,berkoc.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: C3E81584B64
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Two independent issues in the synthetic video driver that both stem
from trusting unvalidated host data.

1/2 bounds resolution_count from SYNTHVID_RESOLUTION_RESPONSE against
the supported_resolution[] array, and populates WIN8 defaults for
hv->screen_*_max / hv->preferred_* in both the WIN10-probe-failure
path and the pre-WIN10 path, so a failed or pre-WIN10 probe yields
a usable display instead of having drm_internal_framebuffer_create()
reject every userspace framebuffer with -EINVAL.

2/2 forwards bytes_recvd from vmbus_recvpacket() into the sub-handler,
rejects packets that do not cover the synthvid header, and additionally
requires the type-specific payload size before memcpy/complete or
before reading the feature-change byte. Rejected packets are logged
via drm_err_ratelimited() instead of being silently dropped, matching
the CoCo-hardened pattern in hv_kvp_onchannelcallback().

Changes since v2 (per review by Michael Kelley):

  1/2: dropped the reinit_completion() change. Kelley pointed out that
       the negotiate-version and update-vram-location timeouts cause
       hyperv_vmbus_probe() to fail and free the device, so the stale
       completion can only outlive its request in hyperv_vmbus_resume()
       after a get_supported_resolution() timeout. That is a narrower
       fix and belongs in a separate patch against the resume path.
       Subject and commit message rewritten to reflect that this patch
       is now bounds-check + WIN8 fallback only. Pre-WIN10 branch now
       also populates hv->preferred_* (Kelley spotted the gap).
       Followed the post-probe-test refactor Kelley suggested: the else
       branch is gone, a single screen_width_max == 0 check covers
       both the pre-WIN10 case and a failed WIN10 probe.

  2/2: dropped the redundant upper bound on bytes_recvd. Added a
       per-type switch for the three completion-driving message types
       (SYNTHVID_VERSION_RESPONSE, SYNTHVID_RESOLUTION_RESPONSE,
       SYNTHVID_VRAM_LOCATION_ACK) so the wait-completion path
       validates payload size before memcpy/complete. Every reject
       path now emits drm_err_ratelimited() rather than returning
       silently. Commit message rewritten to lead with the residue
       read, with "wasteful copy" reframed as the secondary observation.

Changes since v1:
  1/2: bound resolution_count check folded into the existing zero
       check; populate WIN8 defaults when hyperv_get_supported_resolution()
       fails.
  2/2: forward bytes_recvd into hyperv_receive_sub(); enforce the
       pipe + synthvid header minimum; check synthvid_feature_change
       payload size before reading is_dirt_needed.

Both patches carry an Assisted-by: Claude:claude-opus-4-7 berkoc-pipeline
trailer per the kernel coding-assistants policy. Code, analysis and
review responses are mine; the model is used as a structured reviewer
under human verification.

base-commit: 4bf5d3da79c48e1df4bab82c9680c53adeff7820

Berkant Koc (2):
  drm/hyperv: validate resolution_count and fix WIN8 fallback
  drm/hyperv: validate VMBus packet size in receive callback

 drivers/gpu/drm/hyperv/hyperv_drm_proto.c | 58 ++++++++++++++++++++---
 1 file changed, 52 insertions(+), 6 deletions(-)

--
2.47.3

