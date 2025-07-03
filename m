Return-Path: <linux-hyperv+bounces-6072-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B8AAF7555
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Jul 2025 15:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28543542BC7
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Jul 2025 13:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F7413B284;
	Thu,  3 Jul 2025 13:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UlXkEiBJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v0dKw/UR"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E40C4B5AE;
	Thu,  3 Jul 2025 13:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751548851; cv=none; b=RNrg9vYhBsc2RFP5zxMLnhHLOSoRcTL/ssCQJCYlxNG3xLSKtqUH82aFR8ax2jk4YjFa7oYvOok2AQfMMk3pHe5DGyV9iRhqmbdrcuci7Sn0aweNhF6wcNiwXI8ltEnVqFIHCQxoxmrXzWbDHky2yejlVQ0IQTtSV+Br2GSN3qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751548851; c=relaxed/simple;
	bh=4kcJobrOnoamaBnANOlfQkU1M63AHPCa2YelSe1E0P8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=E7dnwD7iojqPTngtw+ceKzIuUW4tWRSt+dcA8XYvMQh35eBrwhriFjozyvMue7cbDNqYuSiFnzQy+TO/2MoGEcj7HC8X2U1Y5dwU5CVkcZx2AkEMqvz7d0MCsAbuNIdmLkpeueLC5lN5uL7tRjk4K/nHsr009aJ3XZ6mAeFzG3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UlXkEiBJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=v0dKw/UR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751548848;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4kcJobrOnoamaBnANOlfQkU1M63AHPCa2YelSe1E0P8=;
	b=UlXkEiBJqNjhllfVDtG8y0edGQKLlyFxzH8xETVXZypLGZ61vM7l3ytQ7jjpGyqlBMkc6i
	sRkL7/vbLMpCMzWWO2T2br1a5FMflMQg/BN/A9zdfZSdIDmXAVliyjnY07zqD1L+4eNHPE
	1Fh/fZAJDgZEMuago2VahCS8FK+DCAZOALdMV1jCDDkXWCN2/h6Xugwbw9GxKMH+pICAQb
	fM07VdDSbpKwpNMbf8cEsXWnxBl1M8+VHv/JdM+mk8YUiNaZEsYEog/ac15Y9ep5EC7BUb
	VHml9lM+fsUHFHGZcoAtZocFaWorwb9zF+fWmrV9hEBX7EiqY7k/fp0ZUrqCEA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751548848;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4kcJobrOnoamaBnANOlfQkU1M63AHPCa2YelSe1E0P8=;
	b=v0dKw/URDPmkRr2m+EPCNDnlXRj7aiiyTtvfQdE8gcbEU6P0s/b6zLnLGgPaAqXK2L1siW
	gqMDlKhAg0bztrAA==
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
Subject: Re: [PATCH 02/16] PCI: mobiveil: Switch to
 msi_create_parent_irq_domain()
In-Reply-To: <af46c15c47a7716f7e0c50d0f7391509c95b49c2.1750858083.git.namcao@linutronix.de>
References: <cover.1750858083.git.namcao@linutronix.de>
 <af46c15c47a7716f7e0c50d0f7391509c95b49c2.1750858083.git.namcao@linutronix.de>
Date: Thu, 03 Jul 2025 15:20:47 +0200
Message-ID: <878ql5wguo.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Jun 26 2025 at 16:47, Nam Cao wrote:

> Move away from the legacy MSI domain setup, switch to use
> msi_create_parent_irq_domain().
>
> Signed-off-by: Nam Cao <namcao@linutronix.de>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

