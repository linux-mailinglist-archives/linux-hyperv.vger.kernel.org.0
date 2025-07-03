Return-Path: <linux-hyperv+bounces-6085-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F5A8AF75C6
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Jul 2025 15:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19C21486BEB
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Jul 2025 13:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E3328E59C;
	Thu,  3 Jul 2025 13:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="l1udAsok";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fDwiMDAz"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F992222B4;
	Thu,  3 Jul 2025 13:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751549674; cv=none; b=fvWOhKi3YSjNUE6D3sN9wCNDPxMEAPUdRmOWOe01D28PfteoUK9x7s5rryRIUxQGb/Ep97zN154uH6Q9OSYmzj6nKTB59YgpWZThTkQIY8icNjLggPs+sew3MdRe/ZzEEn8sgG1zJTnEPnsJxIZn7uik3wKYMPZk/PFwjFscXos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751549674; c=relaxed/simple;
	bh=ZIvwyQ4PUprtYpegCqSfNywCoxWQF3PgP8EXeWA7/BU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=c/RjJXrsSfGP4Odn2QxSK4skDfvDjvJ9wKEXYNZ3dy/nQLlgG/k6Q0jnmRZpnYNJTNTe7DO3aq2Z3FFv52dy2xKKXQpqQq3IndC7n0R7DdPMs9bIL+dlvosG2WUp0fMJBFK6dU8ai/aT5DSj4mVGQmRqjVZvkc/Qkc64Zl3uqRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=l1udAsok; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fDwiMDAz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751549670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZIvwyQ4PUprtYpegCqSfNywCoxWQF3PgP8EXeWA7/BU=;
	b=l1udAsokKLScIuqBvN8DegegnRK49KLBCAG9FW+f93GZWXVy22m/JUJMzpZKqr3DX8VSMB
	STSlh1a1KXjoDTb+Gx1SU6tNCMOhZPj+CArBPGQ45EBtN1Vt4DE7KCBq8jLXu79sPKoHeu
	Fs91uIpUIN/PhcKQLGE/106p33KF/mxN2IlOOaGqbyrfMm3ISdeci1aP4IAwvjrRfobVHj
	OXlDRtA2bDkYBIEnF0MLvV8G/TetnH/ZtFPRYj+3wNc4eDpFSKpJ6RPNplc64rQjKxaRgK
	7XcDpYbDUt3yd6IF8rltbiBovk9J9B/r53Kox/ges44ZuFRAFqBEEQwVPBXVNw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751549670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZIvwyQ4PUprtYpegCqSfNywCoxWQF3PgP8EXeWA7/BU=;
	b=fDwiMDAz/Q7eYBgrZ0taV3R9DNy4wR+6pGV4OJlldbXkJ3xPfiJNKJfVVOX2tncCUv3R4k
	h+whtou+At064iDw==
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
Subject: Re: [PATCH 15/16] PCI: vmd: Convert to lock guards
In-Reply-To: <836cca37449c70922a2bea1fb13f37940a7a7132.1750858083.git.namcao@linutronix.de>
References: <cover.1750858083.git.namcao@linutronix.de>
 <836cca37449c70922a2bea1fb13f37940a7a7132.1750858083.git.namcao@linutronix.de>
Date: Thu, 03 Jul 2025 15:34:29 +0200
Message-ID: <877c0pv1ne.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Jun 26 2025 at 16:48, Nam Cao wrote:
> Convert lock/unlock pairs to lock guard and tidy up the code.
>
> Signed-off-by: Nam Cao <namcao@linutronix.de>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

