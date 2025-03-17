Return-Path: <linux-hyperv+bounces-4552-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58834A657F8
	for <lists+linux-hyperv@lfdr.de>; Mon, 17 Mar 2025 17:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 590867A90A9
	for <lists+linux-hyperv@lfdr.de>; Mon, 17 Mar 2025 16:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3307519DFA7;
	Mon, 17 Mar 2025 16:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="Zb/b0736"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lamorak.hansenpartnership.com (lamorak.hansenpartnership.com [198.37.111.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20B4198E60;
	Mon, 17 Mar 2025 16:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.37.111.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742228794; cv=none; b=vDxiwDLyq+l7Y4+p9w54u6CaMyNHf48m49EnxaZjfRAY3LGB/dVrp6KrOznK2zWuXhIyKipXHSV41lY8vCjxcJD3PCBN/58oM5kXUy7T63kStf9cK8tioE1bmRUESmzhq8rd8S4C0yobvqJf2tOOCcxXw7+3QUs6P7LH7KPp6qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742228794; c=relaxed/simple;
	bh=+Ndjy4xmcEbXyhbj74b5WBRBd0mqSMQV+7NKaMwfF0w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JWe9iYrWD8VWROwab7WlXSnwx+mPR7062J7VVmo4xQp3nA1x6XAXb1cJ2AKjBnNUBoUcD/pnkK23CoM2htZbUjcm1++yIIo+91JstmJox5yXiibyWHMaBgZX/HkCr/j9UgPVOObFCpsKb3RRpFxq4Fg7StM3tbf1Vm8UayAixhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=Zb/b0736; arc=none smtp.client-ip=198.37.111.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1742228790;
	bh=+Ndjy4xmcEbXyhbj74b5WBRBd0mqSMQV+7NKaMwfF0w=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=Zb/b0736daXymZaWap1l3aurwmc/9FF73bbGMNHV9DFCCB5Jch9TlatrPBsTcmAxi
	 C1srhA4D8T6OAx6K3bNyEQlA++AhjiFPFLKi1OZJKi0phx1X/gNmO4BOiMxfIumFxx
	 XVuEkLWLXWf3aNnBbAf800il9shIJMoGK9hmGfis=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lamorak.hansenpartnership.com (Postfix) with ESMTPSA id 0F8421C01F4;
	Mon, 17 Mar 2025 12:26:30 -0400 (EDT)
Message-ID: <609eeb873fdef6171c71f3beda289d799cb7172c.camel@HansenPartnership.com>
Subject: Re: [patch V3 09/10] scsi: ufs: qcom: Remove the MSI descriptor
 abuse
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, "Martin K.
 Petersen" <martin.petersen@oracle.com>,  linux-scsi@vger.kernel.org,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,  Nishanth Menon
 <nm@ti.com>, Dhruva Gole <d-gole@ti.com>, Tero Kristo <kristo@kernel.org>, 
 Santosh Shilimkar <ssantosh@kernel.org>, Logan Gunthorpe
 <logang@deltatee.com>, Dave Jiang <dave.jiang@intel.com>,  Jon Mason
 <jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>, ntb@lists.linux.dev,
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, Michael
 Kelley <mhklinux@outlook.com>, Wei Liu <wei.liu@kernel.org>, Haiyang Zhang
 <haiyangz@microsoft.com>, linux-hyperv@vger.kernel.org, Wei Huang
 <wei.huang2@amd.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Date: Mon, 17 Mar 2025 12:26:29 -0400
In-Reply-To: <20250317092946.265146293@linutronix.de>
References: <20250317092919.008573387@linutronix.de>
	 <20250317092946.265146293@linutronix.de>
Autocrypt: addr=James.Bottomley@HansenPartnership.com;
 prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-03-17 at 14:29 +0100, Thomas Gleixner wrote:
> The driver abuses the MSI descriptors for internal purposes. Aside of
> core code and MSI providers nothing has to care about their
> existence. They have been encapsulated with a lot of effort because
> this kind of abuse caused all sorts of issues including a
> maintainability nightmare.
>=20
> Rewrite the code so it uses dedicated storage to hand the required
> information to the interrupt handler.
>=20
> No functional change intended.
>=20
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
> Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
> Cc: linux-scsi@vger.kernel.org
>=20
>=20
> ---
> =C2=A0drivers/ufs/host/ufs-qcom.c |=C2=A0=C2=A0 77 ++++++++++++++++++++++=
-----------
> -----------
> =C2=A01 file changed, 40 insertions(+), 37 deletions(-)
>=20
> --- a/drivers/ufs/host/ufs-qcom.c
> +++ b/drivers/ufs/host/ufs-qcom.c
> @@ -1782,15 +1782,19 @@ static void ufs_qcom_write_msi_msg(struc
> =C2=A0	ufshcd_mcq_config_esi(hba, msg);
> =C2=A0}
> =C2=A0
> +struct ufs_qcom_irq {
> +	unsigned int		irq;
> +	unsigned int		idx;
> +	struct ufs_hba		*hba;
> +};
> +
> =C2=A0static irqreturn_t ufs_qcom_mcq_esi_handler(int irq, void *data)
> =C2=A0{
> -	struct msi_desc *desc =3D data;
> -	struct device *dev =3D msi_desc_to_dev(desc);
> -	struct ufs_hba *hba =3D dev_get_drvdata(dev);
> -	u32 id =3D desc->msi_index;
> -	struct ufs_hw_queue *hwq =3D &hba->uhq[id];
> +	struct ufs_qcom_irq *qi =3D data;
> +	struct ufs_hba *hba =3D qi->hba;
> +	struct ufs_hw_queue *hwq =3D &hba->uhq[qi->idx];
> =C2=A0
> -	ufshcd_mcq_write_cqis(hba, 0x1, id);
> +	ufshcd_mcq_write_cqis(hba, 0x1, qi->idx);
> =C2=A0	ufshcd_mcq_poll_cqe_lock(hba, hwq);
> =C2=A0
> =C2=A0	return IRQ_HANDLED;
> @@ -1799,8 +1803,7 @@ static irqreturn_t ufs_qcom_mcq_esi_hand
> =C2=A0static int ufs_qcom_config_esi(struct ufs_hba *hba)
> =C2=A0{
> =C2=A0	struct ufs_qcom_host *host =3D ufshcd_get_variant(hba);
> -	struct msi_desc *desc;
> -	struct msi_desc *failed_desc =3D NULL;
> +	struct ufs_qcom_irq *qi;
> =C2=A0	int nr_irqs, ret;
> =C2=A0
> =C2=A0	if (host->esi_enabled)
> @@ -1811,47 +1814,47 @@ static int ufs_qcom_config_esi(struct uf
> =C2=A0	 * 2. Poll queues do not need ESI.
> =C2=A0	 */
> =C2=A0	nr_irqs =3D hba->nr_hw_queues - hba-
> >nr_queues[HCTX_TYPE_POLL];
> +	qi =3D devm_kcalloc(hba->dev, nr_irqs, sizeof(*qi),
> GFP_KERNEL);
> +	if (qi)

Typo causing logic inversion: should be !qi here (you need a more
responsive ! key).

> +		return -ENOMEM;
> +
> =C2=A0	ret =3D platform_device_msi_init_and_alloc_irqs(hba->dev,
> nr_irqs,
> =C2=A0						=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> ufs_qcom_write_msi_msg);
> =C2=A0	if (ret) {
> =C2=A0		dev_err(hba->dev, "Failed to request Platform MSI
> %d\n", ret);
> -		return ret;
> +		goto cleanup;
> =C2=A0	}
> =C2=A0
> -	msi_lock_descs(hba->dev);
> -	msi_for_each_desc(desc, hba->dev, MSI_DESC_ALL) {
> -		ret =3D devm_request_irq(hba->dev, desc->irq,
> -				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ufs_qcom_mcq_esi_handler,
> -				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IRQF_SHARED, "qcom-mcq-esi",
> desc);
> +	for (int idx =3D 0; idx < nr_irqs; idx++) {
> +		qi[idx].irq =3D msi_get_virq(hba->dev, idx);
> +		qi[idx].idx =3D idx;
> +		qi[idx].hba =3D hba;
> +
> +		ret =3D devm_request_irq(hba->dev, qi[idx].irq,
> ufs_qcom_mcq_esi_handler,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IRQF_SHARED, "qcom-mcq-esi",
> qi + idx);
> =C2=A0		if (ret) {
> =C2=A0			dev_err(hba->dev, "%s: Fail to request IRQ
> for %d, err =3D %d\n",
> -				__func__, desc->irq, ret);
> -			failed_desc =3D desc;
> -			break;
> +				__func__, qi[idx].irq, ret);
> +			qi[idx].irq =3D 0;
> +			goto cleanup;
> =C2=A0		}
> =C2=A0	}
> -	msi_unlock_descs(hba->dev);
> =C2=A0
> -	if (ret) {
> -		/* Rewind */
> -		msi_lock_descs(hba->dev);
> -		msi_for_each_desc(desc, hba->dev, MSI_DESC_ALL) {
> -			if (desc =3D=3D failed_desc)
> -				break;
> -			devm_free_irq(hba->dev, desc->irq, hba);
> -		}
> -		msi_unlock_descs(hba->dev);
> -		platform_device_msi_free_irqs_all(hba->dev);
> -	} else {
> -		if (host->hw_ver.major =3D=3D 6 && host->hw_ver.minor =3D=3D
> 0 &&
> -		=C2=A0=C2=A0=C2=A0 host->hw_ver.step =3D=3D 0)
> -			ufshcd_rmwl(hba, ESI_VEC_MASK,
> -				=C2=A0=C2=A0=C2=A0 FIELD_PREP(ESI_VEC_MASK,
> MAX_ESI_VEC - 1),
> -				=C2=A0=C2=A0=C2=A0 REG_UFS_CFG3);
> -		ufshcd_mcq_enable_esi(hba);
> -		host->esi_enabled =3D true;
> +	if (host->hw_ver.major =3D=3D 6 && host->hw_ver.minor =3D=3D 0 &&
> +	=C2=A0=C2=A0=C2=A0 host->hw_ver.step =3D=3D 0) {
> +		ufshcd_rmwl(hba, ESI_VEC_MASK,
> +			=C2=A0=C2=A0=C2=A0 FIELD_PREP(ESI_VEC_MASK, MAX_ESI_VEC -
> 1),
> +			=C2=A0=C2=A0=C2=A0 REG_UFS_CFG3);
> =C2=A0	}
> -
> +	ufshcd_mcq_enable_esi(hba);
> +	host->esi_enabled =3D true;
> +	return 0;
> +
> +cleanup:
> +	for (int idx =3D 0; qi[idx].irq; idx++)
> +		devm_free_irq(hba->dev, qi[idx].irq, hba);
> +	platform_device_msi_free_irqs_all(hba->dev);
> +	devm_kfree(hba->dev, qi);
> =C2=A0	return ret;
> =C2=A0}

This does seem to be exactly the pattern you describe in 1/10, although
I'm not entirely convinced that something like the below is more
readable and safe.

Regards,

James

---

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 23b9f6efa047..26b0c665c3b7 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -1782,25 +1782,37 @@ static void ufs_qcom_write_msi_msg(struct msi_desc =
*desc, struct msi_msg *msg)
 	ufshcd_mcq_config_esi(hba, msg);
 }
=20
+struct ufs_qcom_irq {
+	unsigned int		irq;
+	unsigned int		idx;
+	struct ufs_hba		*hba;
+};
+
 static irqreturn_t ufs_qcom_mcq_esi_handler(int irq, void *data)
 {
-	struct msi_desc *desc =3D data;
-	struct device *dev =3D msi_desc_to_dev(desc);
-	struct ufs_hba *hba =3D dev_get_drvdata(dev);
-	u32 id =3D desc->msi_index;
-	struct ufs_hw_queue *hwq =3D &hba->uhq[id];
+	struct ufs_qcom_irq *qi =3D data;
+	struct ufs_hba *hba =3D qi->hba;
+	struct ufs_hw_queue *hwq =3D &hba->uhq[qi->idx];
=20
-	ufshcd_mcq_write_cqis(hba, 0x1, id);
+	ufshcd_mcq_write_cqis(hba, 0x1, qi->idx);
 	ufshcd_mcq_poll_cqe_lock(hba, hwq);
=20
 	return IRQ_HANDLED;
 }
=20
+DEFINE_FREE(ufs_qcom_irq, struct ufs_qcom_irq *,
+	    if (_T) {							\
+		    for (int idx =3D 0; _T[idx].irq; idx++)		\
+			    devm_free_irq(_T[idx].hba->dev, _T[idx].irq, \
+					  _T[idx].hba);			\
+		    platform_device_msi_free_irqs_all(_T[0].hba->dev);	\
+		    devm_kfree(_T[0].hba->dev, _T);			\
+	    })
+
 static int ufs_qcom_config_esi(struct ufs_hba *hba)
 {
 	struct ufs_qcom_host *host =3D ufshcd_get_variant(hba);
-	struct msi_desc *desc;
-	struct msi_desc *failed_desc =3D NULL;
+	struct ufs_qcom_irq *qi __free(ufs_qcom_irq);
 	int nr_irqs, ret;
=20
 	if (host->esi_enabled)
@@ -1811,6 +1823,11 @@ static int ufs_qcom_config_esi(struct ufs_hba *hba)
 	 * 2. Poll queues do not need ESI.
 	 */
 	nr_irqs =3D hba->nr_hw_queues - hba->nr_queues[HCTX_TYPE_POLL];
+	qi =3D devm_kcalloc(hba->dev, nr_irqs, sizeof(*qi), GFP_KERNEL);
+	if (!qi)
+		return -ENOMEM;
+	qi[0].hba =3D hba;	/* required by __free() */
+
 	ret =3D platform_device_msi_init_and_alloc_irqs(hba->dev, nr_irqs,
 						      ufs_qcom_write_msi_msg);
 	if (ret) {
@@ -1818,41 +1835,31 @@ static int ufs_qcom_config_esi(struct ufs_hba *hba)
 		return ret;
 	}
=20
-	msi_lock_descs(hba->dev);
-	msi_for_each_desc(desc, hba->dev, MSI_DESC_ALL) {
-		ret =3D devm_request_irq(hba->dev, desc->irq,
-				       ufs_qcom_mcq_esi_handler,
-				       IRQF_SHARED, "qcom-mcq-esi", desc);
+	for (int idx =3D 0; idx < nr_irqs; idx++) {
+		qi[idx].irq =3D msi_get_virq(hba->dev, idx);
+		qi[idx].idx =3D idx;
+		qi[idx].hba =3D hba;
+
+		ret =3D devm_request_irq(hba->dev, qi[idx].irq, ufs_qcom_mcq_esi_handler=
,
+				       IRQF_SHARED, "qcom-mcq-esi", qi + idx);
 		if (ret) {
 			dev_err(hba->dev, "%s: Fail to request IRQ for %d, err =3D %d\n",
-				__func__, desc->irq, ret);
-			failed_desc =3D desc;
-			break;
+				__func__, qi[idx].irq, ret);
+			qi[idx].irq =3D 0;
+			return ret;
 		}
 	}
-	msi_unlock_descs(hba->dev);
+	retain_ptr(qi);
=20
-	if (ret) {
-		/* Rewind */
-		msi_lock_descs(hba->dev);
-		msi_for_each_desc(desc, hba->dev, MSI_DESC_ALL) {
-			if (desc =3D=3D failed_desc)
-				break;
-			devm_free_irq(hba->dev, desc->irq, hba);
-		}
-		msi_unlock_descs(hba->dev);
-		platform_device_msi_free_irqs_all(hba->dev);
-	} else {
-		if (host->hw_ver.major =3D=3D 6 && host->hw_ver.minor =3D=3D 0 &&
-		    host->hw_ver.step =3D=3D 0)
-			ufshcd_rmwl(hba, ESI_VEC_MASK,
-				    FIELD_PREP(ESI_VEC_MASK, MAX_ESI_VEC - 1),
-				    REG_UFS_CFG3);
-		ufshcd_mcq_enable_esi(hba);
-		host->esi_enabled =3D true;
+	if (host->hw_ver.major =3D=3D 6 && host->hw_ver.minor =3D=3D 0 &&
+	    host->hw_ver.step =3D=3D 0) {
+		ufshcd_rmwl(hba, ESI_VEC_MASK,
+			    FIELD_PREP(ESI_VEC_MASK, MAX_ESI_VEC - 1),
+			    REG_UFS_CFG3);
 	}
-
-	return ret;
+	ufshcd_mcq_enable_esi(hba);
+	host->esi_enabled =3D true;
+	return 0;
 }
=20
 /*


