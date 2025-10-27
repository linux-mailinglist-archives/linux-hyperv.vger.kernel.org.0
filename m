Return-Path: <linux-hyperv+bounces-7337-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AEC9C0E3CB
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Oct 2025 15:06:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3130F3B637C
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Oct 2025 13:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE022F6926;
	Mon, 27 Oct 2025 13:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="CUiPU+ZF"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-oo1-f97.google.com (mail-oo1-f97.google.com [209.85.161.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9619231A23
	for <linux-hyperv@vger.kernel.org>; Mon, 27 Oct 2025 13:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761573531; cv=none; b=IqIN0J00sIR1eDdoykK+PBs2XwxJvm8J7iRhv/IloW6UOvmyfzKKvUha4eMJVNcK40NFkfhpKQTfbK05BRf6C0yKqMflehMIszh/LlrvYhisQLxbURPklZ/uMtbmgdwvY4AyHtWNgOF1lZWbt8CTy0SfY/v1eWqqWITHiLCpzw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761573531; c=relaxed/simple;
	bh=IPMvoAK9STcJnpaeRlRs1HGCtQVeLCpPAwTFas0aYto=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mrLMrSA5e6Ecbu41ms6x141yPF8ZAwf+eEvgXf+vKg3qzitxkNIHJVK4cc+S8QtPnNtN1RfEgLK1mUmcNURAA4GcpXf4aBIyq6v1U+NNBKVLNIqwM+D+5DVeyj/fo+XOH2gpSSArZgnf57XyRhgESuPeZGP71Y+mIuZb9A3OXpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=CUiPU+ZF; arc=none smtp.client-ip=209.85.161.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oo1-f97.google.com with SMTP id 006d021491bc7-65366485678so2112158eaf.2
        for <linux-hyperv@vger.kernel.org>; Mon, 27 Oct 2025 06:58:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761573529; x=1762178329;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=K93KGOS1dEl6jjOCxK/TcyE6aqTcYLrmRjKvZalLnFA=;
        b=hI/uhk70Rh2yfl5TtUipKs/sL/cl7VHF1JI9uv/dw46ZtQjOVL1jCkkIyNunzRx7Ws
         KHlsopHKsllKYMf/YsceOJK0QFRRYf9emdIcyWdp+447o/H0BR2ovMFLK1L5iq2Xuldu
         1EdrDMZrWQvsTO27hxhxFJApfSN4dxBJpcNbPSif3CS1NKIAgBuR7ZsjkF44mhVx/UVE
         BAmoKBjdr45ZCjA6Himc4huNmmrufrEx7UkOjGDJfnWzo40wlXlQELqZQNFH9YcznkS+
         uhJVlVZe8GoVYO3oK903oAKnX9Fc0VMT2JKo4tncKA+vTTSVkUOTqXRoid/HR83ePlBw
         QX6Q==
X-Forwarded-Encrypted: i=1; AJvYcCX9nT+jsy8/8bKlPj3VAWaXHCLXG4VDYjDPmvZeKJzxvENkSJDzDj1eg6c1Dq5CRzJmSm1HLsk1Nn1ls1s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwC3o10nkBwZkTv68HRXn8ss9En8ZJqfEpW6npKqRVRzE/nu6GM
	efGxsnaS+oo2uCfxWgt+RNn0cURuEIKGmHXBbVOVwlUcuadEvjGKUsJQ1k9mpsTxxSmNSR6Z8ay
	NqnHcPolq7JKFIgGMHb4VDnqk0Im90v4JXKo+M2s6LcT8GH255TMJ3lde0HQYqcAdg486Su27IX
	l9cu49kQTaSjYRcUwG0iexfdzFhlnVxtgxfaxNd3phrONCL81xyoGdkZq53N4aUSg/ZbtzNSJ5D
	YublPVVAidsd6VhCYY=
X-Gm-Gg: ASbGnctPHpBuXHw8q7jfavvakQN4DehhkXayoT+PdUt/g6ykrXCOIawokCzGyIeB3XT
	SHgvBvN35Al0bccNl/vloo/ILFeNjohYeZOl73TyenusD6+OM8t7fzO7pJfSGWuR16CxfpD22CN
	jFDVPLbUbTDgcPelbdEAHrnAsZq0AYNm4lHSt6F1itisNWhnRUHliPdkofOqoHDa6TE6okj5GVd
	ldq0Lj9phRm6/N/JR3Vp4zcU//E2NqWz6M/13Du6YxxRTY9yQdJA8J2UTcI2g28B7sWyx3ymFHi
	PwLgB3NKOP+NEWtxd8RwuFnVFyMg06VD2ncPj2QtPNMJQrvrqG8++mAuKT4x7EplgATA3nM7p/G
	/2FxhBlUyX2mDArOqxzwQcPseksCgBn+zJXk7mTlvQJAVWTzKYkjY7mqGpHJ67x6THp8SnVFnYG
	S/dnSiMBx7n2jiM8JGx3tAjontT4ZEgdIWNw==
X-Google-Smtp-Source: AGHT+IH7Z2eTblUixa0ng83xs0Ik6WIjbvgIUpOVAi4Uu4CjoRv/netMinSECfaU4QorchvNEnxDZH/BOmoz
X-Received: by 2002:a05:6871:893:b0:358:f706:d399 with SMTP id 586e51a60fabf-3c98d0df9b9mr15737199fac.28.1761573528806;
        Mon, 27 Oct 2025 06:58:48 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-19.dlp.protect.broadcom.com. [144.49.247.19])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-3d1e3553124sm720381fac.15.2025.10.27.06.58.48
        for <linux-hyperv@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Oct 2025 06:58:48 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-33be4db19cfso8968091a91.0
        for <linux-hyperv@vger.kernel.org>; Mon, 27 Oct 2025 06:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1761573527; x=1762178327; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=K93KGOS1dEl6jjOCxK/TcyE6aqTcYLrmRjKvZalLnFA=;
        b=CUiPU+ZF3YEOB4qNRpnsxrSYAEiWA7UAQ2sRLTZrqEB6e4V7SiTHiJygxocOGvnFJQ
         Caq4BrYrzdYzE/6udZbjDzviYZ2NzcqRR/eTRNVbJ3cfDLC8TPZICxyeq4SFdjN5plKK
         /TU1qkehvVszmEjJ5XOssL7JtVmSaUha97Pds=
X-Forwarded-Encrypted: i=1; AJvYcCVKVVm+KxEu8BFSesvkNFvEKQLDXndygpERiPKmf5vE6pOvSnf4wuddvaUXI0hTUadiacb/yGmUQPen/uM=@vger.kernel.org
X-Received: by 2002:a17:90a:e70f:b0:32e:3837:284f with SMTP id 98e67ed59e1d1-33bcf8e312bmr49267054a91.21.1761573526847;
        Mon, 27 Oct 2025 06:58:46 -0700 (PDT)
X-Received: by 2002:a17:90a:e70f:b0:32e:3837:284f with SMTP id
 98e67ed59e1d1-33bcf8e312bmr49266977a91.21.1761573526247; Mon, 27 Oct 2025
 06:58:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027114549.GA12252@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
In-Reply-To: <20251027114549.GA12252@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
Date: Mon, 27 Oct 2025 19:28:33 +0530
X-Gm-Features: AWmQ_bmzEfgpSndeiq-9iS4yCkSn75YGTpoaLIz0hY6H0GvjPdC0KxT6Me-7G1k
Message-ID: <CALs4sv0dPZWOZGC9HCMkFDR6hDGJ=SZSebhm5v6m-MKNOgA1JA@mail.gmail.com>
Subject: Re: [PATCH net-next] net: mana: Implement ndo_tx_timeout and
 serialize queue resets per port.
To: Dipayaan Roy <dipayanroy@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org, 
	decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, longli@microsoft.com, 
	kotaranov@microsoft.com, horms@kernel.org, shradhagupta@linux.microsoft.com, 
	ssengar@linux.microsoft.com, ernis@linux.microsoft.com, 
	shirazsaleem@microsoft.com, linux-hyperv@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, dipayanroy@microsoft.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000005ccc5c0642244c2b"

--0000000000005ccc5c0642244c2b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 5:19=E2=80=AFPM Dipayaan Roy
<dipayanroy@linux.microsoft.com> wrote:
>
> Implement .ndo_tx_timeout for MANA so any stalled TX queue can be detecte=
d
> and a device-controlled port reset for all queues can be scheduled to an
> ordered workqueue. The reset for all queues on stall detection is
> recomended by hardware team.
>
> The change introduces a single ordered workqueue
> ("mana_per_port_queue_reset_wq") with WQ_UNBOUND | WQ_MEM_RECLAIM and
> queues exactly one work_struct per port onto it. This achieves:
>
>   * Global FIFO across all port reset requests (alloc_ordered_workqueue).
>   * Natural per-port de-duplication: the same work_struct cannot be
>     queued twice while pending/running.
>   * Avoids hogging a per-CPU kworker for long, may-sleep reset paths
>     (WQ_UNBOUND).
>   * Guarantees forward progress during memory pressure
>     (WQ_MEM_RECLAIM rescuer).
>
> Signed-off-by: Dipayaan Roy <dipayanroy@linux.microsoft.com>
> ---
>  drivers/net/ethernet/microsoft/mana/mana_en.c | 83 +++++++++++++++++++
>  include/net/mana/gdma.h                       |  6 +-
>  include/net/mana/mana.h                       | 12 +++
>  3 files changed, 100 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/=
ethernet/microsoft/mana/mana_en.c
> index f4fc86f20213..2833f66d8b2b 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -258,6 +258,45 @@ static int mana_get_gso_hs(struct sk_buff *skb)
>         return gso_hs;
>  }
>
> +static void mana_per_port_queue_reset_work_handler(struct work_struct *w=
ork)
> +{
> +       struct mana_queue_reset_work *reset_queue_work =3D
> +                       container_of(work, struct mana_queue_reset_work, =
work);
> +       struct mana_port_context *apc =3D reset_queue_work->apc;
> +       struct net_device *ndev =3D apc->ndev;
> +       struct mana_context *ac =3D apc->ac;
> +       int err;
> +
> +       if (!rtnl_trylock()) {
> +               /* Someone else holds RTNL, requeue and exit. */
> +               queue_work(ac->per_port_queue_reset_wq,
> +                          &apc->queue_reset_work.work);
> +               return;
> +       }
> +
> +       /* Pre-allocate buffers to prevent failure in mana_attach later *=
/
> +       err =3D mana_pre_alloc_rxbufs(apc, ndev->mtu, apc->num_queues);
> +       if (err) {
> +               netdev_err(ndev, "Insufficient memory for reset post tx s=
tall detection\n");
> +               goto out;
> +       }
> +
> +       err =3D mana_detach(ndev, false);
> +       if (err) {
> +               netdev_err(ndev, "mana_detach failed: %d\n", err);
> +               goto dealloc_pre_rxbufs;
> +       }
> +
> +       err =3D mana_attach(ndev);
> +       if (err)
> +               netdev_err(ndev, "mana_attach failed: %d\n", err);
> +
> +dealloc_pre_rxbufs:
> +       mana_pre_dealloc_rxbufs(apc);
> +out:
> +       rtnl_unlock();
> +}
> +
>  netdev_tx_t mana_start_xmit(struct sk_buff *skb, struct net_device *ndev=
)
>  {
>         enum mana_tx_pkt_format pkt_fmt =3D MANA_SHORT_PKT_FMT;
> @@ -762,6 +801,25 @@ static int mana_change_mtu(struct net_device *ndev, =
int new_mtu)
>         return err;
>  }
>
> +static void mana_tx_timeout(struct net_device *netdev, unsigned int txqu=
eue)
> +{
> +       struct mana_port_context *apc =3D netdev_priv(netdev);
> +       struct mana_context *ac =3D apc->ac;
> +       struct gdma_context *gc =3D ac->gdma_dev->gdma_context;
> +
> +       netdev_warn(netdev, "%s(): called on txq: %u\n", __func__, txqueu=
e);
> +
> +       /* Already in service, hence tx queue reset is not required.*/
> +       if (gc->in_service)
> +               return;
> +
> +       /* Note: If there are pending queue reset work for this port(apc)=
,
> +        * subsequent request queued up drom here are ignored. This is be=
cause

%s/drom/from/

> +        * we are using the same work instance per port(apc).
> +        */
> +       queue_work(ac->per_port_queue_reset_wq, &apc->queue_reset_work.wo=
rk);
> +}
> +
>  static int mana_shaper_set(struct net_shaper_binding *binding,
>                            const struct net_shaper *shaper,
>                            struct netlink_ext_ack *extack)
> @@ -844,7 +902,9 @@ static const struct net_device_ops mana_devops =3D {
>         .ndo_bpf                =3D mana_bpf,
>         .ndo_xdp_xmit           =3D mana_xdp_xmit,
>         .ndo_change_mtu         =3D mana_change_mtu,
> +       .ndo_tx_timeout     =3D mana_tx_timeout,
>         .net_shaper_ops         =3D &mana_shaper_ops,
> +
>  };
>
>  static void mana_cleanup_port_context(struct mana_port_context *apc)
> @@ -3218,6 +3278,7 @@ static int mana_probe_port(struct mana_context *ac,=
 int port_idx,
>         ndev->min_mtu =3D ETH_MIN_MTU;
>         ndev->needed_headroom =3D MANA_HEADROOM;
>         ndev->dev_port =3D port_idx;
> +       ndev->watchdog_timeo =3D MANA_TXQ_TIMEOUT;
>         SET_NETDEV_DEV(ndev, gc->dev);
>
>         netif_set_tso_max_size(ndev, GSO_MAX_SIZE);
> @@ -3255,6 +3316,11 @@ static int mana_probe_port(struct mana_context *ac=
, int port_idx,
>
>         debugfs_create_u32("current_speed", 0400, apc->mana_port_debugfs,=
 &apc->speed);
>
> +       /* Initialize the per port queue reset work.*/
> +       apc->queue_reset_work.apc =3D apc;
> +       INIT_WORK(&apc->queue_reset_work.work,
> +                 mana_per_port_queue_reset_work_handler);
> +
>         return 0;
>
>  free_indir:
> @@ -3456,6 +3522,15 @@ int mana_probe(struct gdma_dev *gd, bool resuming)
>         if (ac->num_ports > MAX_PORTS_IN_MANA_DEV)
>                 ac->num_ports =3D MAX_PORTS_IN_MANA_DEV;
>
> +       ac->per_port_queue_reset_wq =3D
> +                       alloc_ordered_workqueue("mana_per_port_queue_rese=
t_wq",
> +                                               WQ_UNBOUND | WQ_MEM_RECLA=
IM);
> +       if (!ac->per_port_queue_reset_wq) {
> +               dev_err(dev, "Failed to allocate per port queue reset wor=
kqueue\n");
> +               err =3D -ENOMEM;
> +               goto out;
> +       }
> +
>         if (!resuming) {
>                 for (i =3D 0; i < ac->num_ports; i++) {
>                         err =3D mana_probe_port(ac, i, &ac->ports[i]);
> @@ -3528,6 +3603,8 @@ void mana_remove(struct gdma_dev *gd, bool suspendi=
ng)
>                  */
>                 rtnl_lock();
>
> +               cancel_work_sync(&apc->queue_reset_work.work);
> +
>                 err =3D mana_detach(ndev, false);
>                 if (err)
>                         netdev_err(ndev, "Failed to detach vPort %d: %d\n=
",
> @@ -3547,6 +3624,12 @@ void mana_remove(struct gdma_dev *gd, bool suspend=
ing)
>                 free_netdev(ndev);
>         }
>
> +       if (ac->per_port_queue_reset_wq) {
> +               drain_workqueue(ac->per_port_queue_reset_wq);
> +               destroy_workqueue(ac->per_port_queue_reset_wq);

destroy will take care of the drain.

> +               ac->per_port_queue_reset_wq =3D NULL;
> +       }
> +
>         mana_destroy_eq(ac);
>  out:
>         mana_gd_deregister_device(gd);
> diff --git a/include/net/mana/gdma.h b/include/net/mana/gdma.h
> index 57df78cfbf82..1f8c536ba3be 100644
> --- a/include/net/mana/gdma.h
> +++ b/include/net/mana/gdma.h
> @@ -591,6 +591,9 @@ enum {
>  /* Driver can self reset on FPGA Reconfig EQE notification */
>  #define GDMA_DRV_CAP_FLAG_1_HANDLE_RECONFIG_EQE BIT(17)
>
> +/* Driver detects stalled send queues and recovers them */
> +#define GDMA_DRV_CAP_FLAG_1_HANDLE_STALL_SQ_RECOVERY BIT(18)
> +
>  #define GDMA_DRV_CAP_FLAGS1 \
>         (GDMA_DRV_CAP_FLAG_1_EQ_SHARING_MULTI_VPORT | \
>          GDMA_DRV_CAP_FLAG_1_NAPI_WKDONE_FIX | \
> @@ -599,7 +602,8 @@ enum {
>          GDMA_DRV_CAP_FLAG_1_DEV_LIST_HOLES_SUP | \
>          GDMA_DRV_CAP_FLAG_1_DYNAMIC_IRQ_ALLOC_SUPPORT | \
>          GDMA_DRV_CAP_FLAG_1_SELF_RESET_ON_EQE | \
> -        GDMA_DRV_CAP_FLAG_1_HANDLE_RECONFIG_EQE)
> +        GDMA_DRV_CAP_FLAG_1_HANDLE_RECONFIG_EQE | \
> +        GDMA_DRV_CAP_FLAG_1_HANDLE_STALL_SQ_RECOVERY)
>
>  #define GDMA_DRV_CAP_FLAGS2 0
>
> diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
> index 0921485565c0..9b8f236f27c9 100644
> --- a/include/net/mana/mana.h
> +++ b/include/net/mana/mana.h
> @@ -67,6 +67,11 @@ enum TRI_STATE {
>
>  #define MANA_RX_FRAG_ALIGNMENT 64
>
> +/* Timeout value for Txq stall detetcion & recovery used by ndo_tx_timeo=
ut.

%s/detetcion/detection/

> + * The value is chosen after considering fpga re-config scenarios.
> + */
> +#define MANA_TXQ_TIMEOUT (15 * HZ)
> +
>  struct mana_stats_rx {
>         u64 packets;
>         u64 bytes;
> @@ -475,13 +480,20 @@ struct mana_context {
>
>         struct mana_eq *eqs;
>         struct dentry *mana_eqs_debugfs;
> +       struct workqueue_struct *per_port_queue_reset_wq;
>
>         struct net_device *ports[MAX_PORTS_IN_MANA_DEV];
>  };
>
> +struct mana_queue_reset_work {
> +       struct work_struct work;              // Work structure
> +       struct mana_port_context *apc;        // Pointer to the port cont=
ext

Block comment style is preferred instead of  //

> +};
> +
>  struct mana_port_context {
>         struct mana_context *ac;
>         struct net_device *ndev;
> +       struct mana_queue_reset_work queue_reset_work;
>
>         u8 mac_addr[ETH_ALEN];
>
> --
> 2.43.0
>
>

--0000000000005ccc5c0642244c2b
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIVWQYJKoZIhvcNAQcCoIIVSjCCFUYCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghLGMIIGqDCCBJCgAwIBAgIQfofDCS7XZu8vIeKo0KeY9DANBgkqhkiG9w0BAQwFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSNjETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMzA0MTkwMzUzNTNaFw0yOTA0MTkwMDAwMDBaMFIxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBS
NiBTTUlNRSBDQSAyMDIzMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAwjAEbSkPcSyn
26Zn9VtoE/xBvzYmNW29bW1pJZ7jrzKwPJm/GakCvy0IIgObMsx9bpFaq30X1kEJZnLUzuE1/hlc
hatYqyORVBeHlv5V0QRSXY4faR0dCkIhXhoGknZ2O0bUJithcN1IsEADNizZ1AJIaWsWbQ4tYEYj
ytEdvfkxz1WtX3SjtecZR+9wLJLt6HNa4sC//QKdjyfr/NhDCzYrdIzAssoXFnp4t+HcMyQTrj0r
pD8KkPj96sy9axzegLbzte7wgTHbWBeJGp0sKg7BAu+G0Rk6teO1yPd75arbCvfY/NaRRQHk6tmG
71gpLdB1ZhP9IcNYyeTKXIgfMh2tVK9DnXGaksYCyi6WisJa1Oa+poUroX2ESXO6o03lVxiA1xyf
G8lUzpUNZonGVrUjhG5+MdY16/6b0uKejZCLbgu6HLPvIyqdTb9XqF4XWWKu+OMDs/rWyQ64v3mv
Sa0te5Q5tchm4m9K0Pe9LlIKBk/gsgfaOHJDp4hYx4wocDr8DeCZe5d5wCFkxoGc1ckM8ZoMgpUc
4pgkQE5ShxYMmKbPvNRPa5YFzbFtcFn5RMr1Mju8gt8J0c+dxYco2hi7dEW391KKxGhv7MJBcc+0
x3FFTnmhU+5t6+CnkKMlrmzyaoeVryRTvOiH4FnTNHtVKUYDsCM0CLDdMNgoxgkCAwEAAaOCAX4w
ggF6MA4GA1UdDwEB/wQEAwIBhjBMBgNVHSUERTBDBggrBgEFBQcDAgYIKwYBBQUHAwQGCisGAQQB
gjcUAgIGCisGAQQBgjcKAwwGCisGAQQBgjcKAwQGCSsGAQQBgjcVBjASBgNVHRMBAf8ECDAGAQH/
AgEAMB0GA1UdDgQWBBQAKTaeXHq6D68tUC3boCOFGLCgkjAfBgNVHSMEGDAWgBSubAWjkxPioufi
1xzWx/B/yGdToDB7BggrBgEFBQcBAQRvMG0wLgYIKwYBBQUHMAGGImh0dHA6Ly9vY3NwMi5nbG9i
YWxzaWduLmNvbS9yb290cjYwOwYIKwYBBQUHMAKGL2h0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5j
b20vY2FjZXJ0L3Jvb3QtcjYuY3J0MDYGA1UdHwQvMC0wK6ApoCeGJWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vcm9vdC1yNi5jcmwwEQYDVR0gBAowCDAGBgRVHSAAMA0GCSqGSIb3DQEBDAUAA4IC
AQCRkUdr1aIDRmkNI5jx5ggapGUThq0KcM2dzpMu314mJne8yKVXwzfKBtqbBjbUNMODnBkhvZcn
bHUStur2/nt1tP3ee8KyNhYxzv4DkI0NbV93JChXipfsan7YjdfEk5vI2Fq+wpbGALyyWBgfy79Y
IgbYWATB158tvEh5UO8kpGpjY95xv+070X3FYuGyeZyIvao26mN872FuxRxYhNLwGHIy38N9ASa1
Q3BTNKSrHrZngadofHglG5W3TMFR11JOEOAUHhUgpbVVvgCYgGA6dSX0y5z7k3rXVyjFOs7KBSXr
dJPKadpl4vqYphH7+P40nzBRcxJHrv5FeXlTrb+drjyXNjZSCmzfkOuCqPspBuJ7vab0/9oeNERg
nz6SLCjLKcDXbMbKcRXgNhFBlzN4OUBqieSBXk80w2Nzx12KvNj758WavxOsXIbX0Zxwo1h3uw75
AI2v8qwFWXNclO8qW2VXoq6kihWpeiuvDmFfSAwRLxwwIjgUuzG9SaQ+pOomuaC7QTKWMI0hL0b4
mEPq9GsPPQq1UmwkcYFJ/Z4I93DZuKcXmKMmuANTS6wxwIEw8Q5MQ6y9fbJxGEOgOgYL4QIqNULb
5CYPnt2LeiIiEnh8Uuh8tawqSjnR0h7Bv5q4mgo3L1Z9QQuexUntWD96t4o0q1jXWLyrpgP7Zcnu
CzCCBYMwggNroAMCAQICDkXmuwODM8OFZUjm/0VRMA0GCSqGSIb3DQEBDAUAMEwxIDAeBgNVBAsT
F0dsb2JhbFNpZ24gUm9vdCBDQSAtIFI2MRMwEQYDVQQKEwpHbG9iYWxTaWduMRMwEQYDVQQDEwpH
bG9iYWxTaWduMB4XDTE0MTIxMDAwMDAwMFoXDTM0MTIxMDAwMDAwMFowTDEgMB4GA1UECxMXR2xv
YmFsU2lnbiBSb290IENBIC0gUjYxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNVBAMTCkdsb2Jh
bFNpZ24wggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQCVB+hzymb57BTKezz3DQjxtEUL
LIK0SMbrWzyug7hBkjMUpG9/6SrMxrCIa8W2idHGsv8UzlEUIexK3RtaxtaH7k06FQbtZGYLkoDK
RN5zlE7zp4l/T3hjCMgSUG1CZi9NuXkoTVIaihqAtxmBDn7EirxkTCEcQ2jXPTyKxbJm1ZCatzEG
xb7ibTIGph75ueuqo7i/voJjUNDwGInf5A959eqiHyrScC5757yTu21T4kh8jBAHOP9msndhfuDq
jDyqtKT285VKEgdt/Yyyic/QoGF3yFh0sNQjOvddOsqi250J3l1ELZDxgc1Xkvp+vFAEYzTfa5MY
vms2sjnkrCQ2t/DvthwTV5O23rL44oW3c6K4NapF8uCdNqFvVIrxclZuLojFUUJEFZTuo8U4lptO
TloLR/MGNkl3MLxxN+Wm7CEIdfzmYRY/d9XZkZeECmzUAk10wBTt/Tn7g/JeFKEEsAvp/u6P4W4L
sgizYWYJarEGOmWWWcDwNf3J2iiNGhGHcIEKqJp1HZ46hgUAntuA1iX53AWeJ1lMdjlb6vmlodiD
D9H/3zAR+YXPM0j1ym1kFCx6WE/TSwhJxZVkGmMOeT31s4zKWK2cQkV5bg6HGVxUsWW2v4yb3BPp
DW+4LtxnbsmLEbWEFIoAGXCDeZGXkdQaJ783HjIH2BRjPChMrwIDAQABo2MwYTAOBgNVHQ8BAf8E
BAMCAQYwDwYDVR0TAQH/BAUwAwEB/zAdBgNVHQ4EFgQUrmwFo5MT4qLn4tcc1sfwf8hnU6AwHwYD
VR0jBBgwFoAUrmwFo5MT4qLn4tcc1sfwf8hnU6AwDQYJKoZIhvcNAQEMBQADggIBAIMl7ejR/ZVS
zZ7ABKCRaeZc0ITe3K2iT+hHeNZlmKlbqDyHfAKK0W63FnPmX8BUmNV0vsHN4hGRrSMYPd3hckSW
tJVewHuOmXgWQxNWV7Oiszu1d9xAcqyj65s1PrEIIaHnxEM3eTK+teecLEy8QymZjjDTrCHg4x36
2AczdlQAIiq5TSAucGja5VP8g1zTnfL/RAxEZvLS471GABptArolXY2hMVHdVEYcTduZlu8aHARc
phXveOB5/l3bPqpMVf2aFalv4ab733Aw6cPuQkbtwpMFifp9Y3s/0HGBfADomK4OeDTDJfuvCp8g
a907E48SjOJBGkh6c6B3ace2XH+CyB7+WBsoK6hsrV5twAXSe7frgP4lN/4Cm2isQl3D7vXM3PBQ
ddI2aZzmewTfbgZptt4KCUhZh+t7FGB6ZKppQ++Rx0zsGN1s71MtjJnhXvJyPs9UyL1n7KQPTEX/
07kwIwdMjxC/hpbZmVq0mVccpMy7FYlTuiwFD+TEnhmxGDTVTJ267fcfrySVBHioA7vugeXaX3yL
SqGQdCWnsz5LyCxWvcfI7zjiXJLwefechLp0LWEBIH5+0fJPB1lfiy1DUutGDJTh9WZHeXfVVFsf
rSQ3y0VaTqBESMjYsJnFFYQJ9tZJScBluOYacW6gqPGC6EU+bNYC1wpngwVayaQQMIIGjzCCBHeg
AwIBAgIMClwVCDIzIfrgd31IMA0GCSqGSIb3DQEBCwUAMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQK
ExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAy
MDIzMB4XDTI1MDYyMDEzNTM1MloXDTI3MDYyMTEzNTM1MlowgdcxCzAJBgNVBAYTAlVTMRMwEQYD
VQQIEwpDYWxpZm9ybmlhMREwDwYDVQQHEwhTYW4gSm9zZTEZMBcGA1UEYRMQTlRSVVMrREUtNjYx
MDExNzEPMA0GA1UEBBMGQ2hlYmJpMQ4wDAYDVQQqEwVQYXZhbjEWMBQGA1UEChMNQlJPQURDT00g
SU5DLjEiMCAGA1UEAwwZcGF2YW4uY2hlYmJpQGJyb2FkY29tLmNvbTEoMCYGCSqGSIb3DQEJARYZ
cGF2YW4uY2hlYmJpQGJyb2FkY29tLmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEB
ANGpTISzTrmZguibdFYqGCCUbwwdtM+YnwrLTw7HCfW+biD/WfxA5JKBJm81QJINtFKEiB/AKz2a
/HTPxpDrr4vzZL0yoc9XefyCbdiwfyFl99oBekp+1ZxXc5bZsVhRPVyEWFtCys66nqu5cU2GPT3a
ySQEHOtIKyGGgzMVvitOzO2suQkoMvu/swsftfgCY/PObdlBZhv0BD97+WwR6CQJh/YEuDDEHYCy
NDeiVtF3/jwT04bHB7lR9n+AiCSLr9wlgBHGdBFIOmT/XMX3K8fuMMGLq9PpGQEMvYa9QTkE9+zc
MddiNNh1xtCTG0+kC7KIttdXTnffisXKsX44B8ECAwEAAaOCAd0wggHZMA4GA1UdDwEB/wQEAwIF
oDAMBgNVHRMBAf8EAjAAMIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0cDovL3Nl
Y3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5BggrBgEF
BQcwAYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUGA1Ud
IAReMFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUFBwIB
FiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzBBBgNVHR8EOjA4MDagNKAy
hjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAyMy5jcmwwJAYDVR0R
BB0wG4EZcGF2YW4uY2hlYmJpQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBQAKTaeXHq6D68tUC3boCOFGLCgkjAdBgNVHQ4EFgQUxJ6fps/yOGneJRYDWUKPuLPk
miYwDQYJKoZIhvcNAQELBQADggIBAI2j2qBMKYV8SLK1ysjOOS54Lpm3geezjBYrWor/BAKGP7kT
QN61VWg3QlZqiX21KLNeBWzJH7r+zWiS8ykHApTnBlTjfNGF8ihZz7GkpBTa3xDW5rT/oLfyVQ5k
Wr2OZ268FfZPyAgHYnrfhmojupPS4c7bT9fQyep3P0sAm6TQxmhLDh/HcsloIn7w1QywGRyesbRw
CFkRbTnhhTS9Tz3pYs5kHbphHY5oF3HNdKgFPrfpF9ei6dL4LlwvQgNlRB6PhdUBL80CJ0UlY2Oz
jIAKPusiSluFH+NvwqsI8VuId34ug+B5VOM2dWXR/jY0as0Va5Fpjpn1G+jG2pzr1FQu2OHR5GAh
6Uw50Yh3H77mYK67fCzQVcHrl0qdOLSZVsz/T3qjRGjAZlIDyFRjewxLNunJl/TGtu1jk1ij7Uzh
PtF4nfZaVnWJowp/gE+Hr21BXA1nj+wBINHA0eufDHd/Y0/MLK+++i3gPTermGBIfadXUj8NGCGe
eIj4fd2b29HwMCvfX78QR4JQM9dkDoD1ZFClV17bxRPtxhwEU8DzzcGlLfKJhj8IxkLoww9hqNul
Md+LwA5kUTLPBBl9irP7Rn3jfftdK1MgrNyomyZUZSI1pisbv0Zn/ru3KD3QZLE17esvHAqCfXAZ
a2vE+o+ZbomB5XkihtQpb/DYrfjAMYICVzCCAlMCAQEwYjBSMQswCQYDVQQGEwJCRTEZMBcGA1UE
ChMQR2xvYmFsU2lnbiBudi1zYTEoMCYGA1UEAxMfR2xvYmFsU2lnbiBHQ0MgUjYgU01JTUUgQ0Eg
MjAyMwIMClwVCDIzIfrgd31IMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCC/78pa
T12PAErEoA2vELe/9hhHsmlztLhMCEnuM0DoDTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNTEwMjcxMzU4NDdaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBnE5rbXWftWIerAFHyoZHrdUiYoM5kpmJ3NI/do31B
zijsUc9T9PU3wu0BP4PlNjM1p+eZsdJycd8b7PeCby+ePvlFunoaxYoemH5IRVf6ywH+vQWncaeh
rEoG0mSgouh5hnE+cCimY1CnFF4Od5Vl11OAd8NVUg0tyo/wMMLMNyaPhEczjFZXHE2yzE0Sc4XQ
hfKUwJBHJjweX1xFJ32BJe0ss7GSQZ4wljYv3dP8lj/WNPUu1kr5g0J1IPdTKCz3io4FjnJkhZyb
pus1sRGq9VCedH9OdUsBv67eXfl3u1zFcuEC0vwgVzryE/0zhzS917wstuCXZYxouqDAAOCW
--0000000000005ccc5c0642244c2b--

