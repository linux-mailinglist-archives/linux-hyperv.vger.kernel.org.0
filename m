Return-Path: <linux-hyperv+bounces-541-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 225C27CB9BE
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Oct 2023 06:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70520B20F4C
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Oct 2023 04:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6322BE67;
	Tue, 17 Oct 2023 04:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="SLtR/3Bh"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892DDC122
	for <linux-hyperv@vger.kernel.org>; Tue, 17 Oct 2023 04:32:08 +0000 (UTC)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF629F
	for <linux-hyperv@vger.kernel.org>; Mon, 16 Oct 2023 21:32:04 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2c518a1d83fso34564671fa.3
        for <linux-hyperv@vger.kernel.org>; Mon, 16 Oct 2023 21:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1697517122; x=1698121922; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6Xc6oR6a23SD4JV0rF85aZz1KejrLxXqXEECB4OZTOU=;
        b=SLtR/3BhA5mZVRJPIwDecU/C4mRfZfiBAVjCIAahfuw3XqSOKc0L+wE5Y1AIn23B0t
         KNvumYUJOrkPzXjzFzsKVlWn17gnyRtfXSf9S6pvieD6MX8kbyHArxVniy1Ieg7+TlqW
         t24IZuM32qbrQn0QImAYBb3j83eI9pD9CyQe8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697517122; x=1698121922;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Xc6oR6a23SD4JV0rF85aZz1KejrLxXqXEECB4OZTOU=;
        b=rwv2w1TXujcWy4JOF7knTxvuWZjzTFNNwrqD2L9a6d4PB8crkTndTNqaoLKmI0hG00
         3i6p1S0ELMqToGfNzWBHJ3iEcpq32widf+dvBOAiupNm/vUSBxxOUUPglZED9KgC4yZU
         CicWGv50y4Pf79MdBH0Zc2rqFCcp9QxM2gL0lVNMMJ3C9tZCFtMuATOBeMBc2Z3WHxnw
         gUE/ML3lHa/SjwgZeJ44xBI3Qvt2O58Mrc/1bVE3lud5tKpPHFUKi0qKC6t1YFP/KJFW
         GHIujahJIHZd8WBsB0mOQ2GjxZfPLkJGs1FGW4YarufL9ZlbFRi+EDEOYUGKo1ssF4p1
         w9Rw==
X-Gm-Message-State: AOJu0YwrifKJbv+Q173OhuC7DrJfvuXntrjYQhiRb1pDxsKLQKP7uiyx
	L9Fm4IKTq5HScu+zvcO7Zyk3xUEg9R/2a67PhD9C+w==
X-Google-Smtp-Source: AGHT+IHTD9qpV7Q93Pj8HpsO2CWv553YHO9I1GEWYCcyjA9LY8U0RWmbMlPMBg+hT3AJjaw11mYVqejNdhI14fgCpNM=
X-Received: by 2002:ac2:47f2:0:b0:507:a6b2:3996 with SMTP id
 b18-20020ac247f2000000b00507a6b23996mr712711lfp.56.1697517122203; Mon, 16 Oct
 2023 21:32:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1697494322-26814-1-git-send-email-sharmaajay@linuxonhyperv.com> <1697494322-26814-5-git-send-email-sharmaajay@linuxonhyperv.com>
In-Reply-To: <1697494322-26814-5-git-send-email-sharmaajay@linuxonhyperv.com>
From: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Date: Tue, 17 Oct 2023 10:01:50 +0530
Message-ID: <CAH-L+nPAxQHCCA6pwwHMxys4GGnvmvYZKKNzd8AvMxy-hO0eSw@mail.gmail.com>
Subject: Re: [Patch v7 4/5] RDMA/mana_ib: Query adapter capabilities
To: sharmaajay@linuxonhyperv.com
Cc: Long Li <longli@microsoft.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Leon Romanovsky <leon@kernel.org>, Dexuan Cui <decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-rdma@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Ajay Sharma <sharmaajay@microsoft.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000001afbfe0607e201a9"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

--0000000000001afbfe0607e201a9
Content-Type: multipart/alternative; boundary="000000000000121fe50607e20180"

--000000000000121fe50607e20180
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ajay,

One comment in line.

Regards,
Kalesh

On Tue, Oct 17, 2023 at 3:42=E2=80=AFAM <sharmaajay@linuxonhyperv.com> wrot=
e:

> From: Ajay Sharma <sharmaajay@microsoft.com>
>
> Query the adapter capabilities to expose to
> other clients and VF. This checks against
> the user supplied values and protects against
> overflows.
>
> Signed-off-by: Ajay Sharma <sharmaajay@microsoft.com>
> ---
>  drivers/infiniband/hw/mana/device.c  |  4 ++
>  drivers/infiniband/hw/mana/main.c    | 67 ++++++++++++++++++++++------
>  drivers/infiniband/hw/mana/mana_ib.h | 53 +++++++++++++++++++++-
>  3 files changed, 110 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/infiniband/hw/mana/device.c
> b/drivers/infiniband/hw/mana/device.c
> index 4077e440657a..e15da43c73a0 100644
> --- a/drivers/infiniband/hw/mana/device.c
> +++ b/drivers/infiniband/hw/mana/device.c
> @@ -97,6 +97,10 @@ static int mana_ib_probe(struct auxiliary_device *adev=
,
>                 goto free_error_eq;
>         }
>
> +       ret =3D mana_ib_query_adapter_caps(mib_dev);
> +       if (ret)
> +               ibdev_dbg(&mib_dev->ib_dev, "Failed to get caps, use
> defaults");
>
[Kalesh]: You are ignoring the failure here and continuing with the IB
register. When the FW command fails, you won't populate the
"mib_dev->adapter_caps". Subsequent "mana_ib_query_device" may return stale
values?
Is that what you want?

> +
>         ret =3D ib_register_device(&mib_dev->ib_dev, "mana_%d",
>                                  mdev->gdma_context->dev);
>         if (ret)
> diff --git a/drivers/infiniband/hw/mana/main.c
> b/drivers/infiniband/hw/mana/main.c
> index 5b5d7abe79ac..82923475267d 100644
> --- a/drivers/infiniband/hw/mana/main.c
> +++ b/drivers/infiniband/hw/mana/main.c
> @@ -469,20 +469,15 @@ int mana_ib_get_port_immutable(struct ib_device
> *ibdev, u32 port_num,
>  int mana_ib_query_device(struct ib_device *ibdev, struct ib_device_attr
> *props,
>                          struct ib_udata *uhw)
>  {
> -       props->max_qp =3D MANA_MAX_NUM_QUEUES;
> -       props->max_qp_wr =3D MAX_SEND_BUFFERS_PER_QUEUE;
> +       struct mana_ib_dev *mib_dev =3D container_of(ibdev,
> +                       struct mana_ib_dev, ib_dev);
>
> -       /*
> -        * max_cqe could be potentially much bigger.
> -        * As this version of driver only support RAW QP, set it to the
> same
> -        * value as max_qp_wr
> -        */
> -       props->max_cqe =3D MAX_SEND_BUFFERS_PER_QUEUE;
> -
> -       props->max_mr_size =3D MANA_IB_MAX_MR_SIZE;
> -       props->max_mr =3D MANA_IB_MAX_MR;
> -       props->max_send_sge =3D MAX_TX_WQE_SGL_ENTRIES;
> -       props->max_recv_sge =3D MAX_RX_WQE_SGL_ENTRIES;
> +       props->max_qp =3D mib_dev->adapter_caps.max_qp_count;
> +       props->max_qp_wr =3D mib_dev->adapter_caps.max_requester_sq_size;
> +       props->max_cqe =3D mib_dev->adapter_caps.max_requester_sq_size;
> +       props->max_mr =3D mib_dev->adapter_caps.max_mr_count;
> +       props->max_send_sge =3D mib_dev->adapter_caps.max_send_wqe_size;
> +       props->max_recv_sge =3D mib_dev->adapter_caps.max_recv_wqe_size;
>
>         return 0;
>  }
> @@ -601,3 +596,49 @@ int mana_ib_create_error_eq(struct mana_ib_dev
> *mib_dev)
>
>         return 0;
>  }
> +
> +static void assign_caps(struct mana_ib_adapter_caps *caps,
> +                       struct mana_ib_query_adapter_caps_resp *resp)
> +{
> +       caps->max_sq_id =3D resp->max_sq_id;
> +       caps->max_rq_id =3D resp->max_rq_id;
> +       caps->max_cq_id =3D resp->max_cq_id;
> +       caps->max_qp_count =3D resp->max_qp_count;
> +       caps->max_cq_count =3D resp->max_cq_count;
> +       caps->max_mr_count =3D resp->max_mr_count;
> +       caps->max_pd_count =3D resp->max_pd_count;
> +       caps->max_inbound_read_limit =3D resp->max_inbound_read_limit;
> +       caps->max_outbound_read_limit =3D resp->max_outbound_read_limit;
> +       caps->mw_count =3D resp->mw_count;
> +       caps->max_srq_count =3D resp->max_srq_count;
> +       caps->max_requester_sq_size =3D resp->max_requester_sq_size;
> +       caps->max_responder_sq_size =3D resp->max_responder_sq_size;
> +       caps->max_requester_rq_size =3D resp->max_requester_rq_size;
> +       caps->max_responder_rq_size =3D resp->max_responder_rq_size;
> +       caps->max_send_wqe_size =3D resp->max_send_wqe_size;
> +       caps->max_recv_wqe_size =3D resp->max_recv_wqe_size;
> +       caps->max_inline_data_size =3D resp->max_inline_data_size;
> +}
> +
> +int mana_ib_query_adapter_caps(struct mana_ib_dev *mib_dev)
> +{
> +       struct mana_ib_query_adapter_caps_resp resp =3D {};
> +       struct mana_ib_query_adapter_caps_req req =3D {};
> +       int err;
> +
> +       mana_gd_init_req_hdr(&req.hdr, MANA_IB_GET_ADAPTER_CAP,
> sizeof(req),
> +                            sizeof(resp));
> +       req.hdr.resp.msg_version =3D MANA_IB_GET_ADAPTER_CAP_RESPONSE_V3;
> +       req.hdr.dev_id =3D mib_dev->gc->mana_ib.dev_id;
> +
> +       err =3D mana_gd_send_request(mib_dev->gc, sizeof(req), &req,
> +                                  sizeof(resp), &resp);
> +
> +       if (err) {
> +               ibdev_err(&mib_dev->ib_dev, "Failed to query adapter caps
> err %d", err);
> +               return err;
> +       }
> +
> +       assign_caps(&mib_dev->adapter_caps, &resp);
> +       return 0;
> +}
> diff --git a/drivers/infiniband/hw/mana/mana_ib.h
> b/drivers/infiniband/hw/mana/mana_ib.h
> index 8a652bccd978..6b9406738cb2 100644
> --- a/drivers/infiniband/hw/mana/mana_ib.h
> +++ b/drivers/infiniband/hw/mana/mana_ib.h
> @@ -20,19 +20,41 @@
>
>  /* MANA doesn't have any limit for MR size */
>  #define MANA_IB_MAX_MR_SIZE    U64_MAX
> -
> +#define MANA_IB_GET_ADAPTER_CAP_RESPONSE_V3 3
>  /*
>   * The hardware limit of number of MRs is greater than maximum number of
> MRs
>   * that can possibly represent in 24 bits
>   */
>  #define MANA_IB_MAX_MR         0xFFFFFFu
>
> +struct mana_ib_adapter_caps {
> +       u32 max_sq_id;
> +       u32 max_rq_id;
> +       u32 max_cq_id;
> +       u32 max_qp_count;
> +       u32 max_cq_count;
> +       u32 max_mr_count;
> +       u32 max_pd_count;
> +       u32 max_inbound_read_limit;
> +       u32 max_outbound_read_limit;
> +       u32 mw_count;
> +       u32 max_srq_count;
> +       u32 max_requester_sq_size;
> +       u32 max_responder_sq_size;
> +       u32 max_requester_rq_size;
> +       u32 max_responder_rq_size;
> +       u32 max_send_wqe_size;
> +       u32 max_recv_wqe_size;
> +       u32 max_inline_data_size;
> +};
> +
>  struct mana_ib_dev {
>         struct ib_device ib_dev;
>         struct gdma_dev *gdma_dev;
>         struct gdma_context *gc;
>         struct gdma_queue *fatal_err_eq;
>         mana_handle_t adapter_handle;
> +       struct mana_ib_adapter_caps adapter_caps;
>  };
>
>  struct mana_ib_wq {
> @@ -96,6 +118,7 @@ struct mana_ib_rwq_ind_table {
>  };
>
>  enum mana_ib_command_code {
> +       MANA_IB_GET_ADAPTER_CAP =3D 0x30001,
>         MANA_IB_CREATE_ADAPTER  =3D 0x30002,
>         MANA_IB_DESTROY_ADAPTER =3D 0x30003,
>  };
> @@ -120,6 +143,32 @@ struct mana_ib_destroy_adapter_resp {
>         struct gdma_resp_hdr hdr;
>  }; /* HW Data */
>
> +struct mana_ib_query_adapter_caps_req {
> +       struct gdma_req_hdr hdr;
> +}; /*HW Data */
> +
> +struct mana_ib_query_adapter_caps_resp {
> +       struct gdma_resp_hdr hdr;
> +       u32 max_sq_id;
> +       u32 max_rq_id;
> +       u32 max_cq_id;
> +       u32 max_qp_count;
> +       u32 max_cq_count;
> +       u32 max_mr_count;
> +       u32 max_pd_count;
> +       u32 max_inbound_read_limit;
> +       u32 max_outbound_read_limit;
> +       u32 mw_count;
> +       u32 max_srq_count;
> +       u32 max_requester_sq_size;
> +       u32 max_responder_sq_size;
> +       u32 max_requester_rq_size;
> +       u32 max_responder_rq_size;
> +       u32 max_send_wqe_size;
> +       u32 max_recv_wqe_size;
> +       u32 max_inline_data_size;
> +}; /* HW Data */
> +
>  int mana_ib_gd_create_dma_region(struct mana_ib_dev *mib_dev,
>                                  struct ib_umem *umem,
>                                  mana_handle_t *gdma_region);
> @@ -194,4 +243,6 @@ int mana_ib_create_adapter(struct mana_ib_dev
> *mib_dev);
>
>  int mana_ib_destroy_adapter(struct mana_ib_dev *mib_dev);
>
> +int mana_ib_query_adapter_caps(struct mana_ib_dev *mib_dev);
> +
>  #endif
> --
> 2.25.1
>
>
>

--=20
Regards,
Kalesh A P

--000000000000121fe50607e20180
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Ajay,</div><div><br></div><div>One comment=C2=A0in=
 line.</div><div><br></div><div>Regards,</div><div>Kalesh</div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Oct 17, 20=
23 at 3:42=E2=80=AFAM &lt;<a href=3D"mailto:sharmaajay@linuxonhyperv.com">s=
harmaajay@linuxonhyperv.com</a>&gt; wrote:<br></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">From: Ajay Sharma &lt;<a href=3D"mailto:sharmaaj=
ay@microsoft.com" target=3D"_blank">sharmaajay@microsoft.com</a>&gt;<br>
<br>
Query the adapter capabilities to expose to<br>
other clients and VF. This checks against<br>
the user supplied values and protects against<br>
overflows.<br>
<br>
Signed-off-by: Ajay Sharma &lt;<a href=3D"mailto:sharmaajay@microsoft.com" =
target=3D"_blank">sharmaajay@microsoft.com</a>&gt;<br>
---<br>
=C2=A0drivers/infiniband/hw/mana/device.c=C2=A0 |=C2=A0 4 ++<br>
=C2=A0drivers/infiniband/hw/mana/main.c=C2=A0 =C2=A0 | 67 +++++++++++++++++=
+++++------<br>
=C2=A0drivers/infiniband/hw/mana/mana_ib.h | 53 +++++++++++++++++++++-<br>
=C2=A03 files changed, 110 insertions(+), 14 deletions(-)<br>
<br>
diff --git a/drivers/infiniband/hw/mana/device.c b/drivers/infiniband/hw/ma=
na/device.c<br>
index 4077e440657a..e15da43c73a0 100644<br>
--- a/drivers/infiniband/hw/mana/device.c<br>
+++ b/drivers/infiniband/hw/mana/device.c<br>
@@ -97,6 +97,10 @@ static int mana_ib_probe(struct auxiliary_device *adev,<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto free_error_eq;=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D mana_ib_query_adapter_caps(mib_dev);<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ibdev_dbg(&amp;mib_=
dev-&gt;ib_dev, &quot;Failed to get caps, use defaults&quot;);<br></blockqu=
ote><div>[Kalesh]: You are ignoring the failure here and continuing with th=
e IB register. When the FW command fails, you won&#39;t populate the &quot;=
mib_dev-&gt;adapter_caps&quot;. Subsequent &quot;mana_ib_query_device&quot;=
 may return stale values?</div><div>Is that what you want?</div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D ib_register_device(&amp;mib_dev-&gt;ib_=
dev, &quot;mana_%d&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mdev-&gt;gdma_context-&gt;dev)=
;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret)<br>
diff --git a/drivers/infiniband/hw/mana/main.c b/drivers/infiniband/hw/mana=
/main.c<br>
index 5b5d7abe79ac..82923475267d 100644<br>
--- a/drivers/infiniband/hw/mana/main.c<br>
+++ b/drivers/infiniband/hw/mana/main.c<br>
@@ -469,20 +469,15 @@ int mana_ib_get_port_immutable(struct ib_device *ibde=
v, u32 port_num,<br>
=C2=A0int mana_ib_query_device(struct ib_device *ibdev, struct ib_device_at=
tr *props,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0struct ib_udata *uhw)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0props-&gt;max_qp =3D MANA_MAX_NUM_QUEUES;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0props-&gt;max_qp_wr =3D MAX_SEND_BUFFERS_PER_QU=
EUE;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct mana_ib_dev *mib_dev =3D container_of(ib=
dev,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0struct mana_ib_dev, ib_dev);<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * max_cqe could be potentially much bigger.<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * As this version of driver only support RAW Q=
P, set it to the same<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * value as max_qp_wr<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0props-&gt;max_cqe =3D MAX_SEND_BUFFERS_PER_QUEU=
E;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0props-&gt;max_mr_size =3D MANA_IB_MAX_MR_SIZE;<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0props-&gt;max_mr =3D MANA_IB_MAX_MR;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0props-&gt;max_send_sge =3D MAX_TX_WQE_SGL_ENTRI=
ES;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0props-&gt;max_recv_sge =3D MAX_RX_WQE_SGL_ENTRI=
ES;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0props-&gt;max_qp =3D mib_dev-&gt;adapter_caps.m=
ax_qp_count;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0props-&gt;max_qp_wr =3D mib_dev-&gt;adapter_cap=
s.max_requester_sq_size;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0props-&gt;max_cqe =3D mib_dev-&gt;adapter_caps.=
max_requester_sq_size;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0props-&gt;max_mr =3D mib_dev-&gt;adapter_caps.m=
ax_mr_count;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0props-&gt;max_send_sge =3D mib_dev-&gt;adapter_=
caps.max_send_wqe_size;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0props-&gt;max_recv_sge =3D mib_dev-&gt;adapter_=
caps.max_recv_wqe_size;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
=C2=A0}<br>
@@ -601,3 +596,49 @@ int mana_ib_create_error_eq(struct mana_ib_dev *mib_de=
v)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
=C2=A0}<br>
+<br>
+static void assign_caps(struct mana_ib_adapter_caps *caps,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0struct mana_ib_query_adapter_caps_resp *resp)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0caps-&gt;max_sq_id =3D resp-&gt;max_sq_id;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0caps-&gt;max_rq_id =3D resp-&gt;max_rq_id;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0caps-&gt;max_cq_id =3D resp-&gt;max_cq_id;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0caps-&gt;max_qp_count =3D resp-&gt;max_qp_count=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0caps-&gt;max_cq_count =3D resp-&gt;max_cq_count=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0caps-&gt;max_mr_count =3D resp-&gt;max_mr_count=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0caps-&gt;max_pd_count =3D resp-&gt;max_pd_count=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0caps-&gt;max_inbound_read_limit =3D resp-&gt;ma=
x_inbound_read_limit;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0caps-&gt;max_outbound_read_limit =3D resp-&gt;m=
ax_outbound_read_limit;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0caps-&gt;mw_count =3D resp-&gt;mw_count;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0caps-&gt;max_srq_count =3D resp-&gt;max_srq_cou=
nt;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0caps-&gt;max_requester_sq_size =3D resp-&gt;max=
_requester_sq_size;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0caps-&gt;max_responder_sq_size =3D resp-&gt;max=
_responder_sq_size;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0caps-&gt;max_requester_rq_size =3D resp-&gt;max=
_requester_rq_size;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0caps-&gt;max_responder_rq_size =3D resp-&gt;max=
_responder_rq_size;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0caps-&gt;max_send_wqe_size =3D resp-&gt;max_sen=
d_wqe_size;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0caps-&gt;max_recv_wqe_size =3D resp-&gt;max_rec=
v_wqe_size;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0caps-&gt;max_inline_data_size =3D resp-&gt;max_=
inline_data_size;<br>
+}<br>
+<br>
+int mana_ib_query_adapter_caps(struct mana_ib_dev *mib_dev)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct mana_ib_query_adapter_caps_resp resp =3D=
 {};<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct mana_ib_query_adapter_caps_req req =3D {=
};<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int err;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0mana_gd_init_req_hdr(&amp;req.hdr, MANA_IB_GET_=
ADAPTER_CAP, sizeof(req),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 sizeof(resp));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0req.hdr.resp.msg_version =3D MANA_IB_GET_ADAPTE=
R_CAP_RESPONSE_V3;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0req.hdr.dev_id =3D mib_dev-&gt;gc-&gt;mana_ib.d=
ev_id;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D mana_gd_send_request(mib_dev-&gt;gc, si=
zeof(req), &amp;req,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sizeof(resp), &amp;resp);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (err) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ibdev_err(&amp;mib_=
dev-&gt;ib_dev, &quot;Failed to query adapter caps err %d&quot;, err);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return err;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0assign_caps(&amp;mib_dev-&gt;adapter_caps, &amp=
;resp);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
+}<br>
diff --git a/drivers/infiniband/hw/mana/mana_ib.h b/drivers/infiniband/hw/m=
ana/mana_ib.h<br>
index 8a652bccd978..6b9406738cb2 100644<br>
--- a/drivers/infiniband/hw/mana/mana_ib.h<br>
+++ b/drivers/infiniband/hw/mana/mana_ib.h<br>
@@ -20,19 +20,41 @@<br>
<br>
=C2=A0/* MANA doesn&#39;t have any limit for MR size */<br>
=C2=A0#define MANA_IB_MAX_MR_SIZE=C2=A0 =C2=A0 U64_MAX<br>
-<br>
+#define MANA_IB_GET_ADAPTER_CAP_RESPONSE_V3 3<br>
=C2=A0/*<br>
=C2=A0 * The hardware limit of number of MRs is greater than maximum number=
 of MRs<br>
=C2=A0 * that can possibly represent in 24 bits<br>
=C2=A0 */<br>
=C2=A0#define MANA_IB_MAX_MR=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00xFFFFFFu<br>
<br>
+struct mana_ib_adapter_caps {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 max_sq_id;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 max_rq_id;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 max_cq_id;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 max_qp_count;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 max_cq_count;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 max_mr_count;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 max_pd_count;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 max_inbound_read_limit;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 max_outbound_read_limit;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 mw_count;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 max_srq_count;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 max_requester_sq_size;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 max_responder_sq_size;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 max_requester_rq_size;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 max_responder_rq_size;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 max_send_wqe_size;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 max_recv_wqe_size;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 max_inline_data_size;<br>
+};<br>
+<br>
=C2=A0struct mana_ib_dev {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct ib_device ib_dev;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct gdma_dev *gdma_dev;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct gdma_context *gc;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct gdma_queue *fatal_err_eq;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 mana_handle_t adapter_handle;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct mana_ib_adapter_caps adapter_caps;<br>
=C2=A0};<br>
<br>
=C2=A0struct mana_ib_wq {<br>
@@ -96,6 +118,7 @@ struct mana_ib_rwq_ind_table {<br>
=C2=A0};<br>
<br>
=C2=A0enum mana_ib_command_code {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0MANA_IB_GET_ADAPTER_CAP =3D 0x30001,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 MANA_IB_CREATE_ADAPTER=C2=A0 =3D 0x30002,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 MANA_IB_DESTROY_ADAPTER =3D 0x30003,<br>
=C2=A0};<br>
@@ -120,6 +143,32 @@ struct mana_ib_destroy_adapter_resp {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct gdma_resp_hdr hdr;<br>
=C2=A0}; /* HW Data */<br>
<br>
+struct mana_ib_query_adapter_caps_req {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct gdma_req_hdr hdr;<br>
+}; /*HW Data */<br>
+<br>
+struct mana_ib_query_adapter_caps_resp {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct gdma_resp_hdr hdr;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 max_sq_id;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 max_rq_id;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 max_cq_id;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 max_qp_count;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 max_cq_count;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 max_mr_count;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 max_pd_count;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 max_inbound_read_limit;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 max_outbound_read_limit;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 mw_count;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 max_srq_count;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 max_requester_sq_size;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 max_responder_sq_size;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 max_requester_rq_size;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 max_responder_rq_size;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 max_send_wqe_size;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 max_recv_wqe_size;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 max_inline_data_size;<br>
+}; /* HW Data */<br>
+<br>
=C2=A0int mana_ib_gd_create_dma_region(struct mana_ib_dev *mib_dev,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct ib_umem *umem,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mana_handle_t *gdma_region);<b=
r>
@@ -194,4 +243,6 @@ int mana_ib_create_adapter(struct mana_ib_dev *mib_dev)=
;<br>
<br>
=C2=A0int mana_ib_destroy_adapter(struct mana_ib_dev *mib_dev);<br>
<br>
+int mana_ib_query_adapter_caps(struct mana_ib_dev *mib_dev);<br>
+<br>
=C2=A0#endif<br>
-- <br>
2.25.1<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr">Regards,<div>Kalesh A P</div></div></div></div>

--000000000000121fe50607e20180--

--0000000000001afbfe0607e201a9
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
AQkEMSIEIL0hoibo0625Ri9g3SryrUfqoIYbcNloxQZ3Vc07+Rl1MBgGCSqGSIb3DQEJAzELBgkq
hkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMTAxNzA0MzIwMlowaQYJKoZIhvcNAQkPMVwwWjAL
BglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG
9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAznJSgygKl
nznQWhKblNiZ1cN27E615F9TIzd/5OrV1ePBKqs3F02ZEZ4uWzWeX6vMtnfE3RvbDPDA8FrhyHet
og3Z2pqNs4b1KTxnzVKWxg8OXk/4Z4QCUC7tNrkCrtyjEO9BIsSu8qNs0hd+FnGQg3jfYvGlJcLq
ILR53yboWIlFoUSV58/66XtmBhiVCO/ePejtYhswO9RBGhkUkRPqJ70JAoNy2xG+kmOfdNBMp4FI
qXPui5vlSlqG4E52QqKBiDdiIGIGo2ftWN3I//1RHzis8P1Cn8BVDFSl3n2fccpS8bjb8k/0dgpM
4EbgSmIO5TV7Ask3Upk65iDf65zS
--0000000000001afbfe0607e201a9--

