Return-Path: <linux-hyperv+bounces-3118-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1301198FE15
	for <lists+linux-hyperv@lfdr.de>; Fri,  4 Oct 2024 09:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4988C1F2234A
	for <lists+linux-hyperv@lfdr.de>; Fri,  4 Oct 2024 07:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F4B13A868;
	Fri,  4 Oct 2024 07:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="SIKwsGW+"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7837F7CA
	for <linux-hyperv@vger.kernel.org>; Fri,  4 Oct 2024 07:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728028360; cv=none; b=YJwAOwNNI5kmNKOZ/R3RLAWxTEjRNmFyVWfT3KAQo5aq43D7+U0EJ32goBI5FD2BjavXCycA5Zoses6WqdASr4ADchFiG+9ai+YFW9pcaRS75/sziDh1GWciFs6/ggribbmE5hadvlcnH03vv+6bFgaH41evED7QRJC0PZ0QLgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728028360; c=relaxed/simple;
	bh=LafZow3LLqIEnhaz8WeUveQyrU+M7BNYd+Ivy1IYn9M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EiIgkKpj02aIwKGQXuEsReogBYaVkRgfI+LtM4gBJysDeolyK0lDWbEGkkP7pXAC1S4624wENF1Y7Dm1A1HnqXupSKLaHsjLRbg5PrAMOTVthmAv5iZDYkv36J4ibbZ98aHRfdORFvQpifLGUFkRtxC+em6BcbuJf4Fqktt2Jew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=SIKwsGW+; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-539983beb19so2422231e87.3
        for <linux-hyperv@vger.kernel.org>; Fri, 04 Oct 2024 00:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1728028356; x=1728633156; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=J5LZssjHKaQd6NOX2qEonou5w+g0gYyCfId1tkUfnfg=;
        b=SIKwsGW+UjZqPmILzxl/evoaEgUsOwo2WqOxCBko5Tx/NuwJ9tJxB8qfE19QlmsWl4
         8jwma53TJ30atktegfi4RaAOQJovIMOl9Ba4LM0TiymUFp8FLnJPRs/Uej2xdeFWSY/J
         Y1+w6McjuQmAJRGsyy36ma5WD/47wHyxc2MwY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728028356; x=1728633156;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J5LZssjHKaQd6NOX2qEonou5w+g0gYyCfId1tkUfnfg=;
        b=AjMwUDpWmLFZAKuG+9whpNstsC9i424iWEHFKYfZ+xRXcnlVjj31RREVrqHsTabQFU
         h5+xpIva7LJuc71PIiO9t2rw7p9W1Gt6M9aVfda4aC45wTuLWCuLSiZAP4/Lrshlz+Eg
         H0ksYIgU7rWZ4E9uieqwJ7QVGZI3RNmFVDXljN68WMyckBNMkCxwLN7A49hDvJKF4ap5
         wgifk52zYct3SvNrTKu/C4pDWzABXc+W3sFStz2Hf4nCLgbB92E7LgPgUyTY+8+l429I
         DZJbtxqWztlrKuEYzyLp8GPEXdz9oi22kDjNmPZfBLbMnHg+aWdDdVuGjyNMU9lakvr2
         RshA==
X-Gm-Message-State: AOJu0Ywb/Eardq7hHOtn7mnxtJAZj/E9D0wUIvwGMwQdMQVdaba8ijI1
	YNchszWT328c7KkTyy3nt9a7QLcsvMcqSC/nygyRos80UcQhpGw5lXsSIoizj0GoHXp1Mk7EgvU
	0LzUHo5YqYzNmRgbL8DA2rMDCYGK+MjgpxtCE
X-Google-Smtp-Source: AGHT+IE5EW8JdHbFj/yZ8ij5RAqU81j0+cEKnM8a3idbr7rsH3RgY0kckQq5Pr55syJpTHN/Ui1xLUWC3JjFZ4Kt+0U=
X-Received: by 2002:a05:6512:3d94:b0:52c:e054:4149 with SMTP id
 2adb3069b0e04-539ab86656amr858019e87.15.1728028355766; Fri, 04 Oct 2024
 00:52:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1727754041-26291-1-git-send-email-shradhagupta@linux.microsoft.com>
In-Reply-To: <1727754041-26291-1-git-send-email-shradhagupta@linux.microsoft.com>
From: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Date: Fri, 4 Oct 2024 13:22:22 +0530
Message-ID: <CAH-L+nOnY91mHmwB6ysC5pe2DWtxp-0Kz61SZWE147XLGL0rRw@mail.gmail.com>
Subject: Re: [PATCH net-next] net: mana: Enable debugfs files for MANA device
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Long Li <longli@microsoft.com>, Simon Horman <horms@kernel.org>, 
	Konstantin Taranov <kotaranov@microsoft.com>, 
	Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>, Erick Archer <erick.archer@outlook.com>, 
	Pavan Chebbi <pavan.chebbi@broadcom.com>, Ahmed Zaki <ahmed.zaki@intel.com>, 
	Colin Ian King <colin.i.king@gmail.com>, Shradha Gupta <shradhagupta@microsoft.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000005791780623a1f4a5"

--0000000000005791780623a1f4a5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 9:10=E2=80=AFAM Shradha Gupta
<shradhagupta@linux.microsoft.com> wrote:
>
> Implement debugfs in MANA driver to be able to view RX,TX,EQ queue
> specific attributes and dump their gdma queues.
> These dumps can be used by other userspace utilities to improve
> debuggability and troubleshooting
>
> Following files are added in debugfs:
>
> /sys/kernel/debug/mana/
> |-------------- 1
>     |--------------- EQs
>     |                 |------- eq0
>     |                 |          |---head
>     |                 |          |---tail
>     |                 |          |---eq_dump
>     |                 |------- eq1
>     |                 .
>     |                 .
>     |
>     |--------------- adapter-MTU
>     |--------------- vport0
>                       |------- RX-0
>                       |          |---cq_budget
>                       |          |---cq_dump
>                       |          |---cq_head
>                       |          |---cq_tail
>                       |          |---rq_head
>                       |          |---rq_nbuf
>                       |          |---rq_tail
>                       |          |---rxq_dump
>                       |------- RX-1
>                       .
>                       .
>                       |------- TX-0
>                       |          |---cq_budget
>                       |          |---cq_dump
>                       |          |---cq_head
>                       |          |---cq_tail
>                       |          |---sq_head
>                       |          |---sq_pend_skb_qlen
>                       |          |---sq_tail
>                       |          |---txq_dump
>                       |------- TX-1
>                       .
>                       .
>
> Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
> ---
>  .../net/ethernet/microsoft/mana/gdma_main.c   |  45 +++++++-
>  drivers/net/ethernet/microsoft/mana/mana_en.c | 105 +++++++++++++++++-
>  include/net/mana/gdma.h                       |   6 +-
>  include/net/mana/mana.h                       |   8 ++
>  4 files changed, 161 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/ne=
t/ethernet/microsoft/mana/gdma_main.c
> index ca4ed58f1206..3541bc5e7a48 100644
> --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> @@ -5,9 +5,12 @@
>  #include <linux/pci.h>
>  #include <linux/utsname.h>
>  #include <linux/version.h>
> +#include <linux/debugfs.h>
>
>  #include <net/mana/mana.h>
>
> +struct dentry *mana_debugfs_root;
> +
>  static u32 mana_gd_r32(struct gdma_context *g, u64 offset)
>  {
>         return readl(g->bar0_va + offset);
> @@ -1516,6 +1519,13 @@ static int mana_gd_probe(struct pci_dev *pdev, con=
st struct pci_device_id *ent)
>         gc->bar0_va =3D bar0_va;
>         gc->dev =3D &pdev->dev;
>
> +       if (gc->is_pf) {
> +               gc->mana_pci_debugfs =3D debugfs_create_dir("0", mana_deb=
ugfs_root);
> +       } else {
> +               gc->mana_pci_debugfs =3D debugfs_create_dir(pci_slot_name=
(pdev->slot),
> +                                                         mana_debugfs_ro=
ot);
> +       }
[Kalesh] You can remove the braces here.
> +
>         err =3D mana_gd_setup(pdev);
>         if (err)
>                 goto unmap_bar;
> @@ -1529,6 +1539,13 @@ static int mana_gd_probe(struct pci_dev *pdev, con=
st struct pci_device_id *ent)
>  cleanup_gd:
>         mana_gd_cleanup(pdev);
>  unmap_bar:
> +       /*
> +        * at this point we know that the other debugfs child dir/files
> +        * are either not yet created or are already cleaned up.
> +        * The pci debugfs folder clean-up now, will only be cleaning up
> +        * adapter-MTU file and apc->mana_pci_debugfs folder.
> +        */
> +       debugfs_remove_recursive(gc->mana_pci_debugfs);
>         pci_iounmap(pdev, bar0_va);
>  free_gc:
>         pci_set_drvdata(pdev, NULL);
> @@ -1549,6 +1566,8 @@ static void mana_gd_remove(struct pci_dev *pdev)
>
>         mana_gd_cleanup(pdev);
>
> +       debugfs_remove_recursive(gc->mana_pci_debugfs);
> +
>         pci_iounmap(pdev, gc->bar0_va);
>
>         vfree(gc);
> @@ -1600,6 +1619,8 @@ static void mana_gd_shutdown(struct pci_dev *pdev)
>
>         mana_gd_cleanup(pdev);
>
> +       debugfs_remove_recursive(gc->mana_pci_debugfs);
> +
>         pci_disable_device(pdev);
>  }
>
> @@ -1619,7 +1640,29 @@ static struct pci_driver mana_driver =3D {
>         .shutdown       =3D mana_gd_shutdown,
>  };
>
> -module_pci_driver(mana_driver);
> +static int __init mana_driver_init(void)
> +{
> +       int err;
> +
> +       mana_debugfs_root =3D debugfs_create_dir("mana", NULL);
> +
> +       err =3D pci_register_driver(&mana_driver);
> +
> +       if (err)
> +               debugfs_remove(mana_debugfs_root);
> +
> +       return err;
> +}
> +
> +static void __exit mana_driver_exit(void)
> +{
> +       debugfs_remove(mana_debugfs_root);
> +
> +       pci_unregister_driver(&mana_driver);
> +}
> +
> +module_init(mana_driver_init);
> +module_exit(mana_driver_exit);
>
>  MODULE_DEVICE_TABLE(pci, mana_id_table);
>
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/=
ethernet/microsoft/mana/mana_en.c
> index c47266d1c7c2..255f3189f6fa 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -9,6 +9,7 @@
>  #include <linux/filter.h>
>  #include <linux/mm.h>
>  #include <linux/pci.h>
> +#include <linux/debugfs.h>
>
>  #include <net/checksum.h>
>  #include <net/ip6_checksum.h>
> @@ -30,6 +31,21 @@ static void mana_adev_idx_free(int idx)
>         ida_free(&mana_adev_ida, idx);
>  }
>
> +static ssize_t mana_dbg_q_read(struct file *filp, char __user *buf, size=
_t count,
> +                              loff_t *pos)
> +{
> +       struct gdma_queue *gdma_q =3D filp->private_data;
> +
> +       return simple_read_from_buffer(buf, count, pos, gdma_q->queue_mem=
_ptr,
> +                                      gdma_q->queue_size);
> +}
> +
> +static const struct file_operations mana_dbg_q_fops =3D {
> +       .owner  =3D THIS_MODULE,
> +       .open   =3D simple_open,
> +       .read   =3D mana_dbg_q_read,
> +};
> +
>  /* Microsoft Azure Network Adapter (MANA) functions */
>
>  static int mana_open(struct net_device *ndev)
> @@ -721,6 +737,13 @@ static const struct net_device_ops mana_devops =3D {
>
>  static void mana_cleanup_port_context(struct mana_port_context *apc)
>  {
> +       /*
> +        * at this point all dir/files under the vport directory
> +        * are already cleaned up.
> +        * We are sure the apc->mana_port_debugfs remove will not
> +        * cause any freed memory access issues
> +        */
> +       debugfs_remove(apc->mana_port_debugfs);
>         kfree(apc->rxqs);
>         apc->rxqs =3D NULL;
>  }
> @@ -943,6 +966,8 @@ static int mana_query_device_cfg(struct mana_context =
*ac, u32 proto_major_ver,
>         else
>                 gc->adapter_mtu =3D ETH_FRAME_LEN;
>
> +       debugfs_create_u16("adapter-MTU", 0400, gc->mana_pci_debugfs, &gc=
->adapter_mtu);
> +
>         return 0;
>  }
>
> @@ -1228,6 +1253,8 @@ static void mana_destroy_eq(struct mana_context *ac=
)
>         if (!ac->eqs)
>                 return;
>
> +       debugfs_remove_recursive(ac->mana_eqs_debugfs);
> +
>         for (i =3D 0; i < gc->max_num_queues; i++) {
>                 eq =3D ac->eqs[i].eq;
>                 if (!eq)
> @@ -1240,6 +1267,18 @@ static void mana_destroy_eq(struct mana_context *a=
c)
>         ac->eqs =3D NULL;
>  }
>
> +static void mana_create_eq_debugfs(struct mana_context *ac, int i)
> +{
> +       struct mana_eq eq =3D ac->eqs[i];
> +       char eqnum[32];
> +
> +       sprintf(eqnum, "eq%d", i);
> +       eq.mana_eq_debugfs =3D debugfs_create_dir(eqnum, ac->mana_eqs_deb=
ugfs);
> +       debugfs_create_u32("head", 0400, eq.mana_eq_debugfs, &eq.eq->head=
);
> +       debugfs_create_u32("tail", 0400, eq.mana_eq_debugfs, &eq.eq->tail=
);
> +       debugfs_create_file("eq_dump", 0400, eq.mana_eq_debugfs, eq.eq, &=
mana_dbg_q_fops);
> +}
> +
>  static int mana_create_eq(struct mana_context *ac)
>  {
>         struct gdma_dev *gd =3D ac->gdma_dev;
> @@ -1260,11 +1299,14 @@ static int mana_create_eq(struct mana_context *ac=
)
>         spec.eq.context =3D ac->eqs;
>         spec.eq.log2_throttle_limit =3D LOG2_EQ_THROTTLE;
>
> +       ac->mana_eqs_debugfs =3D debugfs_create_dir("EQs", gc->mana_pci_d=
ebugfs);
> +
>         for (i =3D 0; i < gc->max_num_queues; i++) {
>                 spec.eq.msix_index =3D (i + 1) % gc->num_msix_usable;
>                 err =3D mana_gd_create_mana_eq(gd, &spec, &ac->eqs[i].eq)=
;
>                 if (err)
>                         goto out;
> +               mana_create_eq_debugfs(ac, i);
>         }
>
>         return 0;
> @@ -1871,6 +1913,8 @@ static void mana_destroy_txq(struct mana_port_conte=
xt *apc)
>                 return;
>
>         for (i =3D 0; i < apc->num_queues; i++) {
> +               debugfs_remove_recursive(apc->tx_qp[i].mana_tx_debugfs);
> +
>                 napi =3D &apc->tx_qp[i].tx_cq.napi;
>                 if (apc->tx_qp[i].txq.napi_initialized) {
>                         napi_synchronize(napi);
> @@ -1889,6 +1933,31 @@ static void mana_destroy_txq(struct mana_port_cont=
ext *apc)
>         apc->tx_qp =3D NULL;
>  }
>
> +static void mana_create_txq_debugfs(struct mana_port_context *apc, int i=
dx)
> +{
> +       struct mana_tx_qp *tx_qp =3D &apc->tx_qp[idx];
> +       char qnum[32];
> +
> +       sprintf(qnum, "TX-%d", idx);
> +       tx_qp->mana_tx_debugfs =3D debugfs_create_dir(qnum, apc->mana_por=
t_debugfs);
> +       debugfs_create_u32("sq_head", 0400, tx_qp->mana_tx_debugfs,
> +                          &tx_qp->txq.gdma_sq->head);
> +       debugfs_create_u32("sq_tail", 0400, tx_qp->mana_tx_debugfs,
> +                          &tx_qp->txq.gdma_sq->tail);
> +       debugfs_create_u32("sq_pend_skb_qlen", 0400, tx_qp->mana_tx_debug=
fs,
> +                          &tx_qp->txq.pending_skbs.qlen);
> +       debugfs_create_u32("cq_head", 0400, tx_qp->mana_tx_debugfs,
> +                          &tx_qp->tx_cq.gdma_cq->head);
> +       debugfs_create_u32("cq_tail", 0400, tx_qp->mana_tx_debugfs,
> +                          &tx_qp->tx_cq.gdma_cq->tail);
> +       debugfs_create_u32("cq_budget", 0400, tx_qp->mana_tx_debugfs,
> +                          &tx_qp->tx_cq.budget);
> +       debugfs_create_file("txq_dump", 0400, tx_qp->mana_tx_debugfs,
> +                           tx_qp->txq.gdma_sq, &mana_dbg_q_fops);
> +       debugfs_create_file("cq_dump", 0400, tx_qp->mana_tx_debugfs,
> +                           tx_qp->tx_cq.gdma_cq, &mana_dbg_q_fops);
> +}
> +
>  static int mana_create_txq(struct mana_port_context *apc,
>                            struct net_device *net)
>  {
> @@ -2000,6 +2069,8 @@ static int mana_create_txq(struct mana_port_context=
 *apc,
>
>                 gc->cq_table[cq->gdma_id] =3D cq->gdma_cq;
>
> +               mana_create_txq_debugfs(apc, i);
> +
>                 netif_napi_add_tx(net, &cq->napi, mana_poll);
>                 napi_enable(&cq->napi);
>                 txq->napi_initialized =3D true;
> @@ -2027,6 +2098,8 @@ static void mana_destroy_rxq(struct mana_port_conte=
xt *apc,
>         if (!rxq)
>                 return;
>
> +       debugfs_remove_recursive(rxq->mana_rx_debugfs);
> +
>         napi =3D &rxq->rx_cq.napi;
>
>         if (napi_initialized) {
> @@ -2308,6 +2381,28 @@ static struct mana_rxq *mana_create_rxq(struct man=
a_port_context *apc,
>         return NULL;
>  }
>
> +static void mana_create_rxq_debugfs(struct mana_port_context *apc, int i=
dx)
> +{
> +       char qnum[32];
> +       struct mana_rxq *rxq;
[Kalesh] Maintain RCT order here
> +
> +       rxq =3D apc->rxqs[idx];
> +
> +       sprintf(qnum, "RX-%d", idx);
> +       rxq->mana_rx_debugfs =3D debugfs_create_dir(qnum, apc->mana_port_=
debugfs);
> +       debugfs_create_u32("rq_head", 0400, rxq->mana_rx_debugfs, &rxq->g=
dma_rq->head);
> +       debugfs_create_u32("rq_tail", 0400, rxq->mana_rx_debugfs, &rxq->g=
dma_rq->tail);
> +       debugfs_create_u32("rq_nbuf", 0400, rxq->mana_rx_debugfs, &rxq->n=
um_rx_buf);
> +       debugfs_create_u32("cq_head", 0400, rxq->mana_rx_debugfs,
> +                          &rxq->rx_cq.gdma_cq->head);
> +       debugfs_create_u32("cq_tail", 0400, rxq->mana_rx_debugfs,
> +                          &rxq->rx_cq.gdma_cq->tail);
> +       debugfs_create_u32("cq_budget", 0400, rxq->mana_rx_debugfs, &rxq-=
>rx_cq.budget);
> +       debugfs_create_file("rxq_dump", 0400, rxq->mana_rx_debugfs, rxq->=
gdma_rq, &mana_dbg_q_fops);
> +       debugfs_create_file("cq_dump", 0400, rxq->mana_rx_debugfs, rxq->r=
x_cq.gdma_cq,
> +                           &mana_dbg_q_fops);
> +}
> +
>  static int mana_add_rx_queues(struct mana_port_context *apc,
>                               struct net_device *ndev)
>  {
> @@ -2326,6 +2421,8 @@ static int mana_add_rx_queues(struct mana_port_cont=
ext *apc,
>                 u64_stats_init(&rxq->stats.syncp);
>
>                 apc->rxqs[i] =3D rxq;
> +
> +               mana_create_rxq_debugfs(apc, i);
>         }
>
>         apc->default_rxobj =3D apc->rxqs[0]->rxobj;
> @@ -2518,14 +2615,19 @@ void mana_query_gf_stats(struct mana_port_context=
 *apc)
>  static int mana_init_port(struct net_device *ndev)
>  {
>         struct mana_port_context *apc =3D netdev_priv(ndev);
> +       struct gdma_dev *gd =3D apc->ac->gdma_dev;
> +       struct gdma_context *gc;
>         u32 max_txq, max_rxq, max_queues;
>         int port_idx =3D apc->port_idx;
> +       char vport[32];
[Kalesh] Maintain RCT order while declaring variables
>         int err;
>
>         err =3D mana_init_port_context(apc);
>         if (err)
>                 return err;
>
> +       gc =3D gd->gdma_context;
> +
>         err =3D mana_query_vport_cfg(apc, port_idx, &max_txq, &max_rxq,
>                                    &apc->indir_table_sz);
>         if (err) {
> @@ -2542,7 +2644,8 @@ static int mana_init_port(struct net_device *ndev)
>                 apc->num_queues =3D apc->max_queues;
>
>         eth_hw_addr_set(ndev, apc->mac_addr);
> -
> +       sprintf(vport, "vport%d", port_idx);
> +       apc->mana_port_debugfs =3D debugfs_create_dir(vport, gc->mana_pci=
_debugfs);
>         return 0;
>
>  reset_apc:
> diff --git a/include/net/mana/gdma.h b/include/net/mana/gdma.h
> index de47fa533b15..32afb15e46bc 100644
> --- a/include/net/mana/gdma.h
> +++ b/include/net/mana/gdma.h
> @@ -267,7 +267,8 @@ struct gdma_event {
>  struct gdma_queue;
>
>  struct mana_eq {
> -       struct gdma_queue *eq;
> +       struct gdma_queue       *eq;
> +       struct dentry           *mana_eq_debugfs;
>  };
>
>  typedef void gdma_eq_callback(void *context, struct gdma_queue *q,
> @@ -365,6 +366,7 @@ struct gdma_irq_context {
>
>  struct gdma_context {
>         struct device           *dev;
> +       struct dentry           *mana_pci_debugfs;
>
>         /* Per-vPort max number of queues */
>         unsigned int            max_num_queues;
> @@ -878,5 +880,7 @@ int mana_gd_send_request(struct gdma_context *gc, u32=
 req_len, const void *req,
>                          u32 resp_len, void *resp);
>
>  int mana_gd_destroy_dma_region(struct gdma_context *gc, u64 dma_region_h=
andle);
> +void mana_register_debugfs(void);
> +void mana_unregister_debugfs(void);
>
>  #endif /* _GDMA_H */
> diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
> index f2a5200d8a0f..5ca4941f15ef 100644
> --- a/include/net/mana/mana.h
> +++ b/include/net/mana/mana.h
> @@ -350,6 +350,7 @@ struct mana_rxq {
>         int xdp_rc; /* XDP redirect return code */
>
>         struct page_pool *page_pool;
> +       struct dentry *mana_rx_debugfs;
>
>         /* MUST BE THE LAST MEMBER:
>          * Each receive buffer has an associated mana_recv_buf_oob.
> @@ -363,6 +364,8 @@ struct mana_tx_qp {
>         struct mana_cq tx_cq;
>
>         mana_handle_t tx_object;
> +
> +       struct dentry *mana_tx_debugfs;
>  };
>
>  struct mana_ethtool_stats {
> @@ -407,6 +410,7 @@ struct mana_context {
>         u16 num_ports;
>
>         struct mana_eq *eqs;
> +       struct dentry *mana_eqs_debugfs;
>
>         struct net_device *ports[MAX_PORTS_IN_MANA_DEV];
>  };
> @@ -468,6 +472,9 @@ struct mana_port_context {
>         bool port_st_save; /* Saved port state */
>
>         struct mana_ethtool_stats eth_stats;
> +
> +       /* Debugfs */
> +       struct dentry *mana_port_debugfs;
>  };
>
>  netdev_tx_t mana_start_xmit(struct sk_buff *skb, struct net_device *ndev=
);
> @@ -494,6 +501,7 @@ int mana_pre_alloc_rxbufs(struct mana_port_context *a=
pc, int mtu, int num_queues
>  void mana_pre_dealloc_rxbufs(struct mana_port_context *apc);
>
>  extern const struct ethtool_ops mana_ethtool_ops;
> +extern struct dentry *mana_debugfs_root;
>
>  /* A CQ can be created not associated with any EQ */
>  #define GDMA_CQ_NO_EQ  0xffff
> --
> 2.34.1
>
>


--=20
Regards,
Kalesh A P

--0000000000005791780623a1f4a5
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBWowggRSoAMCAQICDDfBRQmwNSI92mit0zANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAwODI5NTZaFw0yNTA5MTAwODI5NTZaMIGi
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xHzAdBgNVBAMTFkthbGVzaCBBbmFra3VyIFB1cmF5aWwxMjAw
BgkqhkiG9w0BCQEWI2thbGVzaC1hbmFra3VyLnB1cmF5aWxAYnJvYWRjb20uY29tMIIBIjANBgkq
hkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAxnv1Reaeezfr6NEmg3xZlh4cz9m7QCN13+j4z1scrX+b
JfnV8xITT5yvwdQv3R3p7nzD/t29lTRWK3wjodUd2nImo6vBaH3JbDwleIjIWhDXLNZ4u7WIXYwx
aQ8lYCdKXRsHXgGPY0+zSx9ddpqHZJlHwcvas3oKnQN9WgzZtsM7A8SJefWkNvkcOtef6bL8Ew+3
FBfXmtsPL9I2vita8gkYzunj9Nu2IM+MnsP7V/+Coy/yZDtFJHp30hDnYGzuOhJchDF9/eASvE8T
T1xqJODKM9xn5xXB1qezadfdgUs8k8QAYyP/oVBafF9uqDudL6otcBnziyDBQdFCuAQN7wIDAQAB
o4IB5DCCAeAwDgYDVR0PAQH/BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZC
aHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJj
YTIwMjAuY3J0MEEGCCsGAQUFBzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3Iz
cGVyc29uYWxzaWduMmNhMjAyMDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcC
ARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNV
HR8EQjBAMD6gPKA6hjhodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNp
Z24yY2EyMDIwLmNybDAuBgNVHREEJzAlgSNrYWxlc2gtYW5ha2t1ci5wdXJheWlsQGJyb2FkY29t
LmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGP
zzAdBgNVHQ4EFgQUI3+tdStI+ABRGSqksMsiCmO9uDAwDQYJKoZIhvcNAQELBQADggEBAGfe1o9b
4wUud0FMjb/FNdc433meL15npjdYWUeioHdlCGB5UvEaMGu71QysfoDOfUNeyO9YKp0h0fm7clvo
cBqeWe4CPv9TQbmLEtXKdEpj5kFZBGmav69mGTlu1A9KDQW3y0CDzCPG2Fdm4s73PnkwvemRk9E2
u9/kcZ8KWVeS+xq+XZ78kGTKQ6Wii3dMK/EHQhnDfidadoN/n+x2ySC8yyDNvy81BocnblQzvbuB
a30CvRuhokNO6Jzh7ZFtjKVMzYas3oo6HXgA+slRszMu4pc+fRPO41FHjeDM76e6P5OnthhnD+NY
x6xokUN65DN1bn2MkeNs0nQpizDqd0QxggJtMIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYD
VQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25h
bFNpZ24gMiBDQSAyMDIwAgw3wUUJsDUiPdpordMwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcN
AQkEMSIEIOs5DK2lKRbVqUlQBgdVlRR1mZv3c8t7l+nw4hGWWovwMBgGCSqGSIb3DQEJAzELBgkq
hkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MTAwNDA3NTIzNlowaQYJKoZIhvcNAQkPMVwwWjAL
BglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG
9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCj9gxBtHw0
nxSBbDlamndE4jG7oPrGwFl/SdI6DqErm7zULp1aNLOBHSKPZ5TLjFkRyjwduPFVaouQormNM4bM
F0QYaSsWz9frkiXGUPyVeffSzq6vNk0WnpmCw/mgs3+Q2uYA3S4HFFrAyck7+dVBfITX8pXZKca8
tVhch4oEJ2BTkN/hqcxuwu5TreIHkytoqPNgcDR3Z3JKjGc15ayu9mjOueClkG8Yo9yqg73W5ZvM
BkMpaCWLj7ySOGgXQlrQHE93CtxdqPybuFK0wy8Xm44VsRf9X+llBchVXewYpc2D3NojOl3Sorbj
8sZ2gIF9zLhD4qOjrZ2USGtfV3wK
--0000000000005791780623a1f4a5--

