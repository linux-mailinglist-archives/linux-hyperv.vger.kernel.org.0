Return-Path: <linux-hyperv+bounces-9742-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CFtwNrHrwmkdnQQAu9opvQ
	(envelope-from <linux-hyperv+bounces-9742-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Mar 2026 20:53:21 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 25CDC31BE2C
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Mar 2026 20:53:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 813A730308B2
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Mar 2026 19:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F27E37B017;
	Tue, 24 Mar 2026 19:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BI/PyKSY"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F8830FC0F;
	Tue, 24 Mar 2026 19:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774381491; cv=none; b=mtXEhXnWVSMZX2PGYgfHIdmbFOgRvn86vPDkldoUYeV1fwLZ/VvcPxqyimSYSdC9j/Uev8GqoO+huslebf6SWhYYXxSn7P8nZEizcYG/xApApkogRfrJZdgYZRj2h5s1IuhqgqmC+cSEbppaXgubDOEagcCXAhEsyREM5yls2nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774381491; c=relaxed/simple;
	bh=WRF/0A79XI/IfrPujL8sWiRG4jtPsIHG8/HKlYhxfwg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=NGqVbPo8WKAGLL+OqD+s4OvjyUPaAE/OAUYZQ7T+tRf1S/uSvIuIjKCNBcFQcVSz6V08EFN6FakTUSo4VHhdiUPQXFVRFcK3zsuDRumc5D7eU1JpCkGI4G08/E73XLuWdIMeoLP1JrHw0htY8AsFlg7v5fCje9ISWg2Z9T730Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BI/PyKSY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF553C19424;
	Tue, 24 Mar 2026 19:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774381490;
	bh=WRF/0A79XI/IfrPujL8sWiRG4jtPsIHG8/HKlYhxfwg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=BI/PyKSYvjLJXWbEpQrc+czH+55hhTQfVKT55Uu1wKsITHQaRklHZhshTVjzHQFZN
	 XI99w4CrCK+yRfm2877TM5yV4pPdvKaG1DWbUoq9X2UMljaiVAeNppp3zNtFe6VQcR
	 Nbxio4BzKuKvbSdbHpiqyp9b0V4Wi4iBFmRLBu0AraFrnoul9PN3a4ntDRFnw+1WBV
	 6VOLh/84HoNWnxFvJA4p13awciT/KZz8A8WdIkArI2aCUbV0ZkSk5h4r/JYUTPRIIT
	 T8Jt8zQSnSc69wMDv4JXXRT2onYDSQlxz5UqGBDTvOp1c1OxGFbD7+EZxoeS8MPSTJ
	 8n38/skizDzlQ==
From: Mark Brown <broonie@kernel.org>
To: Russell King <linux@armlinux.org.uk>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Ioana Ciornei <ioana.ciornei@nxp.com>, Nipun Gupta <nipun.gupta@amd.com>, 
 Nikhil Agarwal <nikhil.agarwal@amd.com>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, Armin Wolf <W_Armin@gmx.de>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Vineeth Vijayan <vneethv@linux.ibm.com>, 
 Peter Oberparleiter <oberpar@linux.ibm.com>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, 
 Harald Freudenberger <freude@linux.ibm.com>, 
 Holger Dengler <dengler@linux.ibm.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Alex Williamson <alex@shazbot.org>, Juergen Gross <jgross@suse.com>, 
 Stefano Stabellini <sstabellini@kernel.org>, 
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Danilo Krummrich <dakr@kernel.org>
Cc: linux-kernel@vger.kernel.org, driver-core@lists.linux.dev, 
 linuxppc-dev@lists.ozlabs.org, linux-hyperv@vger.kernel.org, 
 linux-pci@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
 linux-s390@vger.kernel.org, linux-spi@vger.kernel.org, 
 virtualization@lists.linux.dev, kvm@vger.kernel.org, 
 xen-devel@lists.xenproject.org, linux-arm-kernel@lists.infradead.org
In-Reply-To: <20260324005919.2408620-1-dakr@kernel.org>
References: <20260324005919.2408620-1-dakr@kernel.org>
Subject: Re: (subset) [PATCH 00/12] treewide: Convert buses to use generic
 driver_override
Message-Id: <177436441990.98682.12977271865531185229.b4-ty@b4>
Date: Tue, 24 Mar 2026 15:00:19 +0000
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev-6cc06
X-Developer-Signature: v=1; a=openpgp-sha256; l=1523; i=broonie@kernel.org;
 h=from:subject:message-id; bh=WRF/0A79XI/IfrPujL8sWiRG4jtPsIHG8/HKlYhxfwg=;
 b=kA0DAAoBJNaLcl1Uh9AByyZiAGnC6amgudhaUXvPlk+pDm3GoyUp8H0DzJj7P23jodGH3vgaM
 YkBMwQAAQoAHRYhBK3maKpnVxi1n+Kf6iTWi3JdVIfQBQJpwumpAAoJECTWi3JdVIfQ7W4H/0HK
 bnLD6QxQOBC+fzyIxZ6G6kEKZPO4GVW3Pfn4yfAzX5qrdKQRkDgps7IYWut/u33hS3f+Z04EmOJ
 lYrLIJIM422nR6nge6hF8EhqNBiTq/w9q7cGC48hH540F15d0sLd2//XCIGupIA1RXpBqVdzq5x
 OT6qjdHSfs8FyZ+oeQmp08Rcg1XfVc+MneH1PzidJufZ+tJUtayZw29OlGfNk6vGZ389vkRi+Ec
 XFn5qSzIYh78B0Z0zXzPv2/IjG8frEcheWdi3dJbD2bUS4h2S1US62r3HG8U3Au0lRz8ggXRMML
 03vuVW3IP0egShhpeZHJhBzFqhYb6LFlY+k9hXc=
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[armlinux.org.uk,linuxfoundation.org,kernel.org,nxp.com,amd.com,microsoft.com,google.com,gmx.de,linaro.org,linux.ibm.com,redhat.com,linux.alibaba.com,shazbot.org,suse.com,epam.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[48];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9742-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 25CDC31BE2C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 24 Mar 2026 01:59:04 +0100, Danilo Krummrich wrote:
> treewide: Convert buses to use generic driver_override
> 
> This is the follow-up of the driver_override generalization in [1], converting
> the remaining 11 busses and removing the now-unused driver_set_override()
> helper.
> 
> All of them (except AP, which has a different race condition) are prone to the
> potential UAF described in [2], caused by accessing the driver_override field
> from their corresponding match() callback.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.0

Thanks!

[11/12] spi: use generic driver_override infrastructure
        https://git.kernel.org/broonie/spi/c/cc34d77dd487

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark


