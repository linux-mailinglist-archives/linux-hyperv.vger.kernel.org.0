Return-Path: <linux-hyperv+bounces-6083-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 176FDAF75B5
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Jul 2025 15:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5990A1C85E99
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Jul 2025 13:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA66B137C52;
	Thu,  3 Jul 2025 13:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ODESv0xv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9Ph7+GkK"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D784F29C33E;
	Thu,  3 Jul 2025 13:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751549441; cv=none; b=K+qnu43ElP/QZFdoOlLdp5nzcL54lXvIw8iUSzGrwHviK/dB0ab40gITWidVEM75u8tznWkriqsTvxEeBPXPpm7h+ifKfnxKuVCI2itCzjEZWXth565kIczICKSv02iSos8+IbWkafoi9W7sXnd+hVnI7PDD9uqliRPnLSp3s2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751549441; c=relaxed/simple;
	bh=SSL6pMiq0gd7XD60qY6vVVqLLdJ+A7wrnDsGL6j47Ag=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iWTkN1mqVYF7M+Lh3vAVFuT2srH/nzT3aFe3wIfDYA4eeYkUIBaHpek2gg7KMsZE/ydReWE+QqKOWp2JO28Uim4jgTzw/uP2UIwJhh0eCLyzO61WU67hM+2oWTtd0YC5TDEY8VENvswkPbOf0Aec/fAd+HRE7ch4HMCKHpVJDN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ODESv0xv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9Ph7+GkK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751549434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SSL6pMiq0gd7XD60qY6vVVqLLdJ+A7wrnDsGL6j47Ag=;
	b=ODESv0xv2KkvhoebkJrt+kxbavcbijo4v02Bbpd43xN4dzPNPuTnI5OU9I5qTgHZ4eVzQJ
	McjfFINTzCQsLXNnnK8lVx6ayVCMC52lsKeayxNLKyS6Oq2r7gy9z1X0ID1KkQhwsGDEVC
	wbfcc31rhpqhgSYxmjqjtRj4t3TJcch4SuaPXCT92Vh01YIfxPMZph6sykTb/ejfOb60if
	DD3euGXd/sJbE9dVAj0wQixYzsrMKQiD2tn7tdsW7UlsWsygyayq7+hp31iQ72zhqL0JFB
	egZ3ZsKB76do9nqS19vNefglJjJYvmL0+M+Af6lde7Mx1htIq7xxuySsCm956Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751549434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SSL6pMiq0gd7XD60qY6vVVqLLdJ+A7wrnDsGL6j47Ag=;
	b=9Ph7+GkKppOD8TprwEEV/khl6dISXJ5b1iSsTu/TRDBxn48naiaxfOXoEl2nrQKttdUr6f
	j6Pwv2E1VYdzL/DQ==
To: Nam Cao <namcao@linutronix.de>, Marc Zyngier <maz@kernel.org>, Lorenzo
 Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, Rob
 Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Karthikeyan
 Mitran <m.karthikeyan@mobiveil.co.in>, Hou Zhiqiang
 <Zhiqiang.Hou@nxp.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Pali =?utf-8?Q?Roh=C3=A1r?= <pali@kernel.org>, "K . Y . Srinivasan"
 <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Joyce Ooi <joyce.ooi@intel.com>, Jim
 Quinlan <jim2101024@gmail.com>, Nicolas Saenz Julienne
 <nsaenz@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Jianjun Wang <jianjun.wang@mediatek.com>, Marek Vasut
 <marek.vasut+renesas@gmail.com>, Yoshihiro Shimoda
 <yoshihiro.shimoda.uh@renesas.com>, Michal Simek <michal.simek@amd.com>,
 Daire McNamara <daire.mcnamara@microchip.com>, Nirmal Patel
 <nirmal.patel@linux.intel.com>, Jonathan Derrick
 <jonathan.derrick@linux.dev>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-renesas-soc@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: Re: [PATCH 13/16] PCI: plda: Switch to msi_create_parent_irq_domain()
In-Reply-To: <1279fe6500a1d8135d8f5feb2f055df008746c88.1750858083.git.namcao@linutronix.de>
References: <cover.1750858083.git.namcao@linutronix.de>
 <1279fe6500a1d8135d8f5feb2f055df008746c88.1750858083.git.namcao@linutronix.de>
Date: Thu, 03 Jul 2025 15:30:33 +0200
Message-ID: <87cyahv1ty.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Jun 26 2025 at 16:48, Nam Cao wrote:
> Move away from the legacy MSI domain setup, switch to use
> msi_create_parent_irq_domain().
>
> Signed-off-by: Nam Cao <namcao@linutronix.de>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

