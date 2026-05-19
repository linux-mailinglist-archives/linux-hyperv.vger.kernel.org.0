Return-Path: <linux-hyperv+bounces-11041-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uP8pI2/IDGrAlwUAu9opvQ
	(envelope-from <linux-hyperv+bounces-11041-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 19 May 2026 22:30:39 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 348D7584B8F
	for <lists+linux-hyperv@lfdr.de>; Tue, 19 May 2026 22:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BAE803013891
	for <lists+linux-hyperv@lfdr.de>; Tue, 19 May 2026 20:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48F83B6BF5;
	Tue, 19 May 2026 20:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=berkoc.com header.i=@berkoc.com header.b="OT0e1kZE";
	dkim=pass (2048-bit key) header.d=berkoc.com header.i=@berkoc.com header.b="l8sr0Jtv"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-01.1984.is (mail-01.1984.is [185.112.145.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9AA3B3BEB;
	Tue, 19 May 2026 20:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.112.145.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779222290; cv=none; b=YN+x+ziMDrvAR6YKxU91ZdgCY+2gVWD+4E9b9s3WEdZcJYgNPCnh4Dc5djih1AV2RcjhIonI5yUQBESYL2mvi02DyKMUscAgsLJ8TZqMljbj4Tws99Ngj/eaXltrwaUU1jAy/AmH5jmZ03AII7UPmAOSNcW8XtmO72PkgPEaDo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779222290; c=relaxed/simple;
	bh=Y3frdyRKW/oF1IZwlAZSK80c2HfcR5nkOP1fkxlziMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KslVI/oYC3rxaV8Gr9NJmgSL5gEpePARWUQcZikCm1bACvcqgmLhtV3n7CcHgk5Y+GCKcvM6NJ5UNZjim3zBe3GcdQD92DZlepHdIUIXLsf1TYyoM7W3XeieRZb8g4mx0EietkTGYoO3lv40KUlqf5jfXjPf08Xg5pUFM9f/9CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=berkoc.com; spf=pass smtp.mailfrom=berkoc.com; dkim=pass (2048-bit key) header.d=berkoc.com header.i=@berkoc.com header.b=OT0e1kZE; dkim=pass (2048-bit key) header.d=berkoc.com header.i=@berkoc.com header.b=l8sr0Jtv; arc=none smtp.client-ip=185.112.145.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=berkoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=berkoc.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=berkoc.com;
	s=1984; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Y3frdyRKW/oF1IZwlAZSK80c2HfcR5nkOP1fkxlziMs=; b=OT0e1kZEf/G0gsee1vE6CaU3OW
	QQUEMFWLNqFY3n/9emT1ZTy30Gj3nyTS/yuKEtjLlEvH+cMNRgbApGckp9hjPCLszf9M8lruTRNeW
	0DO8ECcpQHs/vtpwZY9hUFIOBX1heowYhoTZLA/DE7RbKQ8ieG1qo6lFuKbVBGSA6It8svCiX8KjL
	8i7OBZlmDtAfwP2nFVWZpN8dSOsGHBVJwav/4Za8zBHtfZYDB5EVTkMh/u7/4XcOWqnrolXyIdsWa
	1KsmUUdL0kQk16c1mpikE5hjKNzuibWYrpfXYJWGAzXv4kBKx+0Yln7wQw8XDtVLCAXVgXaSa96L+
	lLtOBdUg==;
Received: from localhost
	by mail-01.1984.is with utf8esmtp (Exim 4.96)
	(envelope-from <me@berkoc.com>)
	id 1wPQzW-006CSM-0Q;
	Tue, 19 May 2026 20:24:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=berkoc.com;
 i=@berkoc.com; q=dns/txt; s=me; t=1779222267; h=message-id : date :
 subject : cc : to : from : sender : reply-to;
 bh=Y3frdyRKW/oF1IZwlAZSK80c2HfcR5nkOP1fkxlziMs=;
 b=l8sr0Jtvj0r0oyJSZ0CsvDHMGn81oWRuEI3/lwFVcnJZ3R4lJ2zxURTKNAcWq6vat1KTt
 PpO4KnLIi0h+b3YRuSdfHHHPOGX6/ZwcdUZiQS5JYJQzOXA7wMuIr2q9whhEtui0l4J+ufw
 48Y87iDEhKe/g5kzUiarjqctyCimCrHSahoRwKnynOZqRsdA0nGuD84uYsecv1Doo48oSIm
 Tw/0+D1pbTdgWyRFMtUo7uxdyuI6BI9m1A/grkwLHtO3j8hPcSjhd23+EXMi89NXVr2xM3U
 HNkmzNPA9XtesQ1oiUsPtebTtIHQUQxdE1Qi1tAfmTUQxNiExzaeUL1zE0EA==
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
Subject: Re: [PATCH v2 1/2] drm/hyperv: validate resolution_count and harden VSP request paths
Date: Tue, 19 May 2026 22:20:28 +0200
Message-ID: <v3-reply-03-reply1.1779222028@berkoc.com>
In-Reply-To: <SN6PR02MB4157D595B990A321BFA85B40D4002@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260517-drm-hyperv-cover@berkoc.com>
    <20260517-drm-hyperv-cover-v2@berkoc.com>
    <20260517-drm-hyperv-patch1-v2@berkoc.com>
    <SN6PR02MB4157D595B990A321BFA85B40D4002@SN6PR02MB4157.namprd02.prod.outlook.com>
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
	TAGGED_FROM(0.00)[bounces-11041-lists,linux-hyperv=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	GREYLIST(0.00)[pass,body];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[outlook.com];
	R_DKIM_REJECT(0.00)[berkoc.com:s=1984];
	FREEMAIL_CC(0.00)[linux.microsoft.com,microsoft.com,kernel.org,suse.de,linux.intel.com,gmail.com,vger.kernel.org,lists.freedesktop.org];
	DMARC_POLICY_ALLOW(0.00)[berkoc.com,quarantine];
	DKIM_TRACE(0.00)[berkoc.com:-,berkoc.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[me@berkoc.com,linux-hyperv@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c04:e001:36c::/64:c];
	DMARC_POLICY_ALLOW_WITH_FAILURES(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[berkoc.com:email,berkoc.com:mid,berkoc.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 348D7584B8F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello Michael,

Thanks for the CoCo context, that lines up with what is in
vmbus_devs[] for the framebuffer device. The piecemeal approach is
what I am aiming for here.

v3 is on the list and addresses your three concrete points:

> This change should probably be a separate patch, as it's not really
> related to the bounds checking issue.
> [...]
> All that notwithstanding, I don't think your fix is needed in its
> current form.

Dropped from v3. You are right that the negotiate-version and
update-vram-location timeouts let hyperv_vmbus_probe() bail out and
free the device, so the stale-completion path is only reachable from
hyperv_vmbus_resume() after a get_supported_resolution() timeout.
That is a narrower fix and belongs in a separate patch against the
resume path, which I will send afterwards.

> Is there a separate problem here in that preferred_width and
> preferred_height are not set in the pre-WIN10 case?

Yes, separate problem, and I missed it in v2. The pre-WIN10 branch
in hyperv_connect_vsp() sets only screen_*_max and leaves preferred_*
at zero, which is inconsistent with the WIN10-failure path.

> Also, having to duplicate the fallback code is distasteful. Instead
> of having an "else" clause, maybe have a follow-up test for
> screen_width_max [...] being zero as an indicator [...]

Adopted in v3. The else branch is gone; the WIN10 path runs the probe
and the post-probe block applies the WIN8 defaults whenever
screen_width_max is still zero. One source of truth, both paths
converge on it.

> In my view, your commit message is a bit too detailed.

Rewritten in v3. The bounds check and the WIN8 fallback are now one
short paragraph each, focused on the "why".

Series: <cover.1779221339.git.me@berkoc.com>

The v3 patches carry an `Assisted-by: Claude:claude-opus-4-7
berkoc-pipeline` trailer per the kernel coding-assistants policy.
Code, analysis and review responses are mine; the model is used as
a structured reviewer under human verification.

Thanks,
Berkant

