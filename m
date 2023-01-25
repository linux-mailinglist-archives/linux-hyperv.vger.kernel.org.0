Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08C8067B818
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Jan 2023 18:11:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235195AbjAYRLv (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 25 Jan 2023 12:11:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235263AbjAYRLi (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 25 Jan 2023 12:11:38 -0500
X-Greylist: delayed 395 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 25 Jan 2023 09:11:01 PST
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8A105AB6A
        for <linux-hyperv@vger.kernel.org>; Wed, 25 Jan 2023 09:11:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1674666260; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Ozy43R5N4iHgaTJJCtnErFSh+5tKBrEwdju/s0SA8W0qTJs4T8304kFHfma3qVPrga
    g3lsB4I5P2+46UfoqGK2STnMqzyntqWZVe8QBJtq9OAxWQ1GhwC4+2uhnB7zB+Lci6Q2
    s50JRpxwkpevidOk6TcC4unNazaTbxef2GAyD0CCiaFXcNCIPc6ZiQqx5fKS7VEaaj0F
    mjoUk7T25WfHKUISG/FjJOCO9t5PT5j5kfvesCnHjn9SBgHyQzXyvqc8wzOsXVicnREV
    0z3ZKYAiTsgDFKdURcWQRZKRnL/QI392jemRf5s3OiG+acLvCLueYlFJXptq4Tz1ZZuU
    MDEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1674666260;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Subject:Cc:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=W+SqnGs9QjmIZ9DXCX93i+A0oA65I5Caxl3ahi9O3u0=;
    b=QgrjCUsvB48gJOEOgHy5fLQ5MJeswizTOM1zZVMPgPBDwQF0K0a1k/VcObHFUgeaor
    77NNneYvQcNDMBBMaQr9XuAVvPI7pwMJTTYnu4Dn3wJo4M2YpcYZjP4YQ3GC+pRdQN4P
    dMG4XXtNw0nOKZ1P+2MbtFyWGfj6iohwmQVmpQjJrcIF4e0viWATfa70XSQ9anfBMcEw
    4HZ7/W6GJcQ0StRcGdvYNfqwYJCOw6qChdA5Xbn140/+W8B3x6xZ8VJuaICKi604g54+
    4d3rSTeImqqd01pBuXtd9HbRzt/paSqKPZ5h8Zm+LaozqcSGsVSfVq6Gh2HUmoj4TyFJ
    Ur+A==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1674666260;
    s=strato-dkim-0002; d=aepfle.de;
    h=Message-ID:Subject:Cc:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=W+SqnGs9QjmIZ9DXCX93i+A0oA65I5Caxl3ahi9O3u0=;
    b=ninPPoKNj6kZcUCr5uN64VDF9fHhUH6tTGVw2LlH9z2FJ0T+KbFShEr+DiL8TLL1bA
    idLLvhOQDA+8afXr+KQmQ9hIpip0hGvpQggo8gmGNFyMOOgskiL/EliL5GtOEWfNs3qo
    RqH91Lk7wJcGo6vjJolk2RVPMeR57fI9MuyeMccjO5/jt33zSejzRnbhQDWfPxjHN7cB
    F5MLFEPAj2AGM4Tt0dFuYHnks7wcfq2rZgUiAS8SlmwWU50F6cYAltVi5taOxkNUseGN
    rbGIs5G/HFPD8yN7kA3eR8Qpmytk6DSD4f6e8xc7KSDseDTnjGquhlSCC499qmEYRNoP
    Bsvg==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QLpd5ylWvMDX3y/OuD5rXVisR4U0KIPE/saK9bfzyVdurcrIu9Z6SKY+a6gtBCfg=="
Received: from sender
    by smtp.strato.de (RZmta 49.2.2 AUTH)
    with ESMTPSA id m23e47z0PH4K8E3
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 25 Jan 2023 18:04:20 +0100 (CET)
Date:   Wed, 25 Jan 2023 18:04:11 +0100
From:   Olaf Hering <olaf@aepfle.de>
To:     linux-hyperv@vger.kernel.org,
        Haiyang Zhang <haiyangz@microsoft.com>
Cc:     linux-pci@vger.kernel.org, Dexuan Cui <decui@microsoft.com>
Subject: unlocked access to struct irq_data->chip_data in pci_hyperv
Message-ID: <20230125180411.4742f159.olaf@aepfle.de>
X-Mailer: Claws Mail 20220819T065813.516423bc hat ein Softwareproblem, kann man nichts machen.
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/OC_Wmt2rWUMlPreEezo4f_B";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

--Sig_/OC_Wmt2rWUMlPreEezo4f_B
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hello,

there are several crash reports due to struct irq_data->chip_data being NUL=
L.

I was under the impression all the "recent changes" to pci-hyperv.c
would fix them. But apparently this specific issue is still there.

What does serialize read and write access to struct irq_data->chip_data?
It seems hv_msi_free can run while other code paths still access at least
->chip_data.

The change below may reduce the window, but I'm not confident this would
actually resolve the concurrency issues.


Olaf

--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -1760,8 +1760,9 @@ static void hv_compose_msi_msg(struct irq_data *data,=
 struct msi_msg *msg)
 		    msi_desc->nvec_used > 1;
=20
 	/* Reuse the previous allocation */
-	if (data->chip_data && multi_msi) {
-		int_desc =3D data->chip_data;
+	virt_rmb();
+	int_desc =3D READ_ONCE(data->chip_data);
+	if (int_desc && multi_msi) {
 		msg->address_hi =3D int_desc->address >> 32;
 		msg->address_lo =3D int_desc->address & 0xffffffff;
 		msg->data =3D int_desc->data;
@@ -1778,8 +1779,9 @@ static void hv_compose_msi_msg(struct irq_data *data,=
 struct msi_msg *msg)
 		goto return_null_message;
=20
 	/* Free any previous message that might have already been composed. */
-	if (data->chip_data && !multi_msi) {
-		int_desc =3D data->chip_data;
+	virt_rmb();
+	int_desc =3D READ_ONCE(data->chip_data);
+	if (int_desc && !multi_msi) {
 		data->chip_data =3D NULL;
 		hv_int_desc_free(hpdev, int_desc);
 	}

--Sig_/OC_Wmt2rWUMlPreEezo4f_B
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE97o7Um30LT3B+5b/86SN7mm1DoAFAmPRYQsACgkQ86SN7mm1
DoBJCQ/+NlH8vXC/YpxQ3IrQF9M1MNNdceL7s+qTwSfGu99p486VXeJ8deCehKY/
QfvUaw3WaJ9a4JEIvxiNQ4rRiQ5QHH6Prv8LgK6ebBrV2WI5ZnOz40jrJL4Wt026
sQZGQtsMfn7ZK4XCx/lM7eTfXmAjBhoPcSewDY+DATfIzPxsxiG3iI3GGGVy1S0/
IVOnEZpM0a2bdhx4L3V47AaqQIQBerC4w7tu6Zij7tYsRree4KM4OthbDijwpDCp
rdkKFO/aj9FB1AUdYrVg2nH5G9xoeDH1oOipgb9JX/33TFxkOgo9WMvfKpq/Rwg2
gr1tuzVXnRBSYhnkuGUv012ZJBWqRot00xjBjURMkZyoAW4tAN8uCyz2b3s6Rb6Z
4oNIETzyIoBPZFPD9h5HSvD8CClArqzxL+2gcYD5mQWRRhGwhb8ZXRdY20Um2EIi
xRoSBP06J5AdpGa0mNs7nB22rM1fFWGjIndcD/zIRWQe1Uw32DYFpYPgA1m+CC6Y
tzEmJtKPGfz10MWG8InE2rNENVEslQiNi9Or8v0+WVeK+9c27GHnvQ8xYLrY6RVR
7Gs9j+xJGuXirw4PphIpAO2zz5lGS04PdMUOD5mKtqCKlB9t4f6bhqehfMvRdnUF
YDMBcTC+e2V1qpTJRpqYV9cRTeSkW11WOjjaEwSl6/PYrtpSsjg=
=zgqN
-----END PGP SIGNATURE-----

--Sig_/OC_Wmt2rWUMlPreEezo4f_B--
