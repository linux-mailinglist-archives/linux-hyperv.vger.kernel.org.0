Return-Path: <linux-hyperv+bounces-9271-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sLwMHZIgsGmCgAIAu9opvQ
	(envelope-from <linux-hyperv+bounces-9271-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 Mar 2026 14:45:54 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D82B250B92
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 Mar 2026 14:45:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3B97B321D8EF
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 Mar 2026 13:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 575563E1CEB;
	Tue, 10 Mar 2026 12:44:21 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B17014AD0D
	for <linux-hyperv@vger.kernel.org>; Tue, 10 Mar 2026 12:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773146661; cv=none; b=KUQhGRLMftfApiEYsnwd/04T36hbwwrHjZFbu1w4hKjO15ZxcFjfHpvwq7u4G3El0hl/538a3E4E/n/7mnseNpb8hFqFSBcI6hs72ZFGqLLxg62dlXjmpt6tcqYMGIHw9LKp9YGbwvXxaXioudS703fINn6OTsIt3N+0atbWde0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773146661; c=relaxed/simple;
	bh=9nwSoyBFb/J+scDlmZ8YZ+1mFs6NH+0TsiNWJNlzMqA=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eK4sUaKKqArVkJpyus4M7NvFdCUorMJi7HTr9HWcogyZWC/FDLWS4r7jJHdoIXdk6LalfHFBtT+4JzQGz3tmkcep3e64YXpj0F2POiJC25glqrlyn2Umve+PQ8LupnrmqXMvi4To5oidEcZgqAqEVplYPY84OL1lYDdI7pM+u2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vzwQv-0006Oq-0m; Tue, 10 Mar 2026 13:43:33 +0100
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vzwQr-004hMj-0z;
	Tue, 10 Mar 2026 13:43:30 +0100
Received: from pza by lupine with local (Exim 4.98.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vzwQs-0000000081v-2556;
	Tue, 10 Mar 2026 13:43:30 +0100
Message-ID: <ddaacda48df23fb2c009a8727518300ed2b82cb2.camel@pengutronix.de>
Subject: Re: [PATCH 57/61] reset: Prefer IS_ERR_OR_NULL over manual NULL
 check
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Philipp Hahn <phahn-oss@avm.de>, amd-gfx@lists.freedesktop.org, 
	apparmor@lists.ubuntu.com, bpf@vger.kernel.org, ceph-devel@vger.kernel.org,
 	cocci@inria.fr, dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org,
 	gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org, 
	intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev,
 kvm@vger.kernel.org, 	linux-arm-kernel@lists.infradead.org,
 linux-block@vger.kernel.org, 	linux-bluetooth@vger.kernel.org,
 linux-btrfs@vger.kernel.org, 	linux-cifs@vger.kernel.org,
 linux-clk@vger.kernel.org, 	linux-erofs@lists.ozlabs.org,
 linux-ext4@vger.kernel.org, 	linux-fsdevel@vger.kernel.org,
 linux-gpio@vger.kernel.org, 	linux-hyperv@vger.kernel.org,
 linux-input@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 linux-leds@vger.kernel.org, 	linux-media@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org, 
	linux-nfs@vger.kernel.org, linux-omap@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-pm@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-sound@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
 ntfs3@lists.linux.dev, 	samba-technical@lists.samba.org,
 sched-ext@lists.linux.dev, 	target-devel@vger.kernel.org,
 tipc-discussion@lists.sourceforge.net, 	v9fs@lists.linux.dev
Date: Tue, 10 Mar 2026 13:43:30 +0100
In-Reply-To: <20260310-b4-is_err_or_null-v1-57-bd63b656022d@avm.de>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
	 <20260310-b4-is_err_or_null-v1-57-bd63b656022d@avm.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-hyperv@vger.kernel.org
X-Rspamd-Queue-Id: 2D82B250B92
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9271-lists,linux-hyperv=lfdr.de];
	DMARC_NA(0.00)[pengutronix.de];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[p.zabel@pengutronix.de,linux-hyperv@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.733];
	RCPT_COUNT_GT_50(0.00)[54];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pengutronix.de:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hi Philipp,

On Di, 2026-03-10 at 12:49 +0100, Philipp Hahn wrote:
> Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
> check.
>
> Semantich change: Previously the code only printed the warning on error,
> but not when the pointer was NULL. Now the warning is printed in both
> cases!

No, rstc =3D=3D NULL is valid (for optional reset controls) and must not
throw a warning.


regards
Philipp

