Return-Path: <linux-hyperv+bounces-6021-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79436AEA195
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Jun 2025 16:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BE6A3BE18B
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Jun 2025 14:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E267C2F19AB;
	Thu, 26 Jun 2025 14:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="44vNn8MC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QRkvml8x"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7052F0E4F;
	Thu, 26 Jun 2025 14:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750949337; cv=none; b=enB2xHwH2EgGC+vwyVik1geAPuaKOf1egRA6G+zZ6nhGVFG1QbKWNyy8Pw/cHvvG84Zh/Yf4hSk/KFo6jF+AxCuxFWBshEnApIdTiMTeBxBKQbipnb8rtDVhg3kmvIjhC5f1Vx6N4DxnQ4YVkVBVNIXVn5WZINiSCK+gF0xwjic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750949337; c=relaxed/simple;
	bh=9EMcwJP/x+JNbDurb6rZj+uU0jwtH3zVDPHoIjNT+j0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hlrwbddKXpOZvrebrmyVdI/pAh5c0Wyc/4bIAVlvkfTQkKJXIRh/ZKnuJ4LEFzQHgc3oDGoHJGGVIZ8YLlu5ZMDS0yny5QqbFHRTHng4zT2iJ2IpSW0fqnNVgjsXmmEJ0tDWXVvPrk+wKxqqEBKbA7VGq6XnmQ4jUPRjTZzqQb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=44vNn8MC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QRkvml8x; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750949333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eCmrCueJeRS5ibC5xxnWfa61fpspJ03Yh0ZfFkdp9c0=;
	b=44vNn8MCNJ+FutWdudMlsBA3G+UbTWImF6VbC1fmDTNCH89l8n929pLAeGCfhevSgCiOHx
	qR2Pzu/Hikfx9eoKGSdYF0YWtfY4LMn9Uy8csZr3F7QW/skk4Avn7l08CGBx9uo+Kv/c3I
	42Hhj7HOTK6i1fohMP/3yxYHWJVOjVUbfe1W2DOFIschnImeameeNA2JMRhH72D3MztZXV
	mj1BL+IC1TkfGw0vM3YmbWlI3eIRnUOjwn33AVCdzN3SkIPkYbuRNwMqHteLui6zmjsJX7
	Ie6yFUUX7Rp0ZMbMr1wTGrlEugc3TlfybTR8mi17OVQGle5MY8PbjC/E1NScaQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750949333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eCmrCueJeRS5ibC5xxnWfa61fpspJ03Yh0ZfFkdp9c0=;
	b=QRkvml8xuqeE/T0T/GtW59FNC+nurgJExh7WDPwC30vEPHH2tnY37E23Gw86l4Xa+UrrDi
	grm02T3W7v93ESDQ==
To: Marc Zyngier <maz@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>,
	Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	=?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	"K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Joyce Ooi <joyce.ooi@intel.com>,
	Jim Quinlan <jim2101024@gmail.com>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Michal Simek <michal.simek@amd.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-hyperv@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH 15/16] PCI: vmd: Convert to lock guards
Date: Thu, 26 Jun 2025 16:48:05 +0200
Message-Id: <836cca37449c70922a2bea1fb13f37940a7a7132.1750858083.git.namcao@linutronix.de>
In-Reply-To: <cover.1750858083.git.namcao@linutronix.de>
References: <cover.1750858083.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Convert lock/unlock pairs to lock guard and tidy up the code.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
Cc: Nirmal Patel <nirmal.patel@linux.intel.com>
Cc: Jonathan Derrick <jonathan.derrick@linux.dev>
---
 drivers/pci/controller/vmd.c | 73 ++++++++++++++----------------------
 1 file changed, 29 insertions(+), 44 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 375ce9d6d9f6a..d9b893bf4e456 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -180,13 +180,12 @@ static void vmd_compose_msi_msg(struct irq_data *data=
, struct msi_msg *msg)
 static void vmd_irq_enable(struct irq_data *data)
 {
 	struct vmd_irq *vmdirq =3D data->chip_data;
-	unsigned long flags;
=20
-	raw_spin_lock_irqsave(&list_lock, flags);
-	WARN_ON(vmdirq->enabled);
-	list_add_tail_rcu(&vmdirq->node, &vmdirq->irq->irq_list);
-	vmdirq->enabled =3D true;
-	raw_spin_unlock_irqrestore(&list_lock, flags);
+	scoped_guard(raw_spinlock_irqsave, &list_lock) {
+		WARN_ON(vmdirq->enabled);
+		list_add_tail_rcu(&vmdirq->node, &vmdirq->irq->irq_list);
+		vmdirq->enabled =3D true;
+	}
=20
 	data->chip->irq_unmask(data);
 }
@@ -194,16 +193,15 @@ static void vmd_irq_enable(struct irq_data *data)
 static void vmd_irq_disable(struct irq_data *data)
 {
 	struct vmd_irq *vmdirq =3D data->chip_data;
-	unsigned long flags;
=20
 	data->chip->irq_mask(data);
=20
-	raw_spin_lock_irqsave(&list_lock, flags);
-	if (vmdirq->enabled) {
-		list_del_rcu(&vmdirq->node);
-		vmdirq->enabled =3D false;
+	scoped_guard(raw_spinlock_irqsave, &list_lock) {
+		if (vmdirq->enabled) {
+			list_del_rcu(&vmdirq->node);
+			vmdirq->enabled =3D false;
+		}
 	}
-	raw_spin_unlock_irqrestore(&list_lock, flags);
 }
=20
 static struct irq_chip vmd_msi_controller =3D {
@@ -225,7 +223,6 @@ static irq_hw_number_t vmd_get_hwirq(struct msi_domain_=
info *info,
  */
 static struct vmd_irq_list *vmd_next_irq(struct vmd_dev *vmd, struct msi_d=
esc *desc)
 {
-	unsigned long flags;
 	int i, best;
=20
 	if (vmd->msix_count =3D=3D 1 + vmd->first_vec)
@@ -242,13 +239,13 @@ static struct vmd_irq_list *vmd_next_irq(struct vmd_d=
ev *vmd, struct msi_desc *d
 		return &vmd->irqs[vmd->first_vec];
 	}
=20
-	raw_spin_lock_irqsave(&list_lock, flags);
-	best =3D vmd->first_vec + 1;
-	for (i =3D best; i < vmd->msix_count; i++)
-		if (vmd->irqs[i].count < vmd->irqs[best].count)
-			best =3D i;
-	vmd->irqs[best].count++;
-	raw_spin_unlock_irqrestore(&list_lock, flags);
+	scoped_guard(raw_spinlock_irq, &list_lock) {
+		best =3D vmd->first_vec + 1;
+		for (i =3D best; i < vmd->msix_count; i++)
+			if (vmd->irqs[i].count < vmd->irqs[best].count)
+				best =3D i;
+		vmd->irqs[best].count++;
+	}
=20
 	return &vmd->irqs[best];
 }
@@ -277,14 +274,12 @@ static void vmd_msi_free(struct irq_domain *domain,
 			struct msi_domain_info *info, unsigned int virq)
 {
 	struct vmd_irq *vmdirq =3D irq_get_chip_data(virq);
-	unsigned long flags;
=20
 	synchronize_srcu(&vmdirq->irq->srcu);
=20
 	/* XXX: Potential optimization to rebalance */
-	raw_spin_lock_irqsave(&list_lock, flags);
-	vmdirq->irq->count--;
-	raw_spin_unlock_irqrestore(&list_lock, flags);
+	scoped_guard(raw_spinlock_irq, &list_lock)
+		vmdirq->irq->count--;
=20
 	kfree(vmdirq);
 }
@@ -387,29 +382,24 @@ static int vmd_pci_read(struct pci_bus *bus, unsigned=
 int devfn, int reg,
 {
 	struct vmd_dev *vmd =3D vmd_from_bus(bus);
 	void __iomem *addr =3D vmd_cfg_addr(vmd, bus, devfn, reg, len);
-	unsigned long flags;
-	int ret =3D 0;
=20
 	if (!addr)
 		return -EFAULT;
=20
-	raw_spin_lock_irqsave(&vmd->cfg_lock, flags);
+	guard(raw_spinlock_irqsave)(&vmd->cfg_lock);
 	switch (len) {
 	case 1:
 		*value =3D readb(addr);
-		break;
+		return 0;
 	case 2:
 		*value =3D readw(addr);
-		break;
+		return 0;
 	case 4:
 		*value =3D readl(addr);
-		break;
+		return 0;
 	default:
-		ret =3D -EINVAL;
-		break;
+		return -EINVAL;
 	}
-	raw_spin_unlock_irqrestore(&vmd->cfg_lock, flags);
-	return ret;
 }
=20
 /*
@@ -422,32 +412,27 @@ static int vmd_pci_write(struct pci_bus *bus, unsigne=
d int devfn, int reg,
 {
 	struct vmd_dev *vmd =3D vmd_from_bus(bus);
 	void __iomem *addr =3D vmd_cfg_addr(vmd, bus, devfn, reg, len);
-	unsigned long flags;
-	int ret =3D 0;
=20
 	if (!addr)
 		return -EFAULT;
=20
-	raw_spin_lock_irqsave(&vmd->cfg_lock, flags);
+	guard(raw_spinlock_irqsave)(&vmd->cfg_lock);
 	switch (len) {
 	case 1:
 		writeb(value, addr);
 		readb(addr);
-		break;
+		return 0;
 	case 2:
 		writew(value, addr);
 		readw(addr);
-		break;
+		return 0;
 	case 4:
 		writel(value, addr);
 		readl(addr);
-		break;
+		return 0;
 	default:
-		ret =3D -EINVAL;
-		break;
+		return -EINVAL;
 	}
-	raw_spin_unlock_irqrestore(&vmd->cfg_lock, flags);
-	return ret;
 }
=20
 static struct pci_ops vmd_ops =3D {
--=20
2.39.5


