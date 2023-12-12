Return-Path: <linux-hyperv+bounces-1317-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B821380E256
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 Dec 2023 03:52:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BA0A2831D3
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 Dec 2023 02:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B3A646B5;
	Tue, 12 Dec 2023 02:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="BUi5cO8a"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from MW2PR02CU002.outbound.protection.outlook.com (mail-westus2azon11023024.outbound.protection.outlook.com [52.101.49.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E29BC;
	Mon, 11 Dec 2023 18:51:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G+BaWTcmtkE+rsBEKMNUUeESplLvOUVhsKZCDXpgHw5mM0i/9JztC7cAVsn7zd+dzca6ArDVHNdKcn7du4u3iTmOzRTK9pd/4TBEfwnkz8lUyAI4H9mBQx7Qjlyn2DCetN5zzmQImOxTofwBeJ3C3C/I9R0xV5eQtB4SGPlPmiJqepprREw/DYtTGM9uId+sXLdlxHavFNE/FRKyWbn4JvTDgktb3+ccBLBei+IveqXxBkehPJr6yAnvhQrIVqRVWKPG9fwZT1K0Xq8tdTddMRzNeAqdnKm04qgb7GlZuwXbUtMj5s8VxxvftLO9QMSXcnsmobXvSjG81Sg0H2x9Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vAESQqfJjCCsMW+egipmd/FsawbANen4roQpbbqUUdQ=;
 b=n/k46yRXcQl9I/x9xVUZaJGsVXPbgLnBlJJNwToW1L9PHpqG5eZQYonotOzr0QqEeGkaxpxcpOimT3DiUwYUOiB4d05GwQd1khlyNqIvojTqyoyLBKwNUlSb9FSI1oh91v2UIeR1pdAw/JNfMj6zroBJuK6JeKtjvfSwG8Os7L1oV5IfhqUiY/bpACIdE/+mtKY+cXorNttXCkvWYhLdmbBm1LI+LzPQ70zxKdVW0sINM+Mgh6/0MSBEA1LMlmQJ0R2I6nYTRO5DGUcTTI/JazL0oCordPCeQ+zYWEoWSaVPytCZ9WWdxImy9UAYJbXArhLN8MHwl/WePaAcPD0b2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vAESQqfJjCCsMW+egipmd/FsawbANen4roQpbbqUUdQ=;
 b=BUi5cO8aGZiGW4YPa3H3PBS6YY556ErlbumWiupgDssApD/IfXBLFrKXHqF4g11cvyh50MbBHwdXQvJjuInzJvENb9uS3jr7qzRISUmX4EJeKbtge52Xk+t+xw1Ej8HnkJipXDSiVREc4VnOcXTV+L+LFwGVbuLKcZVsK8bCwL8=
Received: from PH7PR21MB3263.namprd21.prod.outlook.com (2603:10b6:510:1db::16)
 by SJ0PR21MB1917.namprd21.prod.outlook.com (2603:10b6:a03:292::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.3; Tue, 12 Dec
 2023 02:51:51 +0000
Received: from PH7PR21MB3263.namprd21.prod.outlook.com
 ([fe80::3c1:f565:8d:2954]) by PH7PR21MB3263.namprd21.prod.outlook.com
 ([fe80::3c1:f565:8d:2954%7]) with mapi id 15.20.7113.001; Tue, 12 Dec 2023
 02:51:50 +0000
From: Long Li <longli@microsoft.com>
To: Konstantin Taranov <kotaranov@linux.microsoft.com>, Konstantin Taranov
	<kotaranov@microsoft.com>, KY Srinivasan <kys@microsoft.com>, Haiyang Zhang
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>, "leon@kernel.org" <leon@kernel.org>,
	Dexuan Cui <decui@microsoft.com>, "edumazet@google.com"
	<edumazet@google.com>, "cai.huoqing@linux.dev" <cai.huoqing@linux.dev>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "davem@davemloft.net"
	<davem@davemloft.net>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH] net: mana: add msix index sharing between EQs
Thread-Topic: [PATCH] net: mana: add msix index sharing between EQs
Thread-Index: AQHaKdMCOrqcIf7dokSaSgd+6ugcILCk+ExQ
Date: Tue, 12 Dec 2023 02:51:50 +0000
Message-ID:
 <PH7PR21MB326385C45F555E92BD9170FDCE8EA@PH7PR21MB3263.namprd21.prod.outlook.com>
References: <1702038905-29520-1-git-send-email-kotaranov@linux.microsoft.com>
In-Reply-To: <1702038905-29520-1-git-send-email-kotaranov@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=88f687c9-fa55-4e7f-96be-c953f0270b34;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-12-12T02:50:32Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3263:EE_|SJ0PR21MB1917:EE_
x-ms-office365-filtering-correlation-id: 2ddfd894-7deb-4246-5628-08dbfabd4a3c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 /Gb4pn9FqJ9GiJyJcmBDtJfd1kEFuGeNGWo+4PhbbZvg84sl02SneSMNdsoBbYbzYcFgfOiUsA4xNTIjVosfvJGil3WzRL7AidZ3YOXGsy0gsHQCJbn2t4LbYhSDqkLDezqYv3pNL2S6ysSiOMiXyDwTrd+ULbvjlRz2qup5rR4UQMExczUIOJb2qwEoimGs2kA6viRHp8HIeA/wAPpVVOp8yUmLTYhYhs2HTg6ZVsBMdPIhe7W67p7xC6AJjABc36WjRV/n+pb8cjdq1FHJe5SMmQSWCFN5prDNbMLi6G8RnAO8dLZDTVHw1egtD6Ap2GaT5gYF5p5blMZrqp2nJt3QYIfXM42HBWaBy/vY/m2BXNYGQ8ag/Uxs6bqGEbPaU8zKFfoZkhwBdCFL4FDlct/C4VXplqxA2b3Du8CQ83RGKoMeLMsEoLy5zkdK3oMZpmJHJRn4o1gZ4wsaH9Gdh97TdsYfW04dq+lKg1rVOvQgdUqvhQB3ZGV1bjmMf2P4EZsmc/S96e24N9Cmm5ZrDBUS5H2rpqbFReA7dwotXQX8FSpRQmsW2COjAVlJHj7qcrl/qRdgyM3P5mW82NBPTVZHTWpzImBOwhsZl/AdWqhE6MukteCpfUymsoaARFQ3tZRtpBUP6DcPF4Ta7Ye5KApMXNnFwnnpylF7E7AU+UTabLjBO7AQmDwghgx2Dqqw
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR21MB3263.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(136003)(376002)(39860400002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(83380400001)(33656002)(41300700001)(38100700002)(122000001)(71200400001)(7416002)(82950400001)(10290500003)(2906002)(82960400001)(6506007)(478600001)(9686003)(5660300002)(38070700009)(7696005)(55016003)(26005)(110136005)(4326008)(86362001)(8676002)(8936002)(66556008)(66476007)(8990500004)(52536014)(64756008)(54906003)(76116006)(316002)(66446008)(921008)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?4ts9+Nmkzjsl/dLplFjNYnxNafbL+FPdH47BZ1GgsNCp87vHVeSuCTftcAbw?=
 =?us-ascii?Q?vVflaTINvxG68ZFI2Vr149fXpPFv5goiT4iKDhlCAFH6tsRKPlIaGkbynVmp?=
 =?us-ascii?Q?0L+nV7PRoq2soI+tkYf61SYWTBTIh6XEb9DWQeRpK9Nyy1z7+Lg8dKv039pE?=
 =?us-ascii?Q?KrVojMiVvWNzcjS7pxtyRJFI2XRGZo3sjqkm+Kf0wyAzZXZsEMAFgne5otbT?=
 =?us-ascii?Q?e68aUXPinHtNbvJohRzc2SAZy4Bw0lN+KN8eB3wvmo3OhFixrdcYv8bXsX9n?=
 =?us-ascii?Q?Sk7PyRj6z0tvy1OMPprX8VbYAoypQ/MVHXa9Ch1uhuAYmjsXyNRwJEtBAwfz?=
 =?us-ascii?Q?29fMqDK5U2SXCcykZ73FXjEv1qLv9/+Rt8gUodKhjGf3VRHg9rqytMi12YMs?=
 =?us-ascii?Q?zUXlz6RB78vav+bNYx/1nIGgVC+kRw2wPHM6kCnOgILyfkLZtc+g+Y+UNsgP?=
 =?us-ascii?Q?nOzCJGcFVjK+RPM9+4qBUNMCouYO5HXobdSXfYswVD3JVb16MBhneHaP/RJB?=
 =?us-ascii?Q?0kNtpT5RILZxa0KNLNphF9JlrXbIxDgKdIR0dcGtr0n9RdgIVA8Xqf9VEMTS?=
 =?us-ascii?Q?ptl4h8JmfMkMo8oruMHLQ5Nxo1rn5M17Iw1JlHPHQ8vkiMqbUReRiu2MtUnx?=
 =?us-ascii?Q?3Nhkzwdo+J7bVVcU2Rne2MXqkUFR5CitZvGSqcqpmYxKuc54iV1g75/W/frH?=
 =?us-ascii?Q?VNond9+ZqrJZILTcuA4r2CMZfBWg+N1pvYPKdKIVonuwUpFVPEYFRHpbMYyy?=
 =?us-ascii?Q?CGYw3iZDQvX/El/VTMnTAuTiGRpZvLVnRw+34+qqEiMkqjRzXioaRXGuKetP?=
 =?us-ascii?Q?Ea5dV5pX2URMWZCMrvGpO/y0LGd8+RTVgKgjQVFUXhnK62v0SxL1dZXw+ofm?=
 =?us-ascii?Q?8jy26y2ihbFUEDFziiUGM8LscerCG1QRh+HXi0jzL92lv9TBv3hqsINwmheC?=
 =?us-ascii?Q?AqASsbXANbOYIt02m05hKqP4FVSTSJ/nOPw332cwy0XmnGM7aaLGPWt37nD0?=
 =?us-ascii?Q?oKRBT2Heda0n5lNP1eLo/jGA7QjL345YNs47yXuFSZf9Q4n9mEQxOsNM8Z2G?=
 =?us-ascii?Q?t80zn674mvoEdenrJDkpo5w8Qv4mB0x3PfoiZg8os7kGPS7Je8nkEolJcp46?=
 =?us-ascii?Q?0oJuKk1bTgvgu330Wl8L05KdNVtqDfYdZyVcPmtcRv9rs9xZ5jkx5xWcpRaI?=
 =?us-ascii?Q?cdSg1j2c0UVoLp7891Oxn53tAxHnvYjDwsf1jGPdCmtyTp3yOs1jwztJgixt?=
 =?us-ascii?Q?9xYCldJK1JWeNBugxCYJfyXgji/EohqlFjLVtNBcIXmQagXjxi4XNDDZce0S?=
 =?us-ascii?Q?kOY1wnqyBpM4ptkHYulKC69yRIaRlgnPlZWnvnyMG8r1oEwoI9qmh8Q4sK2J?=
 =?us-ascii?Q?iP4foVtETmPk4AojcT3guyKMgGWTfxhgUQb9UDB+V78GwsP/DP6j7C9yhYzk?=
 =?us-ascii?Q?x0FjMmDTeA1jq2H8bS/O5vcro2cPubkeu9rg4k2ZsF5u6mgNqhFBwIDRvB4N?=
 =?us-ascii?Q?5s4iWbSOI/38Iaa/A6ZSLOM4NeohjfT+F6b0vit4ZvTFsEqW/xIkKxsJxFhn?=
 =?us-ascii?Q?+vcjhAgEBmKcuUbITxJE0c7iixDfZ0b8QitO0k6h?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR21MB3263.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ddfd894-7deb-4246-5628-08dbfabd4a3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2023 02:51:50.4174
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V3bfxmYpWM6gRCJyX8MPIAEjHUx6SUwUnushPPQD6TkrQd6ZH2AaNuVpTe7Yif3uJUZUx8GEUFw+QXTg5oogvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR21MB1917

> @@ -502,12 +512,19 @@ static void mana_gd_deregiser_irq(struct gdma_queue
> *queue)
>  	if (WARN_ON(msix_index >=3D gc->num_msix_usable))
>  		return;
>=20
> -	gic =3D &gc->irq_contexts[msix_index];
> -	gic->handler =3D NULL;
> -	gic->arg =3D NULL;
> -
>  	spin_lock_irqsave(&r->lock, flags);
> -	bitmap_clear(r->map, msix_index, 1);
> +	gic =3D &gc->irq_contexts[msix_index];
> +	list_for_each_entry_rcu(eq, &gic->eq_list, entry) {
> +		if (queue =3D=3D eq) {
> +			list_del_rcu(&eq->entry);
> +			synchronize_rcu();

The usage of RCU is questionable in an atomic context. This code needs to b=
e tested with multiple EQs.

Long

> +			break;
> +		}
> +	}
> +	if (list_empty(&gic->eq_list)) {
> +		gic->handler =3D NULL;
> +		bitmap_clear(r->map, msix_index, 1);
> +	}
>  	spin_unlock_irqrestore(&r->lock, flags);
>=20
>  	queue->eq.msix_index =3D INVALID_PCI_MSIX_INDEX; @@ -587,7 +604,8
> @@ static int mana_gd_create_eq(struct gdma_dev *gd,
>  	u32 log2_num_entries;
>  	int err;
>=20
> -	queue->eq.msix_index =3D INVALID_PCI_MSIX_INDEX;
> +	queue->eq.msix_index =3D spec->eq.msix_index;
> +	queue->id =3D INVALID_QUEUE_ID;
>=20
>  	log2_num_entries =3D ilog2(queue->queue_size / GDMA_EQE_SIZE);
>=20
> @@ -819,6 +837,7 @@ free_q:
>  	kfree(queue);
>  	return err;
>  }
> +EXPORT_SYMBOL_NS(mana_gd_create_mana_eq, NET_MANA);
>=20
>  int mana_gd_create_mana_wq_cq(struct gdma_dev *gd,
>  			      const struct gdma_queue_spec *spec, @@ -895,6
> +914,7 @@ void mana_gd_destroy_queue(struct gdma_context *gc, struct
> gdma_queue *queue)
>  	mana_gd_free_memory(gmi);
>  	kfree(queue);
>  }
> +EXPORT_SYMBOL_NS(mana_gd_destroy_queue, NET_MANA);
>=20
>  int mana_gd_verify_vf_version(struct pci_dev *pdev)  { @@ -1217,9 +1237,=
14
> @@ int mana_gd_poll_cq(struct gdma_queue *cq, struct gdma_comp *comp, int
> num_cqe)  static irqreturn_t mana_gd_intr(int irq, void *arg)  {
>  	struct gdma_irq_context *gic =3D arg;
> +	struct list_head *eq_list =3D &gic->eq_list;
> +	struct gdma_queue *eq;
>=20
> -	if (gic->handler)
> -		gic->handler(gic->arg);
> +	if (gic->handler) {
> +		list_for_each_entry_rcu(eq, eq_list, entry) {
> +			gic->handler(eq);
> +		}
> +	}
>=20
>  	return IRQ_HANDLED;
>  }
> @@ -1272,7 +1297,7 @@ static int mana_gd_setup_irqs(struct pci_dev *pdev)
>  	for (i =3D 0; i < nvec; i++) {
>  		gic =3D &gc->irq_contexts[i];
>  		gic->handler =3D NULL;
> -		gic->arg =3D NULL;
> +		INIT_LIST_HEAD(&gic->eq_list);
>=20
>  		if (!i)
>  			snprintf(gic->name, MANA_IRQ_NAME_SZ,
> "mana_hwc@pci:%s", diff --git
> a/drivers/net/ethernet/microsoft/mana/hw_channel.c
> b/drivers/net/ethernet/microsoft/mana/hw_channel.c
> index 9d1cd3b..0a5fc39 100644
> --- a/drivers/net/ethernet/microsoft/mana/hw_channel.c
> +++ b/drivers/net/ethernet/microsoft/mana/hw_channel.c
> @@ -300,6 +300,7 @@ static int mana_hwc_create_gdma_eq(struct
> hw_channel_context *hwc,
>  	spec.eq.context =3D ctx;
>  	spec.eq.callback =3D cb;
>  	spec.eq.log2_throttle_limit =3D
> DEFAULT_LOG2_THROTTLING_FOR_ERROR_EQ;
> +	spec.eq.msix_index =3D INVALID_PCI_MSIX_INDEX;
>=20
>  	return mana_gd_create_hwc_queue(hwc->gdma_dev, &spec, queue);  }
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c
> b/drivers/net/ethernet/microsoft/mana/mana_en.c
> index fc3d290..8718c04 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -1242,6 +1242,7 @@ static int mana_create_eq(struct mana_context *ac)
>  	spec.eq.callback =3D NULL;
>  	spec.eq.context =3D ac->eqs;
>  	spec.eq.log2_throttle_limit =3D LOG2_EQ_THROTTLE;
> +	spec.eq.msix_index =3D INVALID_PCI_MSIX_INDEX;
>=20
>  	for (i =3D 0; i < gc->max_num_queues; i++) {
>  		err =3D mana_gd_create_mana_eq(gd, &spec, &ac->eqs[i].eq); diff
> --git a/include/net/mana/gdma.h b/include/net/mana/gdma.h index
> 88b6ef7..8d6569d 100644
> --- a/include/net/mana/gdma.h
> +++ b/include/net/mana/gdma.h
> @@ -293,6 +293,7 @@ struct gdma_queue {
>=20
>  	u32 head;
>  	u32 tail;
> +	struct list_head entry;
>=20
>  	/* Extra fields specific to EQ/CQ. */
>  	union {
> @@ -328,6 +329,7 @@ struct gdma_queue_spec {
>  			void *context;
>=20
>  			unsigned long log2_throttle_limit;
> +			unsigned int msix_index;
>  		} eq;
>=20
>  		struct {
> @@ -344,7 +346,7 @@ struct gdma_queue_spec {
>=20
>  struct gdma_irq_context {
>  	void (*handler)(void *arg);
> -	void *arg;
> +	struct list_head eq_list;
>  	char name[MANA_IRQ_NAME_SZ];
>  };
>=20
> --
> 2.43.0


