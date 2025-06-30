Return-Path: <linux-hyperv+bounces-6047-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C815EAED9C9
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Jun 2025 12:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D608176641
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Jun 2025 10:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95446258CC1;
	Mon, 30 Jun 2025 10:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="r0sKDAWt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="djj0xRdI"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E51257AFE;
	Mon, 30 Jun 2025 10:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751279187; cv=none; b=XwnbDh4KxNGNIozLsvFQq0idpWfCXJ4N+0MENGP31hPQuU1rT/Qa6n+v4/q+vJ0BXtFDkFPxE6v/hciksxRj6+itfHcoiZMWBu1iSGnWTdhgWITcKaMjA8lEZy5/DVcIan3CmOaeq3/w4x+EbnIPU0dG1ORYmCqp7LZVLSDkB5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751279187; c=relaxed/simple;
	bh=bBQTqj9wATbwai5CvTj+asfYGG1tNQD2MXt4GzwC+20=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YWHkPKYorTscE0jPGhaSU3f74F9FQXrFvbME+8Rk96B30KilmwJMn9c2gfXAs2PIUOIozzPm0Zi9cRep5bXUvisWtFWUNYSZDTsVPeSgbk1tpSxt784So9Z/8uwLfb8USpRqw5JrPdYvVmI6m9fA5ibW4nEwix9M/NTfQAfUY+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=r0sKDAWt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=djj0xRdI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751279184;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8ZXndMKqkKbWXcshV9ZDUQfsiDhGhb4IBpm3R0c8Fz0=;
	b=r0sKDAWtsE//WnhojxxAV5N6XTMPGgUYPFs47iu8OhcxS9opTW3ZuyqC9bQQZuOGU3KnBz
	28PMmXCCkYPBIDC6SugJ3fbHTLVXDowndEeJUyB2AhQE6PODMQMZnrA4n+vPdZdNHPOzxL
	bovNQSypDy5Md3RUsxyOgzM6NgenzqEmwbHTySvrtS9KY5LgfVKGj8faCopcwtwdUygMwJ
	hcN+XZJXWBAJXEksL0+nj+aMCRYq/AmtwHTcXPVEhasU6EN5AMe/fGKmIRpZolgJg7PQq+
	EiSjYXO3rhHTcIikfHVBPZnbM5omQlNaAFY/ccmavuKpnXenUzXpHVYV57fUtg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751279184;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8ZXndMKqkKbWXcshV9ZDUQfsiDhGhb4IBpm3R0c8Fz0=;
	b=djj0xRdIJQaXGL4WHlfd5pVUlPKCfRbCXvKmYzqmotz8pHlDda+OckcIU3oeEB4SUROkPK
	8s3gAZUmAwsyGFDA==
To: "K . Y . Srinivasan" <kys@microsoft.com>,
	Marc Zyngier <maz@kernel.org>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v2 1/2] irqchip/irq-msi-lib: Select CONFIG_GENERIC_MSI_IRQ
Date: Mon, 30 Jun 2025 12:26:14 +0200
Message-Id: <b0c44007f3b7e062228349a2395f8d850050db33.1751277765.git.namcao@linutronix.de>
In-Reply-To: <cover.1751277765.git.namcao@linutronix.de>
References: <cover.1751277765.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

irq-msi-lib directly uses struct msi_domain_info and
MSI_FLAG_ALLOC_SIMPLE_MSI_DESCS (and likely more) which are only available
when CONFIG_GENERIC_MSI_IRQ=3Dy.

However, no dependency is specified. If it happens that
CONFIG_IRQ_MSI_LIB=3Dy while CONFIG_GENERIC_MSI_IRQ=3Dn, the kernel fails to
build.

Specify this dependency and fix the build.

Fixes: 72e257c6f058 ("irqchip: Provide irq-msi-lib")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202506282256.cHlEHrdc-lkp@int=
el.com/
Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 drivers/irqchip/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 0d196e4471426..c3928ef793449 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -74,6 +74,7 @@ config ARM_VIC_NR
=20
 config IRQ_MSI_LIB
 	bool
+	select GENERIC_MSI_IRQ
=20
 config ARMADA_370_XP_IRQ
 	bool
--=20
2.39.5


