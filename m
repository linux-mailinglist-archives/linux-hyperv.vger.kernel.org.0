Return-Path: <linux-hyperv+bounces-11418-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mPZdDl/NHGomSwkAu9opvQ
	(envelope-from <linux-hyperv+bounces-11418-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 01 Jun 2026 02:07:59 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C8EB0618681
	for <lists+linux-hyperv@lfdr.de>; Mon, 01 Jun 2026 02:07:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 64A253003356
	for <lists+linux-hyperv@lfdr.de>; Mon,  1 Jun 2026 00:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7630E262A6;
	Mon,  1 Jun 2026 00:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Odmyxu5S"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54855EEBB;
	Mon,  1 Jun 2026 00:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780272476; cv=none; b=lHIZrWcN5LSDYFcmtwln/euyXT6Eoz7WY8IgxkDMQm8e9VDiofHEgky27sBKXdhMYeqpXy/5OrQCnvLfqK9O5Dm1lHI80I2+S2IB0TISY2eEj8urJYVNevdc+QMLN7dK6poMVtX91kSmQGNOrzQcmCmvr7zaNSCLwyzEaM2bwok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780272476; c=relaxed/simple;
	bh=YR2NbJMIIz9ABTXExh7IMYnpn76Xt/QGbURG3Atx7KI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HLuxJvY1hmxA5Z9Gk/3ZDlj8/rd4fy7NWJ2/Zu65jgXGZSVmKbJ+aPv5dykglFsCVsnpUUcyujLWEppbbJ/oVH7WDmLf/Qwx7MXBKfsKN5tPP++sdFuu57QDUBtQmDEV+wsHbaCZoUgyAP/QcBCLaFrFnFWsYFZHkLuhPcKyjkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Odmyxu5S; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8657C1F00893;
	Mon,  1 Jun 2026 00:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780272475;
	bh=zbE3AhoewCNMJevfzweFic4aS/GpdB9LV6AJyQVXvCQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Odmyxu5S/Ug7HWNIyy+uuH2Q6va157Q3X07wOddcuUX4UbXTAg59AbQDDLhXDyHzA
	 qLAndnCoLF2S7zRmhNRaOvCy6jUddvG3rVsNhp4PO/zS6RuQr+NJBvBcaBQ0JyQ0sy
	 ZK7uAZaO5VU+/YKW70PF8a1UiCI/Y2TyxePuMVsMZoL/3jYBbPC1cTF8vkpuLZ4pqb
	 c+l7JOaVaSXeer7Pna9+n3IBOxPK4lsQk795xJsOEMclb356eA3mbkuSTOsBwAy0Fu
	 5tgiZ6opwwsvldSaDk8rNs20AnZWYW6i9/zSQR8wjHiF0oZ/JvMzDRbJzZqmqqi8cE
	 JpvD/D9+COspw==
From: Danilo Krummrich <dakr@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	linux@armlinux.org.uk,
	nipun.gupta@amd.com,
	nikhil.agarwal@amd.com,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	andersson@kernel.org,
	mathieu.poirier@linaro.org,
	driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH v2 0/5] treewide: Convert buses to use generic driver_override
Date: Mon,  1 Jun 2026 02:07:47 +0200
Message-ID: <20260601000747.554103-1-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260505133935.3772495-1-dakr@kernel.org>
References: <20260505133935.3772495-1-dakr@kernel.org>
X-Patch-Reply: applied
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11418-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: C8EB0618681
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue,  5 May 2026 15:37:20 +0200, Danilo Krummrich wrote:
> [PATCH v2 0/5] treewide: Convert buses to use generic driver_override

Applied, thanks!

  Branch: driver-core-testing
  Tree:   git://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core.git

[1/5] amba: use generic driver_override infrastructure
      commit: 1947229f5f2a
[2/5] cdx: use generic driver_override infrastructure
      commit: d541aa1897f6
[3/5] Drivers: hv: vmbus: use generic driver_override infrastructure
      commit: 331d8900121a
[4/5] rpmsg: use generic driver_override infrastructure
      commit: 55ced13c4292
[5/5] driver core: remove driver_set_override()
      commit: 46def663dd34

The patches will appear in the next linux-next integration (typically within 24
hours on weekdays).

The patches are in the driver-core-testing branch and will be promoted to
driver-core-next after validation.

