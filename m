Return-Path: <linux-hyperv+bounces-9315-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wCHyAzg8sWkLswIAu9opvQ
	(envelope-from <linux-hyperv+bounces-9315-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Mar 2026 10:56:08 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1593A2616CB
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Mar 2026 10:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C58383076C15
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Mar 2026 09:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB433DA7C7;
	Wed, 11 Mar 2026 09:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JfVWEI4z"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097B73C9ED6
	for <linux-hyperv@vger.kernel.org>; Wed, 11 Mar 2026 09:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773221546; cv=none; b=kefWfG04ZEWLrFt355ty9msnULu6pVq0OFSgTQg/x4g/XgyHrldo/FLOHub6mEjHtSxSHKMUeCfIsZBq7iUiwfNbFTIei0JpPse34r8eYtsrSKZvhKjQIS6uDjGtKQM3Ib3xfKv8fXkFbvCO8raiEpUCW1hNJS4LzY1w/w/Ft/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773221546; c=relaxed/simple;
	bh=JGYhPK256pxU9EiY8jbQSSjgozqR8V5kd9EUseD+GRo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lDPbIJX30/OfdLsE2BHzTX7jbYMiPXOpA5j6nZZN0URtgNrQnRggRxPparRQodJln6PKo0iETdOrUjfDMLAU6+mt52wlIj51GDRWbeyEWHKG6nftPOXTd1tMgwd1Ubeyd3mhnJ+hfZD/E/jaONTblzUxAJdIQu923r0pSmwOvoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JfVWEI4z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B03A6C2BC9E
	for <linux-hyperv@vger.kernel.org>; Wed, 11 Mar 2026 09:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773221545;
	bh=JGYhPK256pxU9EiY8jbQSSjgozqR8V5kd9EUseD+GRo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=JfVWEI4zDrh3iHX+1r4cle8Phcf0RBN0zERjJ8PQNA3EYWSATJ9h5lha/xBvVFGnI
	 lElqdFOyu5rUcg336ldY8JBHZo/CNZ6A5HFkXurPLCqwCA7763w9Gzh1MrCiovz1O6
	 4/dhditNlUPPz/o6nb1awN/pC+8W+SveVLbbW1M3XSJ0LknHbar0z1P9mnX5NF58yX
	 1Uj5dsDyxTrkO1DJZv/qpV8j6iPNzVVJVRqNM1MXMlgjgqpNnn65QlcqD5KydSFEzI
	 yLns3+tdmVfBsvgohk6ekX61JLdkJkatIbZorvb97Pbamw8/hcF79oQl43JkoSoDtA
	 x5H4ornHcPhQg==
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-64ad79dfb6eso13636807d50.0
        for <linux-hyperv@vger.kernel.org>; Wed, 11 Mar 2026 02:32:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW2Rbqv1/xQSx2FQjE6auIWicO2SKuRswmZbYf2UgyN3nj+PUw2iP0tLAhsJApSeqRQPzYd5xGmUsZa758=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYd1MK3A+5ZY1fYi2T20kZk0OVMneUmF1VrGkpx0PzWf+lh3uM
	S8+h4FhqLn/QTR4QMzUJ0ffXhvJ8lp7znc8lwaTcoOEKUUX1IEkKi+4hMKSkIHp8g2m4OJnNmY+
	SmM60UTnNfVs/BEbzrKxhdG8tmAtjuRI=
X-Received: by 2002:a05:690e:144d:b0:64c:e890:fbb9 with SMTP id
 956f58d0204a3-64d656f696dmr1649157d50.20.1773221544775; Wed, 11 Mar 2026
 02:32:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de> <20260310-b4-is_err_or_null-v1-41-bd63b656022d@avm.de>
In-Reply-To: <20260310-b4-is_err_or_null-v1-41-bd63b656022d@avm.de>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 11 Mar 2026 10:32:12 +0100
X-Gmail-Original-Message-ID: <CAD++jLnDv00ErgVdQ4EBpKH9KMWrPD8ODrQ6m846zyQ=wNzCzQ@mail.gmail.com>
X-Gm-Features: AaiRm52aI8z_G2E4qYaKWPEA43RhLektjwMDQXSLwHd-Xy_BYcin-6heFFY4jM4
Message-ID: <CAD++jLnDv00ErgVdQ4EBpKH9KMWrPD8ODrQ6m846zyQ=wNzCzQ@mail.gmail.com>
Subject: Re: [PATCH 41/61] pinctrl: Prefer IS_ERR_OR_NULL over manual NULL check
To: Philipp Hahn <phahn-oss@avm.de>
Cc: amd-gfx@lists.freedesktop.org, apparmor@lists.ubuntu.com, 
	bpf@vger.kernel.org, ceph-devel@vger.kernel.org, cocci@inria.fr, 
	dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org, 
	gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org, 
	intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-mips@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org, 
	linux-nfs@vger.kernel.org, linux-omap@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-pm@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-sound@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, ntfs3@lists.linux.dev, 
	samba-technical@lists.samba.org, sched-ext@lists.linux.dev, 
	target-devel@vger.kernel.org, tipc-discussion@lists.sourceforge.net, 
	v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 1593A2616CB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9315-lists,linux-hyperv=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linusw@kernel.org,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_GT_50(0.00)[54];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,mail.gmail.com:mid,avm.de:email]
X-Rspamd-Action: no action

On Tue, Mar 10, 2026 at 12:55=E2=80=AFPM Philipp Hahn <phahn-oss@avm.de> wr=
ote:

> Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
> check.
>
> Change generated with coccinelle.
>
> To: Linus Walleij <linusw@kernel.org>
> Cc: linux-gpio@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Philipp Hahn <phahn-oss@avm.de>

Patch applied to the pinctrl tree as obviously correct.

Yours,
Linus Walleij

