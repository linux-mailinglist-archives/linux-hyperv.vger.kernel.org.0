Return-Path: <linux-hyperv+bounces-11037-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CCZyCsnGDGp2lwUAu9opvQ
	(envelope-from <linux-hyperv+bounces-11037-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 19 May 2026 22:23:37 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D9995849DA
	for <lists+linux-hyperv@lfdr.de>; Tue, 19 May 2026 22:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 16F4B30265B7
	for <lists+linux-hyperv@lfdr.de>; Tue, 19 May 2026 20:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D363BB680;
	Tue, 19 May 2026 20:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=berkoc.com header.i=@berkoc.com header.b="lYgXpZ5H";
	dkim=pass (2048-bit key) header.d=berkoc.com header.i=@berkoc.com header.b="gQvgOzX+"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-01.1984.is (mail-01.1984.is [185.112.145.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CBF2E7F2C;
	Tue, 19 May 2026 20:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.112.145.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779222201; cv=none; b=jTC80dVEv02Pk/AHjsCb0MolhbXJ92A0bU1OMAbt0X2/x/yOEDdakMWDaLlJIbyz4E4vmEOZu4irxGYH9KJ523+JpH8bDR9hFZIdezpjpVlZeVxRwZ6vTHE/RxxJv2phf5BRLTjfgnoHKMoeZ9h06qwcIZZiSJZlF1tnZZJqXV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779222201; c=relaxed/simple;
	bh=EWApeQD2d5WNNo6QVQUQxlCmp4G9N2Ai6sDq9pwCgJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z0jlnSDDg+56aRLkNvz0nkXuqoIXOfKnCReu/90THfVDTzgw5Phvrq/o3WUcjOUzioQ3Ytr2ptDeW2GUQxsjMejH0Ip86jOhQ0ro2L4X5CBjtbfmlDqq6ixOpRO5sliIDPAZzcix38W2J35Nq5GVCiVTTHrOJcv67gczVVRGEgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=berkoc.com; spf=pass smtp.mailfrom=berkoc.com; dkim=pass (2048-bit key) header.d=berkoc.com header.i=@berkoc.com header.b=lYgXpZ5H; dkim=pass (2048-bit key) header.d=berkoc.com header.i=@berkoc.com header.b=gQvgOzX+; arc=none smtp.client-ip=185.112.145.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=berkoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=berkoc.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=berkoc.com;
	s=1984; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=+/HYbekN88tW98e+2mn2hG/TZbXhaP5H/gJm+hKZZ/I=; b=lYgXpZ5HZe/POAscpvaOtuXLP9
	73NOY0qPgnM6XDL/pBW3TUC8Cun6s0wsnZgA3CQI9d09wyqfRwY5C4AnMa8PcPb8YPVq1JUUfieoQ
	V24hClZoQ/Kw6ToWNXewmDenV/kxJHfAyFVDSZrXdncFrHFTeGIPiztF0xcH8q8Iu1I5ZY7E/3X8m
	cwFmN9B5vlrk4kW+va6KogZn4bXVxf4Aq8/xoV76THZ1VBd0aYTnWxmeAvHscdzEhm7FdgNW5sLnW
	x7zKjIV8yGTNvk/7T3QgPmSvs4zqVzVv+6bBwvSSDDY+n5VTF907WWLVMHHIItVFFUOL3i0eQo1Nq
	QrJMIjag==;
Received: from localhost
	by mail-01.1984.is with utf8esmtp (Exim 4.96)
	(envelope-from <me@berkoc.com>)
	id 1wPQy4-006C4e-0h;
	Tue, 19 May 2026 20:23:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=berkoc.com;
 i=@berkoc.com; q=dns/txt; s=me; t=1779222178; h=message-id : date :
 subject : cc : to : from : sender : reply-to;
 bh=+/HYbekN88tW98e+2mn2hG/TZbXhaP5H/gJm+hKZZ/I=;
 b=gQvgOzX+D8utY5FtNZXuuizs9Sb+2nCge5SSXiiQKsJm332kylpqXMApyoNAilwqz3iTU
 uYBdoiCjfOOVioebArKTzVTaFuZY+RSNZ9+fivSfBDvt+C4CGqeUDFyLj6km/dZGVm2XcWs
 6WdHrYVSgjLJDNrcLROwyvcEZwiyX6CEieYNqJ/ZC2VvTv29ZesH1zoFSCy4uzfZkr+Y37U
 7wTTs8Z6ItHHpHqUsQu80Lm1y6yBByhgbbT+0DKZnQJZM71MLpVKYa7UDsT6J6yyqmUk8qD
 NdlGLLkEL3oP8DrJxhJ3oPmnnvSOrcNxZgVU5CMD+/M/JA3h5bSzEtsKDy9A==
From: Berkant Koc <me@berkoc.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: Saurabh Sengar <ssengar@linux.microsoft.com>,
    Dexuan Cui <decui@microsoft.com>,
    Long Li <longli@microsoft.com>,
    K. Y. Srinivasan <kys@microsoft.com>,
    Haiyang Zhang <haiyangz@microsoft.com>,
    Wei Liu <wei.liu@kernel.org>,
    Thomas Zimmermann <tzimmermann@suse.de>,
    Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
    Maxime Ripard <mripard@kernel.org>,
    Deepak Rawat <drawat.floss@gmail.com>,
    linux-hyperv@vger.kernel.org,
    dri-devel@lists.freedesktop.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] drm/hyperv: validate VMBus packet size in receive callback
Date: Tue, 19 May 2026 22:20:28 +0200
Message-ID: <v3-reply-04-reply2.1779222028@berkoc.com>
In-Reply-To: <SN6PR02MB415761EE7992EAFA14F2201BD4002@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260517-drm-hyperv-cover@berkoc.com>
    <20260517-drm-hyperv-cover-v2@berkoc.com>
    <20260517-drm-hyperv-patch2-v2@berkoc.com>
    <SN6PR02MB415761EE7992EAFA14F2201BD4002@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Spam-Score: -0.2 (/)
X-Authenticated-User: me@berkoc.com
X-Sender-Address: me@berkoc.com
X-Spamd-Result: default: False [4.14 / 15.00];
	SEM_URIBL_FRESH15(3.00)[berkoc.com:email,berkoc.com:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_ALLOW(-0.20)[berkoc.com:s=me];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_MIXED(0.00)[];
	TAGGED_FROM(0.00)[bounces-11037-lists,linux-hyperv=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	GREYLIST(0.00)[pass,meta];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[outlook.com];
	R_DKIM_REJECT(0.00)[berkoc.com:s=1984];
	FREEMAIL_CC(0.00)[linux.microsoft.com,microsoft.com,kernel.org,suse.de,linux.intel.com,gmail.com,vger.kernel.org,lists.freedesktop.org];
	DMARC_POLICY_ALLOW(0.00)[berkoc.com,quarantine];
	DKIM_TRACE(0.00)[berkoc.com:-,berkoc.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[me@berkoc.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c0a:e001:db::/64:c];
	DMARC_POLICY_ALLOW_WITH_FAILURES(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[berkoc.com:email,berkoc.com:mid,berkoc.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 7D9995849DA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello Michael,

Thanks for the thorough review. v3 is on the list and addresses each
point:

> Does copying the full 16 KiB break anything? Or are you flagging as just
> wasteful activity?

It is the residue read that is the actual hazard, not the copy cost:
the consumer that wakes on complete() then reads up to 16 KiB of bytes
the host did not write in this packet as if it were the response
payload. The v3 commit message now leads with that and treats
"wasteful" as a secondary observation.

> Version related comments should go below the "---" following the
> Signed-off line.

Moved into the cover letter changelog in v3 so it stays out of git
log.

> The check against VMBUS_MAX_PACKET_SIZE shouldn't be needed.

Dropped. The v3 check is bytes_recvd < hdr_size only.

> In similar cases in other drivers that have been hardened for CoCo VMs,
> the code outputs a rate limited error message. [...] See
> hv_kvp_onchannelcallback() for example.

Done in v3 via drm_err_ratelimited() on every short-packet path
(synthvid header underflow, type-specific payload underflow, feature
change underflow). The driver already uses drm_err_ratelimited() in
hyperv_sendpacket() for the corresponding send path.

> Additional logic is needed here. Each of the three message types
> in the "if" statement has data beyond just the header. Before doing
> the memcpy() and complete(), the code should validate that the msg
> is big enough to contain that expected data.

Fixed in v3. For the three completion types I now compute the required
payload size with a switch on msg->vid_hdr.type and reject the packet
before memcpy/complete:

  SYNTHVID_VERSION_RESPONSE    -> sizeof(struct synthvid_version_resp)
  SYNTHVID_RESOLUTION_RESPONSE -> sizeof(struct synthvid_supported_resolution_resp)
  SYNTHVID_VRAM_LOCATION_ACK   -> sizeof(struct synthvid_vram_location_ack)

The memcpy then uses bytes_recvd, so wait_for_completion_timeout()
consumers never see truncated data and never read past what the host
wrote.

Series: <cover.1779221339.git.me@berkoc.com>

The v3 patches carry an `Assisted-by: Claude:claude-opus-4-7
berkoc-pipeline` trailer per the kernel coding-assistants policy.
Code, analysis and review responses are mine; the model is used as
a structured reviewer under human verification.

Thanks,
Berkant

